<!--#include file="Connections/pigoConn.asp" -->

<% 
    produkID = request.Form("pdID")

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String
			
	produk_cmd.commandText = "SELECT pdStok FROM MKT_M_Produk where pdID = '"& produkID &"' "
    'response.write produk_cmd.commandText
	set produk = produk_cmd.execute

    set customer_cmd = server.createObject("ADODB.COMMAND")
	customer_cmd.activeConnection = MM_PIGO_String
			
	customer_cmd.commandText = "SELECT MKT_T_Keranjang.cart_custID, MKT_T_Keranjang.cart_pdID, MKT_T_Keranjang.cart_slID, MKT_T_Keranjang.cartQty, MKT_T_Keranjang.cartUpdateTime, MKT_T_Keranjang.cartAktifYN, MKT_M_Produk.pdID, MKT_M_Produk.pdStok FROM MKT_T_Keranjang RIGHT OUTER JOIN   MKT_M_Produk ON MKT_T_Keranjang.cart_pdID = MKT_M_Produk.pdID WHERE (MKT_T_Keranjang.cart_custID = '"& request.cookies("custID") &"' and MKT_M_Produk.pdID = '"& produkID &"' )"
    'response.write customer_cmd.commandText
	set customer = customer_cmd.execute

    set Gambar_cmd = server.createObject("ADODB.COMMAND")
	Gambar_cmd.activeConnection = MM_PIGO_String
			
	Gambar_cmd.commandText = "SELECT MKT_M_Produk.pdImage1, MKT_M_Produk.pdImage2, MKT_M_Produk.pdImage3, MKT_M_Produk.pdImage4, MKT_M_Produk.pdImage5, MKT_M_Produk.pdImage6, gambar.pdImage1 AS gambar1, gambar.pdImage2 AS gambar2, gambar.pdImage3 AS gambar3, gambar.pdImage4 AS gambar4, gambar.pdImage5 AS gambar5, gambar.pdImage6 AS gambar6 FROM MKT_M_Produk LEFT OUTER JOIN MKT_M_Produk AS gambar ON MKT_M_Produk.pdID = gambar.pdID where MKT_M_Produk.pdID = '"& produkID &"' " 
    
	set Gambar = Gambar_cmd.execute

    set review_cmd = server.createObject("ADODB.COMMAND")
	review_cmd.activeConnection = MM_PIGO_String
			
	review_cmd.commandText = " SELECT MKT_T_Reviews.trID, count(MKT_T_Reviews.tr_pdID) as a, MKT_T_Reviews.tr_pdID, MKT_T_Reviews.tr_pdHarga, MKT_T_Reviews.tr_custID, MKT_T_Reviews.tr_slID, MKT_T_Reviews.ReviewTanggal, MKT_T_Reviews.ReviewProduk, MKT_T_Reviews.RUpdateTime, MKT_T_Reviews.RAktifYN, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto FROM MKT_T_Reviews LEFT OUTER JOIN  MKT_M_Customer ON MKT_T_Reviews.tr_custID = MKT_M_Customer.custID  where MKT_T_Reviews.tr_pdID = '"& produkID &"' group by MKT_T_Reviews.trID, MKT_T_Reviews.tr_pdID, MKT_T_Reviews.tr_pdHarga, MKT_T_Reviews.tr_custID, MKT_T_Reviews.tr_slID, MKT_T_Reviews.ReviewTanggal, MKT_T_Reviews.ReviewProduk, MKT_T_Reviews.RUpdateTime, MKT_T_Reviews.RAktifYN, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto " 
    
	set review = review_cmd.execute

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String
			
	Seller_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_M_Seller.sl_custID, MKT_M_Customer.custEmail, MKT_M_Alamat.almProvinsi, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto, count(MKT_M_Produk.pdID) AS totalproduk FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN  MKT_M_Customer RIGHT OUTER JOIN  MKT_M_Produk ON MKT_M_Customer.custID = MKT_M_Produk.pd_custID ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where MKT_M_Produk.pdID = '"& produkID &"'  group by MKT_M_Seller.slName, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto,MKT_M_Alamat.almProvinsi,MKT_M_Seller.sl_custID  " 
	set Seller = Seller_cmd.execute


    set pdID_cmd = server.createObject("ADODB.COMMAND")
	pdID_cmd.activeConnection = MM_PIGO_String
			
	pdID_cmd.commandText = " SELECT dbo.MKT_M_Produk.pdID,dbo.MKT_M_Produk.pd_custID, dbo.MKT_M_Produk.pdNama, dbo.MKT_M_Produk.pd_catID, dbo.MKT_M_Kategori.catName, dbo.MKT_M_Produk.pd_custID,dbo.MKT_M_Merk.mrNama, dbo.MKT_M_Produk.pdType,  dbo.MKT_M_Produk.pdStok, dbo.MKT_M_Produk.pdSku, dbo.MKT_M_Produk.pdDesc1, dbo.MKT_M_Produk.pdDesc2, dbo.MKT_M_Produk.pdPanjang, dbo.MKT_M_Produk.pdLebar, dbo.MKT_M_Produk.pdTinggi, dbo.MKT_M_Produk.pdBerat, dbo.MKT_M_Produk.pdTglProduksi, dbo.MKT_M_Produk.pdExp, dbo.MKT_M_Produk.pdHargaJual, dbo.MKT_M_Produk.pdImage1, dbo.MKT_M_Produk.pdImage1 AS Gambar1, dbo.MKT_M_Produk.pdImage2, dbo.MKT_M_Produk.pdImage3, dbo.MKT_M_Produk.pdImage4, dbo.MKT_M_Produk.pdImage5, dbo.MKT_M_Produk.pdImage6, dbo.MKT_M_Produk.pdVideo, dbo.MKT_M_Produk.pdDangerousGoodsYN, dbo.MKT_M_Produk.pdBaruYN FROM dbo.MKT_M_Produk LEFT OUTER JOIN dbo.MKT_M_Merk ON dbo.MKT_M_Produk.pd_mrID = dbo.MKT_M_Merk.mrID LEFT OUTER JOIN dbo.MKT_M_Kategori ON dbo.MKT_M_Produk.pd_catID = dbo.MKT_M_Kategori.catID where pdID = '"& produkID &"' " 
	set pdID = pdID_cmd.execute

    set StokAkhir_cmd = server.createObject("ADODB.COMMAND")
	StokAkhir_cmd.activeConnection = MM_PIGO_String

    set pd_cmd = server.createObject("ADODB.COMMAND")
	pd_cmd.activeConnection = MM_PIGO_String
			
	pd_cmd.commandText = " SELECT * from MKT_M_Produk where pd_custID = '"& pdID("pd_custID") &"' " 
	set pd = pd_cmd.execute


    set ProdukTerjual_cmd = server.createObject("ADODB.COMMAND")
	ProdukTerjual_cmd.activeConnection = MM_PIGO_String

    ProdukTerjual_cmd.commandText = "SELECT COUNT(MKT_T_Transaksi_D1A.tr_pdQty) AS total FROM MKT_T_Transaksi_D1A FULL OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID AND  LEFT(MKT_T_Transaksi_D1A.trD1A, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  pdID("pdID") &"') "
    'response.write ProdukTerjual_cmd.commandText
    set ProdukTerjual = ProdukTerjual_cmd.execute

    set ProdukRekom_cmd = server.createObject("ADODB.COMMAND")
	ProdukRekom_cmd.activeConnection = MM_PIGO_String

    ProdukRekom_cmd.commandText = "SELECT * From MKT_M_Produk WHERE pd_catID = '"&  pdID("pd_catID") &"' "
    'response.write ProdukRekom_cmd.commandText
    set ProdukRekom = ProdukRekom_cmd.execute

    set pdRekom_cmd = server.createObject("ADODB.COMMAND")
	pdRekom_cmd.activeConnection = MM_PIGO_String

    bs = request.Form("pdID")
    
    dim bs
    set bs_cmd = server.createObject("ADODB.COMMAND")
	bs_cmd.activeConnection = MM_PIGO_String
			
	bs_cmd.commandText = " SELECT dbo.MKT_M_Produk.pdID, dbo.MKT_M_Produk.pdNama, dbo.MKT_M_Merk.mrNama, dbo.MKT_M_Produk.pdType,  dbo.MKT_M_Produk.pdStok, dbo.MKT_M_Produk.pdSku, dbo.MKT_M_Produk.pdDesc1, dbo.MKT_M_Produk.pdDesc2, dbo.MKT_M_Produk.pdPanjang, dbo.MKT_M_Produk.pdLebar, dbo.MKT_M_Produk.pdTinggi, dbo.MKT_M_Produk.pdBerat, dbo.MKT_M_Produk.pdTglProduksi, dbo.MKT_M_Produk.pdExp, dbo.MKT_M_Produk.pdHargaJual, dbo.MKT_M_Produk.pdImage1, dbo.MKT_M_Produk.pdImage2, dbo.MKT_M_Produk.pdImage3, dbo.MKT_M_Produk.pdImage4, dbo.MKT_M_Produk.pdImage5, dbo.MKT_M_Produk.pdImage6, dbo.MKT_M_Produk.pdVideo, dbo.MKT_M_Produk.pdDangerousGoodsYN, dbo.MKT_M_Produk.pdBaruYN, dbo.MKT_M_Kategori.catName FROM dbo.MKT_M_Produk LEFT OUTER JOIN dbo.MKT_M_Merk ON dbo.MKT_M_Produk.pd_mrID = dbo.MKT_M_Merk.mrID LEFT OUTER JOIN dbo.MKT_M_Kategori ON dbo.MKT_M_Produk.pd_catID = dbo.MKT_M_Kategori.catID where pdID = '"& bs &"' " 
	set bs = bs_cmd.execute

