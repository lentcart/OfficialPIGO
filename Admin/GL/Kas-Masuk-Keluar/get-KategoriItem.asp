<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    CatID = request.queryString("CATID")
    CatName = request.queryString("CATNAME")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT GL_M_Item.Item_Cat_ID, GL_M_CategoryItem_PIGO.Cat_Name FROM GL_M_Item LEFT OUTER JOIN GL_M_CategoryItem_PIGO ON GL_M_Item.Item_Cat_ID = GL_M_CategoryItem_PIGO.Cat_ID  Where GL_M_Item.Item_Cat_ID = '"& CatID &"' AND Cat_Name LIKE '%"& CatName &"%' GROUP BY GL_M_Item.Item_Cat_ID, GL_M_CategoryItem_PIGO.Cat_Name "
    set CATITEM = GL_M_ChartAccount_cmd.execute

%>
<div class="col-4 text-center">
    <span class="cont-text"> ID Kategori Transaksi</span><br>
    <input readonly onfocus="getKategoriKas()" class=" text-center mb-2 cont-form" type="text" name="CBD_Cat_ID" id="CBD_Cat_ID" value="<%=CATITEM("Item_Cat_ID")%>">
</div>
<div class="col-8">
    <span class="cont-text"> Kategori Transaksi</span><br>
    <input onfocus="getKategoriKas()" class=" mb-2 cont-form" type="text" name="CBD_Cat_Name" id="CBD_Cat_Name" value="<%=CATITEM("Cat_Name")%>" >
</div>