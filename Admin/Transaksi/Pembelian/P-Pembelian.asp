<!--#include file="../../../connections/pigoConn.asp"-->

<% 

    pmTglPembelian = request.form("tglpembelian")
    pm_custID = request.form("custID")

    pmNamaSupplier = request.form("namasupplier")
    pmEmail = request.form("emailsupplier")
    pmNamaCP = request.form("namacp")
    pmPhone1 = request.form("phone1")
    pmPhone2 = request.form("phone2")
    pmPhone3 = request.form("phone3")
    pmAlamatSupplier = request.form("alamatlengkap")
    pmProvinsi = request.form("provinsi")
    pmDeskripsi = request.form("deskripsi")
    
    pm_pdID = request.form("kdproduk")
    pm_pdNama = request.form("namaproduk")
    pm_pdQty = request.form("jumlahproduk")
    pm_pdUnit = request.form("unit")
    pm_pdHarga = request.form("hargaproduk")
    pm_pdMerk = request.form("merk")
    pm_pdKategori = request.form("kategori")
    pm_pdType = request.form("type")
    pm_pdKondisi = request.form("kondisi")

    set Pembelian_H_CMD = server.CreateObject("ADODB.command")
    Pembelian_H_CMD.activeConnection = MM_pigo_STRING

    Pembelian_H_CMD.commandText = "exec sp_add_MKT_T_Pembelian_H '"& pmTglPembelian &"','"& request.Cookies("custID") &"' "
    'response.write Pembelian_H_CMD.commandText
    set Pembelian_H = Pembelian_H_CMD.execute


    set Pembelian_D_CMD = server.CreateObject("ADODB.command")
    Pembelian_D_CMD.activeConnection = MM_pigo_STRING

    Pembelian_D_CMD.commandText = "exec sp_add_MKT_T_Pembelian_D '"& Pembelian_H("id") &"','"& pmNamaSupplier &"','"& pmEmail &"','"& pmNamaCP &"','"& pmPhone1 &"','"& pmPhone2 &"', '"& pmPhone3 &"','"& pmAlamatSupplier &"','"& pmProvinsi &"','"& pmDeskripsi &"' "
    'response.write Pembelian_D_CMD.commandText
    set Pembelian_D = Pembelian_D_CMD.execute

    set Pembelian_D1_CMD = server.CreateObject("ADODB.command")
    Pembelian_D1_CMD.activeConnection = MM_pigo_STRING

    Pembelian_D1_CMD.commandText = "exec sp_add_MKT_T_Pembelian_D1 '"& Pembelian_D("id") &"','"& pm_pdID &"','"& pm_pdNama &"',"& pm_pdQty &",'"& pm_pdUnit &"',"& pm_pdHarga &","& pm_pdMerk &",'"& pm_pdKategori &"','"& pm_pdType &"','"& pm_pdKondisi &"' "
    'response.write Pembelian_D1_CMD.commandText
    set Pembelian_D1 = Pembelian_D1_CMD.execute

    set Update_CMD = server.CreateObject("ADODB.command")
    Update_CMD.activeConnection = MM_pigo_STRING

    Update_CMD.commandText = "INSERT INTO [dbo].[MKT_M_Stok]([ID],[SCustID],[SProdukID],[TanggalUpdate],[QTYUpdate],[HargaUpdate],[Keterangan],[SUpdateTime],[SAktifYN]) VALUES ('"& Pembelian_H("id") &"','"& request.Cookies("custID") &"','"& pm_pdID &"','"& pmTglPembelian &"',"& pm_pdQty &","& pm_pdHarga &",'PembelianProduk','"& now() &"','Y')"
    set Update = Update_CMD.execute

    Response.redirect "index.asp"
%> 