<!--#include file="../../../connections/pigoConn.asp"-->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    trID = request.form("trID")
    psID = request.form("psID")
    tr_custID = request.form("tr_custID")
    tr_slID = request.form("tr_slID")
    psKonfirmasi = request.form("psKonfirmasi")
    psCatatan = request.form("psCatatan")
    psStatusTransaksi = request.form("psStatusTransaksi")

    set updatestatusps_CMD = server.CreateObject("ADODB.command")
    updatestatusps_CMD.activeConnection = MM_pigo_STRING

    updatestatusps_CMD.commandText = "update MKT_T_Pesanan_D set psNoresi = '0000', psKonfirmasi = '"& psKonfirmasi &"', psCatatan = '"& psCatatan &"', ps_strID = '"&  psStatusTransaksi &"' where left(MKT_T_Pesanan_D.psD,12) = '"& psID &"' "
    'response.write updatestatusps_CMD.commandText &"<BR><BR>"
    updatestatusps_CMD.execute

    set updatestatustr_CMD = server.CreateObject("ADODB.command")
    updatestatustr_CMD.activeConnection = MM_pigo_STRING

    updatestatustr_CMD.commandText = "Update MKT_T_Transaksi_D1 set tr_strID = '03'  where left(trD1,12) ='"& trID &"' and tr_slID = '"& tr_slID &"'  "
    'response.write updatestatustr_CMD.commandText &"<BR><BR>"
    set update = updatestatustr_CMD.execute
    
    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> Pesanan Berhasil Di Proses </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Seller/Pesanan/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>kembali</a></div></div></div>"
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>

