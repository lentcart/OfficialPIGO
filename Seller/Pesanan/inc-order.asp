<!--#include file="../../connections/pigoConn.asp"-->
<%
    if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if
			
	set customer_cmd =  server.createObject("ADODB.COMMAND")
    customer_cmd.activeConnection = MM_PIGO_String

    customer_cmd.commandText = "select * from MKT_M_Customer where custID = '"& request.Cookies("custID") &"'"
    set customer = customer_CMD.execute

    set Pesanan_cmd =  server.createObject("ADODB.COMMAND")
    Pesanan_cmd.activeConnection = MM_PIGO_String

    Pesanan_cmd.commandText = "SELECT dbo.MKT_M_Customer.custID, dbo.MKT_T_Pesanan.ps_trJenisPengiriman,  dbo.MKT_T_Pesanan.ps_trID, dbo.MKT_T_Pesanan.psID, dbo.MKT_M_Customer.custNama, dbo.MKT_M_Customer.custEmail, dbo.MKT_M_Customer.custPhone1, dbo.MKT_T_Pesanan.ps_pdID, MKT_M_Customer_1.custNama AS Expr1, MKT_M_Customer_1.custEmail AS Expr2, dbo.MKT_M_Seller.slName, dbo.MKT_M_Produk.pdID, dbo.MKT_M_Produk.pdImage1, dbo.MKT_M_Produk.pdNama, dbo.MKT_M_Produk.pdHarga, dbo.MKT_M_Produk.pdStatus,  dbo.MKT_M_Produk.pdStok, dbo.MKT_M_Produk.pdSku, dbo.MKT_T_Pesanan.ps_tglTransaksi, dbo.MKT_T_Pesanan.ps_trQty, dbo.MKT_T_Pesanan.ps_pdCustID, dbo.MKT_T_Pesanan.ps_trOngkir,  dbo.MKT_T_Pesanan.ps_custID, dbo.MKT_T_Pesanan.ps_trSubtotal, dbo.MKT_T_Pesanan.ps_trJenisPembayaran, dbo.MKT_T_Pesanan.psKet,  dbo.MKT_T_Pesanan.ps_strID, dbo.MKT_T_Pesanan.psKodeBayar, dbo.MKT_T_Pesanan.psTotalBayar, dbo.MKT_T_Pesanan.psTglBayar, dbo.MKT_T_Pesanan.psTglPesanan, dbo.MKT_T_Pesanan.psKonfirmasi,  dbo.MKT_T_Transaksi_H.trQty, dbo.MKT_T_Transaksi_H.trTglTransaksi, dbo.MKT_T_Transaksi_D.trOngkir, dbo.MKT_T_Transaksi_D.tr_strID, dbo.MKT_T_Transaksi_D.trSubTotal, dbo.MKT_T_StatusTransaksi.strName FROM  dbo.MKT_T_Pesanan LEFT OUTER JOIN  dbo.MKT_T_StatusTransaksi ON dbo.MKT_T_Pesanan.ps_strID = dbo.MKT_T_StatusTransaksi.strID LEFT OUTER JOIN  dbo.MKT_T_Transaksi_H ON dbo.MKT_T_Pesanan.ps_trID = dbo.MKT_T_Transaksi_H.trID LEFT OUTER JOIN  dbo.MKT_T_Transaksi_D ON dbo.MKT_T_Transaksi_H.trID = dbo.MKT_T_Transaksi_D.trID_H LEFT OUTER JOIN dbo.MKT_M_Produk ON dbo.MKT_T_Pesanan.ps_pdID = dbo.MKT_M_Produk.pdID LEFT OUTER JOIN dbo.MKT_M_Customer ON dbo.MKT_T_Pesanan.ps_custID = dbo.MKT_M_Customer.custID LEFT OUTER JOIN dbo.MKT_M_Customer AS MKT_M_Customer_1 ON dbo.MKT_T_Pesanan.ps_pdCustID = MKT_M_Customer_1.custID LEFT OUTER JOIN  dbo.MKT_M_Seller ON MKT_M_Customer_1.custID = dbo.MKT_M_Seller.sl_custID where dbo.MKT_T_Pesanan.ps_pdCustID = '"& request.Cookies("custID") &"'"
    'response.write Transaksi_cmd.commandText
    set ps = Pesanan_CMD.execute



%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="pesanan.css">
        <link rel="stylesheet" type="text/css" href="../../fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../../css/stylehome.css">
        <script src="../../js/jquery-3.6.0.min.js"></script>

        <title>PIGO</title>
    </head>
    <style>

    

    </style>
