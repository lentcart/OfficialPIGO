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

        <title>Otopigo</title>
    </head>
    <body>

    <!--#include file="header.asp"-->
    
    <!--Breadcrumb-->
    <div class="container">
        <div class="navigasi">
            <nav aria-label="breadcrumb" >
            <ol class="breadcrumb ">
                <li class="breadcrumb-item"><a href="index.asp" >Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Produk</li>
            </ol>
            </nav>
        </div>
    </div>
    <!-- Single Produk -->
    <div class="container">
        <div class="row bg-produk">
            <div class="col-lg-5 ">
                <figure class="figure">
                    <img src="assets/produk/15.png" class="figure-img img-fluid" id="imgbox" alt="">
                    <figcaption class="small d-flex justify-content-evenly">
                            <img src="assets/produk/1.png" class="figure-img img-fluid " alt="" onclick="BoxImg(this)">
                            <img src="assets/produk/2.png" class="figure-img img-fluid " alt="" onclick="BoxImg(this)">
                            <img src="assets/produk/3.png" class="figure-img img-fluid " alt="" onclick="BoxImg(this)">
                            <img src="assets/produk/4.png" class="figure-img img-fluid " alt="" onclick="BoxImg(this)">
                            <img src="assets/produk/5.png" class="figure-img img-fluid " alt="" onclick="BoxImg(this)">
                    </figcaption>
                </figure>
            </div>
            
            <div class="col-lg-7">
                <h5>Spare Part</h5>
                     <div class="rating">
                        <span> 5.0 </span>
                        <img src="assets/produk/icon-star.png" width="16px">
                        <img src="assets/produk/icon-star.png" width="16px">
                        <img src="assets/produk/icon-star.png" width="16px">
                        <img src="assets/produk/icon-star.png" width="16px">
                        <img src="assets/produk/icon-star.png" width="16px">
                        <span class="garis-vertikal">  |  </span>
                        <span class="terjual"> 3RB Penilaian </span>
                        <span class="garis-vertikal">  |  </span>
                        <span class="terjual"> 6,7 Terjual </span>
                        </div>
                    <hr>
                    <h4 class="text-muted mb-3"><del>Rp 100.000</del> Rp 50.000<h4>

                    <button type="button" class="btn btn-dark btn-sm"><i class="fas fa-minus"></i></button>
                    <span class="mx-2">2</span>
                    <button type="button" class="btn btn-danger btn-sm"><i class="fas fa-plus text-white"></i></button>
                    <span class="mx-2">Tersisa 10 buah</span>

                    <div class="btn-produk mt-4">
                        <a href="keranjang.asp" class="btn btn-dark text-white btn-lg me-2"><i class="fas fa-shopping-cart fs-6 me-2"></i>Masukkan Keranjang</a>
                        <a href="#" class="btn btn-danger text-white btn-lg ">Beli Sekarang</a>
                    </div>
                
            </div>
        </div>

        <!--Deskripsi-->
        <div class="row desc-produk">
            <div class="col-12">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-items" role="presentation">
                        <button class="nav-link active" id="deskripsi-tab" data-bs-toggle="tab" data-bs-target="#deskripsi" type="button" role="tab" aria-controls="deskripsi" aria-selected="true">Deskripsi Produk</button>
                    </li>
                    <li class="nav-items" role="presentation">
                        <button class="nav-link" id="review-tab" data-bs-toggle="tab" data-bs-target="#review" type="button" role="tab" aria-controls="review" aria-selected="false">Review Produk</button>
                    </li>
                    
                </ul>
                    <div class="tab-content p-3" id="myTabContent">
                        <div class="tab-pane fade show active deskripsi" id="deskripsi" role="tabpanel" aria-labelledby="deskripsi-tab">
                            <p> Dimana mampu menggugah minat serta perasaan pembacanya. 
                                Contohnya saja ketika Freebuddies menjual camilan sehat 
                                maka cobalah sisipkan kata seperti lembut, crunchy atau kriuk, garing, dan sebagainya.
                                Dimana mampu menggugah minat serta perasaan pembacanya. 
                                Contohnya saja ketika Freebuddies menjual camilan sehat 
                                maka cobalah sisipkan kata seperti lembut, crunchy atau kriuk, garing, dan sebagainya.
                                Dimana mampu menggugah minat serta perasaan pembacanya. 
                                Contohnya saja ketika Freebuddies menjual camilan sehat 
                                maka cobalah sisipkan kata seperti lembut, crunchy atau kriuk, garing, dan sebagainya.
                                Dimana mampu menggugah minat serta perasaan pembacanya. </br>
                                Contohnya saja ketika Freebuddies menjual camilan sehat </br>
                                maka cobalah sisipkan kata seperti lembut, crunchy atau kriuk, garing, dan sebagainya.</br>
                                Dimana mampu menggugah minat serta perasaan pembacanya. </br>
                                Contohnya saja ketika Freebuddies menjual camilan sehat </br>
                                maka cobalah sisipkan kata seperti lembut, crunchy atau kriuk, garing, dan sebagainya.</br>Dimana mampu menggugah minat serta perasaan pembacanya. </br>
                                Contohnya saja ketika Freebuddies menjual camilan sehat </br>
                                maka cobalah sisipkan kata seperti lembut, crunchy atau kriuk, garing, dan sebagainya.</br>
                            </p>
                        </div>

                        <div class="tab-pane fade review" id="review" role="tabpanel" aria-labelledby="review-tab">
                            <div class="row">
                                <div class="col-lg-1   img-review">
                                    <img src="assets/3.png" class="review-img rounded-circle">
                                    
                                </div>
                                <div class="col-lg-11   name-star">
                                    <h5 class="review-name">Nama</h5>
                                    <img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px">
                                    </div>
                                <div class="col">
                                    <p class="review-desc">cepat,aman,original,bagus terbaik sellermanatapajijwaahbcbubcbhbvdhvbjevbbvbjvbddhvsdvsdvbhvbehfbskdfubsjkgdsjbsdfu</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-1 col-md-2 col-sm-2 img-review">
                                    <img src="assets/3.png" class="review-img rounded-circle">
                                    
                                </div>
                                <div class="col-lg-11 col-md-10 col-sm-10 name-star">
                                    <h5 class="review-name">Nama</h5>
                                    <img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px">
                                    </div>
                                <div class="col">
                                    <p class="review-desc">cepat,aman,original,bagus terbaik sellermanatapajijwaahbcbubcbhbvdhvbjevbbvbjvbddhvsdvsdvbhvbehfbskdfubsjkgdsjbsdfu</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-1 col-md-2 col-sm-2 img-review">
                                    <img src="assets/3.png" class="review-img rounded-circle">
                                    
                                </div>
                                <div class="col-lg-11 col-md-10 col-sm-10 name-star">
                                    <h5 class="review-name">Nama</h5>
                                    <img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px">
                                    </div>
                                <div class="col">
                                    <p class="review-desc">cepat,aman,original,bagus terbaik sellermanatapajijwaahbcbubcbhbvdhvbjevbbvbjvbddhvsdvsdvbhvbehfbskdfubsjkgdsjbsdfu</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-1 col-md-2 col-sm-2 img-review">
                                    <img src="assets/3.png" class="review-img rounded-circle">
                                    
                                </div>
                                <div class="col-lg-11 col-md-10 col-sm-10 name-star">
                                    <h5 class="review-name">Nama</h5>
                                    <img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px">
                                    </div>
                                <div class="col">
                                    <p class="review-desc">cepat,aman,original,bagus terbaik sellermanatapajijwaahbcbubcbhbvdhvbjevbbvbjvbddhvsdvsdvbhvbehfbskdfubsjkgdsjbsdfu</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-1 col-md-2 col-sm-2 img-review">
                                    <img src="assets/3.png" class="review-img rounded-circle">
                                    
                                </div>
                                <div class="col-lg-11 col-md-10 col-sm-10 name-star">
                                    <h5 class="review-name">Nama</h5>
                                    <img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px"><img src="assets/produk/icon-star.png" width="16px">
                                    </div>
                                <div class="col">
                                    <p class="review-desc">cepat,aman,original,bagus terbaik sellermanatapajijwaahbcbubcbhbvdhvbjevbbvbjvbddhvsdvsdvbhvbehfbskdfubsjkgdsjbsdfu</p>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>


    </div>



    <!-- Footer -->

    <!--#include file="footer.asp"-->

    <!-- Images -->
    <script>
        function BoxImg(smallimg) {
            var fullimg = document.getElementById("imgbox");
            fullimg.src = smallimg.src;    
        }
    </script>






    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="js/bootstrap.js"></script>
    <script src="js/popper.min.js"></script>


  </body>
</html>