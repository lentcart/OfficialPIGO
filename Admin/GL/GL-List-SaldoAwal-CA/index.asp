<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
    set CAID = GL_M_ChartAccount_cmd.execute

    set SaldoAwal_cmd = server.createObject("ADODB.COMMAND")
	SaldoAwal_cmd.activeConnection = MM_PIGO_String
    SaldoAwal_cmd.commandText = "SELECT GL_M_SaldoAwal.SA_Tahun, GL_M_SaldoAwal.SA_Debet, GL_M_SaldoAwal.SA_Kredit, GL_M_SaldoAwal.SA_UpdateID, Header.CA_UpID, GL_M_ChartAccount.CA_Name, GL_M_ChartAccount.CA_Type FROM GL_M_SaldoAwal LEFT OUTER JOIN GL_M_ChartAccount RIGHT OUTER JOIN GL_M_ChartAccount AS Header ON GL_M_ChartAccount.CA_ID = Header.CA_UpID ON GL_M_SaldoAwal.SA_CA_ID = Header.CA_ID "
    set Header = SaldoAwal_cmd.execute
%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
        function getAccountID(){
                $.ajax({
                    type:"get",
                    url: "get-AccountID.asp?CAID="+document.getElementById("SA_CA_ID").value,
                    success: function (url) {
                    $('.cont-AccountID').html(url);
                                        
                    }
                });
            }
            function AddSaldoAwal(){

                let cek = document.getElementById("AddSaldoAwal");
                
                if (!cek.checked){
                    document.getElementById("new-SaldoAwal").style.display = "none";
                    document.getElementById("list-SaldoAwal").style.display = "block";
                    $("#text-AddSaldoAwal").text("TAMBAH SALDO");
                    
                }else{
                    document.getElementById("new-SaldoAwal").style.display = "block";
                    document.getElementById("list-SaldoAwal").style.display = "none";
                    $("#text-AddSaldoAwal").text("BATAL");
                }
            }
    </script>
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row align-items-center">
                    <div class="col-lg-9 col-md-9 col-sm-12">
                        <span class="cont-judul"> SALDO AWAL KODE PERKIRAAN </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <div class="form-check">
                            <input onchange="AddSaldoAwal()" class="form-check-input" type="checkbox" value="" id="AddSaldoAwal">
                            <label class=" cont-text form-check-label" for="AddSaldoAwal" id="text-AddSaldoAwal">
                                TAMBAH SALDO
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2" id="new-SaldoAwal" style="display:none">
                <form class="" action="add-SaldoAwal.asp" method="POST">
                    <div class="row">
                        <div class="col-2">
                            <span class="cont-text"> Tahun  </span><br>
                            <input readonly class="cont-form" type="text" name="SA_Tahun" id="SA_Tahun" value="<%=YEAR(NOW())%>">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <span class="cont-text"> Kode Perkiraan  </span><br>
                            <select onchange="getAccountID()" class=" mb-2 cont-form" name="SA_CA_ID" id="SA_CA_ID" aria-label="Default select example" required>
                            <% do while not CAID.eof %>
                                <option value="<%=CAID("CA_ID")%>"><%=CAID("CA_ID")%>&nbsp;-&nbsp;<%=CAID("CA_Name")%></option>
                            <% CAID.movenext
                            loop %>
                            </select>
                        </div>
                        <div class="col-4 cont-AccountID">
                            <span class="cont-text"> Keterangan </span><br>
                            <input Required class="cont-form" type="text" name="SA_CA_Name" id="SA_CA_Name" value="">
                        </div>
                        <div class="col-2">
                            <span class="cont-text"> Debet </span><br>
                            <input Required class="text-center cont-form" type="number" name="SA_Debet" id="SA_Debet" value="0">
                        </div>
                        <div class="col-2">
                            <span class="cont-text"> Kredit </span><br>
                            <input Required class="text-center cont-form" type="number" name="SA_Kredit" id="SA_Kredit" value="0">
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-2">
                            <input class="cont-btn" type="submit" name="simpan" id="simpan" value="Simpan">
                        </div>
                        <div class="col-2">
                            <button class="cont-btn" > Batal </button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="cont-background mt-2" id="list-SaldoAwal">
                <div class="row">
                    <div class="col-2">
                        <span class="cont-text"> Tahun  </span><br>
                        <input  class=" mb-2 cont-form" type="text" name="" id="" value="">
                    </div>
                    <div class="col-2">
                        <span class="cont-text"> Kode Perkiraan  </span><br>
                        <input  class=" mb-2 cont-form" type="text" name="" id="" value="">
                    </div>
                </div>
            </div>
            <div class="row align-items-center p-2">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="cont-tb" style="overflow:scroll">
                        <table class="cont-text table  table-bordered table-condensed mt-1">
                            <thead>
                                <tr class="text-center">
                                    <th>TAHUN</th>
                                    <th>KODE PERKIRAAN</th>
                                    <th>TYPE</th>
                                    <th>NAMA PERKIRAAN </th>
                                    <th>DEBET</th>
                                    <th>KREDIT</th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                            <% do while not Header.eof %>
                                <tr>
                                    <td class="text-center"><%=Header("SA_Tahun")%> </td>
                                    <td class="text-center"><%=Header("CA_UpID")%> </td>
                                    <td class="text-center"><%=Header("CA_Type")%> </td>
                                    <td><%=Header("CA_Name")%> </td>
                                    <td class="text-end"><%=Replace(Replace(FormatCurrency(Header("SA_Debet")),"$","Rp. "),".00","")%> </td>
                                    <td class="text-end"><%=Replace(Replace(FormatCurrency(Header("SA_Kredit")),"$","Rp. "),".00","")%> </td>
                                </tr>
                                <%
                                    SaldoAwal_cmd.commandText = "SELECT GL_M_SaldoAwal.SA_Tahun, GL_M_SaldoAwal.SA_Debet, GL_M_SaldoAwal.SA_Kredit, GL_M_SaldoAwal.SA_UpdateID, Detail.CA_ID, Detail.CA_Name, Detail.CA_Type FROM GL_M_SaldoAwal LEFT OUTER JOIN GL_M_ChartAccount AS Detail ON GL_M_SaldoAwal.SA_CA_ID = Detail.CA_ID WHERE  CA_UpID = '"& Header("CA_UpID") &"' "
                                    set Detail = SaldoAwal_cmd.execute
                                %>
                                <% do while not Detail.eof %>
                                <tr>
                                    <td class="text-center"><%=Detail("SA_Tahun")%> </td>
                                    <td class="text-center"><%=Detail("CA_ID")%> </td>
                                    <td class="text-center"><%=Detail("CA_Type")%> </td>
                                    <td><%=Detail("CA_Name")%> </td>
                                    <td class="text-end"><%=Replace(Replace(FormatCurrency(Detail("SA_Debet")),"$","Rp. "),".00","")%> </td>
                                    <td class="text-end"><%=Replace(Replace(FormatCurrency(Detail("SA_Kredit")),"$","Rp. "),".00","")%> </td>
                                </tr>
                                <% Detail.movenext
                                loop %>
                            <% Header.movenext
                            loop %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script>
        var dropdown = document.getElementsByClassName("dropdown-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
        } else {
        dropdownContent.style.display = "block";
        }
        });
        }
        var dropdown = document.getElementsByClassName("cont-dp-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
        } else {
        dropdownContent.style.display = "block";
        }
        });
        }
        var modal = document.getElementById("myModal");
        var btn = document.getElementById("myBtn");
        var span = document.getElementsByClassName("closee")[0];
        btn.onclick = function() {
        modal.style.display = "block";
        }
        span.onclick = function() {
        modal.style.display = "none";
        }
        window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        }
        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>