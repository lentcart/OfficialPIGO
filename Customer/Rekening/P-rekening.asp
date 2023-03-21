<!--#include file="../../SecureString.asp" -->
<!--#include file="../../connections/pigoConn.asp"--> 

<% 
dim rkJenis, rkNamaBank, rkNomor, rkNamaPemilik, rkStatus

rkJenis = request.form("jenisrekening")
rkBankID = request.form("idBank")
rkNomor = request.form("norekening")
rkNamaPemilik = request.form("nama")

set rekeningbaru_CMD = server.CreateObject("ADODB.command")
rekeningbaru_CMD.activeConnection = MM_pigo_STRING

rekeningbaru_CMD.commandText = "exec sp_add_MKT_M_Rekening '"& rkBankID &"', "& rkNomor &", '"& rkNamaPemilik &"','"& rkJenis &"','"& request.Cookies("custID") &"','"& request.Cookies("custEmail") &"' "
'Response.Write rekeningbaru_CMD.commandText

rekeningbaru_CMD.execute

response.redirect("index.asp")

%> 