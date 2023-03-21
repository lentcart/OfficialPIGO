<!--#include file="../../../connections/pigoConn.asp"--> 

<%
    TransaksiID     = request.queryString("TransaksiID")
    SellerID        = request.queryString("SellerID")
    Amount          = request.queryString("Amount")

        set Transaksi_CMD = server.CreateObject("ADODB.command")
        Transaksi_CMD.activeConnection = MM_pigo_STRING

        Transaksi_CMD.commandText = "UPDATE MKT_T_SaldoSeller set Wall_Status = 'C', Wall_KonfYN = 'Y' Where Wall_SellerID = '"& SellerID &"' AND Wall_TrID = '"& TransaksiID &"' AND Wall_Amount = '"& Amount &"' "
        set UpdateSaldoSeller = Transaksi_CMD.execute

    
%>