<!--#include file="../../connections/pigoConn.asp"--> 

<%
	if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if

    idseller = request.queryString("sl")

    set seller_cmd =  server.createObject("ADODB.COMMAND")
    seller_cmd.activeConnection = MM_PIGO_String

    seller_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPassword, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custPhone3,    MKT_M_Customer.custJk, MKT_M_Customer.custTglLahir, MKT_M_Customer.custRekening, MKT_M_Customer.custStatus, MKT_M_Customer.custRating, MKT_M_Customer.custPoinReward, MKT_M_Customer.custLastLogin,   MKT_M_Customer.custVerified, MKT_M_Customer.custDakotaGYN, MKT_M_Customer.custAktifYN, MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Customer.custPhoto, MKT_M_Seller.sl_custID,   MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel,  MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong, MKT_M_Alamat.alm_custID FROM MKT_M_Customer LEFT OUTER JOIN  MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID LEFT OUTER JOIN  MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID  where MKT_M_Seller.slName = '"& idseller &"'"
    set seller = seller_CMD.execute

    set produk_cmd =  server.createObject("ADODB.COMMAND")
    produk_cmd.activeConnection = MM_PIGO_String

    produk_cmd.commandText = "SELECT * FROM MKT_M_Produk WHERE pd_custID = '"& seller("custID") &"'"
    set produk = produk_CMD.execute
    
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Required meta tags -->

        <!-- Bootstrap CSS -->
            <link href="<%=base_url%>/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
            <link rel="stylesheet" type="text/css" href="../seller.css">
            <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
            <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
            <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <!-- Bootstrap CSS -->

        <title> Official PIGO</title>
    </head>
    <body>
        <!-- Header -->
            <!--#include file="../../header.asp"-->
        <!-- Header -->

        <!-- body -->
            <div class="PRofile" style="margin-top:2rem; padding:100px">
                <div class="row P-Seller">
                    <div class="col-1">
                        <img src="data:image/png;base64,<%=seller("custPhoto") %>" class="rounded-pill"width="80" height="80" >
                    </div>
                    <div class="col-6">
                        <span class="txt-P-Seller" > <%=seller("slName") %>
                        <div class="row">
                            <div class="col-6">
                            <span class="txt-P-Seller-desc"> Lokasi Pengiriman : <%=seller("almProvinsi")%> </span>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <button class="btn-P-Seller"> Hubungi Seller </button>
                            </div>
                            <div class="col-3">
                                <button class="btn-P-Seller"> Ikuti Seller </button>
                            </div>
                                <div class="col-3">
                            <button class="btn-P-Seller"> Informasi Seller </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row P-Seller mt-2">
                    <div class="col-12">
                        <span class="txt-P-Seller"> Produk Terbaru </span>
                    </div>
                </div>
                <div class="row P-Seller mt-2">
                    <div class="col-12">
                        <span class="txt-P-Seller"> Semua Produk </span>
                    </div>
                <div class="row">
                <%do while not produk.eof%>
                    <div class="col-lg-2 col-md-2 col-sm-1 col-6 mt-2 ">
                        <a href="singleproduk.asp?pdID=<%=produk("pdID")%>">
                            <div class="card mt-3 mb-2 me-2" style="width:11rem; overflow-y:hidden; background-color:white; border-radius:20px">
                                <img src="data:image/png;base64,<%=produk("pdImage1")%>" class="card-img-top" alt="...">
                                <div class="card-body">
                                    <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="<%=produk("pdNama")%>"><br>
                                    <input class="hg-card" type="text" name="pdHarga" id="pdHarga" value="<%=Replace(FormatCurrency(produk("pdHargaJual")),"$","Rp. ")%>"><br>
                                    <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                    <span class="terjual"><del>Rp 100.000</del></span>-->
                                </div>
                            </div>
                        </a>
                    </div>
                <%produk.movenext
                loop%>
                </div>
            </div>
        <!-- body -->
    </body>  
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js">
    </script>
</html>