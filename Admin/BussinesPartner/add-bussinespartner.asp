<!--#include file="../../Connections/pigoConn.asp" -->
<!--#include file="../../UpdateLOG/UpdateLOG.asp"-->

<%
    custNama            = request.form("custNama")
    custDesc            = request.form("deskripsi")
    custStatusKr        = request.form("statuskredit")
    custStatusTax       = request.form("statustax")
    custPartnerG        = request.form("group")
    custNpwp            = request.form("npwp")
    custAlamatNpwp      = request.form("alamatnpwp")
    custPembayaran      = request.form("jpembayaran")
    custTransaksi       = request.form("jtransaksi")
    custPaymentTerm     = request.form("jangkawaktu")
    custAlamat          = request.form("alamatlengkap")
    custProv            = request.form("provinsi")
    custKab             = request.form("kab")
    custPhone1          = request.form("phone1")
    custPhone2          = request.form("phone2")
    custFax             = request.form("fax")
    custEmail           = request.form("emailpr")
    custWilayah         = request.form("wpenjualan")
    custBankID          = request.form("idbank")
    custNoRekening      = request.form("norekening")
    custPemilikRek      = request.form("pemilikrek")
    custNamaCP          = request.form("namacp")
    custPhoneCP         = request.form("phonecp")
    custEmailCP         = request.form("emailcp")
    custJabatanCP       = request.form("jabatancp")
    custAlamatCP        = request.form("alamatcp")
    
    
    set BussinesPartner_CMD = server.CreateObject("ADODB.command")
    BussinesPartner_CMD.activeConnection = MM_pigo_STRING

    BussinesPartner_CMD.commandText = " exec sp_add_MKT_M_Customer '"& custNama &"','"& custEmail &"','','"& custPhone1 &"','"& custPhone2 &"','','','','','',0,0,'"& now() &"','N','','"& custFax &"','"& custNpwp &"','"& custAlamatNpwp &"','"& custWilayah &"','"& custDesc &"',"& custStatusKr &",'"& custStatusTax &"','"& custPartnerG &"',"& custPembayaran &","& custTransaksi &","& custPaymentTerm &",'"& custNamaCP &"','"& custPhoneCP &"','"& custEmailCP &"','"& custJabatanCP &"','"& custAlamatCP &"','N','"& session("username") &"' "
    'response.write BussinesPartner_CMD.commandText & "<br><br><br>"
    set Customer = BussinesPartner_CMD.execute

    if Customer("id") = "DataExists" then 

		BussinesPartner_CMD.commandText = " UPDATE MKT_M_Customer set custFax = '"& custFax &"', custNPWP = '"& custNPWP &"' , custWilayah = '"& custWilayah &"', custDesc = '"& custDesc &"', custStatusKredit = '"& custStatusKr &"', custStatusTax = '"& custStatusTax &"', custPartnerGroup = '"& custPartnerG &"', custPembayaran = '"& custPembayaran &"', custTransaksi = '"& custTransaksi &"', custPaymentTerm = '"& custPaymentTerm &"', custNamaCP = '"& custNamaCP &"', custPhoneCP = '"& custPhoneCP &"', custEmailCP = '"& custEmailCP &"', custJabatanCP = '"& custJabatanCP &"', custAlamatCP = '"& custAlamatCP &"', custUpdateTime = '"& now() &"', custUpdateID = '"& session("username") &"' WHERE custID = '"& Customer("id") &"' AND custEmail = '"& custEmail &"'  "
        'response.write BussinesPartner_CMD.commandText & "<br><br><br>"
        set Customer = BussinesPartner_CMD.execute

	else

    BussinesPartner_CMD.commandText = "exec sp_add_MKT_M_Alamat '"& custNama &"','"& custPhone1 &"', '', '"& custProv &"', '"& custKab &"', '', '', '', '"& custAlamat &"','','Alamat BS',0,0,'"& Customer("id") &"','"& custEmail &"' "
    'response.write BussinesPartner_CMD.commandText & "<br><br><br>"
    set Alamat = BussinesPartner_CMD.execute

    BussinesPartner_CMD.commandText = "exec sp_add_MKT_M_Rekening '"& custBankID &"', "& custNoRekening &", '"& custPemilikRek &"','Rekening Customer','1','"& Customer("id") &"','"& custEmail &"' "
    'response.write BussinesPartner_CMD.commandText & "<br><br><br>"
    set Rekening = BussinesPartner_CMD.execute

    

    Log_ServerID 	= "" 
    Log_Action   	= "CREATE"
    Log_Key         = Customer("id")
    Log_Keterangan  = "Tambah bussines partner baru dengan ID : ("& Customer("id") &") diproses pada "& DATE() &""
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    Log_ServerID 	= "" 
    Log_Action   	= "CREATE"
    Log_Key         = Alamat("id")
    Log_Keterangan  = "Tambah ID alamat ("& Alamat("id") &") baru berdasarkan bussines partner ("& Customer("id") &") diproses pada "& DATE() &""
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)
    
    Log_ServerID 	= "" 
    Log_Action   	= "CREATE"
    Log_Key         = Rekening("id")
    Log_Keterangan  = "Tambah ID rekening ("& Rekening("id") &") baru berdasarkan bussines partner ("& Customer("id") &") diproses pada "& DATE() &""
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    response.redirect "index.asp"
    
    end if

    
%> 