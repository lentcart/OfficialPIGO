<!--#include file="../../../connections/pigoConn.asp"-->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">

<%
    trID = request.form("nopesanan")
    tr_custID = request.form("custid")
    tr_slID = request.form("sellerid")
    psKonfirmasi = request.form("konfirmasips")
    psCatatan = request.form("catatan")
    psStatusTransaksi = request.form("statustransaksi")

    set pesanan_H_CMD = server.CreateObject("ADODB.command")
    pesanan_H_CMD.activeConnection = MM_pigo_STRING

    pesanan_H_CMD.commandText = "exec sp_add_MKT_T_Pesanan_H '"& trID &"','"& tr_custID &"','"& tr_slID &"'"
    'response.write pesanan_H_CMD.commandText &"<br><br>"
    set pesanan_H = pesanan_H_CMD.execute

    set pesanan_D_CMD = server.CreateObject("ADODB.command")
    pesanan_D_CMD.activeConnection = MM_pigo_STRING

    pesanan_D_CMD.commandText = "exec sp_add_MKT_T_Pesanan_D '"& pesanan_H("id") &"','00000','"& psKonfirmasi &"','"& psCatatan &"','"& psStatusTransaksi &"'"
    'response.write pesanan_D_CMD.commandText &"<br><br>"
    set pesanan_D = pesanan_D_CMD.execute

    set updatestatustr_CMD = server.CreateObject("ADODB.command")
    updatestatustr_CMD.activeConnection = MM_pigo_STRING

    updatestatustr_CMD.commandText = "Update MKT_T_Transaksi_D1 set tr_strID = '"&  psStatusTransaksi &"'  where left(trD1,12) ='"& trID &"' and tr_slID = '"& tr_slID &"'  "
    'response.write updatestatustr_CMD.commandText &"<br><br>"
    set update = updatestatustr_CMD.execute

    set notifikasi_CMD = server.CreateObject("ADODB.command")
    notifikasi_CMD.activeConnection = MM_pigo_STRING

    notifikasi_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Notifikasi]([notif_ID],[notif_To],[notif_From],[notif_ReadYN],[notif_UpdateTime],[notif_AktifYN])VALUES('"& pesanan_H("id") &"','"& tr_custID &"','"& request.Cookies("custID") &"','N','"& now() &"','Y')"
    'response.write notifikasi_CMD.commandText &"<br><br>"
    set notifikasi = notifikasi_CMD.execute


    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> Pesanan Berhasil Di Proses </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Seller/Pesanan/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>kembali</a></div></div></div>"
    
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>

