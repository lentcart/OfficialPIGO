<!--#include file="../../SecureString.asp" -->
<!--#include file="../../connections/pigoConn.asp"--> 

<% 
        dim almNamaPenerima, almPhonePenerima, almLabel, almProvinsi, almKota, almKec, almKel, almKdpos, almLengkap, almDetail, almJenis, almLatt, almLong

        almNamaPenerima = request.form("namapenerima")
        almPhonePenerima = request.form("phonepenerima")
        almLabel = request.form("labelalamat")
        almProvinsi = request.form("provinsi")
        almKota = request.form("kab")
        almKec = request.form("kec")
        almKel = request.form("kel")
        almKdpos = request.form("kdpos")
        almLengkap = request.form("alamatlengkap")
        almDetail = request.form("detailalamat")
        almJenis = request.form("jenisalamat")
        almLatt = request.form("lat")
        almLong = request.form("lon")
        
        set Alamatbaru_CMD = server.CreateObject("ADODB.command")
        Alamatbaru_CMD.activeConnection = MM_pigo_STRING

        Alamatbaru_CMD.commandText = "exec sp_add_MKT_M_Alamat '"& almNamaPenerima &"', '"& almPhonePenerima &"', '"& almLabel &"', '"& almProvinsi &"', '"& almKota &"', '"& almKec &"', '"& almKel &"', '"& almKdpos &"', '"& almLengkap &"', '"& almDetail &"','"& almJenis &"',"& almLatt &","& almlong &",'"& request.Cookies("custID") &"','"& request.Cookies("custEmail") &"' "
        'Response.Write Alamatbaru_CMD.commandText
        set Alamat = Alamatbaru_CMD.execute

        almJenis = request.form("jenisalamat")
        if almJenis = "Alamat Toko" then

        slName = request.form("slName")
        sl_almID = request.form("alamatseller")
        slVerified = request.form("slVerified")
        slAktifYN = request.form("slAktifYN")

        set almSeller_CMD = server.CreateObject("ADODB.command")
        almSeller_CMD.activeConnection = MM_pigo_STRING

        almSeller_CMD.commandText = "INSERT INTO [dbo].[MKT_M_Seller]([sl_custID],[sl_almID],[slName],[slVerified],[slAktifYN]) VALUES ('"& request.Cookies("custID") &"','"& Alamat("id") &"','"& slname &"','"& slVerified &"','"& slAktifYN &"')"
        'Response.Write almSeller_CMD.commandText
        almSeller_CMD.execute

        almSeller_CMD.commandText = "Delete From MKT_M_Seller where sl_almID = '' where sl_custID = '"& request.Cookies("custID") &"' "
        Response.Write almSeller_CMD.commandText
        almSeller_CMD.execute

        else

        response.redirect("index.asp")

        end if

        response.redirect("index.asp")
%> 