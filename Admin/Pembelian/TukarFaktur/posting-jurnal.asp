<!--#include file="../../../Connections/pigoConn.asp" -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    TF_ID   = request.queryString("TF_ID")
    
    set TukarFaktur_CMD = server.CreateObject("ADODB.command")
    TukarFaktur_CMD.activeConnection = MM_pigo_STRING
    TukarFaktur_CMD.commandText = "SELECT MKT_T_TukarFaktur_D.TF_mmID,MKT_T_TukarFaktur_H.TF_Tanggal, MKT_T_TukarFaktur_H.TF_ID, MKT_T_TukarFaktur_D.TF_mmTotal, MKT_T_TukarFaktur_D.TF_TFTotal FROM MKT_T_TukarFaktur_D RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) = MKT_T_TukarFaktur_H.TF_ID WHERE MKT_T_TukarFaktur_H.TF_ID = '"& TF_ID &"'"
    'response.write TukarFaktur_CMD.commandText  & "<br><br>"
    set TukarFaktur = TukarFaktur_CMD.execute

    do while not TukarFaktur.eof

        'response.write TukarFaktur("TF_mmID")  & "<br><br>"
        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING
        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('', 'B100.02.00', '"& "Tukar Faktur - Material Receipt ID [ "&TukarFaktur("TF_mmID")&" ] - "& TF_ID &"', '"& TukarFaktur("TF_mmTotal") &"', 0 )"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalD1 = Jurnal_H_CMD.execute

        TF_Total        = TF_Total + TukarFaktur("TF_mmTotal")
        TF_Tanggal      = TukarFaktur("TF_Tanggal")

    TukarFaktur.movenext
    loop

    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_pigo_STRING
    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','B100.01.00','"& "Tukar Faktur (Material Receipt) - "& TF_ID &"',0,'"& TF_Total &"' )"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalD2 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& TF_Tanggal &"','"& "Tukar Faktur (MR) - "& TF_Tanggal &" - "& TF_ID &"','M','N','N','N','"& session("username") &"','TF','Y'"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set Jurnal = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan FROM GL_T_Jurnal_D WHERE RIGHT(JRD_Keterangan,16) = '"& TF_ID &"' "
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set ListJurnalD = Jurnal_H_CMD.execute
    
    no = 0
    Do While Not ListJurnalD.eof
    no = no + 1
    nourut=right("0000000"&no,7)

    Keterangan       = ListJurnalD("JRD_Keterangan")
    'response.write Keterangan & "<br><br>"
        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& Jurnal("id")&nourut &"' WHERE JRD_Keterangan = '"& Keterangan &"'"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdateJurnalD = Jurnal_H_CMD.execute

    ListJurnalD.movenext
    loop

    set TukarFaktur_H_CMD = server.CreateObject("ADODB.command")
    TukarFaktur_H_CMD.activeConnection = MM_pigo_STRING
    TukarFaktur_H_CMD.commandText = "UPDATE MKT_T_TukarFaktur_H set TF_JR_ID = '"& Jurnal("id") &"' , TF_postingYN = 'Y' WHERE TF_ID = '"& TF_ID &"'  "
    'response.write TukarFaktur_H_CMD.commandText  & "<br><br>"
    set UpdateTukarFaktur = TukarFaktur_H_CMD.execute

    TukarFaktur_H_CMD.commandText = "SELECT MKT_T_TukarFaktur_D.TF_mmID FROM MKT_T_TukarFaktur_D RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) = MKT_T_TukarFaktur_H.TF_ID WHERE TF_ID = '"& TF_ID &"'  "
    'response.write TukarFaktur_H_CMD.commandText & "<br>"
    set Faktur = TukarFaktur_H_CMD.execute

    do while not  Faktur.eof
    a = Faktur("TF_mmID")
    'response.write a & "<br>"

        set UpdateMM_CMD = server.CreateObject("ADODB.command")
        UpdateMM_CMD.activeConnection = MM_pigo_STRING
        UpdateMM_CMD.commandText = "UPDATE MKT_T_MaterialReceipt_H set mm_tfYN = 'Y' WHERE mmID = '"& Faktur("TF_mmID") &"' "
        'response.write UpdateMM_CMD.commandText & "<br>"
        set UpdateMM = UpdateMM_CMD.execute

    Faktur.movenext
    loop

    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> BERHASIL POSTING JURNAL </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/Pembelian/TukarFaktur/List-TukarFaktur.asp style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>KEMBALI</a></div></div></div>"
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>