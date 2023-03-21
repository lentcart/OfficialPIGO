<!--#include file="../../connections/pigoConn.asp"-->

<% 
    dim pdImage1, pdImage2, pdImage3, pdImage4, pdImage6, pdNama, pdKategori, pdMerk, pdType, pdBaruYN, pdDangerousGoodsYN, pdDesc1, pdMinPesanan, pdHarga, pdHargaGrosir, pdStatus, pdStok, pdSku, pdBerat, pdPanjang, pdLebar, pdTinggi, pdVolume, pdAsuransi, pdLayanan, pdTglProduksi, pdExp

    pdID = request.form("pdid")
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

    Produk_CMD.commandText = "update MKT_M_Produk set pdImage1 = '"& pdImage1 &"', pdImage2 = '"& pdImage2 &"', pdImage3 = '"& pdImage3 &"', pdImage4 = '"& pdImage4 &"' , pdImage5 ='"& pdImage5 &"', pdImage6 ='"& pdImage6 &"', pdVideo ='"& pdVideo &"', pdNama = '"& pdNama &"', pd_catID = '"& pdKategori &"', pd_mrID = "& pdMerk &", pdType = '"& pdtype &"', pdBaruYN = '"& pdBaruYN &"', pdDangerousGoodsYN = '"& pdDangerousGoodsYN &"', pdDesc1 = '"& pdDesc1 &"', pdDesc2 = '"& pdDesc2 &"', pdMinPesanan = "& pdMinPesanan &", pdHargaBeli = "& pdHargaBeli &", pdHargaJual = "& pdHargaJual &", pdUpTo = "& pdUpTo &", pdPPN = "& pdPPN &", pdHargaGrosir = "& pdHargaGrosir &", pdStatus = '"& pdStatus &"', pdStok = "& pdStok &", pdSKU = '"& pdSku &"', pdBerat = "& pdBerat &", pdPanjang = "& pdPanjang &", pdLebar = "& pdLebar &", pdTinggi = "& pdTinggi &", pdVolume = "& pdVolume &", pdAsuransi = '"& pdAsuransi &"', pdLayanan = '"& pdLayanan &"', pdTglProduksi = '"& pdTglProduksi &"', pdExp = '"& pdExp &"', pdMsds = '"& pdMsds &"', pd_custID = '"& request.Cookies("custID") &  "', pd_almID = '"& pd_AlmID &"' where pdID = '"& pdID &"' "
    'response.write Produk_CMD.commandText
    set pr = Produk_CMD.execute

    Response.redirect "../Daftar-Produk/"
%> 