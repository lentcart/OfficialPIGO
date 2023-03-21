<!--#include file="../../../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")
    id = request.queryString("custID")
    
    if id = "" then
        id = "Xh868hdgXJuy86"
        set Pembelian_cmd = server.createObject("ADODB.COMMAND")
        Pembelian_cmd.activeConnection = MM_PIGO_String

            Pembelian_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Alamat.almKota,  MKT_M_Alamat.almProvinsi FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE almJenis <> 'Alamat Toko' AND  mm_custID = '"& id &"'  GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Alamat.almKota,  MKT_M_Alamat.almProvinsi"
            'response.write Pembelian_cmd.commandText

        set Pembelian = Pembelian_cmd.execute
    else 
    id = Split(request.queryString("custID"),",")
    for each x in id
        if len(x) > 0 then

            filtercust = filtercust & addOR & " MKT_T_MaterialReceipt_H.mm_custID = '"& x &"' "

            addOR = " or " 
                    
        end if

    next

        if filtercust <> "" then
            FilterFix = "( " & filtercust & " )" 
        end if

    response.write FilterFix

    set Pembelian_cmd = server.createObject("ADODB.COMMAND")
	Pembelian_cmd.activeConnection = MM_PIGO_String
    if tgla = "" & tgle = "" then
        Pembelian_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Alamat.almKota,  MKT_M_Alamat.almProvinsi FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE almJenis <> 'Alamat Toko' and mm_custID = 'sdfsdgsgdrigjiregihge' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Alamat.almKota,  MKT_M_Alamat.almProvinsi"
        response.write Pembelian_cmd.commandText

        set Pembelian = Pembelian_cmd.execute
    else
        Pembelian_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Alamat.almKota,  MKT_M_Alamat.almProvinsi FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE almJenis <> 'Alamat Toko' AND mmTanggal between '"& tgla &"' and '"& tgle &"' AND "& FilterFix &"  GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Alamat.almKota,  MKT_M_Alamat.almProvinsi"
        response.write Pembelian_cmd.commandText

        set Pembelian = Pembelian_cmd.execute

        
        end if

    end if
%>
<% 
    if Pembelian.eof = true then
%>
    <td colspan="7"> DATA TIDAK DITEMUKAN </td>
<% else %>
<% 
    no = 0
    do while not Pembelian.eof 
    no = no + 1
%>
<tr>
    <td class="text-center"> <%=no%> </td>
    <td class="text-center"> <%=Pembelian("mmID")%> </td>
    <td class="text-center"> <%=Pembelian("mmTanggal")%> </td>
    <td class="text-center"> 
        <%=Pembelian("custNama")%> 
        <input type="hidden" id="custID" name="custID" value="<%=Pembelian("mm_custID")%>">
    </td>
    <td class="text-center"> <%=Pembelian("custEmail")%> </td>
    <td class="text-center"> <%=Pembelian("almKota")%> </td>
    <td class="text-center"> <%=Pembelian("almProvinsi")%> </td>
</tr>
<% 
    Pembelian.movenext
    loop
%>
<% end if %>
