<!--#include file="../../connections/pigoConn.asp"--> 

<%
	if request.Cookies("custEmail")="" then 
    response.redirect("../../")
    end if

    TransaksiID     = request.queryString("TransaksiID")
    custID          = request.queryString("custID")
    SellerID        = request.queryString("SellerID")

        set Transaksi_CMD = server.CreateObject("ADODB.command")
        Transaksi_CMD.activeConnection = MM_pigo_STRING

        Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_D1 set tr_strID = '03'  Where Left(trD1,12) = '"& TransaksiID &"' AND tr_slID = '"& SellerID &"' "
        set UpdateTransaksiD = Transaksi_CMD.execute

        Transaksi_CMD.commandText = "SELECT MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_H.tr_custID, MKT_T_Transaksi_H.trID, SUM(MKT_T_Transaksi_D1A.tr_pdHarga*MKT_T_Transaksi_D1A.tr_pdQty) AS amount FROM MKT_T_Transaksi_D1 RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A WHERE MKT_T_Transaksi_H.trID = '"& TransaksiID &"' AND MKT_T_Transaksi_D1.tr_slID = '"& SellerID &"' AND tr_strID = '03' GROUP BY MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_H.tr_custID, MKT_T_Transaksi_H.trID"
        set TransaksiSeller = Transaksi_CMD.execute

        Transaksi_CMD.commandText = "SELECT ISNULL(MAX(Wall_Saldo),0) AS SisaSaldo FROM MKT_T_SaldoSeller WHERE Wall_SellerID = '"& SellerID &"'"
        set Saldo = Transaksi_CMD.execute

        JumlahSaldo = Saldo("SisaSaldo")+TransaksiSeller("amount")
        Deskripsi   = "Penghasilan dari Pesanan #"& TransaksiID

        Transaksi_CMD.commandText = "exec sp_add_MKT_T_SaldoSeller '"& Date() &"','01','"& SellerID &"','"& custID &"','"& TransaksiID &"','"& Deskripsi &"', '"& TransaksiSeller("amount") &"','"& JumlahSaldo &"','W', 'N', 'N',0,'-'"
        set SaldoSeller = Transaksi_CMD.execute

    
%>