
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    key = request.queryString("keysearch")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT spKey, spID, spNama1 From MKT_M_Supplier where spKey  = '"& key &"' "
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute
        
%> 
<span class="txt-purchase-order"> </span><br>
<select onchange="return getsupplier()" style="width:19.4rem" class=" mb-2 inp-purchase-order" name="keysupplier" id="keysupplier" aria-label="Default select example">
    <option value="">Pilih Supplier</option>
    <% do while not dproduk.eof%>
    <option value="<%=dproduk("spID")%>"><%=dproduk("spKey")%>,<%=dproduk("spNama1")%></option>
    <% dproduk.movenext
    loop%>
</select>