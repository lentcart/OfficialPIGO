<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

    tgla = Cdate("2022-10-01")
    tgle = Cdate("2022-10-30")
    bulan = month("2022-10-01")
    tahun = year("2022-10-01")
    pdID = "P072200010"

    'KARTU STOK /PRODUK BULANAN
    set KartuStok_CMD = server.createObject("ADODB.COMMAND")
	KartuStok_CMD.activeConnection = MM_PIGO_String

    KartuStok_CMD.commandText = "SELECT MKT_M_PIGO_Produk.pdID FROM MKT_M_PIGO_Produk WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND (MKT_M_PIGO_Produk.pdID = 'P072200010') AND EXISTS (SELECT  ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdHarga, 0) AS HargaPembelian FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND (MKT_M_PIGO_Produk.pdID = 'P072200010') AND (MONTH(MKT_T_MaterialReceipt_H.mmTanggal) = '10')  GROUP BY MKT_T_MaterialReceipt_D2.mm_pdHarga) AND EXISTS  (SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty), 0) AS Penjualan, ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, 0) AS HargaPenjualan FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_M_PIGO_Produk.pdID = MKT_T_Permintaan_Barang_D.Perm_pdID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID Where Perm_pdID = 'P072200010' AND MONTH(PermTanggal) = '10' GROUP BY MKT_T_Permintaan_Barang_D.Perm_pdHargaJual) "
    response.write KartuStok_CMD.commandText &"<br>"
    set Pembelian = KartuStok_CMD.execute
    response.write Pembelian.eof &"<br>"

    
%>