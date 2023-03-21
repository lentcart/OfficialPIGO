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
        .cont-account-id{
            background-color:white;
            height:6rem;
            overflow:scroll;
            overflow-x:hidden;
        }
        .tb-account-id{
            border:1px solid black;
        }
        .cont-background{
            margin-left:20rem;
            margin-right:20rem;
            margin-top:5rem;
            padding:20px 20px;
        }
    </style>
    </head>
    <!--#include file="../../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../../sidebar.asp"-->
        <div id="content">
            <form class="" action="print.asp" method="post">
            <div class="cont-background ">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row text-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <span class="cont-judul">  CETAK BUKU BESAR </span>
                    </div>
                </div>
                <div class="row text-center mt-2 mb-2">
                    <div class="col-6">
                        <span class="cont-text"> BULAN </span> <br>
                        <input class="text-center cont-form" type="text" name="Bulan" id="Bulan" value="" maxlength="12">
                    </div>
                    <div class="col-6">
                        <span class="cont-text"> TAHUN </span> <br>
                        <input class="text-center cont-form" type="text" name="Tahun" id="Tahun" value="<%=year(CDate(NOW()))%>">
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <span class="cont-text"> PILIHAN </span> <br>
                    </div>
                </div>
                <div class="row text-center mt-1">
                    <div class="col-12">
                        <select  class="cont-form" name="typejr" id="typejr" aria-label="Default select example" required>
                            <option value=" "> PILIH </option>
                            <option value="H"> HEADER </option>
                            <option value="D"> DETAIL </option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2"  id="list-jurnal" style="display:block">
                <div class="row">
                    <div class="col-6">
                    <input type="submit" class="cont-btn" value="CETAK">
                    </div>
                    <div class="col-6">
                    <button class="cont-btn"> BATAL </button>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>
    <!--#include file="../../../ModalHome.asp"-->
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