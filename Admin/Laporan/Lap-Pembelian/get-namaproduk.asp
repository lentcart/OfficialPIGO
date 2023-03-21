<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    kategori = request.queryString("kategori")
    namaproduk = request.queryString("namaproduk")

    set Ps_cmd = server.createObject("ADODB.COMMAND")
	Ps_cmd.activeConnection = MM_PIGO_String
			
	Ps_cmd.commandText = "SELECT MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MONTH(MKT_T_MaterialReceipt_H.mmTanggal) AS Bulan, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType,  MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit,MKT_M_PIGO_Produk.pd_catID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_PurchaseOrder_H.poID FROM MKT_T_MaterialReceipt_D1 LEFT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON MKT_T_MaterialReceipt_D1.mm_poID = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_H.mm_custID = '"& request.Cookies("custID") &"' AND MKT_T_PurchaseOrder_D.po_spoID = '1' AND MKT_M_PIGO_Produk.pd_catID = '"& kategori &"' AND  MKT_M_PIGO_Produk.pdNama  like '%"& namaproduk &"%' GROUP BY MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MONTH(MKT_T_MaterialReceipt_H.mmTanggal) , MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType,  MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pd_catID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_PurchaseOrder_H.poID ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC"

    'response.write Ps_cmd.commandText

	set Ps = Ps_cmd.execute


    
%>
<% if Ps.eof = true then %>
    <tr>
        <th colspan="8" class="text-center"> Data Pembelian Tidak Ditemukan  </th>
    </tr>
<% else %>
<%
    no = 0 
    do while not Ps.eof
    no = no + 1
%>
                            
<tr>
    <td class="text-center"><%=no%></td>
    <td class="text-center"><%=MonthName(Ps("Bulan"))%> - <%=CDate(Ps("mmTanggal"))%></td>
    <td><%=Ps("spNama1")%></td>
    <td><%=Ps("pdNama")%></td>
    <td class="text-center"><%=Ps("mm_pdQtyDiterima")%></td>
    <td class="text-center"><%=Replace(FormatCurrency(Ps("mm_pdHarga")),"$","Rp. ")%></td>
    <%total = Ps("mm_pdQtyDiterima") * Ps("mm_pdHarga") %>
    <td class="text-center"><%=Replace(FormatCurrency(total),"$","Rp. ")%></td>
</tr>
<%
    Ps.movenext
    loop
%>
<% end if %>
