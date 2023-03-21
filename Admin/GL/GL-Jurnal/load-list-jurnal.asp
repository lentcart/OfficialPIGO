<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    set CashBank_H_CMD = server.CreateObject("ADODB.command")
    CashBank_H_CMD.activeConnection = MM_PIGO_String
    CashBank_H_CMD.commandText = "SELECT * FROM GL_T_CashBank_H"
    'response.write CashBank_H_CMD.commandText
    set CashBank = CashBank_H_CMD.execute

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
    set AccountKas = GL_M_ChartAccount_cmd.execute


    set Jurnal_CMD = server.createObject("ADODB.COMMAND")
	Jurnal_CMD.activeConnection = MM_PIGO_String

    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")
    JR_Type = request.queryString("JR_Type")
    JR_ID = request.queryString("JR_ID")

    IF JR_ID = "" then 
        IF JR_Type = "" then 
            Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID,GL_T_Jurnal_H.JR_Status, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN, sum(GL_T_Jurnal_D.JRD_Debet+GL_T_Jurnal_D.JRD_Kredit) AS Total FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID  WHERE GL_T_Jurnal_H.JR_Tanggal between '"  & tgla & "' and '"  & tgle & "' GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN,GL_T_Jurnal_H.JR_Status"
            set Jurnal = Jurnal_CMD.execute
        else
            Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID,GL_T_Jurnal_H.JR_Status, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN, sum(GL_T_Jurnal_D.JRD_Debet+GL_T_Jurnal_D.JRD_Kredit) AS Total FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID  Where JR_Type = '"& JR_Type &"' OR JR_Status = '"& JR_Type &"'  GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN,GL_T_Jurnal_H.JR_Status "
            set Jurnal = Jurnal_CMD.execute
        end if 
    else
        Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID,GL_T_Jurnal_H.JR_Status, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN, sum(GL_T_Jurnal_D.JRD_Debet+GL_T_Jurnal_D.JRD_Kredit) AS Total FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID Where JR_ID LIKE '%"& JR_ID &"%' GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN,GL_T_Jurnal_H.JR_Status "
        set Jurnal = Jurnal_CMD.execute
    end if 

%>
<% 
    no = 0 
    do while not Jurnal.eof 
    no = no + 1
%>
    <tr>
        <td class="text-center"> <%=no%> </td>
        <td class="text-center"> 
            <input type="hidden" name="JR_ID" id="JR_ID<%=no%>" value="<%=Jurnal("JR_ID")%>">
            <% if Jurnal("JR_Status") = "A" then %>
            <button class="cont-btn"  > <%=Jurnal("JR_ID")%> </button> 
            <% else %>
            <button class="cont-btn" onclick="window.open('detail-jurnal.asp?JR_ID='+document.getElementById('JR_ID<%=no%>').value,'_Self')" > <%=Jurnal("JR_ID")%> </button> 
            <% end if %>
        </td>
        <td class="text-center"> <%=Jurnal("JR_Tanggal")%> </td>
        <td class="text-center"> <%=Jurnal("JR_Type")%> </td>
        <td> <%=Jurnal("JR_Keterangan")%> </td>
        <td class="text-center"> <%=Jurnal("JR_DeleteYN")%> </td>
        <td class="text-center"> <%=Jurnal("JR_PostingYN")%> </td>
        <td class="text-end"> <%=REPLACE(REPLACE(FORMATCURRENCY(Jurnal("Total")),"$","Rp. "),".00",",-")%> </td>
    </tr>
<% Jurnal.movenext
loop %>