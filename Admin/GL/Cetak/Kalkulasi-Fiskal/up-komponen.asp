<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../../admin/")
    
    end if

    FMID        = request.queryString("FMIDN")

    set KalkulasiFiskal_CMD = server.createObject("ADODB.COMMAND")
	KalkulasiFiskal_CMD.activeConnection = MM_PIGO_String
    KalkulasiFiskal_CMD.commandText = "SELECT GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi, GL_M_Fiskal_H.FM_SaldoAwalYN, GL_M_Fiskal_D.FMD_ID, COUNT(GL_M_Fiskal_D.FMD_CA_ID) AS CAID FROM GL_M_Fiskal_D RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID WHERE GL_M_Fiskal_D.FMD_ID = '"& FMID &"' GROUP BY GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi, GL_M_Fiskal_H.FM_SaldoAwalYN, GL_M_Fiskal_D.FMD_ID "
    set FMID = KalkulasiFiskal_CMD.execute    

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
        .content-komponen-kalkulasi-fiskal{
            background-color:#eee;
            padding:20px;
            width: 45rem; 
            margin: 0 auto;
        }
        .cont-komponen{
            height:18rem;
            overflow-y:scroll;
            margin-top:5px;
        }
        .accountid-cont{
            height:10rem;
            background-color:red;
            overflow-y:scroll;
        }
    </style>
    </head>
    <!--#include file="../../../loaderpage.asp"-->
