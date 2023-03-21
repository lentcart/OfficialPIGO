<!--#include file="../../SecureString.asp" -->
<!--#include file="../../connections/pigoConn.asp"--> 
<!--#include file="../../md5.asp"-->

<% 
    UserID                  = request.form("UserID")
    Username                = request.form("Username")
    OldPassword             = md5(request.form("OldPassword"))
    Usersection             = request.form("Usersection")

    NewPassword             = md5(request.form("NewPassword"))

    set addUSER_CMD = server.CreateObject("ADODB.command")
    addUSER_CMD.activeConnection = MM_pigo_STRING

    addUSER_CMD.commandText = "SELECT * FROM WebLogin Where ( UserID = '"& UserID &"' ) AND  ( Username = '"& Username &"' ) AND ( UserSection = '"& UserSection &"' ) "
    'response.write addUSER_CMD.commandText
    set USER = addUSER_CMD.execute

    if USER.eof then
        Response.Redirect("index.asp?error=Xvg*656VGs")
    else

        addUSER_CMD.commandText = "UPDATE WebLogin SET Password = '"& NewPassword &"' WHERE ( UserID = '"& UserID &"' ) AND  ( Username = '"& Username &"' ) AND ( UserSection = '"& UserSection &"' ) "
        set Update = addUSER_CMD.execute

        success = "x" 
        Response.Redirect("index.asp?success="& success)

    end if 
%> 