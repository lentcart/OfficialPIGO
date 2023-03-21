<!--#include file="../../../connections/pigoConn.asp"-->
<%
    PermNo = request.queryString("PermNo")
    PermTanggal = request.queryString("PermTanggal")
    PermTujuan  = request.queryString("PermTujuan")
    PermJenis  = request.queryString("PermJenis")
    Perm_custID = request.queryString("Perm_custID")

    set Permintaan_Barang_H_CMD = server.CreateObject("ADODB.command")
    Permintaan_Barang_H_CMD.activeConnection = MM_pigo_STRING
    Permintaan_Barang_H_CMD.commandText = "exec sp_add_MKT_T_Permintaan_Barang '"& PermNo &"','"& PermTanggal &"','"& PermTujuan &"','"& PermJenis &"','N','"& Perm_custID &"','N','00','04'"
    'response.write Permintaan_Barang_H_CMD.commandText &"<br><br>"
    
    set Permintaan_Barang_H = Permintaan_Barang_H_CMD.execute
%>
<div class="row">
    <div class="col-12">
        <input type="hidden" name="permID" id="permID" value="<%=Permintaan_Barang_H("id")%>">
        <input type="hidden" name="tanggalpermintaan" id="tanggalpermintaan" value="<%=PermTanggal%>">
    </div>
</div>