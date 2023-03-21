<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    InvAP_IDH = request.Form("InvAP_IDH") 
    InvAP_GrandTotal = request.Form("InvAP_GrandTotal") 
    
    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING

    InvoiceVendor_CMD.commandText = " UPDATE MKT_T_InvoiceVendor_H set InvAP_GrandTotal = '"& InvAP_GrandTotal &"' Where InvAPID = '"& InvAP_IDH &"'  "
    'response.write InvoiceVendor_CMD.commandText &"<br><br>"
    set InvoiceVendorH = InvoiceVendor_CMD.execute
%> 