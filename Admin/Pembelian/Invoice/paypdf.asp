<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    payID = request.queryString("payID")
    tglpayment = request.queryString("tglpayment")
    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Payment_cmd = server.createObject("ADODB.COMMAND")
	Payment_cmd.activeConnection = MM_PIGO_String
			
	Payment_cmd.commandText = "SELECT MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_Payment_H.payID, MKT_T_PaymentRequest_H.prID FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_M_Supplier.spID = MKT_T_Payment_H.pay_spID LEFT OUTER JOIN MKT_T_PaymentRequest_D RIGHT OUTER JOIN MKT_T_Payment_D LEFT OUTER JOIN MKT_T_PaymentRequest_H ON MKT_T_Payment_D.pay_prID = MKT_T_PaymentRequest_H.prID ON MKT_T_PaymentRequest_D.prID_H = MKT_T_PaymentRequest_H.prID ON  MKT_T_Payment_H.payID = MKT_T_Payment_D.payID_H where MKT_T_Payment_H.payID = '"& payID &"' and MKT_T_Payment_H.payTanggal = '"& tglpayment &"' group by MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_Payment_H.payID, MKT_T_PaymentRequest_H.prID   "
    'response.write Payment_cmd.commandText
	set Payment = Payment_cmd.execute


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
            <% do while not Payment.eof%>
            <div class="row text-center mt-1">
                <div class="col-12">
                    <span class="txt-desc" style="font-size:20px">BUKTI KAS KELUAR</span><br>
                    <span class="txt-desc">  <%=Payment("payID")%>  </span><br>
                </div>
            </div>
            <div class="row">
                <div class="col-2">
                    <span class="txt-desc">Dibayarkan Kepada</span><br>
                </div>
                <div class="col-1 p-0">
                    <span class="txt-desc">:</span><br>
                </div>
                <div class="col-4 p-0">
                    <span class="txt-desc"><%=payment("spNama1")%></span><br>
                </div>
            </div>
            <div class="row">
                <div class="col-2">
                    <span class="txt-desc">No Payment Request</span><br>
                </div>
                <div class="col-1 p-0">
                    <span class="txt-desc">:</span><br>
                </div>
                <div class="col-4 p-0">
                    <span class="txt-desc"><%=payment("prID")%></span><br>
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
                                <th class="text-center"> PO </th>
                                <th class="text-center"> Receipt No </th>
                                <th class="text-center"> Sub Total</th>
                            </tr>
                            
                        </thead>
                        <tbody>
                        <% 
                            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY prID_H) AS no, MKT_T_PaymentRequest_D.pr_poID, MKT_T_PaymentRequest_D.pr_mmID FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_Payment_D LEFT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.pay_prID = MKT_T_Payment_H.payID LEFT OUTER JOIN MKT_T_PaymentRequest_H ON MKT_T_Payment_D.pay_prID = MKT_T_PaymentRequest_H.prID LEFT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H ON MKT_M_Supplier.spID = MKT_T_Payment_H.pay_spID WHERE MKT_T_Payment_H.payID = '"& payment("payID") &"' AND MKT_T_Payment_H.pay_spID = '"& Payment("spID") &"' group by MKT_T_PaymentRequest_D.pr_poID, MKT_T_PaymentRequest_D.pr_mmID, MKT_T_PaymentRequest_D.prID_H "
                            'response.write produk_cmd.commandText
	                        set produk = produk_cmd.execute
                        %>
                        <% do while not produk.eof%>
                            <tr>
                                <td class="text-center"> <%=produk("no")%> </td>
                                <td> <%=produk("pr_poID")%> </td>
                                <td class="text-center"> <%=produk("pr_mmID")%> </td>
                                <td class="text-center"> <%=Replace(FormatCurrency(produk("pr_mmSubtotal")),"$","Rp.  ")%> </td>
                            </tr>
                            <%
                                subtotal = subtotal + produk("pr_mmSubtotal")
                            %>
                            <% produk.movenext
                            loop%>
                            <tr>
                                <th colspan="3" class="text-right"> Total </th>
                                <td class="text-center"> <%=Replace(FormatCurrency(subtotal),"$","Rp.  ")%> </td>
                            </tr>
                            <%
                                tax = 11/100*subtotal
                            %>
                            <tr>
                                <th colspan="3" class="text-right"> TAX </th>
                                <td class="text-center"> <%=Replace(FormatCurrency(tax),"$","Rp.  ")%> </td>
                            </tr>
                            <%
                                GrandTotal = subtotal+tax
                            %>
                            <tr>
                                <th colspan="3" class="text-right"> GrandTotal </th>
                                <td class="text-center"> <%=Replace(FormatCurrency(GrandTotal),"$","Rp.  ")%> </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
            <% Payment.movenext
            loop %>  
            <div class="row text-center" style="margin-top:1rem">
                <div class="col-7">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                        <thead>
                            <tr>
                                <th class="text-center"> Direksi </th>
                                <th class="text-center"> Fiat Byr </th>
                                <th class="text-center"> Pembk. </th>
                                <th class="text-center"> Kabag </th>
                            </tr>
                            
                        </thead>
                        <tbody>
                            <td><br><br><br><br></td>
                            <td><br><br><br><br></td>
                            <td><br><br><br><br></td>
                            <td><br><br><br><br></td>
                        </tbody>
                    </table>
                </div>
                <div class="col-5">
                    <span   class="txt-desc"> Tanggal, <%=Cdate(date())%> </span><br>
                    <span   class="txt-desc"> Tanda Tangan Penerima</span><br><br><br><br>
                    <span   class="txt-desc"> ...................</span><br><br><br><br>
                    
                </div>
            </div>          
        </div>
    </div>
</body>

    <script>

        
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>