<body>
    <!--Header Seller-->
    <div class="header">
        <div class="container">
                <div class="row align-items-center">
                    <div class=" col-lg-0 col-md-0 col-sm-0 col-12 mt-1">
                        <!--<div class="row" style="text-align:right">
                            <div class=" col-lg-0 col-md-0 col-sm-0 col-12">
                                <span> Media Sosial </span>
                                <a href="#" >
                                <img class="icon-media mr-2 ml-2" src="<%=base_url%>/sosialmedia/fb.png"alt=""/>
                                </a>
                                <a href="#" >
                                    <img class="icon-media mr-2" src="<%=base_url%>/sosialmedia/ig.png" alt="" />
                                </a>
                                <a href="#" >
                                    <img class="icon-media mr-2" src="<%=base_url%>/sosialmedia/yt.png" alt="" />
                                </a>
                                <a href="#" >
                                    <img class="icon-media mr-2" src="<%=base_url%>/sosialmedia/tt.png" alt="" />
                                </a>
                            </div>
                        </div>-->
                        <div class="row mb-3 mt-2" style="text-align:left">
                            <div class=" col-lg-0 col-md-0 col-sm-0 col-2 ">
                                <img src="<%=base_url%>/assets/logo1.jpg" class="rounded-pill" class="logo" alt="" width="65" height="65" />
                                <span class="judul-hd"> PIGO Seller </span>
                            </div>
                            <div class="col-lg-0 col-md-0 col-sm-0 col-7 mt-3">
                                <input class="form-search" type="search" placeholder="Cari Barang Terkini" aria-label="Search">
                            </div>
                            <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-4">
                                <img class="icon-media" src="<%=base_url%>/assets/logo/notif.png"alt=""/>
                                <span>|</span>
                                <a href="Customer/"><span class="cs-text-hd" ><%= request.cookies("custEmail") %> </span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <!--Header Seller-->

    <!--Body Seller-->
