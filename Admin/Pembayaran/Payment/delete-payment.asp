<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    payID = request.Form("payID") 
    
    set Penawaran_CMD = server.CreateObject("ADODB.command")
    Penawaran_CMD.activeConnection = MM_pigo_STRING

    Penawaran_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_Payment_H] Where payID =  '"& payID &"' "
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set Penawaran = Penawaran_CMD.execute
    Penawaran_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_Payment_D] Where payID_H =  '"& payID &"' "
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set PenawaranD = Penawaran_CMD.execute
%> 