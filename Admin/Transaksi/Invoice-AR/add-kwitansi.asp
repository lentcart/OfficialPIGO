<!--#include file="../../../connections/pigoConn.asp"-->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">

<% 
    InvARID = request.queryString("InvARID")
    InvARTanggala = request.queryString("InvARTanggala")
    InvARTanggala = request.queryString("InvARTanggala")

    if InvARTanggala = "" and InvARTanggala =  "" then 

        set FakturPenjualan_CMD = server.createObject("ADODB.COMMAND")
        FakturPenjualan_CMD.activeConnection = MM_PIGO_String
        FakturPenjualan_CMD.commandText = "Select MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal, MKT_T_PengeluaranSC_H.psc_custID, MKT_T_Faktur_Penjualan.InvARTotalLine,  MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax FROM MKT_T_PengeluaranSC_D RIGHT OUTER JOIN MKT_T_SuratJalan_H LEFT OUTER JOIN MKT_T_SuratJalan_D ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH,18) LEFT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_SuratJalan_H.SJID = MKT_T_Faktur_Penjualan.InvAR_SJID ON MKT_T_PengeluaranSC_D.pscIDH = MKT_T_PengeluaranSC_H.pscID WHERE MKT_T_Faktur_Penjualan.InvARID = '"& InvARID &"' "
        'Response.Write FakturPenjualan_CMD.commandText & "<br>"
        set FakturPenjualan = FakturPenjualan_CMD.execute

        Qty         = FakturPenjualan("SJID_pdQty")
        Harga       = FakturPenjualan("SJIDD_pdHargaJual")
        PPN         = FakturPenjualan("SJID_pdTax")
        UpTo        = FakturPenjualan("SJID_pdUpto")

        Total       = Qty*Harga
        ReturnPPN   = Total+(Total*PPN/100)
        ReturnUP    = (ReturnPPN*UpTo/100)
        SubTotal    = ReturnPPN+ReturnUP

        set Kwitansi_CMD = server.CreateObject("ADODB.command")
        Kwitansi_CMD.activeConnection = MM_pigo_STRING
        Kwitansi_CMD.commandText = "exec sp_add_MKT_T_Kwitansi '"& date() &"','"& FakturPenjualan("psc_custID") &"'"
        'response.write Kwitansi_CMD.commandText  & "<br><br><br>"
        set KwitansiH = Kwitansi_CMD.execute

        Kwitansi_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Kwitansi_D]([KWID_H],[KW_InvARID],[KW_InvARTanggal],[KW_InvARTotalLine],[KWUpdateTime],[KWAktifYN])VALUES('"& KwitansiH("id") &"','"& InvARID &"','"& FakturPenjualan("InvARTanggal") &"','"& SubTotal  &"','"& now() &"','Y')"
        'response.write Kwitansi_CMD.commandText
        set KwitansiD = Kwitansi_CMD.execute

        FakturPenjualan_CMD.activeConnection = MM_PIGO_String
        FakturPenjualan_CMD.commandText = "UPDATE MKT_T_Faktur_Penjualan  SET InvAR_KWYN = 'Y' Where InvARID = '"& InvARID &"' "
        'Response.Write FakturPenjualan_CMD.commandText & "<br>"
        set UpdateFakturPenjualan = FakturPenjualan_CMD.execute

    else

        InvAP_custID = request.queryString("InvAP_custID")

        set FakturPenjualan_CMD = server.createObject("ADODB.COMMAND")
        FakturPenjualan_CMD.activeConnection = MM_PIGO_String
        FakturPenjualan_CMD.commandText = "Select MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal, MKT_T_PengeluaranSC_H.psc_custID, MKT_T_Faktur_Penjualan.InvARTotalLine,  MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax FROM MKT_T_PengeluaranSC_D RIGHT OUTER JOIN MKT_T_SuratJalan_H LEFT OUTER JOIN MKT_T_SuratJalan_D ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH,18) LEFT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_SuratJalan_H.SJID = MKT_T_Faktur_Penjualan.InvAR_SJID ON MKT_T_PengeluaranSC_D.pscIDH = MKT_T_PengeluaranSC_H.pscID WHERE InvARTanggal Between '"& InvARTanggala &"' and '"& InvARTanggale &"' and InvAR_custID = '"& InvAP_custID &"'  "
        'Response.Write FakturPenjualan_CMD.commandText & "<br>"
        set FakturPenjualan = FakturPenjualan_CMD.execute


        set Kwitansi_CMD = server.CreateObject("ADODB.command")
        Kwitansi_CMD.activeConnection = MM_pigo_STRING
        Kwitansi_CMD.commandText = "exec sp_add_MKT_T_Kwitansi '"& date() &"','"& FakturPenjualan("InvAR_custID") &"'"
        'response.write Kwitansi_CMD.commandText  & "<br><br><br>"
        set KwitansiH = Kwitansi_CMD.execute

        do while not FakturPenjualan.eof

            Qty         = FakturPenjualan("SJID_pdQty")
            Harga       = FakturPenjualan("SJIDD_pdHargaJual")
            PPN         = FakturPenjualan("SJID_pdTax")
            UpTo        = FakturPenjualan("SJID_pdUpto")

            Total       = Qty*Harga
            ReturnPPN   = Total+(Total*PPN/100)
            ReturnUP    = (ReturnPPN*UpTo/100)
            SubTotal    = ReturnPPN+ReturnUP

            Kwitansi_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Kwitansi_D]([KWID_H],[KW_InvARID],[KW_InvARTanggal],[KW_InvARTotalLine],[KWUpdateTime],[KWAktifYN])VALUES('"& KwitansiH("id") &"','"& FakturPenjualan("InvARID") &"','"& FakturPenjualan("InvARTanggal") &"','"& SubTotal  &"','"& now() &"','Y')"
            'response.write Kwitansi_CMD.commandText
            set KwitansiD = Kwitansi_CMD.execute

            FakturPenjualan_CMD.activeConnection = MM_PIGO_String
            FakturPenjualan_CMD.commandText = "UPDATE MKT_T_Faktur_Penjualan  SET InvAR_KWYN = 'Y' Where InvARID = '"& FakturPenjualan("InvARID") &"' "
            'Response.Write FakturPenjualan_CMD.commandText & "<br>"
            set UpdateFakturPenjualan = FakturPenjualan_CMD.execute

        FakturPenjualan.movenext
        loop

    end if

    'response.redirect "index.asp"
    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> KWITANSI BERHASIL DI BUAT </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/Transaksi/Invoice-AR/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>kembali</a></div></div></div>"
%>

<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>