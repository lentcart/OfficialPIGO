<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    pscID = request.queryString("pscID")
    pscTanggal = request.queryString("pscTanggal")
    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= '"& request.Cookies("custID") &"'  "
	set Merchant = Merchant_cmd.execute

    set Pengeluaran_cmd = server.createObject("ADODB.COMMAND")
	Pengeluaran_cmd.activeConnection = MM_PIGO_String
			
	Pengeluaran_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal, MKT_M_Supplier.spNama1, MKT_T_PengeluaranSC_D1.pscD1_NoPermintaan FROM MKT_T_PengeluaranSC_D1 LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_PengeluaranSC_D1.pscD1_spID = MKT_M_Supplier.spID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D1.pscID1_H = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D2 ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D2.pscD2_H WHERE (MKT_T_PengeluaranSC_H.pscID ='"& pscID &"') AND (MKT_T_PengeluaranSC_H.pscTanggal ='"& pscTanggal &"')  GROUP BY MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal, MKT_M_Supplier.spNama1, MKT_T_PengeluaranSC_D1.pscD1_NoPermintaan "
    'response.write Pengeluaran_cmd.commandText
	set Pengeluaran = Pengeluaran_cmd.execute

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

%>

<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="invoice.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    
    <script>
    </script>
    </head>
<body>
    <div class="container invoice">
        <div class="invoice-header">
        <% do while not Merchant.eof%>
            <div class="row">
                <div class="col-4">
                    <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                </div>
                <div class="col-6">
                    <span class="Judul-Merchant"> <%=Merchant("custNama")%> </span><br>
                    <span class="Txt-Merchant"> <%=Merchant("custPhone1")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone2")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone3")%> </span><br>
                    <span class="Txt-Merchant"> <%=Merchant("almLengkap")%> </span><br>
                </div>
            </div>
            <% Merchant.movenext
            loop%>
            <hr>
            <div class="invoice-body" style="background-color:#eeeeee; padding: 10px 20px; border-radius:20px;">
            <% do while not Pengeluaran.eof%>
            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <div class="col-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> No PSCB </span><br>
                                    <span class="txt-desc"> Pelanggan </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-7 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"><%=Pengeluaran("pscID")%></span><br>
                                    <span class="txt-desc"><%=Pengeluaran("spNama1")%></span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> No Permintaan  </span><br>
                                    <span class="txt-desc"> Tanggal </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-5 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"><%=Pengeluaran("pscD1_NoPermintaan")%></span><br>
                                    <span class="txt-desc"><%=pengeluaran("pscTanggal")%></span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row text-center mt-3">
                <div class="col-12">
                    <span class="txt-desc" style="font-size:20px">BUKTI PENGELUARAN SUKU CADANG BARU</span><br>
                    <span class="txt-desc">  <%=Pengeluaran("pscID")%>  </span><br>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        </div>
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                        <thead>
                            <tr>
                                <th class="text-center"> No </th>
                                <th class="text-center"> SKU/Part Number </th>
                                <th class="text-center"> Nama Produk </th>
                                <th class="text-center"> Jumlah </th>
                                <th class="text-center"> Unit </th>
                                <th class="text-center"> Harga</th>
                                <th class="text-center"> Sub Total</th>
                            </tr>
                            
                        </thead>
                        <tbody>
                        <% 
                            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber,  MKT_T_PengeluaranSC_D2.pscD2_pdHarga, MKT_T_PengeluaranSC_D2.pscD2_pdQty, MKT_T_PengeluaranSC_D2.pscD2_pdUnit, MKT_T_PengeluaranSC_D2.pscD2_pdSubtotal FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PengeluaranSC_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_PengeluaranSC_D2.pscD2_pdID RIGHT OUTER JOIN MKT_T_PengeluaranSC_D1 RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D1.pscID1_H = MKT_T_PengeluaranSC_H.pscID ON MKT_T_PengeluaranSC_D2.pscD2_H = MKT_T_PengeluaranSC_H.pscID WHERE MKT_T_PengeluaranSC_H.pscID = '"& Pengeluaran("pscID") &"' GROUP BY  MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber,  MKT_T_PengeluaranSC_D2.pscD2_pdHarga, MKT_T_PengeluaranSC_D2.pscD2_pdQty, MKT_T_PengeluaranSC_D2.pscD2_pdUnit, MKT_T_PengeluaranSC_D2.pscD2_pdSubtotal"
                            'response.write produk_cmd.commandText
	                        set produk = produk_cmd.execute
                        %>
                        <% do while not produk.eof%>
                            <tr>
                                <td class="text-center"> <%=produk("no")%> </td>
                                <td> <%=produk("pdPartNumber")%> </td>
                                <td> <%=produk("pdNama")%> </td>
                                <td class="text-center"> <%=produk("pscD2_pdQty")%> </td>
                                <td class="text-center"> <%=produk("pscD2_pdUnit")%> </td>
                                <td class="text-center"> <%=Replace(FormatCurrency(produk("pscD2_pdHarga")),"$","Rp.  ")%> </td>
                                <td class="text-center"> <%=Replace(FormatCurrency(produk("pscD2_pdSubtotal")),"$","Rp.  ")%> </td>
                                <% totalqty = totalqty+produk("pscD2_pdSubtotal") %>
                            </tr>
                            <%
                                subtotal = subtotal + totalpo
                            %>
                            <% produk.movenext
                            loop%>
                            <tr>
                                <th colspan="6" class="text-right"> Total QTY </th>
                                <td class="text-center"> <%=totalqty%> </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
            <% Pengeluaran.movenext
            loop %>  
            <div class="row text-center" style="margin-top:2rem">
                <div class="col-6">
                    <span class="txt-desc"> </span><br>
                    <span class="txt-desc"> Diserahkan Oleh,</span><br><br><br>
                    <span class="txt-desc">...........................</span><br>
                </div>
                <div class="col-6">
                    <span class="txt-desc"> Tanggal, <%=Cdate(date())%> </span><br>
                    <span class="txt-desc"> Diterima Oleh,</span><br><br><br>
                    <span class="txt-desc">...........................</span><br>
                </div>
            </div>          
        </div>
    </div>
</body>

    <script>

        
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>