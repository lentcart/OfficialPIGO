<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("CA_ID")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID = '"& CA_ID &"'"
    set Account = GL_M_ChartAccount_cmd.execute

%>
<input class="text-center cont-form" type="hidden" name="ACID2" id="ACID2" value="<%=Account("CA_ID")%>">
<input onfocus="getAccountID2()" onkeyup="getAccountName2()" class="text-center cont-form" type="text" name="AccountID2" id="AccountID2" value="<%=Account("CA_Name")%>">