<!--#include file="Connections/pigoConn.asp" -->
<%
    set produk_cmd =  server.createObject("ADODB.COMMAND")
    produk_cmd.activeConnection = MM_PIGO_String

    produk_cmd.commandText = "SELECT * FROM MKT_M_Produk WHERE pdAktifYN = 'Y' "
    'response.write produk_CMD.commandText & "<br>"
    set produk = produk_cmd.execute
    
    set ProdukTerjual_cmd = server.createObject("ADODB.COMMAND")
	ProdukTerjual_cmd.activeConnection = MM_PIGO_String
    
    set kategori_cmd = server.createObject("ADODB.COMMAND")
	kategori_cmd.activeConnection = MM_PIGO_String
			
	kategori_cmd.commandText = "SELECT [catID] ,[catName] ,[catAktifYN] FROM [PIGO].[dbo].[MKT_M_Kategori] where catAktifYN = 'Y'" 
	set kategori = kategori_cmd.execute

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
    
    <script>
    </script>
    </head>
<body>
    <!-- Header -->
        <!--#include file="header.asp"-->
    <!-- Header -->

    <div class="container" style="margin-top:1rem">
        <!-- Carousel -->
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
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
            <div class="row mx-0 sale mt-1 ">
                <div class="d-flex mt-3">
                    <h5 class="weight" >FLASHSALE</h5>
                    <span class="mt-1"style="font-size:11px"> Berakhir dalam </span>
                    <h5 class ="ms-2 text-timer text-center weight" id="demo" ></h5>
                </div>
            </div>
            <div class="row bg-flashsale mx-0" id="cards" >
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
                                            <div class="row mt-2">
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

        <!-- Produk Rekomendasi -->
            <div class="bg-judul mt-4">
                <h5 class="text-center weight">REKOMENDASI</h5>
            </div>
            <hr>
            <div class="row">
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
        <!-- Produk Rekomendasi -->
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>                            
</html>