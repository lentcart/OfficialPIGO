<!--#include file="connections/pigoConn.asp"-->   


<%

	set Customer_CMD = server.CreateObject("ADODB.command")
	Customer_CMD.activeConnection = MM_pigo_STRING
	
	customer_CMD.commandText = "select * from MKT_M_Customer"
	
	set rsCustomer = customer_CMD.execute
	
	
	do while not rsCustomer.eof
	
	response.write rsCustomer("custNama") & "<BR>"
	
	
	rsCustomer.movenext
	loop
	

%>