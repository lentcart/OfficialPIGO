<!doctype html>
<html lang="en">

<head>
  <!--#include file="../connections/cargo.asp"-->
  <title>OTOPIGO</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link href="https://fonts.googleapis.com/css?family=Rubik:300,400,700|Oswald:400,700" rel="stylesheet">

  <link rel="stylesheet" href="fonts/icomoon/style.css">

  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/jquery.fancybox.min.css">
  <link rel="stylesheet" href="css/owl.carousel.min.css">
  <link rel="stylesheet" href="css/owl.theme.default.min.css">
  <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
  <link rel="stylesheet" href="css/aos.css">

  <!-- MAIN CSS -->
  <link rel="stylesheet" href="css/style.css">


  <script>

    function traceBTT(btt) {
      var btt = btt;
      var xmlhttp;
      if (btt == "") {
        document.getElementById("resultbtt").innerHTML = "";
        return;
      }
      if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
      }
      else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
          document.getElementById("resultbtt").innerHTML = xmlhttp.responseText;
        }
      }
      xmlhttp.open("GET", "result.asp?b=" + btt, true);
      xmlhttp.send();

    }

  </script>

  <script>
    function checktarif(asal, tuj, kdpos) {
      var asal = asal;
      var tuj = tuj;
      var kdpos = kdpos;
      var xmlhttp;
      if (kdpos == "") {
        document.getElementById("tarifdasar").innerHTML = "";
        return;
      }
      if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
      }
      else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
          document.getElementById("tarifdasar").innerHTML = xmlhttp.responseText;
        }
      }
      xmlhttp.open("GET", "get-harga-pokok-from-all.asp?tagen=" + asal + "&tuj=" + tuj + "&tujKdpos=" + kdpos, true);
      xmlhttp.send();

    }
  </script>


</head>

