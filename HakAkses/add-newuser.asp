<!--#include file="../SecureString.asp" -->
<!--#include file="../connections/pigoConn.asp"--> 
<!--#include file="../md5.asp"-->

<% 
    Surename                = request.form("surename")
    Username                = request.form("username")
    Password                = md5(request.form("password"))
    Usersection             = request.form("usersection")
    Userserveraddress       = Request.ServerVariables("remote_addr")
    Userserverbrowsing      = Request.ServerVariables("http_user_agent")

    set addUSER_CMD = server.CreateObject("ADODB.command")
    addUSER_CMD.activeConnection = MM_pigo_STRING

    addUSER_CMD.commandText = "exec sp_WebLogin '"& Surename &"','"& Username &"','"& Password &"','"& Usersection &"','"& "["& Userserveraddress & "]" & Userserverbrowsing  &"' "
    'response.write addUSER_CMD.commandText
    set USER = addUSER_CMD.execute
    Response.redirect "index.asp"
%> 