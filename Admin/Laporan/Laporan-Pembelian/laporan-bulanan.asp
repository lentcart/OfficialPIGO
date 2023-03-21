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
			
	BussinesPartner_cmd.commandText = "SELECT  MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama as bussines, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almProvinsi FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID WHERE almJenis <> 'Alamat Toko' "& FilterFix &" "& filterTanggal &" GROUP BY  MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almProvinsi "
    'response.write BussinesPartner_cmd.commandText
	set BussinesPartner = BussinesPartner_cmd.execute

    set Purchase_cmd = server.createObject("ADODB.COMMAND")
	Purchase_cmd.activeConnection = MM_PIGO_String

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-Bulanan-Pembelian - " & now() & ".xls"

    dim Mbulan
    MBulan = 0
    dim Mtahun
    Mtahun = 0
%>

<table>
    <tr>
        <th colspan="8"><%=Merchant("custNama")%></th>
    </tr>
    <tr>
        <th colspan="8">LAPORAN PEMBELIAN</th>
    </tr>
    <tr>
        <th colspan="8"> Periode Laporan : <%=tgla%> s.d <%=tgle%></th>
    </tr>
    <%
        Purchase_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poTanggal, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdSubtotal,  MKT_T_PurchaseOrder_D.poPajak, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_MaterialReceipt_D2.mm_poID, MKT_M_PIGO_Produk.pdUnit FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID LEFT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_MaterialReceipt_D2.mm_poID = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE (MKT_T_MaterialReceipt_H.mm_custID ='"& BussinesPartner("mm_custID") &"') GROUP BY MKT_T_PurchaseOrder_H.poTanggal, MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,MKT_T_MaterialReceipt_H.mmTanggal,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdSubtotal,  MKT_T_PurchaseOrder_D.poPajak, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_MaterialReceipt_D2.mm_poID, MKT_M_PIGO_Produk.pdUnit "
        'response.write Purchase_cmd.commandText
        set Purchase = Purchase_cmd.execute
    %>
    <% if Mtahun <>  month(Purchase("mmTanggal")) then  %>
   
    <tr>
        <th colspan="8">Tahun <%=year(Purchase("mmTanggal"))%></th>
    </tr>
    <tr>
        <th colspan="8"></th>
    </tr>

    <%end if
    
     Mtahun = month(Purchase("mmTanggal")) 

     %> 
    <tr>   
        <th>PO ID</th>
        <th>TANGGAL</th>
        <th>DETAIL PRODUK</th>
        <th>HARGA BELI</th>
        <th>PPN/TAX</th>
        <th>QTY</th>
        <th>TOTAL</th>
    </tr>
    <%do while not Purchase.eof%>
    <% if Mbulan <>  month(Purchase("mmTanggal")) then  %>
   
    <tr>
        <th> Bulan : <%=monthname(month(Purchase("mmTanggal")))%></th>
    </tr>

    <%end if
    
     MBulan = month(Purchase("mmTanggal")) 

     %>
     <% do while not Purchase.eof %>
    <tr>
        <td><%=Purchase("mm_poID")%></td>
        <td><%=Purchase("poTanggal")%></td>
        <td><b>[<%=Purchase("pdPartNumber")%>]</b>&nbsp;- <%=Purchase("pdNama")%></td>
        <td><%=Purchase("mm_pdHarga")%></td>
        <%
            pajak = Purchase("mm_pdHarga")*Purchase("poPajak")/100
        %>
        <td><%=pajak%></td>
        <td><%=Purchase("mm_pdQtyDiterima")%></td>
        <td><%=Purchase("mm_pdSubtotal")%></td>
        <%subtotal = subtotal + Purchase("mm_pdSubtotal") %>
    </tr>
    <% Purchase.movenext
    loop%>
    <%
    response.flush
    BussinesPartner.movenext
    loop%>
    <tr>
        <td colspan="6"><b>Total Keseluruhan</b></td>
        <td><%=subtotal%></td>
    </tr>
</table>