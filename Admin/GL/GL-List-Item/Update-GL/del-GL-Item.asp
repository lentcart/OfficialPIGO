<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    Item_ID = request.queryString("ItemID")

    set GL_M_Item_cmd = server.createObject("ADODB.COMMAND")
	GL_M_Item_cmd.activeConnection = MM_PIGO_String
        GL_M_Item_cmd.commandText = "Select * From GL_M_Item "
    set GL_M_Item = GL_M_Item_cmd.execute

    if  Gl_M_Item("Item_AktifYN") = "Y" Then 
        GL_M_Item_cmd.commandText = "Update GL_M_Item set Item_AktifYN = 'N' Where Item_ID ='"& Item_ID &"'"
        set GL_M_Item = GL_M_Item_cmd.execute
    else
        GL_M_Item_cmd.commandText = "Update GL_M_Item set Item_AktifYN = 'Y' Where Item_ID ='"& Item_ID &"'"
        set GL_M_Item = GL_M_Item_cmd.execute
    end if
    

%>
