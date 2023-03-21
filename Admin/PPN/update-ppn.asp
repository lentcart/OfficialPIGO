<!--#include file="../../Connections/pigoConn.asp" -->
<%
    TaxID               = request.Form("TaxID")
    TaxTanggal          = request.Form("TaxTanggal")
    TaxNama             = request.Form("TaxNama")
    TaxDesc             = request.Form("TaxDesc")
    TaxTglValidasi      = request.Form("TaxTglValidasi")
    TaxKategori         = request.Form("TaxKategori")
    TaxRate             = request.Form("TaxRate")
    TaxTahun            = request.Form("TaxTahun")
    
    set PPN_CMD = server.createObject("ADODB.COMMAND")
	PPN_CMD.activeConnection = MM_PIGO_String

    PPN_CMD.commandText = "UPDATE [dbo].[MKT_M_Tax] SET [TaxID] = [TaxTanggal] = '"& date() &"',[TaxNama] = '"& TaxNama &"',[TaxDesc] = '"& TaxDesc &"',[TaxTglValidasi] = '"& TaxTglValidasi &"',[TaxKategori] = '"& TaxKategori &"',[TaxRate] = '"& TaxRate &"',[TaxTahun] = '"& TaxTahun &"',[TaxUpdateID] = '"& session("username") &"',[TaxUpdateTime] = '"& now() &"' WHERE TaxID = '"& TaxID &"'  "  
    'response.write PPN_CMD.commandText

    set PPN = PPN_CMD.execute

%>