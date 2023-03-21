<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    JR_ID = request.queryString("JR_ID")

    set CashBank_H_CMD = server.CreateObject("ADODB.command")
    CashBank_H_CMD.activeConnection = MM_PIGO_String
    CashBank_H_CMD.commandText = "SELECT * FROM GL_T_CashBank_H"
    'response.write CashBank_H_CMD.commandText
    set CashBank = CashBank_H_CMD.execute

    

    set JurnalH_CMD = server.createObject("ADODB.COMMAND")
	JurnalH_CMD.activeConnection = MM_PIGO_String
    JurnalH_CMD.commandText = "SELECT * FROM GL_T_Jurnal_H WHERE JR_ID = '"& JR_ID &"'  "
    set Jurnal = JurnalH_CMD.execute 
    if Jurnal("JR_Type")  = "M" then 
    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' AND CA_ItemTipe <> 'C' AND CA_ID <> 'A100.02.00' AND CA_UpID <> 'A100.02.00'"
    set AccountKas = GL_M_ChartAccount_cmd.execute 
    else 
    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
    set AccountKas = GL_M_ChartAccount_cmd.execute 
    end if 

    JurnalH_CMD.commandText = "SELECT GL_T_Jurnal_D.JRD_ID,GL_T_Jurnal_D.JRD_CA_ID, GL_M_ChartAccount.CA_Name,GL_T_Jurnal_D.JRD_Keterangan, GL_T_Jurnal_D.JRD_Debet, GL_T_Jurnal_D.JRD_Kredit,JR_AktifYN FROM GL_M_ChartAccount RIGHT OUTER JOIN GL_T_Jurnal_D ON GL_M_ChartAccount.CA_ID = GL_T_Jurnal_D.JRD_CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID Where LEFT(GL_T_Jurnal_D.JRD_ID,12) = '"& JR_ID &"' "
    'response.write JurnalH_CMD.commandText 
    set JurnalD = JurnalH_CMD.execute 


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
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"> </script>
    <script>
        function newjurnal(){
            document.getElementById("add-jurnal").style.display = "block";
            document.getElementById("list-jurnal").style.display = "none";
            document.getElementById("btn-batal").style.display = "block";
            document.getElementById("btn-add").style.display = "none";
        }
        function canclejurnal(){
            document.getElementById("list-jurnal").style.display = "block";
            document.getElementById("add-jurnal").style.display = "none";
            document.getElementById("btn-batal").style.display = "none";
            document.getElementById("btn-add").style.display = "block";
        }
        function getAccountID(){
            document.getElementById("cont-account-id").style.display = "block"
        }
        function getAccountName(){
            var caname = document.getElementById("AccountID").value;
            var jrtype = document.getElementById("jurnaltype").value;
            $.ajax({
                type: "get",
                url: "get-ACName.asp",
                data:{
                    caname,
                    jrtype
                },
                success: function (url) {
                $('.cont-account-kas').html(url);
                }
            });
        }
        function getAccountKas(){
            var caid = document.getElementById("AccountID").value;
            var jrtype = document.getElementById("jurnaltype").value;
            $.ajax({
                type: "get",
                url: "get-ACID.asp",
                data:{
                    caid,
                    jrtype
                },
                success: function (data) {
                $('.cont-account-kas').html(data);
                }
            });
        }
    </script>
    <style>
        .cont-rincian-data-jurnal{
            background-color:white;
            height:13rem;
            overflow:scroll;
            overflow-x:hidden;
        }
        .cont-account-id{
            background-color:white;
            height:6rem;
            overflow:scroll;
            overflow-x:hidden;
        }
        .tb-account-id{
            border:1px solid black;
        }
    </style>
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-10 col-md-10 col-sm-12">
                        <span class="cont-judul"> DETAIL JURNAL </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                    <% if Jurnal("JR_AktifYN") = "Y" then %>
                        <button onclick="window.open('index.asp','_Self')"  class="cont-btn"> KEMBALI </button>
                    <% else %>
                        <span class="cont-judul"><%=Jurnal("JR_AktifYN")%></span>
                    <% end if  %>
                    </div>
                </div>
            </div>
            
            <div class="cont-background mt-2"  id="add-jurnal">
                <div class="add-jurnal mt-1 mb-2">
                    <div class="row">
                        <div class="col-2">
                            <span class="cont-text"> Pembuat </span> <br>
                            <input readonly class="text-center cont-form" type="text" name="JR_UpdateID" id="cont" value="<%=Jurnal("JR_UpdateID")%>">
                        </div>
                        <div class="col-2">
                            <span class="cont-text"> Tanggal </span> <br>
                            <input readonly class="text-center cont-form" type="text" name="JR_Tanggal" id="cont" value="<%=Jurnal("JR_Tanggal")%>">
                        </div>
                        <div class="col-4">
                            <span class="cont-text"> Type Jurnal </span> <br>
                            <% if Jurnal("JR_Type") = "B" then %>
                            <input readonly class="text-center cont-form" type="text" name="JR_Type" id="cont" value="Pembelian">
                            <% else if Jurnal("JR_Type") = "P" then %>
                            <input readonly class="text-center cont-form" type="text" name="JR_Type" id="cont" value="Penjualan">
                            <% else if Jurnal("JR_Type") = "T" then %>
                            <input readonly class="text-center cont-form" type="text" name="JR_Type" id="cont" value="Kas Masuk">
                            <% else if Jurnal("JR_Type") = "K" then %>
                            <input readonly class="text-center cont-form" type="text" name="JR_Type" id="cont" value="Kas Keluar">
                            <% else %>
                            <input readonly class="text-center cont-form" type="text" name="JR_Type" id="cont" value="Memorial">
                            <% end if %><% end if %><% end if %><% end if %>
                        </div> 
                        <div class="col-4">
                            <span class="cont-text"> Keterangan Jurnal </span> <br>
                            <input readonly class=" cont-form" type="text" name="JR_Keterangan" id="cont" value="<%=Jurnal("JR_Keterangan")%>">
                        </div>
                    </div>
                    <div class="cont-rincian-jurnal" id="cont-rincian-jurnal">
                    <hr>
                        <div class="row mt-3 cont-JR-ID">
                            <div class="col-2 ">
                                <span class="cont-text"> NO JURNAL </span>
                            </div>
                            <div class="col-8 ">
                                <input readonly class="text-center cont-form" type="text" name="JRD_ID" id="JRD_ID" value="<%=Jurnal("JR_ID")%>">
                            </div>
                            <% if Jurnal("JR_AktifYN") <> "Y" then %>
                            <div class="col-2 ">
                                <button onclick="batal()" class="cont-btn"> BATALKAN JURNAL </button>
                            </div>
                            <% end if %>
                        </div>
                    <hr>
                    <div class="row mt-3 text-center">
                        <div class="col-12">
                            <div class="cont-label-text">
                                <span class="cont-text"> RINCIAN JURNAL </span> <br>
                            </div>
                        </div>
                    </div>
                    <% if Jurnal("JR_Status") = "JR" then %>
                    <div class="rincian-data-jurnal" id="rincian-data-jurnal" style="display:block">
                        <div class="row mt-2 text-center">
                            <div class="col-2  Account-Kas-Cont">
                                <span class="cont-text"> Kode Account ID </span> <br>
                                <input  type="hidden" name="jurnaltype" id="jurnaltype" value="<%=Jurnal("JR_Type")%>">
                                <input onkeyup="getAccountKas()" class="text-center cont-form" type="text" name="AccountID" id="AccountID" value="">
                            </div>
                            <div class="col-4">
                                <span class="cont-text"> Keterangan </span> <br>
                                <input class="cont-form" type="text" name="JRD_Keterangan" id="JRD_Keterangan" value="<%=Jurnal("JR_Keterangan")%>">
                            </div>
                            <div class="col-2">
                                <span class="cont-text"> DEBET </span> <br>
                                <input class="text-center cont-form" type="number" name="JRD_Debet" id="JRD_Debet" value="0">
                            </div>
                            <div class="col-2">
                                <span class="cont-text"> KREDIT </span> <br>
                                <input class="text-center cont-form" type="number" name="JRD_Kredit" id="JRD_Kredit" value="0">
                            </div>
                            <div class="col-2">
                                <br>
                                <button onclick="addjurnalD()"class="cont-btn"> Tambah Rincian </button>
                            </div>
                        </div>
                    </div>
                    <div class="cont-account-id mt-2 mb-2" id="cont-account-id" style="display:block">
                        <div class="row cont-account-kas">
                        </div>
                    </div>
                    <% end if %>
                </div>
                <div class="cont-data-jurnal" id="cont-data-jurnal" >
                    <div class="mt-2 cont-rincian-data-jurnal" id="cont-rincian-data-jurnal">
                        <div class="row text-center" >
                            <div class="col-12">
                                <table class="cont-text cont-tb table  table-bordered table-condensed" style="font-size:12px">
                                    <thead>
                                        <tr class="text-center">
                                            <th>ACTION</th>
                                            <th colspan="2">KODE PERKIRAAN</th>
                                            <th>KETERANGAN</th>
                                            <th>DEBET</th>
                                            <th>KREDIT</th>
                                        </tr>
                                    </thead>
                                    <tbody class="datatr">
                                        <%
                                            if JurnalD.eof = true then
                                            selisih = 1
                                        %>
                                            <tr>
                                                <td colspan="6" > RINCIAN JURNAL KOSONG </td>
                                                <input class="text-center cont-text"  type="hidden" name="selisih" id="selisih" value="<%=selisih%>" style="border:none">
                                            </tr>
                                        <% else %>
                                        <% 
                                            no = 0 
                                            do while not JurnalD.eof 
                                            no = no + 1
                                        %>
                                        <tr class="text-center">
                                            <td>
                                                <% if Jurnal("JR_Status") = "JR" then %>
                                                <button onclick="deleteJurnalD<%=no%>()" name="delete-rincian" id="delete-rincian<%=no%>" class="delete-rincian cont-btn" style="display:block"> DELETE </button>
                                                <input type="hidden" name="JRD_ID" id="JRD_ID<%=no%>" Value="<%=JurnalD("JRD_ID")%>">
                                                <span class="cont-text label-stpo6" name="span-tb" id="span-tb" style="display:none"> <i class="fas fa-check"></i> </span>
                                                <% else %>
                                                <span class="cont-text label-stpo6" name="span-tb" id="span-tb"> <i class="fas fa-check"></i> </span>
                                                <% end if %>
                                            </td>
                                            <td> <%=JurnalD("JRD_CA_ID")%> </td>
                                            <td> <%=JurnalD("CA_Name")%> </td>
                                            <td> <%=JurnalD("JRD_Keterangan")%> </td>
                                            <td> <%=JurnalD("JRD_Debet")%> </td>
                                            <td> <%=JurnalD("JRD_Kredit")%> </td>
                                        </tr>
                                        <script>
                                            function deleteJurnalD<%=no%>(){
                                                var JRD_ID = document.getElementById("JRD_ID<%=no%>").value;
                                                var Kode   = "DE";
                                                $.ajax({
                                                    type: "POST",
                                                    url: "delete-jurnalD.asp",
                                                    data: {
                                                        JRD_ID,
                                                        Kode
                                                    },
                                                    success: function (data) {
                                                        Swal.fire('Deleted !!', data.message, 'success').then(() => {
                                                        location.reload();
                                                        });
                                                    }
                                                });
                                            }
                                        </script>
                                            <% 
                                                totaldebet = totaldebet + JurnalD("JRD_Debet") 
                                                totalkredit = totalkredit + JurnalD("JRD_Kredit") 
                                            %>
                                        <% JurnalD.movenext
                                        loop %>
                                       
                                    </tbody>
                                    <thead>
                                        <tr class="text-center">
                                            <th colspan="4">TOTAL</th>
                                            <td ><%=totaldebet%></td>
                                            <td ><%=totalkredit%></td>
                                        </tr>
                                        <tr class="text-center">
                                            <th colspan="4">SELISIH</th>
                                            <% selisih = totalkredit - totaldebet%>
                                            <td colspan="2">
                                                <input class="text-center cont-text"  type="number" name="selisih" id="selisih" value="<%=selisih%>" style="border:none">
                                            </td>
                                        </tr> 
                                        <% end if %>
                                    <thead>
                                </table>
                            </div>
                        </div>
                    </div>
                    <% if Jurnal("JR_Status") = "JR" then %>
                    <div class="complete" id="comp" style="display:none">
                        <div class="row align-items-center mt-2">
                            <div class="col-3">
                                <div class="form-check">
                                    <input onclick="comp()" class="form-check-input" type="checkbox" id="check1" name="option1" value="something" >
                                    <label class="cont-text form-check-label">Complete Rincian</label>
                                </div>
                            </div>
                            <div class="col-2">
                                <button onclick="DelDetailJurnal()" name="clear-jurnal" id="clear-jurnal" class="cont-btn" style="display:block"> Clear Rincian Jurnal </button>
                            </div>
                        </div>
                    </div>
                    <div class="cont-simpan-jurnal" id="cont-simpan-jurnal" style="display:none">
                        <div class="row mt-2">
                            <div class="col-2">
                                <button onclick="simjurnal()" class="cont-btn"> Simpan </button>
                            </div>
                            <div class="col-2">
                                <button onclick="window.open('jurnal-voucher.asp?JR_ID='+document.getElementById('JRD_ID').value)"  class="cont-btn" id="jr-btn-cetak"style="display:none"> Cetak </button>
                            </div>
                            <div class="col-2">
                                <button onclick="window.open('index.asp','_Self')" class="cont-btn" id="jr-btn-kembali"style="display:none"> Kembali </button>
                            </div>
                        </div>
                    </div>
                    <% else %>
                    <div class="cont-simpan-jurnal" id="cont-simpan-jurnal">
                        <div class="row mt-2">
                            <div class="col-2">
                                <button onclick="window.open('jurnal-voucher.asp?JR_ID='+document.getElementById('JRD_ID').value)"  class="cont-btn" id="jr-btn-cetak"> Cetak </button>
                            </div>
                            <div class="col-2">
                                <button onclick="window.open('index.asp','_Self')" class="cont-btn" id="jr-btn-kembali"> Kembali </button>
                            </div>
                        </div>
                    </div>
                    <% end if  %>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script>
        var hasil = document.getElementById("selisih").value;
            if(hasil == 0){
                document.getElementById("comp").style.display = "block"
            }else{
                document.getElementById("comp").style.display = "none"
            }
        
        function simjurnal(){
            var JR_IDD = document.getElementById("JRD_ID").value;
            var Proses11 = "Y";
            $.ajax({
                type: "POST",
                url: "update-JurnalH.asp",
                data: {
                    JR_ID : JR_IDD,
                    Proses1 : Proses11
                },
                success: function (data) {
                    Swal.fire('Jurnal Berhasil Di Simpan', data.message, 'success').then(() => {
                    });
                    document.getElementById("jr-btn-cetak").style.display = "block"
                    document.getElementById("jr-btn-kembali").style.display = "block"
                }
            });
            document.getElementById("comp").style.display = "none" 
        }

        function comp(){
            var JR_ID = document.getElementById("JRD_ID").value;
            var Proses1 = "P";
            var complete = document.getElementById("check1");
            if (!complete.checked){
                $.ajax({
                    type: "POST",
                    url: "update-JurnalH.asp",
                    data: {
                        JR_ID,
                        Proses1
                    },
                    success: function (data) {
                    }
                });
                document.getElementById("cont-simpan-jurnal").style.display = "none" 
                document.getElementById("rincian-data-jurnal").style.display = "block" 
                document.getElementById("clear-jurnal").style.display = "block" 
                // $('button[name=delete-rincian]').html("DELETE");
                $('button[name=delete-rincian]').attr("style", "display:block")
                $('span[name=span-tb]').attr("style", "display:none")
            }else{
                $.ajax({
                    type: "POST",
                    url: "update-JurnalH.asp",
                    data: {
                        JR_ID
                    },
                    success: function (data) {
                    }
                });
                document.getElementById("cont-simpan-jurnal").style.display = "block" 
                document.getElementById("rincian-data-jurnal").style.display = "none" 
                document.getElementById("clear-jurnal").style.display = "none" 
                // $('button[name=delete-rincian]').html("-");
                $('span[name=span-tb]').attr("style", "display:block")
                $('button[name=delete-rincian]').attr("style", "display:none")
            }
        } 

        function batal() {
            var JR_ID = document.getElementById("JRD_ID").value;
            Swal.fire({
                title: 'Anda Yakin Akan Membatalkan Jurnal ?',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Iya',
                denyButtonText: `Tidak`,
                }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: "delete-jurnalH.asp",
                            data:{
                                JR_ID
                            },
                        success: function (data) {
                            Swal.fire('Deleted !!', data.message, 'success').then(() => {
                            location.reload();
                            window.open(`index.asp`,`_Self`)
                            });
                        }
                    });
                } else if (result.isDenied) {
                    location.reload();
                }
            })
        }

        function addjurnalD(){
            var JRD_ID      = $('input[name=JRD_ID]').val();
            var JRD_CA_ID   = $('input[name=AccountID1]').val();
            console.log(JRD_CA_ID)
            var JRD_Keterangan   = $('input[name=JRD_Keterangan').val();
            var JRD_Debet         = $('input[name=JRD_Debet]').val();
            var JRD_Kredit     = $('input[name=JRD_Kredit]').val();
            $.ajax({
                type: "get",
                url: "add-jurnalD.asp",
                data: {
                    JRD_ID,
                    JRD_CA_ID,
                    JRD_Keterangan,
                    JRD_Debet,
                    JRD_Kredit
                },
                success: function (data) {
                $('.cont-data-jurnal').html(data);
                }
            });
            $('input[name=AccountID]').val('');
            $('input[name=JRD_Debet]').val(0);
            $('input[name=JRD_Kredit]').val(JRD_Debet);
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

        function DelDetailJurnal(){
        var JR_ID = document.getElementById("JRD_ID").value;
        var Kode  = "AD";
        $.ajax({
            type: "POST",
            url: "delete-jurnalD.asp",
            data: {
                JR_ID,
                Kode
            },
            success: function (data) {
                Swal.fire('Deleted !!', data.message, 'success').then(() => {
                location.reload();
                });
            }
        });
                                            }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>