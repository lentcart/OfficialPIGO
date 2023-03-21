<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    Item_Tipe = request.queryString("CATName")

    set GL_M_Item_cmd = server.createObject("ADODB.COMMAND")
	GL_M_Item_cmd.activeConnection = MM_PIGO_String
        GL_M_Item_cmd.commandText = "SELECT GL_M_CategoryItem.Cat_Name,  GL_M_Item.Item_Cat_ID, GL_M_Item.Item_AktifYN FROM GL_M_CategoryItem RIGHT OUTER JOIN GL_M_Item ON GL_M_CategoryItem.Cat_ID = GL_M_Item.Item_Cat_ID WHERE Item_AktifYN = 'Y' AND Item_Tipe = '"& Item_Tipe &"'  GROUP BY GL_M_CategoryItem.Cat_Name,  GL_M_Item.Item_Cat_ID, GL_M_Item.Item_AktifYN  "
    set CatList = GL_M_Item_cmd.execute

%>
    <span class="cont-text"> SUB Kategori </span><br>
    <select required  class=" mb-2 cont-form" name="CatListItem" id="CatListItem" aria-label="Default select example">
        <option selected>Pilih</option>
        <% do while not CatList.eof %>
        <option value="<%=CatList("Item_Cat_ID")%>"><%=CatList("Cat_Name")%></option>
        <% CatList.movenext
        loop %>
    </select><br>