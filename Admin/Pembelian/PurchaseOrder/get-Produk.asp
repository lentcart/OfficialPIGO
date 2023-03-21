
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    key = request.queryString("katakunci")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT pdID, pdNama From MKT_M_PIGO_Produk where pdNama  like '%"& key &"%' "
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute
        
%> 
<span class="cont-text"> </span><br>
<select onchange="return getproduk()" class="cont-form" name="pdID" id="pdID" aria-label="Default select example">
    <option value=""> Silahkan Pilih Produk </option>
    <% if dproduk.eof = true then %>
    <option value=""> Data Tidak Ditemukan </option>
    <% else %>
    <% do while not dproduk.eof%>
    <option value="<%=dproduk("pdID")%>"><%=dproduk("pdNama")%></option>
    <% dproduk.movenext
    loop%>
    <%end if%>
</select>
