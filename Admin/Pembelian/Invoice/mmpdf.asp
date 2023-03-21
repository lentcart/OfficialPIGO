<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    mmID = request.queryString("mmID")
    tanggalmm = request.queryString("tanggalmm")
    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= '"& request.Cookies("custID") &"'  "
	set Merchant = Merchant_cmd.execute

    set MaterialReceipt_cmd = server.createObject("ADODB.COMMAND")
	MaterialReceipt_cmd.activeConnection = MM_PIGO_String
			
	MaterialReceipt_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_M_Supplier.spID, MKT_M_Supplier.spKey, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spFax,  MKT_T_MaterialReceipt_H.mm_spID FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN   MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID WHERE (MKT_T_MaterialReceipt_H.mmID ='"& mmID &"') AND (MKT_T_MaterialReceipt_H.mmTanggal ='"& tanggalmm &"')  group by MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_M_Supplier.spID, MKT_M_Supplier.spKey, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spFax,  MKT_T_MaterialReceipt_H.mm_spID"
    'response.write MaterialReceipt_cmd.commandText
	set MaterialReceipt = MaterialReceipt_cmd.execute


    set po_cmd = server.createObject("ADODB.COMMAND")
	po_cmd.activeConnection = MM_PIGO_String

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
            <% do while not MaterialReceipt.eof%>
            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <div class="col-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> Telah Di Terima Dari </span><br>
                                    <span class="txt-desc"> Alamat </span><br>
                                    <span class="txt-desc"> CP</span><br>
                                    <span class="txt-desc"> Kontak </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-7 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"><%=MaterialReceipt("spNama1")%></span><br>
                                    <span class="txt-desc"><%=MaterialReceipt("spAlamat")%></span><br>
                                    <span class="txt-desc"> Telepon</span> - <span class="txt-desc"><%=MaterialReceipt("spPhone1")%></span><br>
                                    <span class="txt-desc"> Fax</span> - <span class="txt-desc"><%=MaterialReceipt("spFax")%></span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-3">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> Tanggal </span><br>
                                    <span class="txt-desc"> No PO </span><br>
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
                                    <span class="txt-desc"><%=MaterialReceipt("mmTanggal")%></span><br>
                                    <%
                                        po_cmd.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_MaterialReceipt_D1.mm_poTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 where MKT_T_MaterialReceipt_H.mm_spID = '"& MaterialReceipt("spID") &"' AND (MKT_T_MaterialReceipt_H.mmTanggal ='"& MaterialReceipt("mmTanggal")  &"') AND (MKT_T_MaterialReceipt_H.mmID ='"& MaterialReceipt("mmID")  &"')  "
                                        'response.write po_cmd.commandText
                                        set po = po_cmd.execute
                                    %>
                                    <% do while not po.eof%>
                                    <span class="txt-desc"><%=po("mm_poID")%></span><br>
                                    <% po.movenext
                                    loop%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-12">
                    <span class="txt-desc" style="font-size:20px">MATERIAL RECEIPT</span><br>
                    <span class="txt-desc">  <%=MaterialReceipt("mmID")%>  </span><br>
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
                                <th class="text-center"> Lokasi</th>
                                <th class="text-center"> Satuan</th>
                                <th class="text-center"> QTY</th>
                            </tr>
                            
                        </thead>
                        <tbody>
                        <% 
                            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdKey, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_PIGO_Produk.pdLokasi,   MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_H.mmID FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID RIGHT OUTER JOIN  MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID where MKT_T_MaterialReceipt_H.mm_spID = '"& MaterialReceipt("spID") &"' AND (MKT_T_MaterialReceipt_H.mmTanggal ='"& MaterialReceipt("mmTanggal")  &"') AND (MKT_T_MaterialReceipt_H.mmID ='"& MaterialReceipt("mmID")  &"')  "
                            'response.write produk_cmd.commandText
	                        set produk = produk_cmd.execute
                        %>
                        <% do while not produk.eof%>
                            <tr>
                                <td class="text-center"> <%=produk("no")%> </td>
                                <td> <%=produk("pdPartNumber")%> </td>
                                <td> <%=produk("pdNama")%> </td>
                                <td class="text-center"> <%=produk("pdLokasi")%> </td>
                                <td class="text-center"> <%=produk("pdUnit")%> </td>
                                <td class="text-center"> <%=produk("mm_pdQtyDiterima")%> </td>
                                <% totalqty = totalqty+produk("mm_pdQtyDiterima") %>
                            </tr>
                            <%
                                subtotal = subtotal + totalpo
                            %>
                            <% produk.movenext
                            loop%>
                            <tr>
                                <th colspan="5" class="text-right"> Total QTY </th>
                                <td class="text-center"> <%=totalqty%> </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
            <% MaterialReceipt.movenext
            loop %>  
            <div class="row text-center" style="margin-top:2rem">
                <div class="col-6">
                    <span class="txt-desc"> </span><br>
                    <span class="txt-desc"> Dibuat Oleh,</span><br><br><br>
                    <span class="txt-desc">...........................</span><br>
                </div>
                <div class="col-6">
                    <span class="txt-desc"> Tanggal, <%=Cdate(date())%> </span><br>
                    <span class="txt-desc"> Mengetahui,</span><br><br><br>
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