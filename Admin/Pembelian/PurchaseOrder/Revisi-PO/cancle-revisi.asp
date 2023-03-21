<!--#include file="../../../../connections/pigoConn.asp"-->

<% 
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    poIDLama = request.queryString("poIDLama")
    poIDBaru = request.queryString("poIDBaru")
    
    set PurchaseOrder_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_CMD.activeConnection = MM_pigo_STRING

    PurchaseOrder_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_PurchaseOrder_H] Where poID =  '"& poIDBaru &"' "
    'response.write PurchaseOrder_CMD.commandText &"<br><br>"
    set PurchaseOrder = PurchaseOrder_CMD.execute

    set Update_CMD = server.CreateObject("ADODB.command")
    Update_CMD.activeConnection = MM_pigo_STRING
    Update_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_H set poAktifYN = 'Y' WHERE poID = '"& poIDLama &"' "
    'response.write Update_CMD.commandText & "<br><br>"
    set UpdateH = Update_CMD.execute
    Update_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set poID_H = '"& poIDLama &"' WHERE poID_H = '"& poIDBaru &"' "
    'response.write Update_CMD.commandText & "<br><br>"
    set UpdateD = Update_CMD.execute
    Update_CMD.commandText = "DELETE FROM MKT_T_PurchaseOrder_R Where poID = '"& poIDLama &"' AND po_Ket = '02' "
    'response.write Update_CMD.commandText & "<br><br>"
    set UpdateR = Update_CMD.execute
    Update_CMD.commandText = "DELETE FROM MKT_T_PurchaseOrder_R Where poID = '"& poIDBaru &"'  "
    'response.write Update_CMD.commandText & "<br><br>"
    set Update = Update_CMD.execute
%> 