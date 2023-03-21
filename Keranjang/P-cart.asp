<!--#include file="../connections/pigoConn.asp"-->

<% 
    pdID = request.queryString("pdID")
    slID = request.queryString("slID")
    qty = request.queryString("qty")

    if request.Cookies("custEmail")="" then 

    response.redirect("../Login/")
    
    else

    set cart_H_CMD = server.CreateObject("ADODB.command")
    cart_H_CMD.activeConnection = MM_pigo_STRING

    cart_H_CMD.commandText = "exec [sp_add_MKT_T_Keranjang]  '"& request.cookies("custID")  &"','"& pdID &"','"& slID &"',"& qty &" "
    'response.write cart_H_CMD.commandText
    set cart = cart_H_CMD.execute


    Response.redirect "../Keranjang/"
    end if
%> 