<!--#include file="../../../connections/pigoConn.asp"--> 

<%
    pdID = request.queryString("produkid")
    pdStok = request.queryString("stokproduk")
    pdHargaJual = request.queryString("harga")

    set upproduk_CMD = server.CreateObject("ADODB.command")
    upproduk_CMD.activeConnection = MM_pigo_STRING
    
    upproduk_CMD.commandText = "select * from MKT_M_Produk where pdID  = '"& pdID &"' "
	'response.write upproduk_CMD.commandText  & "<BR>"
    set upproduk = upproduk_CMD.execute

    if upproduk.EOF = false then

        set updateproduk_CMD = server.CreateObject("ADODB.command")
        updateproduk_CMD.activeConnection = MM_pigo_STRING

        updateproduk_CMD.commandText = "update MKT_M_Produk set pdStok = '"& pdStok &"' , pdHargaJual = '"& pdHargaJual &"' where pdID  = '"& pdID &"' "
        'response.write updateproduk_CMD.commandText  & "<BR>"
        set updateproduk = updateproduk_CMD.execute

        Response.redirect "index.asp"
    else
        Response.redirect "upproduk.asp?pdID=" & trim(pdID)
    end if
    ' Response.redirect "index.asp"
%>