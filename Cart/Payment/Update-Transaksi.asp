<!--#include file="../../connections/pigoConn.asp"-->
<%
        external_id = request.queryString("external_id")
        JenisPay    = request.queryString("JenisPay")
        BankCode    = request.queryString("BankCode")
        PayStatus   = request.queryString("PayStatus")
        PaidAt      = request.queryString("PaidAt")
        BookingID   = request.queryString("BookingID")
        
        set Transaksi_CMD = server.CreateObject("ADODB.command")
        Transaksi_CMD.activeConnection = MM_pigo_STRING

        if PayStatus = "EXPIRED" then
            PembayaranYN    = "X"
            StatusTransaksi = "04"
            StatusPembayaran = "03"

            Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_H set trJenisPembayaran = '"& JenisPay &"' ,  trPembayaranYN = '"& PembayaranYN &"', tr_spID = '"& StatusPembayaran &"', tr_BankCode = '"& BankCode &"', tr_StatusPayment = '"& PayStatus &"', tr_PaidAt = '"& PaidAt &"' Where trID = '"& external_id &"'"
            'response.write Transaksi_CMD.commandText &"<br><br>"
            set UpdateTransaksiH = Transaksi_CMD.execute

            Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_D1 set tr_IDBooking = '"& BookingID &"', tr_strID = '"& StatusTransaksi &"' Where Left(trD1,12) = '"& external_id &"' "
            'response.write Transaksi_CMD.commandText &"<br><br>"
            set UpdateTransaksiD = Transaksi_CMD.execute

        else

            Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_H set trJenisPembayaran = '"& JenisPay &"' ,  trPembayaranYN = 'Y', tr_spID = '02', tr_BankCode = '"& BankCode &"', tr_StatusPayment = '"& PayStatus &"', tr_PaidAt = '"& PaidAt &"' Where trID = '"& external_id &"'"
            'response.write Transaksi_CMD.commandText &"<br><br>"
            set UpdateTransaksiH = Transaksi_CMD.execute

            Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_D1 set tr_IDBooking = '"& BookingID &"', tr_strID = '01'  Where Left(trD1,12) = '"& external_id &"' "
            'response.write Transaksi_CMD.commandText &"<br><br>"
            set UpdateTransaksiD = Transaksi_CMD.execute
        end if 
%>