<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    poID = request.form("poid")
    poKonfPem = request.form("jeniskonfirmasi")


    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText = "UPDATE MKT_T_PurchaseOrder_H set poKonfYN = 'Y', poKonfPem = '"& poKonfPem &"' where poID = '"& poID &"'  "
        'response.write PurchaseOrder_cmd.commandText
        set UpdatePO = PurchaseOrder_cmd.execute
    
%>