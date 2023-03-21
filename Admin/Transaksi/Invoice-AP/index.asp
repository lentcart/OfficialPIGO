<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../admin/")
    
    end if
    
    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING
    InvoiceVendor_CMD.commandText = "SELECT MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Desc, MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_T_InvoiceVendor_H.InvAP_Faktur, MKT_T_InvoiceVendor_H.InvAP_TglFaktur,  MKT_T_InvoiceVendor_H.InvAP_GrandTotal, MKT_T_InvoiceVendor_H.InvAP_prYN FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_M_Customer.custID = MKT_T_InvoiceVendor_H.InvAP_custID"
    set InvoiceVendor = InvoiceVendor_CMD.execute
%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!--#include file="../../IconPIGO.asp"-->

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    
    </head>
    <script>
        function listinvoice(){
            document.getElementById("cont-listinvoice").style.display = "block";
            document.getElementById("cont-addinvoice").style.display = "none";
        }
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
    </script>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <span class="cont-text"> INVOICE (VENDOR) </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12 text-end">
                        <button onclick="Refresh()" class="cont-btn" > <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12 text-end">
                        <button onclick="window.open('List-InvoiceVendor.asp','_Self')" class="cont-btn" > List Invoice </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="cont-addinvoice" id="cont-addinvoice" style="display:block">
                    <div class="data-po mt-2">
                        <div class="cont-InvoiceVendor ">
                            <div class="row">
                                <div class="col-lg-2 col-md-6 col-sm-12">
                                    <span class="cont-text"> Tanggal Invoice </span><br>
                                    <input type="date" class="InvAP_Tanggal text-center cont-form" name="InvAP_Tanggal" id="cont" value="" >
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12">
                                    <span class="cont-text"> No Surat Jalan / Faktur Vendor </span><br>
                                    <input type="text" class="InvAP_Faktur text-center cont-form" name="InvAP_Faktur" id="cont" value="">
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-12">
                                    <span class="cont-text"> Tanggal Faktur </span><br>
                                    <input type="Date" class="InvAP_TglFaktur text-center cont-form" name="InvAP_TglFaktur" id="cont" value="">
                                </div>
                            </div>
                            <div class="row align-items-center mt-2">
                                <div class="col-lg-2 col-md-2 col-sm-2">
                                    <span class="cont-text"> Deksripsi </span>
                                </div>
                                <div class="col-lg-10 col-md-10 col-sm-10">
                                    <input type="text" class="InvAP_Desc cont-form" name="InvAP_Desc" id="cont" value="" style="height:3rem">
                                </div>
                            </div>
                            <div class="row mt-1">
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <span class="cont-text"> Kata Kunci </span><br>
                                    <input onkeyup="getbussinespart()" required type="text" class="  cont-form" name="keysearch" id="cont" value=""><br>
                                </div>
                                <div class="col-lg-4 col-md-8 col-sm-8 cont-bussinespart">
                                <span class="cont-text">  </span><br>
                                    <select disabled class=" cont-form" name="bussines" id="bussines" aria-label="Default select example" required>
                                        <option value="">Pilih Bussines Partner</option>
                                    </select>
                                </div>
                            </div>
                            <div class="cont-bussines">
                                <div class="row mt-1">
                                    <div class="col-lg-2 col-md-4 col-sm-4">
                                        <span class="cont-text">  Supplier ID </span><br>
                                        <input readonly type="text" class=" InvAP_custID cont-form" name="InvAP_custID" id="cont" value="" ><br>
                                    </div>
                                    <div class="col-lg-4 col-md-8 col-sm-8">
                                        <span class="cont-text"> Nama Supplier </span><br>
                                        <input readonly type="text" class="  cont-form" name="namasupplier" id="namasupplier" value="" ><br>
                                    </div>
                                    <div class="col-lg-2 col-md-4 col-sm-4">
                                        <span class="cont-text"> Pay-Term </span><br>
                                        <input readonly type="text" class="  cont-form" name="poterm" id="poterm" value="" ><br>
                                    </div>
                                    <div class="col-lg-4 col-md-8 col-sm-8">
                                        <span class="cont-text"> Nama CP Supplier </span><br>
                                        <input readonly type="text" class="  cont-form" name="namacp" id="namacp" value=""><br>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6 col-md-12 col-sm-12">
                                        <span class="cont-text"> Lokasi Supplier </span><br>
                                        <input readonly type="text" class="  cont-form" name="lokasi" id="lokasi" value="" ><br>
                                    </div>
                                    <div class="col-lg-2 col-md-4 col-sm-4">
                                        <span class="cont-text"> Phone </span><br>
                                        <input readonly type="text" class="  cont-form" name="phone" id="phone" value="" ><br>
                                    </div>
                                    <div class="col-lg-2 col-md-4 col-sm-4">
                                        <span class="cont-text"> Email </span><br>
                                        <input readonly type="text" class="  cont-form" name="email" id="email" value="" ><br>
                                    </div>
                                    <div class="col-lg-2 col-md-4 col-sm-4">
                                        <span class="cont-text"> NPWP </span><br>
                                        <input readonly type="text" class="  cont-form" name="npwp" id="npwp" value="" ><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cont-InvoiceHeader" id="cont-InvoiceHeader">
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>
        function addInvoiceH() {
            var InvAP_Tanggal       = $('input[name=InvAP_Tanggal]').val();
            var InvAP_Faktur        = $('input[name=InvAP_Faktur]').val();
            var InvAP_TglFaktur     = $('input[name=InvAP_TglFaktur]').val();
            var InvAP_Desc          = $('input[name=InvAP_Desc]').val();
            var InvAP_custID        = $('input[name=InvAP_custID]').val();
            var InvAP_LineFrom      = $('input[name=InvAP_LineFrom]').val();
            var flag                = $('input[name=flag]').val();
            if (InvAP_Tanggal == "" ){
                $('.InvAP_Tanggal').focus();
            }else if (InvAP_Faktur == ""){
                $('.InvAP_Faktur').focus();
            }else if ( InvAP_TglFaktur == "" ){
                $('.InvAP_TglFaktur').focus();
            }else if (InvAP_Desc == ""){
                $('.InvAP_Desc').focus();
            }else if (InvAP_custID == "" ){
                $('.InvAP_custID').focus();
            }else{
                $.ajax({
                    type: "GET",
                    url: "add-InvoiceH.asp",
                    data:{
                        InvAP_Tanggal,
                        InvAP_Faktur,
                        InvAP_TglFaktur,
                        InvAP_Desc,
                        InvAP_custID,
                        InvAP_LineFrom,
                        flag
                    },
                    success: function (data) {
                        $('.cont-InvoiceHeader').html(data);
                    }
                });
                document.getElementById("add").style.display = "none"
                document.getElementById("batal").style.display = "block"
                $('#bussinespartner').attr('disabled',true);
                $('#bussinespartner').attr('disabled',true);
                var invoice = document.querySelectorAll("[id^=cont]");
                for (let i = 0; i < invoice.length; i++) {
                    invoice[i].setAttribute("readonly", true);
                    invoice[i].setAttribute("disabled", true);
                }
            }
        }

        function batal() {
        var InvAPID = $('input[name=InvAPID]').val();
        console.log(InvAPID);
        $.ajax({
            type: "GET",
            url: "delete-InvoiceH.asp",
                data:{
                    InvAPID
                },
            success: function (data) {
                Swal.fire('Data Berhasil Di Hapus !', data.message, 'success').then(() => {
                location.reload();
                });
            }
        });
    }
    function getPO() {
        var InvAP_poID           = $('select[name=listpo]').val();
        // var InvAP_Keterangan    = $('input[name=InvAP_Keterangan]').val();
        $.ajax({
            type: "GET",
            url: "get-purchaseorder.asp",
            data:{
                InvAP_poID
            },
            success: function (data) {
                $('.cont-Lines').html(data);
            }
        });
    }
    function getMM() {
        var InvAP_mmID           = $('select[name=listmm]').val();
        // var InvAP_Keterangan    = $('input[name=InvAP_Keterangan]').val();
        $.ajax({
            type: "GET",
            url: "get-materialreceipt.asp",
            data:{
                InvAP_mmID
            },
            success: function (data) {
                $('.cont-Lines').html(data);
            }
        });
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
</html>