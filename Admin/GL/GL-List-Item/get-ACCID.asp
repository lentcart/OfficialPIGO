<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("ACC_ACID")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID = '"& CA_ID &"'"
    set ACCID = GL_M_ChartAccount_cmd.execute

%>
<div class="col-4">
    <span class="cont-text"> No ACC (Debet)</span><br>
</div>
<div class="col-3">
    <input type="text" onclick="GetKode()" onkeyup="getCaName()" style="width:100%"  name="CA_ID" id="CA_ID"  class=" mb-2 cont-form" value="<%=ACCID("CA_ID")%>">
</div>
<div class="col-5">
    <input type="text" onclick="GetKode()" onkeyup="getCaName()" style="width:100%"  name="CA_Name" id="CA_Name"  class=" mb-2 cont-form"  value="<%=ACCID("CA_Name")%>">
</div>