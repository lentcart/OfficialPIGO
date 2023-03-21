<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    CA_IK = request.queryString("AC_IK")
    ' ItemList = request.queryString("ItemID")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        ' GL_M_ChartAccount_cmd.commandText = "SELECT Item_ID FROM GL_M_Item where Item_ID = '"& ItemList &"' "
        'response.Write GL_M_ChartAccount_cmd.commandText
    ' set ItemList = GL_M_ChartAccount_cmd.execute
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID = '"& CA_IK &"'  "
        'response.Write GL_M_ChartAccount_cmd.commandText
    set ACCID = GL_M_ChartAccount_cmd.execute

%>
<div class="col-4">
    <input onclick="OpenK()" onkeyup="getListACIK()" type="text" style="width:100%"  class="mb-1 cont-form" name="ACIK" id="ACIK" value="<%=ACCID("CA_ID")%>">
</div>
<div class="col-8">
    <input onclick="OpenK()" onkeyup="getListACIK()" type="text" style="width:100%"  class="mb-1 cont-form" name="NameACIK" id="NameACIK" value="<%=ACCID("CA_Name")%>">
</div>