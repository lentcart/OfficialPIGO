<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    pdNama = request.queryString("pdNama")

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

    Produk_cmd.commandText = "SELECT pdID, pdNama, pdPartNumber, pdLokasi FROM MKT_M_PIGO_Produk WHERE pdNama LIKE '%"& pdNama &"%' "
    'response.write Produk_cmd.commandText
    set Produk = Produk_cmd.execute

    set Stok_CMD = server.createObject("ADODB.COMMAND")
	Stok_CMD.activeConnection = MM_PIGO_String
    set Stok_cmd = server.createObject("ADODB.COMMAND")
	Stok_cmd.activeConnection = MM_PIGO_String

	Stok_cmd.commandText = " SELECT pdTypeProduk FROM MKT_M_PIGO_Produk Where pdAktifYN = 'Y' GROUP BY pdTYpeProduk"
    set TypePD = Stok_cmd.execute

	Stok_cmd.commandText = " SELECT  pdTypePart FROM MKT_M_PIGO_Produk Where pdAktifYN = 'Y' GROUP BY pdTypePart"
    set TypePART = Stok_cmd.execute

    set kategori_cmd = server.createObject("ADODB.COMMAND")
    kategori_cmd.activeConnection = MM_PIGO_String
    kategori_cmd.commandText = "SELECT catID, catName From MKT_M_Kategori WHERE catAktifYN = 'Y' "
    'response.write kategori_cmd.commandText
    set kategori = kategori_cmd.execute 
%>
<% 
    no = 0
    do while not Produk.eof 
    no = no + 1
%>
<tr>
    <td class="text-center"> <%=no%> </td>
    <td class="text-center"> 
        <input type="hidden" name="pdID" id="pdID<%=Produk("pdID")%>" value="<%=Produk("pdID")%>">
        <button class="cont-btn"  onclick="window.open('Kartu-Stok-Produk.asp?periode='+document.getElementById('periodeks').value+'&Tanggal='+document.getElementById('tanggalks').value+'&pdID='+document.getElementById('pdID<%=Produk("pdID")%>').value,'_Self')" > <%=Produk("pdID")%> </button>
    </td>
    <td>
        [<i><%=Produk("pdPartNumber")%></i>] <%=Produk("pdNama")%>
    </td>
    <%
            Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_M_Stok.st_pdQty), 0) AS SaldoAwal, ISNULL(MKT_M_Stok.st_pdHarga,0) AS HargaSaldoAwal FROM MKT_M_PIGO_Produk INNER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE MKT_M_PIGO_Produk.pdID = '"& Produk("pdID") &"' GROUP BY MKT_M_Stok.st_pdHarga"
            'response.write Stok_CMD.commandText &"<br>"
            set SaldoAwal = Stok_CMD.execute
        %>
    <td class="text-center"><%=SaldoAwal("SaldoAwal")%></td>
    <%
            Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian, ISNULL(MKT_M_PIGO_Produk.pdHarga, 0) AS HargaPembelian FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE  pdID = '"& Produk("pdID") &"' GROUP BY MKT_M_PIGO_Produk.pdHarga"
            'response.write Stok_CMD.commandText &"<br>"
            set SaldoMasuk = Stok_CMD.execute
        %>
        <td class="text-center"> <%=SaldoMasuk("Pembelian")%> </td>
        <%
            Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty),0) AS Penjualan, ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdHargaJual,0) AS HargaPenjualan FROM MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_Permintaan_Barang_D.Perm_IDH RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID WHERE MKT_M_PIGO_Produk.pdID = '"& Produk("pdID") &"' GROUP BY MKT_T_Permintaan_Barang_D.Perm_pdHargaJual    "
            'response.write Stok_CMD.commandText &"<br>"
            set SaldoKeluar = Stok_CMD.execute
        %>
        <td class="text-center"> <%=SaldoKeluar("Penjualan")%> </td>
        <%
            Sisa = SaldoAwal("SaldoAwal")+SaldoMasuk("Pembelian")-SaldoKeluar("Penjualan")
        %>
        <td class="text-center"> <%=Sisa%></td>
    <td class="text-center"><%=Produk("pdLokasi")%></td>
</tr>
<% 
    Produk.movenext
    loop
%>