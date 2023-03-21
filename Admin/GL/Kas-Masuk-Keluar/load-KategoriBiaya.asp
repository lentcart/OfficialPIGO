<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    ItemID = request.queryString("ItemID")
    ItemNama = request.queryString("ItemNama")

    set Kas_Detail_CMD = server.CreateObject("ADODB.command")
    Kas_Detail_CMD.activeConnection = MM_pigo_STRING

    Kas_Detail_CMD.commandText = "SELECT Item_ID, Item_Name FROM GL_M_Item Where Item_ID = '"& ItemID &"' AND Item_Name LIKE '%"& ItemNama &"%' GROUP BY Item_ID, Item_Name   "
    set KategoriBiaya = Kas_Detail_CMD.execute
%>
<div class="col-4 text-center">
    <span class=" text-center cont-text"> ID Biaya Transaksi </span><br>
    <input readonly onfocus="getKategoriBiaya()" class="text-center mb-2 cont-form" type="text" name="CBD_Item_ID" id="CBD_Item_ID" value="<%=KategoriBiaya("Item_ID")%>" >
</div>
<div class="col-8">
    <span class="cont-text"> Nama Biaya Transaksi </span><br>
    <input onfocus="getKategoriBiaya()" class=" mb-2 cont-form" type="text" name="CBD_Item_Name" id="CBD_Item_Name" value="<%=KategoriBiaya("Item_Name")%>" >
</div>