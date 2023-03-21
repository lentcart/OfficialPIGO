<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    pscID_H = request.queryString("pscID_H")        
    pdID = request.queryString("pdID")        
    pdHarga = request.queryString("pdHarga")
    pdQty = request.queryString("pdQty")
    pdUnit = request.queryString("pdUnit")
    pdSubtotal = request.queryString("pdSubtotal")
    
    

    set PurchaseOrder_D_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_D_CMD.activeConnection = MM_pigo_STRING
    PurchaseOrder_D_CMD.commandText = " INSERT INTO [dbo].[MKT_T_PengeluaranSC_D2]([pscD2_H],[pscD2_pdID],[pscD2_pdHarga],[pscD2_pdQty],[pscD2_pdUnit],[pscD2_pdSubtotal],[pscD2UpdateTime],[pscD2AktifYN]) VALUES ('"& pscID_H &"','"& pdID &"','"& pdHarga &"','"& pdQty &"','"& pdUnit &"','"& pdSubtotal &"','"& now() &"','Y')"
    
    response.write PurchaseOrder_D_CMD.commandText
    set PurchaseOrder_D = PurchaseOrder_D_CMD.execute


%>