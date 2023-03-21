<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    poID = request.queryString("poID") 
    
    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_PurchaseOrder_D.poID_H),0) as ID FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE poID_H = '"& poID &"' "
        'response.write PurchaseOrder_cmd.commandText

    set PurchaseOrder = PurchaseOrder_cmd.execute
%> 
<br>
<input type="hidden" name="jumlahpoid" id="jumlahpoid" value="<%=PurchaseOrder("ID")%>">
<button onclick="konfirmasipo()"class=" btn-addpo cont-btn"> Konfirmasi Status PO </button>