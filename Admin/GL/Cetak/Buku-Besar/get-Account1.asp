<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("CA_ID")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID = '"& CA_ID &"'"
    set Account = GL_M_ChartAccount_cmd.execute

%>
<input class="text-center cont-form" type="hidden" name="ACID1" id="ACID1" value="<%=Account("CA_ID")%>">
<input onfocus="getAccountID1()" onkeyup="getAccountName1()" class="text-center cont-form" type="text" name="AccountID1" id="AccountID1" value="<%=Account("CA_Name")%>">