<!--#include file="../../connections/pigoConn.asp"-->
<%
    id = request.form("id")

    set updatefoto_CMD = server.CreateObject("ADODB.command")
    updatefoto_CMD.activeConnection = MM_pigo_STRING

    updatefoto_CMD.commandText = "update MKT_M_Customer set custPhoto = '"& id &"' where custID = '"& request.cookies("custID") &"' "
    'response.write updatefoto_CMD.commandText
    updatefoto_CMD.execute

%>
