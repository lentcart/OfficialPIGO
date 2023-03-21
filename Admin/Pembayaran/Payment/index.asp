<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    set PaymentRequest_cmd = server.createObject("ADODB.COMMAND")
	PaymentRequest_cmd.activeConnection = MM_PIGO_String

        PaymentRequest_cmd.commandText = "SELECT MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prTanggalInv FROM MKT_T_PaymentRequest_D RIGHT OUTER JOIN  MKT_T_PaymentRequest_H ON MKT_T_PaymentRequest_D.prID_H = MKT_T_PaymentRequest_H.prID WHERE MKT_T_PaymentRequest_H.pr_custID = '"& request.Cookies("custID") &"'  GROUP BY MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prTanggalInv"
        'response.write PaymentRequest_cmd.commandText

    set PaymentRequest = PaymentRequest_cmd.execute

    set Rekening_cmd = server.createObject("ADODB.COMMAND")
	Rekening_cmd.activeConnection = MM_PIGO_String

        Rekening_cmd.commandText = "SELECT MKT_M_Rekening.rkID, GLB_M_Bank.BankName, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, MKT_M_Rekening.rkJenis, MKT_M_Rekening.rk_custID FROM GLB_M_Bank RIGHT OUTER JOIN MKT_M_Rekening ON GLB_M_Bank.BankID = MKT_M_Rekening.rkBankID Where rkJenis = 'Rekening Seller' AND rk_custID = 'C0322000000002' "
        'response.write Rekening_cmd.commandText

    set Rekening = Rekening_cmd.execute

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
            function getBussinesPartner(){
                var Bussines = $('input[name=keysearch]').val();            
                $.ajax({
                    type: "get",
                    url: "get-bussinespart.asp?keysearch="+Bussines,
                    success: function (url) {
                    // console.log(url);
                    $('.cont-BussinesPart').html(url);
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
                    <div class="col-lg-9 col-md-9 col-sm-12">
                        <span class="cont-text"> PAYMENT </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button class="cont-btn" onclick="Refresh()" style="font-size:12px"><i class="fas fa-sync-alt"></i></button>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button class="cont-btn" onclick="window.open('../PaymentDetail/','_Self')" style="font-size:12px"> PAYMENT DETAIL</button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row align-items-center">
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <span class="cont-text"> Type Payment </span><br>
                        <select  class="cont-form" name="typepayment" id="cont" aria-label="Default select example">
                            <option value="">Pilih</option>
                            <option value="01"> Invoice-AP </option>
                            <option value="02"> Invoice-AR </option>
                        </select>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <span class="cont-text"> Bank Account  </span><br>
                        <select  class="cont-form" name="namabank" id="cont" aria-label="Default select example">
                            <option selected>Pilih</option>
                            <% do while not Rekening.eof %>
                            <option value="<%=Rekening("rkID")%>"> <%=Rekening("BankName")%>&nbsp;&nbsp;[ <%=Rekening("rkNamaPemilik")%> ] </option>
                            <% Rekening.movenext
                            loop %>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <span class="cont-text"> Jenis Pembayaran </span><br>
                        <select  class="cont-form" name="jenispayment" id="cont" aria-label="Default select example">
                            <option value="">Pilih</option>
                            <option value="01"> Transfer </option>
                            <option value="02"> Cash </option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <span class="cont-text"> Tanggal Pembayaran </span><br>
                        <input type="Date" class="cont-form" name="tglpayment" id="cont" value="" ><br>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <span class="cont-text"> Deskripsi </span><br>
                        <input type="text" class=" mb-2 cont-form" name="desc" id="cont" value="Pembayaran : " style="padding:8px 5px" ><br>
                    </div>
                </div>
                <div class="row mt-1 mb-1 text-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="cont-label-text">
                            <span class="cont-text "> Business Partner </span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <span class="cont-text"> Kata Kunci </span><br>
                        <input required  onkeyup="getBussinesPartner()" type="text" class=" mb-1 cont-form" name="keysearch" id="cont" value=""><br>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-12 cont-BussinesPart">

                    </div>
                </div>
                <div class="cont-bussines">
                    <div class="row">
                        <div class="col-lg-2 col-md-4 col-sm-12">
                            <span class="cont-text">  Bussines Partner ID </span><br>
                            <input readonly type="text" class=" mb-2 cont-form" name="supplierid" id="supplierid" value=""  ><br>
                        </div>
                        <div class="col-lg-4 col-md-8 col-sm-12">
                            <span class="cont-text">  Nama Bussines Partner </span><br>
                            <input readonly type="text" class=" mb-2 cont-form" name="supplierid" id="supplierid" value=""  ><br>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-12">
                            <span class="cont-text"> PaymentTerm </span><br>
                            <input readonly type="text" class="text-center mb-2 cont-form" name="poterm" id="poterm" value="" ><br>
                        </div>
                        <div class="col-lg-4 col-md-8 col-sm-12">
                            <span class="cont-text"> Nama CP BussinesPartner </span><br>
                            <input readonly type="text" class=" mb-2 cont-form" name="namacp" id="namacp" value=""><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-12 col-sm-12">
                            <span class="cont-text"> Lokasi BussinesPartner </span><br>
                            <input readonly type="text" class=" mb-2 cont-form" name="lokasi" id="lokasi" value=""><br>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-12">
                            <span class="cont-text"> BANK </span><br>
                            <input readonly type="text" class="text-center mb-2 cont-form" name="poterm" id="poterm" value="" ><br>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-12">
                            <span class="cont-text"> No Rekening </span><br>
                            <input readonly type="text" class=" mb-2 cont-form" name="namacp" id="namacp" value="" ><br>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-12">
                            <span class="cont-text"> Nama Pemilik Rek </span><br>
                            <input readonly type="text" class=" mb-2 cont-form" name="namacp" id="namacp" value=""><br>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 mb-2">
                    <div class="col-12">
                        <button onclick="return AddBussinesPart()"name="btn-pay" id="btn-pay" class="cont-btn" style="display:block"><i class="fas fa-folder-plus"></i>&nbsp;&nbsp;Generate No Invoice</button>
                        <button onclick="batal()" name="btn-batal" id="btn-batal" class="cont-btn" style="display:none"><i class="fas fa-ban"></i>&nbsp;&nbsp; Batalkan Proses Payment </button>
                    </div>
                </div>
                <div class="cont-invoice" id="cont-invoice" style="display:none">
                        
                </div>
                <div class="data-payment">

                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>  
    <script>
    function getBussines(){
            var s = document.getElementById("bussinespartner").value;
            $.ajax({
                type: "get",
                url: "get-Bussines.asp?bussines="+s,
                success: function (url) {
                // console.log(url);
                $('.cont-Bussines').html(url);
                                    
                }
            });
        }

        function AddBussinesPart() {
            var payBank	        = $('select[name=namabank]').val();
            var payType	        = $('select[name=typepayment]').val();
            var payTanggal	    = $('input[name=tglpayment]').val();
            var payJenis        = $('select[name=jenispayment]').val();
            var payDesc	        = $('input[name=desc]').val();
            var pay_custID	    = $('input[name=pay_custID]').val();
            var pay_rkID        = $('input[name=pay_rkID]').val();
            var payNoRek        = $('input[name=payNoRek]').val();
            var payBank         = $('input[name=payBank]').val();
            if ( payBank == "" , payType == "", payTanggal == "" , payJenis == "" , payDesc == "", pay_custID == ""){
                alert("Masih Ada Field Kosong !")
            }else{
                $.ajax({
                    type: "GET",
                    url: "add-payment.asp",
                    data:{
                        payBank,
                        payType,
                        payTanggal,
                        payJenis,
                        payDesc,
                        pay_custID,
                        pay_rkID,
                        payNoRek,
                        payBank
                    },
                    success: function (data) {
                        console.log(data);
                        
                        $('.cont-invoice').html(data);
                        }
                    });
                // document.getElementById("cont-Produk-PO").style.display = "block";
                document.getElementById("cont-invoice").style.display = "block";
                document.getElementById("btn-pay").style.display = "none";
                document.getElementById("btn-batal").style.display = "block";
                $('#bussinespartner').attr('disabled',true);
                document.querySelectorAll("[id^=cont]");
                var permintaan = document.querySelectorAll("[id^=cont]");
                
                for (let i = 0; i < permintaan.length; i++) {
                    permintaan[i].setAttribute("readonly", true);
                    permintaan[i].setAttribute("disabled", true);
                }
            }
        }

        function batal() {
        var payID = $('input[name=payID]').val();
        $.ajax({
            type: "POST",
            url: "delete-payment.asp",
                data:{
                    payID
                },
            success: function (data) {
                Swal.fire('Data Berhasil Dihapus')
                location.reload();
            }
            });
        document.getElementById("cont-invoice").style.display = "none";
        document.getElementById("btn-pay").style.display = "block";
        document.getElementById("btn-batal").style.display = "none";
        $('#bussinespartner').removeAttr('disabled');
        $('#bussinespartner').val('');
        
        var permintaan = document.querySelectorAll("[id^=cont]");
        
        for (let i = 0; i < permintaan.length; i++) {
            permintaan[i].removeAttribute("readonly");
            permintaan[i].removeAttribute("disabled");
            permintaan[i].value = "";
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