<!--#include file="../../../connections/pigoConn.asp"-->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->

<% 

    pdKey   = request.form("katakunci")
    pdImage = request.form("Image2")
    pdNama = request.form("namaproduk")
    pdUnit = request.form("unitproduk")
    pdPartNumber = request.form("partnumber")
    pd_catID = request.form("kategori")
    pd_mrID = request.form("merk")
    pdKondisi = request.form("kondisiproduk")
    pdTypeProduk = request.form("typeproduk")
    pdStokAwal = request.form("stokawal")
    pdTypePart = request.form("typepart")
    pdDesc = request.form("deskripsi")
    pdDropship = "0"
    pdHarga = request.form("pdharga")
    pdBerat = request.form("beratproduk")
    pdJenisBerat = request.form("jenisberat")
    pdPanjang = request.form("panjangproduk")
    pdLebar = request.form("lebarproduk")
    pdTinggi = request.form("tinggiproduk")
    pdVolume = request.form("volumeproduk")
    pdLokasi = request.form("lokasirak")
    pdStatus = request.form("statusproduk")
    
    
    set Produk_CMD = server.CreateObject("ADODB.command")
    Produk_CMD.activeConnection = MM_pigo_STRING

    Produk_CMD.commandText = " exec sp_add_MKT_M_PIGO_Produk '"& pdKey &"','"& pdImage &"','"& pdNama &"','"& pdUnit &"','"& pdPartNumber &"','"& pd_catID &"',"& pd_mrID &",'"& pdKondisi &"','"& pdTypeProduk &"',"& pdStokAwal &",'"& pdTypePart &"','"& pdDesc &"','Y',"& pdHarga &",5,'TAX2201',"& pdBerat &",'"& pdJenisBerat &"', "& pdPanjang &","& pdLebar &","& pdTinggi &","& pdVolume &",'"& pdLokasi &"','"& pdStatus &"','"& session("Username") &"'"
    'response.write Produk_CMD.commandText
    set Produk = Produk_CMD.execute

    Log_ServerID 	= "" 
    Log_Action   	= "CREATE"
    Log_Key         = Produk("id")
    Log_Keterangan  = "Tambah produk baru dengan ID : ("& Produk("id") &") diproses pada "& DATE() &""
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    set UpdateStok_CMD = server.CreateObject("ADODB.command")
    UpdateStok_CMD.activeConnection = MM_pigo_STRING
    UpdateStok_CMD.commandText = "INSERT INTO [dbo].[MKT_M_Stok]([st_Tanggal],[st_pdID],[st_pdQty],[st_pdHarga],[st_pdStatus],[st_updateID],[st_UpdateTime],[st_AktifYN])VALUES('"& Cdate(date()) &"','"& Produk("id") &"',"&  pdStokAwal  &","& pdHarga &",2,'"& session("username") &"','"& now() &"','Y')"
    set UpdateStok = UpdateStok_CMD.execute

    Log_ServerID 	= ""
    Log_Action   	= "ADD"
    Log_Key         = Produk("id")
    Log_Keterangan  = "Tambah stok baru produk ("& Produk("id") &") diproses pada tanggal "& DATE() &""
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    Response.redirect "index.asp"
%> 