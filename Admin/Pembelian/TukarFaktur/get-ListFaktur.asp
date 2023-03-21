<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    TFID            = request.queryString("TFID")
    TanggalAwal     = request.queryString("TF_TanggalAwal")
    TanggalAkhir    = request.queryString("TF_TanggalAkhir")

    set Faktur_CMD = server.createObject("ADODB.COMMAND")
	Faktur_CMD.activeConnection = MM_PIGO_String

    IF TFID = "PIGO/TF/" then 
        Faktur_CMD.commandText = " SELECT MKT_T_TukarFaktur_H.TF_ID, MKT_T_TukarFaktur_H.TF_Tanggal, MKT_T_TukarFaktur_H.TF_FakturPajak, MKT_T_TukarFaktur_H.TF_Invoice,MKT_T_TukarFaktur_H.TF_SuratJalan, MKT_T_TukarFaktur_H.TF_custID, MKT_T_TukarFaktur_H.TF_prYN,  MKT_T_TukarFaktur_H.TF_JR_ID, MKT_T_TukarFaktur_H.TF_postingYN, MKT_M_Customer.custNama FROM MKT_T_TukarFaktur_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_TukarFaktur_H.TF_custID = MKT_M_Customer.custID WHERE TF_Tanggal BETWEEN '"& TanggalAwal &"' AND  '"& TanggalAkhir &"' ORDER BY MKT_T_TukarFaktur_H.TF_Tanggal ASC"
        response.write Faktur_CMD.commandText 
        set TukarFaktur = Faktur_CMD.execute
    else
        Faktur_CMD.commandText = " SELECT MKT_T_TukarFaktur_H.TF_ID, MKT_T_TukarFaktur_H.TF_Tanggal, MKT_T_TukarFaktur_H.TF_FakturPajak, MKT_T_TukarFaktur_H.TF_Invoice,MKT_T_TukarFaktur_H.TF_SuratJalan, MKT_T_TukarFaktur_H.TF_custID, MKT_T_TukarFaktur_H.TF_prYN,  MKT_T_TukarFaktur_H.TF_JR_ID, MKT_T_TukarFaktur_H.TF_postingYN, MKT_M_Customer.custNama FROM MKT_T_TukarFaktur_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_TukarFaktur_H.TF_custID = MKT_M_Customer.custID WHERE TF_ID LIKE '%"& TFID &"%' OR TF_Tanggal BETWEEN '"& TanggalAwal &"' AND  '"& TanggalAkhir &"' ORDER BY MKT_T_TukarFaktur_H.TF_Tanggal ASC"
        response.write Faktur_CMD.commandText 
        set TukarFaktur = Faktur_CMD.execute
    end if 

%>
<% If TukarFaktur.eof = true then %>

    <tr>
        <td colspan="11" class="text-center"> Data Tidak Ditemukan </td>
    <tr>

<% else %>

<%
    no = 0 
    do while not TukarFaktur.eof
    no = no + 1
%>
<tr>
    <td class="text-center"> 
        <%=no%> 
        <input type="hidden" name="TF_ID" id="TF_ID<%=no%>" value="<%=TukarFaktur("TF_ID")%>">
    </td>
    <td class="text-center">
        <button class="cont-btn" onclick="window.open('Bukti-TandaTerima.asp?TF_ID='+document.getElementById('TF_ID<%=no%>').value,'_Self')" > <i class="fas fa-print"></i> TD-<%=TukarFaktur("TF_ID")%> </button>
    </td>
    <td class="text-center"> <%=TukarFaktur("TF_Invoice")%> </td>
    <td class="text-center"> <%=TukarFaktur("TF_FakturPajak")%> </td>
    <td class="text-center"> <%=TukarFaktur("TF_SuratJalan")%> </td>
    <td class="text-center"> <%=CDate(TukarFaktur("TF_Tanggal"))%> </td>
    <td> <%=TukarFaktur("custNama")%> </td>
    <td class="text-center"> <%=TukarFaktur("TF_prYn")%> </td>
        <% if TukarFaktur("TF_prYn") = "N" then %>
            <td class="text-center"> 
                <button class="cont-btn" onclick="window.open('Invoice(Vendor).asp?TF_ID='+document.getElementById('TF_ID<%=no%>').value,'_Self') "style="background-color:red; color:white"> ADD PAY-REQUEST</button> 
            </td>
        <% else %>
            <%
                TukarFaktur_cmd.commandText = "SELECT MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Tanggal FROM MKT_T_InvoiceVendor_H INNER JOIN MKT_T_TukarFaktur_H ON MKT_T_InvoiceVendor_H.InvAP_Faktur = MKT_T_TukarFaktur_H.TF_SuratJalan Where InvAP_Faktur = '"& TukarFaktur("TF_SuratJalan") &"'  "
                'response.write TukarFaktur_cmd.commandText 
                set PayRequest = TukarFaktur_cmd.execute
            %>
        <td class="text-center"> 
            <input type="hidden" name="InvAPID" id="InvAPID<%=no%>" value="<%=PayRequest("InvAPID")%>">
            <input type="hidden" name="InvAP_Tanggal" id="InvAP_Tanggal<%=no%>" value="<%=PayRequest("InvAP_Tanggal")%>">
            <button class="cont-btn" style="background-color:green; color:white" onclick="window.open('../../Transaksi/Invoice-AP/PaymentRequest.asp?InvAPID='+document.getElementById('InvAPID<%=no%>').value+'&InvAP_Tanggal='+document.getElementById('InvAP_Tanggal<%=no%>').value,'_Self')"> <i class="fas fa-print"></i> <%=PayRequest("InvAPID")%> </button> 
        </td>
        <% end if %>
    <td class="text-center"> <%=TukarFaktur("TF_postingYN")%> </td>
    <% if TukarFaktur("TF_postingYN") = "N" then%>
    <td class="text-center"> 
        <button class="cont-btn" onclick="window.open('posting-jurnal.asp?TF_ID='+document.getElementById('TF_ID<%=no%>').value,'_Self')"> POSTING JURNAL </button> 
    </td>
    <% else %>
    <td class="text-center"> 
        <input type="hidden" name="JRD_ID" id="JR_ID<%=no%>" value="<%=TukarFaktur("TF_JR_ID")%>">
        <button class="cont-btn" onclick="window.open('../../GL/GL-Jurnal/jurnal-voucher.asp?JR_ID='+document.getElementById('JR_ID<%=no%>').value,'_Self')"> <i class="fas fa-print"></i> &nbsp; <%=TukarFaktur("TF_JR_ID")%> </button> 
    </td>
    <% end if%>
</tr>
<%
    TukarFaktur.movenext
    loop
%>

<% end if %>