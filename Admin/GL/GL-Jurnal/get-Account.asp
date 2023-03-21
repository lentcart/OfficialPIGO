<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("CA_ID")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID = '"& CA_ID &"'"
    set Account = GL_M_ChartAccount_cmd.execute

%>
<span class="cont-text"> Kode Account ID </span><br>
<input onfocus="getAccountID()" onkeyup="getAccountName()" class="text-center cont-form" type="text" name="AccountID1" id="AccountID1" value="<%=Account("CA_ID")%>">