%> 

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/styleproduk.css">
        <link rel="stylesheet" type="text/css" href="fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="css/stylehome.css">
        <script src="js/sw/sweetalert2.all.min.js"></script>
        <script src="js/jquery-3.6.0.min.js"></script>
        <title>Official PIGO</title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

    <script>
        // $(".swa-confirm").on("submit", function(e) {
        //     e.preventDefault();
        //     swal({
        //         title: $(this).data("swa-title"),
        //         text: $(this).data("swa-text"),
        //         type: "warning",
        //         showCancelButton: true,
        //         confirmButtonColor: "#cc3f44",
        //         confirmButtonText: $(this).data("swa-btn-txt"),
        //         closeOnConfirm: false,
        //         html: false
        //     }, function() {

        //     }
        //     );
        // });

        function Tambah() {
            let btnPls = document.getElementsByTagName("plus");
            let input = document.getElementById("qty").value;
            let qty = document.getElementById("tes").value;
            let mqty = document.getElementById("tes").max;
                if(document.getElementById("qty").validity.rangeOverflow){
                    Swal.fire({
                        text: 'Jumlah Stok Hanya '+ mqty
                    });

                }else{
                    if (input === input){
                            let nilaitambah =  input++ +1;
                            document.getElementById("qty").value = input++;
                        }
                    
                    if (qty === qty){
                        let nilaitambah =  qty++ +1;
                        document.getElementById("tes").value = qty++;
                    }
                }
            }
        function Kurang() {
            
            let input = document.getElementById("qty").value;
            
            let qty = document.getElementById("tes").value;

            if (input === input){
                let nilaikurang = input-- ;
                    document.getElementById("qty").value = input--;
                }
            if (qty === qty){
                let nilaikurang = qty--;
                    document.getElementById("tes").value = qty--;
                }
        }

        $(document).ready(function(){
            var cartQTY = document.getElementById("cartQTY").value;
            var n = document.getElementById("qty").max;
            var sisaqty = n - cartQTY;
            document.getElementById("sisaqty").value = sisaqty;

        })


        function addcart(){
            var cartQTY = parseInt(document.getElementById("cartQTY").value);
            var n = parseInt(document.getElementById("qty").max);
            var qtyy = parseInt(document.getElementById("qty").value);
            var MinQty = parseInt(document.getElementById("qty").min);
            var qtysisa = parseInt(document.getElementById("sisaqty").value);
            var modalsendproduk = document.getElementById("myModal-sendproduk");
            var spansendproduk = document.getElementsByClassName("close-sendproduk")[0];
            console.log(modalsendproduk);
            // When the user clicks anywhere outside of the modal, close it
            // window.onclick = function(event) {
            //     if (event.target == modalsendproduk) {
            //         modalsendproduk.style.display = "none";
            //     }
            // }
            if ( cartQTY >= n ){
                // alert("Stok Produk Ini " + n + " Dikeranjangmu Sudah Ada " + cartQTY);
                Swal.fire({
                    text: 'Stok Produk Ini ' + n + ' Dikeranjangmu Sudah Ada ' + cartQTY
                });
            }else{
                if ( qtyy > qtysisa ){
                    // alert("Kamu Hanya Bisa Menambahkan " + qtysisa + " Produk" );
                    Swal.fire({
                        text: 'Kamu Hanya Bisa Menambahkan ' + qtysisa + ' Produk'
                    });
                }else{
                    $.ajax({
                        type: "post",
                        url: "Keranjang/P-cart.asp?pdID="+document.getElementById("kodeproduk").value+"&slID="+document.getElementById("slID").value+"&qty="+document.getElementById("qty").value,
                        success: function (url) {
                            // Swal.fire({
                            //     text: '' + qtyy + '  Produk Berhasil Di Tambahkan'
                            // }).then((result) => {
                            //     location.reload();
                            // });   
                            $("#myModal-sendproduk").show
                            document.getElementById("myModal-sendproduk").style.display = "block";    
                            spansendproduk.onclick = function() {
                                location.reload();
                            }      
                        }
                    });
                }

            }
        }
        function profileseller(){
            $.ajax({
                type: "post",
                url: "Profile/index.asp?idseller="+document.getElementById("idseller").value,
                success: function (url) {                
                }
            });
        }
        function profileseller(){
            $.ajax({
                type: "post",
                url: "Profile/index.asp?idseller="+document.getElementById("idseller").value,
                success: function (url) {                
                }
            });
        }
    </script>

    <style>
        /* The Modal (background) */
