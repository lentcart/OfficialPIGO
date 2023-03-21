<!--#include file="../../connections/pigoConn.asp"--> 

<%
	if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if
			
	set customer_cmd =  server.createObject("ADODB.COMMAND")
    customer_cmd.activeConnection = MM_PIGO_String

    customer_cmd.commandText = "select * from MKT_M_Customer where custID = '"& request.Cookies("custID") &"'"
    set customer = customer_CMD.execute

	set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_M_Seller.slName, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_M_Produk.pdHargaJual,MKT_M_Produk.pdType, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_transaksi_D2.trSubTotal ,MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.trPengiriman FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_Transaksi_H ON left(MKT_T_Transaksi_D1.trD1,12) = left(MKT_T_Transaksi_H.trID,12) LEFT OUTER JOIN MKT_T_Transaksi_D2 ON left(MKT_T_Transaksi_H.trID,12) = left(MKT_T_Transaksi_D2.trD2,12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON left(MKT_T_Transaksi_D1.trD1,12) = left(MKT_T_Transaksi_D1A.trD1A,12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID LEFT OUTER JOIN MKT_T_StatusTransaksi ON left(MKT_T_Transaksi_H.tr_strID,12) = MKT_T_StatusTransaksi.strID where MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' "
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute


    
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
        <link rel="stylesheet" type="text/css" href="../../css/stylehome.css">
        <link rel="stylesheet" type="text/css" href="../../fontawesome/css/all.min.css">
        <script src="../../js/jquery-3.6.0.min.js"></script>

        <title>PIGO</title>
    </head>
    <body>
    <!-- Header -->
        <!--#include file="../../header.asp"-->
    <!-- Header -->
    
    <div class="container"style="margin-top:8rem;">
        <div class="row">
            <div class="col-5">
            <div  class="accordion" id="accordionExample" >
                <h2 class="accordion-header" id="heading1">
                    <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">Akun Saya</button>
                </h2>
            </div>
            <div class="col-2">
            dgfdsg
            </div>
        </div>
    </div>
    <hr>
    <!--Sub Body-->
    </body>
    <script src="../../js/bootstrap.js"></script>
    <script src="../../js/popper.min.js"></script>
</html>