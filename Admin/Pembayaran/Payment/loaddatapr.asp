
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    prID = request.queryString("prID")

    set loadpr_CMD = server.createObject("ADODB.COMMAND")
	loadpr_CMD.activeConnection = MM_PIGO_String

    loadpr_CMD.commandText = "SELECT MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prType, MKT_T_PaymentRequest_H.prTanggalInv FROM MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_MaterialReceipt_H RIGHT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_MaterialReceipt_H.mmID = MKT_T_PaymentRequest_D.pr_mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H  WHERE MKT_T_PaymentRequest_H.prID = '"& prID &"' GROUP BY MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prType, MKT_T_PaymentRequest_H.prTanggalInv"
    'Response.Write loadpr_CMD.commandText & "<br>"

    set loadpr = loadpr_CMD.execute
    

    set tax_CMD = server.createObject("ADODB.COMMAND")
	tax_CMD.activeConnection = MM_PIGO_String

    tax_CMD.commandText = "SELECT MKT_T_PurchaseOrder_D.poPajak FROM MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_MaterialReceipt_H RIGHT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_MaterialReceipt_H.mmID = MKT_T_PaymentRequest_D.pr_mmID LEFT OUTER JOIN MKT_T_PurchaseOrder_H RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D2.mm_poID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H  WHERE MKT_T_PaymentRequest_H.prID = '"& loadpr("prID") &"' group by  MKT_T_PurchaseOrder_D.poPajak  "
    'Response.Write tax_CMD.commandText & "<br>"

    set tax = tax_CMD.execute

    set total_CMD = server.createObject("ADODB.COMMAND")
	total_CMD.activeConnection = MM_PIGO_String
%>
<% do while not loadpr.eof %>
    <div class="row">
        <div class="col-6">
            <div class="row">
                <div class="col-6">
                    <span class="txt-payment-request"> Tanggal Invoice  </span><br>
                    <input type="text" class=" mb-2 inp-payment-request" name="tglinvoice" id="tglinvoice" value="<%=loadpr("prTanggalInv")%>" style="width:14rem"><br>
                </div>
                <div class="col-6">
                    <span class="txt-payment-request"> Type Dokumen Payment Request </span><br>
                    <input type="text" class=" mb-2 inp-payment-request" name="jenisinvoice" id="jenisinvoice" value="<%=loadpr("prType")%>" style="width:14rem"><br>
                </div>
            </div>
        </div>
        <% 
            total_CMD.commandText = "SELECT MKT_T_PaymentRequest_H.prID, MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_T_PurchaseOrder_D.poPajak FROM MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_MaterialReceipt_H RIGHT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_MaterialReceipt_H.mmID = MKT_T_PaymentRequest_D.pr_mmID LEFT OUTER JOIN MKT_T_PurchaseOrder_H RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D2.mm_poID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H WHERE MKT_T_PaymentRequest_H.prID = '"& loadpr("prID") &"' group by  MKT_T_PaymentRequest_H.prID, MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_T_PurchaseOrder_D.poPajak  "
            'Response.Write total_CMD.commandText & "<br>"

            set total = total_CMD.execute
        %>
        <% do while not total.eof %>
        <input type="hidden" class=" mb-2 inp-payment-request" name="jenisinvoice" id="jenisinvoice" value="<%=total("mm_pdSubtotal")%>" style="width:14rem">
        <% subtotal = subtotal + total("mm_pdSubtotal")%>
        <% total.movenext
        loop %>
        <% loadpr.movenext
        loop %>
        <div class="col-6">
            <div class="row">
                <div class="col-4">
                    <span class="txt-payment-request"> Total  </span><br>
                    <input type="number" class=" mb-2 inp-payment-request" name="total" id="total" value="<%=subtotal%>" style="width:10rem"><br>
                </div>
                <div class="col-4">
                    <span class="txt-payment-request"> TAX </span><br>
                    <input type="number" class=" mb-2 inp-payment-request" name="tax" id="tax" value="<%=tax("poPajak")%>" style="width:10rem"><br>
                </div>
                <%
                    tax = tax("poPajak")/100*subtotal
                %>
                <%
                    grandtotal = subtotal+tax
                %>
                <div class="col-4">
                    <span class="txt-payment-request"> Sub Total  </span><br>
                    <input type="number" class=" mb-2 inp-payment-request" name="subtotal" id="subtotal" value="<%=grandtotal%>" style="width:9.4rem"><br>
                </div>
            </div>
        </div>
    </div>
