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

    Transaksi_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, dbo.MKT_T_Transaksi_D.tr_pdID,dbo.MKT_T_Transaksi_D.tr_custID,dbo.MKT_T_Transaksi_H.trQty,dbo.MKT_T_Transaksi_H.tr_pdCustID, dbo.MKT_T_Transaksi_H.trTglTransaksi,dbo.MKT_T_Transaksi_D.trID_H, dbo.MKT_T_Transaksi_D.trOngkir, dbo.MKT_T_Transaksi_D.tr_strID, dbo.MKT_T_Transaksi_D.trSubTotal, dbo.MKT_T_Transaksi_D.trJenisPengiriman, dbo.MKT_T_Transaksi_D.trJenisPembayaran, dbo.MKT_T_Transaksi_D.trNoResi,dbo.MKT_M_Produk.pdNama,dbo.MKT_M_Produk.pdImage1, dbo.MKT_M_Produk.pdType, dbo.MKT_M_Produk.pdHargaJual, dbo.MKT_M_Produk.pdSku, dbo.MKT_M_Produk.pdBerat, dbo.MKT_M_Produk.pdVolume, dbo.MKT_M_Customer.custNama, dbo.MKT_M_Customer.custEmail, dbo.MKT_T_StatusTransaksi.strName FROM dbo.MKT_T_Transaksi_H LEFT OUTER JOIN dbo.MKT_T_Transaksi_D ON dbo.MKT_T_Transaksi_H.trID = dbo.MKT_T_Transaksi_D.trID_H LEFT OUTER JOIN dbo.MKT_T_StatusTransaksi ON dbo.MKT_T_Transaksi_D.tr_strID = dbo.MKT_T_StatusTransaksi.strID LEFT OUTER JOIN dbo.MKT_M_Produk ON dbo.MKT_T_Transaksi_D.tr_pdID = dbo.MKT_M_Produk.pdID LEFT OUTER JOIN dbo.MKT_M_Customer ON dbo.MKT_T_Transaksi_H.tr_pdCustID = dbo.MKT_M_Customer.custID where dbo.MKT_T_Transaksi_H.trAktifYN = 'Y'" 

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
        <link rel="stylesheet" type="text/css" href="inc-order.css">
        <link rel="stylesheet" type="text/css" href="../../fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../../css/stylehome.css">

        <title>PIGO</title>
        <script>
        function transaksi(){
            $.ajax({
                type: "post",
                url: "P-order.asp",
                data: { id : id },
                success: function (data) {
                    console.log(data);
                }
            });
        }
        </script>
    </head>
<body>
    <!--Breadcrumb-->
    <div class="container mt-3">
        <div class="navigasi" >
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb ">
                    <li class="breadcrumb-item">
                    <a href="../Seller/index.asp" >Seller Home</a></li>
                    <li class="breadcrumb-item"><a href="../Pesanan/" >Pesanan</a></li>
                    <li class="breadcrumb-item"><a href="index.asp.asp" >Verifikasi Pesanan</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <hr size="10px" color="#ececec">

<!--Body Seller-->
<div style="margin-top:1rem; padding:20px 20px; background-color:white">
    <div class="container">
        <div class="row">
        <div class="col-lg-0 col-md-0 col-sm-0 col-12" >
            <div class="container">
                <div class="row">
                    <div class="col-12 mb-2">
                        <h5> Verifikasi Pesanan Baru</h5>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-12 mb-2">
                        <table class=" table table-bordered table-condensed">
                            <thead>
                                <tr>
                                    <th class="text-center"> Pembeli </th>
                                    <th class="text-center" colspan="3"> Detail Produk </th>
                                    <th class="text-center"> Total </th>
                                    <th class="text-center" colspan="2"> Aksi </th>
                                </tr>
                            </thead>
                            <tbody>
                            <% do while not Transaksi.eof%>
                            <form class="" action="../P-Order.asp" method="post">
                                <tr>
                                    <td><%=Transaksi("custNama")%>
                                        <input type="hidden" name="kodetransaksi" id="kodetransaksi" value="<%=Transaksi("trID")%>">
                                        <input type="hidden" name="tgltransaksi" id="tgltransaksi" value="<%=Transaksi("trTglTransaksi")%>">
                                        <input type="hidden" name="trqty" id="trqty" value="<%=Transaksi("trQty")%>">
                                        <input type="hidden" name="kdpdcust" id="kdpdcust" value="<%=Transaksi("tr_pd_custID")%>">
                                        <input type="hidden" name="idpd" id="idpd" value="<%=Transaksi("tr_pdID")%>">
                                        <input type="hidden" name="ongkir" id="ongkir" value="<%=Transaksi("trOngkir")%>">
                                        <input type="hidden" name="jenispengiriman" id="jenispengiriman" value="<%=Transaksi("trJenisPengiriman")%>">
                                        <input type="hidden" name="idcust" id="idcust" value="<%=Transaksi("tr_custID")%>">
                                        <input type="hidden" name="subtotal" id="subtotal" value="<%=Transaksi("trSubTotal")%>">
                                        <input type="hidden" name="jenispembayaran" id="jenispembayaran" value="<%=Transaksi("trJenisPembayaran")%>">
                                    </td>
                                    <td><%=Transaksi("pdNama")%></td>
                                    <td><%=Transaksi("pdhargaJual")%></td>
                                    <td class="text-center"><%=Transaksi("trQty")%></td>
                                    <td><%=Transaksi("trSubTotal")%></td>
                                    <td class="text-center"><%=Transaksi("trJenisPengiriman")%></td>
                                    <td><input id="<%=Transaksi("trID")%>" type="submit" value="Kirim Barang"></td>
                                </tr>
                                </form>
                            <%Transaksi.movenext
                            loop%>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <hr>
                    <!--<div class="col-2">
                        <button type="button" onclick="window.open('../../Admin/Order/detail-order.asp?trID='+document.getElementById('kdtr<%=Transaksi("trID")%>').value,'_Self')"> Proses Pesanan</button>
                    </div>-->
                </div>
                
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
</html>