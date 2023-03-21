<!--#include file="../../../connections/pigoConn.asp"-->

<% 

    poid	= request.queryString("poid")
    alasan	= request.queryString("alasan")
    pospid	= request.queryString("pospid")

    set Update_CMD = server.CreateObject("ADODB.command")
    Update_CMD.activeConnection = MM_pigo_STRING
    Update_CMD.commandText = "INSERT INTO [dbo].[MKT_T_PurchaseOrder_R]([poID],[po_Ket],[po_custID],[poUpdateID],[poUpdateTime],[poAktifYN])VALUES('"& poid &"','"& alasan &"','"& pospid &"','"& session("username") &"','"& now() &"','Y')"
    'response.write Update_CMD.commandText &"<BR><BR>"
    set Update = Update_CMD.execute

    set UpdatePO_CMD = server.CreateObject("ADODB.command")
    UpdatePO_CMD.activeConnection = MM_pigo_STRING
    UpdatePO_CMD.commandText = "Update MKT_T_PurchaseOrder_D set po_spoID = 4 Where poID_H = '"& poid &"' "
    'response.write UpdatePO_CMD.commandText &"<BR><BR>"
    set UpdatePO = UpdatePO_CMD.execute
%>