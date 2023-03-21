<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
    response.redirect("../../../../admin/")
    end if

    set CashBank_H_CMD = server.CreateObject("ADODB.command")
    CashBank_H_CMD.activeConnection = MM_PIGO_String
    CashBank_H_CMD.commandText = "SELECT * FROM GL_T_CashBank_H"
    'response.write CashBank_H_CMD.commandText
    set CashBank = CashBank_H_CMD.execute

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
    set AccountKas = GL_M_ChartAccount_cmd.execute

    set Jurnal_CMD = server.createObject("ADODB.COMMAND")
	Jurnal_CMD.activeConnection = MM_PIGO_String
    Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID,GL_T_Jurnal_H.JR_Status, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN,GL_T_Jurnal_H.JR_Status"
    set Jurnal = Jurnal_CMD.execute
    set KalkulasiFiskal_CMD = server.createObject("ADODB.COMMAND")
	KalkulasiFiskal_CMD.activeConnection = MM_PIGO_String

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
        function getListData(){
                $.ajax({
                    type: "get",
                    url: "load-list-jurnal.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value+"&JR_Type="+document.getElementById("typejr").value+"&JR_ID="+document.getElementById("jrid").value,
                    success: function (url) {
                        console.log(url);
                    $('.DataListJurnal').html(url);
                    }
                });
            }
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
            $.ajax({
                type: "get",
                url: "get-ACName.asp?CA_Name="+document.getElementById("AccountID").value,
                success: function (url) {
                $('.cont-account-kas').html(url);
                }
            });
        }
        function getAccountKas(){
            $.ajax({
                type: "get",
                url: "get-ACID.asp?CA_ID="+document.getElementById("AccountID").value,
                success: function (url) {
                $('.cont-account-kas').html(url);
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
        .cont-tb{
            font-size:10px;
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
        .container{
            background-color:white;
            margin-top:1rem;
        }
        .content-kalkulasi-fiskal{
            background-color:#eee;
            border-radius:10px;
            padding:20px
        }
        .cont-komponen{
            height:18rem;
            overflow-y:scroll;
            margin-top:5px;
        }
    </style>
    </head>
    <!--#include file="../../../loaderpage.asp"-->
<body>
    <div class="container">
        <div class="content-kalkulasi-fiskal">
            <div class="row">
                <div class="col-lg-10 col-md-10 col-sm-10">
                    <span class="cont-judul"> TAMBAH DATA KALKULASI FISKAL  </span>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-2">
                    <button class="cont-btn" onclick="window.open('index.asp','_Self')"> KEMBALI </button>
                </div>
            </div>
            <hr>
            <div class="cont-background-kf mt-3">
                <div class="row">
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="cont-koreksi-negatif text-center" style="padding:5px 5px; background-color:white;border-radius:10px">
                            <span class="cont-judul"> KOREKSI NEGATIF  </span><br>
                            <input type="hidden" name="JenisKoreksiNegatif" id="JenisKoreksiNegatif" value="N">
                            <button class="cont-btn mt-2" onclick="window.open('add-komponen.asp?JK='+document.getElementById('JenisKoreksiNegatif').value,'_Self')"> TAMBAH KOMPONEN KOREKSI NEGATIF </button>
                            <!--MODAL TAMBAH KOMPONEN KOREKSI NEGATIF -->
                            <div class="cont-koreksi-negatif cont-komponen">
                            <%
                                KalkulasiFiskal_CMD.commandText = "SELECT GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi, GL_M_Fiskal_H.FM_SaldoAwalYN, GL_M_Fiskal_D.FMD_ID, COUNT(GL_M_Fiskal_D.FMD_CA_ID) AS CAID FROM GL_M_Fiskal_D RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID WHERE FM_JenisKoreksi = 'N' GROUP BY GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi, GL_M_Fiskal_H.FM_SaldoAwalYN, GL_M_Fiskal_D.FMD_ID"
                                set KoreksiNegatif = KalkulasiFiskal_CMD.execute
                            %>
                            <table  class=" align-items-center cont-tb table tb-transaksi table-bordered table-condensed mt-1">
                                <thead>
                                    <tr class="text-center">
                                        <th> NAMA </th>
                                        <th> SALDO AWAL</th>
                                        <th> AKUN </th>
                                        <th> AKSI </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% do while not KoreksiNegatif.eof %>
                                    <tr>
                                        <td class="text-start"> 
                                            <%=KoreksiNegatif("FM_Nama")%> 
                                            <input type="hidden" name="FMIDN" id="FMIDN<%=KoreksiNegatif("FMD_ID")%>" value="<%=KoreksiNegatif("FMD_ID")%>">
                                        </td>
                                        <% if KoreksiNegatif("FM_SaldoAwalYN") = "Y" then %>
                                        <td> YA </td>
                                        <% else %>
                                        <td> TIDAK </td>
                                        <% end if %>
                                        <td> <%=KoreksiNegatif("CAID")%> </td>
                                        <td> <button class="cont-btn" style="font-size:10px" onclick="window.open('up-komponen.asp?FMIDN='+document.getElementById('FMIDN<%=KoreksiNegatif("FMD_ID")%>').value,'_Self')"> EDIT </button> </td>
                                    </tr>
                                    <% KoreksiNegatif.movenext
                                    loop %>
                                </tbody>
                            </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="cont-koreksi-negatif text-center" style="padding:5px 5px; background-color:white;border-radius:10px">
                            <span class="cont-judul"> KOREKSI POSITIF  </span><br>
                            <input type="hidden" name="JenisKoreksiPositif" id="JenisKoreksiPositif" value="P">
                            <button class="cont-btn mt-2" onclick="window.open('add-komponen.asp?JK='+document.getElementById('JenisKoreksiPositif').value,'_Self')"> TAMBAH KOMPONEN KOREKSI POSITIF </button>
                            <div class="cont-koreksi-positif cont-komponen">
                            <%
                                KalkulasiFiskal_CMD.commandText = "SELECT GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi, GL_M_Fiskal_H.FM_SaldoAwalYN, GL_M_Fiskal_D.FMD_ID, COUNT(GL_M_Fiskal_D.FMD_CA_ID) AS CAID FROM GL_M_Fiskal_D RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID WHERE FM_JenisKoreksi = 'P' GROUP BY GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi, GL_M_Fiskal_H.FM_SaldoAwalYN, GL_M_Fiskal_D.FMD_ID"
                                set KoreksiPositif = KalkulasiFiskal_CMD.execute
                            %>
                            <table  class=" align-items-center cont-tb table tb-transaksi table-bordered table-condensed mt-1">
                                <thead>
                                    <tr class="text-center">
                                        <th> NAMA </th>
                                        <th> SALDO AWAL</th>
                                        <th> AKUN </th>
                                        <th> AKSI </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% do while not KoreksiPositif.eof %>
                                    <tr>
                                        <td class="text-start"> 
                                            <%=KoreksiPositif("FM_Nama")%> 
                                            <input type="hidden" name="FMIDN" id="FMIDN<%=KoreksiPositif("FMD_ID")%>" value="<%=KoreksiPositif("FMD_ID")%>">
                                        </td>
                                        <% if KoreksiPositif("FM_SaldoAwalYN") = "Y" then %>
                                        <td> YA </td>
                                        <% else %>
                                        <td> TIDAK </td>
                                        <% end if %>
                                        <td> <%=KoreksiPositif("CAID")%> </td>
                                        <td> <button class="cont-btn" style="font-size:10px" onclick="window.open('up-komponen.asp?FMIDN='+document.getElementById('FMIDN<%=KoreksiPositif("FMD_ID")%>').value,'_Self')"> EDIT </button> </td>
                                    </tr>
                                    <% KoreksiPositif.movenext
                                    loop %>
                                </tbody>
                            </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="cont-koreksi-negatif text-center" style="padding:5px 5px; background-color:white; border-radius:10px">
                            <span class="cont-judul"> KREDIT PAJAK </span><br>
                            <input type="hidden" name="KreditPajak" id="KreditPajak" value="K">
                            <button class="cont-btn mt-2" onclick="window.open('add-komponen.asp?JK='+document.getElementById('KreditPajak').value,'_Self')"> TAMBAH KOMPONEN KREDIT PAJAK </button>
                            <div class="cont-kredit-pajak cont-komponen">
                            <%
                                KalkulasiFiskal_CMD.commandText = "SELECT GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi, GL_M_Fiskal_H.FM_SaldoAwalYN, GL_M_Fiskal_D.FMD_ID, COUNT(GL_M_Fiskal_D.FMD_CA_ID) AS CAID FROM GL_M_Fiskal_D RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID WHERE FM_JenisKoreksi = 'K' GROUP BY GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi, GL_M_Fiskal_H.FM_SaldoAwalYN, GL_M_Fiskal_D.FMD_ID"
                                set KreditPajak = KalkulasiFiskal_CMD.execute
                            %>
                            <table  class=" align-items-center cont-tb table tb-transaksi table-bordered table-condensed mt-1">
                                <thead>
                                    <tr class="text-center">
                                        <th> NAMA </th>
                                        <th> SALDO AWAL</th>
                                        <th> AKUN </th>
                                        <th> AKSI </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% do while not KreditPajak.eof %>
                                    <tr>
                                        <td class="text-start"> 
                                            <%=KreditPajak("FM_Nama")%> 
                                            <input type="hidden" name="FMIDN" id="FMIDN<%=KreditPajak("FMD_ID")%>" value="<%=KreditPajak("FMD_ID")%>">
                                        </td>
                                        <% if KreditPajak("FM_SaldoAwalYN") = "Y" then %>
                                        <td> YA </td>
                                        <% else %>
                                        <td> TIDAK </td>
                                        <% end if %>
                                        <td> <%=KreditPajak("CAID")%> </td>
                                        <td> <button class="cont-btn" style="font-size:10px" onclick="window.open('up-komponen.asp?FMIDN='+document.getElementById('FMIDN<%=KreditPajak("FMD_ID")%>').value,'_Self')"> EDIT </button> </td>
                                    </tr>
                                    <% KreditPajak.movenext
                                    loop %>
                                </tbody>
                            </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <form class="" action="proses.asp" method="POST">
            <div class="cont-background mt-3">
                <div class="row">
                    <div class="col-3">
                        <span class="cont-text"> TAHUN </span>
                        <input class="cont-form text-center" type="text" name="Tahun" id="Tahun" value="<%=YEAR(Date())%>">
                    </div>
                    <div class="col-3">
                        <span class="cont-text"> BULAN </span>
                        <input class="cont-form text-center" type="text" name="Bulan" id="Bulan" value="<%=MONTH(Date())%>">
                    </div>
                    <div class="col-3">
                        <span class="cont-text"> TARIF PAJAK </span>
                        <input class="cont-form text-center" type="number" name="TarifPajak" id="TarifPajak" value="">
                    </div>
                    <div class="col-3">
                        <span class="cont-text"> KOMPENSASI </span>
                        <input class="cont-form text-center" type="text" name="Kompensasi" id="Kompensasi" value="0">
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <input type="submit" name="proses" id="proses" class="cont-btn" value="PROSES">
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>
</body>
    <script>
        function addjurnal(){
            var JR_Tanggal      = $('input[name=JR_Tanggal]').val();
            var JR_Keterangan   = $('input[name=JR_Keterangan]').val();
            var JR_Type         = $('select[name=JR_Type]').val();
            var JR_UpdateID     = $('input[name=JR_UpdateID]').val();
            $.ajax({
                type: "get",
                url: "add-jurnalH.asp",
                data: {
                    JR_Tanggal,
                    JR_Keterangan,
                    JR_Type,
                    JR_UpdateID
                },
                success: function (data) {
                $('.cont-rincian-jurnal').html(data);
                }
            });
            document.getElementById("tb-jurnal").style.display = "none";
            document.getElementById("btn-batal").style.display = "none";
            document.getElementById("batal-jurnal").style.display = "block";
            document.getElementById("tambah-jurnal").style.display = "none";
            var permintaan = document.querySelectorAll("[id^=cont]");
            for (let i = 0; i < permintaan.length; i++) {
                permintaan[i].setAttribute("readonly", true);
                permintaan[i].setAttribute("disabled", true);
            }
        }

        function batal() {
            var JR_ID = document.getElementById("JRD_ID").value;
            console.log(JR_ID);
            $.ajax({
                type: "POST",
                url: "delete-jurnal.asp",
                    data:{
                        JR_ID
                    },
                success: function (data) {
                    Swal.fire('Deleted !!', data.message, 'success').then(() => {
                    location.reload();
                    });
                }
            });
            document.getElementById("tb-jurnal").style.display = "block";
            document.getElementById("btn-batal").style.display = "none";
            document.getElementById("btn-add").style.display = "block";
            document.getElementById("batal-jurnal").style.display = "none";
            document.getElementById("tambah-jurnal").style.display = "block";

            var permintaan = document.querySelectorAll("[id^=cont]");
            for (let i = 0; i < permintaan.length; i++) {
                permintaan[i].removeAttribute("readonly");
                permintaan[i].removeAttribute("disabled");
                permintaan[i].value="";
            }
        }

        function addjurnalD(){
            var JRD_ID      = $('input[name=JRD_ID]').val();
            var JRD_CA_ID   = $('input[name=AccountID]').val();
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
       
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>