<!--#include file="../connections/pigoConn.asp"-->

<% 
    tr_rkID = request.form("rekidcust")
    tr_rkBankID  = request.form("bankidcust")
    tr_rkNomorRk = request.form("nomorrkcust")
    almID = request.form("alamatpenerima")
    trJenisPembayaran = request.form("jenispembayaran")
    trTotalPembayaran = request.form("jenispembayaran")
    totalseller = request.form("no")
    totalproduk = request.form("grandtotalqty")

        set Transaksi_H_CMD = server.CreateObject("ADODB.command")
        Transaksi_H_CMD.activeConnection = MM_pigo_STRING
        Transaksi_H_CMD.commandText = "exec sp_add_MKT_T_Transaksi_H '"& request.cookies("custID") &"','"& tr_rkID &"','"& tr_rkBankID &"','"& tr_rkNomorRk &"','"& almID &"','"& trJenisPembayaran &"'"
        response.write Transaksi_H_CMD.commandText &"<br><br>"
        set Transaksi_H = Transaksi_H_CMD.execute 
        
        set Permintaan_Barang_H_CMD = server.CreateObject("ADODB.command")
        Permintaan_Barang_H_CMD.activeConnection = MM_pigo_STRING
        Permintaan_Barang_H_CMD.commandText = "exec sp_add_MKT_T_Permintaan_Barang '"& Transaksi_H("id") &"','"& Date() &"',1,'','N','"& request.cookies("custID") &"','00','04','Y' "
        response.write Permintaan_Barang_H_CMD.commandText &"<br><br>"
        set Permintaan_Barang_H = Permintaan_Barang_H_CMD.execute
        
    urut=0

    slID = request.form("slid")
    tr_rkIDs = request.form("rekidsl")
    tr_rkBankIDs  = request.form("bankidsl")
    tr_rkNomorRks = request.form("nomorrksl")
    trJenisPengiriman= request.form("ongkirsl")
    trongkir = request.form("ongkoskirimsl")
    trD1catatan = request.form("catatansl")
    

    sellerid = split(trim(slID),", ")
    rekid = split(trim(tr_rkIDs),", ")
    bankid = split(trim(tr_rkBankIDs),", ")
    nomorrk = split(trim(tr_rkNomorRks),", ")
    pengiriman = split(trim(trJenisPengiriman),", ")
    ongkir = split(trim(trongkir),", ")
    catatan = split(trim(trD1catatan),", ")

    for i = 0 to Ubound(sellerid)
        'response.write sellerid(i) &"<br><br>"
        urut=urut+1
        txturut=right("000"&urut,3)

        set Transaksi_D1_CMD = server.CreateObject("ADODB.command")
        Transaksi_D1_CMD.activeConnection = MM_pigo_STRING
        Transaksi_D1_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Transaksi_D1]([trD1],[tr_slID],[tr_rkID],[tr_BankID],[tr_rkNomorRK],[trPengiriman],[trBiayaOngkir],[trAsuransi],[trBAsuransi],[trPacking],[trBPacking],[trD1catatan],[tr_strID],[trD1AktifYN])VALUES('"& Transaksi_H("id")&txturut &"','"& sellerid(i) &"','"& rekid(i) &"','"& bankid(i) &"','"& nomorrk(i) &"','"& pengiriman(i) &"',"& ongkir(i) &",'N',0,'N',0,'"& catatan(i) &"','00','Y')"
        response.write Transaksi_D1_CMD.commandText &"<br><br>"
        set Transaksi_D1 = Transaksi_D1_CMD.execute

        Transaksi_D1 = sellerid(i)

        no=0
        pdID = request.form("pdID")
        pdHarga = request.form("pdHargaJual")
        qty = request.form("pdQty")

        produkid = split(trim(pdID),", ")
        harga = split(trim(pdHarga),", ")
        jumlah = split(trim(qty),", ")

    next

        for a = 0 to Ubound(produkid)

            no=no+1
            nourut=right("0000"&no,4)

                set Transaksi_D1A_CMD = server.CreateObject("ADODB.command")
                Transaksi_D1A_CMD.activeConnection = MM_pigo_STRING
                Transaksi_D1A_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Transaksi_D1A]([trD1A],[tr_pdID],[tr_pdHarga],[tr_pdQty],[trD1AAktifYN])VALUES('"& Transaksi_H("id") &"','"& produkid(a) &"',"& harga(a) &","& jumlah(a) &",'Y')"
                'response.write Transaksi_D1A_CMD.commandText &"<br><br>"
                set Transaksi_D1A = Transaksi_D1A_CMD.execute

                set Permintaan_Barang_D_CMD = server.CreateObject("ADODB.command")
                Permintaan_Barang_D_CMD.activeConnection = MM_pigo_STRING
                Permintaan_Barang_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Permintaan_Barang_D]([Perm_IDH],[Perm_pdID],[Perm_pdQty],[Perm_pdHargaJual],[Perm_pdUpTo],[Perm_pdTax],[Perm_AktifYN])VALUES('"& Permintaan_Barang_H("id") &"','"& produkid(a) &"',"& jumlah(a) &","& harga(a) &",0,0,'Y')"
                'response.write Permintaan_Barang_D_CMD.commandText &"<br><br>"
                set Permintaan_Barang_D = Permintaan_Barang_D_CMD.execute

                set Update_CMD = server.CreateObject("ADODB.command")
                Update_CMD.activeConnection = MM_pigo_STRING
                Update_CMD.commandText = "INSERT INTO [dbo].[MKT_M_Stok]([st_Tanggal],[st_pdID],[st_pdQty],[st_pdHarga],[st_pdStatus],[st_updateID],[st_UpdateTime],[st_AktifYN])VALUES('"& now() &"','"& produkid(a) &"',"& jumlah(a) &","& harga(a) &",2,'"& request.cookies("custID") &"','"& now() &"','Y')"
                set Update = Update_CMD.execute

                set delete_CMD = server.CreateObject("ADODB.command")
                delete_CMD.activeConnection = MM_pigo_STRING
                delete_CMD.commandText = "DELETE FROM [dbo].[MKT_T_Keranjang] WHERE cart_custID ='"& request.Cookies("custID") &"' and cart_pdID = '"& produkid(a) &"'"
                'response.write delete_CMD.commandText &"<br><br>"
                set delete = delete_CMD.execute

        next

        Response.redirect "../Pembayaran/?trID=" & trim(Transaksi_H("id"))

%>
