<!--#include file="../../../connections/pigoConn.asp"-->
<%
    
    permID = request.Form("permID")

    set DeletePermintaan_CMD = server.CreateObject("ADODB.command")
    DeletePermintaan_CMD.activeConnection = MM_pigo_STRING
    DeletePermintaan_CMD.commandText = "DELETE FROM MKT_T_Permintaan_Barang_H WHERE permID = '"& permID &"' "
    'response.write DeletePermintaan_CMD.commandText &"<br><br>"
    set DeletePermintaan = DeletePermintaan_CMD.execute
    DeletePermintaan_CMD.commandText = "DELETE FROM MKT_T_Permintaan_Barang_D WHERE perm_IDH = '"& permID &"' "
    'response.write DeletePermintaan_CMD.commandText &"<br><br>"
    set DeletePermintaanD = DeletePermintaan_CMD.execute
%>