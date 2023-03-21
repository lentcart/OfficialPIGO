<!--#include file="../../connections/pigoConn.asp"--> 
<% if request.Cookies("custEmail")="" then

response.redirect("../")

end if
%> 

<%
	dim produkid, stokid, sku

    produkid = request.form("produkid")
    if produkid = "" then   
        produkid = request.queryString("produkid")
    end if
    stokid = request.form("stokid")
    sku = request.form("sku")

    set stok_CMD = server.CreateObject("ADODB.command")
    stok_CMD.activeConnection = MM_pigo_STRING

    stok_CMD.commandText = "delete MKT_T_ProdukD where SKU = '"& SKU &"'"
    stok_CMD.execute 

	stok_CMD.commandText = "insert into MKT_T_ProdukD values('"& stokID &"', '"& produkID &"', '"& SKU &"', '"& request.Cookies("custEmail") &"', '"& now() &"' )"
	
   ' if SKU<>"" and  stokid<>"" then


    
    'response.write stok_CMD.commandText  & "<BR>"
    set stok= stok_CMD.execute
   ' end if

   response.redirect "index.asp?produkid=" & produkid
%>

