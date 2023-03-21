<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Otopigo</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/styleproduk.css">
    <link rel="stylesheet" type="text/css" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/stylehome.css">
    <link rel="stylesheet" type="text/css" href="css/pengiriman.css">
    <script src="js/jquery-3.6.0.min.js"></script>

    <script>
    $(document).ready(function(){
        $(".search-alamat").change(function(){
            alert("OK");
        })
    });
      function pembayaran(){
            let pem= document.getElementsByClassName("pm");

            document.getElementById("btn-go").style.display = "block";
            document.getElementById("gop").style.display = "none";
      }
      function alamat(){
            let pem= document.getElementsByClassName("pm");

            document.getElementById("alm").style.display = "block";
            document.getElementById("almt").style.display = "none";
      }
       function gopay(e){
            let go = "gopay";
            let ovo ="OVO";
            let Gpl ="GoPayLatter";

            if (e == "1"){
                document.getElementById("gop").style.display = "block";
                document.getElementById("gop").innerHTML = go;
            }else if (e == "2"){
                document.getElementById("gop").style.display = "block";
                document.getElementById("gop").innerHTML = ovo;
                
            }else{
                document.getElementById("gop").style.display = "block";
                document.getElementById("gop").innerHTML = Gpl;
                
            }
            document.getElementById("btn-go").style.display = "none";
      }
      function pembiayaan(){
            let pe= document.getElementsByClassName("instan");
            console.log("ok");
            document.getElementById("instan").style.display = "block";
      }
      function tes() {
        let btnPls = document.getElementsByTagName("btn-keranjang-plus");
        let input = document.getElementById("tes").value;
        
        if (input === input){
            input++;
            document.getElementById("tes").value = input++;
        }
        
    }
    function tes2() {
        
        let input = document.getElementById("tes").value;

        if (input === input){
            input--;
            if (input<=0){
                 document.getElementById("tes").value = 0 ;
            }else{
                document.getElementById("tes").value = input--;
            }
            

        }
        
    }
    
     </script>
    <style>

        body {
        margin: 0;
        font-family: Arial, Helvetica, sans-serif;
        }

        .topnav {
        overflow: hidden;
        background-color: #e9e9e9;
        }

        .topnav a {
        float: left;
        display: block;
        color: black;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        font-size: 17px;
        }

        .topnav a:hover {
        background-color: #ddd;
        color: black;
        }

        .topnav a.active {
        background-color: #2196F3;
        color: white;
        }

        .topnav .search-container {
        float: right;
        }

        .topnav input[type=text] {
        padding: 6px;
        margin-top: 8px;
        font-size: 17px;
        border: none;
        }

        .topnav .search-container button {
        float: right;
        padding: 6px 10px;
        margin-top: 8px;
        margin-right: 16px;
        background: #ddd;
        font-size: 17px;
        border: none;
        cursor: pointer;
        }

        .topnav .search-container button:hover {
        background: #ccc;
        }

        @media screen and (max-width: 600px) {
        .topnav .search-container {
            float: none;
        }
        .topnav a, .topnav input[type=text], .topnav .search-container button {
            float: none;
            display: block;
            text-align: left;
            width: 100%;
            margin: 0;
            padding: 14px;
        }
        .topnav input[type=text] {
            border: 1px solid #ccc;  
        }
        }
    
    {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=submit] {
  background-color: #04AA6D;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container-pm {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
    .btn-keranjang-plus{
        border-radius:50px;
    }
    .btn-keranjang-minus{
        border-radius:50px;
    }
    
    #tes {
    width: 25px;
    border:none;
    text-align:center;
}
    </style>
  </head>
  <body>
    <!--Header-->
    <div class="header">
        <div class="container">
            <div class="navbar d-flex justify-content-between align-items-center navbar-dark bg-info head-navbar">
                
                    <div class="d-flex align-items-center" class="icon">
                        <a class="nav-link active" href="#">
                            <a href="singleproduk.asp"> <img class="icon-media mr-2 ml-2" src="assets/logo/back.png"alt=""/><span class="header-font">Pengiriman</span></a>
                            
                    </div>
            </div>
        </div>
    </div>
    
    <!--Breadcrumb-->
    <div class="container">
        <div class="navigasi">
            <nav aria-label="breadcrumb" >
            <ol class="breadcrumb ">
                <li class="breadcrumb-item">Checkout</li>
            </ol>
            </nav>
        </div>
    </div>
    
    <!--body-pengiriman-->

    <!-- Produk -->
    <div class="container">
        <table class="table table-p">
            <tr>
                <th scope="row">Alamat Pengiriman</th>
            </tr>
            <tr>
                <td><span > Agus <b>(Kantor)</b> </span><br>
                <span > +62 897 3376 2637</span><br>
                <span > Jl. Wibawa Mukti II No.8, RT.002/RW.010, Jatiasih, Kec. Jatiasih, Kota Bks, Jawa Barat 12230</span></td>
            </tr>
            <tr>
                <td><button type="button" class="btn btn-light btn-p mt-2 mb-2"style="background-color:#0dcaf0; color:white" data-bs-toggle="modal" data-bs-target="#exampleModal"><b>Pilih Alamat Lain</b></button>
                <button type="button" class="btn btn-light btn-p mt-2 mb-2"style="background-color:#0dcaf0; color:white" ><b>Kirim Ke Beberapa Alamat</b></button><br></td>
            </tr>
        </table>

        <!-- Table Pesanan Produk -->
        <div class="container">
            <div class="row bg-produk-p">
                <table class="table">
                    <thead>
                        <tr>
                        <th scope="col">Pesanan Produk</th>
                        <th scope="col">Type</th>
                        <th scope="col">Harga Produk</th>
                        <th scope="col">Jumlah</th>
                        <th scope="col">Sub Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                        <th colspan="5"scope="row">SparePart   SKU :  TO-48609-AVZ-1800. </th>
                        </tr>
                        <tr>
                            <th scope="row">
                                <figure class="figure">
                                    <img src="assets/produk/15.png" class="img-fluid" alt="" style="width:130px; height:90px">
                                </figure>
                            </th>
                                <td>Genuine</td>
                                <td>50.000</td>
                                <td>1</td>
                                <td>50.000</td>
                        </tr>
                    </tbody>
                    
                </table>
                <table class="table">
                <tr>
                    <th scope="row" colspan="3"><div class="form-floating">
                        <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea"></textarea>
                        <label for="floatingTextarea">Catatan Produk</label>
                    </div></th>
                    <th scope="row" colspan="1">
                        <figure class="figure ">
                            <span> Pilih Pengiriman </span>
                                <select class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown"  aria-expanded="false" style="text-align:left; background-color:#0dcaf0; border:none; width:160px; Font-size:12px">   
                                    <option value="0"><b>Pilih</b></option>
                                    <option class="instan" value="20.000">Instan</option>
                                    <option value="10.000">Same Day</option>
                                    <option value="5.000">Next Day</option>
                                </select>
                        </figure>
                    </div></th>
                    </tr>
                </table>
                <div>
                    <input type="checkbox" class="form-check-input mb-1" id="exampleCheck1">
                    <span  style="color:grey; font-size:12px"> Asuransi Pengiriman </span>  
                </div>
                <table class="table">
                    <thead>
                        <tr>
                        <th scope="col">Metode Pembayaran</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                        <th scope="row">
                            <button onclick="return pembayaran()" type="button" class="btn btn-light btn-p mt-2 mb-2 pm"style="background-color:#0dcaf0; color:white" id="pm"><b>Pilih pembayaran</b></button>
                        </th>
                        <th scope="row">
                            <div class="container" style="background-color:white">
                                <div class="btn-go" id="btn-go" style="display:none">
                                    <span> Metode Pembayaran</span><br>
                                        <button class="btn btn-light btn-p mt-2 mb-2"style="background-color:#0dcaf0; color:white" onclick="return gopay('1')"><span><b> GoPay </b></span></button><br>
                                        <button class="btn btn-light btn-p mt-2 mb-2"style="background-color:#0dcaf0; color:white" onclick="return gopay('2')"><span><b> OVO </b></span></button></td><br>
                                        <button class="btn btn-light btn-p mt-2 mb-2"style="background-color:#0dcaf0; color:white" onclick="return gopay('3')"><span><b> GoPayLatter </b></span></button></td>
                                </div>
                                <div  class="container" id="gop" style="display:none;">
                                    <span> Metode Pembayaran</span>
                                    <div class="row">
                                    </div>
                                </div>
                            </div>
                        </th>
                    </tbody>
                </table>

                <div class="container" style="background-color:white">
                    <div class="btn-go" id="btn-go" style="display:none">
                        <span> Metode Pembayaran</span><br>
                            <button class="btn btn-light btn-p mt-2 mb-2"style="background-color:#0dcaf0; color:white" onclick="return gopay('1')"><span><b> GoPay </b></span></button><br>
                            <button class="btn btn-light btn-p mt-2 mb-2"style="background-color:#0dcaf0; color:white" onclick="return gopay('2')"><span><b> OVO </b></span></button></td><br>
                            <button class="btn btn-light btn-p mt-2 mb-2"style="background-color:#0dcaf0; color:white" onclick="return gopay('3')"><span><b> GoPayLatter </b></span></button></td>
                    </div>
                    <div  class="container" id="gop" style="display:none;">
                        <span> Metode Pembayaran</span>
                            <div class="row">
                            </div>
                    </div>
                </div>
            </div>
        </div>

        
        <div class="container">
            <div class="row bg-produk-p">
                <table class="table">
                    <tr> 
                        <td> Sub Total</td>
                        <td> 50.000</td>
                    </tr>
                    <tr> 
                        <td> Ongkos Kirim</td>
                        <td> 50.000</td>
                    </tr>
                    <tr>
                        <td colspan="6"><button type="button" class="btn btn-light btn-p mt-2 mb-2"style="background-color:#0dcaf0; color:white" data-bs-toggle="modal" data-bs-target="#exampleModal"><b>Buat Pesanan</b></button></td>
                    </tr>
            </table>
        </div>

