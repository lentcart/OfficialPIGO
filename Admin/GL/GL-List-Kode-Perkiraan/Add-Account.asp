<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    CA_Type     = request.QueryString("CA_Type")
    CA_ID       = request.QueryString("CA_ID")
    CA_Name     = request.QueryString("CA_Name")

        set GL_M_GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
        GL_M_GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount WHERE CA_Type = '"& CA_Type &"' AND CA_ID LIKE '%"& CA_ID &"%' AND CA_UpID LIKE '%"& CA_ID &"%'  AND CA_Name LIKE '%"& CA_Name &"%' "
        response.write GL_M_GL_M_ChartAccount_cmd.commandText
        set ChartAccount = GL_M_GL_M_ChartAccount_cmd.execute
%>
<% do while not ChartAccount.eof %>
<tr>
    <td class="text-center"><button class="cont-btn"> <%=ChartAccount("CA_ID")%> </button> </td>
    <td><%=ChartAccount("CA_Name")%></td>
    <td class="text-center"><%=ChartAccount("CA_UpID")%></td>
    <td class="text-center"><%=ChartAccount("CA_Type")%></td>
    <td class="text-center"><%=ChartAccount("CA_Jenis")%></td>
    <% if ChartAccount("CA_AktifYN") = "Y" then %>
    <td class="text-center"> Aktif </td>
    <% else %>
    <td class="text-center"> Tidak Aktif </td>
    <% end if %>
                    
</tr>
<% ChartAccount.movenext
loop %>