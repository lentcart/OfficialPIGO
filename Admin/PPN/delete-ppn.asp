<!--#include file="../../Connections/pigoConn.asp" -->
<!--#include file="../../UpdateLOG/UpdateLOG.asp"-->
<%
    TaxID = request.Form("TaxID")
    
    set PPN_CMD = server.createObject("ADODB.COMMAND")
	PPN_CMD.activeConnection = MM_PIGO_String

        PPN_CMD.commandText = "UPDATE MKT_M_Tax SET TaxAktifYN = 'N', TaxUpdateTime = '"& Now() &"', TaxUpdateID= '"& session("username") &"'  WHERE TaxID = '"& TaxID &"'  "
        'response.write PPN_CMD.commandText

    set PPN = PPN_CMD.execute

    Log_ServerID 	= "" 
    Log_Action   	= "DELLETE"
    Log_Key         = TaxID
    Log_Keterangan  = "PPN "& TaxID &" telah dinonaktifkan / dihapus pada "& DATE() &""
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

%>