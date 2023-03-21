<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    catID = request.queryString("CatID")

    set Kas_Detail_CMD = server.CreateObject("ADODB.command")
    Kas_Detail_CMD.activeConnection = MM_pigo_STRING

    Kas_Detail_CMD.commandText = "SELECT Item_ID, Item_Name FROM GL_M_Item Where Item_Cat_ID = '"& catID &"' GROUP BY Item_ID, Item_Name  "
    set KategoriBiaya = Kas_Detail_CMD.execute
%>
<table class="align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px;">
<% 
    no = 0 
    do while not KategoriBiaya.eof
    no = no + 1 
%>
    <tr>
        <td class="text-center"><Input onclick="getCatBiaya<%=no%>(),getKeterangan<%=no%>()" class=" text-center cont-text" type="text" name="ItemID" id="ItemID<%=no%>" Value="<%=KategoriBiaya("Item_ID")%>"  style="width:8rem;border:none;"></td>
        <td><Input onclick="getCatBiaya<%=no%>(),getKeterangan<%=no%>()" class="cont-text"type="text" name="NameItem" id="NameItem" Value="<%=KategoriBiaya("Item_Name")%>" style="width:19rem;border:none;"> </td>
    </tr>
    <script>
        function getCatBiaya<%=no%>(){
            $.ajax({
                type: "get",
                url: "load-KategoriBiaya.asp?ItemID="+document.getElementById("ItemID<%=no%>").value,
                success: function (url) {
                $('.cont-CATBIAYA').html(url);
                }
            });
            document.getElementById("cont-KategoriBiaya").style.display = "none"
        }
        function getKeterangan<%=no%>(){
            $.ajax({
                type: "get",
                url: "get-Keterangan.asp?ItemID="+document.getElementById("ItemID<%=no%>").value,
                success: function (url) {
                $('.cont-Keterangan').html(url);
                
                }
            });
        }
    </script>
<% KategoriBiaya.Movenext
loop %>
</table>