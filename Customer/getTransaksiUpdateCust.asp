<!--#include file="../connections/pigoConn.asp"--> 
<!--#INCLUDE file="../aspJSON.asp" -->
<%

    ' Cek Transaksi ( Status Pembayaran - N ) 

        set Transaksi_H_CMD = server.CreateObject("ADODB.command")
        Transaksi_H_CMD.activeConnection = MM_pigo_STRING

        Transaksi_H_CMD.commandText = "SELECT  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trPembayaranYN, MKT_T_Transaksi_D1.tr_IDBooking FROM MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1,12) WHERE trPembayaranYN = 'N' AND tr_custID = '"& request.cookies("custID") &"'"
        'response.Write Transaksi_H_CMD.commandText & "<br>"
        set Transaksi = Transaksi_H_CMD.execute 
        
    do while not Transaksi.eof

        Dim objHttp
        Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim url, payload
        url = "https://api.xendit.co/v2/invoices/?external_id="& Transaksi("trID") &""
        objHttp.Open "GET", url, False
        objHttp.setRequestHeader "Content-Type", "application/json"
        objHttp.setRequestHeader "Authorization", "Basic eG5kX2RldmVsb3BtZW50X2p3NzllSVVBTWQwTEdjd1B4S1hDcVdtZU1rVnpnZndJSlQzMlJMTUlvWTFvUjVWTkdqeEFsdmpOWkNHZmxDZDo"
        objHttp.send payload
        strReturn = objHTTP.responseText
        'response.Write strReturn & "<br>"

        Set oJSON = New aspJSON
        oJSON.loadJSON(strReturn)

        For Each result In oJSON.data

            Set this = oJSON.data.item(data)

            id = this.item("id")
            JenisPay  = this.item("payment_method")
            BankCode  = this.item("bank_code")
            PayStatus = this.item("status")
            PaidAt    = this.item("paid_at")
            'response.Write PayStatus & "<br>"
            
            if PayStatus = "SETTLED" then 

                set Transaksi_CMD = server.CreateObject("ADODB.command")
                Transaksi_CMD.activeConnection = MM_pigo_STRING

                Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_H set trJenisPembayaran = '"& JenisPay &"' ,  trPembayaranYN = 'Y', tr_spID = '02', tr_BankCode = '"& BankCode &"', tr_StatusPayment = '"& PayStatus &"', tr_PaidAt = '"& PaidAt &"' Where trID = '"& Transaksi("trID") &"'"
                'response.write Transaksi_CMD.commandText &"<br><br>"
                set UpdateTransaksiH = Transaksi_CMD.execute

                Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_D1 set tr_strID = '01' Where Left(trD1,12) = '"& Transaksi("trID") &"' "
                'response.write Transaksi_CMD.commandText &"<br><br>"
                set UpdateTransaksiD = Transaksi_CMD.execute

            else if PayStatus = "EXPIRED" then
        
                set Transaksi_CMD = server.CreateObject("ADODB.command")
                Transaksi_CMD.activeConnection = MM_pigo_STRING

                PembayaranYN        = "X"
                StatusTransaksi     = "04"
                StatusPembayaran    = "03"

                Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_H set trJenisPembayaran = '-' ,  trPembayaranYN = '"& PembayaranYN &"', tr_spID = '"& StatusPembayaran &"', tr_BankCode = '-', tr_StatusPayment = '-', tr_PaidAt = '' Where trID = '"& Transaksi("trID") &"'"
                'response.write Transaksi_CMD.commandText &"<br><br>"
                set UpdateTransaksiH = Transaksi_CMD.execute

                Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_D1 set tr_IDBooking = '-', tr_strID = '"& StatusTransaksi &"' Where Left(trD1,12) = '"& Transaksi("trID") &"' "
                'response.write Transaksi_CMD.commandText &"<br><br>"
                set UpdateTransaksiD = Transaksi_CMD.execute

            end if  end if 

        Next

    Transaksi.movenext
    loop
%>

