<!--#include file="../../../Connections/pigoConn.asp" -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    mmID   = request.queryString("mmID")

    set MaterialReceipt_CMD = server.CreateObject("ADODB.command")
    MaterialReceipt_CMD.activeConnection = MM_pigo_STRING

    MaterialReceipt_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID,MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_D2.mm_pdID,MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdSubtotal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_H.mmID = '"& mmID &"'"
    'response.write MaterialReceipt_CMD.commandText & "<br><br>"
    set MaterialReceipt = MaterialReceipt_CMD.execute

    do while not MaterialReceipt.eof
        'response.write MaterialReceipt("mm_pdID")& "<br><br>"

        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING
        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('', 'A106.01.00', '"& "Persediaan Suku Cadang - ProdukID ["&MaterialReceipt("mm_pdID")&"] - "& mmID &"', '"& MaterialReceipt("mm_pdSubtotal") &"', 0 )"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalD1 = Jurnal_H_CMD.execute

        total           = total + MaterialReceipt("mm_pdSubtotal")
        Tanggal         = MaterialReceipt("mmTanggal")

    MaterialReceipt.movenext
    loop

    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('', 'B100.02.00', '"& "Persediaan Suku Cadang - Material Receipt ID - "& mmID &"',0, '"& total &"' )"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalD2 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& Tanggal &"','"& " Persediaan Suku Cadang - "& Tanggal &" - Material Receipt ID - "& mmID &"','M','N','N','N','"& session("username") &"','MM','Y'"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set Jurnal = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan FROM GL_T_Jurnal_D WHERE RIGHT(JRD_Keterangan,16) = '"& mmID &"' "
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set ListJurnalD = Jurnal_H_CMD.execute
    
    no = 0
    Do While Not ListJurnalD.eof
    no = no + 1
    nourut=right("0000000"&no,7)

    Keterangan       = ListJurnalD("JRD_Keterangan")
    'response.write Keterangan & "<br><br>"
        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& Jurnal("id")&nourut &"' WHERE JRD_Keterangan = '"& Keterangan &"' and JRD_ID = '' "
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdateJurnalD = Jurnal_H_CMD.execute

        Jurnal_H_CMD.commandText = "UPDATE MKT_T_MaterialReceipt_H set mm_postingYN = 'Y', mm_JR_ID = '"& Jurnal("id") &"' WHERE mmID = '"& RIGHT(Keterangan,16) &"'   "
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdateMM = Jurnal_H_CMD.execute
    ListJurnalD.movenext
    loop

    Jurnal_H_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_D1.mm_poID FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 WHERE MKT_T_MaterialReceipt_H.mmID = '"& mmID &"' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_D1.mm_poID"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set PO = Jurnal_H_CMD.execute

    do while not PO.eof

        Jurnal_H_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_H SET po_postingYN = 'Y', po_JR_ID = '"& Jurnal("id") &"' WHERE poID = '"& PO("mm_poID") &"'  "
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdatePO = Jurnal_H_CMD.execute

    PO.movenext
    loop
    

    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> BERHASIL POSTING JURNAL </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/Pembelian/MaterialReceiptDetail/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>KEMBALI</a></div></div></div>"
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>