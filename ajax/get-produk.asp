<!--#include file="../Connections/pigoConn.asp" -->
<%
    pdNama = trim(request.queryString("a"))

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String
			
	Produk_cmd.commandText = "SELECT dbo.MKT_M_Produk.pdNama, dbo.MKT_M_Produk.pdID, dbo.MKT_M_Seller.sl_custID, dbo.MKT_M_Seller.slName FROM dbo.MKT_M_Seller LEFT OUTER JOIN dbo.MKT_M_Produk ON dbo.MKT_M_Seller.sl_custID = dbo.MKT_M_Produk.pd_custID where MKT_M_Produk.pdAktifYN = 'Y' and MKT_M_Produk.pdNama like '%"& pdNama &"%' order by MKT_M_Produk.pdNama ASC" 
	set Produk = Produk_cmd.execute


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
        <%do while not Produk.eof%>
            <ul style="list-style:none" class="mt-3">
                <li><a href="#"><%=Produk("pdNama")%></a></li>
            </ul>
        <%Produk.movenext
        loop%>