<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")
    typeproduk = request.queryString("typeproduk")
    typepart = request.queryString("typepart")
    kategori = request.queryString("kategori")
    namapd = request.queryString("namapd")


    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

    If namapd = "" then 
        If kategori = "" then 
            If typepart = "" then 
                If typeproduk = "" then
                
                    Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal, MKT_M_PIGO_Produk.pdHarga AS HargaBeli, MKT_M_Tax.TaxRate,  MKT_M_PIGO_Produk.pdUpTo, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, 0) AS Pembelian, ISNULL(MKT_T_Transaksi_D1A.tr_pdQty,0) AS Penjualan, ISNULL(MKT_T_Transaksi_D1A.tr_pdHarga,0) AS HargaJual FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_Stok RIGHT OUTER JOIN MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A ON MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID ON MKT_M_Stok.st_pdID = MKT_M_PIGO_Produk.pdID ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE mmTanggal BETWEEN '"& tgla &"' and '"& tgle &"' OR trTglTransaksi BETWEEN '"&tgla&"' and '"& tgle &"'"
                    'response.write Produk_cmd.commandText
                    set Produk = Produk_cmd.execute
                Else
                    Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal, MKT_M_PIGO_Produk.pdHarga AS HargaBeli, MKT_M_Tax.TaxRate,  MKT_M_PIGO_Produk.pdUpTo, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, 0) AS Pembelian, ISNULL(MKT_T_Transaksi_D1A.tr_pdQty,0) AS Penjualan, ISNULL(MKT_T_Transaksi_D1A.tr_pdHarga,0) AS HargaJual FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_Stok RIGHT OUTER JOIN MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A ON MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID ON MKT_M_Stok.st_pdID = MKT_M_PIGO_Produk.pdID ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE pdTypeProduk = '"& typeproduk &"' "
                    'response.write Produk_cmd.commandText
                    set Produk = Produk_cmd.execute
                End If
            Else
                Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal, MKT_M_PIGO_Produk.pdHarga AS HargaBeli, MKT_M_Tax.TaxRate,  MKT_M_PIGO_Produk.pdUpTo, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, 0) AS Pembelian, ISNULL(MKT_T_Transaksi_D1A.tr_pdQty,0) AS Penjualan, ISNULL(MKT_T_Transaksi_D1A.tr_pdHarga,0) AS HargaJual FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_Stok RIGHT OUTER JOIN MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A ON MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID ON MKT_M_Stok.st_pdID = MKT_M_PIGO_Produk.pdID ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE pdTypePart = '"& typeproduk &"' and pdTypeProduk = '"& typeproduk &"' "
                'response.write Produk_cmd.commandText
                set Produk = Produk_cmd.execute
            End If 
        Else
            Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal, MKT_M_PIGO_Produk.pdHarga AS HargaBeli, MKT_M_Tax.TaxRate,  MKT_M_PIGO_Produk.pdUpTo, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, 0) AS Pembelian, ISNULL(MKT_T_Transaksi_D1A.tr_pdQty,0) AS Penjualan, ISNULL(MKT_T_Transaksi_D1A.tr_pdHarga,0) AS HargaJual FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_Stok RIGHT OUTER JOIN MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A ON MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID ON MKT_M_Stok.st_pdID = MKT_M_PIGO_Produk.pdID ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE pd_catID = '"& kategori &"' "
            'response.write Produk_cmd.commandText
            set Produk = Produk_cmd.execute
        End If
    Else
        Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal, MKT_M_PIGO_Produk.pdHarga AS HargaBeli, MKT_M_Tax.TaxRate,  MKT_M_PIGO_Produk.pdUpTo, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, 0) AS Pembelian, ISNULL(MKT_T_Transaksi_D1A.tr_pdQty,0) AS Penjualan, ISNULL(MKT_T_Transaksi_D1A.tr_pdHarga,0) AS HargaJual FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_Stok RIGHT OUTER JOIN MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A ON MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID ON MKT_M_Stok.st_pdID = MKT_M_PIGO_Produk.pdID ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE pd_catID = '"& kategori &"' and pdNama LIKE '%"& namapd &"%' "
        'response.write Produk_cmd.commandText
        set Produk = Produk_cmd.execute
    End If
%>  
<div class="row d-flex flex-row-reverse p-1">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <table class="align-items-center cont-tb table tb-transaksi table-bordered">
            <thead>
                <tr class="text-center">
                    <th>NO</th>
                    <th>ID PRODUK</th>
                    <th colspan="2">DETAL PRODUK</th>
                    <th>STOK</th>
                    <th>PEMBELIAN</th>
                    <th>PENJUALAN</th>
                    <th>SISA</th>
                    <th>RAK</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    no = 0
                    do while not Produk.eof 
                    no = no + 1
                %>
                <tr>
                    <td class="text-center"> <%=no%> </td>
                    <td class="text-center"> <input class=" text-center cont-form" type="text" readonly name="pdID" id="pdID" value="<%=Produk("pdID")%>" style="border:none; width:6rem"> </td>
                    <td class="text-center"><%=Produk("pdPartNumber")%></td>
                    <td>
                    <%=Produk("pdNama")%>
                        <input type="hidden" name="pdID" id="pdID<%=Produk("pdID")%>" value="<%=Produk("pdID")%>">
                        <input type="hidden" name="pdStok" id="pdStok<%=Produk("pdID")%>" value="<%=Produk("pembelian")%>">
                        <input type="hidden" name="pdHargaJual" id="pdHargaJual<%=Produk("pdID")%>" value="<%=Produk("HargaBeli")%>">
                    </td>
                    <td class="text-center"><%=Produk("StokAwal")%></td>
                    <td class="text-center"><%=Produk("Pembelian")%></td>
                    <td class="text-center"><%=Produk("penjualan")%></td>
                    <% sisastok = Produk("StokAwal")+Produk("Pembelian")-Produk("penjualan")%>
                    <td class="text-center"><%=sisastok%></td>
                    <td class="text-center"><%=Produk("pdLokasi")%></td>
                </tr>
                <% 
                    Produk.movenext
                    loop
                %>
            </tbody>
        </table>
    </div>
</div>