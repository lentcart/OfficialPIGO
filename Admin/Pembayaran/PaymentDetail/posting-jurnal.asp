<!--#include file="../../../Connections/pigoConn.asp" -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    payID   = request.queryString("payID")

    set Payment_CMD = server.CreateObject("ADODB.command")
    Payment_CMD.activeConnection = MM_pigo_STRING

    Payment_CMD.commandText = "SELECT MKT_T_Payment_H.payID, MKT_T_Payment_D.pay_prID, MKT_T_Payment_D.pay_subtotal FROM MKT_T_Payment_D RIGHT OUTER JOIN MKT_T_Payment_H ON LEFT(MKT_T_Payment_D.payID_H,18) = MKT_T_Payment_H.payID WHERE MKT_T_Payment_H.payID = '"& payID &"'"
    'response.write Payment_CMD.commandText & "<br><br>"
    set Payment = Payment_CMD.execute

    do while not Payment.eof

        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING
        Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('', 'A106.01.00', '"& PayID&"/"&Payment("pay_prID") &"', '"& Payment("pay_subtotal") &"', 0 )"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set JurnalD1 = Jurnal_H_CMD.execute

        payGrandTotal = payGrandTotal + Payment("pay_subtotal")

    Payment.movenext
    loop

    Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A100.02.01','"& payID &"',0,'"& payGrandTotal &"' )"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set JurnalD2 = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& CDate(now()) &"','"& "Bank Payment OUT : "& payID &"','K','N','N','N','"& session("username") &"','PY','Y'"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set Jurnal = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan FROM GL_T_Jurnal_D WHERE LEFT(JRD_Keterangan,18) = '"& payID &"' "
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set ListJurnalD = Jurnal_H_CMD.execute
    
    no = 0
    Do While Not ListJurnalD.eof
    no = no + 1
    nourut=right("0000000"&no,7)

    Keterangan       = ListJurnalD("JRD_Keterangan")

        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& Jurnal("id")&nourut &"' WHERE JRD_Keterangan = '"& Keterangan &"'"
        'response.write Jurnal_H_CMD.commandText  & "<br><br>"
        set UpdateJurnalD = Jurnal_H_CMD.execute


    ListJurnalD.movenext
    loop

    set Payment_H_CMD = server.CreateObject("ADODB.command")
    Payment_H_CMD.activeConnection = MM_pigo_STRING
    Payment_H_CMD.commandText = "UPDATE MKT_T_Payment_H set pay_JR_ID = '"& Jurnal("id") &"' , paypostingYN = 'Y' WHERE payID = '"& payID &"'  "
    'response.write Payment_H_CMD.commandText  & "<br><br>"
    set UpdatePayment = Payment_H_CMD.execute

    Payment_H_CMD.commandText = "SELECT MKT_T_Payment_D.pay_prID FROM MKT_T_Payment_D RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID WHERE MKT_T_Payment_H.payID = '"& payID &"'  "
    'response.write Payment_H_CMD.commandText & "<br>"
    set InvoiceVendor = Payment_H_CMD.execute

    do while not  InvoiceVendor.eof
    a = InvoiceVendor("pay_prID")
    'response.write a & "<br>"

        set UpdateMM_CMD = server.CreateObject("ADODB.command")
        UpdateMM_CMD.activeConnection = MM_pigo_STRING
        UpdateMM_CMD.commandText = "UPDATE MKT_T_InvoiceVendor_H set InvAP_prYN = 'Y' WHERE InvAPID = '"& InvoiceVendor("pay_prID") &"' "
        'response.write UpdateMM_CMD.commandText & "<br>"
        set UpdateInvoiceVendor = UpdateMM_CMD.execute

    InvoiceVendor.movenext
    loop

    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> BERHASIL POSTING JURNAL </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/Pembayaran/PaymentDetail/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>KEMBALI</a></div></div></div>"
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>