<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    bpNama = request.queryString("keysearch")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String

    BussinesPart_CMD.commandText = "SELECT custID, custNama FROM MKT_M_Customer where custNama like '%"& bpNama &"%' "
    'Response.Write BussinesPart_CMD.commandText & "<br>"


set BussinesPart = BussinesPart_CMD.execute
        
%>
<span class="txt-purchase-order"> </span><br>
<select onchange="return getbussines()" class="cont-form" name="bussinespartner" id="bussinespartner" aria-label="Default select example" required>
<option value="">Silahkan Pilih BussinesPartner </option>
    <% do while not BussinesPart.eof%>
    <option value="<%=BussinesPart("custID")%>"><%=BussinesPart("custNama")%></option>
    <% BussinesPart.movenext
    loop%>
</select>

<script>
    function getbussines(){
    var Bussines = document.getElementById("bussinespartner").value;
    console.log(Bussines);
             
    $.ajax({
        type: "get",
        url: "get-bussines.asp?bussines="+Bussines,
        success: function (url) {
        // console.log(url);
        $('.cont-bussines').html(url);
        }
    });
    }
</script>