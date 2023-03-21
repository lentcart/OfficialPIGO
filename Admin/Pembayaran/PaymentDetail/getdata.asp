<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    payID = request.queryString("payID")

    set Payment_cmd = server.createObject("ADODB.COMMAND")
	Payment_cmd.activeConnection = MM_PIGO_String

        Payment_cmd.commandText = "SELECT MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payDesc, MKT_T_Payment_H.pay_custID, MKT_M_Customer.custNama, MKT_T_Payment_D.pay_prID,  MKT_T_Payment_D.pay_total, MKT_T_Payment_D.pay_dibayar, MKT_T_Payment_D.pay_sisa, MKT_T_Payment_D.pay_subtotal, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Tanggal FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_M_Customer.custID = MKT_T_Payment_H.pay_custID LEFT OUTER JOIN MKT_T_InvoiceVendor_D LEFT OUTER JOIN MKT_T_InvoiceVendor_D1 ON MKT_T_InvoiceVendor_D.InvAP_Line = MKT_T_InvoiceVendor_D1.InvAP_DLine RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID RIGHT OUTER JOIN MKT_T_Payment_D ON MKT_T_InvoiceVendor_H.InvAPID = MKT_T_Payment_D.pay_prID ON MKT_T_Payment_H.payID = MKT_T_Payment_D.payID_H WHERE MKT_T_Payment_H.payID = '"& payID &"' GROUP BY MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payDesc, MKT_T_Payment_H.pay_custID, MKT_M_Customer.custNama, MKT_T_Payment_D.pay_prID,  MKT_T_Payment_D.pay_total, MKT_T_Payment_D.pay_dibayar, MKT_T_Payment_D.pay_sisa, MKT_T_Payment_D.pay_subtotal, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Tanggal "
        'response.write Payment_cmd.commandText 

    set Payment = Payment_cmd.execute
%>
<% 
    no = 0 
    do while not Payment.eof 
    no = no + 1
%>
<tr>
    <td class="text-center"><%=no%></td>
    <td class="text-center"><%=Payment("payID")%></td>
    <td class="text-center"><%=Payment("payTanggal")%></td>
    <td><%=Payment("custNama")%></td>
    <td><%=Payment("payDesc")%>&nbsp;<%=Payment("InvAPID")%>/<%=Payment("InvAP_Tanggal")%></td>
    <td class="text-end"><%=Replace(Replace(FormatCurrency(Payment("pay_Total")),"$","Rp. "),".00","")%></td>
    <td class="text-end"><%=Replace(Replace(FormatCurrency(Payment("pay_Dibayar")),"$","Rp. "),".00","")%></td>
    <td class="text-end"><%=Replace(Replace(FormatCurrency(Payment("pay_sisa")),"$","Rp. "),".00","")%></td>
    </tr>
<% 
    Payment.movenext
    loop
%>
