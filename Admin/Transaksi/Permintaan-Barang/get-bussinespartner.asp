
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    key = request.queryString("keysearch")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT custID, custNama From MKT_M_Customer where custNama Like '%"& key &"%' "
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute
        
%> 
<span class="txt-purchase-order"> </span><br>
<select onchange="return getsupplier()" class="cont-form" name="keysupplier" id="keysupplier" aria-label="Default select example">
    <option value="">Pilih Bussines Partner</option>
    <% do while not dproduk.eof%>
    <option value="<%=dproduk("custID")%>"><%=dproduk("custNama")%></option>
    <% dproduk.movenext
    loop%>
</select>