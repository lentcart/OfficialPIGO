<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    prID = request.queryString("prID")
    tanggalivn = request.queryString("tglinvoice")
    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= '"& request.Cookies("custID") &"'  "
	set Merchant = Merchant_cmd.execute

    set PaymentRequest_cmd = server.createObject("ADODB.COMMAND")
	PaymentRequest_cmd.activeConnection = MM_PIGO_String
			
	PaymentRequest_cmd.commandText = "SELECT MKT_M_Supplier.spNama1,MKT_T_PaymentRequest_H.pr_spID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv, MKT_M_Supplier.spPaymentTerm, MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.pr_poID, MKT_T_PaymentRequest_D.pr_mmID, MKT_T_PurchaseOrder_D.poPajak FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PaymentRequest_H.pr_poID = MKT_T_PurchaseOrder_H.poID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID LEFT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H ON MKT_M_Supplier.spID = MKT_T_PaymentRequest_H.pr_spID where MKT_T_PaymentRequest_H.prID = '"& prID &"' AND MKT_T_PaymentRequest_H.prTanggalInv = '"& tanggalivn &"' GROUP BY MKT_M_Supplier.spNama1, MKT_T_PaymentRequest_H.pr_spID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv, MKT_M_Supplier.spPaymentTerm, MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.pr_poID,  MKT_T_PaymentRequest_D.pr_mmID, MKT_T_PurchaseOrder_D.poPajak"
    'response.write PaymentRequest_cmd.commandText
	set PaymentRequest = PaymentRequest_cmd.execute


    set mm_cmd = server.createObject("ADODB.COMMAND")
	mm_cmd.activeConnection = MM_PIGO_String

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
            <% do while not PaymentRequest.eof%>
            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <div class="col-4">
                            <span class="txt-desc"> PO Ref </span><br>
                        </div>
                        <div class="col-1 p-0">
                            <span class="txt-desc"> : </span><br>
                        </div>
                        <div class="col-4 p-0 ">
                            <span class="txt-desc"> <%=PaymentRequest("prFaktur")%> </span><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <span class="txt-desc"> Tanggal Invoice </span><br>
                        </div>
                        <div class="col-1 p-0">
                            <span class="txt-desc"> : </span><br>
                        </div>
                        <div class="col-4 p-0 ">
                            <span class="txt-desc"> <%=PaymentRequest("prTanggalInv")%> </span><br>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> Supplier </span><br>
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
                        <div class="col-7 p-0 ">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"><%=PaymentRequest("spNama1")%></span><br>
                                    <span class="txt-desc"><%=PaymentRequest("pr_poID")%></span><br>
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
                                    <span class="txt-desc"> T.O.P </span><br>
                                    <span class="txt-desc"> Jatuh Tempo </span><br>
                                    
                                    <span class="txt-desc"> Receipt No</span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-7 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"><%=PaymentRequest("spPaymentTerm")%></span><br>
                                    <span class="txt-desc">-</span><br>
                                    
                                    <%
                                        mm_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_MaterialReceipt_H RIGHT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_MaterialReceipt_H.mmID = MKT_T_PaymentRequest_D.pr_mmID ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H ON  MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID where MKT_T_PaymentRequest_H.pr_spID = '"& PaymentRequest("pr_spID") &"' AND MKT_T_PaymentRequest_H.pr_poID = '"& PaymentRequest("pr_poID") &"' AND MKT_T_PaymentRequest_H.prID = '"& PaymentRequest("prID") &"' group by MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal "
                                        'response.write mm_cmd.commandText
                                        set mm = mm_cmd.execute
                                    %>
                                    <%do while not mm.eof%>
                                    <span class="txt-desc"><%=mm("mmID")%></span><br>
                                    <%mm.movenext
                                    loop%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row text-center mt-3">
                <div class="col-12">
                    <span class="txt-desc" style="font-size:20px">PAYMENT REQUEST</span><br>
                    <span class="txt-desc">  <%=PaymentRequest("prID")%>  </span><br>
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
                                <th class="text-center"> Item </th>
                                <th class="text-center"> Satuan </th>
                                <th class="text-center"> Qty</th>
                                <th class="text-center"> Harga</th>
                                <th class="text-center"> Sub Total</th>
                            </tr>
                            
                        </thead>
                        <tbody>
                        <% 
                            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_T_PurchaseOrder_D.poPajak FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_PaymentRequest_D LEFT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_PaymentRequest_D.pr_mmID = MKT_T_MaterialReceipt_H.mmID RIGHT OUTER JOIN MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PaymentRequest_H.pr_poID = MKT_T_PurchaseOrder_H.poID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID ON  MKT_T_PaymentRequest_D.prID_H = MKT_T_PaymentRequest_H.prID LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 ON  MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID where MKT_T_PaymentRequest_H.pr_spID = '"& PaymentRequest("pr_spID") &"'  AND MKT_T_PaymentRequest_H.pr_poID = '"& PaymentRequest("pr_poID") &"' AND MKT_T_PaymentRequest_H.prID = '"& PaymentRequest("prID") &"' group by MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_T_PurchaseOrder_D.poPajak  "
                            'response.write produk_cmd.commandText
	                        set produk = produk_cmd.execute
                        %>
                        <% do while not produk.eof%>
                            <tr>
                                <td class="text-center"> <%=produk("no")%> </td>
                                <td> <%=produk("pdNama")%> </td>
                                <td class="text-center"> <%=produk("pdUnit")%> </td>
                                <td class="text-center"> <%=produk("mm_pdQtyDiterima")%> </td>
                                <td class="text-center"> <%=Replace(FormatCurrency(produk("mm_pdHarga")),"$","Rp.  ")%> </td>
                                <% total = produk("mm_pdQtyDiterima")*produk("mm_pdHarga") %>
                                <td class="text-center"> <%=Replace(FormatCurrency(total),"$","Rp.  ")%> </td>
                            </tr>
                            <%
                                subtotal = subtotal + total
                            %>
                            <% produk.movenext
                            loop%>
                            <tr>
                                <th colspan="5" class="text-right"> Total </th>
                                <td class="text-center"> <%=Replace(FormatCurrency(subtotal),"$","Rp.  ")%> </td>
                            </tr>
                            <%
                                tax = PaymentRequest("poPajak")/100*subtotal
                            %>
                            <tr>
                                <th colspan="5" class="text-right"> TAX </th>
                                <td class="text-center"> <%=Replace(FormatCurrency(tax),"$","Rp.  ")%> </td>
                            </tr>
                            <%
                                GrandTotal = subtotal+tax
                            %>
                            <tr>
                                <th colspan="5" class="text-right"> GrandTotal </th>
                                <td class="text-center"> <%=Replace(FormatCurrency(GrandTotal),"$","Rp.  ")%> </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
            <% PaymentRequest.movenext
            loop %>  
            <div class="row text-center" style="margin-top:2rem">
                <div class="col-4">
                    <span class="txt-desc"> </span><br>
                    <span class="txt-desc"> Dibuat Oleh,</span><br><br><br><br>
                    <span class="txt-desc">...........................</span><br>
                </div>
                <div class="col-4">
                    <span class="txt-desc"></span><br>
                    <span class="txt-desc"> Disetujui Oleh,</span><br><br><br><br>
                    <span class="txt-desc">F. Deni Arijanto</span><br>
                </div>
                <div class="col-4">
                    <span class="txt-desc"> Tanggal, <%=Cdate(date())%> </span><br>
                    <span class="txt-desc"> Mengetahui,</span><br><br><br><br>
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