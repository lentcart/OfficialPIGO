<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    ' id = request.queryString("custID")
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))
    'response.write tahun &"<BR>"


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    'response.write tgla &"<BR>"
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))

    id = Split(request.queryString("custID"),",")

    for each x in id
            if len(x) > 0 then

                    filtercust = filtercust & addOR & " MKT_T_Transaksi_H.tr_custID = '"& x &"' "

                    addOR = " or " 

            end if
        next

        if filtercust <> "" then
            FilterFix = "and  ( " & filtercust & " )" 
        end if

        ' response.write FilterFix


    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and trTglTransaksi between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= '"& request.Cookies("custID") &"'  "
	set Merchant = Merchant_cmd.execute

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String
                
        Seller_cmd.commandText = "SELECT MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Customer.custNama,MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where MKT_M_Seller.sl_custID = '"& request.Cookies("custID") &"'  "
	set Seller = Seller_cmd.execute

	dim report

    set report_cmd = server.createObject("ADODB.COMMAND")
	report_cmd.activeConnection = MM_PIGO_String
			
	report_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_H.tr_custID, buyer.custNama, buyer.custEmail, buyer.custPhone1, buyer.custPhone2,  MKT_T_Transaksi_H.tr_almID, almbuyer.almNamaPenerima, almbuyer.almPhonePenerima, almbuyer.almLengkap, almbuyer.almLabel, almbuyer.almProvinsi, almbuyer.almLatt, almbuyer.almLong, almbuyer.almKota,  almbuyer.almKel, almbuyer.almKec, almbuyer.almKdpos, MKT_T_Transaksi_H.trTglTransaksi AS tanggaltr, MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir,  MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_T_Transaksi_D1A.tr_pdID, MKT_M_Produk.pdNama, MKT_M_Produk.pdLayanan,  MKT_M_Produk.pdHargaJual, MKT_M_Produk.pdBerat, MKT_M_Produk.pdPanjang, MKT_M_Produk.pdLebar, MKT_M_Produk.pdTinggi, MKT_M_Produk.pdVolume, MKT_T_Transaksi_D1A.tr_pdHarga,  MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.tr_strID AS Expr2, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_M_Customer AS buyer RIGHT OUTER JOIN MKT_M_Alamat AS almbuyer RIGHT OUTER JOIN MKT_T_Transaksi_H ON almbuyer.almID = MKT_T_Transaksi_H.tr_almID ON buyer.custID = MKT_T_Transaksi_H.tr_custID LEFT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID LEFT OUTER JOIN MKT_M_Alamat AS almseller ON MKT_M_Produk.pd_almID = almseller.almID ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_M_Customer.custID = MKT_T_Transaksi_D1.tr_slID ON  MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) FULL OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_D1A.trD1A WHERE (MKT_T_Transaksi_D1.tr_slID = '"& request.cookies("custID") &"') AND MKT_T_Transaksi_D1.tr_strID = '03' "& FilterFix & filterTanggal &" GROUP BY MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_H.tr_custID, buyer.custNama, buyer.custEmail, buyer.custPhone1,  buyer.custPhone2, MKT_T_Transaksi_H.tr_almID, almbuyer.almNamaPenerima, almbuyer.almPhonePenerima, almbuyer.almLengkap, almbuyer.almLabel, almbuyer.almProvinsi, almbuyer.almLatt, almbuyer.almLong,  almbuyer.almKota, almbuyer.almKel, almbuyer.almKec, almbuyer.almKdpos,  MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking,  MKT_T_Transaksi_D1A.tr_pdID, MKT_M_Produk.pdNama, MKT_M_Produk.pdLayanan, MKT_M_Produk.pdHargaJual, MKT_M_Produk.pdBerat, MKT_M_Produk.pdPanjang, MKT_M_Produk.pdLebar, MKT_M_Produk.pdTinggi,  MKT_M_Produk.pdVolume, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.tr_strID, MKT_T_Transaksi_H.trJenisPembayaran  order by trTglTransaksi "
    'response.write report_cmd.commandText
	set report = report_cmd.execute

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-Penjualan-Harian - " & now() & ".xls"

    dim Mbulan
    MBulan = 0
    dim Mtahun
    Mtahun = 0
%>

<table>
    <tr>
        <th colspan="8"><%=seller("slName")%></th>
    </tr>
    <tr>
        <th colspan="8"><%=seller("custPhone1")%> |  <%=seller("custEmail")%></th>
    </tr>
    <tr>
        <th colspan="8"><%=seller("almLengkap")%></th>
    </tr>
    <tr>
        <th colspan="8"><%=seller("almProvinsi")%><%=seller("almKota")%>,<%=seller("almKec")%>,<%=seller("almKel")%>,<%=seller("almKdpos")%></th>
    </tr>
    <tr>
        <th colspan="8">LAPORAN PENJUALAN</th>
    </tr>
    <tr>
        <th colspan="8"> Periode Laporan : <%=tgla%> s.d <%=tgle%></th>
    </tr>
    <tr>
        <th></th>
    </tr>
    <tr>   
        <th>Kode Transaksi</th>
        <th>Tanggal Transaksi</th>
        <th>Nama Pembeli</th>
        <th>Alamat Email</th>
        <th>Nama Produk</th>
        <th>Harga Jual Produk</th>
        <th>QTY</th>
        <th>Total</th>
    </tr>
    <%do while not report.eof%>
    <tr>
        <td><%=report("trID")%></td>
        <td><%=report("trTglTransaksi")%></td>
        <td><%=report("custNama")%></td>
        <td><%=report("custEmail")%></td>
        <td><%=report("pdNama")%></td>
        <td><%=report("tr_pdHarga")%></td>
        <td><%=report("tr_pdQty")%></td>
        <% total = report("tr_pdQty") * report("tr_pdHarga")%>
        <td><%=total%></td>
        <%subtotal = subtotal + total %>
    </tr>
    <%
    response.flush
    report.movenext
    loop%>
    <tr>
        <td class="text-center"colspan="7"><b>Total Keseluruhan</b></td>
        <td><%=subtotal%></td>
    </tr>
</table>