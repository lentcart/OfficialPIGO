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

                    filtercust = filtercust & addOR & " MKT_T_MaterialReceipt_H.mm_custID = '"& x &"' "

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
        filterTanggal = " and mmTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID = 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String
			
	BussinesPartner_cmd.commandText = "SELECT  MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almProvinsi FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID WHERE almJenis <> 'Alamat Toko' "& FilterFix &" "& filterTanggal &" GROUP BY  MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almProvinsi "
    'response.write BussinesPartner_cmd.commandText
	set BussinesPartner = BussinesPartner_cmd.execute

    set Purchase_cmd = server.createObject("ADODB.COMMAND")
	Purchase_cmd.activeConnection = MM_PIGO_String

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Laporan-Pembelian-PIGO- " & now() & ".xls"
%>
<table>
    <tr>
        <td colspan="9">LAPORAN PEMBELIAN</td>
    </tr>
    <tr>
        <td colspan="9"> Periode Laporan : <%=tgla%> s.d <%=tgle%></td>
    </tr>
    <tr>
        <th></th>
    </tr>
    <% do while not BussinesPartner.eof %>
    <tr>
        <td colspan="9"><%=BussinesPartner("custNama")%></td>
    </tr>
    <tr>
        <td colspan="9"><%=BussinesPartner("custPhone1")%>  |  <%=BussinesPartner("custEmail")%></td>
    </tr>
    <tr>
        <td colspan="9"><%=BussinesPartner("almLengkap")%></td>
    </tr>
    <tr class="text-center">
        <th> NO </th>
        <th> PURCHASEORDER </th>
        <th> ID PRODUK </th>
        <th> DETAIL </th>
        <th> SATUAN </th>
        <th> HARGA BELI </th>
        <th> PPN </th>
        <th> QTY </th>
        <th> TOTAL </th>
    </tr>
    <%
        Purchase_cmd.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_T_PurchaseOrder_D.poPdUnit, MKT_T_PurchaseOrder_D.poPajak, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2  WHERE MKT_T_MaterialReceipt_H.mm_custID = '"& BussinesPartner("mm_custID") &"' GROUP BY MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_T_PurchaseOrder_D.poPdUnit, MKT_T_PurchaseOrder_D.poPajak, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber "
        'response.write Purchase_cmd.commandText
        set Purchase = Purchase_cmd.execute
    %>
    <%
        If Purchase.eof = true then
    %>
        <tr class="text-center">
            <td colspan="9"> TIDAK TERDAPAT DATA PEMBELIAN </td>
        <tr>
    <% else %>
    <%
        no = 0 
        do while not Purchase.eof
        no = no + 1
    %>
    <tr>
        <td class="text-center"><%=no%></td>
        <td class="text-center"><%=Purchase("mm_poID")%>/<b><%=CDate(Purchase("poTanggal"))%></b></td>
        <td class="text-center"><%=Purchase("mm_pdID")%></td>
        <td><b>[<%=Purchase("pdPartNumber")%>]</b><%=Purchase("pdNama")%></td>
        <td class="text-center"><%=Purchase("poPdUnit")%></td>
        <td class="text-center"><%=Purchase("mm_pdHarga")%></td>
        <%
            Pajak = Purchase("mm_pdHarga")*Purchase("poPajak")/100
        %>
        <td class="text-center"><%=Pajak%></td>
        <td class="text-center"><%=Purchase("mm_pdQtyDiterima")%></td>
        <td class="text-center"><%=Purchase("mm_pdSubtotal")%></td>
    </tr>
    <%
        total = total + Purchase("mm_pdSubtotal")
    %>
    <%
        Purchase.movenext
        loop
    %>
    <% end if %>
    <tr>
        <th class="text-center" colspan="8"> TOTAL </th>
        <th class="text-center"> <%=total%> </th>
    </tr>
    <tr>
        <td></td>
    </tr>
    <%
        GRANDTOTAL = GRANDTOTAL + TOTAL
        total = 0
    %>
    <% BussinesPartner.movenext
    loop%>
</table>