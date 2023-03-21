<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    mmTanggal = request.form("tanggalmm")
    mmType = request.form("typemm")
    mmMoveDate = request.form("movedatemm")
    mmAccDate = request.form("accdatemm")
    mm_spID = request.form("supplierid")


        
    set MaterialReceipt_H_CMD = server.CreateObject("ADODB.command")
    MaterialReceipt_H_CMD.activeConnection = MM_pigo_STRING
    MaterialReceipt_H_CMD.commandText = "exec sp_add_MKT_T_MaterialReceipt_H '"& mmTanggal &"','"& mmType &"','"& mmMoveDate &"','"& mmAccDate &"','"& mm_spID &"','C0322000000002'"
    response.write MaterialReceipt_H_CMD.commandText
    set MaterialReceipt_H = MaterialReceipt_H_CMD.execute

    response.redirect "produkmm.asp?mmID=" & trim(MaterialReceipt_H("id"))

%>