.modal-sendproduk {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top:2px;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content-sendproduk {
  background-color: #fefefe;
  margin: auto;
  border-radius:20px;
  border:none;
  padding: 20px;
  width: 40%;
  margin-top:5rem;
}

/* The Close Button */
.close-sendproduk {
  color: #0077a2;
  float: right;
  font-size: 20px;
  font-weight: bold;
}

.close-sendproduk:hover,
.close-sendproduk:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
        .btnk{
            width:20px;
            height:20px;
            font-size:10px;
            background-color:#0dcaf0;
            border:none;
            padding:2px 2px;
            border-radius:10px;
        }
.txt-judul-modal{
    font-size:17px;
    font-weight:bold;
    color:#0077a2;
}
.txt-modal{
    font-size:12px;
    font-weight:bold;
    color:black;
}
.cont-modal-produk{
    margin:20px;
}
.btn-modal{
    background-color:#0077a2;
    color:white;
    font-size:12px;
    font-weight:450;
    border:none;
    border-radius:20px;
    padding:2px 25px
}
    </style>
    
    </head>
<body>
    <!-- Header -->
        <!--#include file="header.asp"-->
        <!--#include file="ChatLive/new.asp"-->
    <!-- Header -->

    <!--Breadcrumb-->
        <div class="container">
            <div class="navigasi">
                <nav aria-label="breadcrumb" >
                    <ol class="breadcrumb ">
                        <li class="breadcrumb-item"><a href="<%=base_url%>/" >Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page"><%=pdID("catName")%></li>
                        <li class="breadcrumb-item active" aria-current="page">Detail Produk</li>
                    </ol>
                </nav>
            </div>
        </div>
    <!--Breadcrumb-->

    <input type="hidden" name="sisaqty" id="sisaqty" value="0">
    <%if customer.eof = true then%>
        <input type="hidden" name="cartQTY" id="cartQTY" value="0">
    <%else%>
    <%do while  not customer.eof%>
        <input type="hidden" name="cartQTY" id="cartQTY" value="<%=customer("cartQTY")%>">
    <%customer.movenext
    loop%>
    <%end if%>
    <div class="container">
        <div class="row detail-produk" style="height:35rem">
            <div class="col-6 mt-4">
                <figure class="figure align-items-center" style="margin-left:1rem">
                    <img src="data:image/png;base64,<%=pdID("pdImage1") %>" class="figure-img img-fluid align-center" id="imgbox" alt="" style="width:30rem; height:25rem">
                    <figcaption class="small d-flex justify-content-evenly mt-4">
                    <%
                        do while not Gambar.eof
                    %>
                        <img src="data:image/png;base64,<%=Gambar("gambar1")%>" class="figure-img img-fluid me-1 " style="border:2px solid #ececec; width:6rem; height:4rem" alt="" onclick="BoxImg(this)">
                        <img src="data:image/png;base64,<%=Gambar("gambar2")%>" class="figure-img img-fluid me-1" style="border:2px solid #ececec; width:6rem; height:4rem" alt="" onclick="BoxImg(this)">
                        <img src="data:image/png;base64,<%=Gambar("gambar3")%>" class="figure-img img-fluid me-1" style="border:2px solid #ececec; width:6rem; height:4rem" alt="" onclick="BoxImg(this)">
                        <img src="data:image/png;base64,<%=Gambar("gambar4")%>" class="figure-img img-fluid me-1" style="border:2px solid #ececec; width:6rem; height:4rem" alt="" onclick="BoxImg(this)">
                        <img src="data:image/png;base64,<%=Gambar("gambar6")%>" class="figure-img img-fluid " style="border:2px solid #ececec; width:6rem; height:4rem" alt="" onclick="BoxImg(this)">
                    <%
                        Gambar.movenext
                        loop
                    %>
                    </figcaption>
                </figure>
            </div>

            <div class="col-6 mt-4">
                <div class="row">
                    <div class="col-12">
                        <span class="txt-produk-name"><%=pdID("pdNama")%></span>
                        <input type="hidden" name="produkid" id="produkid" value="<%=pdID("pdID")%>">
                    </div>
                </div>
                <div class="row mt-1 mb-1" >
                    <div class="col-10">
                        <table>
                            <td style="border-right:5px solid #0077a2;padding:2px 15px">
                                <i class="fas fa-star" style="color:#0077a2"></i>
                                <i class="fas fa-star" style="color:#0077a2"></i>
                                <i class="fas fa-star" style="color:#0077a2"></i>
                                <i class="fas fa-star" style="color:#0077a2"></i>
                                <i class="far fa-star" style="color:#0077a2"></i>
                                <span class="text-desc"> 4.9 </span>
                            </td>
                            <td style="border-right:5px solid #0077a2;padding:2px 15px">
                                <span class="text-desc"> <%=ProdukTerjual("total")%> Terjual  </span>
                            </td>
                            <td style="border-right:5px solid #0077a2;padding:2px 15px">
                                <span class="text-desc" > 0 Penilaian </span>
                            </td>
                        </table>
                    </div>
                </div>
                <div class="cont-harga mt-3 mb-3">
                    <div class="row" >
                        <div class="col-12">
                            <span class="txt-produk-harga"><%=Replace(Replace(Replace(FormatCurrency(pdID("pdHargaJual")),"$","Rp.  "),".00",""),",",".")%> </span>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-3">
                        <button href="" class="btn-d-produk" data-bs-toggle="modal" data-bs-target="#exampleModal">Beli Sekarang</button>
                    </div>
                    <div class="col-4">
                        <button href="" class="btn-d-produk" style="width:100%"> <i class="fas fa-thumbs-up"></i> &nbsp;Tambahkan Ke Favorit</button>
                    </div>
                    <div class="col-5">
                        <button href="" class="btn-d-produk"> <i class="fas fa-truck"></i> &nbsp;Pengiriman Dari : <%=Seller("AlmProvinsi")%></button>
                    </div>
                </div>
                    <%
                        StokAkhir_cmd.commandText = "SELECT MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdID, MKT_M_Produk.pdStok, SUM(MKT_M_Produk.pdStok - MKT_T_Transaksi_D1A.tr_pdQty) AS total FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D2 ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D2.trD2 FULL OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_D1A.trD1A WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  pdID("pdID") &"') AND (MKT_M_Produk.pd_custID = '"&  pdID("pd_custID") &"') GROUP BY MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdID, MKT_M_Produk.pdStok"
                    'response.write StokAkhir_cmd.commandText
                    set StokAkhir = StokAkhir_cmd.execute
                    %>
                    <% if StokAkhir.eof = true then %>
                    <div class="row mt-3">
                        <div class="col-12">
                            <!--<button name="minus" id="minus" type="button" class=" btnk btn-dark btn-sm minus " onclick="return Kurang()" ><i class="fas fa-minus"></i></button>-->
                            <div class="row mt-2">
                                <div class="col-3">
                                    <div class="quantity">
                                        <input class="inp-qty" name="qty" id="qty" type="number" min="1" max="<%=pdID("pdStok")%> " step="1" value="1">
                                    </div>
                                </div>
                                <div class="col-4">
                                    <input type="hidden" name="kodeproduk" id="kodeproduk" value="<%=pdID("pdID")%>">

                                    <input type="hidden" name="slID" id="slID" value="<%=pdID("pd_custID")%>">
                                    <button type="button" name="cart" id="cart" class="btn-d-produk"  onclick="return addcart()"> <i class="fas fa-shopping-cart"></i> &nbsp; Masukan Keranjang </button>
                                </div>
                            </div>

                            <!--<button name="plus" id="plus" type="button" class=" btnk btn-dark btn-sm plus  me-4" onclick="return Tambah()"><i class="fas fa-plus"></i></button>-->
                            
                        </div>
                    </div>
                    <%else%>
                    <% do while not StokAkhir.eof %>
                    <div class="row mt-3">
                        <div class="col-12">
                            <!--<button name="minus" id="minus" type="button" class=" btnk btn-dark btn-sm minus " onclick="return Kurang()" ><i class="fas fa-minus"></i></button>-->
                            <div class="row mt-2">
                                <div class="col-3">
                                    <div class="quantity">
                                        <input class="inp-qty" name="qty" id="qty" type="number" min="1" max="<%=StokAkhir("total")%> " step="1" value="1">
                                    </div>
                                </div>
                                <div class="col-4">
                                    <input type="hidden" name="kodeproduk" id="kodeproduk" value="<%=pdID("pdID")%>">

                            <input type="hidden" name="slID" id="slID" value="<%=pdID("pd_custID")%>">
                            <button type="button" name="cart" id="cart" class="btn-d-produk"  onclick="return addcart()"> <i class="fas fa-shopping-cart"></i> &nbsp; Masukan Keranjang </button>
                                </div>
                            </div>

                            <!--<button name="plus" id="plus" type="button" class=" btnk btn-dark btn-sm plus  me-4" onclick="return Tambah()"><i class="fas fa-plus"></i></button>-->
                            
                        </div>
                    </div>
                    <% StokAkhir.movenext
                    loop%>
                    <%end if%>
                <div class="row mt-2">
                    <div class="col-12">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-items" role="presentation">
                                <button class="nav-link active text-desc" id="deskripsi-tab" data-bs-toggle="tab" data-bs-target="#deskripsi" type="button" role="tab" aria-controls="deskripsi" aria-selected="true">Detail</button>
                            </li>
                            <li class="nav-items" role="presentation">
                                <button class="nav-link text-desc" id="review-tab" data-bs-toggle="tab" data-bs-target="#review" type="button" role="tab" aria-controls="review" aria-selected="false">Spesifikasi</button>
                            </li>
                        </ul>
                        <div class="tab-content p-3" id="myTabContent" >
                            <div class="tab-pane fade show active deskripsi" id="deskripsi" role="tabpanel" aria-labelledby="deskripsi-tab" style="height:10.2rem">
                                <div class="row">
                                    <div class="col-12"  >
                                        <span class="text-desc"><%=pdID("pdDesc1")%><span>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade review" id="review" role="tabpanel" aria-labelledby="review-tab" style="height:10.2rem">
                                <div class="row">
                                    <div class="col-2">
                                        <span class="text-desc"> Merk </span><br>
                                        <span class="text-desc"> Kategori </span><br>
                                        <span class="text-desc"> Berat </span><br>
                                        <span class="text-desc"> SKU </span><br>
                                        </div>
                                        <div class="col-6">
                                            <span> : </span>&nbsp;&nbsp;<span class="text-desc"> <%=pdID("mrNama")%> </span><br>
                                            <span> : </span>&nbsp;&nbsp;<span class="text-desc"> <%=pdID("catName")%> </span><br>
                                            <span> : </span>&nbsp;&nbsp;<span class="text-desc"> <%=pdID("pdBerat")%> </span><br>
                                            <span> : </span>&nbsp;&nbsp;<span class="text-desc"> <%=pdID("pdSKU")%> </span><br>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <div class="container mt-3">
        <div class="row align-items-center detail-produk p-3">
            <%do while not seller.eof%>
                <div class="col-1">
                    <img src="data:image/png;base64,<%=Seller("custPhoto") %>" id="output" width="50" height="50">
                </div>
                <div class="col-3">
                    <input class="text-pd-seller" type="text" name="namaseller" id="namaseller" value="<%=Seller("slName")%>" style=" width:15rem;border:none;"><br>
                    <span class="text-pd-desc"><%=Seller("almProvinsi")%></span><br>
                    <span class="text-pd-desc">Aktif 9 Menit lalu</span>
                </div>
                <div class="col-4">
                    <a href="Seller/Profile/?sl=<%=Seller("slName")%>" role="button" class="btn-pd me-4"> Kunjungi Seller </a>
                    <input type="hidden" name="kodeseller" id="kodeseller" value="<%=Seller("sl_custID")%>">
                    <button class="btn-pd" onclick="openForm()"> Chat Seller </button>
                </div>
                <div class="col-4">
                    <div class="row">
                        <div class="col-4">
                            <div class="card-pd text-center">
                                <span> Penilaian </span><br>
                                <div class="card-footer-pd mt-2">
                                    <span> 0%</span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="card-pd text-center">
                                <span> Produk </span><br>
                                <div class="card-footer-pd mt-2">
                                    <span>0</span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="card-pd text-center">
                                <span> Pengikut </span><br>
                                <div class="card-footer-pd mt-2">
                                    <span> 0%</span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <%Seller.movenext
            loop%>
        </div>
    </div>
    <div class="container mt-3">
    <% if review.eof = true then%>
        <div class="row align-items-center detail-produk p-3">
            <div class="col-12">
                <span class="text-pd-seller"> ULASAN </span>
                <hr>
                <div class="row">
                    <div class="col-1">
                        <span class="text-pd-seller"> Filter </span>
                    </div>
                    <div class="col-11">
                        <div class="row">
                            <div class="col-12">
                                <button class="btn-fl-ulasan me-2"> Semua </button>
                                <button class="btn-fl-ulasan me-2"> Dengan Foto </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 5 </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 4 </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 3 </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 2 </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 1 </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <span class="text-pd-desc"> Tidak Ada Ulasan </span>
                    <!--<div class="col-2 vc-seller">
                        <span class="text-pd-desc"> Voucher Toko </span>
                    </div>-->
                </div>
            </div>
        </div>
    <% else %>
    <% do while not review.eof %>
        <div class="row align-items-center detail-produk p-3">
            <div class="col-12">
                <span class="text-pd-seller"> ULASAN (<%=review("a")%>) </span>
                <hr>
                <div class="row">
                    <div class="col-1">
                        <span class="text-pd-seller"> Filter </span>
                    </div>
                    <div class="col-11">
                        <div class="row">
                            <div class="col-12">
                                <button class="btn-fl-ulasan me-2"> Semua </button>
                                <button class="btn-fl-ulasan me-2"> Dengan Foto </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 5 </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 4 </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 3 </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 2 </button>
                                <button class="btn-fl-ulasan-dsc me-2"> 1 </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <span class="text-pd-desc"> Semua Ulasan </span>
                    <div class="col-10">
                    
                        <div class="div-ulasan">
                            <div class="row mt-3">
                                <div class="col-1 ms-4">
                                    <img src="data:image/png;base64,<%=Review("custPhoto") %>" id="output" width="50" height="50">
                                </div>
                                <div class="col-2">
                                    <input class="text-pd-desc" type="text" name="custNama" id="custNama" value="<%=review("custNama")%>" style="border:none; width:8rem; background-color:#f7f5f5"><br>
                                    <input class="text-pd-desc" type="text" name="custNama" id="custNama" value="<%=Cdate(review("ReviewTanggal"))%>" style="border:none; width:8rem; background-color:#f7f5f5"><br>
                                </div>
                                <div class="col-7">
                                    <div class="row">
                                        <div class="col-12">
                                            <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                            <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                            <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                            <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                            <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <span class="text-pd-desc"> <%=review("ReviewProduk")%> </span><br>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!--<div class="col-2 vc-seller">
                        <span class="text-pd-desc"> Voucher Toko </span>
                    </div>-->
                </div>
            </div>
        </div>
    <% review.movenext
    loop%>
    <% end if %>
    </div>
    <div class="container mt-3">
        <div class="row align-items-center detail-produk p-3">
            <div class="col-12 text-center">
                <span class="text-pd-seller"> Produk Rekomendasi </span>
            </div>
        </div>
        
                <div class="row">
                <% do while not ProdukRekom.eof %>
                <div class="col-lg-2 col-md-2 col-sm-1 col-6 mt-2 ">
                    <a href="singleproduk.asp?pdID=<%=ProdukRekom("pdID")%>">
                        <div class="card mt-3 mb-2 me-2">
                            <img src="data:image/png;base64,<%=ProdukRekom("pdImage1")%>" class="card-img-top rounded" alt="...">
                            <!--<input class="terlaris" type="text" name="promo" id="promo" value="Promo" style="border:none" readonly>-->
                            <div class="card-body">
                                <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="<%=ProdukRekom("pdNama")%>"><br>
                                <input class="hg-card" type="text" name="pdHarga" id="pdHarga" value="<%=Replace(FormatCurrency(ProdukRekom("pdHargaJual")),"$","Rp. ")%>"><br>
                                <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                <span class="terjual"><del>Rp 100.000</del></span>-->
                                <div class="row mt-2">
                                    <div class="col-6">
                                        <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                        <span class="label-card"> 4.9 </span>
                                    </div>
                                    <%
                                        pdRekom_cmd.commandText = "SELECT COUNT(MKT_T_Transaksi_D1A.tr_pdQty) AS total FROM MKT_M_Produk RIGHT OUTER JOIN  MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN  MKT_T_Transaksi_D1 ON LEFT(MKT_T_Transaksi_D1A.trD1A, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  ProdukRekom("pdID") &"')  GROUP BY MKT_T_Transaksi_D1A.tr_pdID"
                                        set pdRekom = pdRekom_cmd.execute
                                    %>
                                    <% do while not pdRekom.eof%>
                                    <div class="col-6">
                                        <span class="label-card"> <%=pdRekom("total")%> Terjual </span>
                                    </div>
                                    <%pdRekom.movenext
                                    loop%>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <% 
                lastpdID = ProdukRekom("pdID") 
                ProdukRekom.movenext
                loop
                response.Cookies("lpd")=lastpdID 
                %>
            </div>
    </div>
    <!-- The Modal -->
    <div id="myModal-sendproduk" class="modal-sendproduk">

    <!-- Modal content -->
    <div class="modal-content-sendproduk">
        
        <div class="row">
            <div class="col-10">
                <span class="txt-judul-modal"> Produk Berhasil Ditambahkan </span>
            </div>
            <div class="col-2">
                <span class="close-sendproduk">&times;</span>
            </div>
        </div>
        <div class="cont-modal-produk">
            <div class="row">
                <div class="col-4 me-2">
                    <img src="data:image/png;base64,<%=pdID("Gambar1") %>" class="figure-img img-fluid align-center" id="imgbox" alt="" style="width:8rem; height:8rem">
                </div>
                <div class="col-6">
                    <span class="txt-modal"><%=pdID("pdNama") %></span><br>
                    <span class="txt-modal"><%=pdID("catName") %></span> - <span class="txt-modal"><%=pdID("mrNama") %></span> <br>
                    <span class="txt-produk-harga" style="font-size:15px"><%=Replace(Replace(Replace(FormatCurrency(pdID("pdHargaJual")),"$","Rp.  "),".00",""),",",".")%> </span>
                </div>
            </div>
        </div>
        <div class="row text-center">
            <div class="col-12">
                <button class="btn-modal"  onclick="window.location.href='Cart/'"> Lihat Keranjang </button>
            </div>
        </div>
    </div>

    </div>
    <!--Footer-->
         <!--#include file="footer.asp"-->
    <!--Footer-->
    <!-- Beli Sekarang -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                <div class="row mt-2 p-2">
                    <div class="col-6">
                        <figure class="figure">
                            <img src="data:image/png;base64,<%=bs("pdImage1") %>" class="figure-img img-fluid" id="imgbox" alt="">
                        </figure>
                    
                    </div>
                    <div class="col-6">
                        <span class="text-pd-desc"><%=bs("pdNama")%></span><br>
                        <span class="text-pd-desc">SKU :  <%=bs("pdSku")%></span><br>
                        <span class="text-pd-desc"> Rp <%=bs("pdHargaJual")%></span><br>
                        <span class="text-pd-desc">Stok : <%=bs("pdStok")%></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-7">
                        <span>Varian</span><br>
                    </div>
                    <div class="col-3 mt-2">
                        <span>Jumlah</span><br>
                        <div class="quantity">
                            <input class="inp-qty" name="qty" id="qty" type="number" min="1" max="<%=pdID("pdStok")%>" step="1" value="1">
                        </div>
                    </div>
                </div>
                <div class="row align-items-center mt-3 mb-3">
                    <div class="col-12">
                        <input type="hidden" name="idproduk" id="idproduk" value="<%=bs("pdID")%>">
                        <button type="button" class="btn btn-cart" onclick="window.open('Cart/BuyNow.asp?pdID='+document.getElementById('idproduk').value+'&totalqty='+document.getElementById('qty').value,'_Self')">Beli Sekarang</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Beli Sekarang -->
    
  </body>
    <script>
        function BoxImg(smallimg) {
            var fullimg = document.getElementById("imgbox");
            fullimg.src = smallimg.src;    
        }
            jQuery('<div class="quantity-nav"><div class="quantity-button quantity-up">+</div><div class="quantity-button quantity-down">-</div></div>').insertAfter('.quantity input');
                jQuery('.quantity').each(function() {
                var spinner = jQuery(this),
                    input = spinner.find('input[type="number"]'),
                    btnUp = spinner.find('.quantity-up'),
                    btnDown = spinner.find('.quantity-down'),
                    min = input.attr('min'),
                    max = input.attr('max');

                btnUp.click(function() {
                    var oldValue = parseFloat(input.val());
                    if (oldValue >= max) {
                    var newVal = oldValue;
                        Swal.fire({
                            text: 'Stok Tersedia Hanya '+ max
                        });
                    } else {
                    var newVal = oldValue + 1;
                    }
                    spinner.find("input").val(newVal);
                    spinner.find("input").trigger("change");
                });

                btnDown.click(function() {
                    var oldValue = parseFloat(input.val());
                    if (oldValue <= min) {
                    var newVal = oldValue;
                    } else {
                    var newVal = oldValue - 1;
                    }
                    spinner.find("input").val(newVal);
                    spinner.find("input").trigger("change");
                });

            });
            function openForm() {
                var custEmail = document.getElementById("custEmail").value;
                if ( custEmail == "" ){
                    window.open(`Login/`,`_Self`)
                }else{
                    document.getElementById("myForm").style.display = "block";
                    var kodeseller = document.getElementById("kodeseller").value;
                    var produkid = document.getElementById("produkid").value;
                    $.ajax({
                        type: "get",
                        url: "Ajax/get-seller.asp",
                        data: {
                            kodeseller,
                            produkid
                        },
                        success: function (url) {
                            $('.chatseller').html(url);
                            return url;
                            // console.log(url);
                        }
                    });
                                    
                    $('.cont-chat').focus();
                }
            }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>     

</html>