<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    poID = request.queryString("poID")


    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText = "SELECT MKT_M_Customer.custNama,  MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal,MKT_T_PurchaseOrder_D.po_spoID, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_StatusPurchaseOrder.spoName, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID LEFT OUTER JOIN  MKT_M_StatusPurchaseOrder ON MKT_T_PurchaseOrder_D.po_spoID = MKT_M_StatusPurchaseOrder.spoID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID where MKT_T_PurchaseOrder_H.poID = '"& poID &"' and MKT_T_PurchaseOrder_D.po_spoID = '0' "
        'response.write Produk_cmd.commandText

    set PurchaseOrder = PurchaseOrder_cmd.execute
    set jatuhtempo_cmd = server.createObject("ADODB.COMMAND")
	jatuhtempo_cmd.activeConnection = MM_PIGO_String
    
%>
<table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
    <thead>
        <tr class="text-center">
            <th>No</th>
            <th>PO ID</th>
            <th>Tanggal</th>
            <th>Jenis Order</th>
            <th>BussinesPartner</th>
            <th>Nama Produk</th>
            <th>Status PO</th>
            <th colspan="2">Jatuh Tempo</th>
        </tr>
    </thead>
    <tbody >
<%  if PurchaseOrder.eof then   %>
    <tr>
        <td class="text-center" colspan="9"> Data Tidak Ditemukan </td>
    </tr>
<% else %>
<% 
    no = 0 
    do while not PurchaseOrder.eof 
    no = no + 1 
%>
    <tr>
        <td class="text-center"><%=no%></td>
        <td class="text-center"><%=PurchaseOrder("poID")%></td>
        <input type="hidden" name="tanggalpo" id="tanggalpo" value="<%=PurchaseOrder("poTanggal")%>">
        <td class="text-center"><%=Cdate(PurchaseOrder("poTanggal"))%></td>
        <td class="text-center"><%=PurchaseOrder("poJenisOrder")%></td>
        <td><%=PurchaseOrder("custNama")%></td>
        <td class="text-center"><input readonly type="text" name="" id="" value="<%=PurchaseOrder("pdNama")%>" style="width:15rem; border:none"></td>
        

        <% if PurchaseOrder("po_spoID") = "0" then %>
        <td class="text-center"><span class="label-stpo0"><%=PurchaseOrder("spoName")%></span></td>
        <%else if PurchaseOrder("po_spoID") = "1" then %>
        <td class="text-center"><span class="label-stpo1"><%=PurchaseOrder("spoName")%></span></td>
        <%else if PurchaseOrder("po_spoID") = "2" then %>
        <td class="text-center"><span class="label-stpo2"><%=PurchaseOrder("spoName")%></span></td>
        <%else if PurchaseOrder("po_spoID") = "3" then %>
        <td class="text-center"><span class="label-stpo3"><%=PurchaseOrder("spoName")%></span></td>
        <%else %>
        <td class="text-center"><span class="label-stpo4"><%=PurchaseOrder("spoName")%></span></td>
        <% end if %><% end if %><% end if %><% end if %>
        <%
            jatuhtempo_cmd.commandText = "SELECT DATEADD(day, MKT_M_Customer.custPaymentTerm, MKT_T_MaterialReceipt_H.mmTanggal) AS DateAdd FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON  MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE MKT_T_PurchaseOrder_H.poID = '"& PurchaseOrder("poID") &"' AND MKT_T_PurchaseOrder_D.po_pdID = '"& PurchaseOrder("pdID") &"' AND MKT_T_PurchaseOrder_D.po_spoID = 1 AND (MKT_T_MaterialReceipt_H.mmTanggal)IS NOT NULL "
            'response.write  jatuhtempo_cmd.commandText

            set jatuhtempo = jatuhtempo_cmd.execute
        %>
        <% if jatuhtempo.eof then %>
        <td class="text-center "style="color:red">Pending</td>
        <%else%>
        <td class="text-center"><%=CDate(jatuhtempo("DateAdd"))%></td>
        <%end if%>
    </tr>
<% PurchaseOrder.movenext
loop 
nomor = no %>
<%  end if  %>