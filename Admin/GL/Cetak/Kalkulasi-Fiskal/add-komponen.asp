<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../../admin/")
    
    end if

    FMID        = request.queryString("FMID")

    if FMID <> "" then

    else
        JK          = request.queryString("JK")
    end if 
    

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
        .cont-rincian-acc{
            display:none
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
                    if JK = "N" then
                        JK = "NEGATIF"
                        FM_JenisKoreksi = "N"
                    else if JK = "P" then
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
                        <input type="text" class="cont-form" name="FM_Nama" id="FM_Nama" value="" placeholder="Masukan Keterangan Komponen">
                        <input type="hidden" class="cont-form" name="FM_JenisKoreksi" id="FM_JenisKoreksi" value="<%=FM_JenisKoreksi%>">
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4">
                        <span class="cont-text"> DENGAN SALDO AWAL </span> <br>
                        <select class="cont-form" name="FM_SaldoAwalYN" id="FM_SaldoAwalYN" aria-label="Default select example">
                            <option value="">PILIH</option>
                            <option value="Y">YA</option>
                            <option value="N">TIDAK</option>
                        </select>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <button onclick="AddKomponen()" class="cont-btn"> TAMBAH RINCIAN ACCOUNT </button>
                    </div>
                </div>
                <hr>
                
                <div class="cont-rincian-acc" id="cont-rincian-acc">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 komponenkoreksi" id="komponenkoreksi">

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