<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../admin/")
    
    end if
    
    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String

        Supplier_cmd.commandText = "SELECT * FROM MKT_M_BussinesPartner WHERE bpAktifYN = 'Y' "
        'response.write Supplier_cmd.commandText

    set Supplier = Supplier_cmd.execute

    set KeySupplier_cmd = server.createObject("ADODB.COMMAND")
	KeySupplier_cmd.activeConnection = MM_PIGO_String

        KeySupplier_cmd.commandText = "SELECT bpNama1 FROM MKT_M_BussinesPartner WHERE bpAktifYN = 'Y' "
        'response.write KeySupplier_cmd.commandText

    set KeySupplier = KeySupplier_cmd.execute

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText = "SELECT poID FROM MKT_T_PurchaseOrder_H WHERE poAktifYN = 'Y' group by poID "
        'response.write PurchaseOrder_cmd.commandText

    set PurchaseOrder = PurchaseOrder_cmd.execute
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
        function getbussinespart(){
            var Bussines = $('input[name=keysearch]').val();            
            $.ajax({
                type: "get",
                url: "get-bussinespart.asp?keysearch="+Bussines,
                success: function (url) {
                // console.log(url);
                $('.cont-bussinespart').html(url);
                }
            });
        }
        

        $('#keysearch').on("change",function(){
            let keysp = $('#keysearch').val();
        });

        function getKeySupplier(){
            $.ajax({
                type: "get",
                url: "getKeySupplier.asp?keysearch="+document.getElementById("keysearch").value,
                success: function (url) {
                // console.log(url);
                $('.keysp').html(url);
                                    
                }
            });
        }
        function getsupplier(){
            $.ajax({
                type: "get",
                url: "loadsupplier.asp?keysupplier="+document.getElementById("keysupplier").value,
                success: function (url) {
                // console.log(url);
                $('.datasp').html(url);
                                    
                }
            });
        }
        function getpo(){
            $.ajax({
                type: "get",
                url: "get-purchaseorder.asp?poID="+document.getElementById("poID").value,
                success: function (url) {
                // console.log(url);
                $('.datapo').html(url);
                                    
                }
            });
        }
    </script>
    <style>
        #loader-page {
        width: 100%;
        height:  100%;
        position: fixed;
        background-color:rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        z-index: 9999;
        top:0px;
        }

        #loader {
            width: 42px;
            height: 42px;
            border-right: 5px solid #10a5d3;
            border-left: 5px solid rgba(150, 169, 169, 0.32);
            border-top: 5px solid rgba(169, 169, 169, 0.32);
            border-bottom: 5px solid rgba(169, 169, 169, 0.32);
            border-radius: 50%;
            opacity: .6;
            animation: spin 1s linear infinite;
        }
        .cont-loader{
            background-color:#10a5d3;
            width:10%;
            border-radius:20px;
            color:white;
            font-size:15px;
            font-weight:bold;
            margin-top : 10px;

        }

        @keyframes spin {
        
            0% {
                transform: rotate(0deg);
            }
            
            100% {
                transform: rotate(360deg);
            }
            
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
                        <span class="cont-text"> MATERIAL RECEIPT BARU </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button class="cont-btn" style="font-size:11px" onclick="window.open('../MaterialReceiptDetail/','_Self')"> Material Receipt Detail <i class="fas fa-arrow-from-left"></i> </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <span class="cont-text"> Tanggal  </span><br>
                        <input type="Date" class=" text-center cont-form" name="tanggalmm" id="cont" value="" ><br>
                    </div>
                </div>
                <div class="row mt-2 mb-1 text-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="cont-label-text">
                            <span class="cont-text"> Bussines Partner </span>
                        </div>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <span class="cont-text"> Kata Kunci </span><br>
                        <input onkeyup="getbussinespart()" required type="text" class="  cont-form" name="keysearch" id="cont" value=""><br>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-12 cont-bussinespart">
                    <span class="cont-text">  </span><br>
                        <select onchange="return getbussines()"  class=" cont-form" name="bussines" id="bussines" aria-label="Default select example" required>
                            <option value="">Pilih Bussines Partner</option>
                            <option value=""></option>
                        </select>
                    </div>
                </div>

                <div class="cont-bussines">
                    <div class="row mt-1">
                        <div class="col-lg-2 col-md-3 col-sm-12">
                            <span class="cont-text">  Supplier ID </span><br>
                            <input required type="text" class="cont-form" name="supplierid" id="supplierid" value="" ><br>
                        </div>
                        <div class="col-lg-4 col-md-3 col-sm-12">
                            <span class="cont-text"> Nama Supplier </span><br>
                            <input required type="text" class="cont-form" name="namasupplier" id="namasupplier" value="" ><br>
                        </div>
                        <div class="col-lg-2 col-md-3 col-sm-6">
                            <span class="cont-text"> Pay-Term </span><br>
                            <input required type="text" class="cont-form" name="poterm" id="poterm" value="" ><br>
                        </div>
                        <div class="col-lg-4 col-md-3 col-sm-6">
                            <span class="cont-text"> Nama CP Supplier </span><br>
                            <input required type="text" class="cont-form" name="namacp" id="namacp" value=""><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <span class="cont-text"> Lokasi Supplier </span><br>
                            <input required type="text" class="cont-form" name="lokasi" id="lokasi" value="" ><br>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6">
                            <span class="cont-text"> Phone </span><br>
                            <input required type="text" class="cont-form" name="phone" id="phone" value="" ><br>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6">
                            <span class="cont-text"> Email </span><br>
                            <input required type="text" class="cont-form" name="email" id="email" value="" ><br>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6">
                            <span class="cont-text"> NPWP </span><br>
                            <input required type="text" class="cont-form" name="npwp" id="npwp" value="" ><br>
                        </div>
                    </div>
                </div>

                <div class="row mt-2 mb-2">
                    <div class="col-lg-2 col-md-4 col-sm-6 data-mmID">
                        <button onclick="AddBussinesPart()" name="btn-add" id="btn-add" class="cont-btn" style="display:block"><i class="fas fa-folder-plus"></i>&nbsp;&nbsp; Tambah Produk </button>
                    </div>
                </div>

                <div class="datapo mt-2">
                </div>

            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>
        function AddBussinesPart() {
        var mmTanggal = $('input[name=tanggalmm]').val();
        var mmType = $('select[name=typemm]').val();
        var mmMoveDate = $('input[name=movedatemm]').val();
        var mmAccDate = $('input[name=accdatemm]').val();
        var mm_spID = $('input[name=supplierid]').val();
        $.ajax({
            type: "GET",
            url: "add-materialreceipt.asp",
            data:{
                mmTanggal,
                mmType,
                mmMoveDate,
                mmAccDate,
                mm_spID
            },
            success: function (data) {
                $('.data-mmID').html(data);
                }
            });
        // document.getElementById("cont-Produk-PO").style.display = "block";
        document.getElementById("btn-add").style.display = "none";
        $('#bussinespartner').attr('disabled',true);
        document.querySelectorAll("[id^=cont]");
        var permintaan = document.querySelectorAll("[id^=cont]");
        
        for (let i = 0; i < permintaan.length; i++) {
            permintaan[i].setAttribute("readonly", true);
            permintaan[i].setAttribute("disabled", true);
        }
        }
        function batal() {
            var mmID = $('input[name=mmID]').val();
            $.ajax({
                type: "POST",
                url: "delete-materialreceipt.asp",
                    data:{
                        mmID
                    },
                success: function (data) {
                    Swal.fire('Deleted !!', data.message, 'success').then(() => {
                    location.reload();
                    });
                }
            });
            // document.getElementById("cont-Produk-PO").style.display = "none";
            $('#bussinespartner').removeAttr('disabled');
            $('#bussinespartner').val('');
            var permintaan = document.querySelectorAll("[id^=cont]");
            
            for (let i = 0; i < permintaan.length; i++) {
                permintaan[i].removeAttribute("readonly");
                permintaan[i].removeAttribute("disabled");
                permintaan[i].value="";
            }
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
    </script>
</html>