<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    pshID = request.queryString("pshID")
    pdID = request.queryString("pdID")
    pdHargaBeli = request.queryString("pdHargaBeli")
    pdTax = request.queryString("pdTax")
    pdUpTo = request.queryString("pdUpTo")
    pdHargaJual = request.queryString("pdHargaJual")
    
    set Penawaran_CMD = server.CreateObject("ADODB.command")
    Penawaran_CMD.activeConnection = MM_pigo_STRING

    Penawaran_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Penawaran_D]([PenwIDH],[Penw_pdID],[Penw_pdHargaBeli],[Penw_pdTaxID],[Penw_pdUpTo],[Penw_pdHargaJual],[PenwDAktifYN])VALUES('"& pshID &"','"& pdID &"',"& pdHargaBeli &",'"& pdTax &"',"& pdUpTo &","& pdHargaJual &",'Y')"
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set Penawaran = Penawaran_CMD.execute

    Penawaran_CMD.commandText = "SELECT MKT_T_Penawaran_D.Penw_pdID, MKT_T_Penawaran_D.Penw_pdHargaBeli, MKT_T_Penawaran_D.Penw_pdTaxID, MKT_T_Penawaran_D.Penw_pdUpTo, MKT_T_Penawaran_D.Penw_pdHargaJual,  MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Tax.TaxRate FROM MKT_T_Penawaran_D LEFT OUTER JOIN MKT_M_Tax ON MKT_T_Penawaran_D.Penw_pdTaxID = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Penawaran_D.Penw_pdID = MKT_M_PIGO_Produk.pdID WHERE MKT_T_Penawaran_D.PenwIDH = '"& pshID &"' "
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set produkpenawaran = Penawaran_CMD.execute
%> 
<% 
    no = 0
    do while not produkpenawaran.eof
    no = no + 1
%>
<tr>
    <td class="text-center"> <%=no%> </td>
    <td> <%=produkpenawaran("pdNama")%> </td>
    <td class="text-center"> <%=produkpenawaran("Penw_pdHargaJual")%> </td>
    <td class="text-center"> <%=produkpenawaran("TaxRate")%> </td>
    <td class="text-center"> <%=produkpenawaran("Penw_PdUpTo")%> </td>
    <td class="text-center"> <%=produkpenawaran("Penw_PdHargaJual")%> </td>
</tr>
<% produkpenawaran.movenext
loop %>
