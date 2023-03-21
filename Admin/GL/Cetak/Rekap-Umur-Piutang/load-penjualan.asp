<!--#include file="../../../../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")

    
    id = request.queryString("custID")

    if id = "" then
        id = "Xh868hdgXJuy86"
        set RUP_CMD = server.createObject("ADODB.COMMAND")
        RUP_CMD.activeConnection = MM_PIGO_String

            RUP_CMD.commandText = "SELECT GL_T_RekapUmurPiutang.RUP_Tahun, GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_custID, MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_UpdateTime FROM GL_T_RekapUmurPiutang LEFT OUTER JOIN MKT_M_Customer ON GL_T_RekapUmurPiutang.RUP_custID = MKT_M_Customer.custID WHERE RUP_custID = '"& id &"'  GROUP BY GL_T_RekapUmurPiutang.RUP_Tahun, GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_custID, MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_UpdateTime"
            'response.write RUP_CMD.commandText

        set RUP = RUP_CMD.execute
    else 
    id = Split(request.queryString("custID"),",")
    for each x in id
        if len(x) > 0 then

            filtercust = filtercust & addOR & " GL_T_RekapUmurPiutang.RUP_custID = '"& x &"' "

            addOR = " or " 
                    
        end if

    next

        if filtercust <> "" then
            FilterFix = "( " & filtercust & " )" 
        end if

    response.write FilterFix

    set RUP_CMD = server.createObject("ADODB.COMMAND")
	RUP_CMD.activeConnection = MM_PIGO_String

    if tgla = "" & tgle = "" then
        RUP_CMD.commandText = "SELECT GL_T_RekapUmurPiutang.RUP_Tahun, GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_custID, MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_UpdateTime FROM GL_T_RekapUmurPiutang LEFT OUTER JOIN MKT_M_Customer ON GL_T_RekapUmurPiutang.RUP_custID = MKT_M_Customer.custID WHERE RUP_custID = 'sdfsdgsgdrigjiregihge'  GROUP BY GL_T_RekapUmurPiutang.RUP_Tahun, GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_custID, MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_UpdateTime"
        response.write RUP_CMD.commandText
        set RUP = RUP_CMD.execute
    else
        RUP_CMD.commandText = "SELECT GL_T_RekapUmurPiutang.RUP_Tahun, GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_custID, MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_UpdateTime FROM GL_T_RekapUmurPiutang LEFT OUTER JOIN MKT_M_Customer ON GL_T_RekapUmurPiutang.RUP_custID = MKT_M_Customer.custID WHERE RUP_Tanggal between '"& tgla &"' and '"& tgle &"' AND "& FilterFix &"   GROUP BY GL_T_RekapUmurPiutang.RUP_Tahun, GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_custID, MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_UpdateTime"
        response.write RUP_CMD.commandText
        set RUP = RUP_CMD.execute

    end if
    end if
%>
<% if RUP.eof = true then %>

    <tr>
        <td colspan="9" class="text-center"> DATA TIDAK DITEMUKAN </td>
    </tr>

<% else %>
<%  
    no = 0 
    do while not RUP.eof
    no = no + 1
%>
    <tr>
        <td class="text-center"> <%=no%> </td>
        <td class="text-center"> <%=RUP("RUP_Tahun")%> </td>
        <td class="text-center"> <%=RUP("RUP_Jenis")%> </td>
        <td class="text-start">  <%=RUP("custNama")%> </td>
        <td class="text-center"> <%=RUP("RUP_UpdateTime")%> </td>
    </tr>
<%
    RUP.movenext
    loop
%>
<% end if %>