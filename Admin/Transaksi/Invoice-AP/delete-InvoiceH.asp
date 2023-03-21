<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    InvAPID = request.queryString("InvAPID") 
    
    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING

    InvoiceVendor_CMD.commandText = "SELECT InvAP_Line FROM MKT_T_InvoiceVendor_D WHERE InvAP_IDH =  '"& InvAPID &"' GROUP BY InvAP_Line "
    set InvoiceVendorD1 = InvoiceVendor_CMD.execute

    InvoiceVendor_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_InvoiceVendor_D1] Where InvAP_DLine =  '"& InvoiceVendorD1("InvAP_Line") &"' "
    set InvoiceVendorD1A = InvoiceVendor_CMD.execute

    InvoiceVendor_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_InvoiceVendor_H] Where InvAPID =  '"& InvAPID &"' "
    set InvoiceVendorH = InvoiceVendor_CMD.execute

    InvoiceVendor_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_InvoiceVendor_D] Where InvAP_IDH =  '"& InvAPID &"' "
    set InvoiceVendorD = InvoiceVendor_CMD.execute

%> 