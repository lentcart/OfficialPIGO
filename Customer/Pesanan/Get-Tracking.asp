<!--#include file="../../connections/pigoConn.asp"-->
<!--#INCLUDE file="../../aspJSON.asp" -->
<%
        TransaksiID = "TR0802230002"
        CustomerID  = "C0322000000001"
        SellerID    = "C0322000000002"

        set Transaksi_CMD = server.createObject("ADODB.COMMAND")
        Transaksi_CMD.activeConnection = MM_PIGO_String

        Transaksi_CMD.commandText = "SELECT MKT_T_Transaksi_D1.tr_IDBooking, MKT_T_Transaksi_H.trUpdateTime, MKT_T_StatusTransaksi.strName FROM MKT_T_Transaksi_D1 RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID Where trID = 'TR0802230002' AND tr_custID = 'C0322000000001' AND tr_slID = 'C0322000000002'" 
        'response.write Transaksi_CMD.commandText
        set Transaksi = Transaksi_CMD.execute

        if Transaksi("tr_IDBooking") = "" then

            Response.Write "["
                Response.Write "{"
                    Response.Write """UpdateTime""" & ":" & """" & Transaksi("trUpdateTime") & """" & "," 
                    Response.Write """Status""" & ":" & """Pesanan Dibuat"""  & "," 
                    Response.Write """Keterangan""" & ":" & """ """  
                Response.Write "}"
            Response.Write "]" 

        else

            Response.Write "["
                Response.Write "{"
                    Response.Write """UpdateTime""" & ":" & """" & Transaksi("trUpdateTime") & """" & ","
                    Response.Write """Status""" & ":" & """Pesanan Dibuat""" & "," 
                    Response.Write """Keterangan""" & ":" & """Pengirim telah mengatur pengiriman. Menunggu paket diserahkan ke pihak jasa kirim."""    
                Response.Write "}"
            Response.Write "]"

            Dim objHttp
            Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

            Dim url, payload
            url = "http://103.111.190.162/dbs/customerapps/orderBooking/history/?b="& Transaksi("tr_IDBooking")&""

            objHttp.Open "GET", url, False
            objHttp.setRequestHeader "Content-Type", "application/json"
            objHttp.send payload

            strReturn = objHTTP.responseText
            response.write strReturn
            

        end if

        
%>