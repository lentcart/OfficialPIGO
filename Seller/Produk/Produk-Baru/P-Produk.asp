<!--#include file="../../connections/pigoConn.asp"-->

<% 
    
    pdImage1 = request.form("image1")
    pdImage2 = request.form("image2")
    pdImage3 = request.form("image3")
    pdImage4 = request.form("image4")
    'pdImage5 = request.form("image5")
    pdImage6 = request.form("image6")
    pdNama = request.form("namaproduk")
    pdKategori = request.form("kategori")
    pdMerk = request.form("merk")
    pdType = request.form("type")
    pdBaruYN = request.form("kondisi")
    pdDangerousGoodsYN = request.form("Dangerous")
    pdDesc1 = request.form("deskripsi")
    pdMinPesanan = request.form("minpesanan")
    pdHargaBeli = request.form("hargabeli")
    pdHargaJual = request.form("hargajual")
    pdUpTo = request.form("upto")
    pdPPN = request.form("ppn")
    pdHargaGrosir = request.form("hargagrosir")
    pdStatus = request.form("statusproduk")
    pdStok = request.form("stok")
    pdSku = request.form("sku")
    pdBerat = request.form("berat")
    pdPanjang = request.form("panjang")
    pdLebar = request.form("lebar")
    pdTinggi = request.form("tinggi")
    pdVolume = request.form("totVol")
    pdAsuransi = request.form("asuransi")
    pdLayanan = request.form("layanan")
    pdTglProduksi = request.form("tglproduksi")
    pdExp = request.form("tglexp")
    pd_almID = request.form("almID")
    
    
    set Produk_CMD = server.CreateObject("ADODB.command")
    Produk_CMD.activeConnection = MM_pigo_STRING

    Produk_CMD.commandText = " exec sp_add_MKT_M_Produk '"& pdImage1 &"','"& pdImage2 &"','"& pdImage3 &"','"& pdImage4 &"','"& pdImage5 &"','"& pdImage6 &"','"& pdVideo &"','"& pdNama &"','"& pdKategori &"',"& pdMerk &",'"& pdtype &"','"& pdBaruYN &"','"& pdDangerousGoodsYN &"','"& pdDesc1 &"','"& pdDesc2 &"',"& pdMinPesanan &","& pdHargaBeli &","& pdHargaJual &","& pdUpTo &","& pdPPN &","& pdHargaGrosir &",'"& pdStatus &"',"& pdStok &",'"& pdSku &"',"& pdBerat &","& pdPanjang &","& pdLebar &","& pdTinggi &","& pdVolume &",'N','"& pdLayanan &"','"& pdTglProduksi &"','"& pdExp &"','"& pdMsds &"','"& request.cookies("custEmail") &"','"& request.cookies("custID") &"','"& pd_almID &"' "
    'response.write Produk_CMD.commandText
    set Produk = Produk_CMD.execute

    Response.redirect "index.asp"
%> 