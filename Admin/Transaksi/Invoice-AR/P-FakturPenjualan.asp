<!--#include file="../../../connections/pigoConn.asp"-->
<% 
    
    InvARTanggal    = request.form("InvARTanggal")
    InvARPayTerm    = request.form("InvARPayTerm")
    InvARDesc       = request.form("InvARDesc")
    InvARTotalLine  = request.form("InvARTotalLine")
    InvAR_SJID      = request.form("InvAR_SJID")
    InvAR_pscID     = request.form("InvAR_pscID")
    InvAR_custID    = request.form("InvAR_custID")
        
    set FakturPenjualan_CMD = server.CreateObject("ADODB.command")
    FakturPenjualan_CMD.activeConnection = MM_pigo_STRING
    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_pigo_STRING
    set Profit_CMD = server.CreateObject("ADODB.command")
    Profit_CMD.activeConnection = MM_pigo_STRING

    FakturPenjualan_CMD.commandText = "exec sp_add_MKT_T_Faktur_Penjualan '"& InvARTanggal &"','"& InvARPayTerm &"','"& InvARDesc &"','"& InvARTotalLine &"','"& InvAR_SJID &"','"& InvAR_pscID &"','"& InvAR_custID &"','N','N','N','','N',''"
    'response.write FakturPenjualan_CMD.commandText & "<br><br><br>"
    set FakturPenjualan = FakturPenjualan_CMD.execute

    set Update_CMD = server.CreateObject("ADODB.command")
    Update_CMD.activeConnection = MM_pigo_STRING

    Update_CMD.commandText = "UPDATE MKT_T_SuratJalan_H set SJ_InvARYN = 'Y', SJ_InvARID = '"& FakturPenjualan("id") &"' WHERE SJID = '"& InvAR_SJID &"'"
    set UpdateSuratJalan = Update_CMD.execute

    Update_CMD.commandText = "UPDATE MKT_T_PengeluaranSC_H set psc_InvARYN = 'Y' WHERE pscID = '"& InvAR_pscID &"' "
    set UpdatePengeluaran = Update_CMD.execute

    Response.redirect "index.asp"
    
%>
