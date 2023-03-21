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
    <link rel="stylesheet" type="text/css" href="css/keranjang.css">

    <title>Otopigo</title>
    <script>
    function tes() {
        let btnPls = document.getElementsByTagName("btn-keranjang-plus");
        let input = document.getElementById("tes").value;
        let harga = parseInt(document.getElementById("harga").value);
        let total = document.getElementById("total");

        if (input === input){
            let nilaitambah =  input++ +1;
            document.getElementById("tes").value = input++;

            if (nilaitambah==1){
                total.value = harga;
            }else{
                 let subtotal = harga*nilaitambah;
            total.value = subtotal;
            }

           
        }
        
    }
    function tes2() {
        
        let input = document.getElementById("tes").value;
        let harga = parseInt(document.getElementById("harga").value);
        let total = document.getElementById("total");

        if (input === input){
            let nilaikurang = input--;
            let totalkurang = document.getElementById("total").value;
            // console.log(nilaikurang);
            // console.log(harga);
            // console.log(totalkurang);

            if (input<=0){
                 document.getElementById("tes").value = 0 ;
                
                total.value=0;

            }else{
                document.getElementById("tes").value = input--;
                let hasil = totalkurang-harga;

                total.value = hasil;
            }
            

        }
        
    }
    
    </script>
    <style>
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
    <!--#include file="header.asp"-->
    
    <!--Breadcrumb-->
    <div class="container">
        <div class="navigasi">
            <nav aria-label="breadcrumb" >
            <ol class="breadcrumb ">
                <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Keranjang</li>
            </ol>
            </nav>
        </div>
    </div>
    
    <!--Keranjang-->
    <div class="container">
        <div class="row row-keranjang">
            <div class="col table-responsive mt-2 mx-2">
                <table class="table">
                    <thead class="head-keranjang">
                        <tr>
                            <th scope="col"class="th-keranjang">Hapus</th>
                            <th scope="col"class="th-keranjang">Gambar</th>
                            <th scope="col"class="th-keranjang">Produk</th>
                            <th scope="col"class="th-keranjang">Harga</th>
                            <th scope="col"class="th-keranjang">Jumlah</th>
                            <th scope="col"class="th-keranjang">Subtotal</th>
                        </tr>
                    </thead>

                    <tbody class="nama-keranjang align-middle">
                        <tr>
                            <th scope="row"><a href=""><i class="fas fa-trash-alt text-dark fs-4"></i></a></th>
                            <td><img src="assets/produk/15.png" class="img-keranjang"></td>
                            <td>Nama Produk</td>
                            <td><input type="number" value="100000"></td>
                            <td><button type="button" class="btn-keranjang btn-dark btn-sm"><i class="fas fa-minus"></i></button>
                                <span class="mx-2">1</span>
                                <button type="button" class="btn-keranjang btn-dark btn-sm"><i class="fas fa-plus"></i></button></td>
                            <td><input type="number" value="0"></td>
                        </tr>
                        <tr>
                            <th scope="row"><a href=""><i class="fas fa-trash-alt text-dark fs-4"></i></a></th>
                            <td><img src="assets/produk/15.png" class="img-keranjang"></td>
                            <td>Nama Produk</td>
                            <td>Rp100.000</td>
                            <td><button type="button" class="btn-keranjang btn-dark btn-sm"><i class="fas fa-minus"></i></button>
                                <span class="mx-2">1</span>
                                <button type="button" class="btn-keranjang btn-dark btn-sm"><i class="fas fa-plus"></i></button></td>
                            <td>Rp100.000</td>
                        </tr>
                        <tr>
                            <th scope="row"><a href=""><i class="fas fa-trash-alt text-dark fs-4"></i></a></th>
                            <td><img src="assets/produk/15.png" class="img-keranjang"></td>
                            <td>Nama Produk</td>
                            <td><input type="number" id="harga" name="harga" value="100000"></td>
                            <td><button type="button" class="btn-keranjang-minus btn-dark btn-sm" onclick="return tes2()" ><i class="fas fa-minus"></i></button>
                                <input name="tes" id="tes" value="0">
                                <button type="button" class="btn-keranjang-plus btn-dark btn-sm" onclick="return tes()"><i class="fas fa-plus"></i></button></td>
                            <td><input type="number" id="total" name="total" value="0"></td>
                        </tr>
                    </tbody>
                </table>


            </div>
        </div>

        <div class="row row-keranjang">
            <div class="col table-responsive">
                <table class="table ms-auto text-center mb-5 mt-3 mx-2" id="table-checkout">
                        <thead class="head-total">
                            <tr>
                                <th scope="col" colspan="2" class="th-keranjang">Total Keranjang Belanja</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="fw-bold th-keranjang">Total Harga</td>
                                <td class="th-keranjang">Rp100.000</td>
                            </tr>
                            <tr>
                                <td colspan="2" class="th-keranjang">
                                    <div class="btn-checkout d-grid ">
                                        <button class="btn-checkout btn-sm mx-4">Checkout</button>
                                    </div>
                                </td>
                            </tr>
                            
                        </tbody>
                </table>
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