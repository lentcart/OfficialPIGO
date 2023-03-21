<!--#include file="../../../connections/pigoConn.asp"-->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->

<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">

<% 

    dim produkID,pdKey,pdNama,pdUnit,pdPartNumber,pd_catID,pd_mrID,pdKondisi,pdTypeProduk,pdStokAwal,pdTypePart,pdDesc,pdHarga,pdBerat,pdJenisBerat,pdPanjang,pdLebar,pdTinggi,pdVolume,pdLokasi,pdStatus

    produkID            = trim(request.form("pdID"))
    pdKey               = trim(request.form("katakunci"))
    pdNama              = trim(request.form("namaproduk"))
    pdUnit              = trim(request.form("unitproduk"))
    pdPartNumber        = trim(request.form("partnumber"))
    pd_catID            = trim(request.form("kategori"))
    pd_mrID             = CINT(trim(request.form("merk")))
    pdKondisi           = trim(request.form("kondisiproduk"))
    pdTypeProduk        = trim(request.form("typeproduk"))
    pdStokAwal          = Cint(trim(request.form("stokawal")))
    pdTypePart          = trim(request.form("typepart"))
    pdDesc              = trim(request.form("deskripsi"))
    pdHarga             = cstr(trim(request.form("pdharga")))
    pdBerat             = Cint(trim(request.form("beratproduk")))
    pdJenisBerat        = trim(request.form("jenisberat"))
    pdPanjang           = Cint(trim(request.form("panjangproduk")))
    pdLebar             = Cint(trim(request.form("lebarproduk")))
    pdTinggi            = Cint(trim(request.form("tinggiproduk")))
    pdVolume            = Cint(trim(request.form("volumeproduk")))
    pdLokasi            = trim(request.form("lokasirak"))
    pdStatus            = trim(request.form("statusproduk"))
    
    set Produk_CMD = server.CreateObject("ADODB.command")
    Produk_CMD.activeConnection = MM_pigo_STRING

    Produk_CMD.commandText = "SELECT * FROM MKT_M_PIGO_Produk  WHERE pdID = '"& produkID &"'"
    set Produk = Produk_CMD.execute

    if not Produk.eof then

        SND_pdKey               = Produk("pdKey")
        SND_pdImage             = Produk("pdImage")
        SND_pdNama              = Produk("pdNama")
        SND_pdUnit              = Produk("pdUnit")
        SND_pdPartNumber        = Produk("pdPartNumber")
        SND_pd_catID            = Produk("pd_catID")
        SND_pd_mrID             = Cint(Produk("pd_mrID"))
        SND_pdKondisi           = Produk("pdKondisi")
        SND_pdTypeProduk        = Produk("pdTypeProduk")
        SND_pdStokAwal          = Produk("pdStokAwal")
        SND_pdTypePart          = Produk("pdTypePart")
        SND_pdDesc              = Produk("pdDesc")
        SND_pdDropship          = Produk("pdDropship")
        SND_pdHarga             = cstr(Produk("pdHarga"))   
        SND_pdBerat             = Produk("pdBerat")
        SND_pdJenisBerat        = Produk("pdJenisBerat")
        SND_pdPanjang           = Produk("pdPanjang")
        SND_pdLebar             = Produk("pdLebar")
        SND_pdTinggi            = Produk("pdTinggi")
        SND_pdVolume            = Produk("pdVolume")
        SND_pdLokasi            = Produk("pdLokasi")
        SND_pdStatus            = Produk("pdStatus")

        if SND_pdKey = pdKey THEN 
            updateKey = ""
        else 
            updateKey = "Perubahan kunci Pencarian Produk Dari " & SND_pdKey & " Ke " & pdKey & ","
        end if

        if SND_pdNama <> pdNama THEN 
            updateNama = "Perubahan Nama Produk Dari " & SND_pdNama & " Ke " & pdNama & ","
        else 
            updateNama = ""
        end if

        if SND_pdUnit <> pdUnit THEN 
            updateUnit = "Perubahan Unit Produk Dari " & SND_pdUnit & " Ke " & pdUnit & ","
        else 
            updateUnit = ""
        end if

        if SND_pdPartNumber <> pdPartNumber THEN 
            updatePartNumber = "Perubahan Part Number Produk Dari " & SND_pdPartNumber & " Ke " & pdPartNumber & ","
        else 
            updatePartNumber = ""
        end if

        if SND_pd_catID <> pd_catID THEN 
            updateKategori = "Perubahan Kategori Produk Dari " & SND_pd_catID & " Ke " & pd_catID & ","
        else 
            updateKategori = ""
        end if

        if SND_pd_mrID = pd_mrID THEN 
            updateMerk = ""
        else 
            updateMerk = "Perubahan Merk Produk Dari " & SND_pd_mrID & " Ke " & pd_mrID & ","
        end if

        if SND_pdKondisi <> pdKondisi THEN 
            updateKondisi = "Perubahan Kondisi Produk Dari " & SND_pdKondisi & " Ke " & pdKondisi & ","
        else 
            updateKondisi = ""
        end if

        if SND_pdTypeProduk <> pdTypeProduk THEN 
            updateTypeProduk = "Perubahan Type Produk Produk Dari " & SND_pdTypeProduk & " Ke " & pdTypeProduk & ","
        else 
            updateTypeProduk = ""
        end if
        if SND_pdStokAwal <> pdStokAwal THEN 
            updateStokAwal = "Perubahan Stok Awal Produk Dari " & SND_pdStokAwal & " Ke " & pdStokAwal & ","
        else 
            updateStokAwal = ""
        end if

        if SND_pdTypePart <> pdTypePart THEN 
            updateTypePart = "Perubahan Type Part Produk Dari " & SND_pdTypePart & " Ke " & pdTypePart & ","
        else 
            updateTypePart = ""
        end if

        if SND_pdDesc <> pdDesc THEN 
            updateDesc = "Perubahan Deskripsi Produk Dari " & SND_pdDesc & " Ke " & pdDesc & ","
        else 
            updateDesc = ""
        end if

        if SND_pdHarga = pdHarga THEN 
            updateHarga = ""
        else 
            updateHarga = "Perubahan Harga Produk Dari " & SND_pdHarga & " Ke " & pdHarga & ","
        end if

        if SND_pdBerat <> pdBerat THEN 
            updateBerat = "Perubahan Ukuran Berat Produk Dari " & SND_pdBerat & " Ke " & pdBerat & ","
        else 
            updateBerat = ""
        end if

        if SND_pdJenisBerat <> pdJenisBerat THEN 
            updateJenisBerat = "Perubahan Jenis Berat Produk Dari " & SND_pdJenisBerat & " Ke " & pdJenisBerat & ","
        else 
            updateJenisBerat = ""
        end if

        if SND_pdPanjang <> pdPanjang THEN 
            updatePanjang = "Perubahan Ukuran Panjang Produk Dari " & SND_pdPanjang & " Ke " & pdPanjang & ","
        else 
            updatePanjang = ""
        end if

        if SND_pdLebar <> pdLebar THEN 
            updateLebar = "Perubahan Ukuran Lebar Produk Dari " & SND_pdLebar & " Ke " & pdLebar & ","
        else 
            updateLebar = ""
        end if

        if SND_pdTinggi <> pdTinggi THEN 
            updateTinggi = "Perubahan Ukuran Tinggi Produk Dari " & SND_pdTinggi & " Ke " & pdTinggi & ","
        else 
            updateTinggi = ""
        end if

        if SND_pdVolume <> pdVolume THEN 
            updateVolume = "Perubahan Nilai Volume Produk Dari " & SND_pdVolume & " Ke " & pdVolume & ","
        else 
            updateVolume = ""
        end if

        if SND_pdLokasi <> pdLokasi THEN 
            updateLokasi = "Perubahan Lokasi RAK Produk Dari " & SND_pdLokasi & " Ke " & pdLokasi & ","
        else 
            updateLokasi = ""
        end if

        if SND_pdStatus <> pdStatus THEN 
            updateStatus = "Perubahan Status Produk Dari " & SND_pdStatus & " Ke " & pdStatus & ","
        else 
            updateStatus = ""
        end if

        Produk_CMD.commandText = " UPDATE [dbo].[MKT_M_PIGO_Produk] SET [pdKey] = '"& pdKey &"',[pdNama] = '"& pdNama &"',[pdUnit] = '"& pdUnit &"',[pdPartNumber] = '"& pdPartNumber &"',[pd_catID] = '"& pd_catID &"',[pd_mrID] = '"& pd_mrID &"',[pdKondisi] = '"& pdKondisi &"',[pdTypeProduk] = '"& pdTypeProduk &"',[pdStokAwal] = '"& pdStokAwal &"',[pdTypePart] = '"& pdTypePart &"',[pdDesc] = '"& pdDesc &"',[pdHarga] = '"&  pdHarga &"',[pdBerat] = '"& pdBerat &"',[pdJenisBerat] = '"& pdJenisBerat &"',[pdPanjang] = '"& pdPanjang &"',[pdLebar] = '"& pdLebar &"',[pdTinggi] = '"& pdTinggi &"',[pdVolume] = '"& pdVolume &"',[pdLokasi] = '"& pdLokasi &"',[pdStatus] = '"& pdStatus &"', pdUpdateID = '"& session("username") &"'  WHERE pdID = '"& produkID &"'"
        ' response.write Produk_CMD.commandText & "<br><br>"
        set UpdateProduk = Produk_CMD.execute

        Ket =  "UPDATE " & updateKey & updateNama & updateUnit & updatePartNumber & updateKategori & updateMerk & updateKondisi & updateTypeProduk & updateStokAwal & updateTypePart & updateDesc & updateHarga & updateBerat & updateJenisBerat & updatePanjang & updateLebar & updateTinggi & updateVolume & updateLokasi & updateStatus & " Berdasarkan Produk ID : ("& produkID &") "
        ' response.write Ket & "<br><br>"

        Log_ServerID 	= "" 
        Log_Action   	= "UPDATE"
        Log_Key         = produkID
        Log_Keterangan  = Ket
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

        Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> DATA BERHASIL DI UBAH </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/Produk/ProdukInfo/ style='color:white;font-weight:bold; text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'> KEMBALI </a>"

    else

        Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> DATA TIDAK TERDAFTAR </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/Produk/ProdukInfo/ style='color:white;font-weight:bold; text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'> KEMBALI </a>"

    end if

%> 
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>