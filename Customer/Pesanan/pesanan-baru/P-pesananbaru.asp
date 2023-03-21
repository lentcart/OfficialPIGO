<!--#include file="../../../connections/pigoConn.asp"-->
<%
    trID = request.form("trID")
    tr_custID = request.form("tr_custID")
    psKonfirmasi = request.form("konfirmasips")
    psCatatan = request.form("ketpd")
    psStatusTransaksi = request.form("statustransaksi")

    set pesanan_H_CMD = server.CreateObject("ADODB.command")
    pesanan_H_CMD.activeConnection = MM_pigo_STRING

    pesanan_H_CMD.commandText = "exec sp_add_MKT_T_Pesanan_H '"& trID &"' "
    'response.write pesanan_H_CMD.commandText
    set pesanan_H = pesanan_H_CMD.execute

    set pesanan_D_CMD = server.CreateObject("ADODB.command")
    pesanan_D_CMD.activeConnection = MM_pigo_STRING

    pesanan_D_CMD.commandText = "exec sp_add_MKT_T_Pesanan_D '"& pesanan_H("id") &"','00000','"& psKonfirmasi &"','"& psCatatan &"','"& psStatusTransaksi &"'"
    'response.write pesanan_D_CMD.commandText
    set pesanan_D = pesanan_D_CMD.execute

    set updatestatustr_CMD = server.CreateObject("ADODB.command")
    updatestatustr_CMD.activeConnection = MM_pigo_STRING

    updatestatustr_CMD.commandText = "update MKT_T_Transaksi_H set tr_strID = '"&  psStatusTransaksi &"' where tr_custID = '"& tr_custID &"' and trID = '"& trID &"' "
    'response.write updatestatustr_CMD.commandText
    updatestatustr_CMD.execute
     
%>

<script language="javascript">
    alert("Pesanan Berhasil Diproses !")
    <% response.redirect("../index.asp")%>
</script>

