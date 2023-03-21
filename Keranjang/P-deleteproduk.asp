<!--#include file="../connections/pigoConn.asp"-->

<% 

    pdid = request.queryString("pdid")
    
    
    
    set Delete_CMD = server.CreateObject("ADODB.command")
    Delete_CMD.activeConnection = MM_pigo_STRING

    Delete_CMD.commandText = "delete From MKT_T_Keranjang where cart_pdID = '"& pdid &"' "
    Delete_CMD.execute

    Response.redirect "index.asp"
%> 