<!--#include file="../../../connections/pigoConn.asp"-->

<% 
  

    slID = request.queryString("slID")
    custID = request.queryString("custID")
    
    
    set Member_CMD = server.CreateObject("ADODB.command")
    Member_CMD.activeConnection = MM_pigo_STRING

    Member_CMD.commandText = "exec sp_add_MKT_T_Member '"&  slID  &"','"&  custID  &"', 0 "
    response.write Member_CMD.commandText
    'set pr = Member_CMD.execute

    'Response.redirect "index.asp"
%> 