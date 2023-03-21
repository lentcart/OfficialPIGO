<!--#include file="Connections/pigoConn.asp" -->
<%
    dim produk_cmd, produk

    set produk_cmd =  server.createObject("ADODB.COMMAND")
    produk_cmd.activeConnection = MM_PIGO_String

    produk_cmd.commandText = "SELECT * FROM MKT_M_Produk WHERE pdAktifYN = 'Y' "
    'response.write produk_CMD.commandText & "<br>"
    set produk = produk_cmd.execute

    set Listseller_cmd =  server.createObject("ADODB.COMMAND")
    Listseller_cmd.activeConnection = MM_PIGO_String

    Listseller_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_M_Seller.sl_custID,MKT_M_Customer.custPhoto FROM MKT_M_Customer RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_T_Keranjang ON MKT_M_Seller.sl_custID = MKT_T_Keranjang.cart_slID WHERE (MKT_T_Keranjang.cart_custID = '"& request.Cookies("custID") &"') GROUP BY MKT_M_Seller.slName, MKT_M_Customer.custPhoto,MKT_M_Seller.sl_custID "
    'response.write Listseller_CMD.commandText & "<br>"
    set Listseller = Listseller_cmd.execute

    set chat_cmd =  server.createObject("ADODB.COMMAND")
    chat_cmd.activeConnection = MM_PIGO_String

    chat_cmd.commandText = "SELECT MKT_T_ChatLive.chatDesc, MKT_T_ChatLive.chatTanggal, MKT_T_ChatLive.chatTime, Penerima.custPhoto, MKT_T_ChatLive.chat_Penerima,  MKT_T_ChatLive.chat_Pengirim, Penerima.custNama AS namapenerima, Pengirim.custNama AS namapengirim FROM MKT_T_ChatLive LEFT OUTER JOIN MKT_M_Customer AS Pengirim ON MKT_T_ChatLive.chat_Pengirim = Pengirim.custID LEFT OUTER JOIN MKT_M_Customer AS Penerima ON MKT_T_ChatLive.chat_Penerima = Penerima.custID Where chat_Penerima = '"& request.Cookies("custID") &"' Order BY ChatTime"
    'response.write chat_CMD.commandText & "<br>"
    set chat = chat_cmd.execute

    set namaseller_cmd =  server.createObject("ADODB.COMMAND")
    namaseller_cmd.activeConnection = MM_PIGO_String

    namaseller_cmd.commandText = "SELECT MKT_M_Seller.slName FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID Where  MKT_M_Customer.custID = '"& request.cookies("custID") &"'  "
    set namaseller = namaseller_CMD.execute

    set StokAkhir_cmd = server.createObject("ADODB.COMMAND")
	StokAkhir_cmd.activeConnection = MM_PIGO_String

	dim kategori_cmd, kategori
			
	set kategori_cmd = server.createObject("ADODB.COMMAND")
	kategori_cmd.activeConnection = MM_PIGO_String
			
	kategori_cmd.commandText = "SELECT [catID] ,[catName] ,[catAktifYN] FROM [PIGO].[dbo].[MKT_M_Kategori] where catAktifYN = 'Y'" 
	set kategori = kategori_cmd.execute

    set ProdukTerjual_cmd = server.createObject("ADODB.COMMAND")
	ProdukTerjual_cmd.activeConnection = MM_PIGO_String
