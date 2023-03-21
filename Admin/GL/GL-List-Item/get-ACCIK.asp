<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("ACC_ACID")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID = '"& CA_ID &"'"
    set ACCIK = GL_M_ChartAccount_cmd.execute

%>
<div class="col-4">
    <span class="cont-text"> No ACC  CASH / BANK (Debet)</span><br>
</div>
<div class="col-3">
    <input type="text" onclick="GetKodeK()" onkeyup="getCaNameK()" style="width:100%"  name="CA_IK" id="CA_IK"  class=" mb-2 cont-form" value="<%=ACCIK("CA_ID")%>">
</div>
<div class="col-5">
    <input type="text" onclick="GetKodeK()" onkeyup="getCaNameK()" style="width:100%"  name="CA_NameK" id="CA_NameK"  class=" mb-2 cont-form"  value="<%=ACCIK("CA_Name")%>">
</div>