<!--#include file="../connections/pigoConn.asp"--> 

<%
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    pdID = request.queryString("pdID")


    set alamat_cmd = server.createObject("ADODB.COMMAND")
	alamat_cmd.activeConnection = MM_PIGO_String

	alamat_cmd.commandText = "SELECT * From MKT_M_Alamat where alm_custID = '"& request.cookies("custID") &"' "
    'response.write alamat_cmd.commandText
    set alamat = alamat_cmd.execute

    set tr_cmd = server.createObject("ADODB.COMMAND")
	tr_cmd.activeConnection = MM_PIGO_String

	tr_cmd.commandText = "SELECT dbo.MKT_T_Transaksi_H.trQty, dbo.MKT_T_Transaksi_H.trTglTransaksi, dbo.MKT_M_Customer.custEmail, dbo.MKT_M_Produk.pdNama, dbo.MKT_M_Produk.pdType, dbo.MKT_M_Produk.pdHarga, dbo.MKT_M_Produk.pdImage1, dbo.MKT_M_Produk.pd_custID, dbo.MKT_M_Produk.pdID, dbo.MKT_M_Alamat.almID, dbo.MKT_M_Alamat.almNamaPenerima, dbo.MKT_M_Alamat.almPhonePenerima, dbo.MKT_M_Alamat.almLabel, dbo.MKT_M_Alamat.almProvinsi, dbo.MKT_M_Alamat.almKota, dbo.MKT_M_Alamat.almKec, dbo.MKT_M_Alamat.almKel, dbo.MKT_M_Alamat.almKdpos, dbo.MKT_M_Alamat.almLengkap, dbo.MKT_M_Alamat.almDetail, dbo.MKT_M_Alamat.alm_custID FROM dbo.MKT_M_Alamat LEFT OUTER JOIN dbo.MKT_M_Customer ON dbo.MKT_M_Alamat.alm_custID = dbo.MKT_M_Customer.custID LEFT OUTER JOIN dbo.MKT_T_Transaksi_H ON dbo.MKT_M_Customer.custID = dbo.MKT_T_Transaksi_H.tr_custID LEFT OUTER JOIN dbo.MKT_M_Produk ON dbo.MKT_T_Transaksi_H.tr_pdID = dbo.MKT_M_Produk.pdID where MKT_T_Transaksi_H.tr_custID = '"& request.cookies("custID") &"' "
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
        <link rel="stylesheet" type="text/css" href="transaksi.css">

        <title>PIGO</title>
    </head>
