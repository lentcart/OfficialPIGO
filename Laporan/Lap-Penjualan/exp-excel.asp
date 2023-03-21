<!--#include file="../../Connections/pigoConn.asp" -->
<%
    ' id = request.queryString("custID")
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
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

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String
			
	Seller_cmd.commandText = "SELECT MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where MKT_M_Seller.sl_custID = '"& request.Cookies("custID") &"' "
    'response.write Seller_cmd.commandText
	set Seller = Seller_cmd.execute

	dim report
    set report_cmd = server.createObject("ADODB.COMMAND")
	report_cmd.activeConnection = MM_PIGO_String
			
	report_cmd.commandText = "SELECT MKT_T_Transaksi_H.tr_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Alamat.almLengkap, MKT_M_Seller.slName FROM MKT_M_Seller RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Seller.sl_custID = MKT_T_Transaksi_D1.tr_slID RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Customer.custID = MKT_T_Transaksi_H.tr_custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_T_Transaksi_H.tr_almID = MKT_M_Alamat.almID ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& request.cookies("custID") &"' "& FilterFix & filterTanggal & "GROUP BY dbo.MKT_T_Transaksi_H.tr_custID, dbo.MKT_M_Customer.custNama, dbo.MKT_M_Customer.custEmail, dbo.MKT_M_Customer.custPhone1, dbo.MKT_M_Alamat.almLengkap, MKT_M_Seller.slName"
    'response.write report_cmd.commandText
	set report = report_cmd.execute

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String
	
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-Penjualan - " & now() & ".xls"
%>

<table>
    <tr>
        <th colspan="6">NAMA SELLER</th>
    </tr>
    <tr>
        <th colspan="6"><%=seller("slName")%></th>
    </tr>
    <tr>
        <th colspan="6">LAPORAN PENJUALAN</th>
    </tr>
    <tr>
        <th colspan="6"> Periode Laporan : <%=tgla%> s.d <%=tgle%></th>
    </tr>
    <%do while not report.eof%>
    <tr>
        <th colspan="6"> Data Pembeli </th>
    </tr>
    <tr>
        <th> Nama </th>
        <th> Alamat Email </th>
        <th> Nomor Telepon </th>
        <th colspan="3"> Alamat Lengkap </th>
    </tr>
    <tr>
        <td><%=report("custNama")%></td>
        <td><%=report("custEmail")%></td>
        <td>'<%=report("custPhone1")%> </td>
        <td colspan="3"><%=report("almLengkap")%></td>
    </tr>
    <tr>
        <th> Tanggal Transaksi </th>
        <th> Jumlah</th>
        <th> Kode Produk </th>
        <th> Nama Produk </th>
        <th> Harga </th>
        <th> Total </th>
    </tr>
    <% produk_cmd.commandText = "SELECT MKT_T_Transaksi_D1A.tr_pdID, MKT_M_Produk.pdNama, MKT_T_Transaksi_D2.trSubTotal, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.tr_pdQty,MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdHargaJual FROM MKT_T_Transaksi_D2 RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D2.trD2, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON LEFT(MKT_T_Transaksi_D1A.trD1A, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) WHERE (dbo.MKT_T_Transaksi_H. tr_custID = '"& report("tr_custID") &"') "  & FilterFix & filterTanggal & " order by trTglTransaksi "
    'response.write produk_cmd.commandText
    set produk = produk_cmd.execute %>

    <%do while not produk.eof%>
        <tr>
            <td><%=produk("trTglTransaksi")%></td>
            <td><%=produk("tr_pdQty")%></td>
            <td><%=produk("tr_pdID")%></td>
            <td><%=produk("pdNama")%></td>
            <td><%=produk("tr_pdHarga")%></td>
            <td><%=produk("trSubTotal")%></td>
            <%subtotal = subtotal + produk("trSubTotal") %>
        </tr>
                       
        <% 
        produk.movenext
        loop%>
        <tr>
            <td colspan="5"><b>Sub Total</b></td>
            <td><%=subtotal%></td>

            <%
            grandTotal =  grandTotal + subtotal
            subtotal = 0
            'response.write grandTotal
            %>   
        </tr>
        <%
        response.flush
        report.movenext
        loop%>
        <tr>   
            <th colspan="5"> Total Keseluruhan </th>
            <th> <%=grandTotal%> </th>
        </tr>
        
</table>