<!--#include file="../../../../connections/pigoConn.asp"-->

<% 
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    poID = request.Form("poID")
    po_spID = request.Form("po_spID")

    set Update_CMD = server.CreateObject("ADODB.command")
    Update_CMD.activeConnection = MM_pigo_STRING

    Update_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_H set poAktifYN = 'N' WHERE poID = '"& poID &"' "
    'response.write Update_CMD.commandText & "<br><br>"
    set UpdateH = Update_CMD.execute
    
    Update_CMD.commandText = "INSERT INTO [dbo].[MKT_T_PurchaseOrder_R]([poID],[po_Ket],[po_custID],[poUpdateID],[poUpdateTime],[poAktifYN])VALUES('"& poID &"','02','"& po_spID &"','','"& now() &"','Y')  "
    'response.write Update_CMD.commandText & "<br><br>"
    set UpdateR = Update_CMD.execute

    poTanggal = request.Form("poTanggal")
    poJenis = request.Form("poJenis")
    poJenisOrder = request.Form("poJenisOrder")
    poTglOrder = request.Form("poTglOrder")
    poTglDiterima = request.Form("poTglDiterima")
    poStatusKredit = request.Form("poStatusKredit")
    poDropShip = request.Form("poDropShip")
    poKonfPem = request.Form("poKonfPem")

    set PurchaseOrder_H_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_H_CMD.activeConnection = MM_pigo_STRING

    PurchaseOrder_H_CMD.commandText = "exec sp_add_MKT_T_PurchaseOrder_H '"& poTanggal &"','"& poJenisOrder &"','"& poTglOrder &"','"& poTglDiterima &"','"& poStatusKredit &"','"& poDesc &"','','',0,'"& po_spID &"','','N','','N','','"& session("username") &"'"
    'response.write PurchaseOrder_H_CMD.commandText & "<br><br>"
    set PurchaseOrder_H = PurchaseOrder_H_CMD.execute

    Response.redirect "load-po.asp?newpo=" & trim(PurchaseOrder_H("id")) &"&poID="& poID &"&po_spID="&po_spID

%>
