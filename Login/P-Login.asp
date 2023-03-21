<!--#include file="../SecureString.asp" -->
<!--#include file="../connections/pigoConn.asp"--> 
<!--#include file="../md5.asp" -->

<% 
dim custEmail, custPassword, salahlagi
salah = request.form("jumlahsalah")

custEmail = request.form("email")
custPassword = md5(request.form("password"))


set Login_CMD = server.CreateObject("ADODB.command")
Login_CMD.activeConnection = MM_pigo_STRING

    Login_CMD.commandText = "select * from MKT_M_Customer where custEmail  = '"& custEmail &"' "
	response.write Login_CMD.commandText  & "<BR>"
    set loginn = Login_CMD.execute

        if loginn.EOF = false then 
            if Loginn("custPassword") <> custPassword then
                salahlagi = salah + 1
                Response.redirect "index.asp?err=XGrty6579GR-GDgfgIH76&a="& salahlagi

            end if

            if Loginn("custVerified") = "N" then
                custEmail = loginn("custEmail")
                Response.Cookies("custEmail")=custEmail
                Response.redirect "Verifikasi.asp"
            end if

                custID = loginn("custID")
                Response.Cookies("custID")=custID
                custNama = loginn("custNama")
                Response.Cookies("custNama")=custNama
                custEmail = loginn("custEmail")
                Response.Cookies("custEmail")=custEmail
                custPoinReward = loginn("custPoinReward")
                Response.Cookies("custPoinReward")=custPoinReward

                Response.redirect "../"
        else
			Response.redirect "index.asp?e=XetrSHu1073H-D798hHki10KIH76"
        end if


%> 