
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    custNama = request.queryString("keysearch")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String

    BussinesPart_CMD.commandText = "SELECT custID, custNama FROM MKT_M_Customer where custNama like '%"& custNama &"%' "
    'Response.Write BussinesPart_CMD.commandText & "<br>"


set BussinesPart = BussinesPart_CMD.execute
        
%>
<span class="cont-text"> </span><br>
<select onchange=" getBussines()" class="cont-form" name="bussinespartner" id="bussinespartner" aria-label="Default select example" required>
<option value="">Pilih Bussines Partner </option>
    <% do while not BussinesPart.eof%>
    <option value="<%=BussinesPart("custID")%>"><%=BussinesPart("custNama")%></option>
    <% BussinesPart.movenext
    loop%>
</select>

<script>
    function getBussines(){
    var Bussines = document.getElementById("bussinespartner").value; 
            
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