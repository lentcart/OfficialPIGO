<!--#include file="../Connections/pigoConn.asp" -->

<!doctype html>
<html lang="en">
    <head>
         <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="dashboard.css">
    <link rel="stylesheet" type="text/css" href="baru.css">
    <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
    <script src="../js/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    
        <script>

        </script>
    </head>
        <style>
        
        </style>
    <body>
        <!-- Navbar -->
            <nav class="navbar">
                <h4> DASHBOARD | OFFICIAL PIGO </h4>
                <div class="profile">
                    <span class="fas fa-search"> </span>
                    <img class="profile-image" src="<%=base_url%>/assets/logo/1.png"> 
                    <p class="profile-name"> Official PIGO </p>
                </div>
            </nav>
        <!-- Navbar -->

        <!-- Sidebar -->
            <input type="checkbox" id="toggle">
            <label class="side-toggle" for="toggle"> <span class="fas fa-bars"> </span></label>

            <div class="sidebar" style="overflow-y:auto">
                <div class="row items-align-center"> 
                    <div class="col-12" >
                        <div class="row mt-2 Dashboard text-center" style=" background-color:white; padding: 5px; whidth:100%">
                            <div class="col-12">
                                <a href="<%=base_url%>/Admin/dashboard.asp" class="judul-side" style="font-size:12px; color:#10a5d3;"> Dashboard Home </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <button class="dropdown-btn mt-2" >Data<i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Data/Customer/">Customer PIGO</a>
                            <a class="text-dropdown" href="">Seller</a>
                        </div>
                    <button class="dropdown-btn " > Produk <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukBaru/">Produk Baru</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukInfo/">Produk Info</a>
                            <a class="text-dropdown" href="">Stok Produk</a>
                        </div>
                    <button class="dropdown-btn " > Supplier <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/"> Supplier </a>
                        </div>
                    <button class="dropdown-btn " > General Ledger <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <button class="dropdown-btn " style="background-color:#10a5d3; margin-left:-8px; width:12.2rem"> Cetak <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct" style="margin-left:-8px;  width:12.2rem">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Cetak Pembukuan </a>
                                </div>
                            <button class="dropdown-btn " style="background-color:#10a5d3; margin-left:-8px;  width:12.2rem"> Daftar <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct" style="margin-left:-8px;  width:12.1rem">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Daftar Kas </a>
                                </div>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Kas-Masuk-Keluar/"> Kas Masuk/Keluar </a>
                        </div>
                    <button class="dropdown-btn " > Operasional <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/PurchaseOrderDetail/"> Purchase Order </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/MaterialReceiptDetail/"> Material Receipt </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pembayaran/PaymentRequestDetail/"> Payment Request </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pembayaran/PaymentDetail/"> Payment </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pengeluaran/PSCBDetail/"> Pengeluaran SCB </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/SuratJalan/"> Surat Jalan </a>
                        </div>
                    <button class="dropdown-btn " >Laporan<i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Lap-Penjualan/">Laporan Penjualan</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Lap-Pembelian/">Laporan Pembelian</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/Daftar-Produk/">Laporan Barang</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Lap-Stok/">Laporan Stok</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Kartu-Stok/index.asp">Kartu Stok</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/">Laporan Laba Rugi</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/Produk-supplier/">Laporan Pemasukan</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/Produk-supplier/">Laporan Pengeluaran</a>
                        </div>
                    <button class="dropdown-btn " >User<i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/Tambah-Produk">User PIGO</a>
                        </div>
                </div>
            </div>
            <div class="row mt-2 Dashboard text-center" style=" background-color:white; padding: 5px; whidth:100%">
                <div class="col-12">
                    <a href="<%=base_url%>/" class="judul-side" style="font-size:12px; color:#10a5d3;"> Website Official PIGO </a>
                </div>
            </div>
            </div>

        <!-- Sidebar -->

        <!-- Main Dashboard -->
            <main>
                <div class="dashboard-container">
                <!-- 4 card top -->
                    <div class="card total1">
                        <div class="info">
                            <div class="info-detail">
                                
                            </div>
                            <div class="info-image">
                                
                            </div>
                        </div>
                    </div>
                    
                    <div class="card total2">
                        <div class="info">
                            <div class="info-detail">
                                <h3> Total Orders </h3>
                                <p> Lorem Ipsum Dolor </p>
                                <h2> 10,890 <span> Orders </span> </h2>
                            </div>
                            <div class="info-image">
                                <i class="fas fa-boxes"> </i>
                            </div>
                        </div>
                    </div>

                    <div class="card total3">
                        <div class="info">
                            <div class="info-detail">
                                <h3> Customer </h3>
                                <p> Lorem Ipsum Dolor </p>
                                <h2> 340 <span> Companies </span> </h2>
                            </div>
                            <div class="info-image">
                                <i class="fas fa-user-friends"> </i>
                            </div>
                        </div>
                    </div>

                    <div class="card total4">
                        <div class="info">
                            <div class="info-detail">
                                <h3> Daily Orders </h3>
                                <p> Lorem Ipsum Dolor </p>
                                <h2> 56 <span> Orders </span> </h2>
                            </div>
                            <div class="info-image">
                                <i class="fas fa-shipping-fast"> </i>
                            </div>
                        </div>
                    </div>
                <!-- 2 card bottom -->

                    <div class="card detail">
                        <div class="detail-header">
                            <h2> All Orders </h2>
                            <button> See More </button>
                        </div>
                        <table class="table">
                            <tr>
                                <th> Order #</th>
                                <th> Company </th>
                                <th> Status </th>
                                <th> Total </th>
                                <th> Created </th>
                                <th> Last Uploated </th>
                            </tr>
                            <tr>
                                <td> #PW-0001 </td>
                                <td> Potential Corp </td>
                                <td> 
                                    <span class="status onprogress"><i class="fas fa-circle"> </i>ONPROGRESS </span> 
                                </td>
                                <td> 3.149.154 USE </td>
                                <td>  APR 11.2021 </td>
                                <td>  Today </td>
                            </tr>
                            <tr>
                                <td> #PW-0002 </td>
                                <td> WebCode </td>
                                <td> 
                                    <span class="status confirmed"><i class="fas fa-circle"> </i>CONFIRMED </span> 
                                </td>
                                <td> 3.149.154 USE </td>
                                <td>  APR 11.2021 </td>
                                <td>  Today </td>
                            </tr>
                            <tr>
                                <td> #PW-0003 </td>
                                <td> Coding Time </td>
                                <td> 
                                    <span class="status fulfilled"><i class="fas fa-circle"> </i>FULFILLED </span> 
                                </td>
                                <td> 3.149.154 USE </td>
                                <td>  APR 11.2021 </td>
                                <td>  Today </td>
                            </tr>
                        </table>
                    </div>

                    <div class="card customer">
                        <h2> Sales Activities </h2>
                        <div class="customer-wrapper">
                            <img class="customer-image" src="https://picsum.photos/200/200?random=2">
                            <div class="customer-name">
                                <h4> Mollit </h4>
                                <p> Lorem Ipsyum Dollor Site Amet </p>
                            </div>
                            <p class="customer-date"> Today  </p> 
                        </div>
                    </div>
                </div>
            <main>
        <!-- Main Dashboard -->
    </body>
        <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
        <script>
        var dropdown = document.getElementsByClassName("dropdown-btn");
                var i;

                for (i = 0; i < dropdown.length; i++) {
                dropdown[i].addEventListener("click", function() {
                this.classList.toggle("active");
                var dropdownContent = this.nextElementSibling;
                if (dropdownContent.style.display === "block") {
                dropdownContent.style.display = "none";
                } else {
                dropdownContent.style.display = "block";
                }
                });
                }
    </script>   
</html>