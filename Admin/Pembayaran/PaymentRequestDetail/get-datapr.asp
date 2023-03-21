<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    prID = request.queryString("prID")


    set PaymentRequest_cmd = server.createObject("ADODB.COMMAND")
	PaymentRequest_cmd.activeConnection = MM_PIGO_String

        PaymentRequest_cmd.commandText = "SELECT MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv, MKT_T_PaymentRequest_D.pr_poID, MKT_T_PaymentRequest_D.pr_mmID, MKT_M_Customer.custNama,  MKT_T_PaymentRequest_H.pr_custID, MKT_M_StatusPayment.spayID, MKT_M_StatusPayment.spayName FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_PaymentRequest_D LEFT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_PaymentRequest_D.pr_mmID = MKT_T_MaterialReceipt_H.mmID ON MKT_T_PurchaseOrder_H.poID = MKT_T_PaymentRequest_D.pr_poID RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_M_StatusPayment ON MKT_T_PaymentRequest_H.pr_spayID = MKT_M_StatusPayment.spayID ON MKT_M_Customer.custID = MKT_T_PaymentRequest_H.pr_custID ON  MKT_T_PaymentRequest_D.prID_H = MKT_T_PaymentRequest_H.prID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 Where MKT_T_PaymentRequest_H.prID = '"& prID &"' GROUP BY MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv, MKT_T_PaymentRequest_D.pr_poID, MKT_T_PaymentRequest_D.pr_mmID, MKT_M_Customer.custNama,  MKT_T_PaymentRequest_H.pr_custID, MKT_M_StatusPayment.spayID, MKT_M_StatusPayment.spayName " 
        'response.write PaymentRequest_cmd.commandText

    set PaymentRequest = PaymentRequest_cmd.execute
%>
<% do while not PaymentRequest.eof %>
    <tr>
        <td> <%=PaymentRequest("prID")%><input type="hidden" name="tglinvoice" id="tglinvoice" value="<%=PaymentRequest("prTanggalInv")%>"> </td>
        <td class="text-center"> <%=PaymentRequest("prTanggalInv")%> </td>
        <td> <%=PaymentRequest("custNama")%> </td>
        <td class="text-center"> <%=PaymentRequest("pr_poID")%> </td>
        <td class="text-center"> <%=PaymentRequest("pr_mmID")%> </td>
        <% if PaymentRequest("spayID") = "1" then %>
        <td class="text-center"><span class="label-pr1"> <%=PaymentRequest("spayName")%> </span></td>
        <% else %>
        <td class="text-center"><span class="label-pr2"> <%=PaymentRequest("spayName")%> </span></td>
        <%end if%>
    </tr>
<% PaymentRequest.movenext
loop%>
