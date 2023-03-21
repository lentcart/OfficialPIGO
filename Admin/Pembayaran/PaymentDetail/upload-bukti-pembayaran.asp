<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    payID	        = Request.Form("payID")
    payBukti	    = Request.Form("payBukti")
    
    set Payment_CMD = server.CreateObject("ADODB.command")
    Payment_CMD.activeConnection = MM_pigo_STRING
    Payment_CMD.commandText = "UPDATE MKT_T_Payment_H set payBukti = '"& payBukti &"' Where payID = '"& payID &"'  "
    ' response.write Payment_CMD.commandText
    set Payment = Payment_CMD.execute

%>