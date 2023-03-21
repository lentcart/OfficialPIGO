<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    Item_ID = request.queryString("Item_ID")
    updCatItemID = request.queryString("updCatItemID")
    Item_Tipe = request.queryString("Item_Tipe")
    Item_Cat_ID = request.queryString("Item_Cat_ID")
    Item_Name = request.queryString("Item_Name")
    Item_Status = request.queryString("Item_Status")
    Item_CAIDD = request.queryString("Item_CAIDD")
    Item_CAIDK = request.queryString("Item_CAIDK")

    set GL_M_Item_cmd = server.createObject("ADODB.COMMAND")
	GL_M_Item_cmd.activeConnection = MM_PIGO_String
        GL_M_Item_cmd.commandText = "UPDATE [dbo].[GL_M_Item] SET [Item_Tipe] = '"& Item_Tipe &"',[Item_CatTipe] = '"& updCatItemID &"',[Item_Cat_ID] = '"& Item_Cat_ID &"',[Item_Name] = '"& Item_Name &"',[Item_Status] = '"& Item_Status &"',[Item_CAIDD] = '"& Item_CAIDD &"',[Item_CAIDK] = '"& Item_CAIDK &"',[Item_UpdateID] = '"& session("username") &"',[Item_UpdateTime] = '"& now() &"',[Item_AktifYN] = 'Y' Where Item_ID = '"& Item_ID &"' "
        response.Write GL_M_Item_cmd.commandText
        set UpdGLItem = GL_M_Item_cmd.execute
%>