<!--#include file="../../connections/pigoConn.asp"-->

<% 
    merchantID = request.form("merchantID")
    channelId = request.form("channelId")
    crn = request.form("currency")
    transactionNo = request.form("transactionNo")
    transactionAmount = request.form("transactionAmount")
    transactionDate = request.form("transactionDate")
    transactionStatus = request.form("transactionStatus")
    transactionMessage = request.form("transactionMessage")
    flagType = request.form("flagType")
    paymentReffId = request.form("paymentReffId")
    authCode = request.form("authCode")
    
    set Transaksi_CMD = server.CreateObject("ADODB.command")
    Transaksi_CMD.activeConnection = MM_pigo_STRING
	
	response.ContentType = "application/json;charset=utf-8"
    
    Transaksi_CMD.commandText = "SELECT * FROM MKT_T_Transaksi_D WHERE trID_H  = '"& transactionNo &"' and trSubTotal = '"& transactionAmount &"' "
	'response.write Transaksi_CMD.commandText  & "<BR>"
    set tr = Transaksi_CMD.execute

        if tr.EOF =  true then 

            'Response.redirect "index.asp"
			%>
			{"status":"FAILED"}
			<%

        else

            set UpdateTr_CMD = server.CreateObject("ADODB.command")
            UpdateTr_CMD.activeConnection = MM_pigo_STRING

            UpdateTr_CMD.commandText = "UPDATE MKT_T_Transaksi_D SET tr_strID = '"& transactionStatus &"' WHERE trID_H = '"& transactionNo &"' AND trSubTotal = '"& transactionAmount &"' "
            'response.write UpdateTr_CMD.commandText  & "<BR>"
            set UpdateTr = UpdateTr_CMD.execute
			%>
			{"status":"OK"}
			<%

        end if

    
    
    
%>