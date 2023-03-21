<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    ItemID = request.queryString("ItemID")
    ItemNama = request.queryString("ItemNama")

    set Kas_Detail_CMD = server.CreateObject("ADODB.command")
    Kas_Detail_CMD.activeConnection = MM_pigo_STRING

    Kas_Detail_CMD.commandText = "SELECT Item_ID, Item_Name FROM GL_M_Item Where Item_ID = '"& ItemID &"' AND Item_Name LIKE '%"& ItemNama &"%' GROUP BY Item_ID, Item_Name   "
    set KategoriBiaya = Kas_Detail_CMD.execute
%>
<span class="cont-text me-4"> Keterangan </span><br>
<input class=" mb-2 cont-form" type="text" name="CBD_Keterangan" id="CBD_Keterangan" value="<%=KategoriBiaya("Item_Name")%>">