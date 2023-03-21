<!--#include file="../../Connections/pigoConn.asp" -->

<%
    sjID = request.queryString("sjID")


    set suratjalan_cmd = server.createObject("ADODB.COMMAND")
	suratjalan_cmd.activeConnection = MM_PIGO_String

        suratjalan_cmd.commandText = "SELECT MKT_T_SuratJalan.sjID, MKT_T_SuratJalan.sTanggal, MKT_T_SuratJalan.s_pscID, MKT_T_SuratJalan.s_spID, MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spAlamat FROM MKT_T_SuratJalan LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_SuratJalan.s_spID = MKT_M_Supplier.spID WHERE MKT_T_SuratJalan.sjID = '"& sjID &"' "
        'response.write suratjalan_cmd.commandText 

    set suratjalan = suratjalan_cmd.execute
%>
<% do while not SuratJalan.eof %>
    <tr>
        <td class="text-center"> <%=SuratJalan("sjID")%></td>
        <td class="text-center"> <%=CDate(SuratJalan("sTanggal"))%><input type="hidden" name="tglSuratJalan" id="tglSuratJalan" value="<%=SuratJalan("sTanggal")%>"> </td>
        <td class="text-center"> <%=SuratJalan("s_pscID")%> </td>
        <td class="text-center"> <%=SuratJalan("spNama1")%> </td>
        <td> <%=SuratJalan("spAlamat")%> </td>
    </tr>
<% SuratJalan.movenext
loop%>
