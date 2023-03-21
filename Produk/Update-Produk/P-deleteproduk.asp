<!--#include file="../../connections/pigoConn.asp"-->

<% 

    pdid = request.queryString("pdid")
    
    set Delete_CMD = server.CreateObject("ADODB.command")
    Delete_CMD.activeConnection = MM_pigo_STRING

    Delete_CMD.commandText = "DELETE FROM MKT_M_Produk where pdID = '"& pdid &"' "
    Delete_CMD.execute

    Response.redirect "../Daftar-Produk/"
%> 