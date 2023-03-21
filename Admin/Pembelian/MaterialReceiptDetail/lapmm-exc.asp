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
        filterTanggal = " mmTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

	set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String
			
	BussinesPartner_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almLengkap, MKT_M_Customer.custPhone1,  MKT_M_Customer.custNamaCP FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_M_Alamat.almJenis <> 'Alamat Toko' GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi,MKT_M_Alamat.almLengkap, MKT_M_Customer.custPhone1,  MKT_M_Customer.custNamaCP "
    'response.write BussinesPartner_cmd.commandText
	set BussinesPartner = BussinesPartner_cmd.execute

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-MaterialReceipt- " & now() & ".xls"

%>
<table>
    <tr>
        <td colspan="11" class="text-start"> LAPORAN MATERIAL RECEIPT </td>
    </tr>
    <tr>
        <td colspan="11" class="text-start"> PERIODE LAPORAN : <%=tgla%> S.D <%=tgle%></td>
    </tr>
    <tr>
        <th> <br> </th>
    </tr>
    <% 
        do while not BussinesPartner.eof
    %>
        <tr>
            <td colspan="11" class="text-start"><%=BussinesPartner("custNama")%></td>
        </tr>
        <tr>
            <td colspan="11" class="text-start"> <%=BussinesPartner("almLengkap")%> - <%=BussinesPartner("almProvinsi")%> </td>
        </tr>
        <tr>
            <td colspan="11" class="text-start"> <%=BussinesPartner("custNamaCP")%> - <%=BussinesPartner("custPhone1")%> </td>
        </tr>
        <tr>
            <td colspan="11" class="text-start"> Payment Term : n/<%=BussinesPartner("custPaymentTerm")%> </td>
        </tr>
        
        <tr>
            <th></th>
        </tr>

        <tr class="text-center">
            <th> NO </th>
            <th> DETAIL PRODUK </th>
            <th> UNIT </th>
            <th> HARGA </th>
            <th> QTY </th>
            <th> SUBTOTAL </th>
        </tr>
        <%
            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE MKT_T_MaterialReceipt_H.mm_custID = '"& BussinesPartner("custID") &"' GROUP BY MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber "
            'response.write produk_cmd.commandText
            set produk = produk_cmd.execute
        %>
        <% 
            do while not produk.eof
        %>
            <tr>
                <td class="text-center"> <%=produk("no")%> </td>
                <td> [<%=produk("pdPartNumber")%> ] - <%=produk("pdNama")%> </td>
                <td class="text-center"> <%=produk("pdUnit")%> </td>
                <td class="text-end"> <%=produk("mm_pdHarga")%> </td>
                <td class="text-center"> <%=produk("mm_pdQtyDiterima")%> </td>
                <%
                    subtotal = produk("mm_pdHarga") * produk("mm_pdQtyDiterima")
                %>
                <td class="text-end"> <%=subtotal%> </td>
            </tr>
            <%
                totalqty = totalqty + produk("mm_pdQty") 
                grandtotal = grandtotal + subtotal 
            %>
        <% 
            produk.movenext
            loop  
        %>
        <%
            grandsubtotal = grandsubtotal + grandtotal
            grandtotal = 0
            grandtotalqty = grandtotalqty + totalqty
            totalqty = 0
        %>
        <tr>
            <th class="text-center"colspan="5"> TOTAL </th>
            <th class="text-end"> <%=grandsubtotal%> </th>
        </tr>
        <%
            totalsubtotal = totalsubtotal + grandsubtotal
            grandsubtotal =0
            totalkeseluruhan = totalkeseluruhan + grandtotalqty
            grandtotalqty = 0
        %>
    <% 
        BussinesPartner.movenext
        loop
    %>
</table>