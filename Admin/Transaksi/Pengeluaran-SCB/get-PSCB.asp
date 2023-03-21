<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    pscID = request.queryString("pscID")

    set Pengeluaran_cmd = server.createObject("ADODB.COMMAND")
	Pengeluaran_cmd.activeConnection = MM_PIGO_String

        Pengeluaran_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_H.pscTujuan, MKT_T_PengeluaranSC_H.pscDelRule, MKT_T_PengeluaranSC_H.pscDesc, MKT_T_PengeluaranSC_H.pscDelVia, MKT_T_PengeluaranSC_H.pscDelPriority, MKT_T_PengeluaranSC_H.pscFCRule, MKT_T_PengeluaranSC_H.psc_permID, MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_H RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_PengeluaranSC_H.psc_permID LEFT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_Permintaan_Barang_D.Perm_IDH WHERE MKT_T_PengeluaranSC_H.pscID = '"& pscID &"'  GROUP BY MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_H.pscTujuan, MKT_T_PengeluaranSC_H.pscDelRule, MKT_T_PengeluaranSC_H.pscDesc, MKT_T_PengeluaranSC_H.pscDelVia, MKT_T_PengeluaranSC_H.pscDelPriority, MKT_T_PengeluaranSC_H.pscFCRule, MKT_T_PengeluaranSC_H.psc_permID, MKT_T_Permintaan_Barang_H.PermTanggal"
        'response.write Pengeluaran_cmd.commandText 

    set Pengeluaran = Pengeluaran_cmd.execute
%>
<% 
    no = 0
    do while not Pengeluaran.eof 
    no = no + 1
%>
    <tr>
        <td class="text-center"> <%=Pengeluaran("pscID")%><input type="hidden" name="pscTanggal" id="pscTanggal" value="<%=Pengeluaran("pscTanggal")%>"><input type="hidden" name="pscID" id="pscID<%=no%>" value="<%=Pengeluaran("pscID")%>">  </td>
        <td class="text-center" class="text-center"> <%=Pengeluaran("pscTanggal")%> </td>
        <td class="text-center"> <%=Pengeluaran("pscType")%> </td>
        <td class="text-center"> <%=Pengeluaran("psc_permID")%>- [<%=Pengeluaran("permtanggal")%>] </td>
        <td class="text-center"> <button  onclick="window.open('../Invoice-AR/Add-Faktur.asp?pscID='+document.getElementById('pscID<%=no%>').value,'_Self')"class="btn-cetak-po"> Add </button> </td>
    </tr>
<% Pengeluaran.movenext
loop%>