<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    pshID = request.Form("pshID") 
    
    set Penawaran_CMD = server.CreateObject("ADODB.command")
    Penawaran_CMD.activeConnection = MM_pigo_STRING

    Penawaran_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_Penawaran_H] Where PenwID =  '"& pshID &"' "
    response.write Penawaran_CMD.commandText &"<br><br>"
    set Penawaran = Penawaran_CMD.execute
    Penawaran_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_Penawaran_D] Where PenwIDH =  '"& pshID &"' "
    response.write Penawaran_CMD.commandText &"<br><br>"
    set PenawaranD = Penawaran_CMD.execute
%> 