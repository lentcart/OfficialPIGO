<!--#include file="../connections/pigoConn.asp"-->
<%

    Input = request.queryString("Input")
    pdID = request.queryString("pdID")

    set updateqty_CMD = server.CreateObject("ADODB.command")
    updateqty_CMD.activeConnection = MM_pigo_STRING

    updateqty_CMD.commandText = "update MKT_T_Keranjang set cartQty = '"& Input &"' where cart_custID = '"& request.cookies("custID") &"' and cart_pdID = '"& pdID &"' "
    response.write updateqty_CMD.commandText
    updateqty_CMD.execute


%>
