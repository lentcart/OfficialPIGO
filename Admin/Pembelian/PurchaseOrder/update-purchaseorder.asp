<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    poID = request.form("poID")
    status = request.form("status")

    set PurchaseOrder_R_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_R_CMD.activeConnection = MM_pigo_STRING
    PurchaseOrder_R_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_H set poStatus = '"& status &"' WHERE poID = '"& poID &"'  "
    'response.write PurchaseOrder_R_CMD.commandText
    set PurchaseOrder_R = PurchaseOrder_R_CMD.execute

%>