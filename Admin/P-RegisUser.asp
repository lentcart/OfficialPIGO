
<!--#include file="../SecureString.asp" -->
<!--#include file="../connections/pigoConn.asp"--> 
<!--#include file="../md5.asp"--> 
<% 
	userName = request.form("userName")
	userPassword = md5(request.form("password"))
	userBagian = request.form("userBagian")

	set User_CMD = server.CreateObject("ADODB.command")
	User_CMD.activeConnection = MM_pigo_STRING

	User_CMD.commandText = "exec sp_add_MKT_M_User '"& userName &"', '"& userPassword &"', '"& userBagian &"' "
	'response.write User_CMD.commandText & "<BR>"
    set User = User_CMD.execute

	if User("id") = "DataExists" then 
		response.write "Data Sudah Ada"
	else 

	' response.redirect "loginuser.asp"
    
    end if
 %> 