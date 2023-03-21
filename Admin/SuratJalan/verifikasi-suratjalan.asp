<!--#include file="../../connections/pigoConn.asp"-->

<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">

<% 
    SJID = request.queryString("SJID")
        
    set SuratJalan_CMD = server.CreateObject("ADODB.command")
    SuratJalan_CMD.activeConnection = MM_pigo_STRING

    SuratJalan_CMD.commandText = "SELECT MKT_T_SuratJalan_D.SJID_pdID, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax, MKT_T_SuratJalan_H.SJID,MKT_T_SuratJalan_H.SJ_Tanggal,  MKT_T_PengeluaranSC_H.pscDesc, MKT_M_PIGO_Produk.pdHarga, MKT_M_Customer.custNama FROM MKT_T_PengeluaranSC_H RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_M_Customer.custID = MKT_T_SuratJalan_H.SJ_custID ON MKT_T_PengeluaranSC_H.pscID = MKT_T_SuratJalan_H.SJ_pscID LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_SuratJalan_D ON MKT_M_PIGO_Produk.pdID = MKT_T_SuratJalan_D.SJID_pdID ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH, 18) WHERE MKT_T_SuratJalan_H.SJID = '"& SJID &"' "
    'response.write SuratJalan_CMD.commandText & "<br><br>"
    set SuratJalan = SuratJalan_CMD.execute

    do while not SuratJalan.eof

        'response.write SuratJalan("SJID_pdID") & "<br><br>"
        HargaJual   = SuratJalan("pdHarga")
        Upto        = SuratJalan("SJID_pdUpto")
        PPN         = SuratJalan("SJID_pdTax")

        resultup    = HargaJual+(HargaJual*Upto/100)
        resultppn   = resultup*PPN/100
        result      = resultup+resultppn
        total       = round(result)

        keterangan  = SuratJalan("pscDesc") 
        totalharga  = totalharga + HargaJual 
        custNama    = SuratJalan("custNama")
        
        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING
        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','E100.01.00','"& SJID &" - Tukar Faktur SJ - ProdukID "& SuratJalan("SJID_pdID") &"','"& SuratJalan("pdHarga") &"',0 )"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalDA1 = Jurnal_H_CMD.execute

        SJ_Tanggal  = SuratJalan("SJ_Tanggal")

    SuratJalan.movenext
    loop

    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A106.04.00','"& SJID &" - Tukar Faktur (SJ - "& custNama &")""',0,'"& totalharga &"')"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalDA2 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& SJ_Tanggal &"','Tukar Faktur (SJ) "& SJ_Tanggal &" "& SJID &"','M','N','N','N','"& session("username") &"','SJ','Y'"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set Jurnal1 = Jurnal_H_CMD.execute
    'response.write Jurnal("id")

    Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan FROM GL_T_Jurnal_D WHERE LEFT(JRD_Keterangan,18) = '"& SJID &"' and JRD_ID = ''  "
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set ListJurnalD1 = Jurnal_H_CMD.execute
    
    no = 0
    Do While Not ListJurnalD1.eof
    no = no + 1
    nourut=right("0000000"&no,7)

    Keterangan       = LEFT(ListJurnalD1("JRD_Keterangan"),18)

        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& Jurnal1("id")&nourut &"' WHERE LEFT(JRD_Keterangan,18) = '"& Keterangan &"' and JRD_ID = ''   "
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdateJurnalD1 = Jurnal_H_CMD.execute

    ListJurnalD1.movenext
    loop

    set Profit_CMD = server.CreateObject("ADODB.command")
    Profit_CMD.activeConnection = MM_pigo_STRING
    Profit_CMD.commandText = "SELECT * FROM MKT_M_Profit WHERE PRAktifYN = 'Y' "
    'response.write Profit_CMD.commandText  & "<br><br>"
    set Profit = Profit_CMD.execute


    TotalProfit = Profit("PRRate")
    'response.write TotalProfit & "<br><br>"

    SuratJalan_CMD.commandText = "SELECT MKT_T_SuratJalan_D.SJID_pdID, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax, MKT_T_SuratJalan_H.SJID,  MKT_T_PengeluaranSC_H.pscDesc, MKT_M_PIGO_Produk.pdHarga, MKT_M_Customer.custNama FROM MKT_T_PengeluaranSC_H RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_M_Customer.custID = MKT_T_SuratJalan_H.SJ_custID ON MKT_T_PengeluaranSC_H.pscID = MKT_T_SuratJalan_H.SJ_pscID LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_SuratJalan_D ON MKT_M_PIGO_Produk.pdID = MKT_T_SuratJalan_D.SJID_pdID ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH, 18) WHERE MKT_T_SuratJalan_H.SJID = '"& SJID &"' "
    'response.write SuratJalan_CMD.commandText & "<br><br>"
    set Produk = SuratJalan_CMD.execute


    do while not Produk.eof

        Profit       = Produk("SJID_pdUpto")                      ' 25%
        HargaPokok   = Produk("pdHarga")                    ' 50.000
        ProfitProduk = HargaPokok*Profit/100                ' 12.500
        HargaJual    = Round(HargaPokok+ProfitProduk)              ' 62.500

        PPNKeluaran  = Round(HargaJual*Produk("SJID_pdTax")/100)  ' 6.875
        SubTotal     = Round(HargaJual+PPNKeluaran)              ' 69.375
        custNama     = Produk("custNama")

        ' response.write Profit  & " Profit<br><br>"
        ' response.write HargaPokok  & " HargaPokok<br><br>"
        ' response.write ProfitProduk  & " ProfitProduk<br><br>"
        ' response.write HargaJual  & " HargaJual<br><br>"
        ' response.write PPNKeluaran  & " PPNKeluaran<br><br>"
        ' response.write Subtotal  & " Subtotal<br><br>"

        ' HargaJual    = Produk("SJIDD_pdHargaJual")
        ' ProfitProduk = Produk("SJIDD_pdHargaJual")*TotalProfit/100
        ' Total        = ProfitProduk+HargaJual

        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','D100.02.00','"& SJID &" Terima (SJ) - ProdukID "& Produk("SJID_pdID") &"',0,'"& HargaJual &"')"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalD1 = Jurnal_H_CMD.execute
        
        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','B104.02.00','"& SJID &" Terima (SJ) - ProdukID "& Produk("SJID_pdID") &"',0,'"& PPNKeluaran &"')"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalD2 = Jurnal_H_CMD.execute

        GrandTotal = GrandTotal + SubTotal

    Produk.movenext
    loop

    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A102.01.00','"& SJID &" Terima (SJ) - "& custNama &"','"& GrandTotal &"',0)"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalD3 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& SJ_Tanggal &"','Terima (SJ) "& SJ_Tanggal &" "& SJID &"','M','N','N','N','"& session("username") &"','SJ','Y'"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set Jurnal = Jurnal_H_CMD.execute
    'response.write Jurnal("id")

    Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan FROM GL_T_Jurnal_D WHERE LEFT(JRD_Keterangan,18) = '"& SJID &"' and JRD_ID = ''  "
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set ListJurnalD = Jurnal_H_CMD.execute
    
    no = 0
    Do While Not ListJurnalD.eof
    no = no + 1
    nourut=right("0000000"&no,7)

    Keterangan       = LEFT(ListJurnalD("JRD_Keterangan"),18)

        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& Jurnal("id")&nourut &"' WHERE LEFT(JRD_Keterangan,18) = '"& Keterangan &"' and JRD_ID = ''   "
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdateJurnalD = Jurnal_H_CMD.execute

    ListJurnalD.movenext
    loop

    SuratJalan_CMD.commandText = "UPDATE MKT_T_SuratJalan_H set SJ_TerimaYN = 'Y' WHERE MKT_T_SuratJalan_H.SJID = '"& SJID &"' "
    'response.write SuratJalan_CMD.commandText & "<br><br>"
    set UpdateSuratJalan = SuratJalan_CMD.execute

    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> SURAT JALAN BERHASIL DI VERIFIKASI </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/SuratJalan/Index.asp style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>KEMBALI</a></div></div></div>"
' %>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>