<body>
    <div class="container">
        <div class="content-komponen-kalkulasi-fiskal">
            <div class="row">
                <div class="col-lg-11 col-md-11 col-sm-11">
                <%
                    if FMID("FM_JenisKoreksi") = "N" then 
                        JK = "NEGATIF"
                        FM_JenisKoreksi = "N"
                    else if  FMID("FM_JenisKoreksi") = "P" then
                        JK = "POSITIF"
                        FM_JenisKoreksi = "P"
                    else
                        JK = "KREDIT PAJAK"
                        FM_JenisKoreksi = "K"
                    end if end if 
                %>

                    <span class="cont-judul">  EDIT KOMPONEN <%=JK%> </span>
                </div>
                <div class="col-lg-1 col-md-1 col-sm-1">
                    <i onclick="window.open('detail.asp','_Self')" class="fas fa-times-circle"  style="font-size:22px"></i>
                </div>
            </div>
            <hr>
            <div class="cont-background-kf mt-3">
                <div class="row">
                    <div class="col-lg-8 col-md-8 col-sm-8">
                        <span class="cont-text"> KETERANGAN KOMPONEN </span> <br>
                        <input type="text" class="cont-form" name="FM_Nama" id="FM_Nama" value="<%=FMID("FM_Nama")%>">
                        <input type="hidden" class="cont-form" name="FM_JenisKoreksi" id="FM_JenisKoreksi" value="<%=FM_JenisKoreksi%>">
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4">
                        <span class="cont-text"> DENGAN SALDO AWAL </span> <br>
                        <% if FMID("FM_SaldoAwalYN") = "Y" then %>
                        <input type="text" class="class-center cont-form" name="FM_Nama" id="FM_Nama" value="YA">
                        <% else %>
                        <input type="text" class="class-center cont-form" name="FM_Nama" id="FM_Nama" value="TIDAK">
                        <% end if %>
                    </div>
                </div>
                <hr>
                
                <div class="cont-rincian-acc" id="cont-rincian-acc">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 komponenkoreksi" id="komponenkoreksi">
                            <input type="hidden" name="FMID" id="FMID" value="<%=FMID("FMD_ID")%>">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <span class="cont-text"> KODE AKUN </span> <br>
                            <input onkeyup="getAccountName()" type="text" class="cont-form" name="CA_ID" id="CA_ID" value="">
                        </div>
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <span class="cont-text"> NAMA AKUN </span> <br>
                            <input onkeyup="getAccountName()" type="text" class="cont-form" name="CA_Name" id="CA_Name" value="">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-lg-12 col-md-12 col-sm-12 cont-account">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-lg-12 col-md-12 col-sm-12 rincian-acc-komponen">
                        <%
                            KalkulasiFiskal_CMD.commandText = "SELECT GL_M_Fiskal_D.FMD_ID, GL_M_Fiskal_D.FMD_CA_ID, GL_M_Fiskal_D.FMD_Value, GL_M_ChartAccount.CA_Name, GL_M_Fiskal_H.FM_JenisKoreksi FROM GL_M_Fiskal_D RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_M_Fiskal_D.FMD_CA_ID = GL_M_ChartAccount.CA_ID WHERE FMD_ID = '"& FMID("FMD_ID") &"' AND FM_JenisKoreksi = '"& FMID("FM_JenisKoreksi") &"' "
                            'response.write KalkulasiFiskal_CMD.commandText
                            set GLMFiskalD = KalkulasiFiskal_CMD.execute
                        %>
                        <table class=" align-items-center cont-tb table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px;">
                            <tr class="text-center">
                                <th> KODE AKUN </th>
                                <th> NAMA AKUN </th>
                                <th> VALUE (%) </th>
                                <th> AKSI </th>
                            </tr>
                            <% 
                                no = 0 
                                do while not GLMFiskalD.eof 
                                no = no + 1
                            %>
                                <tr>
                                    <td class="text-center"> 
                                        <%=GLMFiskalD("FMD_CA_ID")%> 
                                        <input type="hidden" name="CA_ID" id="CA_ID<%=no%>" value="<%=GLMFiskalD("FMD_CA_ID")%>">
                                        <input type="hidden" name="FMD_ID" id="FMD_ID<%=no%>" value="<%=GLMFiskalD("FMD_ID")%>">
                                        <input type="hidden" name="FM_JenisKoreksi" id="FM_JenisKoreksi<%=no%>" value="<%=FM_JenisKoreksi%>">
                                    </td>
                                    <td class="text-start"> <%=GLMFiskalD("CA_Name")%> </td>
                                    <td class="text-center"> <input onkeyup="addValue<%=no%>()" type="number" class="text-end cont-form" name="FMD_Value" id="FMD_Value<%=no%>" value="<%=GLMFiskalD("FMD_Value")%>" style="width:5rem"> </td>
                                    <td class="text-center"> <button onclick="DeleteGLMFiskalD<%=no%>()" class="cont-btn"> HAPUS </button> </td>
                                </tr>
                                <script>
                                    function addValue<%=no%>(){
                                        var FMD_CA_ID   = document.getElementById("CA_ID<%=no%>").value;
                                        var FMD_ID      = document.getElementById("FMD_ID<%=no%>").value;
                                        var FMD_Value   = document.getElementById("FMD_Value<%=no%>").value;
                                        $.ajax({
                                            type: "get",
                                            url: "up-ValueFiskalD.asp",
                                            data:{
                                                FMD_ID,
                                                FMD_CA_ID,
                                                FMD_Value
                                            },
                                            success: function (data) {
                                            }
                                        });
                                    }
                                    function DeleteGLMFiskalD<%=no%>(){
                                        var FMD_CA_ID       = document.getElementById("CA_ID<%=no%>").value;
                                        var FMD_ID          = document.getElementById("FMD_ID<%=no%>").value;
                                        var FMD_Value       = document.getElementById("FMD_Value<%=no%>").value;
                                        var FM_JenisKoreksi = document.getElementById("FM_JenisKoreksi<%=no%>").value;
                                        $.ajax({
                                            type: "get",
                                            url: "del-GLMFiskalD.asp",
                                            data:{
                                                FMD_ID,
                                                FMD_CA_ID,
                                                FMD_Value,
                                                FM_JenisKoreksi
                                            },
                                            success: function (data) {
                                                $('.rincian-acc-komponen').html(data);
                                            }
                                        });
                                    }
                                </script>
                            <% GLMFiskalD.movenext
                            loop %>
                        </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>
        function AddKomponen(){
            var FM_Nama             = document.getElementById("FM_Nama").value;
            var FM_JenisKoreksi     = document.getElementById("FM_JenisKoreksi").value;
            var FM_SaldoAwalYN      = document.getElementById("FM_SaldoAwalYN").value;
            $.ajax({
                type: "POST",
                url: "add-GLMFiskalH.asp",
                data:{
                    FM_Nama,
                    FM_JenisKoreksi,
                    FM_SaldoAwalYN
                },
                success: function (data) {
                    $('.cont-rincian-acc').show();
                    $('.komponenkoreksi').html(data);
                }
            });
        }
        function getAccountName(){
            var CAID    = document.getElementById("CA_ID").value;
            var CANAME    = document.getElementById("CA_Name").value;
            $.ajax({
                type: "get",
                url: "get-AccountID.asp",
                data:{
                    CAID,
                    CANAME
                },
                success: function (data) {
                    $('.cont-account').html(data);
                }
            });
        }
    </script>
</html>