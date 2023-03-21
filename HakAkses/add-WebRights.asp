<!--#include file="../Connections/pigoConn.asp" -->
<% 
    apprights   = Request.QueryString("apprights") 
    username    = Request.QueryString("username") 
    usersection = Request.QueryString("usersection") 

    set WebRights_CMD = server.createObject("ADODB.COMMAND")
	WebRights_CMD.activeConnection = MM_PIGO_String
    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (UserName = '"& username &"') AND (UserSection = '"& usersection &"') AND AppRights = '"& apprights &"'  "
    set WebRights = WebRights_CMD.execute

    if WebRights.eof then
        WebRights_CMD.commandText  = "INSERT INTO [dbo].[WebRights]([AppRights],[UserName],[UserSection])VALUES('"& apprights &"','"& username &"','"& usersection &"')"
        set WebRights = WebRights_CMD.execute
    else
        WebRights_CMD.commandText  = "DELETE FROM WebRights WHERE (UserName = '"& username &"') AND (UserSection = '"& usersection &"') AND AppRights = '"& apprights &"' "
        set WebRights = WebRights_CMD.execute
    end if
%>