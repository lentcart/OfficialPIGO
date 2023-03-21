<!--#include file="../../../connections/pigoConn.asp"-->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<% 
    prFaktur = request.form("nofaktur")
    prType = request.form("typeinvoice")
    prTanggalInv = request.form("tglinv")
    prTanggalAcc = request.form("tglacc")
    pr_mmID = request.form("mmID")
    pr_spID = request.form("supplierid")
    pr_SubTotal = request.form("SubTotal")
        
    set PaymentRequest_H_CMD = server.CreateObject("ADODB.command")
    PaymentRequest_H_CMD.activeConnection = MM_pigo_STRING
    PaymentRequest_H_CMD.commandText = "exec sp_add_MKT_T_PaymentRequest '"& prFaktur &"','"& prType &"','"& prTanggalInv &"','"& prTanggalAcc &"',1,'"& pr_mmID &"',"& pr_SubTotal &",'"& pr_spID &"' "
    'response.write PaymentRequest_H_CMD.commandText & "<BR><BR><BR>"
    set PaymentRequest_H = PaymentRequest_H_CMD.execute

    MaterialR = pr_mmID = request.form("mmID")

    pr_poID = request.form("poID")
    pr_poSubTotal = request.form("poSubTotal")
    pr_poPajak = request.form("poPajak")

    poid = split(trim(pr_poID),", ")
    popajak = split(trim(pr_poPajak),", ")
    pototal = split(trim(pr_poSubTotal),", ")

    no = 0 

    for i = 0 to Ubound(poid)

        no=no+1
		nourut=right("0000"&no,4)
        
        set PaymentRequest_D_CMD = server.CreateObject("ADODB.command")
        PaymentRequest_D_CMD.activeConnection = MM_pigo_STRING

        PaymentRequest_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_PaymentRequest_D]([prID_H],[pr_mmID],[pr_poID],[pr_poPajak],[pr_poSubTotal],[prD_Updatetime],[prD_AktifYN])VALUES('"& PaymentRequest_H("id") &"','"& pr_mmID &"','"& poid(i) &"',"& popajak(i) &","& pototal(i) &",'"& now() &"','Y') "
        'response.write PaymentRequest_D_CMD.commandText & "<BR><BR><BR>"
        set PaymentRequest_D = PaymentRequest_D_CMD.execute

        set updatepo_CMD = server.CreateObject("ADODB.command")
        updatepo_CMD.activeConnection = MM_pigo_STRING
        updatepo_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set po_prYN = 'Y' where poID_H = '"& poid(i) &"'"
        'response.write updatepo_CMD.commandText & "<BR><BR><BR>"
        set updatepo = updatepo_CMD.execute

    next

    set updatemm_CMD = server.CreateObject("ADODB.command")
    updatemm_CMD.activeConnection = MM_pigo_STRING
    updatemm_CMD.commandText = "UPDATE MKT_T_MaterialReceipt_D2 set mm_prYN = 'Y' where mmID_D2 = '"& pr_mmID &"'"
    'response.write updatemm_CMD.commandText & "<BR><BR><BR>"
    set updatemm = updatemm_CMD.execute


    Response.Write "<div class='text-center berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> Payment Request Berhasil Ditambahkan </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/Pembayaran/PaymentRequestDetail/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>Kembali</a></div></div></div>"
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>