<div class="site-wrap" id="home-section">
  <div class="site-mobile-menu site-navbar-target">
    <div class="site-mobile-menu-header">
      <div class="site-mobile-menu-close mt-3">
        <span class="icon-close2 js-menu-toggle"></span>
      </div>
    </div>
    <div class="site-mobile-menu-body"></div>
  </div>

  <div class="top-bar">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <a href="#" class=""><span class="mr-2  icon-envelope-open-o"></span> <span
              class="d-none d-md-inline-block">dakota.cargo@gmail.com</span></a>
          <span class="mx-md-2 d-inline-block"></span>
          <a href="#" class=""><span class="mr-2  icon-phone"></span> <span class="d-none d-md-inline-block">0811 8989
              770 </span></a>


          <div class="float-right">

            <a href="#" class=""><span class="mr-2  icon-instagram"></span> <span
                class="d-none d-md-inline-block">Instagram</span></a>
            <span class="mx-md-2 d-inline-block"></span>
            <a href="#" class=""><span class="mr-2  icon-facebook"></span> <span
                class="d-none d-md-inline-block">Facebook</span></a>

          </div>

        </div>

      </div>

    </div>
  </div>

  <header class="site-navbar js-sticky-header site-navbar-target" role="banner">

    <div class="container">
      <div class="row align-items-center position-relative">


        <div class="site-logo" style="color:#1eda0d;">
          OTOPIGO
        </div>

        <div class="col-12">
          <nav class="site-navigation text-right ml-auto " role="navigation">
            <ul class="site-menu main-menu js-clone-nav ml-auto d-none d-lg-block">
              <li><a href="#home-section"><span class="mr-2 icon-home">Home</a></li>


              <li class="has-children">
                <a href="#about-section"><span class="mr-2 icon-person">About Us</a>
                <ul class="dropdown arrow-top">
                  <li><a href="#Dakota-Group-section" class="nav-link">Dakota Group</a></li>

              </li>
            </ul>
            </li>

            <li><a href="#why-us-section"><span class="mr-2 icon-building">Why Us</a></li>
            <li><a href="#contact-section"><span class="mr-2 icon-phone">Contact</a></li>
            </ul>
          </nav>

        </div>

        <div class="toggle-button d-inline-block d-lg-none"><a href="#"
            class="site-menu-toggle py-5 js-menu-toggle text-black"><span class="icon-menu h3"></span></a></div>

      </div>

  </header>

  <div class="ftco-blocks-cover-1">

    <div class="ftco-cover-1 overlay" style="background-image: url('https://source.unsplash.com/pSyfecRCBQA/1920x780')">

      <nav class="navbar navbar-dark">
        <div class="container-fluid">
          <form class="d-flex">
            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-light bg-dark" type="submit"><span class="icon-search"></span></button>
          </form>
        </div>


        <div class="margin-top">
          <div class="col-lg-3">

            <div class="card" style="width: 5rem;">
              <div class="card-body">
                <a href="https://www.youtube.com/" class="btn btn-primary"><span class="icon-car"></span></a>
              </div>
            </div>
          </div>

          <div class="margin-top">
            <div class="col-lg-8">

              <div class="card" style="width: 5rem;">
                <div class="card-body">
                  <a href="https://www.youtube.com/" class="btn btn-primary">
                    <span class="icon-phone"></span></a>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img src="images/artikel_1.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
              <img src="images/armada_udara.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
              <img src="..." class="d-block w-100" alt="...">
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls"
            data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls"
            data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
    </div>



    <!-- END .ftco-cover-1 -->
    <div class="ftco-service-image-1 pb-5">
      <div class="container">
        <div class="owl-carousel owl-all">
          <div class="service text-center">
            <a href="#"><img src="images/armada_laut.jpg" alt="Image" class="img-fluid"></a>
            <div class="px-md-3">
              <h3><a href="">Layanan Laut</a></h3>
              <p>Pengiriman via laut barang atau cargo yang dikirim melalui armada kapal laut.</p>
            </div>
          </div>
          <div class="service text-center">
            <a href="#"><img src="images/armada_udara.jpg" alt="Image" class="img-fluid"></a>
            <div class="px-md-3">
              <h3><a href="#">Layanan Udara</a></h3>
              <p>Produk dari suatu maskapai penerbangan. Di setiap rute penerbangan, mereka menurunkan atau mengangkut
                cargo untuk dikirim ke wilayah lainnya.</p>
            </div>
          </div>
          <div class="service text-center">
            <a href="#"><img src="images/armada_darat.jpg" alt="Image" class="img-fluid"></a>
            <div class="px-md-3">
              <h3><a href="#">Layanan Darat</a></h3>
              <p>Pengiriman barang-barang melalui jalur darat. Biasanya memakai armada truck untuk pengangkutan dalam
                jumlah besar hal ini membaut harga cargo relatif lebih murah dan lebih hemat.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>


  <div class="site-section" id="about-section">

    <div class="container">
      <div class="row mb-5 justify-content-center">
        <div class="col-md-7 text-center">
          <div class="block-heading-1" data-aos="fade-up" data-aos-delay="">


            <div class="site-section" id="Dakota-Group-section">
              <div class="container">
                <div class="row mb-5 justify-content-center">
                  <div class="col-md-7 text-center">
                    <div class="block-heading-1" data-aos="fade-up" data-aos-delay="">
                      <h2>DAKOTA GROUP</h2>
                      <p></p>
                    </div>
                  </div>
                </div>

                <div class="owl-carousel owl-all">
                  <div class="block-team-member-1 text-center rounded h-100">
                    <figure>
                      <img src="images/person_1.jpg" alt="Image" class="img-fluid rounded-circle">
                    </figure>
                    <h3 class="font-size-20 text-black">PT. DAKOTA BUANA SEMESTA</h3>
                    <span class="d-block font-gray-5 letter-spacing-1 text-uppercase font-size-12 mb-3">Dakota
                      Cargo</span>
                    <p class="mb-4">Berdiri Sejak 5 Desember 1996</p>
                    <p class="mb-4">Visi</p>
                    <p class="mb-4">Menjadi perusahaan jasa titipan terbaik di Indonesia dalam pengertian mutu.</p>
                    <p class="mb-4">Misi</p>
                    <p class="mb-4">Melayani kebutuhan logistik barang yang berkesinambungan keseluruh Indonesia
                      dengan memberikan jaminan bahwa barang tepat berada ditempat yang tepat.</p>
                    <div class="block-social-1">
                      <a href="#" class="btn border-w-2 rounded primary-primary-outline--hover"><span
                          class="icon-facebook"></span></a>
                      <a href="#" class="btn border-w-2 rounded primary-primary-outline--hover"><span
                          class="icon-twitter"></span></a>
                      <a href="#" class="btn border-w-2 rounded primary-primary-outline--hover"><span
                          class="icon-instagram"></span></a>
                    </div>
                  </div>

                  <div class="block-team-member-1 text-center rounded h-100">
                    <figure>
                      <img src="images/person_2.jpg" alt="Image" class="img-fluid rounded-circle">
                    </figure>
                    <h3 class="font-size-20 text-black">PT. DAKOTA LOGISTIK INDONESIA</h3>
                    <span class="d-block font-gray-5 letter-spacing-1 text-uppercase font-size-12 mb-3">Dakota
                      Logistik</span>
                    <p class="mb-4">Berdiri Sejak 14 Juni 2010</p>
                    <p class="mb-4">Visi</p>
                    <p class="mb-4">Menjadi perusahaan logistik yang dapat mendistribusikan barang ke seluruh pelosok
                      tanah air.</p>
                    <p class="mb-4">Misi</p>
                    <p class="mb-4">Melaksanakan pengiriman yang sesuai yaitu pada tempat yang tepat, pada waktu yang
                      tepat dan pada kondisi yang diinginkan, sehingga memberikan manfaat bagi pelanggan</p>
                    <div class="block-social-1">
                      <a href="#" class="btn border-w-2 rounded primary-primary-outline--hover"><span
                          class="icon-facebook"></span></a>
                      <a href="#" class="btn border-w-2 rounded primary-primary-outline--hover"><span
                          class="icon-twitter"></span></a>
                      <a href="#" class="btn border-w-2 rounded primary-primary-outline--hover"><span
                          class="icon-instagram"></span></a>
                    </div>
                  </div>

                  <div class="block-team-member-1 text-center rounded h-100">
                    <figure>
                      <img src="images/person_3.jpg" alt="Image" class="img-fluid rounded-circle">
                    </figure>
                    <h3 class="font-size-20 text-black">PT. DAKOTA LINTAS BUANA</h3>
                    <span class="d-block font-gray-5 letter-spacing-1 text-uppercase font-size-12 mb-3">Dakota
                      Courier</span>
                    <p class="mb-4">Berdiri Sejak 14 Juni 2010</p>
                    <p class="mb-4">Visi</p>
                    <p class="mb-4">Menjadi perusahaan jasa kurir pilihan pertama komsumen indonesia .</p>
                    <p class="mb-4">Misi</p>
                    <p class="mb-4">Menjadi perusahaan jasa kurir pilihan pertama konsumen Indonesia Tepat Waktu,
                      harga Kompetitif, Kepuasan Pelanggan dan Luas Jangkauannya Yang Tersedia Di Seluruh indonesia.
                    </p>
                    <p class="mb-4"></p>
                    <div class="block-social-1">
                      <a href="#" class="btn border-w-2 rounded primary-primary-outline--hover"><span
                          class="icon-facebook"></span></a>
                      <a href="#" class="btn border-w-2 rounded primary-primary-outline--hover"><span
                          class="icon-twitter"></span></a>
                      <a href="#" class="btn border-w-2 rounded primary-primary-outline--hover"><span
                          class="icon-instagram"></span></a>
                    </div>
                  </div>
                </div>
              </div>






              <footer class="site-footer">
                <div class="container">
                  <div class="row">
                    <div class="col-md-6">
                      <div class="row">
                        <div class="col-md-7">
                          <h2 class="footer-heading mb-4">OTOPIGO</h2>
                          <p>Percayakan Pengiriman anda kepada DAKOTA GROUP
                            Kami Akan Melayani Setulus Hati. </p>
                        </div>
                        <div class="col-md-4 ml-auto">
                          <ul class="list-unstyled">
                        </div>

                      </div>
                    </div>
                    <div class="col-md-4 ml-auto">

                      <div class="mb-5">
                        <h2 class="footer-heading mb-4">Subscribe to Newsletter</h2>
                        <form action="#" method="post" class="footer-suscribe-form">
                          <div class="input-group mb-3">
                            <input type="text" class="form-control border-secondary text-white bg-transparent"
                              placeholder="Enter Email" aria-label="Enter Email" aria-describedby="button-addon2">
                            <div class="input-group-append">
                              <button class="btn btn-primary text-white" type="button"
                                id="button-addon2">Subscribe</button>
                            </div>
                          </div>
                      </div>


                      <h2 class="footer-heading mb-4">Follow Us</h2>
                      <a href="#about-section" class="smoothscroll pl-0 pr-3"><span class="icon-facebook"></span></a>
                      <a href="#" class="pl-3 pr-3"><span class="icon-twitter"></span></a>
                      <a href="#" class="pl-3 pr-3"><span class="icon-instagram"></span></a>
                      <a href="#" class="pl-3 pr-3"><span class="icon-linkedin"></span></a>
                      </form>
                    </div>
                  </div>

                  <div class="row pt-50 mt-50 text-center">
                    <div class="col-md-12">
                      <div class="border-top pt-5">
                        <p class="copyright">
                          <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                          Copyright &copy;
                          <script>document.write(new Date().getFullYear());</script> All rights reserved <a
                            href="https://colorlib.com" target="_blank">DAKOTA GROUP</a>
                          <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </p>
                      </div>
                    </div>

                  </div>
                </div>
              </footer>

            </div>

            <script src="js/jquery-3.3.1.min.js"></script>
            <script src="js/popper.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script src="js/owl.carousel.min.js"></script>
            <script src="js/jquery.sticky.js"></script>
            <script src="js/jquery.waypoints.min.js"></script>
            <script src="js/jquery.animateNumber.min.js"></script>
            <script src="js/jquery.fancybox.min.js"></script>
            <script src="js/jquery.easing.1.3.js"></script>
            <script src="js/aos.js"></script>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
              integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
              crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
              integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
              crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
              integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
              crossorigin="anonymous"></script>
            <script src="js/main.js"></script>


            </body>

</html>