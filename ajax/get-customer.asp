<!--#include file="../Connections/pigoConn.asp" -->
<%

    set Customer_cmd = server.createObject("ADODB.COMMAND")
	Customer_cmd.activeConnection = MM_PIGO_String
			
	Customer_cmd.commandText = "SELECT dbo.MKT_M_Customer.custID, dbo.MKT_M_Customer.custNama, dbo.MKT_M_Customer.custEmail FROM dbo.MKT_M_Customer LEFT OUTER JOIN dbo.MKT_T_Pesanan ON dbo.MKT_M_Customer.custID = dbo.MKT_T_Pesanan.ps_custID LEFT OUTER JOIN dbo.MKT_M_Customer AS MKT_M_Customer_1 ON dbo.MKT_T_Pesanan.ps_pdCustID = MKT_M_Customer_1.custID LEFT OUTER JOIN dbo.MKT_M_Seller ON MKT_M_Customer_1.custID = dbo.MKT_M_Seller.sl_custID where dbo.MKT_T_Pesanan.ps_pdCustID ='"& request.Cookies("custID") &"' " 
	set Customer = Customer_cmd.execute


%>
<%do while not Customer.eof%>
    <input class="" type="checkbox" name="checkbox-custid" id="<%=Customer("custID")%>" value="<%=Customer("custID")%>" onchange="checkcust<%=Customer("custID")%>(this,<%=Customer("custID")%>)">
    <span class="text-updatealamat"  style="font-size:12px"><%=Customer("custEmail")%></span><br>
<%Customer.movenext
loop%>

