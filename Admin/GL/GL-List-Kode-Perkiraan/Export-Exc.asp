<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

        set GL_M_GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
        GL_M_GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount WHERE CA_Type = 'H'"
        set CID = GL_M_GL_M_ChartAccount_cmd.execute

        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount "
        set ChartAccount = GL_M_GL_M_ChartAccount_cmd.execute

        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT MAX(CA_ID) AS AccountID  FROM GL_M_ChartAccount WHERE CA_Type = 'H'  "
        set LastCAID = GL_M_GL_M_ChartAccount_cmd.execute
        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT GL_M_Kelompok.KCA_Name, GL_M_ChartAccount.CA_Name FROM GL_M_ChartAccount LEFT OUTER JOIN GL_M_Kelompok ON GL_M_ChartAccount.CA_Kelompok = GL_M_Kelompok.KCA_ID WHERE (GL_M_ChartAccount.CA_Type = 'H') AND CA_ID = '"& LastCAID("AccountID") &"' "
        set LastAccount = GL_M_GL_M_ChartAccount_cmd.execute

        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM [PIGO].[dbo].[GL_M_Kelompok] "
        set CAKelompok = GL_M_GL_M_ChartAccount_cmd.execute

        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader "content-disposition", "filename=Account-Kas-PIGO- " & date() & ".xls"

%>

<table>
    <tr>
        <th> NO </th>
        <th> ACCOUNT ID </th>
        <th> NAMA ACCOUNT  </th>
        <th> ACCOUNT UP ID </th>
        <th> ACCOUNT JENIS </th>
        <th> ACCOUNT TYPE </th>
        <th> ACCOUNT GOLONGAN </th>
        <th> ACCOUNT KELOMPOK </th>
        <th> ACCOUNT TYPE ITEM </th>
        <th> ACC AKTIFYN </th>
    </tr>
    <%
        no = 0 
        do while not ChartAccount.eof
        no = no + 1
    %>
    <tr>
        <td><%=no%></td>
        <% if ChartAccount("CA_Type") = "H" then %>
        <td><b><%=ChartAccount("CA_ID")%></b></td>
        <td><b><%=ChartAccount("CA_Name")%></b></td>
        <% else %>
        <td><%=ChartAccount("CA_ID")%></td>
        <td><%=ChartAccount("CA_Name")%></td>
        <% end if %>
        <td><%=ChartAccount("CA_UpID")%></td>
        <td><%=ChartAccount("CA_Jenis")%></td>
        <td><%=ChartAccount("CA_Type")%></td>
        <td><%=ChartAccount("CA_Golongan")%></td>
        <td><%=ChartAccount("CA_Kelompok")%></td>
        <td><%=ChartAccount("CA_ItemTipe")%></td>
        <td><%=ChartAccount("CA_AktifYN")%></td>
    </tr>
    <% 
        ChartAccount.movenext
        loop
    %>
</table>