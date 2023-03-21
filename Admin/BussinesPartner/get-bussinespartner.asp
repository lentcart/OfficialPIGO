<!--#include file="../../connections/pigoConn.asp"--> 

<% 

    custNama = request.queryString("custNama")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String
    BussinesPart_CMD.commandText = "SELECT custID , custNama From MKT_M_Customer Where custNama Like '%"& custNama &"%' "
    'Response.Write BussinesPart_CMD.commandText & "<br>"
    set BussinesPart = BussinesPart_CMD.execute
        
%>
<% if BussinesPart.eof = true then %>

<span class="cont-text"> Silahkan Lanjut Pengisian Data  </span><br>
<select disabled="true"  class="cont-form" name="" id="" aria-label="Default select example">

    <option value=""> Data <b><%=custNama%></b> Tidak Ditemukan </option>

</select>
<% else %>
<span class="cont-text">  </span><br>
<select   onchange="getbussines()" class="cont-form" name="custID" id="custID" aria-label="Default select example">
    <option value=""> Pilih Nama Customer </option>
<% do while not BussinesPart.eof %>
    <option value="<%=BussinesPart("custID")%>"><%=BussinesPart("custNama")%></option>
<% BussinesPart.movenext
loop %>
</select>
<% end if %>