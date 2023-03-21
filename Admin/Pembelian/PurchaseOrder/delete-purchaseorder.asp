<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    poID = request.Form("poID") 
    
    set PurchaseOrder_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_CMD.activeConnection = MM_pigo_STRING

    PurchaseOrder_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_PurchaseOrder_H] Where poID =  '"& poID &"' "
    'response.write PurchaseOrder_CMD.commandText &"<br><br>"
    set PurchaseOrder = PurchaseOrder_CMD.execute
    PurchaseOrder_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_PurchaseOrder_D] Where poID_H =  '"& poID &"' "
    'response.write PurchaseOrder_CMD.commandText &"<br><br>"
    set PurchaseOrderD = PurchaseOrder_CMD.execute
    PurchaseOrder_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_PurchaseOrder_R] Where poID =  '"& poID &"' "
    'response.write PurchaseOrder_CMD.commandText &"<br><br>"
    set PurchaseOrderR = PurchaseOrder_CMD.execute
%> 