<body>
    <div class="header">
        <div class="container">
            <div class="row align-items-center mt-2">
                <div class="col-12 align-items-center">
                    <img src="../assets/logo1.jpg" class="rounded-pill me-4" alt="" width="65" height="65" />
                    <span class="judul me-4">PIGO </span>
                    <span class="judul-hd me-4">| </span>
                    <span class="judul-hd">Checkout</span>
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
                            <div class="judul-kategori  mt-3 mb-4 ">
                            <span>Alamat Pengiriman</span>
                                <table class="table table-p">
                                <tr>
                                    <th scope="row align-items-center"></th>
                                </tr>
                                <tr>
                                    <td><span><%=alamat("almNamaPenerima")%>,[<b><%=alamat("almPhonePenerima")%></b>]</span><br>
                                    <span ><%=alamat("almPhonePenerima")%></span><br>
                                    <span ><%=alamat("almLengkap")%></span><br>
                                    <span ><%=alamat("almProvinsi")%>,<%=alamat("almKota")%>,<%=alamat("almKec")%>,<%=alamat("almKel")%>,</span>
                                    <span ><strong><%=tr("almKdpos")%></strong></span>
                                    </td>
                                </tr>
                                </table>
                                <button type="button" class="btn-alm text-center"id="myBtn"> Pilih Alamat Lain </button>
                                    <button type="button" class="btn-alamatt text-center"> Kirim Ke Beberapa Alamat </button>
                                <div class="form-floating mt-3">
                                    <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea"></textarea>
                                    <label for="floatingTextarea">Catatan Alamat</label>
                                </div>
                            </div>

                            <span> Detail Pesanan </span>
                            <% do while not tr.eof %> 
                            <div class="judul-kategori mt-3 mb-3" style=" background-color:white; padding:10px; border-radius:10px;border:4px solid #ececec">
                                <div class="row align-items-center mt-3">
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                        <img src="data:image/png;base64,<%=tr("pdImage1")%>" style="height:100px;width:100px;" alt=""/>
                                    </div>
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                                        <span style="font-size:15px"><b><%=tr("pdNama")%></b></span><br>
                                        <span style="font-size:12px">Variasi Produk (Warna, Ukuran, Type)<%=tr("pdType")%></span><br>
                                        <span style="font-size:12px">Spesifikasi</span><br>
                                        <span style="font-size:12px">Total Barang : </span><br>
                                        <span style="color:#205f6b;font-size:15px"><b>Rp. <input style="color:#205f6b; font-size:15px width:9rem; border:none" type="number" name="harga" id="harga" value="<%=tr("pdHarga")%>"></b></span>
                                    </div>
                                </div>
                            </div>
                            <% tr.movenext
                            loop  %>

                            <div class="judul-kategori" style=" background-color:white; padding:10px; border-radius:10px;border:4px solid #ececec">
                            <span> Metode Pengiriman </span>
                                <div class="row align-items-center mt-2">
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                        <select class="form-select" aria-label="Default select example" style="border:none; width: 45rem;">
                                            <option value="1">
                                                <div class="row">
                                                    <div class="col-lg-0 col-md-0 col-sm-0 col-6">
                                                        <p> Standard </p><br>
                                                        <p> Waktu Pengiriman </p>
                                                    </div>
                                                    <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                                                        <span> Rp. 12.000 </span><br>
                                                    </div>
                                                </div>
                                            </option>

                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--Produk-->

                        <!--CheckOut-->
                        <div class="col-lg-0 col-md-0 col-sm-0 col-5 align-items-center ">
                            <div class="judul-kategori mb-3" style=" padding:5px; background-color:white; border-radius:20px;border:4px solid #ececec">
                            <div class="row  align-items-center">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                    <img src="../assets/logo/voucher.png" width="50" height="50">
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-8 ">
                                    <span> Pakai  Voucher / Kode Promo </span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-2 ">
                                    <img src="../assets/logo/next.png" width="35" height="35">
                                </div>
                            </div>
                            </div>
                            
                            <span> Ringkasan Belanja </span>
                            <div class="judul-kategori align-items-center mt-2" style="padding:15px; 15px; background-color:white; border-radius:20px;border:4px solid #ececec">
                                <div class="row">
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-6 ">
                                        <span> Total Harga </span><br>
                                        <span> Ongkos Kirim </span><br>
                                        <span> Total Diskon </span> <br>
                                        <span> Asuransi Pengiriman </span>
                                    </div>
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-1 me-2">
                                        <span>Rp. </span><br>
                                        <span>Rp. </span><br>
                                        <span>Rp. </span><br>
                                        <span>Rp. </span>
                                    </div>
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="total" id="total" value="0"><br>
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="diskon" id="diskon" value="0">
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="diskon" id="diskon" value="0">
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="diskon" id="diskon" value="0">
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-6 ">
                                        <span> Total Tagihan </span><br>
                                    </div>
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-1 me-2">
                                        <span>Rp. </span><br>
                                    </div>
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                                        <input readonly style="width:6rem; text-align:right; border:none" type="number" name="total" id="total" value="0"><br>
                                    </div>
                                </div>
                            </div>
                                <button type="button" class="btn-pembayaran mt-4 text-center"> Pilih Pembayaran </button>
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
            <span class="close-alamat">&times;</span>
            <span class="text-judul text-center"> Pilih Alamat Pengiriman</span>
        </div>
        <div class="modal-body">
            <div id="container-alamat">
                <div id="overflow-alamat">
                 <hr>
                    <input class="form-alamat" type="search" placeholder="Tuliskan Alamat/Kota">
                    <div class="alm mb-4" style=" width:36.5rem; background-color:white; padding:10px 10px; border-radius:20px;border:4px solid #ececec">
                        <span> Nama Penerima [Label Alamat] </span><br>
                        <span> Nomor Telepon Penerima </span><br>
                        <span> Alamat Lengkap </span><br>
                        <span> (Detail/Patokan) Lengkap </span><br>
                        <span> Provinsi, Kota, Kecamatan, Kelurahan, Kd Pos </span>
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