<div style="margin-top:6rem; padding:20px 20px; background-color:white">
    <div class="row">
        <!--MENU-->
            <div class="col-lg-0 col-md-0 col-sm-0 col-2" >
            <div class="row mb-3">
                <div class="col-12">
                    <a href="Customer/"><span class="cs-text" ><%= request.cookies("custNama") %> </span></a>
                    </div>
                    <div class="col-12">
                        <a href=""><span>[Poin Seller]</span></a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div id="accordionExample">
                    <div class="">
                        <h2 class="accordion-header" id="heading1">
                            <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">Produk </button>
                        </h2>
                        <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="heading1" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <a href ="../Produk/add-produk.asp">Tambah Produk</a><br>
                                <a href ="../Produk/list-produk.asp">Daftar Produk</a><br>
                                <a href ="">Kelola Stok Produk</a>
                            </div>
                        </div>
                    </div>

                    <div class="">
                        <h2 class="accordion-header" id="headingTwo">
                            <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2">Pesanan</button>
                        </h2>
                        <div id="collapse2" class="accordion-collapse collapse" aria-labelledby="heading2" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <a href ="">Pesanan Toko</a><br>
                                <a href ="">Pembatalan</a>
                            </div>
                        </div>
                    </div>

                    <div class="">
                        <h2 class="accordion-header" id="headingThree">
                            <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3">Pengiriman</button>
                        </h2>
                        <div id="collapse3" class="accordion-collapse collapse" aria-labelledby="heading3" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <a href ="../Produk/index.asp">Pengiriman Saya</a><br>
                                <a href ="../Produk/daftarproduk.asp">Pengiriman Masal</a>
                                <a href ="../Produk/index.asp">Pengaturan Pengiriman</a><br>
                            </div>
                        </div>
                    </div>
                    
                    <div class="">
                        <h2 class="accordion-header" id="headingFour">
                            <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse4">Performa Toko</button>
                        </h2>
                        <div id="collapse4" class="accordion-collapse collapse" aria-labelledby="heading4" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <a href ="../Produk/index.asp">Tambah Produk</a><br>
                                <a href ="../Produk/daftarproduk.asp">Daftar Produk</a>
                            </div>
                        </div>
                    </div>

                    <div class="">
                        <h2 class="accordion-header" id="heading5">
                            <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5" aria-expanded="false" aria-controls="collapse5">Promosi</button>
                        </h2>
                        <div id="collapse5" class="accordion-collapse collapse" aria-labelledby="heading5" data-bs-parent="#accordionExample">
                            <div class="promo" style="margin-left:10px">
                                <button onclick="promo()" class="dropbtn" style="background-color:white; margin-top:5px; margin-bottom:2px">Promo</button>
                                <div id="promo" class="promo-content">
                                    <a href="../Promosi/Promo/basic.asp">Basic Promo</a>
                                    <a href="">Promo Per Total Pembelian</a>
                                    <a href="">Promo Per Produk</a>
                                </div>
                            </div>
                            <div class="kupon" style="margin-left:10px">
                                <button onclick="kupon()" class="dropbtn" style="background-color:white">Voucher</button>
                                <div id="kupon" class="promo-content">
                                    <a href="">Tambah Voucher</a>
                                    <a href="">Daftar Voucher</a>
                                    <a href="">Voucher Toko</a>
                                </div>
                            </div>
                            <div class="poinreward" style="margin-left:10px">
                                <button onclick="poinreward()" class="dropbtn" style="background-color:white">poinreward</button>
                                <div id="poinreward" class="promo-content">
                                    <a href="">Per Total Pembelian</a>
                                    <a href="">Per Produk</a>
                                    <a href="">Pengaturan Produk</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="">
                        <h2 class="accordion-header" id="heading6">
                           <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse6" aria-expanded="false"aria-controls="collapse6">Keuangan</button>
                        </h2>
                        <div id="collapse6" class="accordion-collapse collapse" aria-labelledby="heading6" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <a href ="../Produk/index.asp">Tambah Produk</a><br>
                                <a href ="../Produk/daftarproduk.asp">Daftar Produk</a>
                            </div>
                        </div>
                    </div>

                    <div class="">
                        <h2 class="accordion-header" id="heading7">
                            <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse7" aria-expanded="false"aria-controls="collapse7">Data</button>
                        </h2>
                        <div id="collapse7" class="accordion-collapse collapse" aria-labelledby="heading7" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <a href ="../Produk/index.asp">Tambah Produk</a><br>
                                <a href ="../Produk/daftarproduk.asp">Daftar Produk</a>
                            </div>
                        </div>
                    </div>
                </div>
                    </div>
                </div>
            </div>
            <!--MENU-->
        <div class="col-lg-0 col-md-0 col-sm-0 col-9 " >
            <div class="container">
                <div class="row">
                    <div class="col-12 mb-4">
                        <h5>Daftar Pesanan</h5>
                    </div>
                </div>
                <div class="row justify-content-between mb-3" style="border: 4px solid #eeeeee; padding:10px 5px">
                    <div class="col-2 text-center">
                        <a href=""> Semua </a>
                    </div>
                    <div class="col-2">
                        <a href=""> Pesanan Baru </a>
                    </div>
                    <div class="col-2">
                        <a href=""> Dalam Pengiriman </a>
                    </div>
                    <div class="col-2">
                        <a href=""> Pesanan Selesai </a>
                    </div>
                    <div class="col-2">
                        <a href=""> Komplain </a>
                    </div>
                    <div class="col-2">
                        <a href=""> Dibatalkan </a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <table class="table">
                        <thead class="align-items-center">
                            <tr>
                            <th colspan="8">Produk</th>
                            <th class=" text-center" >Sub Total</th>
                            <th class=" text-center" scope="col">Status</th>
                            <th class=" text-center" scope="col">Jasa Kirim</th>
                            <th class=" text-center" scope="col">Aksi</th>
                            </tr>
                        </thead>
                        <%do while not ps.eof%>
                        <tbody>
                            <tr>
                                <th colspan="12"> Customer : <%=ps("custEmail")%> <input type="hidden" name="kdtr" id="kdtr<%=ps("ps_trID")%>" value="<%=ps("ps_trID")%>"></th>
                            </tr>
                            <tr>
                            
                            <td colspan="8">
                                <div class="row">
                                    <div class="col-3">
                                        <img src="data:image/png;base64,<%=ps("pdImage1")%>" style="height:80px;width: 80px;" alt=""/>
                                    </div>
                                    <div class="col-6">
                                        <span> <%=ps("pdNama")%> </span><br>
                                        <span> <%=Replace(FormatCurrency(ps("pdHarga")),"$","Rp.")%> </span><br>
                                        <span> Total Pembelian : <%=ps("ps_trQty")%> qty</span><br>
                                    </div>
                                </div>
                            </td>
                            <td class=" text-center" ><%=Replace(FormatCurrency(ps("ps_trSubTotal")),"$","Rp.")%></td>
                            <td class=" text-center" ><%=ps("strName")%></td>
                            <td class=" text-center" ><%=ps("ps_trJenisPengiriman")%></td>
                            <td class=" text-center" ><a href="detail.asp?psID=<%=ps("psID")%>"> Detail </a></td>
                            </tr>
                        </tbody>
                        <%ps.movenext
                        loop%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

</body>
    <script>
</script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../../js/bootstrap.js"></script>
    <script src="../../js/popper.min.js"></script>
S</html>