<!--#include file="../../Connections/pigoConn.asp" -->
<!--#include file="../../UpdateLOG/UpdateLOG.asp"-->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">

<% 
    dim custID,custNama,custDesc,custStatusKr,custStatusTax,custPartnerG,custNpwp,custAlamatNpwp,custPembayaran,custTransaksi,custPaymentTerm,custAlamat,custProv,custKab,custPhone1,custPhone2,custFax,custEmail,custWilayah,custBankID,custNoRekening,custPemilikRek,custNamaCP,custPhoneCP,custEmailCP,custJabatanCP,custAlamatCP

    custID                  = trim(request.form("custID"))
    custNama                = trim(request.form("custNama"))
    custDesc                = trim(request.form("deskripsi"))
    custStatusKr            = CINT(trim(request.form("statuskredit")))
    custStatusTax           = trim(request.form("statustax"))
    custPartnerG            = trim(request.form("group"))
    custNpwp                = trim(request.form("npwp"))
    custAlamatNpwp          = trim(request.form("alamatnpwp"))
    custPembayaran          = CINT(trim(request.form("jpembayaran")))
    custTransaksi           = CINT(trim(request.form("jtransaksi")))
    custPaymentTerm         = CINT(trim(request.form("jangkawaktu")))
    custAlamat              = trim(request.form("alamatlengkap"))
    custProv                = trim(request.form("provinsi"))
    custKab                 = trim(request.form("kab"))
    custPhone1              = trim(request.form("phone1"))
    custPhone2              = trim(request.form("phone2"))
    custFax                 = trim(request.form("fax"))
    custEmail               = trim(request.form("emailpr"))
    custWilayah             = trim(request.form("wpenjualan"))
    custBankID              = CINT(trim(request.form("idbank")))
    custNoRekening          = trim(request.form("norekening"))
    custPemilikRek          = trim(request.form("pemilikrek"))
    custNamaCP              = trim(request.form("namacp"))
    custPhoneCP             = trim(request.form("phonecp"))
    custEmailCP             = trim(request.form("emailcp"))
    custJabatanCP           = trim(request.form("jabatancp"))
    custAlamatCP            = trim(request.form("alamatcp"))
    
    
    set BussinesPartner_CMD = server.CreateObject("ADODB.command")
    BussinesPartner_CMD.activeConnection = MM_pigo_STRING

    BussinesPartner_CMD.commandText = "SELECT * FROM MKT_M_Customer WHERE custID = '"& custID &"'"
    set BussinesPartner = BussinesPartner_CMD.execute

    if not BussinesPartner.eof then

        SND_custID                  = BussinesPartner("custID")
        SND_custNama                = BussinesPartner("custNama")
        SND_custFax                 = BussinesPartner("custFax")
        SND_custNpwp                = BussinesPartner("custNpwp")
        SND_custAlamatNpwp          = BussinesPartner("custAlamatNpwp")
        SND_custWilayah             = BussinesPartner("custWilayah")
        SND_custDesc                = BussinesPartner("custDesc")
        SND_custStatusKr            = BussinesPartner("custStatusKredit")
        SND_custStatusTax           = BussinesPartner("custStatusTax")
        SND_custPartnerG            = BussinesPartner("custPartnerGroup")
        SND_custPembayaran          = CINT(BussinesPartner("custPembayaran"))
        SND_custTransaksi           = CINT(BussinesPartner("custTransaksi"))
        SND_custPaymentTerm         = CINT(BussinesPartner("custPaymentTerm"))
        SND_custPhone1              = BussinesPartner("custPhone1")
        SND_custPhone2              = BussinesPartner("custPhone2")
        SND_custEmail               = BussinesPartner("custEmail")
        SND_custNamaCP              = BussinesPartner("custNamaCP")
        SND_custPhoneCP             = BussinesPartner("custPhoneCP")
        SND_custEmailCP             = BussinesPartner("custEmailCP")
        SND_custAlamatCP            = BussinesPartner("custAlamatCP")
        SND_custJabatanCP           = BussinesPartner("custJabatanCP")

        if SND_custNama <> custNama THEN 
            updateNama = "Perubahan Nama Bussines Partner Dari " & SND_custNama & " Ke " & custNama & ","
        else 
            updateNama = ""
        end if
        
        if  SND_custDesc <> custDesc THEN 
            updateDesc = "Perubahan Deskripsi Bussines Partner Dari " &  SND_custDesc & " Ke " & custDesc & ","
        else 
            updateDesc = ""
        end if
        
        
        if  SND_custStatusKr <> custStatusKr THEN 
            updateStatusKr = "Perubahan StatusKr Bussines Partner Dari " &  SND_custStatusKr & " Ke " & custStatusKr & ","
        else 
            updateStatusKr = ""
        end if

        if  SND_custStatusTax <> custStatusTax THEN 
            updateStatusTax = "Perubahan StatusTax Bussines Partner Dari " &  SND_custStatusTax & " Ke " & custStatusTax & ","
        else 
            updateStatusTax = ""
        end if

        if  SND_custPartnerG <> custPartnerG THEN 
            updatePartnerG = "Perubahan PartnerG Bussines Partner Dari " &  SND_custPartnerG & " Ke " & custPartnerG & ","
        else 
            updatePartnerG = ""
        end if
        
        if  SND_custNpwp <> custNpwp THEN 
            updateNPWP = "Perubahan NPWP Bussines Partner Dari " &  SND_custNpwp & " Ke " & custNpwp & ","
        else 
            updateNPWP = ""
        end if

        if  SND_custAlamatNpwp <> custAlamatNpwp THEN 
            updateAlamatNPWP = "Perubahan Alamat NPWP Bussines Partner Dari " &  SND_custAlamatNpwp & " Ke " & custAlamatNpwp & ","
        else 
            updateAlamatNPWP = ""
        end if

        if  SND_custPembayaran <> custPembayaran THEN 
            updatePembayaran = "Perubahan Opsi Pembayaran Bussines Partner Dari " &  SND_custPembayaran & " Ke " & custPembayaran & ","
        else 
            updatePembayaran = ""
        end if

        if  SND_custTransaksi <> custTransaksi THEN 
            updateTransaksi = "Perubahan Opsi Transaksi Bussines Partner Dari " &  SND_custTransaksi & " Ke " & custTransaksi & ","
        else 
            updateTransaksi = ""
        end if

        if  SND_custPaymentTerm <> custPaymentTerm THEN 
            updatePaymentTerm = "Perubahan Payment Term Bussines Partner Dari " &  SND_custPaymentTerm & " Ke " & custPaymentTerm & ","
        else 
            updatePaymentTerm = ""
        end if

        if  SND_custPhone1 <> custPhone1 THEN 
            updatePhone1 = "Perubahan Nomor Telepon 1 Bussines Partner Dari " &  SND_custPhone1 & " Ke " & custPhone1 & ","
        else 
            updatePhone1 = ""
        end if
        
        if  SND_custPhone2 <> custPhone2 THEN 
            updatePhone2 = "Perubahan Nomor Telepon 2 Bussines Partner Dari " &  SND_custPhone2 & " Ke " & custPhone2 & ","
        else 
            updatePhone2 = ""
        end if

        if  SND_custFax <> custFax THEN 
            updateFax = "Perubahan Nomor Fax Bussines Partner Dari " &  SND_custFax & " Ke " & custFax & ","
        else 
            updateFax = ""
        end if

        if  SND_custEmail <> custEmail THEN 
            updateEmail = "Perubahan Alamat Email Bussines Partner Dari " &  SND_custEmail & " Ke " & custEmail & ","
        else 
            updateEmail = ""
        end if

        if  SND_custWilayah <> custWilayah THEN 
            updateWilayah = "Perubahan Wilayah Bussines Partner Dari " &  SND_custWilayah & " Ke " & custWilayah & ","
        else 
            updateWilayah = ""
        end if

        if  SND_custNamaCP <> custNamaCP THEN 
            updateNamaCP = "Perubahan Nama Contact Person Bussines Partner Dari " &  SND_custNamaCP & " Ke " & custNamaCP & ","
        else 
            updateNamaCP = ""
        end if

        if   SND_custPhoneCP <>  custPhoneCP THEN 
            updatePhoneCP = "Perubahan Nomor Telepon Contact Person Bussines Partner Dari " &   SND_custPhoneCP & " Ke " &  custPhoneCP & ","
        else 
            updatePhoneCP = ""
        end if

        if   SND_custEmailCP <>  custEmailCP THEN 
            updateEmailCP = "Perubahan Alamat Email Contact Person Bussines Partner Dari " &   SND_custEmailCP & " Ke " &  custEmailCP & ","
        else 
            updateEmailCP = ""
        end if

        if   SND_custJabatanCP <>  JabatanCP THEN 
            updateJabatanCP = "Perubahan Jabatan Contact Person Bussines Partner Dari " &   SND_custJabatanCP & " Ke " &  JabatanCP & ","
        else 
            updateJabatanCP = ""
        end if

        if   SND_custAlamatCP <>  custAlamatCP THEN 
            updateAlamatCP = "Perubahan Alamat Contact Person Bussines Partner Dari " &   SND_custAlamatCP & " Ke " &  custAlamatCP & ","
        else 
            updateAlamatCP = ""
        end if

        Ket1 =  "UPDATE " & updateNama & updateDesc & updateStatusKr & updateStatusTax & updatePartnerG & updateNPWP & updateAlamatNPWP & updatePembayaran & updateTransaksi & updatePaymentTerm & updatePhone1 & updatePhone2 & updateFax & updateEmail & updateWilayah & updateNamaCP & updatePhoneCP & uodateEmailCP & updateJabatanCP & updateAlamatCP & " Berdasarkan Bussines Partner ID : ("& custID &") "

        Log_ServerID 	= "" 
        Log_Action   	= "UPDATE"
        Log_Key         = custID
        Log_Keterangan  = Ket1
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

        ' Alamat Bussines Partner
            BussinesPartner_CMD.commandText = "SELECT * FROM MKT_M_Alamat WHERE alm_custID = '"& custID &"'"
            set AlamatBussinesPartner = BussinesPartner_CMD.execute

            if custAlamat <> AlamatBussinesPartner("almLengkap") then

            SND_custAlamat              = AlamatBussinesPartner("almLengkap")
            SND_custProv                = AlamatBussinesPartner("almProvinsi")
            SND_custKab                 = AlamatBussinesPartner("almKota")

            if   SND_custAlamat <>  custAlamat THEN 
                updateAlamat = "Perubahan Alamat Bussines Partner Dari " &  SND_custAlamat & " Ke " & custAlamat & ","
            else 
                updateAlamat = ""
            end if
            
            if   SND_custProv <>  custProv THEN 
                updateProvinsi = "Perubahan Provinsi Bussines Partner Dari " &  SND_custProv & " Ke " & custProv & ","
            else 
                updateProvinsi = ""
            end if
            
            if   SND_custKab <>  custKab THEN 
                updateKota = "Perubahan Kota Bussines Partner Dari " &  SND_custKab & " Ke " & custKab & ","
            else 
                updateKota = ""
            end if

            Ket2 =  "UPDATE " & updateAlamat & updateProvinsi & updateKota & " Berdasarkan Bussines Partner ID : ("& custID &") "
            response.write Ket2 & "<br><br><br>"

            Log_ServerID 	= "" 
            Log_Action   	= "UPDATE"
            Log_Key         = custID
            Log_Keterangan  = Ket2
            URL		        = ""

            call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

            end if 

        'Rekening Bussines Partner

            BussinesPartner_CMD.commandText = "SELECT * FROM MKT_M_Rekening WHERE rk_custID = '"& custID &"'"
            set RekeningBussinesPartner = BussinesPartner_CMD.execute

            if custBankID <> RekeningBussinesPartner("rkBankID") then

            SND_custBankID              = CINT(RekeningBussinesPartner("rkBankID"))
            SND_custNoRekening          = RekeningBussinesPartner("rkNomorRk")
            SND_custPemilikRek          = RekeningBussinesPartner("rkNamaPemilik")

            if   SND_custBankID  <>  custBankID THEN 
                updateBankID = "Perubahan ID Bank Bussines Partner Dari " &  SND_custBankID & " Ke " & custBankID & ","
            else 
                updateBankID = ""
            end if
            
            if   SND_custNoRekening <>  custNoRekening THEN 
                updateNoRekening = "Perubahan Nomor Rekening Bussines Partner Dari " &  SND_custNoRekening & " Ke " & custNoRekening & ","
            else 
                updateNoRekening = ""
            end if
            
            if   SND_custPemilikRek <>  custPemilikRek THEN 
                updatePemilikRekening = "Perubahan Nama Pemilik Rekening Bussines Partner Dari " &  SND_custPemilikRek & " Ke " & custPemilikRek & ","
            else 
                updatePemilikRekening = ""
            end if

            Ket3 =  "UPDATE " & updateBankID & updateNoRekening & updatePemilikRekening & " Berdasarkan Bussines Partner ID : ("& custID &") "

            Log_ServerID 	= "" 
            Log_Action   	= "UPDATE"
            Log_Key         = custID
            Log_Keterangan  = Ket3
            URL		        = ""

            call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

            end if 

        BussinesPartner_CMD.commandText = " UPDATE [dbo].[MKT_M_Customer] SET [custNama] = '"& custNama &"',[custEmail] = '"& custEmail &"',[custPhone1] = '"& custPhone1 &"',[custPhone2] = '"& custPhone2 &"',[custFax] = '"& custFax &"',[custNpwp] = '"& custNpwp &"',[custAlamatNpwp] = '"& custAlamatNpwp &"',[custWilayah] = '"& custWilayah &"',[custDesc] = '"& custDesc &"',[custStatusKredit] = "& custStatusKr &",[custStatusTax] = '"& custStatusTax &"',[custPartnerGroup] = '"& custPartnerG &"',[custPembayaran] = "& custPembayaran &",[custTransaksi] = "& custTransaksi &",[custPaymentTerm] = "& custPaymentTerm &",[custNamaCP] = '"& custNamaCP &"',[custPhoneCP] = '"& custPhoneCP &"',[custEmailCP] = '"& custEmailCP &"',[custJabatanCP] = '"& custJabatanCP &"',[custAlamatCP] = '"& custAlamatCP &"',[custUpdateID] = '"& session("username") &"',[custUpdateTime] = '"& now() &"' WHERE custID = '"& custID &"'"
        'response.write BussinesPartner_CMD.commandText & "<br><br><br>"
        set Customer = BussinesPartner_CMD.execute

        BussinesPartner_CMD.commandText = "UPDATE [dbo].[MKT_M_Alamat] SET [almNamaPenerima] = '"& custNama &"',[almPhonePenerima] = '"& custPhone1 &"',[almProvinsi] = '"& custProv &"',[almKota] = '"& custKab &"',[almLengkap] = '"& custAlamat &"',[almUpdateID] = '"& session("username") &"'  WHERE alm_custID = '"& custID &"'"
        'response.write BussinesPartner_CMD.commandText & "<br><br><br>"
        set Alamat = BussinesPartner_CMD.execute

        BussinesPartner_CMD.commandText = "UPDATE [dbo].[MKT_M_Rekening] SET [rkBankID] = '"& custBankID &"',[rkNomorRk] = '"& custNoRekening &"',[rkNamaPemilik] = '"& custPemilikRek &"',[rkUpdateID] = '"& session("username") &"' WHERE rk_custID = '"& custID &"' "
        'response.write BussinesPartner_CMD.commandText & "<br><br><br>"
        set Rekening = BussinesPartner_CMD.execute
        
        Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #0077a2; background-color:#0077a2; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:white; font-size:22px'> DATA BERHASIL DI UBAH </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/BussinesPartner/ style='color:#0077a2;font-weight:bold;  text-decoration:none; background-color:white; padding:10px 25px; margin-bottom:4px; border-radius:10px'>KEMBALI</a></div></div></div>"
    else

        Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> DATA TIDAK TERDAFTAR </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/BussinesPartner/ style='color:white;font-weight:bold; text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'> KEMBALI </a>"
    
    end if 
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script> 