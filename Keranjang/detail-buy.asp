<!--#include file="../connections/pigoConn.asp"--> 

<%
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    custid = request.queryString("custID")
    pdID = request.queryString("pdID")

    set tr_cmd = server.createObject("ADODB.COMMAND")
	tr_cmd.activeConnection = MM_PIGO_String

	tr_cmd.commandText = "SELECT * FROM MKT_T_Keranjang_H where cart_custID ='"& custid &"' "
    'response.write tr_cmd.commandText
    set tr = tr_cmd.execute

%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="detail-cart.css">

        <title>PIGO</title>
        <script>
        function findTotal(){
            var qty = parseInt(document.getElementById('qty').value);
            var harga = parseInt(document.getElementById('harga').value);
            var total=qty*harga;
            
            document.getElementById('subtotal').value = total;
            document.getElementById('total').value = total;
            // console.log(total);
            };
            document.addEventListener("DOMContentLoaded", function(event) {
                findTotal();
                });
        </script>
    </head>
<body>
    <div class="header">
        <div class="container">
            <div class="row align-items-center mt-2">
                <div class="col-12 align-items-center">
                    <img src="../assets/logo1.jpg" class="rounded-pill me-4" alt="" width="65" height="65" />
                    <span class="judul-hd">PEMBAYARAN</span>
                </div>
            </div>
        </div>
    </div>

    <div class="container" style="margin-top:5.5rem; ">
        <form name="transaksi" action=""  method="post">
            <div class="row">
                <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                    <!--Produk-->
                    <div class="row">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-7">
                            <div class="judul-kategori mt-1 mb-1" style=" background-color:white; padding:10px; border-radius:10px;border:4px solid #ececec">
                                <div class="row align-items-center mt-2 mb-2">
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-6">
                                        
                                    </div>
                                </div>
                        </div>
                    </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-7">
                            <div class="judul-kategori  mt-3 mb-4 ">
                                <span>Metode Pembayaran</span>
                            </div>
                            <div class="judul-kategori mt-3 mb-3" style=" background-color:white; padding:10px; border-radius:10px;border:4px solid #ececec">
                                <div class="judul-kategori  mt-3 mb-4 ">
                                    <div class="accordion" id="accordionExample" >
                                        <div class="">
                                            <h2 class="accordion-header" id="heading1">
                                                <div class="row">
                                                    <div class="col-lg-0 col-md-0 col-sm-0 col-1">
                                                        <input type="radio" id="html" name="fav_language" value="HTML" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">
                                                    </div>
                                                    <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                                                        <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">Transfer Virtual Account </button>
                                                    </div>
                                                </div>
                                            </h2>
                                        <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="heading1" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <select class="form-select form-select-sm" aria-label=".form-select-sm example">
                                                <option value="1">BCA</option>
                                                <option value="2">Mandiri</option>
                                                <option value="3">BNI</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                        <!--Produk-->

                        <!--CheckOut-->
                        <div class="col-lg-0 col-md-0 col-sm-0 col-5 mt-4 align-items-center ">
                            <span> Ringkasan Belanja </span>
                            <div class="judul-kategori align-items-center mt-3" style="padding:15px; 15px; background-color:white; border-radius:20px;border:4px solid #ececec">
                                <div class="row">
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-6 ">
                                        <span> Total Harga </span><br>
                                        <span> Ongkos Kirim </span><br>
                                        <span> Total Diskon </span> <br>
                                        <span> Biaya Layanan </span> <br>
                                        <span> Asuransi Pengiriman </span>
                                    </div>
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-1 me-2">
                                        <span>Rp. </span><br>
                                        <span>Rp. </span><br>
                                        <span>Rp. </span><br>
                                        <span>Rp. </span><br>
                                        <span>Rp. </span>
                                    </div>
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                                        <input readonly  onblur="findTotal()" style="width:6rem; text-align:right; border:none" type="number" name="total" id="total" value="0"><br>
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="ongkir" id="ongkir" value="0">
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="diskon" id="diskon" value="0">
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="layanan" id="layanan" value="0">
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="asuransi" id="asuransi" value="0">
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-6 ">
                                        <span> Total Pembayaran </span><br>
                                    </div>
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-1 me-2">
                                        <span>Rp. </span><br>
                                    </div>
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="subtotal" id="subtotal" value="0"><br>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-12 mt-4 ">
                                        <span> Dengan mengklik tombol <b>Bayar Sekarang</b>, kamu menyetujui Syarat  dan Ketentuan yang berlaku </span><br>
                                <button type="button" class="btn-pembayaran mt-4 text-center"> Bayar Sekarang </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--CheckOut-->
                    </div>
                </div>
            </div>
        </form>
    </div>
    <!-- The Modal -->
<div id="modalalamat" class="modal-alamat">
    <div class="modal-content-alamat">
        <div class="modal-header-alamat">
            <span class="close-alamat">&times;</span><br>
                <h5 class="text-judul">Alamat Saya</h5>
        </div>
        <div class="modal-body">
            <div id="container-alamat">
                <div id="overflow-alamat">
                    <form class="d-flex ms-auto ">
                        <input class="form-control me-1 " style="width:45rem" type="search" placeholder="Cari Alamat" aria-label="Search" >
                        <button class="btn btn-light" type="submit"><i class="fas fa-search"></i></button>
                    </form>
                    <button type="button" class="btn-tambahalamat mt-3 mb-3 " id="myBtn">Tambah Alamat</button>
                    <div class="judul-kategori" >
                            <div class="col-lg-0 col-md-0 col-sm-0 col-12 mb-2">
                                <div class="container" style=" padding:5px 5px; background-color:white; border-radius:20px;border:5px solid #ececec;"> 
                                    <span><%=alamat("almNamaPenerima")%>,[<b><%=alamat("almPhonePenerima")%></b>]</span><br>
                                    <span ><%=alamat("almPhonePenerima")%></span><br>
                                    <span ><%=alamat("almLengkap")%></span><br>
                                    <span ><%=alamat("almProvinsi")%>,<%=alamat("almKota")%>,<%=alamat("almKec")%>,<%=alamat("almKel")%>,</span>
                                    <span ><strong><%=alamat("almKdPos")%></strong></span>
                                </div>
                        </div>
                    </div>
                </div>
                </div>
            </div>
        </div>  
    </div>
</div>

</body>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../js/bootstrap.js"></script>
    <script src="../js/popper.min.js"></script>
    <script> 
    // Get the modal
var modal = document.getElementById("modalalamat");

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close-alamat")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>
</html>