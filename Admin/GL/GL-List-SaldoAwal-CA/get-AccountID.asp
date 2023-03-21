<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("CAID")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID = '"& CA_ID &"'"
    set CAID = GL_M_ChartAccount_cmd.execute

%>
<span class="cont-text"> Keterangan </span><br>
<input Required class="cont-form" type="text" name="" id="" value="<%=CAID("CA_Name")%>">