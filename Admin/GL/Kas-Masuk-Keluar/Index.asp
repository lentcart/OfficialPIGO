<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

   set CashBank_H_CMD = server.CreateObject("ADODB.command")
    CashBank_H_CMD.activeConnection = MM_PIGO_String
    CashBank_H_CMD.commandText = "SELECT * FROM GL_T_CashBank_H"
    'response.write CashBank_H_CMD.commandText
    set CashBank = CashBank_H_CMD.execute

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
        function loadCashBank(){
            $.ajax({
                type: "get",
                url: "load-CashBank.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value+"&CB_ID="+document.getElementById("idcb").value+"&CB_Tipe="+document.getElementById("tipecb").value,
                success: function (url) {
                    console.log(url);
                $('.datatr').html(url);
                }
            });
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
                <div class="row">
                    <div class="col-lg-11 col-md-11 col-sm-12">
                        <span class="cont-judul"> KAS MASUK / KELUAR </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <form class="" action="add-CashBankH.asp" method="post">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <span class="cont-text"> Tambah Data Transaksi  </span><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-2 col-md-4 col-sm-12">
                                    <span class="cont-text "> Tanggal  </span><br>
                                    <input class="text-center mb-2 cont-form" type="date" name="tgltransaksi" id="tgltransaksi" value="" >
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-12">
                                    <span class="cont-text "> Pembuat </span><br>
                                    <input readonly class=" mb-2 cont-form" type="text" name="updatename" id="updatename" value="<%=session("username")%>">
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-12">
                                    <span class="cont-text "> Jenis Transaksi </span><br>
                                    <select  class=" mb-2 cont-form" name="jenis" id="jenis" aria-label="Default select example" required>
                                        <option selected>Jenis Transaksi</option>
                                        <option value="T">Kas Masuk</option>
                                        <option value="K">Kas Keluar</option>
                                    </select>
                                </div>
                                <div class="col-lg-4 col-md-8 col-sm-12">
                                    <span class="cont-text"> Keterangan Transaksi </span><br>
                                    <input class=" mb-2 cont-form" type="text" name="keterangan" id="keterangan" value="" >
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-12">
                                    <span class="cont-text"> </span><br>
                                    <input class="cont-btn" type="submit" name="submit" id="submit" value="Tambah" > 
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-12">
                        <span class="cont-text"> Periode Tanggal Transaksi </span><br>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <input onchange="loadCashBank()" class=" mb-2 cont-form" type="date" name="tgla" id="tgla" value="" >
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <input onchange="loadCashBank()" class=" mb-2 cont-form" type="date" name="tgle" id="tgle" value="" >
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-12">
                        <input onkeyup="loadCashBank()" class=" mb-2 cont-form" type="text" name="idcb" id="idcb" value=""  placeholder="Masukan No Transaksi">
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <select onchange="loadCashBank()" class=" mb-2 cont-form" name="tipecb" id="tipecb" aria-label="Default select example" required>
                            <option Value="">Jenis Transaksi</option>
                            <option value="M">Kas Masuk</option>
                            <option value="K">Kas Keluar</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-12 col-sm-12">
                        <div class="dropdown">
                            <button class="cont-btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                Lap Cash Flow 
                            </button>
                            <ul class="dropdown-menu text-center cont-btn" aria-labelledby="dropdownMenuButton1">
                                <li>
                                    <button class="cont-btn" onclick="window.open('lappopdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')">Laporan PDF</button>
                                </li>
                                <li>
                                    <button class=" mt-2 cont-btn" onclick="window.open('lappoexc.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Excel </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row align-items-center p-1">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="cont-tb" style="overflow:scroll">
                        <table class="cont-text table  table-bordered table-condensed mt-1" style="width:70rem">
                            <thead>
                                <tr class="text-center">
                                    <th>NO</th>
                                    <th>ID TRANSAKSI</th>
                                    <th>TANGAL</th>
                                    <th>KETERANGAN</th>
                                    <th>JENIS TRANSAKSI</th>
                                    <th>STATUS TRANSAKSI</th>
                                    <th>NO JURNAL</th>
                                    <th>POSTING</th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                                <% 
                                    no = 0 
                                    do while not CashBank.eof 
                                    no = no + 1
                                %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td class="text-center"> 
                                        <input type="hidden" name="CB_ID" id="CB_ID<%=no%>" value="<%=CashBank("CB_ID")%>">
                                        <button onclick="window.open('Kas-Detail.asp?X='+document.getElementById('CB_ID<%=no%>').value,'_Self')" class="cont-btn"> <%=CashBank("CB_ID")%> </button>
                                        </td>
                                    <td class="text-center"> <%=Day(CDate(CashBank("CB_Tanggal")))%>/<%=MonthName(Month(CashBank("CB_Tanggal")))%>/<%=Year(CashBank("CB_Tanggal"))%> </td>
                                    <td> <%=CashBank("CB_Keterangan")%> </td>
                                    <% if  CashBank("CB_Tipe") = "M" Then %>
                                    <td> Kas Masuk </td>
                                    <% else %>
                                    <td> Kas Keluar </td>
                                    <% end if  %>
                                    <td class="text-center"> <%=CashBank("CB_Pembuat")%> </td>
                                    <td class="text-center"> <%=CashBank("CB_JR_ID")%> </td>
                                    <td class="text-center"> <%=CashBank("CB_PostingYN")%> </td>
                                </tr>
                                <% CashBank.Movenext
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