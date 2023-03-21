<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    InvAPID = request.Form("InvAPID") 
    
    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING

    InvoiceVendor_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_InvoiceVendor_H] Where InvAPID =  '"& InvAPID &"' "
    'response.write InvoiceVendor_CMD.commandText &"<br><br>"
    set InvoiceVendorH = InvoiceVendor_CMD.execute
    InvoiceVendor_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_InvoiceVendor_D] Where InvAP_IDH =  '"& InvAPID &"' "
    'response.write InvoiceVendor_CMD.commandText &"<br><br>"
    set InvoiceVendorD = InvoiceVendor_CMD.execute
%> 