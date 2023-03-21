 <!--#include file="../Connections/pigoConn.asp" -->
<!doctype html>
<html lang="en">

    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Otopigo</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="bantuan.css">
    <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
    
<!-- load-->
    <script>
        function load() {
        var dots = document.getElementById("dots");
        var moreText = document.getElementById("more");
        var btnText = document.getElementById("myBtn");

        if (dots.style.display === "none") {
            dots.style.display = "inline";
            moreText.style.display = "none";
        } else {
            dots.style.display = "none"; 
            moreText.style.display = "inline";
        }
        } console.log("ok");
    </script>
        
    
    </head>
<body>
    <!-- Header Bantuan -->
    <div class="header">
        <div class="container"> 
            <div class="row align-items-center">
                <div class="logo col-lg-0 col-md-0 col-sm-0 col-3 mb-2 mt-2">
                    <a class="logo" href="#" style="margin-left:10px">
                        <img src="<%=base_url%>/assets/logo1.jpg" class="rounded-pill" class="logo" alt="" width="65" height="65" />
                    </a>
                </div>
            </div>
        </div>
    </div>

    
    <!-- Body Bantuan PIGO -->
    <div class="container" >
        <div class="navigasi">
            <div class="judul-produk"   style="background-color:#f8f8f">
                <span  class="judul-bantuan">Selamat Pagi, </span><br>
                <span style="font-size:30px"> Ada yang bisa kami bantu ?</span>                  
            </div>
            <div class="col-8 ">
                <form class="d-flex ms-auto my-2 ">
                    <input class="form-control" type="search" placeholder="Ketik Kata Kunci" aria-label="Search">
                    <div class="button">
                        <button class="btn btn-light" type="submit"><i class="fas fa-search" style="height:26px"></i></button>
                    </div>
                </form>
            </div>
                <h5 class="text-left" style="margin-top: 90px; margin-bottom:35px">Pilih Topik Sesuai Kendala Kamu </h5>
                    <div class="row bantuan justify-content-evenly">
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdr ">
                            <img src="<%=base_url%>/assets/logo1.jpg" class="img-fluid" alt="" style="width:50px; height:50px"><span> Akun Saya </span>
                        </div>
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdr ">
                            <img src="<%=base_url%>/assets/logo1.jpg" class="img-fluid" alt="" style="width:50px; height:50px"><span> Pesanan Saya </span>
                        </div>
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdr ">
                            <img src="<%=base_url%>/assets/logo1.jpg" class="img-fluid" alt="" style="width:50px; height:50px"><span> Pembayaran </span>
                        </div>
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdr ">
                            <img src="<%=base_url%>/assets/logo1.jpg" class="img-fluid" alt="" style="width:50px; height:50px"><span> Pengiriman </span>
                        </div>
                    </div>
                    <div class="row bantuan justify-content-evenly">
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdr ">
                            <img src="<%=base_url%>/assets/logo1.jpg" class="img-fluid" alt="" style="width:50px; height:50px"><span> Pengembalian Dana </span>
                        </div>
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdr ">
                            <img src="<%=base_url%>/assets/logo1.jpg" class="img-fluid" alt="" style="width:50px; height:50px"><span> Komplain Pesanan </span>
                        </div>
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdr ">
                            <img src="<%=base_url%>/assets/logo1.jpg" class="img-fluid" alt="" style="width:50px; height:50px"><span> Promosi </span>
                        </div>
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdr ">
                            <img src="<%=base_url%>/assets/logo1.jpg" class="img-fluid" alt="" style="width:50px; height:50px"><span> lainnya </span>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="row bantuan justify-content-evenly">
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdrr ">
                           <img src="assets/logo1.jpg" class="img-fluid" alt="" style="width:80px; height:80px"><span> Riwayat Komplain</span>
                        </div>
                        <div class="col-lg-4 col-md-2 col-sm-3 col-4 mt-2 bdrr ">
                        <span> FAQ (Tanya Jawab)<br> Punya pertanyaan mengenai PIGO? </span>
                        </div>
                        </div>
                    </div>
            </div>
        </div>
    </div>
        
        <div class="bg-light p-4 mt-2">
                    <div class="container">
                        <div class="row mt-2">
                            <div class="col-md-8 text-md-start text-center pt-2 pb-2">
                                <a class="text-decoration-none">
                                    <img src="<%=base_url%>/assets/logo.png" style="width: 80px;">
                                </a>
                                <span class="ps-1"> &copy; Otopigo 2021. | Hak Cipta Dilindungi</span>
                            </div>

                            <div class="col-md-4 text-md-end text-center pt-2 pb-2">
                                <a href="#" class="text-decoration-none">
                                    <img src="<%=base_url%>/sosialmedia/fb.png" class="ms-2" style="width: 30px;">
                                </a>
                                <a href="#" class="text-decoration-none">
                                    <img src="<%=base_url%>/sosialmedia/ig.png" class="ms-2" style="width: 30px;">
                                </a>
                                <a href="#" class="text-decoration-none">
                                    <img src="<%=base_url%>/sosialmedia/yt.png" class="ms-2" style="width: 35px;">
                                </a>
                            </div>
                        </div>
                    </div>
        </div>
    </div>
  </body>

    <!-- chat-->
    <script>
        function openForm() {
        document.getElementById("myForm").style.display = "block";
        }

        function closeForm() {
        document.getElementById("myForm").style.display = "none";
        }
    </script>
        <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>                            
    <script src="<%=base_url%>/js/popper.min.js"></script>
</html>