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
        filterTanggal = " and poTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'   "
	set Merchant = Merchant_cmd.execute

	set supplier_cmd = server.createObject("ADODB.COMMAND")
	supplier_cmd.activeConnection = MM_PIGO_String
			
	supplier_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi  FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H Where poTanggal between '"& tgla &"' and '"& tgle &"' AND almJenis <> 'Alamat Toko' GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi  "
    'response.write supplier_cmd.commandText
	set supplier = supplier_cmd.execute

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-PurchaseOrder- " & now() & ".xls"
%>

<table class="table" >
    <tr>
        <td colspan="11" class="text-start"> LAPORAN PURCHASE ORDER </td>
    </tr>
    <tr>
        <td colspan="11" class="text-start"> PERIODE LAPORAN : <%=tgla%> S.D <%=tgle%></td>
    </tr>
    <tr>
        <th> <br> </th>
    </tr>
    <%
        do while not supplier.eof
    %>
        <tr>
            <td colspan="11" class="text-start"><%=supplier("custNama")%></td>
        </tr>
        <tr>
            <td colspan="11" class="text-start"> <%=supplier("almLengkap")%> - <%=supplier("almProvinsi")%> </td>
        </tr>
        <tr>
            <td colspan="11" class="text-start"> <%=supplier("custNamaCP")%> - <%=supplier("custPhone1")%> </td>
        </tr>
        <tr>
            <td colspan="11" class="text-start"> Payment Term : n/<%=supplier("custPaymentTerm")%> </td>
        </tr>
        
        <tr>
            <th></th>
        </tr>

        <tr>
            <th> NO </th>
            <th> PURCHASE ORDER ID </th>
            <th> JENIS ORDER </th>
            <th> GRAND TOTAL </th>
            <th> STATUS </th>
            <th> TANGGAL ORDER </th>
            <th> TANGGAL PERKIRAAN </th>
            <th> TANGGAL PENERIMAAN </th>
            <th> NO INVOICE / FAKTUR </th>
            <th> TANGGAL FAKTUR </th>
            <th> JATUH TEMPO </th>
        </tr>
        <%
            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY poID) AS no, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_StatusPurchaseOrder.spoName, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poTglDiterima FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_StatusPurchaseOrder ON MKT_T_PurchaseOrder_D.po_spoID = MKT_M_StatusPurchaseOrder.spoID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID where MKT_T_PurchaseOrder_H.po_custID = '"& supplier("custID") &"' AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"' and MKT_T_PurchaseOrder_H.poAktifYN = 'Y' GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_StatusPurchaseOrder.spoName, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poTglDiterima "
            'response.write produk_cmd.commandText
            set produk = produk_cmd.execute
        %>
        <% 
            do while not produk.eof 
        %>
        <tr>
            <td class="text-center"> <%=produk("no")%> </td>
            <td class="text-center"> <%=produk("poID")%> </td>
            <% if produk("poJenisOrder") = "1" then %>
            <td class="text-center"> Slow Moving </td>
            <% else %>
            <td class="text-center"> Fast Moving </td>
            <% end if %>

            <%
                produk_cmd.commandText = "SELECT sum(MKT_T_PurchaseOrder_D.poTotal)as grandtotal FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_StatusPurchaseOrder ON MKT_T_PurchaseOrder_D.po_spoID = MKT_M_StatusPurchaseOrder.spoID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID Where poID = '"& produk("poID") &"' AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"'  "
                'response.write produk_cmd.commandText
                set Gtotal = produk_cmd.execute
            %>

            <td class="text-center"> <%=Gtotal("grandtotal")%> </td>
            <td class="text-center"> <%=produk("spoName")%> </td>
            <td class="text-center"> 
                <%=day(CDate(produk("poTanggal")))%>/<%=Month(produk("poTanggal"))%>/<%=year(produk("poTanggal"))%> 
            </td>
            <td class="text-center"> 
                <%=day(CDate(produk("poTglDiterima")))%>/<%=Month(produk("poTglDiterima"))%>/<%=year(produk("poTglDiterima"))%> 
            </td>

            <%
                produk_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D2.mm_poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID  WHERE (MKT_T_PurchaseOrder_H.poID = '"& produk("poID") &"') AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"' GROUP BY MKT_T_MaterialReceipt_H.mmTanggal "
                'response.write produk_cmd.commandText
                set Penerimaan = produk_cmd.execute
            %>

            <% if Penerimaan.eof = true then %>
            <td class="text-center"> Pending </td>
            <% else %>
            <td class="text-center"> 
                <%=day(CDate(Penerimaan("mmTanggal")))%>/<%=Month(Penerimaan("mmTanggal"))%>/<%=year(Penerimaan("mmTanggal"))%>
            </td>
            <% end if %>

            <%
                produk_cmd.commandText = "SELECT MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Tanggal FROM MKT_T_TukarFaktur_D1 LEFT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_TukarFaktur_D1.TFD1_poID = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_TukarFaktur_D ON LEFT(MKT_T_TukarFaktur_D1.TFD1_ID, 20) = MKT_T_TukarFaktur_D.TFD_ID RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON LEFT(MKT_T_TukarFaktur_D.TFD_ID, 16) = MKT_T_TukarFaktur_H.TF_ID RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_TukarFaktur_H.TF_ID = MKT_T_InvoiceVendor_D.InvAP_Line RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID WHERE (MKT_T_PurchaseOrder_H.poID = '"& produk("poID") &"') AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"'  Group by MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Tanggal"
                'response.write produk_cmd.commandText
                set invoice = produk_cmd.execute
            %>

            <% if invoice.eof = true then %>
            <td class="text-center"style="color:red" > Pending </td>
            <td class="text-center" style="color:red"> - </td>
            <% else %>
            <td class="text-center"> <%=invoice("InvAPID")%> </td>
            <td class="text-center"> 
                <%=day(CDate(invoice("InvAP_Tanggal")))%>/<%=Month(invoice("InvAP_Tanggal"))%>/<%=year(invoice("InvAP_Tanggal"))%> 
            </td>
            <% end if %>

            <%
                produk_cmd.commandText = "SELECT po_payYN,po_JatuhTempo FROM MKT_T_PurchaseOrder_H WHERE (MKT_T_PurchaseOrder_H.poID = '"& produk("poID") &"') AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"' AND MKT_T_PurchaseOrder_H.po_custID = '"& supplier("custID") &"' "
                'response.write produk_cmd.commandText
                set PayYN = produk_cmd.execute
            %>

            <% if PayYN("po_payYN") = "Y" then %>
                <td class="text-center "style="color:green">LUNAS</td>
            <% else %>
                <% if PayYN("po_JatuhTempo") = "1900-01-01" then %>
                    <td class="text-center "style="color:red">Pending</td>
                <%else%>
                    <td class="text-center"><%=CDate(PayYN("po_JatuhTempo"))%></td>
                <% 
                    sekarang = date()
                    sisahari = CDate(PayYN("po_JatuhTempo")) - sekarang
                %>
                <% end if %>
            <% end if %>
        </tr>
            <%
                grandtotal = grandtotal + Gtotal("grandtotal")
            %>
        <% 
            produk.movenext
            loop  
        %>
        <%
            grandtotalqty = grandtotalqty + totalqty
            totalqty = 0
            grantotalharga = grandtotalharga + totalharga
            totalharga = 0
            grandsubtotal = grandsubtotal + grandtotal
            grandtotal = 0
        %>
        <tr>
            <td class="text-start" colspan="10"><b> TOTAL </b></td>

            <td class="text-center"><b> <%=grandsubtotal%> </b></td>
        </tr>
        
        <%
            GranQTY = GranQTY + grandtotalqty
            grandtotalqty = 0
            totalkeseluruhan = totalkeseluruhan + grandsubtotal
            grandsubtotal = 0
        %>
        <tr>
            <th> <br> </th>
        </tr>
    <% 
        supplier.movenext
        loop 
    %>
    <tr>
        <td class="text-start" colspan="10"><b> SUBTOTAL </b></td>

        <td class="text-center"><b> <%=totalkeseluruhan%> </b></td>
    </tr>
</table>