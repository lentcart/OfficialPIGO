<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    pscID = request.queryString("pscID")


    set Pengeluaran_cmd = server.createObject("ADODB.COMMAND")
	Pengeluaran_cmd.activeConnection = MM_PIGO_String

        Pengeluaran_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_D1.pscD1_NoPermintaan, MKT_T_PengeluaranSC_D1.pscD1_TglPermintaan,  MKT_M_Supplier.spID, MKT_M_Supplier.spNama1 FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_PengeluaranSC_D1 ON MKT_M_Supplier.spID = MKT_T_PengeluaranSC_D1.pscD1_spID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D1.pscID1_H = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D2 ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D2.pscD2_H WHERE MKT_T_PengeluaranSC_H.pscID = '"& pscID &"' group by MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_D1.pscD1_NoPermintaan, MKT_T_PengeluaranSC_D1.pscD1_TglPermintaan,  MKT_M_Supplier.spID, MKT_M_Supplier.spNama1"
        'response.write Pengeluaran_cmd.commandText

    set Pengeluaran = Pengeluaran_cmd.execute
%>
<% do while not Pengeluaran.eof %>
    <tr>
        <td class="text-center"> <%=Pengeluaran("pscID")%><input type="hidden" name="pscTanggal" id="pscTanggal" value="<%=Pengeluaran("pscTanggal")%>"> </td>
        <td class="text-center" class="text-center"> <%=Pengeluaran("pscTanggal")%> </td>
        <td class="text-center"> <%=Pengeluaran("pscType")%> </td>
        <td class="text-center"> <%=Pengeluaran("pscD1_noPermintaan")%> </td>
        <td class="text-center"> <%=Pengeluaran("pscD1_TglPermintaan")%> </td>
        <td class="text-center"> <%=Pengeluaran("spNama1")%> </td>
    </tr>
<% Pengeluaran.movenext
loop%>
