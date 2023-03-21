<!--#include file="../SecureString.asp" -->
<!--#include file="../connections/pigoConn.asp"--> 

<% 
dim almNamaPenerima, almPhonePenerima, almLabel, almProvinsi, almKota, almKec, almKel, almKdpos, almLengkap, almDetail

almNamaPenerima = request.form("namapenerima")
almPhonePenerima = request.form("phonepenerima")
'response.write(almPhonePenerima)
almLabel = request.form("labelalamat")
almProvinsi = request.form("provinsi")
almKota = request.form("kota")
almKec = request.form("kecamatan")
almKel = request.form("kelurahan")
almKdpos = request.form("kodepos")
almKdpos = request.form("kodepos")
almLengkap = request.form("alamatlengkap")
almDetail = request.form("detailalamat")



set Alamatbaru_CMD = server.CreateObject("ADODB.command")
Alamatbaru_CMD.activeConnection = MM_pigo_STRING

Alamatbaru_CMD.commandText = "exec sp_add_MKT_M_Alamat '"& almNamaPenerima &"', '"& almPhonePenerima &"', '"& almLabel &"', '"& almProvinsi &"', '"& almKota &"', '"& almKec &"', '"& almKel &"', '"& almKdpos &"', '"& almLengkap &"', '"& almDetail &"','"& session("custID") &"','"& session("custEmail") &"' "
'Response.Write Alamatbaru_CMD.commandText

Alamatbaru_CMD.execute

if Alamatbaru.EOF = false then 
        session("almID")=Alamatbaru("almID")
        session("almNamaPenerima")=Alamatbaru("almNamaPenerima")
        session("almPhonePenerima")=Alamatbaru("almPhonePenerima")
        session("almLabel")=Alamatbaru("almLabel")
        session("almProvinsi")=Alamatbaru("almProvinsi")
        session("almKota")=Alamatbaru("almKota")
        session("almKec")=Alamatbaru("almKec")
        session("almKel")=Alamatbaru("almKel")
        session("almKdpos")=Alamatbaru("almKdpos")
        session("almLengkap")=Alamatbaru("almLengkap")
        session("almDetail")=Alamatbaru("almDetail")

        response.redirect("../Customer/")
        


%> 