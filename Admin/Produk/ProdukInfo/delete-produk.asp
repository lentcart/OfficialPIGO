<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->
<%
    pdID = request.Form("pdID")
    
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "UPDATE MKT_M_PIGO_Produk set pdAktifYN = 'N'  WHERE MKT_M_PIGO_Produk.pdID = '"& pdID &"'  "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    Ket =  "Produk ID : ("& pdID &") Dihapus / dinonaktifkan pada "& Date() &""
    ' response.write Ket & "<br><br>"

        Log_ServerID 	= "" 
        Log_Action   	= "DELLETE"
        Log_Key         = pdID
        Log_Keterangan  = Ket
        URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

%>