<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    Item_Tipe   = request.queryString("CATName")
    Item_Cat_ID = request.queryString("CatListItem")
    Item_Status = request.queryString("StatusListItem")
    Item_Name   = request.queryString("NameItem")

    set GL_M_Item_cmd = server.createObject("ADODB.COMMAND")
	GL_M_Item_cmd.activeConnection = MM_PIGO_String
        GL_M_Item_cmd.commandText = "SELECT GL_M_CategoryItem.Cat_Name, GL_M_Item.Item_ID, GL_M_Item.Item_Cat_ID, GL_M_Item.Item_Tipe, GL_M_Item.Item_Name, GL_M_Item.Item_Status, GL_M_Item.Item_CAIDD, GL_M_Item.Item_CAIDK,  GL_M_Item.Item_UpdateID, CAST(GL_M_Item.Item_UpdateTime AS DATE) AS Tanggal, GL_M_Item.Item_AktifYN FROM GL_M_CategoryItem RIGHT OUTER JOIN GL_M_Item ON GL_M_CategoryItem.Cat_ID = GL_M_Item.Item_Cat_ID WHERE Item_Tipe  = '"& Item_Tipe &"' AND Item_Cat_ID = '"& Item_Cat_ID &"' AND Item_Status = '"& Item_Status &"' OR Item_Name Like '%"& Item_Name &"%' "
        'response.write GL_M_Item_cmd.commandText
    set ItemList = GL_M_Item_cmd.execute

%>
<% if ItemList.eof = true then %>
<tr>
    <th colspan="10" class="text-center"> Data Tidak Ditemukan </th>
</tr>
<% else %>
<% do while not ItemList.eof %>
    <tr>
        <td class="text-center"><%=ItemList("Item_ID")%></td>
        <td class="text-center"><%=ItemList("Cat_Name")%></td>
        <td><%=ItemList("Item_Name")%></td>
        <td class="text-center"><%=ItemList("Item_Tipe")%></td>
        <td class="text-center"><%=ItemList("Item_Status")%></td>
        <td class="text-center"><%=ItemList("Item_CAIDD")%></td>
        <td class="text-center"><%=ItemList("Item_CAIDK")%></td>
        <td class="text-center"><%=ItemList("Item_UpdateID")%></td>
        <td class="text-center"><%=ItemList("Tanggal")%></td>
        <% if ItemList("Item_AktifYN") = "Y" then %>
        <td class="text-center"> Aktif </td>
        <% else %>
        <td class="text-center"> Tidak Aktif </td>
        <% end if %>
    </tr>
<% ItemList.movenext
loop %>
<% end if %>