%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OFFICIAL PIGO</title>
    <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/stylehome.css">
    <link rel="stylesheet" type="text/css" href="fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    </head>
    <script>
        // var countDownDate = new Date("Maret 23, 2022 20:00:00").getTime();
        // var x = setInterval(function() {
        // var now = new Date().getTime()
        // var distance = countDownDate - now;
        // var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        // var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        // var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        // var seconds = Math.floor((distance % (1000 * 60)) / 1000);
        // document.getElementById("demo").innerHTML = hours + " : " + minutes + " : " + seconds;
        // if (distance < 0) {
        //     clearInterval(x);
        //     document.getElementById("demo").innerHTML = "EXPIRED";
        // }
        // }, 1000);

        // var produkk = document.querySelectorAll('.produkk');
        // var btn = document.querySelector('.btn');
        // var currentimg = 2 btn.addEventListener('click',function() {
        //     for (var i = currentimg; i < currentimg + 2; i++) {
        //         if(produkk[i]) {
        //             produkk[i].style.display = 'block';
        //         }
        //     }
        //     currentimg += 2;
        //     if (currentimg >= produkk.length) {
        //         event.target.style.display = 'none';
        //     }
            
        // });

        // function load(){
        //     $(".prtampil").slice(0, 6).show();
        //     $(".load-more").on("click", function(){
        //         $(".prtampil:hidden").slice(0, 6).show();
        //         if( $(".prtampil:hidden").length == 0){
        //             $(".load-more").fadeOut();
        //         }
        //     })
        // }

        // function load(id){
        //     $.ajax({
        //         url: 'loadproduk.asp',
        //         data: { id : id },
        //         method: 'post',
        //         success: function (data){
        //             let maxitem = 3
        //             $(".prtampil").slice(0, maxitem).show();
        //             $(".load-more").on("click", function(){
        //                 $(".prtampil:hidden").slice(0, maxitem).show();
        //                 if( $(".prtampil:hidden").length == 0){
        //                     $(".load-more").fadeOut();
        //                 }
        //         })
        //         }
        //     });
        // }
    </script>
    <style>
        .notify-badgee2{
            position: absolute;
            right:-9px;
            top:-8px;
            max-height:22px;
            max-width:2rem;
            background:red;
            text-align: center;
            border-radius: 100%;
            color:white;
            font-weight:bold;
            font-size:10px;
            padding:3px 5px;
        }
        #timer {
            font-size: 12px;
            font-weight: 100;
            color: white;
            padding: 2px;
            width: 700px;

        }

        #timer div {
            display: inline-block;
            min-width: 35px;
            padding: 5px;
            background: #0077a2;
            border-radius: 5px;
            margin: 2px;
            font-weight: bold;
        }
        #timer div span {
            color: #ffffff;
            font-size: 12px;
            font-weight: bold;
        }
    </style>
