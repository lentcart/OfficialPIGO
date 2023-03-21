<!--#include file="../../../connections/pigoConn.asp"-->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    trID = request.form("trID")
    psID = request.form("nopesanan")
    tr_custID = request.form("tr_custID")
    psKonfirmasi = request.form("konfirmasips")
    psCatatan = request.form("ketpd")
    psStatusTransaksi = request.form("statustransaksi")

    set updatestatusps_CMD = server.CreateObject("ADODB.command")
    updatestatusps_CMD.activeConnection = MM_pigo_STRING

    updatestatusps_CMD.commandText = "update MKT_T_Pesanan_D set ps_Noresi = '0000', psKomfirmasi = '"& psKonfirmasi &"', psCatatan = '"& psCatatan &"' ps_strID = '"&  psStatusTransaksi &"' where left(MKT_T_Pesanan_D.psD,12) = '"& psID &"' "
    'response.write updatestatusps_CMD.commandText
    updatestatusps_CMD.execute

    set updatestatustr_CMD = server.CreateObject("ADODB.command")
    updatestatustr_CMD.activeConnection = MM_pigo_STRING

    updatestatustr_CMD.commandText = "update MKT_T_Transaksi_H set tr_strID = '"&  psStatusTransaksi &"' where tr_custID = '"& tr_custID &"' and trID = '"& trID &"' "
    'response.write updatestatustr_CMD.commandText
    updatestatustr_CMD.execute

    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> Pesanan Berhasil Di Proses </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Seller/Pesanan/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>kembali</a></div></div></div>"
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
