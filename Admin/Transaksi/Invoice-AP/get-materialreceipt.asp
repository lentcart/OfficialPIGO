<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    InvAP_mmID = request.queryString("InvAP_mmID")

    set MaterialReceipt_CMD = server.createObject("ADODB.COMMAND")
	MaterialReceipt_CMD.activeConnection = MM_PIGO_String
    MaterialReceipt_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_MaterialReceipt_H.mm_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 WHERE MKT_T_MaterialReceipt_H.mmID = '"& InvAP_mmID &"' GROUP BY MKT_T_MaterialReceipt_H.mmID"
    'Response.Write MaterialReceipt_CMD.commandText & "<br>"
    set MaterialReceipt = MaterialReceipt_CMD.execute
        
%>
<input readonly class="inp-purchase-order" type="text" name="InvAP_LineFrom" id="InvAP_LineFrom" value="<%=MaterialReceipt("mmID")%>" style="width:42.5rem">
<input readonly class="inp-purchase-order" type="text" name="flag" id="flag" value="MM">