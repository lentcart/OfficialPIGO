<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))

    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and mmTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String
			
	Seller_cmd.commandText = "SELECT MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Customer.custNama,MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where MKT_M_Seller.sl_custID = '"& request.Cookies("custID") &"' "
	set Seller = Seller_cmd.execute

	set Pembelian_cmd = server.createObject("ADODB.COMMAND")
	Pembelian_cmd.activeConnection = MM_PIGO_String
			
	Pembelian_cmd.commandText = "SELECT MKT_M_Supplier.spID, MKT_M_Supplier.spKey, MKT_M_Supplier.spNama1, MKT_M_Supplier.spNama2, MKT_M_Supplier.spNpwp, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spProv,   MKT_M_Supplier.spPhone1, MKT_M_Supplier.spFax, MKT_M_Supplier.spEmail, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spPhoneCP, MKT_M_Supplier.spJabatanCP FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN  MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN  MKT_T_MaterialReceipt_H LEFT OUTER JOIN  MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID ON   MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID WHERE MKT_T_MaterialReceipt_H.mm_custID = '"& request.Cookies("custID") &"' " & FilterFix & filterTanggal & "  GROUP BY  MKT_M_Supplier.spID, MKT_M_Supplier.spKey, MKT_M_Supplier.spNama1, MKT_M_Supplier.spNama2, MKT_M_Supplier.spNpwp, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spProv, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spFax, MKT_M_Supplier.spEmail, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spPhoneCP, MKT_M_Supplier.spJabatanCP"

    'response.write Pembelian_cmd.commandText
	set Pembelian = Pembelian_cmd.execute

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-Pembelian-PIGO- " & now() & ".xls"

%>

<table>
    <tr>
        <td><%=seller("slName")%></td>
    </tr>
    <tr>
        <td><%=seller("custPhone1")%>  |  <%=seller("custEmail")%></td>
    </tr>
    <tr>
        <td><%=seller("almLengkap")%></td>
    </tr>
    <tr>
        <td><%=seller("almProvinsi")%> - <%=seller("almKota")%> , <%=seller("almKec")%> , <%=seller("almKel")%> , <%=seller("almKdpos")%></td>
    </tr>
    <tr>
        <td>LAPORAN PEMBELIAN</td>
    </tr>
    <tr>
        <td> Periode Laporan : <%=tgla%> s.d <%=tgle%></td>
    </tr>
    <tr>
        <th></th>
    </tr>
    <tr>
        <th> No Urut </th>
        <th> Tanggal  </th>
        <th> Nama Produk </th>
        <th> Type Produk </th>
        <th> Harga </th>
        <th> Jumlah </th>
        <th> Total </th>
    </tr>
    <%do while not Pembelian.eof%>
    <tr>
            
        <% 
            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS nourut,  MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType, MKT_T_MaterialReceipt_D1.mm_poID,  MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MKT_T_MaterialReceipt_H.mm_spID = '"& Pembelian("spID") &"') "   & filterTanggal & "GROUP BY MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType, MKT_T_MaterialReceipt_D1.mm_poID,  MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_M_PIGO_Produk.pdTypeProduk  order by mmTanggal "
            'response.write produk_cmd.commandText
	        set produk = produk_cmd.execute %>

        <%do while not produk.eof%>
        <td><%=produk("nourut")%></td>
        <td><%=Cdate(produk("mmTanggal"))%></td>
        <td><%=produk("pdNama")%></td>
        <td><%=produk("pdTypeProduk")%></td>
        <td ><%=produk("mm_pdHarga")%></td>
        <td><%=produk("mm_pdQtyDiterima")%></td>
        <%total = produk("mm_pdQtyDiterima") * produk("mm_pdHarga") %>
        <td><%=total%></td>
        <%subtotal = subtotal+ total %>
    </tr>
        <% 
        produk.movenext
        loop%>   
            <%
            grandTotal =  grandTotal + subtotal
            subtotal = 0
            'response.write grandTotal
            %>   
        <%
        response.flush
        Pembelian.movenext
        loop%>
    <tr>   
        <th colspan="6"> Total Keseluruhan </th>
        <th> <%=grandTotal%> </th>
    </tr>
        
</table>