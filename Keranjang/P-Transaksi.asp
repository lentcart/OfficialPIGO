<!--#include file="../connections/pigoConn.asp"-->

<% 
        almID = request.form("alamatpenerima")
        trJenisPembayaran = request.form("jenispembayaran")

	set Transaksi_D1_CMD = server.CreateObject("ADODB.command")
	Transaksi_D1_CMD.activeConnection = MM_pigo_STRING        
    set Transaksi_H_CMD = server.CreateObject("ADODB.command")
    Transaksi_H_CMD.activeConnection = MM_pigo_STRING


    Transaksi_H_CMD.commandText = "exec sp_add_MKT_T_Transaksi2_H '"& trJenisPembayaran &"','"& request.cookies("custID") &"','"& almID &"','00'"
    'response.write Transaksi_H_CMD.commandText
    set Transaksi_H = Transaksi_H_CMD.execute 
    
        slID = request.form("slid")
        trJenisPengiriman= request.form("ongkirsl")
        trongkir = request.form("ongkoskirimsl")
        trCatatan = request.form("catatansl")
        pdID = request.form("pdID")
        pdHarga = request.form("pdHargaJual")
        qty = request.form("pdQty")

		produkid = split(trim(pdID),", ")
		harga = split(trim(pdHarga),", ")
		catatan = split(trim(trCatatan),", ")
		jumlah = split(trim(qty),", ")
		pengiriman = split(trim(trJenisPengiriman),", ")
		selerid = split(trim(slID),", ")
		ongkir = split(trim(trongkir),", ")

		urut=0
        
		for i = 0 to Ubound(produkid)
        
			urut=urut+1
			txturut=right("0000"&urut,4)
            
			Transaksi_D1_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Transaksi2_D]([trID_H],[trDCatatan],[tr_pdID],[tr_pdQty],[tr_pdHarga],[tr_Pengiriman],[tr_slID],[tr_prID],[tr_rkID],[trBiayaOngkir],[trAsuransi],[trBAsuransi],[trPacking],[trBPacking],[trDUpdateTime],[trDAktifYN]) VALUES ('"& Transaksi_H("id")&txturut &"','"& trCatatan  &"','"& produkid(i) &"','"& jumlah(i) &"','"& harga(i) &"','"& trJenisPengiriman &"','"& slID &"','00','00','"& trongkir &"','N',0,'N',0,'"& now() &"','Y')"
			response.write Transaksi_D1_CMD.commandText &"<br><br>"

			' Transaksi_D1_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Transaksi2_D]([trID_H],[trDCatatan],[tr_pdID],[tr_pdQty],[tr_pdHarga],[tr_Pengiriman],[tr_slID],[tr_prID],[tr_rkID],[trBiayaOngkir],[trAsuransi],[trBAsuransi],[trPacking],[trBPacking],[trDUpdateTime],[trDAktifYN]) VALUES ('"& Transaksi_H("id")&txturut &"','"& catatan(i) &"','"& produkid(i) &"','"& jumlah(i) &"','"& harga(i) &"','"& pengiriman(i) &"','"& selerid(i) &"','00','00','"& ongkir(i) &"','N',0,'N',0,'"& now() &"','Y')"
			' response.write Transaksi_D1_CMD.commandText &"<br><br>"
			' 'set Transaksi_D1 = Transaksi_D1_CMD.execute

            ' set Update_CMD = server.CreateObject("ADODB.command")
            ' Update_CMD.activeConnection = MM_pigo_STRING
            ' Update_CMD.commandText = "INSERT INTO [dbo].[MKT_M_Stok]([ID],[SCustID],[SProdukID],[TanggalUpdate],[QTYUpdate],[HargaUpdate],[Keterangan],[SUpdateTime],[SAktifYN]) VALUES ('"& Transaksi_H("id")&txturut &"','"& request.Cookies("custID") &"','"& produkid(i) &"','"& now() &"',"& jumlah(i) &","& harga(i) &",'PenjualanProduk','"& now() &"','Y')"
            ' 'sresponse.write Transaksi_H_CMD.commandText
            ' set Update = Update_CMD.execute

            ' set delete_CMD = server.CreateObject("ADODB.command")
            ' delete_CMD.activeConnection = MM_pigo_STRING
            ' delete_CMD.commandText = "DELETE FROM [dbo].[MKT_T_Keranjang_H] WHERE cart_custID ='"& request.Cookies("custID") &"' and cart_pdID = '"& produkid(i) &"'"
            ' 'response.write delete_CMD.commandText
            ' 'set delete = delete_CMD.execute
            
		next


    'Response.redirect "../Pembayaran/?trID=" & trim(Transaksi_H("id"))
%> 