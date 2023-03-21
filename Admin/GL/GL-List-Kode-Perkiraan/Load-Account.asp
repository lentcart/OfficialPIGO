<!--#include file="../../../Connections/pigoConn.asp" -->

<%
        caid        = request.QueryString("caid")
        caidname    = request.QueryString("caidname")

        set GL_M_GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
        GL_M_GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount WHERE CA_ID LIKE '%"& caid &"%' AND CA_Name LIKE '%"& caidname &"%' "
        response.write GL_M_GL_M_ChartAccount_cmd.commandText
        set CID = GL_M_GL_M_ChartAccount_cmd.execute
%>
<%
    if CID.eof = true then
%>

    <td colspan="6" class="text-center"> Data Tidak Ditemukan </td>

<% else %>
    <% do while not CID.eof %>
    <tr>
        <td class="text-center"> <%=CID("CA_ID")%> </td>
        <td> <%=CID("CA_Name")%> </td>
        <td class="text-center"> <%=CID("CA_Type")%> </td>
        <td class="text-center"> <%=CID("CA_ID")%> </td>
        <td class="text-center"> 
            <button type="button" class="cont-btn" onclick="addaccount(this)" id="<%=CID("CA_ID")%>"> Add Detail Acc
        </td>
    </tr>
    <% CID.movenext
    loop %>
<% end if %>