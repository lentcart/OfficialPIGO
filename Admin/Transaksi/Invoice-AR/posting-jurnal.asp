<!--#include file="../../../connections/pigoConn.asp"-->
<% 
    
    InvARID         = Request.form("InvARID")
    InvARBukti      = Request.form("InvARBukti")
    response.write InvARID & "<br><br><br>"
        
    set FakturPenjualan_CMD = server.CreateObject("ADODB.command")
    FakturPenjualan_CMD.activeConnection = MM_pigo_STRING
    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_pigo_STRING
    set Profit_CMD = server.CreateObject("ADODB.command")
    Profit_CMD.activeConnection = MM_pigo_STRING

    FakturPenjualan_CMD.commandText = "SELECT * FROM MKT_T_Faktur_Penjualan WHERE InvARID = '"& InvARID &"' "
    'response.write FakturPenjualan_CMD.commandText & "<br><br><br>"
    set Faktur = FakturPenjualan_CMD.execute

    FakturPenjualan_CMD.commandText = " UPDATE MKT_T_Faktur_Penjualan set InvAR_Bukti = '"& InvARBukti &"', InvAR_Status = 'Y' WHERE InvARID = '"& InvARID &"' "
    'response.write FakturPenjualan_CMD.commandText & "<br><br><br>"
    set FakturPenjualan = FakturPenjualan_CMD.execute

    Profit_CMD.commandText = "SELECT * FROM MKT_M_Profit WHERE PRAktifYN = 'Y' "
    'response.write Profit_CMD.commandText  & "<br><br>"
    set Profit = Profit_CMD.execute

    TotalProfit = Profit("PRRate")

    ' GENERTE JURNAL TAHAP I

    set SuratJalan_CMD = server.CreateObject("ADODB.command")
    SuratJalan_CMD.activeConnection = MM_pigo_STRING

    SuratJalan_CMD.commandText = "SELECT MKT_T_SuratJalan_D.SJID_pdID, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax, MKT_T_SuratJalan_H.SJID,  MKT_T_PengeluaranSC_H.pscDesc, MKT_M_PIGO_Produk.pdHarga FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_SuratJalan_D ON MKT_M_PIGO_Produk.pdID = MKT_T_SuratJalan_D.SJID_pdID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_T_PengeluaranSC_H.pscID = MKT_T_SuratJalan_H.SJ_pscID ON LEFT(MKT_T_SuratJalan_D.SJIDH, 18) = MKT_T_SuratJalan_H.SJID WHERE MKT_T_SuratJalan_H.SJID = '"& Faktur("InvAR_SJID") &"' "
    'response.write SuratJalan_CMD.commandText & "<br><br>"
    set SuratJalan = SuratJalan_CMD.execute

    do while not SuratJalan.eof

        Profit       = SuratJalan("SJID_pdUpto")
        HargaPokok   = SuratJalan("pdHarga")
        ProfitProduk = Round(HargaPokok*Profit/100)
        HargaJual    = Round(HargaPokok+ProfitProduk)

        PPNKeluaran  = Round(HargaJual*SuratJalan("SJID_pdTax")/100)
        SubTotal     = Round(HargaJual+PPNKeluaran)

        ' HargaJual    = SuratJalan("SJIDD_pdHargaJual")
        ' ProfitProduk = SuratJalan("SJIDD_pdHargaJual")*TotalProfit/100
        ' Total        = ProfitProduk+HargaJual

        
        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','D100.02.00','"& InvARID&"/"& SuratJalan("SJID_pdID") &"','"& HargaJual &"',0 )"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalD1 = Jurnal_H_CMD.execute

        GrandTotal = GrandTotal + SubTotal
        GrandPPN = GrandPPN + PPNKeluaran

    SuratJalan.movenext
    loop

    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','B104.02.00','"& InvARID&"/PPN" &"','"& GrandPPN &"',0 )"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalD2 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A102.01.00','"& InvARID &"',0,'"& GrandTotal &"')"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalD3 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& CDate(now()) &"','"& "Faktur Penjualan/"&InvARID  &"','M','N','N','N','"& session("username") &"','IN','Y'"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set Jurnal = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan FROM GL_T_Jurnal_D WHERE LEFT(JRD_Keterangan,22) = '"& InvARID &"' and JRD_ID = ''  "
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set ListJurnalD = Jurnal_H_CMD.execute
    
    no = 0
    Do While Not ListJurnalD.eof
    no = no + 1
    nourut=right("0000000"&no,7)

    Keterangan       = LEFT(ListJurnalD("JRD_Keterangan"),22)

        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& Jurnal("id")&nourut &"' WHERE LEFT(JRD_Keterangan,22) = '"& Keterangan &"' and JRD_ID = ''   "
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdateJurnalD = Jurnal_H_CMD.execute

    ListJurnalD.movenext
    loop

    ' GENERTE JURNAL TAHAP II

    SuratJalan_CMD.commandText = "SELECT MKT_T_SuratJalan_D.SJID_pdID, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax, MKT_T_SuratJalan_H.SJID,  MKT_T_PengeluaranSC_H.pscDesc, MKT_M_PIGO_Produk.pdHarga FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_SuratJalan_D ON MKT_M_PIGO_Produk.pdID = MKT_T_SuratJalan_D.SJID_pdID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_T_PengeluaranSC_H.pscID = MKT_T_SuratJalan_H.SJ_pscID ON LEFT(MKT_T_SuratJalan_D.SJIDH, 18) = MKT_T_SuratJalan_H.SJID WHERE MKT_T_SuratJalan_H.SJID = '"& Faktur("InvAR_SJID") &"' "
    'response.write SuratJalan_CMD.commandText & "<br><br>"
    set SuratJalan = SuratJalan_CMD.execute

    do while not SuratJalan.eof

        Profit1       = SuratJalan("SJID_pdUpto")
        HargaPokok1   = SuratJalan("pdHarga")
        ProfitProduk1 = Round(HargaPokok1*Profit1/100)
        HargaJual1    = Round(HargaPokok1+ProfitProduk1)

        PPNKeluaran1  = Round(HargaJual1*SuratJalan("SJID_pdTax")/100)
        SubTotal1     = Round(HargaJual1+PPNKeluaran1)

        ' HargaJual1    = SuratJalan("SJIDD_pdHargaJual")
        ' ProfitProduk1 = SuratJalan("SJIDD_pdHargaJual")*TotalProfit/100
        ' Total1        = ProfitProduk+HargaJual

        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','D100.01.00','"& InvARID&"/"& SuratJalan("SJID_pdID") &"',0,'"& HargaJual1 &"' )"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalDA1 = Jurnal_H_CMD.execute

        GrandTotal1 = GrandTotal1 + SubTotal1
        GrandPPN1 = GrandPPN1 + PPNKeluaran1

    SuratJalan.movenext
    loop

    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','B104.01.00','"& InvARID&"/PPN" &"',0,'"& GrandPPN1 &"' )"
    response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalDA2 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A102.02.00','"& InvARID &"','"& GrandTotal1 &"',0)"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalDA3 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& CDate(now()) &"','"& "INV-AR/"&InvARID &"','M','N','N','N','"& session("username") &"','IN','Y'"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalA = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan, JRD_ID FROM GL_T_Jurnal_D WHERE LEFT(JRD_Keterangan,22) = '"& InvARID &"' and JRD_ID = ''  "
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set ListJurnalDA = Jurnal_H_CMD.execute
    
    no = 0
    Do While Not ListJurnalDA.eof
    no = no + 1
    nourut=right("0000000"&no,7)

    Keterangan       = LEFT(ListJurnalDA("JRD_Keterangan"),22)

        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& JurnalA("id")&nourut &"' WHERE LEFT(JRD_Keterangan,22) = '"& Keterangan &"' and JRD_ID = ''   "
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdateJurnalDA = Jurnal_H_CMD.execute

    ListJurnalDA.movenext
    loop

    set Update_CMD = server.CreateObject("ADODB.command")
    Update_CMD.activeConnection = MM_pigo_STRING
    
    Update_CMD.commandText = "UPDATE MKT_T_Faktur_Penjualan set InvAR_PostingYN = 'Y', InvAR_JR_ID = '"& JurnalA("id") &"' WHERE InvARID = '"& InvARID &"' "
    set UpdateFaktur = Update_CMD.execute

    Update_CMD.commandText = "UPDATE MKT_T_SuratJalan_H set SJ_InvARYN = 'Y', SJ_InvARID = '"& InvARID &"' WHERE SJID = '"& Faktur("InvAR_SJID") &"'"
    set UpdateSuratJalan = Update_CMD.execute

    Update_CMD.commandText = "UPDATE MKT_T_PengeluaranSC_H set psc_InvARYN = 'Y' WHERE pscID = '"& InvAR_pscID &"' "
    set UpdatePengeluaran = Update_CMD.execute

%>