<body>
    <!-- Header -->
        <!--#include file="header.asp"-->
    <!-- Header -->

    <div class="container" style="margin-top:2rem">
        <!-- Carousel -->
            <div id="carouselExampleIndicators" class=" mt-4 carousel slide" data-bs-ride="carousel">
                <div class="cr-index">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active" >    <img src="assets/baru/Banner/Bann1.jpg" class="d-block img-fluid crimg" alt="" class="img-banner" width="100%" height="100%">
                        </div>
                        <div class="carousel-item">
                            <img src="assets/baru/Banner/Bann2.jpg" class="d-block img-fluid crimg" alt="" class="img-banner" width="100%" height="100%">
                        </div>
                        <div class="carousel-item">
                            <img src="assets/baru/Banner/Bann3.jpg" class="d-block img-fluid crimg" alt="" class="img-banner" width="100%" height="100%">
                        </div>
                        <div class="carousel-item">
                            <img src="assets/baru/Banner/Bann4.jpg" class="d-block img-fluid crimg" alt="" class="img-banner" width="100%" height="100%">
                        </div>
                        <div class="carousel-item">
                            <img src="assets/baru/Banner/Bann5.jpg" class="d-block img-fluid crimg" alt="" class="img-banner" width="100%" height="100%">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next " type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                        <span class="carousel-control-next-icon"  aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        <!-- Carousel -->

        <!--Kategori-->
            <div class="row text-center bg-produk mt-3 mb-2" >
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <a href="" style="font-size:12px"> Kategori </a>
                </div>
            </div>
            <div class="row text-center bg-produk" style="overflow-y:auto;">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <table  class="tabel-kategori" >
                        <tr>
                        <% do while not kategori.eof %>
                            <td>
                                <div class="cat me-3" >
                                    <a href="Otopigo/indexotopigo.asp?<%=kategori("catID")%>"><img src="assets/kategori/<%=kategori("catID")%>.jpg" class="img-kategori mt-3" width="50"></a><br>
                                    <a class="text-kategori" href="#"><b><%=kategori("catName")%></b></a>
                                </div>
                            </td>
                        <% kategori.movenext
                        loop %>
                        </tr>
                    </table>
                </div>
            </div>
        <!--Kategori-->

        <!-- Flash Sale -->
            <div class="row mt-1  ">
                <div class="col-1 me-4 mt-3">
                    <h5 class="weight" >FLASHSALE </h5>
                </div>
                <div class="col-8" style="margin-top:12px">
                    <i class="fas fa-bolt"></i> &nbsp; &nbsp; <span id="timer"></span>
                </div>
            </div>
            <div class="row bg-flashsale mx-0" id="cards">
                <div class='col-sm-12 col-lg-12' >
                    <table> 
                        <tr>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <!--<input class="terlaris" type="" name="" id="" value="OFF 50%" style="border:none; "readonly>-->
                                        <img src="assets/sparepart/8.png" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                                    25%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        <!-- Flash Sale -->

        <!-- Produk Terlaris -->
            <div class="row mx-0 sale mt-1 ">
                <div class="d-flex  mt-3">
                    <h5 class="weight" >PRODUK TERLARIS</h5>
                </div>
            </div>
            <div class='row bg-terlaris mx-0' id="cards">
                <div class='col-sm-12 col-lg-12' >
                    <table> 
                        <tr>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <!--<input class="terlaris" type="" name="" id="" value="Terlaris" style="border:none; "readonly>-->
                                        <div class="card-body">
                                            <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="SEAL PISTON KALIPER REM - CARRY T3 T5"><br>
                                            <input style="color:red" readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="Rp. 50.000"><br>
                                            <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                            <span class="terjual"><del>Rp 100.000</del></span>-->
                                            <div class="row">
                                                <div class="col-6">
                                                    <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        <!-- Produk Terlaris -->

        <!-- Produk -->
            <div class="bg-judul mt-4">
                <h5 class="text-center weight">REKOMENDASI</h5>
            </div>
            <hr>
            <div class="row">
                <%
                    if produk.eof = true then 
                %>
                <%
                    else
                %>
                <% do while not produk.eof %>
                <div class="col-lg-2 col-md-2 col-sm-1 col-6 mt-2 ">
                    <a href="singleproduk.asp?pdID=<%=produk("pdID")%>">
                        <div class="card mt-3 mb-2 me-2">
                            <img src="data:image/png;base64,<%=produk("pdImage1")%>" class="card-img-top rounded" alt="...">
                            <!--<input class="terlaris" type="text" name="promo" id="promo" value="Promo" style="border:none" readonly>-->
                            <div class="card-body">
                                <input readonly class="tx-card" onclick="return produk()" type="text" name="pdNama" id="pdNama" value="<%=produk("pdNama")%>"><br>
                                <input readonly class="tx-card" type="hidden" name="pdID" id="pdID<%=produk("pdID")%>" value="<%=produk("pdID")%>">
                                <input class="hg-card" type="text" name="pdHarga" id="pdHarga" value="<%=Replace(FormatCurrency(produk("pdHargaJual")),"$","Rp. ")%>"><br>
                                <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                <span class="terjual"><del>Rp 100.000</del></span>-->
                                <div class="row mt-2">
                                    <div class="col-6">
                                        <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                        <span class="label-card"> 4.9 </span>
                                    </div>
                                    <%
                                        ProdukTerjual_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdQty),0) AS total FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  produk("pdID") &"') AND (MKT_M_Produk.pd_custID = '"&  produk("pd_custID") &"') GROUP BY  MKT_T_Transaksi_D1A.tr_pdID, MKT_M_Produk.pd_custID" 
                                        set ProdukTerjual = ProdukTerjual_cmd.execute
                                    %>
                                    <% if ProdukTerjual.eof = true then %>
                                    <div class="col-6">
                                        <span class="label-card"> 0 Terjual </span>
                                    </div>
                                    <% else %>
                                    <div class="col-6">
                                        <span class="label-card"> <%=ProdukTerjual("total")%> Terjual </span>
                                    </div>
                                    <% end if %>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <% 
                lastpdID = produk("pdID") 
                produk.movenext
                loop
                response.Cookies("lpd")=lastpdID 
                %>
                <% end if %>
            </div>
        <!-- Produk -->

    </div>
    <!-- Popup Chat -->
        <button class="open-button" onclick="openForm()"><img src="assets/logo/bantuan.png" class="  me-1" alt="..." id="chat" >  <span class="notify-badgee2">99+</span>Live Chat</button>
            <div class="chat-popup" id="myForm">
                <div class="form-container">
                    <div class="row">
                        <div class="col-9 me-4">
                            <span class="txt-ChatLive"> ChatLive () </span>
                        </div>
                        <div class="col-2">
                            <span class=""  style="font-size:15px"><i onclick="closeForm()" class="fas fa-times-circle me-4"></i><i class="fas fa-list-ul"></i></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-7">
                            <div class="row mt-2 mb-1">
                                <div class="col-12">
                                    <div class="roomChat chatseller" id="chatseller">
                                        <div class="row text-center">
                                            <div class="col-12">
                                                <img src="<%=base_url%>/assets/logo/Maskotnew.png"  class="logo" alt="" width="70" height="75" ><br>
                                                <span class="txt-ChatLive"> Selamat Datang Di Fitur Chat  </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-8 me-3">
                                    <input Required class="chatStart" type="text" value="" name="isipesan" id="isipesan" placeholder="Masukan Pesan Anda">
                                </div>
                                <div class="col-2">
                                    <button onclick="return sendChat()" class="sendChat"> Kirim </button>
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="row ">
                                <div class="col-12">
                                        <div class="s" style="overflow-y:scroll; overflow-x:hidden; height:8.8rem">
                                        <% do while not Listseller.eof %>
                                            <button onclick="setTimeout(selectsl<%=Listseller("sl_custID")%>(), 100)" class="listt mt-2">
                                            <div class="row align-items-center">
                                                <div class="col-2">
                                                    <span class="" style="font-size:22px"> <i class="fas fa-user-circle"></i>  </span>
                                                </div>
                                                <div class="col-7 text-start">
                                                    <span  style="font-size:8px; font-weight:bold"><%=Listseller("slName")%> </span><br>
                                                    <span class="txt-ChatDesc" style="font-size:8px; font-weight:bold"> Isi Pesan Terakhir </span>
                                                    <input readonly class="txt-ChatDesc" type="hidden" value="<%=Listseller("sl_custID")%>" name="kodeseller" id="kodeseller<%=Listseller("sl_custID")%>" style="width:8rem" >
                                                
                                            </div>
                                            </button>
                                            <script>
                                                function selectsl<%=Listseller("sl_custID")%>(){
                                                    $.ajax({
                                                        type: "get",
                                                        url: "Ajax/get-seller.asp?kodeseller="+document.getElementById("kodeseller<%=Listseller("sl_custID")%>").value,
                                                        success: function (url) {
                                                            $('.chatseller').html(url);
                                                            return url;
                                                        // console.log(url);
                                                        }
                                                    });
                                                }
                                            </script>
                                        <% Listseller.movenext
                                        loop %>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
    <!-- Popup Chat -->

    <!--footer/Help -->
        <div class="fttr" style="width:99%; margin:0px; padding:20px 20px; background-color:none; margin-bottom:0px; z-index: 999;">
            <div class="row">
                <div class="col-12">
                    <div class="footer">
                        <div class="help">
                            <div class="row mt-2">
                                <div class="col-3 me-0 ms-0 p-0">
                                    <ul style="list-style:none">
                                        <li><p class="title">BANTUAN</p></li>
                                        <li><a href=""><span class="desc">Pembayaran</span></a></li>
                                        <li><a href=""><span class="desc">Pengiriman</span></a></li>
                                        <li><a href=""><span class="desc">Status Pemesanan</span></a></li>
                                        <li><a href=""><span class="desc">Pengembalian Produk</span></a></li>
                                        <li><a href=""><span class="desc">Cara Berbelanja</span></a></li>
                                        <li><a href=""><span class="desc">otopigo.official@gmail.com</span></a></li>
                                    </ul>
                                </div>
                                <div class="col-3 me-0 ms-0 p-0">
                                    <ul style="list-style:none">
                                        <li><p class="tittle">INFO PIGO</p></li>
                                        <li><a href=""><span class="desc">Tentang Pigo</span></a></li>
                                        <li><a href=""><span class="desc">Blog Pigo</span></a></li>
                                        <li><a href=""><span class="desc">Informasi Terbaru</span></a></li>
                                        <li><a href=""><span class="desc">Karir</span></a></li>
                                        <li><a href=""><span class="desc">Syarat, Ketentuan & Kebijakan Privasi</span></a></li>
                                    </ul>
                                </div>
                                <div class="col-6 me-0 ms-0 p-0">
                                    <div class="row">
                                        <div class="col-6">
                                            <p class="tittle">KERJA SAMA</p>
                                            <span class="desc"></span>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-12"> 
                                            <p class="tittle">DAKOTA GROUP</p>
                                            <div class="d-flex flex-wrap">
                                                <img src="assets/help/dakota.png" width="40" height="50" style="margin:10px"  />
                                                <img src="assets/help/kurir.png" width="40" height="50" style="margin:10px" />
                                                <img src="assets/help/dli.png" width="40" height="50" style="margin:10px"/>
                                                <img src="assets/help/delima.png" width="210" height="50" style="margin:10px"/>
                                                <img src="assets/help/spim.png" width="115" height="50" style="margin:10px"/>
                                                <img src="<%=base_url%>/assets/logo/otopigo1.png" width="60"height="80" style="margin:10px"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <!--footer/Help -->

    <!--#include file="footer.asp"-->

    <!-- Popup iklan-->
        <div class="popbox hide" id="popbox">
            <div aria-label='Close' class="pop-overlay" onclick='document.getElementById("popbox").style.display="none";removeClassonBody();'>
                <div class="pop-content">
                    <a href="#" target="_blank" rel="noopener noreferrer" title="">
                        <div class="popcontent">
                            <img src="assets/banner/banner1.jpg" alt="banner" class="rounded" width="100%" />
                        </div>
                    </a>
                    <button aria-label='Close' class='popbox-close-button' onclick='document.getElementById("popbox").style.display="none";removeClassonBody();'>&times;</button>
                </div>
            </div>
        </div> 
    <!-- Popup iklan -->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>         
    <script>
        // PopUp Iklan
            setTimeout(function(){
            document.getElementById('popbox').classList.remove('hide');
            document.body.className+="flowbox"
            }, 800);
            function removeClassonBody(){
                var element=document.body;element.className=element.className.replace(/\bflowbox\b/,"")
            }
        // PopUp Iklan

        // Open Chat
            function openForm() {
            document.getElementById("myForm").style.display = "block";
            }
            function closeForm() {
            document.getElementById("myForm").style.display = "none";
            }

        function sendChat(){
            $.ajax({
                type: "get",
                url: "ChatLive/chatcust.asp?isipesan="+document.getElementById("isipesan").value+"&kodeseller="+document.getElementById("kodeseller").value,
                success: function (url) {
                // console.log(url);
                $('.chatseller').html(url);
                // console.log(url);
                document.getElementById("isipesan").value = "";
                }
            });
        }
        // var modal = document.getElementById("myModal");
        // var btn = document.getElementById("myBtn");
        // var span = document.getElementsByClassName("closess")[0];
        
        //     btn.onclick = function() {
        //         modal.style.display = "block";
        //     }
        //     span.onclick = function() {
        //         modal.style.display = "none";
        //     }
        //     window.onclick = function(event) {
        //         if (event.target == modal) {
        //             modal.style.display = "none";
        //         }
        //     }
        function sendseller(){
            $.ajax({
                type: "get",
                url: "Ajax/loadseller.asp?idseller="+document.getElementById("idseller").value+"&namaseller="+document.getElementById("namaseller").value,
                success: function (url) {
                    // console.log(url);
                    Swal.fire({
                    icon: 'success',
                    text: 'Nama Seller (Toko) Berhasil Didaftarkan , Silahkan Untuk Menambahkan Alamat Pengiriman'
                });
                    
                }
            });
        }
           function updateTimer() {
    future = Date.parse("jun 12, 2022 01:30:00");
 now = new Date();
 diff = future - now;

 days = Math.floor(diff / (1000 * 60 * 60 * 24));
 hours = Math.floor(diff / (1000 * 60 * 60));
 mins = Math.floor(diff / (1000 * 60));
 secs = Math.floor(diff / 1000);

 d = days;
 h = hours - days * 24;
 m = mins - hours * 60;
 s = secs - mins * 60;

 document.getElementById("timer")
  .innerHTML =
  '<div class="text-center">' + d + '</div>' +
  '<div class="text-center">' + h + '</div>' +
  '<div class="text-center">' + m + '</div>' +
  '<div class="text-center">' + s + '</div>';
}
setInterval('updateTimer()', 1000);
    </script>                   
</html>