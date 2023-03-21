
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    key = request.queryString("katakunci")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT pdKey, pdID, pdNama From MKT_M_PIGO_Produk where pdKey  = '"& key &"' "
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute
        
%> 
<span class="txt-purchase-order"> </span><br>
<select onchange="return getproduk()" style="width:19.4rem" class=" mb-2 inp-purchase-order" name="keyproduk" id="keyproduk" aria-label="Default select example">
    <option value="">Pilih Produk</option>
    <% do while not dproduk.eof%>
    <option value="<%=dproduk("pdID")%>"><%=dproduk("pdKey")%>,<%=dproduk("pdNama")%></option>
    <% dproduk.movenext
    loop%>
</select>