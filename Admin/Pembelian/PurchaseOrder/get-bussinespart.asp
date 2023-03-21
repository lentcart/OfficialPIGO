
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    bpNama = request.queryString("keysearch")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String

    BussinesPart_CMD.commandText = "SELECT custID, custNama FROM MKT_M_Customer where custNama like '%"& bpNama &"%' AND custPartnerGroup = 'V'  "
    'Response.Write BussinesPart_CMD.commandText & "<br>"


set BussinesPart = BussinesPart_CMD.execute
        
%>
<span class="cont-text"> </span><br>
<select onchange="return getBussines()" class="cont-form" name="bussinespartner" id="bussinespartner" aria-label="Default select example" required>
<option value="">Pilih </option>
    <% do while not BussinesPart.eof%>
    <option value="<%=BussinesPart("custID")%>"><%=BussinesPart("custNama")%></option>
    <% BussinesPart.movenext
    loop%>
</select>