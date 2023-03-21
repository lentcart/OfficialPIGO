<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
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
			
	Seller_cmd.commandText = "SELECT MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Customer.custNama,MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where MKT_M_Seller.sl_custID = '"& request.Cookies("custID") &"' "
	set Seller = Seller_cmd.execute

	dim report

    set report_cmd = server.createObject("ADODB.COMMAND")
	report_cmd.activeConnection = MM_PIGO_String
			
        report_cmd.commandText = "SELECT MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MONTH(MKT_T_Transaksi_H.trTglTransaksi) as Bulan, MKT_M_Customer.custNama, MKT_M_Produk.pdID, MKT_M_Produk.pdNama FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Customer.custID = MKT_T_Transaksi_H.tr_custID ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID WHERE (MKT_T_Transaksi_D1.tr_slID = '"& request.cookies("custID") &"') AND MKT_T_Transaksi_D1.tr_strID = '03' "& FilterFix & filterTanggal &"  GROUP BY MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_H.trTglTransaksi, MKT_M_Customer.custNama, MKT_M_Produk.pdID, MKT_M_Produk.pdNama  "
        'response.write report_cmd.commandText
	set report = report_cmd.execute

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-Penjualan-Bulanan - " & now() & ".xls"

    dim Mbulan
    MBulan = 0
    dim Mtahun
    Mtahun = 0
%>

<table>
    <tr>
        <th colspan="3"><%=seller("slName")%></th>
    </tr>
    <tr>
        <th colspan="3"><%=seller("custPhone1")%>  |  <%=seller("custEmail")%></th>
    </tr>
    <tr>
        <th colspan="3"><%=seller("almLengkap")%></th>
    </tr>
    <tr>
        <th colspan="3"><%=seller("almProvinsi")%><%=seller("almKota")%>,<%=seller("almKec")%>,<%=seller("almKel")%>,<%=seller("almKdpos")%></th>
    </tr>
    <tr>
        <th colspan="3">LAPORAN PENJUALAN BULANAN</th>
    </tr>
    <tr>
        <th colspan="3"> Tahun : <%=tahun%></th>
    </tr>
    <tr>   
        <th>Bulan</th>
        <th>Quantity Pembelian Produk</th>
        <th>Total Pembelian</th>
    </tr>
    <%do while not report.eof%>
    <% 
        bulan =report("bulan")
        total = report("tr_pdQty")*report("tr_pdHarga")
        totalqty = totalqty + report("tr_pdQty")
        grandTotal = grandTotal + total
    %>
    <%
    response.flush
    report.movenext
    loop%>
    <tr>
        <td><%=monthname(bulan)%></td>
        <td><%=totalqty%></td>
        <td><%=grandTotal%></td>
    </tr>
    <%
        subtotal = subtotal + grandTotal
        grandTotal = 0
    %>
    <tr>
        <td colspan="2"><b>Total Keseluruhan</b></td>
        <td><%=subtotal%></td>
    </tr>
</table>