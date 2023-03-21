
<!--#include file="../SecureString.asp" -->
<!--#include file="../connections/pigoConn.asp"--> 
<!--#include file="../md5.asp"--> 
<% 
	custID = request.form("custID")
	custEmail = request.form("email")
	custPassword = request.form("password")
	custPhone1 = request.form("phone1")
	VerifCode = request.form("VerifCode")

	set Customer_CMD = server.CreateObject("ADODB.command")
	Customer_CMD.activeConnection = MM_pigo_STRING

	customer_CMD.commandText = "Update MKT_M_Customer set custNama = '"& custNama &"', custEmail =  '"& custEmail &"', custPassword = '"& custPassword &"', custPhone1 = '"& custPhone1 &"', custPhone2 = '"& custPhone2 &"', custPhone3 = '"& custPhone3 &"', custJk = '"& custjk &"', custTglLahir =  '"& custTglLahir &"', custRekening = '"& custRekening &"', custStatus = '"& custStatus &"', custRating = '0', custPoinReward = '0' where custID = '"& custID &"' "
	'response.write customer_CMD.commandText & "<BR>"
    set customer = customer_CMD.execute

		custID = request.form("custID")
		Dim UserIPAddress
		UserIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
		If UserIPAddress = "" Then
		UserIPAddress = Request.ServerVariables("REMOTE_ADDR")
		End If

		set Verifikasi_CMD = server.CreateObject("ADODB.command")
			Verifikasi_CMD.activeConnection = MM_pigo_STRING
		validUntil = DateAdd("d",3, now())
		validUntil = month(validUntil) & "/" & day(validUntil) & "/" & year(validUntil) & " " & hour(validUntil) & ":" & minute(validUntil) & ":00"

		sekarang = month(now()) & "/" & day(now()) & "/" & year(now()) & " " & hour(now()) & ":" & minute(now()) & ":00"

		if verifCode = "" then
			custID = request.form("custID")
			
			verifCode =  md5(custID & now())
			Verifikasi_CMD.commandText = "exec sp_GLB_T_Verifikasi '"& custID &"','"& verifCode &"','"&  validUntil &"','"& UserIPAddress &"','"& sekarang &"' "
			'Response.Write Verifikasi_CMD.commandText
			set verifikasi = verifikasi_CMD.execute

		else
			Verifikasi_CMD.commandText = "update GLB_T_Verifikasi set verifCode = '"& verifCode &"', validUntil = '"& validUntil &"', ipAddr = '"& UserIPAddress &"', validUpdateTime = '"& sekarang &"' where custID_H = '"& custID &"' "
			'Response.Write Verifikasi_CMD.commandText
			set verifikasi = verifikasi_CMD.execute

		end if

		verif = verifCode
		Set Mail = CreateObject("CDO.Message")

		Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2

		Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="mail.otopigo.com"
		Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465

		Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = 1
		Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60

		Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
		Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") ="official@otopigo.com" 
		Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") ="otopigo00001"

		Mail.Configuration.Fields.Update

		
		Mail.Subject="Verifikasi Customer baru PIGO"
		Mail.From="officialpigo@gmail.com"
		Mail.To= custEmail
		'Mail.Bcc="someoneelse@somedomain.com" 'Carbon Copy



		Mail.HTMLBody="<table border=0 width=640 style=margin:auto;border-collapse:collapse;font-size:12px;font-family:Arial,Helvetica,sans-serif;>"&_
				"<tr >"&_
					"<td colspan=2 align=left>"&_
							"<img src=http://www.otopigo.com/assets/logo/3.png width=100 height=120>"&_
							"<br />"&_
					"</td>"&_
				"</tr>"&_
				"<tr>"&_
						"<td colspan=2 align=center style=background-color:gainsboro;padding:10px;>"&_
							"Yth, Pelanggan <b>Official PIGO</b> <br />"&_
							"Terima kasih sudah menjadi member kami. Untuk melanjutkan proses, jangan lupa verifikasi dengan mengklik tombol verifikasi di bawah  : "&_
						"</td>"&_
				"</tr>"&_
				"<tr>"&_
					"<td  colspan=2 align=center >"&_
						
						"<h2>"&_
							"<a href=http://www.otopigo.com/verifikasi/?b="& verif &" style=text-decoration:none;color:white;padding:10px;background-color:#0dcaf0;> VERIFIKASI SEKARANG </a>"&_
						"</h2>"&_
					"</td>"&_
				"</tr>"&_
				
				"<tr style=font-size:11px;background-color:#0dcaf0;color:white; >"&_
					"<td width=50% style=padding:10px;>"&_
						"Ditunggu ya <br />"&_
						"Jangan lupa selalu kunjungi website kami di http://www.otopigo.com/"&_
					"</td>"&_
					"<td width=50% align=right style=padding:10px;>"&_
						
						"PT. PIGO <br />"&_
						"informasi : cs@pigo.com"&_

					"</td>"&_
						
				"</tr>"&_
				"<tr>"&_
					"<td style=padding:10px;font-size:8px; align=center>"&_
						"Email ini dikirim secara otomatis, mohon untuk tidak membalas email ini"&_
					"</td>"&_
				"</tr>"&_
			"</table>"

		Mail.Send
		Set Mail = Nothing


	
	response.redirect "../Register/RegisterSuccess.asp"
 %> 