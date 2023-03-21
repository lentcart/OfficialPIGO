<!--#include file="../connections/pigoConn.asp"-->
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Otopigo</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/stylehome.css">
    <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
    
<!-- load-->
    <script>
        var produkk = document.querySelectorAll('.produkk');
        var btn = document.querySelector('.btn');
        var currentimg = 2 btn.addEventListener('click',function() {
            for (var i = currentimg; i < currentimg + 2; i++) {
                if(produkk[i]) {
                    produkk[i].style.display = 'block';
                }
            }
            currentimg += 2;
            if (currentimg >= produkk.length) {
                event.target.style.display = 'none';
            }
            
        });
    </script>
        
    
    </head>
<body>
    <!--#include file="../header.asp"-->
        

    
    
    <!-- Carousel -->
    
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="container">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
                </div>
                
                <div class="carousel-inner">
                    <div class="carousel-item active">
                    <img src="assets/banner/banner1.jpg" class="d-block img-fluid" alt="..." class="img-banner" width="100%">
                    </div>
                    <div class="carousel-item">
                    <img src="assets/banner/banner2.jpg" class="d-block img-fluid" alt="..." class="img-banner" width="100%">
                    </div>
                    <div class="carousel-item">
                    <img src="assets/banner/banner3.jpg" class="d-block img-fluid" alt="..." class="img-banner" width="100%">
                    </div>
                    <div class="carousel-item">
                    <img src="assets/banner/banner4.jpg" class="d-block img-fluid" alt="..." class="img-banner" width="100%">
                    </div>
                    <div class="carousel-item">
                    <img src="assets/banner/banner5.jpg" class="d-block img-fluid" alt="..." class="img-banner" width="100%">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>

    <div class="container head-merk">
        <div class="row text-center row-container justify-content-evenly">
            <div class="col-lg-2 col-md-2 col-sm-2 col-6">
                <div class="menu-kategori">
                    <a href="#"><img src="assets/logo/sepedamotor.png" class="img-categori mt-3"></a>
                    <p class="mt-2">Sepeda Motor</p>
                </div>
            </div>

            <div class="col-lg-2 col-md-2 col-sm-2 col-6">
                <div class="menu-kategori">
                    <a href="#"><img src="assets/logo/bus.png" class="img-categori mt-3"></a>
                    <p class="mt-2">Bus</p>
                </div>
            </div>

            <div class="col-lg-2 col-md-2 col-sm-2 col-6">
                <div class="menu-kategori">
                    <a href="#"><img src="assets/logo/truk.png" class="img-categori mt-3"></a>
                    <p class="mt-2">Truk</p>
                </div>
            </div>

            <div class="col-lg-2 col-md-2 col-sm-2 col-6">
                <div class="menu-kategori">
                    <a href="#"><img src="assets/logo/minibus.png" class="img-categori mt-3"></a>
                    <p class="mt-2">Mini Bus</p>
                </div>
            </div>

            <div class="col-lg-2 col-md-2 col-sm-2 col-6">
                <div class="menu-kategori">
                    <a href="#"><img src="assets/logo/forklift.png" class="img-categori mt-3"></a>
                    <p class="mt-2">Mobil Berat</p>
                </div>
            </div>

            

        </div>
    </div>

        <!--Kategori-->
    <div class="container mt-4">
        <div class="judul-kategori">
            <h5 class="text-kategori">KATEGORI</h5>
        </div>

        <div class="row text-center row-kategori" >
                    <div class="col-lg-12 col-md-12 col-sm-12 " style="overflow-y:auto;" >
                        <table  class="tabel-kategori" >
                            <tr>        
                                <td>
                                    <a href="#"><img src="assets/kategori/toyota.png" class="img-kategori mt-3"></a>
                                    <p >Toyota</p>
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/daihatsu.png" class="img-kategori mt-3"></a>
                                    <p >Daihatsu</p>
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/honda.png" class="img-kategori mt-3"></a>
                                    <p >Honda</p>    
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/mitsubishi.png" class="img-kategori mt-3"></a>
                                    <p >Mitsubishi</p>
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/suzuki.png" class="img-kategori mt-3"></a>
                                    <p >Suzuki</p>
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/jeep.png" class="img-kategori mt-3"></a>
                                    <p >Jeep</p>
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/hino.png" class="img-kategori mt-3"></a>
                                    <p >Hino</p>
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/isuzu.png" class="img-kategori mt-3"></a>
                                    <p >Isuzu</p>
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/wuling.png" class="img-kategori mt-3"></a>
                                    <p >Wuling</p>
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/nissan.png" class="img-kategori mt-3"></a>
                                    <p >Nissan</p>                    
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/datsun.png" class="img-kategori mt-3"></a>
                                    <p >Datsun</p>                    
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/mazda.png" class="img-kategori mt-3"></a>
                                    <p >Mazda</p>                    
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/audi.png" class="img-kategori mt-3"></a>
                                    <p >Audi</p>                    
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/tesla.png" class="img-kategori mt-3"></a>
                                    <p >Tesla</p>                    
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/subaru.png" class="img-kategori mt-3"></a>
                                    <p >Subaru</p>                    
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/volvo.png" class="img-kategori mt-3"></a>
                                    <p >Volvo</p>                    
                                </td>
                                <td>
                                    <a href="#"><img src="assets/kategori/volkswagen.png" class="img-kategori mt-3"></a>
                                    <p >Volkswagen</p>                    
                                </td>
                                    


                            </tr>        
                            <tr>        
                                <td>                    
                                    <a href="#"><img src="assets/kategori/dfsk.png" class="img-kategori mt-3"></a>
                                    <p >DFSK</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/mercedes.png" class="img-kategori mt-3"></a>
                                    <p >Mercedes</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/bmw.png" class="img-kategori mt-3"></a>
                                    <p >BMW</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/ud.png" class="img-kategori mt-3"></a>
                                    <p >UD Trucks</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/chevrolet.png" class="img-kategori mt-3"></a>
                                    <p >Chevrolet</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/hyundai.png" class="img-kategori mt-3"></a>
                                    <p >Hyundai</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/lexus.png" class="img-kategori mt-3"></a>
                                    <p >Lexus</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/tata.png" class="img-kategori mt-3"></a>
                                    <p >Tata</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/mitsubishi.png" class="img-kategori mt-3"></a>
                                    <p >Fuso</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/kia.png" class="img-kategori mt-3"></a>
                                    <p >KIA</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/ford.png" class="img-kategori mt-3"></a>
                                    <p >Ford</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/peugeot.png" class="img-kategori mt-3"></a>
                                    <p >Peugeot</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/porsche.png" class="img-kategori mt-3"></a>
                                    <p >Porsche</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/ferrari.png" class="img-kategori mt-3"></a>
                                    <p >Ferrari</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/jaguar.png" class="img-kategori mt-3"></a>
                                    <p >Jaguar</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/lamborghini.png" class="img-kategori mt-3"></a>
                                    <p >Lamborghini</p>        
                                </td>
                                <td>                    
                                    <a href="#"><img src="assets/kategori/landrover.png" class="img-kategori mt-3"></a>
                                    <p >Land Rover</p>        
                                </td>
                                    
                            </tr>        
                        </table>
                    </div>
            
        </div>   
    </div>

    <!-- Flash Sale -->
    <div class="container">
        <div class="bg-light flashsale">
            <div class="row mx-0 sale mt-2">
                <div class="d-flex  mt-3">
                    <h5 >FLASH SALE</h5>
                    <span >00</span>
                    <span >00</span>
                    <span >00</span>
                </div>
            </div>
            <div class='row mx-0' id="cards">
                <div class='col-sm-12 col-lg-12' style="overflow-y:auto;">
                    <table> 
                        <tr>
                            <td>
                                <div class="card-flashsale">
                                <a href="#">
                                    <div class="card-body">
                                        <div class="diskon-fl">
                                            <span class="font-weight-bold" style="color: #00ffff">35%</span>
                                            <span class="text-white font-weight-bold">OFF</span>
                                        </div>
                                        <div class="image-fl" >
                                            <img src="assets/sparepart/1.png" alt="" style="width:9rem;height:200px;"/>
                                        </div>
                                        <div class="price-fl">
                                            <span>Rp 275.000</span>
                                        </div>
                                        <div class="progress">
                                            <img src="assets/flashsale/petir.png"/>
                                            <span >2 TERJUAL</span>
                                            <div class="progress-on" role="progressbar" style="inherit;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                            
                                        </div>
                                        
                                    </div>
                                </a>
                                </div>
                            </td>
                            <td>
                                <div class="card-flashsale">
                                <a href="#">
                                    <div class="card-body">
                                        <div class="diskon-fl">
                                            <span class="font-weight-bold" style="color: #00ffff">35%</span>
                                            <span class="text-white font-weight-bold">OFF</span>
                                        </div>
                                        <div class="image-fl" >
                                            <img src="assets/sparepart/2.png" alt="" style="width:9rem;height: 200px;"/>
                                        </div>
                                        <div class="price-fl">
                                            
                                            <span>Rp 275.000</span>
                                        </div>
                                        <div class="progress">
                                            <img src="assets/flashsale/petir.png"/>
                                            <span >2 TERJUAL</span>
                                            <div class="progress-on" role="progressbar" style="inherit;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </a>
                                </div>
                            </td>
                            <td>
                                <div class="card-flashsale">
                                <a href="#">
                                    <div class="card-body">
                                        <div class="diskon-fl">
                                            <span class="font-weight-bold" style="color: #00ffff">35%</span>
                                            <span class="text-white font-weight-bold">OFF</span>
                                        </div>
                                        <div class="image-fl" >
                                            <img src="assets/sparepart/3.png" alt="" style="width:9rem;height: 200px;"/>
                                        </div>
                                        <div class="price-fl">
                                            
                                            <span>Rp 275.000</span>
                                        </div>
                                        <div class="progress">
                                            <img src="assets/flashsale/petir.png"/>
                                            <span >2 TERJUAL</span>
                                            <div class="progress-on" role="progressbar" style="inherit;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </a>
                                </div>
                            </td>
                            <td>
                                <div class="card-flashsale">
                                <a href="#">
                                    <div class="card-body">
                                        <div class="diskon-fl">
                                            <span class="font-weight-bold" style="color: #00ffff">35%</span>
                                            <span class="text-white font-weight-bold">OFF</span>
                                        </div>
                                        <div class="image-fl" >
                                            <img src="assets/sparepart/4.png" alt="" style="width:9rem;height: 200px;"/>
                                        </div>
                                        <div class="price-fl">
                                            
                                            <span>Rp 275.000</span>
                                        </div>
                                        <div class="progress">
                                            <img src="assets/flashsale/petir.png"/>
                                            <span >2 TERJUAL</span>
                                            <div class="progress-on" role="progressbar" style="inherit;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </a>
                                </div>
                            </td>
                            <td>
                                <div class="card-flashsale">
                                <a href="#">
                                    <div class="card-body">
                                        <div class="diskon-fl">
                                            <span class="font-weight-bold" style="color: #00ffff">35%</span>
                                            <span class="text-white font-weight-bold">OFF</span>
                                        </div>
                                        <div class="image-fl" >
                                            <img src="assets/sparepart/5.png" alt="" style="width:9rem;height: 200px;"/>
                                        </div>
                                        <div class="price-fl">
                                            
                                            <span>Rp 275.000</span>
                                        </div>
                                        <div class="progress">
                                            <img src="assets/flashsale/petir.png"/>
                                            <span >2 TERJUAL</span>
                                            <div class="progress-on" role="progressbar" style="inherit;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </a>
                                </div>
                            </td>
                            <td>
                                <div class="card-flashsale">
                                <a href="#">
                                    <div class="card-body">
                                        <div class="diskon-fl">
                                            <span class="font-weight-bold" style="color: #00ffff">35%</span>
                                            <span class="text-white font-weight-bold">OFF</span>
                                        </div>
                                        <div class="image-fl" >
                                            <img src="assets/sparepart/6.png" alt="" style="width:9rem;height: 200px;"/>
                                        </div>
                                        <div class="price-fl">
                                            
                                            <span>Rp 275.000</span>
                                        </div>
                                        <div class="progress">
                                            <img src="assets/flashsale/petir.png"/>
                                            <span >2 TERJUAL</span>
                                            <div class="progress-on" role="progressbar" style="inherit;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                            
                                        </div>
                                    </a>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="card-flashsale">
                                <a href="#">
                                    <div class="card-body">
                                        <div class="diskon-fl">
                                            <span class="font-weight-bold" style="color: #00ffff">35%</span>
                                            <span class="text-white font-weight-bold">OFF</span>
                                        </div>
                                        <div class="image-fl" >
                                            <img src="assets/sparepart/7.png" alt="" style="width:9rem;height: 200px;"/>
                                        </div>
                                        <div class="price-fl">
                                            
                                            <span>Rp 275.000</span>
                                        </div>
                                        <div class="progress">
                                            <img src="assets/flashsale/petir.png"/>
                                            <span >2 TERJUAL</span>
                                            <div class="progress-on" role="progressbar" style="inherit;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </a>
                                </div>
                            </td>
                            <td>
                                <div class="card-flashsale">
                                <a href="#">
                                    <div class="card-body">
                                        <div class="diskon-fl">
                                            <span class="font-weight-bold" style="color: #00ffff">35%</span>
                                            <span class="text-white font-weight-bold">OFF</span>
                                        </div>
                                        <div class="image-fl" >
                                            <img src="assets/sparepart/8.png" alt="" style="width:9rem;height: 200px;"/>
                                        </div>
                                        <div class="price-fl">
                                            
                                            <span>Rp 275.000</span>
                                        </div>
                                        <div class="progress">
                                            <img src="assets/flashsale/petir.png"/>
                                            <span >2 TERJUAL</span>
                                            <div class="progress-on" role="progressbar" style="inherit;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </a>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Produk -->
    <div class="container mt-4">
        <div class="judul-produk">
            <h5 class="text-center" style="margin-top: 10px;">PRODUK</h5>
        </div>
            <div class="row produk">
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/15.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span class="terjual"> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/14.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/13.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/11.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/6.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/7.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/8.png" class="card-img-top" alt="">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/9.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/10.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/11.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                    
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                    <a href="singleproduk.asp">
                        <div class="card ">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2 coba">
                    <a href="singleproduk.asp">
                        <div class="card" id="tes">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2 coba">
                    <a href="singleproduk.asp">
                        <div class="card "id="tes">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div><div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2 coba">
                    <a href="singleproduk.asp">
                        <div class="card "id="tes">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div><div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2 coba">
                    <a href="singleproduk.asp">
                        <div class="card "id="tes">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2 coba">
                    <a href="singleproduk.asp">
                        <div class="card produkk">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2 coba">
                    <a href="singleproduk.asp">
                        <div class="card produkk">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2 coba">
                    <a href="singleproduk.asp">
                        <div class="card produkk">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2 coba">
                    <a href="singleproduk.asp">
                        <div class="card produkk">
                            <img src="assets/produk/12.png" class="card-img-top" alt="...">
                            <div class="card-produk">
                                <h6 class="card-title">headset</h6>
                                <p class="price-produk mt-1">Rp100.000</p>
                                <div class="rating">
                                    <img src="assets/produk/icon-star.png" width="16px">
                                    <span> 4.9 </span>
                                    <span> (100) Terjual </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div> 
            <div class="row lainnya1 justify-content-evenly">
                <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                    <button class="btn btn-primary lainnya">Lihat Lainnya</button>
                </div>
            </div>

    </div>
    
    <!-- Popup Chat -->
    <button class="open-button" onclick="openForm()">Chat</button>

    <div class="chat-popup" id="myForm">
    <form action="/action_page.php" class="form-container">
        <h3>Live Chat</h3>

        <label for="msg"><b>Pesan</b></label>
        <textarea placeholder="Silahkan tulis keluhan anda" name="msg" required></textarea>

        <button type="submit" class="btn">Kirim</button>
        <button type="button" class="btn cancel" onclick="closeForm()">Tutup</button>
    </form>
    </div>


    <!--footer/Help -->
    <div class="footer">
        <div class="help">
            <div class="container pt-4">
                <div class="d-flex justify-content-between ">
                    <div class="d-flex flex-column">
                        <p class="title">BANTUAN</p>
                        <a href=""><span class="desc">Pembayaran</span></a>
                        <a href=""><span class="desc">Pengiriman</span></a>
                        <a href=""><span class="desc">Status Pemesanan</span></a>
                        <a href=""><span class="desc">Pengembalian Produk</span></a>
                        <a href=""><span class="desc">Cara Berbelanja</span></a>
                        <a href=""><span class="desc">otopigo.official@gmail.com</span></a>
                    </div>
                    <div class="d-flex flex-column">
                        <p class="tittle">INFO PIGO</p>
                        <a href=""><span class="desc">Tentang Pigo</span></a>
                        <a href=""><span class="desc">Blog Pigo</span></a>
                        <a href=""><span class="desc">Informasi Terbaru</span></a>
                        <a href=""><span class="desc">Karir</span></a>
                        <a href=""><span class="desc">Syarat, Ketentuan & Kebijakan Privasi</span></a>
                    </div>
                    <div class="d-flex flex-column">
                        <p class="tittle">KERJA SAMA</p>
                        <span class="desc"></span>
                    </div>
                    <div class="flex col-xl-3 col-lg-3 col-md-4 col-sm-0">
                        <p class="tittle">DAKOTA GROUP</p>
                        <img src="assets/help/dakota.png" width="60" height="75" style="margin-right: 10px;"  />
                        <img src="assets/help/kurir.png" width="60" height="75" style="margin-right: 10px;" />
                        <img src="assets/help/dli.png" width="60" height="75"/>
                        <img src="assets/help/delima.png" width="210" height="50" style="margin-top: 5px;"/>
                        <img src="assets/help/spim.png" width="115" height="50" style="margin-top: 5px;"/>
                        <img src="assets/help/otopigo.png" width="100"height="60"/>
                        
                    </div>
                    <div class="d-flex flex-column">
                        <p class="tittle">UNDUH APLIKASI</p>
                        <a href="goo"><img src="assets/help/google.png" width="120" /></a>
                        <a href="ios"><img src="assets/help/ios.png" width="120" /></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
        <!--#include file="footer.asp"-->


    


    <!-- Popup iklan -->
    <div class="popbox hide" id="popbox">
        <div aria-label='Close' class="pop-overlay" onclick='document.getElementById("popbox").style.display="none";removeClassonBody();' />
            <div class="pop-content">
                <a href="#" target="_blank" rel="noopener noreferrer" title="">
                    <div class="popcontent">
                        <img src="assets/banner/banner1.jpg" alt="banner" class="rounded" width="100%" />
                    </div>
                    
                </a>
                <button aria-label='Close' class='popbox-close-button' onclick='document.getElementById("popbox").style.display="none";removeClassonBody();'>&times;</button>
            </div>
    </div> 

    <!-- Popup iklan-->
    <script>
        //<![CDATA[
        setTimeout(function(){
        document.getElementById('popbox').classList.remove('hide');
        document.body.className+="flowbox"
        }, 700);
        function removeClassonBody(){var element=document.body;element.className=element.className.replace(/\bflowbox\b/,"")}
        //]]>
    </script>

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
    <script src="../js/bootstrap.js"></script>
    <script src="../js/popper.min.js"></script>

    
    

  </body>
</html>