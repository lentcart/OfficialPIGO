<!--#include file="../../../../Connections/pigoConn.asp" -->

<% 
    FMD_ID              = request.queryString("FMD_ID")
    FMD_CA_ID           = request.queryString("FMD_CA_ID")
    FMD_Value           = request.queryString("FMD_Value")

    set KalkulasiFiskal_CMD = server.CreateObject("ADODB.command")
    KalkulasiFiskal_CMD.activeConnection = MM_pigo_STRING
    KalkulasiFiskal_CMD.commandText = "UPDATE GL_M_Fiskal_D SET FMD_Value = '"& FMD_Value &"' WHERE FMD_ID = '"& FMD_ID &"' AND FMD_CA_ID = '"& FMD_CA_ID &"' "
    'response.write KalkulasiFiskal_CMD.commandText
    set ValueFiskal = KalkulasiFiskal_CMD.execute
%>