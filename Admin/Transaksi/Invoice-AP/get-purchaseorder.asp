<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    InvAP_poID = request.queryString("InvAP_poID")

    set PurchaseOrder_CMD = server.createObject("ADODB.COMMAND")
	PurchaseOrder_CMD.activeConnection = MM_PIGO_String
    PurchaseOrder_CMD.commandText = "SELECT MKT_T_PurchaseOrder_H.poID FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID Where MKT_T_PurchaseOrder_H.poID = '"& InvAP_poID &"' GROUP BY MKT_T_PurchaseOrder_H.poID "
    'Response.Write PurchaseOrder_CMD.commandText & "<br>"
    set PurchaseOrder = PurchaseOrder_CMD.execute
        
%>
<input readonly class="inp-purchase-order" type="text" name="InvAP_LineFrom" id="InvAP_LineFrom" value="<%=PurchaseOrder("poID")%>" style="width:42.5rem">
<input readonly class="inp-purchase-order" type="text" name="flag" id="flag" value="PO">