<!--#include file="../../../connections/pigoConn.asp"-->
<%
    trID = request.form("trID")
    psID = request.form("nopesanan")
    tr_custID = request.form("tr_custID")
    psKonfirmasi = request.form("konfirmasips")
    psCatatan = request.form("ketpd")
    psStatusTransaksi = request.form("statustransaksi")

    set updatestatusps_CMD = server.CreateObject("ADODB.command")
    updatestatusps_CMD.activeConnection = MM_pigo_STRING

    updatestatusps_CMD.commandText = "update MKT_T_Pesanan_D set ps_strID = '"&  psStatusTransaksi &"' where left(MKT_T_Pesanan_D.psD,12) = '"& psID &"' "
    'response.write updatestatusps_CMD.commandText
    updatestatusps_CMD.execute

    set updatestatustr_CMD = server.CreateObject("ADODB.command")
    updatestatustr_CMD.activeConnection = MM_pigo_STRING

    updatestatustr_CMD.commandText = "update MKT_T_Transaksi_H set tr_strID = '"&  psStatusTransaksi &"' where tr_custID = '"& tr_custID &"' and trID = '"& trID &"' "
    'response.write updatestatustr_CMD.commandText
    updatestatustr_CMD.execute
     
%>

<script language="javascript">
    alert("Pesanan Telah Selesai !")
    <% response.redirect("../index.asp")%>
</script>

