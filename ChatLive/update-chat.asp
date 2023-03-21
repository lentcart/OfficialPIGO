<!--#include file="../connections/pigoConn.asp"-->

<%
   
    penerima = request.queryString("penerima")
    'response.write penerimapesan & "<br>"

    set updatechat_cmd =  server.createObject("ADODB.COMMAND")
    updatechat_cmd.activeConnection = MM_PIGO_String

    updatechat_cmd.commandText = "Update MKT_T_ChatLive set chatReadYN = 'Y' where chat_Penerima = '"& penerimapesan &"' and chat_Pengirim = '"& request.Cookies("custID") &"' "
    'response.write updatechat_cmd.commandText & "<br>"
    set updatechat = updatechat_cmd.execute
%>