<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    prID_H = request.form("prID_H")
    pr_poID = request.form("poID")
    pr_mmID = request.form("mmID")
    pr_mmSubtotal = request.form("mm_pdSubtotal")
    mm_pdID = request.form("mm_pdID")

        set PaymentRequest_D_CMD = server.CreateObject("ADODB.command")
        PaymentRequest_D_CMD.activeConnection = MM_pigo_STRING
        PaymentRequest_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_PaymentRequest_D]([prID_H],[pr_poID],[pr_mmID],[pr_mmSubTotal],[prDUpdatetime],[prDAktifYN]) VALUES ('"& prID_H &"','"& pr_poID &"','"& pr_mmID &"','"& pr_mmSubtotal &"','"& now() &"', 'Y')"
        'response.write PaymentRequest_D_CMD.commandText
        set PaymentRequest_D = PaymentRequest_D_CMD.execute

        set UpdatePO_CMD = server.CreateObject("ADODB.command")
        UpdatePO_CMD.activeConnection = MM_pigo_STRING
        UpdatePO_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set po_prYN = 'Y' where po_pdID = '"& mm_pdID &"' and poID_H = '"& pr_poID &"' "
        'response.write UpdatePO_CMD.commandText
        set UpdatePO = UpdatePO_CMD.execute
        
        set UpdateMM_CMD = server.CreateObject("ADODB.command")
        UpdateMM_CMD.activeConnection = MM_pigo_STRING
        UpdateMM_CMD.commandText = "UPDATE MKT_T_MaterialReceipt_D2 set mm_prYN = 'Y' where mmID_D2 = '"& pr_mmID &"' and mm_pdID = '"& mm_pdID &"' "
        'response.write UpdateMM_CMD.commandText
        set UpdateMM = UpdateMM_CMD.execute


    

%>