<!-- Pilih Alamat Lain -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Pilih Alamat Pengiriman</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <input type="text" class="search-alamat" id="search-alamat" placeholder="Search.."name="search">
                    </form>
                    <button type="button" class="btn btn-light btn-p mt-2 mb-2"style=" background-color:#0dcaf0; color:white" onclick="return alamat()"><b>Tambah Alamat Baru</b></button><br></td>
                    <!-- Form Tambah Alamat -->
                    <div class="container-pm form-modal-alamat alm" id="alm" style="display:none">
                            <label for="fname">Nama Jalan/Desa</label>
                            <input type="text" id="jname " name="firstname">
                            <label for="lname">Kecamatan</label>
                            <input type="text" id="Kname" name="lastname">
                            <label for="country">Kota</label>
                            <select id="country" name="ktname">
                                <option value="jaksel">Jakarta Selatan</option>
                                <option value="jakpus">Jakarta Pusat</option>
                                <option value="jakbar">Jakarta Barat</option>
                                <option value="jaktim">Jakarta Timur</option>
                            </select>
                                <label for="subject">Subject</label>
                                <textarea id="subject" name="subject" style="height:200px"></textarea>
                                <input type="submit" value="Simpan">
                        </form>
                    </div>
                    <!-- Form Tambah Alamat -->

                    <table class="table table-p" id="almt">
                        <tr>
                            <td><span > Agus <b>(Kantor)</b> </span><br>
                            <span > +62 897 3376 2637</span><br>
                            <span > Jl. Wibawa Mukti II No.8, RT.002/RW.010, Jatiasih, Kec. Jatiasih, Kota Bks, Jawa Barat 12230</span></td>
                        </tr>
                    </table>
                </div>
            </div>
            
        </div>
    </div>
</div>
</div>
</div>

            
    <!-- Footer -->
    <!--#include file="footer.asp"-->

    
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="js/bootstrap.js"></script>
    <script src="js/popper.min.js"></script>

  </body>
</html>