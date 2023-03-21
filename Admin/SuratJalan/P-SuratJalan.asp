<!--#include file="../../connections/pigoConn.asp"-->

<% 
    sTanggal            = request.form("sTanggal")
    s_pscID             = request.form("s_pscID")
    s_spID              = request.form("s_spID")
        
    set SuratJalan_CMD = server.CreateObject("ADODB.command")
    SuratJalan_CMD.activeConnection = MM_pigo_STRING

    SuratJalan_CMD.commandText = "exec sp_add_MKT_T_SuratJalan_H '"& sTanggal &"','"& s_pscID &"','"& s_spID &"','N','N','','N',''"
    'response.write SuratJalan_CMD.commandText
    set SuratJalan = SuratJalan_CMD.execute

    SuratJalan_CMD.commandText = "SELECT MKT_T_PengeluaranSC_D.pscD_pdQty,MKT_T_PengeluaranSC_H.pscDesc, MKT_T_PengeluaranSC_D.pscD_pdHargaJual, MKT_T_PengeluaranSC_D.pscD_pdUpTo, MKT_T_PengeluaranSC_D.pscD_pdTaxID, MKT_T_PengeluaranSC_D.pscD_pdID FROM MKT_T_PengeluaranSC_D RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON LEFT(MKT_T_PengeluaranSC_D.pscIDH,17) = MKT_T_PengeluaranSC_H.pscID WHERE MKT_T_PengeluaranSC_H.pscID = '"& s_pscID &"' "
    'response.write SuratJalan_CMD.commandText & "<br><br>"
    set Pengeluaran = SuratJalan_CMD.execute

    no      = 0
    do while not Pengeluaran.eof
    no      = no+1
    nourut  = right("0000"&no,4)

        'response.write Pengeluaran("pscD_pdID") & "<br><br>"
        HargaJual   = Pengeluaran("pscD_pdHargaJual")
        Upto        = Pengeluaran("pscD_pdUpTo")
        PPN         = Pengeluaran("pscD_pdTaxID")

        resultup    = HargaJual+(HargaJual*Upto/100)
        resultppn   = resultup*PPN/100
        result      = resultup+resultppn
        total       = round(result)

        SuratJalan_CMD.commandText = "INSERT INTO [dbo].[MKT_T_SuratJalan_D]([SJIDH],[SJID_pdID],[SJIDD_pdHargaJual],[SJID_pdQty],[SJID_pdUpto],[SJID_pdTax])VALUES('"& SuratJalan("id")&nourut &"','"& Pengeluaran("pscD_pdID") &"',"& Pengeluaran("pscD_pdHargaJual") &","& Pengeluaran("pscD_pdQty") &","& Pengeluaran("pscD_pdUpTo") &","& Pengeluaran("pscD_pdTaxID") &") "
        'response.write SuratJalan_CMD.commandText & "<br><br>"
        set SuratJalanD = SuratJalan_CMD.execute

    Pengeluaran.movenext
    loop

    SJID   = SuratJalan("id")

    set SuratJalan_CMD = server.CreateObject("ADODB.command")
    SuratJalan_CMD.activeConnection = MM_pigo_STRING

    SuratJalan_CMD.commandText = "SELECT MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_D.SJID_pdID, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax,  MKT_T_PengeluaranSC_H.pscDesc, MKT_M_Customer.custNama FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_M_Customer.custID = MKT_T_SuratJalan_H.SJ_custID LEFT OUTER JOIN MKT_T_PengeluaranSC_H LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = LEFT(MKT_T_PengeluaranSC_D.pscIDH, 17) ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_SuratJalan_D ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH, 18) WHERE MKT_T_SuratJalan_H.SJID = '"& SJID &"' GROUP BY MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_D.SJID_pdID, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax, MKT_T_PengeluaranSC_H.pscDesc, MKT_M_Customer.custNama "
    'response.write SuratJalan_CMD.commandText & "<br><br>"
    set SuratJalan = SuratJalan_CMD.execute

    do while not SuratJalan.eof

        'response.write SuratJalan("SJID_pdID") & " Produk <br><br>"
        Custnama    = SuratJalan("custNama")
        HargaJual   = SuratJalan("SJIDD_pdHargaJual")
        Upto        = SuratJalan("SJID_pdUpto")
        PPN         = SuratJalan("SJID_pdTax")

        resultup    = HargaJual+(HargaJual*Upto/100)
        resultppn   = resultup*PPN/100
        result      = resultup+resultppn
        total       = round(result)

        keterangan      = SuratJalan("pscDesc") 
        subtotal        = subtotal + SuratJalan("SJIDD_pdHargaJual") 

        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING
        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('', 'A106.04.00', '"& SuratJalan("SJID")&" - "& SuratJalan("custNama") &" - ProdukID ( "&SuratJalan("SJID_pdID") &")""', '"& SuratJalan("SJIDD_pdHargaJual") &"', 0 )"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalD1 = Jurnal_H_CMD.execute

    SuratJalan.movenext
    loop

    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_pigo_STRING
    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A106.01.00','"& SJID &" - Surat Jalan - "& Custnama &"',0,'"& subtotal &"' )"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalD2 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& sTanggal &"','"& "Pengeluaran Suku Cadang - "& Custnama &" - "& SJID &"','M','N','N','N','"& session("username") &"','SJ','Y'"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set Jurnal = Jurnal_H_CMD.execute
    'response.write Jurnal("id")

    Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan FROM GL_T_Jurnal_D WHERE LEFT(JRD_Keterangan,18) = '"& SJID &"' "
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set ListJurnalD = Jurnal_H_CMD.execute
    
    no = 0
    Do While Not ListJurnalD.eof
    no = no + 1
    nourut=right("0000000"&no,7)

    Keterangan       = LEFT(ListJurnalD("JRD_Keterangan"),18)

        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& Jurnal("id")&nourut &"' WHERE LEFT(JRD_Keterangan,18) = '"& Keterangan &"'"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdateJurnalD = Jurnal_H_CMD.execute


    ListJurnalD.movenext
    loop

    set SuratJalan_CMD = server.CreateObject("ADODB.command")
    SuratJalan_CMD.activeConnection = MM_pigo_STRING
    SuratJalan_CMD.commandText = "UPDATE MKT_T_SuratJalan_H set SJ_PostingYN = 'Y' , SJ_JR_ID = '"& Jurnal("id") &"' Where SJID = '"& SJID &"'   "
    'response.write SuratJalan_CMD.commandText  & "<br><br>"
    set UpdateSuratJalan = SuratJalan_CMD.execute

    set Pengeluaran_CMD = server.CreateObject("ADODB.command")
    Pengeluaran_CMD.activeConnection = MM_pigo_STRING
    Pengeluaran_CMD.commandText = "UPDATE MKT_T_PengeluaranSC_H set psc_SJYN = 'Y'  WHERE pscID = '"& s_pscID &"'"
    'response.write Pengeluaran_CMD.commandText  & "<br><br>"
    set UpdatePengeluaran = Pengeluaran_CMD.execute

    Response.redirect "../Transaksi/Pengeluaran-SCB/List-PSCB.asp"

%>