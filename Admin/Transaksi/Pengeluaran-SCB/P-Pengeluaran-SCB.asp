<!--#include file="../../../connections/pigoConn.asp"-->

<% 

    pscType	        = request.form("pscType")
    pscTanggal	    = request.form("pscTanggal")
    pscDesc	        = request.form("pscDesc")
    pscDelRule	    = request.form("pscDelRule")
    pscDelVia	    = request.form("pscDelVia")
    pscDelPriority	= request.form("pscDelPriority")
    pscFCRule	    = request.form("pscFCRule")
    pscSubtotal	    = request.form("pscSubtotal")
    psc_permID	    = request.form("psc_permID")
    psc_custID	    = request.form("psc_custID")

    PermNo          = request.form("PermNo")
    Perm_trYN       = request.form("Perm_trYN")
    
        
    set PengeluaranSC_H_CMD = server.CreateObject("ADODB.command")
    PengeluaranSC_H_CMD.activeConnection = MM_pigo_STRING
    PengeluaranSC_H_CMD.commandText = "exec sp_add_MKT_T_PengeluaranSC_H '"& pscType &"', '"& pscTanggal &"','"& pscDesc &"', '"& pscDelRule &"', '"& pscDelVia &"', '"& pscDelPriority &"', '"& pscFCRule &"', "& pscSubtotal &", '"& psc_permID &"',  '"& psc_custID &"'"
    response.write PengeluaranSC_H_CMD.commandText & "<br><br>"
    set PengeluaranSC_H = PengeluaranSC_H_CMD.execute

    set Permintaan_CMD = server.CreateObject("ADODB.command")
    Permintaan_CMD.activeConnection = MM_pigo_STRING
    Permintaan_CMD.commandText = "SELECT count(MKT_T_Permintaan_Barang_D.Perm_pdID) as total FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE permID = '"& psc_permID &"'  "
    response.write Permintaan_CMD.commandText & "<br><br>"
    set JMLPerm = Permintaan_CMD.execute
    response.write JMLPerm("total") & "<br><br>"

    Permintaan_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_D.Perm_pdUpTo,  MKT_T_Permintaan_Barang_D.Perm_pdTax FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MKT_T_Permintaan_Barang_H.PermID = '"& psc_permID &"' )  "
    response.write Permintaan_CMD.commandText & "<br><br>"
    set Permintaan_D = Permintaan_CMD.execute
    response.write Permintaan_D.eof & "<br><br>"

    no = 0
    Do While Not Permintaan_D.eof
    no = no + 1
    nourut=right("000"&no,3)

    pscIDH          = PengeluaranSC_H("id")&nourut
    pscD_pdID       = Permintaan_D("Perm_pdID")
    pscD_pdQty      = Permintaan_D("Perm_pdQty")
    pscD_pdHarga    = Permintaan_D("Perm_pdHargaJual")
    pscD_pdUpTo     = Permintaan_D("Perm_pdUpTo")
    pscD_pdTaxID    = Permintaan_D("Perm_pdTax")

    JMLpd = JMLPerm("total")
    jumlah = split(JMLpd)

        for i = 0 to Ubound(jumlah)

            PengeluaranSC_H_CMD.commandText = " INSERT INTO [dbo].[MKT_T_PengeluaranSC_D]([pscIDH],[pscD_pdID],[pscD_pdQty],[pscD_pdHargaJual],[pscD_pdUpTo],[pscD_pdTaxID],[pscD_AktifYN])VALUES('"& pscIDH &"','"& pscD_pdID &"',"& pscD_pdQty &","& pscD_pdHarga &","& pscD_pdUpTo &",'"& pscD_pdTaxID &"','Y') "
            response.write PengeluaranSC_H_CMD.commandText & "<br><br>"
            set PengeluaranSC_D = PengeluaranSC_H_CMD.execute

        next

        set Produk_CMD = server.CreateObject("ADODB.command")
        Produk_CMD.activeConnection = MM_pigo_STRING
        Produk_CMD.commandText = "SELECT pdID, pdStokAwal From MKT_M_PIGO_Produk WHERE pdID = '"& pscD_pdID &"' "
        set Produk = Produk_CMD.execute

        Stok       = Produk("pdStokAwal")
        StokAkhir  = Stok-pscD_pdQty 

        Produk_CMD.commandText = "UPDATE MKT_M_PIGO_Produk set pdStokAwal = '"& StokAkhir &"' WHERE pdID = '"& Permintaan_D("Perm_pdID") &"'"
        set UpdateProduk = Produk_CMD.execute 

    Permintaan_D.movenext
    loop

    set Update_CMD = server.CreateObject("ADODB.command")
    Update_CMD.activeConnection = MM_pigo_STRING
    Update_CMD.commandText = "Update MKT_T_Permintaan_Barang_H set Perm_PSCBYN = 'Y' Where PermID = '"& psc_permID &"' "
    response.write Update_CMD.commandText
    set UpdatePerm = Update_CMD.execute

    If Perm_trYN = "Y" then

    Update_CMD.commandText = "UPDATE MKT_T_Transaksi_D1 set tr_strID = '01' where left(trD1,12) = '"& Perm_trID &"'  "
    response.write Update_CMD.commandText
    set Update = Update_CMD.execute

    else

    response.redirect "List-PSCB.asp"

    end if

%>