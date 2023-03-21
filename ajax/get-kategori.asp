<!--#include file="../Connections/pigoConn.asp" -->
<%

    set kategori_cmd = server.createObject("ADODB.COMMAND")
	kategori_cmd.activeConnection = MM_PIGO_String
			
	kategori_cmd.commandText = "SELECT [catID] ,[catName] ,[catAktifYN] FROM [PIGO].[dbo].[MKT_M_Kategori] where catAktifYN = 'Y'" 
	set kategori = kategori_cmd.execute


%>
<script>
var contsearch = document.getElementById("cont-search");
var cont = document.getElementById("cont");
    var span = document.getElementsByClassName("close")[0];
        span.onclick = function() {
            contsearch.style.display = "none";
            cont.style.display = "none";
            }
</script>
        <span class="close">&times;</span>
        <%do while not kategori.eof%>
        
            <ul style="list-style:none" class="mt-3">
                <li><%=kategori("catName")%></li>
            </ul>
        <%kategori.movenext
        loop%>