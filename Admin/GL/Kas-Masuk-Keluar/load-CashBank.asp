<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    set CashBank_cmd = server.createObject("ADODB.COMMAND")
	CashBank_cmd.activeConnection = MM_PIGO_String

    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")
    CB_ID = request.queryString("CB_ID")
    CB_Tipe = request.queryString("CB_Tipe")

    IF CB_Tipe = "" then 
        IF CB_ID = "" then
            CashBank_cmd.commandText = "SELECT GL_T_CashBank_H.*, GL_T_CashBank_D.* FROM GL_T_CashBank_H LEFT OUTER JOIN GL_T_CashBank_D ON GL_T_CashBank_H.CB_ID = GL_T_CashBank_D.CBD_ID WHERE GL_T_CashBank_H.CB_Tanggal between '"& tgla & "' and '"& tgle &"'"
            response.write CashBank_cmd.commandText 
            set CashBank = CashBank_cmd.execute
        Else
            CashBank_cmd.commandText = "SELECT GL_T_CashBank_H.*, GL_T_CashBank_D.* FROM GL_T_CashBank_H LEFT OUTER JOIN GL_T_CashBank_D ON GL_T_CashBank_H.CB_ID = GL_T_CashBank_D.CBD_ID WHERE GL_T_CashBank_H.CB_ID LIKE '%"& CB_ID &"%' "
            response.write CashBank_cmd.commandText 
            set CashBank = CashBank_cmd.execute
        End IF
    Else 
        CashBank_cmd.commandText = "SELECT GL_T_CashBank_H.*, GL_T_CashBank_D.* FROM GL_T_CashBank_H LEFT OUTER JOIN GL_T_CashBank_D ON GL_T_CashBank_H.CB_ID = GL_T_CashBank_D.CBD_ID WHERE GL_T_CashBank_H.CB_Tipe = '"& CB_Tipe &"' "
            response.write CashBank_cmd.commandText 
            set CashBank = CashBank_cmd.execute
    End IF
%>
<% 
    IF CashBank.eof = true Then
%>
    <tr>
        <td colspan="8" > DATA TIDAK DITEMUKAN </td>
    </tr>

<%
    Else
%>
<% 
    no = 0 
    do while not CashBank.eof 
    no = no + 1
%>
    <tr>
        <td class="text-center"> <%=no%> </td>
        <td class="text-center"> 
            <input type="hidden" name="CB_ID" id="CB_ID<%=no%>" value="<%=CashBank("CB_ID")%>">
            <button onclick="window.open('KasDetail.asp?X='+document.getElementById('CB_ID<%=no%>').value,'_Self')" class="cont-btn"> <%=CashBank("CB_ID")%> </button>
            </td>
        <td class="text-center"> <%=Day(CDate(CashBank("CB_Tanggal")))%>/<%=MonthName(Month(CashBank("CB_Tanggal")))%>/<%=Year(CashBank("CB_Tanggal"))%> </td>
        <td> <%=CashBank("CB_Keterangan")%> </td>
        <% if  CashBank("CB_Tipe") = "M" Then %>
        <td> Kas Masuk </td>
        <% else %>
        <td> Kas Keluar </td>
        <% end if  %>
        <td class="text-center"> <%=CashBank("CB_Pembuat")%> </td>
        <td class="text-center"> <%=CashBank("CB_JR_ID")%> </td>
        <td class="text-center"> <%=CashBank("CB_PostingYN")%> </td>
    </tr>
<% CashBank.Movenext
loop %>
<%
    End IF
%>