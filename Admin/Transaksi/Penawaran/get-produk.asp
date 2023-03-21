<!--#include file="../../../connections/pigoConn.asp"--> 

<% 
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    kategori = request.queryString("pdkategori")
    merk = request.queryString("pdmerk")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT pdPartNumber , pdNama From MKT_M_PIGO_Produk where pd_catID  = '"& kategori &"' and pd_mrID = '"& merk &"' "
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set partnumber = loadproduk_CMD.execute

%>
<span class="cont-text"> Produk </span><br>
<select onchange="getproduk()"  class="cont-form" name="partnumber" id="partnumber" aria-label="Default select example" required>
    <option value="">Pilih</option>
    <% do while not partnumber.eof %>
    <option value="<%=partnumber("pdPartNumber")%>">[<%=partnumber("pdPartNumber")%>] &nbsp; <%=partnumber("pdNama")%> </option>
    <% partnumber.movenext
    loop %>
</select>