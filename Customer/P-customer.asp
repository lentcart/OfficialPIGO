<!--#include file="../SecureString.asp" -->
<!--#include file="../connections/pigoConn.asp"--> 

<% 
dim custNama, custEmail, custPhone1, custPhone2, custPhone3, custJk, custTglLahir, custNamaToko

custNama = request.form("namalengkap")
custEmail = request.form("email")
custPhone1 = request.form("phone1")
custPhone2 = request.form("phone2")
custPhone3 = request.form("phone3")
custJk = request.form("jk")
custTglLahir = request.form("tgllahir")
slName = request.form("namaseller")


set Customer_CMD = server.CreateObject("ADODB.command")
Customer_CMD.activeConnection = MM_pigo_STRING

customer_CMD.commandText = "update MKT_M_Customer set custNama = '"& custNama &"', custEmail ='"& custEmail &"',  custPhone1 ='"& custPhone1 &"',  custPhone2 ='"& custPhone2 &"',  custPhone3 ='"& custPhone3 &"', custJk ='"& custJk &"', custTglLahir ='"& custTglLahir &"' where custID ='"& request.cookies("custID") &"' "
'Response.Write Customer_CMD.commandText
set cust = Customer_CMD.execute

set updatesl_CMD = server.CreateObject("ADODB.command")
updatesl_CMD.activeConnection = MM_pigo_STRING

    updatesl_CMD.commandText = "update MKT_M_Seller set slName = '"& slName &"'  where sl_custID = '"& request.cookies("custID") &"' "
    'response.write updatesl_CMD.commandText
    set updatesl = updatesl_CMD.execute

response.redirect("index.asp")

%> 