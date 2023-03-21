<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="basic.css">
        <link rel="stylesheet" type="text/css" href="../../fontawesome/css/all.min.css">
        <script src="../../js/jquery-3.6.0.min.js"></script>

        <title>PIGO</title>
    </head>
<body>
    <!--Breadcrumb-->
    <div class="container mt-3">
        <div class="navigasi" >
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb ">
                    <li class="breadcrumb-item">
                    <a href="../../Seller/" >Promosi</a></li>
                    <li class="breadcrumb-item"><a href="" >Basic Promo</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <hr size="10px" color="#ececec">
    
    <!--Body Seller-->
    <div class="container" style=" background-color:white; padding: 10px 50px">
        <div class="judul-produk" style=" background-color:white" >
            <div class="row">
                <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                    <h5 class="text-kategori">Basic Promo</h5>
                </div>
                <div class="col-lg-0 col-md-0 col-sm-0 col-8 ">
                    <div class="row">
                        <div class="col-4">
                            <span> Status Promo </span>
                        </div>
                        <div class="col-8 mb-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" style="width:40px; height:20px">
                            </div>
                        </div>
                        <div class="col-12 mb-3">
                            <span> Nama Promo </span>
                            <input type="text" class="form-control">
                        </div>
                        <div class="col-12">
                            <span> Keterangan Promo </span>
                            <textarea class="form-control">Fitur Basic Promo digunakan untuk memberikan potongan harga pada setiap transaksi tanpa batasan waktu, namun fitur ini dapat diaktifkan atau dinon-aktifkan kapanpun.</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row mt-3">
                <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                    <h5 class="text-kategori">Jenis Promo</h5>
                </div>
                <div class="col-lg-0 col-md-0 col-sm-0 col-8 mb-3">
                    <span> Jumlah Potongan (%)</span>
                    <input type="text" class="form-control">
                </div>
            <hr>
            <div class="row mt-1">
                <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                    <h5 class="text-kategori">Upload Banner Promosi</h5>
                </div>
                <div class="col-lg-0 col-md-0 col-sm-0 col-8 ">
                    <label for="firstimg4">
                    <img src="" id="output4" style="border:3px solid #f5f5f5; width:41rem; height:100px; border-radius:20px">
                    </label>
                    <input type="file" name="firstimg4" id="firstimg4" style="display:none" onchange="loadFile4(event)"><br>
                    <textarea name="image4" id="base64_4" rows="1"style="display:none"   ></textarea>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-lg-0 col-md-0 col-sm-0 col-4">
            <button> Simpan Promo </button>
                </div>
            </div>

            
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../../js/bootstrap.js"></script>
    <script src="../../js/popper.min.js"></script>
</html>