<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    InvAPID    = request.queryString("InvAPID")

    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING
    InvoiceVendor_CMD.commandText = "SELECT MKT_T_InvoiceVendor_D.InvAP_Line FROM MKT_T_InvoiceVendor_D1 RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_InvoiceVendor_D1.InvAP_DLine = MKT_T_InvoiceVendor_D.InvAP_Line RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID WHERE (MKT_T_InvoiceVendor_H.InvAPID = '"& InvAPID &"') GROUP BY MKT_T_InvoiceVendor_D.InvAP_Line "
    set InvoiceVendor = InvoiceVendor_CMD.execute

    InvoiceVendor_CMD.commandText = "DELETE FROM [pigo].[dbo].[MKT_T_InvoiceVendor_D] WHERE InvAP_Line = '"& InvoiceVendor("InvAP_Line") &"' "
    set InvoiceVendorD = InvoiceVendor_CMD.execute
    InvoiceVendor_CMD.commandText = "DELETE FROM [pigo].[dbo].[MKT_T_InvoiceVendor_D1] WHERE InvAP_DLine = '"& InvoiceVendor("InvAP_Line") &"' "
    set InvoiceVendorD1 = InvoiceVendor_CMD.execute
    InvoiceVendor_CMD.commandText = "DELETE FROM [pigo].[dbo].[MKT_T_InvoiceVendor_H] WHERE InvAPID = '"& InvAPID &"' "
    set InvoiceVendorH = InvoiceVendor_CMD.execute

%>