<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    InvAPID             = request.queryString("InvAPID")
    TanggalAwal         = request.queryString("InvAP_TanggalAwal")
    TanggalAkhir        = request.queryString("InvAP_TanggalAkhir")

    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING

    IF InvAPID = "PIGO/APINV/" then 
        
        InvoiceVendor_CMD.commandText = "SELECT MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Desc, MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_T_InvoiceVendor_H.InvAP_Faktur, MKT_T_InvoiceVendor_H.InvAP_TglFaktur,  MKT_T_InvoiceVendor_H.InvAP_GrandTotal, MKT_T_InvoiceVendor_H.InvAP_prYN FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_M_Customer.custID = MKT_T_InvoiceVendor_H.InvAP_custID WHERE InvAP_Tanggal BETWEEN '"& TanggalAwal &"' AND  '"& TanggalAkhir &"' ORDER BY InvAP_UpdateTime DESC"
        set InvoiceVendor = InvoiceVendor_CMD.execute

    else
        
        InvoiceVendor_CMD.commandText = "SELECT MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Desc, MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_T_InvoiceVendor_H.InvAP_Faktur, MKT_T_InvoiceVendor_H.InvAP_TglFaktur,  MKT_T_InvoiceVendor_H.InvAP_GrandTotal, MKT_T_InvoiceVendor_H.InvAP_prYN FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_M_Customer.custID = MKT_T_InvoiceVendor_H.InvAP_custID WHERE InvAPID LIKE '%"& InvAPID &"%' OR InvAP_Tanggal BETWEEN '"& TanggalAwal &"' AND  '"& TanggalAkhir &"' ORDER BY InvAP_UpdateTime DESC"
        set InvoiceVendor = InvoiceVendor_CMD.execute

    end if 

%>
<% If InvoiceVendor.eof = true then %>

    <tr>
        <td colspan="7" class="text-center"> Data Tidak Ditemukan </td>
    <tr>

<% else %>

<% 
    no = 0 
    do while not InvoiceVendor.eof 
    no = no + 1
%>
<%

    InvoiceVendor_CMD.commandText = "SELECT ISNULL(COUNT(MKT_T_InvoiceVendor_D1.InvAP_DLine),0) AS Line FROM MKT_T_InvoiceVendor_D1 RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_InvoiceVendor_D1.InvAP_DLine = MKT_T_InvoiceVendor_D.InvAP_Line RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID WHERE MKT_T_InvoiceVendor_H.InvAPID = '"& InvoiceVendor("InvAPID") &"' "
    set LineINVAP = InvoiceVendor_CMD.execute

%>
<% If LineINVAP("Line") = "0" then %>
    <tr style="background-color:#d9d5d5; color:#940005">    
        <td class="text-center"><%=no%></td>
        <td class="text-center">
            <%=day(CDate(InvoiceVendor("InvAP_Tanggal")))%>-<%=Month(CDate(InvoiceVendor("InvAP_Tanggal")))%>-<%=Year(CDate(InvoiceVendor("InvAP_Tanggal")))%>
        </td>
        <td class="text-center">
            <button class="cont-btn" style="background-color:#eee; color:#940005" > <%=InvoiceVendor("InvAPID")%> </button>
            <input type="hidden" name="InvAPID" id="InvAPID<%=no%>" value="<%=InvoiceVendor("InvAPID")%>" >
            <input type="hidden" name="InvAPID_Tanggal" id="InvAPID_Tanggal<%=no%>" value="<%=InvoiceVendor("InvAP_Tanggal")%>">
        </td>
        <td class="text-center" colspan="4">
            <button class="cont-btn"  style="width:max-content;background-color:#eee; color:#940005"> TIDAK LENGKAP </button> &nbsp;
            <button class="cont-btn" onclick="hapus()" style="width:max-content;background-color:#eee; color:#940005"> DELETE </button>
        </td>
    </tr>
<% else %>
    <tr>    
        <td class="text-center"><%=no%></td>
        <td class="text-center">
            <%=day(CDate(InvoiceVendor("InvAP_Tanggal")))%>-<%=Month(CDate(InvoiceVendor("InvAP_Tanggal")))%>-<%=Year(CDate(InvoiceVendor("InvAP_Tanggal")))%>
        </td>
        <td class="text-center">
            <button class="cont-btn" onclick="window.open('PaymentRequest.asp?InvAPID='+document.getElementById('InvAPID<%=no%>').value+'&InvAP_Tanggal='+document.getElementById('InvAPID_Tanggal<%=no%>').value)"> <%=InvoiceVendor("InvAPID")%> </button>

            <input type="hidden" name="InvAPID" id="InvAPID<%=no%>" value="<%=InvoiceVendor("InvAPID")%>" >
            <input type="hidden" name="InvAPID_Tanggal" id="InvAPID_Tanggal<%=no%>" value="<%=InvoiceVendor("InvAP_Tanggal")%>">
        </td>
        <td class="text-center"><%=InvoiceVendor("InvAP_Faktur")%></td>
        <td><%=InvoiceVendor("custNama")%></td>
        <td><%=InvoiceVendor("InvAP_Desc")%></td>
        <td class="text-end">
            <%=Replace(Replace(Replace(FormatCurrency(InvoiceVendor("InvAP_GrandTotal")),"$","Rp. "),".00",""),",",".")%>
        </td>
    </tr>
<% end if %>
<% 
    InvoiceVendor.movenext
    loop 
%>

<% end if %>