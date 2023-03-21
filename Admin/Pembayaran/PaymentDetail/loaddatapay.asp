<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    payID = trim(request.queryString("caripay"))

    set Payment_cmd = server.createObject("ADODB.COMMAND")
	Payment_cmd.activeConnection = MM_PIGO_String

        Payment_cmd.commandText = "SELECT MKT_T_Payment_H.payID, MKT_T_Payment_H.payBank, MKT_T_Payment_H.payType, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payDesc, MKT_M_Supplier.spID, MKT_M_Supplier.spNama1,  MKT_M_Supplier.spAlamat, MKT_T_Payment_D.pay_subtotal, MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_D.pr_poID, MKT_T_PaymentRequest_D.pr_mmID FROM MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_PaymentRequest_D LEFT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_PaymentRequest_D.pr_mmID = MKT_T_MaterialReceipt_H.mmID ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H RIGHT OUTER JOIN MKT_T_Payment_D ON MKT_T_PaymentRequest_H.prID = MKT_T_Payment_D.pay_prID RIGHT OUTER JOIN MKT_M_Supplier RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_M_Supplier.spID = MKT_T_Payment_H.pay_spID ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID LEFT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON MKT_T_PaymentRequest_D.pr_poID = MKT_T_PurchaseOrder_H.poID WHERE  MKT_T_Payment_H.payID like '%"& payID &"%' GROUP BY MKT_T_Payment_H.payID, MKT_T_Payment_H.payBank, MKT_T_Payment_H.payType, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payDesc, MKT_M_Supplier.spID, MKT_M_Supplier.spNama1,  MKT_M_Supplier.spAlamat, MKT_T_Payment_D.pay_subtotal, MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_D.pr_poID, MKT_T_PaymentRequest_D.pr_mmID"
        'response.write Payment_cmd.commandText 

    set Payment = Payment_cmd.execute
%>
<% do while not Payment.eof %>
    <tr>
        <td class="text-center"> <%=Payment("payID")%></td>
        <td class="text-center"> <%=Payment("payTanggal")%><input type="hidden" name="tglpayment" id="tglpayment" value="<%=Payment("payTanggal")%>"> </td>
        <td class="text-center"> <%=Payment("payBank")%> </td>
        <td> <%=Payment("PayDesc")%> </td>
        <td> <%=Payment("prID")%> </td>
        <td> <%=Payment("SpNama1")%> </td>
        <td> <%=Payment("spAlamat")%> </td>
        <td class="text-center"> <%=Replace(Replace(FormatCurrency(Payment("pay_subtotal")),"$","Rp.   "),"00","")%> </td>
    </tr>
<% Payment.movenext
loop%>
