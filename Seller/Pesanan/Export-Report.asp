<!--#include file="../../Connections/pigoConn.asp" -->
<%
    dim TanggalAwal,TanggalAkhir,JenisWallet,ReportJenis,ReportTipe,Tgla,Tgle,ReportNama,DownloadReport

    TanggalAwal         = "2/23/2023"
    TanggalAkhir        = "2/23/2023"


    if TanggalAwal="" or TanggalAkhir = "" then
        FillterTanggal = ""
    else
        FillterTanggal = " AND Wall_DateAcc BETWEEN '"& TanggalAwal &"' AND '"& TanggalAkhir &"' "
    end if

	set Report_CMD = server.createObject("ADODB.COMMAND")
	Report_CMD.activeConnection = MM_PIGO_String

	Report_CMD.commandText = "SELECT MKT_M_Seller.slName FROM MKT_M_Seller RIGHT OUTER JOIN MKT_T_SaldoSeller ON MKT_M_Seller.sl_custID = MKT_T_SaldoSeller.Wall_SellerID WHERE Wall_SellerID = '"& request.Cookies("custID") &"' "
	set Seller = Report_CMD.execute


    ' Response.ContentType = "application/vnd.ms-excel"
    ' Response.AddHeader "content-disposition", "filename="& ReportNama 

%>

<table class="table" >
    <tr>
        <td colspan="7" class="text-start" style="font-size:20px"><b> LAPORAN TRANSAKSI </b></td>
    </tr>
    <tr>
        <td colspan="7" class="text-start"> PERIODE LAPORAN : <%=TanggalAwal%> S.D <%=TanggalAkhir%></td>
    </tr>
    <tr>
        <th> ID TRANSAKSI </th>
        <th> STATUS </th>
        <th> ALASAN PEMBATALAN </th>
        <th> STATUS PEMBATALAN/PENGEMBALIAN </th>
        <th> NO RESI </th>
        <th> OPSI PENGIRIMAN </th>
        <th> ANTAR KE COUNTER / PICK UP </th>
        <th> PESANAN HARUS DIKIRIMKAN SEBELUM </th>
        <th> WAKTU PENGIRIMAN </th>
        <th> WAKTU PESANAN DIBUAT </th>
        <th> SKU </th>
        <th> NAMA PRODUK </th>
        <th> NAMA VARIASI </th>
        <th> HARGA AWAL </th>
        <th> HARGA SETELAH PPH </th>
        <th> HARGA SETELAH DISKON </th>
        <th> QTY </th>
        <th> TOTAL HARGA PRODUK </th>
        <th> TOTAL DISKON </th>
        <th> DISKON DARI PENJUAL </th>
        <th> DISKON DARI OFFICIAL PIGO </th>
        <th> BERAT PRODUK </th>
        <th> JUMLAH PRODUK DIPESAN </th>
        <th> TOTAL BERAT </th>
        <th> VOUCHER DITANGGUNG PENJUAL </th>
        <th> CASHBACK KOIN </th>
        <th> VOUCHER DITANGGUNG OFFICIAL PIGO </th>
        <th> PAKET DISKON </th>
        <th> PAKET DISKON ( DISKON DARI OFFICIAL PIGO ) </th>
        <th> PAKET DISKON ( DISKON DARI PENJUAL ) </th>
        <th> POTONGAN KOIN </th>
        <th> DISKON KARTU KREDIT </th>
        <th> ONGKOS KIRIM DIBAYAR PEMBELI </th>
        <th> ESTIMASI POTONGAN BIAYA KIRIM </th>
        <th> ONGKOS KIRIM PENGEMBALIAN BARANG </th>
        <th> TOTAL PEMBAYARAN </th>
        <th> PERKIRAAN ONGKOS KIRIM </th>
        <th> CATATAN DARI PEMBELI </th>
        <th> NAMA PEMBELI </th>
        <th> NOMOR TELEPON </th>
        <th> ALAMAT PENERIMA </th>
        <th> KOTA </th>
        <th> PROVINSI </th>
        <th> WAKTU PESANAN SELESAI </th>
    </tr>
</table>