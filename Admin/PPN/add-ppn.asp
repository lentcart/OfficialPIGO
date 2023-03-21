<!--#include file="../../Connections/pigoConn.asp" -->
<!--#include file="../../UpdateLOG/UpdateLOG.asp"-->

<% 
    TaxTanggal      = request.Form("TaxTanggal")
    TaxUpdateName   = request.Form("TaxUpdateName")
    TaxNama         = request.Form("TaxNama")
    TaxDesc         = request.Form("TaxDesc")
    TaxTglValidasi  = request.Form("TaxTglValidasi")
    TaxKategori     = request.Form("TaxKategori")
    TaxRate         = request.Form("TaxRate")
    TaxTahun        = request.Form("TaxTahun")
    TaxUpdateID     = request.Form("TaxUpdateID")

    set Tax_CMD = server.CreateObject("ADODB.command")
    Tax_CMD.activeConnection = MM_pigo_STRING
    Tax_CMD.commandText = "exec sp_add_MKT_M_Tax '"& TaxTanggal &"','"& TaxUpdateName &"','"& TaxNama &"','"& TaxDesc &"','"& TaxTglValidasi &"','"& TaxKategori &"','"& TaxRate &"','"& TaxTahun &"','"& Session("username") &"' "
    'response.write Tax_CMD.commandText & "<br><br><br>"
    set Tax = Tax_CMD.execute

    Log_ServerID 	= "" 
    Log_Action   	= "CREATE"
    Log_Key         = Tax("id")
    Log_Keterangan  = "Tambah PPN baru dengan ID : ("& Tax("id") &") diproses pada "& DATE() &""
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    response.redirect "index.asp"

%>