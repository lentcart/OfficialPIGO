<!--#include file="../../../../Connections/pigoConn.asp" -->

<% 
    FM_Nama         = request.Form("FM_Nama")
    FM_JenisKoreksi = request.Form("FM_JenisKoreksi")
    FM_SaldoAwalYN  = request.Form("FM_SaldoAwalYN")

    set KalkulasiFiskal_CMD = server.CreateObject("ADODB.command")
    KalkulasiFiskal_CMD.activeConnection = MM_pigo_STRING
    KalkulasiFiskal_CMD.commandText = "exec sp_add_GL_M_Fiskal '"& FM_Nama &"','"& FM_JenisKoreksi &"','"& FM_SaldoAwalYN &"'"
    'response.write KalkulasiFiskal_CMD.commandText
    set KalkulasiFiskal = KalkulasiFiskal_CMD.execute
    'response.write KalkulasiFiskal("id")
%>
<input type="hidden" name="FMID" id="FMID" value="<%=KalkulasiFiskal("id")%>">