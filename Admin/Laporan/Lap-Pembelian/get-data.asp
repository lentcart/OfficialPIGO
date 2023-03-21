<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")


        
    set Ps_cmd = server.createObject("ADODB.COMMAND")
	Ps_cmd.activeConnection = MM_PIGO_String
			
	Ps_cmd.commandText = "SELECT MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType, MKT_T_MaterialReceipt_D1.mm_poID,  MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE MKT_T_MaterialReceipt_H.mm_custID = '"& request.Cookies("custID") &"' "& FilterFix & "and mmTanggal between '"  & tgla & "' and '"  & tgle & "' order by mmTanggal GROUP BY MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType, MKT_T_MaterialReceipt_D1.mm_poID,  MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty  "

    'response.write Ps_cmd.commandText

	set Ps = Ps_cmd.execute
%>

<%
    do while not Ps.eof
%>

<tr>
    <td><%=Ps("mmTanggal")%></td>
    <td><%=Ps("spNama1")%></td>
    <td><%=Ps("pdId")%></td>
    <td><%=Ps("pdNama")%></td>
    <td><%=Ps("mm_pdQtyDiterima")%></td>
    <td><%=Ps("mm_pdHarga")%></td>
    <%total = Ps("mm_pdQtyDiterima") * Ps("mm_pdHarga") %>
    <td><%=total%></td>
</tr>
<%
    Ps.movenext
    loop
%>
