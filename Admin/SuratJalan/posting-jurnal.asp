<!--#include file="../../Connections/pigoConn.asp" -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    SJID   = request.queryString("SJID")

    set SuratJalan_CMD = server.CreateObject("ADODB.command")
    SuratJalan_CMD.activeConnection = MM_pigo_STRING

    SuratJalan_CMD.commandText = "SELECT MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_D.SJID_pdID, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax, MKT_T_PengeluaranSC_H.pscDesc, MKT_M_Customer.custNama FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_M_Customer.custID = MKT_T_SuratJalan_H.SJ_custID LEFT OUTER JOIN MKT_T_PengeluaranSC_H LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = LEFT(MKT_T_PengeluaranSC_D.pscIDH, 17) ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_SuratJalan_D ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH, 18)WHERE MKT_T_SuratJalan_H.SJID = '"& SJID &"' GROUP BY MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_D.SJID_pdID, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax, MKT_T_PengeluaranSC_H.pscDesc, MKT_M_Customer.custNama "
    'response.write SuratJalan_CMD.commandText & "<br><br>"
    set SuratJalan = SuratJalan_CMD.execute

    do while not SuratJalan.eof

        'response.write SuratJalan("SJID_pdID") & " Produk <br><br>"
        HargaJual   = SuratJalan("SJIDD_pdHargaJual")
        Upto        = SuratJalan("SJID_pdUpto")
        PPN         = SuratJalan("SJID_pdTax")

        resultup    = HargaJual+(HargaJual*Upto/100)
        resultppn   = resultup*PPN/100
        result      = resultup+resultppn
        total       = round(result)
        custNama    = SuratJalan("custNama")

        keterangan      = SuratJalan("pscDesc") 
        subtotal        = subtotal + SuratJalan("SJIDD_pdHargaJual") 

        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING
        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('', 'A106.04.00', '"& SuratJalan("SJID") &" - "& SuratJalan("custNama")&" - "& SuratJalan("SJID_pdID") &" ', '"& SuratJalan("SJIDD_pdHargaJual") &"', 0 )"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalD1 = Jurnal_H_CMD.execute

    SuratJalan.movenext
    loop

    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_pigo_STRING
    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A106.01.00','"& SJID &" - "& custNama &"',0,'"& subtotal &"' )"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalD2 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& CDate(now()) &"','"& "Pengeluaran Suku Cadang - "& custNama &" - "& SJID &"','M','N','N','N','"& session("username") &"','SJ','Y'"
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

    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> BERHASIL POSTING JURNAL </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/SuratJalan/Index.asp style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>KEMBALI</a></div></div></div>"
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>