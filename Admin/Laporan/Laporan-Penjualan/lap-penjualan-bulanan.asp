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

                    filtercust = filtercust & addOR & " MKT_T_Permintaan_Barang_H.Perm_custID = '"& x &"' "

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
        filterTanggal = " and MKT_T_Permintaan_Barang_H.PermTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID = 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Penjualan_CMD = server.createObject("ADODB.COMMAND")
	Penjualan_CMD.activeConnection = MM_PIGO_String
			

    Penjualan_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermTanggal,MONTH(MKT_T_Permintaan_Barang_H.PermTanggal) AS Bulan, MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermNo,MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_D.Perm_pdUpTo,  MKT_T_Permintaan_Barang_D.Perm_pdTax, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_M_PIGO_Produk.pdID = MKT_T_Permintaan_Barang_D.Perm_pdID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_H.PermTanggal between '"& tgla &"' and '"& tgle &"'  AND PermTujuan = '1' "
    'response.write Penjualan_CMD.commandText
    set Penjualan = Penjualan_CMD.execute

    dim Mbulan
    MBulan = 0
    dim Mtahun
    Mtahun = 0

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-Penjualan-Bulanan - " & now() & ".xls"
%>
<table>
    <tr>
        <td style="font-size:18px"><b> PT. PERKASA INDAH GEMILANG OETAMA </b></td>
    </tr>
    <tr>
        <td style="font-size:15px">  Jln. Alternatif Cibubur, Komplek Ruko Cibubur Point Automotiv Center Blok B No. 12B Cimangis, </td>
    </tr>
    <tr>
        <td style="font-size:15px"> Depok - Jawa Barat </td>
    </tr>
    <tr>
        <td style="font-size:15px"> otopigo.sekertariat@gmail.com </td>
    </tr>
    <tr>
        <td style="font-size:15px"> Telp : (021) 8459 6001 / 0811-8838-008 </td>
    </tr>

    <tr>
        <td style="font-size:15px"> </td>
    </tr>

    <tr>
        <td style="font-size:15px"><b> LAPORAN PENJUALAN BULANAN </b></td>
    </tr>
    <tr>
        <td style="font-size:15px"><b> TAHUN : <%=tahun%> </b></td>
    </tr>

    <tr>
        <td style="font-size:15px"><b> <br> </b></td>
    </tr>
    <tr>
        <th> BULAN </th>
        <th> QTY PEMBELIAN </th>
        <th> TOTAL PEMBELIAN </th>
    </tr>
    <%do while not Penjualan.eof%>
    <% 
        bulan =Penjualan("Bulan")
        total = Penjualan("Perm_pdQty")*Penjualan("Perm_pdHargaJual")
        totalqty = totalqty + Penjualan("Perm_pdQty")
        SubTotal = SubTotal + total
    %>
    <%
    Penjualan.movenext
    loop%>
    <tr>
        <td><%=monthname(bulan)%></td>
        <td><%=totalqty%></td>
        <td><%=SubTotal%></td>
    </tr>
    <%
        GrandTotal = GrandTotal + SubTotal
        SubTotal = 0
    %>
    <tr>
        <th> TOTAL KESELURUHAN </th>
        <td> </td>
        <td> <%=GrandTotal%> </td>
    </tr>
    
</table>