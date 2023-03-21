<!--#include file="../connections/pigoConn.asp"-->
<!--#INCLUDE file="../aspJSON.asp" -->

<% 
    server.ScriptTimeout=60000

    tr_rkID                 = request.form("RekeningID")
    tr_rkBankID             = request.form("BankID")
    tr_rkNomorRk            = request.form("NomorRekening")
    almID                   = request.form("AlamatID")
    trJenisPembayaran       = request.form("jenispembayaran")
    trTotalPembayaran       = request.form("totalbayar")
    totalseller             = request.form("no")
    totalproduk             = request.form("grandtotalqty")

    set Transaksi_H_CMD = server.CreateObject("ADODB.command")
    Transaksi_H_CMD.activeConnection = MM_pigo_STRING
    Transaksi_H_CMD.commandText = "exec sp_add_MKT_T_Transaksi_H  '"& Date() &"','"& request.cookies("custID") &"','"& almID &"','"& tr_rkNomorRk &"','"& tr_rkBankID &"',1000,1000,'"& trTotalPembayaran &"','N','','','','','','','01'"
    'response.write Transaksi_H_CMD.commandText &"<br><br>"
    set Transaksi_H = Transaksi_H_CMD.execute 

    ' set Permintaan_Barang_H_CMD = server.CreateObject("ADODB.command")
    ' Permintaan_Barang_H_CMD.activeConnection = MM_pigo_STRING
    ' Permintaan_Barang_H_CMD.commandText = "exec sp_add_MKT_T_Permintaan_Barang '"& Transaksi_H("id") &"','"& Date() &"',1,'','N','"& request.cookies("custID") &"','00','04','Y' "
    ' 'response.write Permintaan_Barang_H_CMD.commandText &"<br><br>"
    ' set Permintaan_Barang_H = Permintaan_Barang_H_CMD.execute
    
    IDTransaksi = Transaksi_H("id")

    ' SEND TO XENDIT 
        Dim objHttp
        Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim url, payload
        url = "https://api.xendit.co/v2/invoices"
        payload = "{" & _
                    """external_id"" :" & """" & IDTransaksi & """" & "," & _
                    """amount"" :" & """" & trTotalPembayaran & """" & ","  & _
                    """success_redirect_url"" : ""http://192.168.50.8/pigo/Customer/Pesanan/""," & _
                    """invoice_duration"" : 3600" & _
                    "}"

        objHttp.Open "POST", url, False
        objHttp.setRequestHeader "Content-Type", "application/json"
        objHttp.setRequestHeader "Authorization", "Basic eG5kX2RldmVsb3BtZW50X2p3NzllSVVBTWQwTEdjd1B4S1hDcVdtZU1rVnpnZndJSlQzMlJMTUlvWTFvUjVWTkdqeEFsdmpOWkNHZmxDZDo"
        objHttp.send payload
        strReturn = objHTTP.responseText
        'response.write strReturn
    ' SEND TO XENDIT 

    ' GET INVOICE 
        Dim objHttpp
        Set objHttpp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim urlGet, payloadGet
        urlGet = "https://api.xendit.co/v2/invoices/?external_id="& IDTransaksi &""
        objHttpp.Open "GET", url, False
        objHttpp.setRequestHeader "Content-Type", "application/json"
        objHttpp.setRequestHeader "Authorization", "Basic eG5kX2RldmVsb3BtZW50X2p3NzllSVVBTWQwTEdjd1B4S1hDcVdtZU1rVnpnZndJSlQzMlJMTUlvWTFvUjVWTkdqeEFsdmpOWkNHZmxDZDo"
        objHttpp.send payloadGet
        strReturnGet = objHTTPp.responseText

        Set oJSON = New aspJSON
        oJSON.loadJSON(strReturnGet)

        For Each result In oJSON.data

            Set this = oJSON.data.item(data)

            id              = this.item("id")
            Link_Payment    = this.item("invoice_url")
            Pay_Expired     = this.item("expiry_date")
            Pay_Status      = this.item("status")

            set Transaksi_H_CMD = server.CreateObject("ADODB.command")
            Transaksi_H_CMD.activeConnection = MM_pigo_STRING
            Transaksi_H_CMD.commandText = "UPDATE MKT_T_Transaksi_H set tr_LinkPayment = '"& Link_Payment &"', tr_PayExpired = '"& Pay_Expired &"', tr_StatusPayment = '"& Pay_Status &"' Where trID = '"& IDTransaksi &"'"
            set Transaksi_H = Transaksi_H_CMD.execute

        next
    
    urut=0

    slID                = request.form("slid")
    tr_almIDs           = request.form("SAlamatID")
    tr_rkNomorRks       = request.form("SNomorRekening")
    tr_rkBankIDs        = request.form("SBankID")
    trJenisPengiriman   = request.form("pengiriman-sl")
    trongkir            = request.form("ongkir-seller")
    trD1catatan         = request.form("catatan-sl")

    if trD1Catatan = "" then
        trD1Catatan = "Tanpa Catatan"
    end if

    sellerid            = split(trim(slID),",")
    alamatsellerid      = split(trim(tr_almIDs),",")
    nomorrk             = split(trim(tr_rkNomorRks),",")
    bankid              = split(trim(tr_rkBankIDs),",")
    pengiriman          = split(trim(trJenisPengiriman),",")
    ongkir              = split(trim(trongkir),",")
    catatan             = split(trim(trD1catatan),",")

    for i = 0 to Ubound(sellerid)

        'response.write sellerid(i) &"<br><br>"
        urut            = urut + 1
        txturut         = right("000"&urut,3)

        set Transaksi_D1_CMD = server.CreateObject("ADODB.command")
        Transaksi_D1_CMD.activeConnection = MM_pigo_STRING
        
        Transaksi_D1_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Transaksi_D1]([trD1],[tr_slID],[tr_almID],[tr_rkNomorRK],[tr_BankID],[trD1catatan],[trPengiriman],[trBiayaOngkir],[trAsuransi],[trBAsuransi],[trPacking],[trBPacking],[tr_Diskon],[tr_BiayaLayanan],[tr_IDBooking],[tr_strID],[trD1AktifYN])VALUES('"& IDTransaksi&txturut &"','"& sellerid(i) &"','"& alamatsellerid(i) &"','"& nomorrk(i) &"','"& bankid(i) &"','"& catatan(i) &"','"& pengiriman(i) &"',"& ongkir(i) &",'N',0,'N',0,'','00','','00','Y')"
        'response.write Transaksi_D1_CMD.commandText &"<br><br>"
        set Transaksi_D1 = Transaksi_D1_CMD.execute

        Transaksi_D1    = sellerid(i)

        no              = 0
        pdID            = request.form("pdID")
        pdHarga         = request.form("pdHargaJual")
        qty             = request.form("pdQty")
        ProteksiYN      = request.form("pdProteksiYN")
        BiayaProteksi   = request.form("pdBiayaProteksi")
        'response.write ProteksiYN
        'response.write BiayaProteksi

        produkid        = split(trim(pdID),", ")
        harga           = split(trim(pdHarga),", ")
        jumlah          = split(trim(qty),", ")
        proteksi        = split(trim(ProteksiYN),", ")
        proteksibiaya   = split(trim(BiayaProteksi),", ")

    next

        for a = 0 to Ubound(produkid)

            no          = no + 1
            nourut      = right("0000"&no,4)

                set Transaksi_D1A_CMD = server.CreateObject("ADODB.command")
                Transaksi_D1A_CMD.activeConnection = MM_pigo_STRING
                Transaksi_D1A_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Transaksi_D1A]([trD1A],[tr_pdID],[tr_pdHarga],[tr_pdQty],[tr_ProteksiYN],[tr_BiayaProteksi],[trD1AAktifYN])VALUES('"& IDTransaksi &"','"& produkid(a) &"',"& harga(a) &","& jumlah(a) &",'"& proteksi(a) &"','"& proteksibiaya(a) &"','Y')"
                'response.write Transaksi_D1A_CMD.commandText &"<br><br>"
                set Transaksi_D1A = Transaksi_D1A_CMD.execute

                ' set Permintaan_Barang_D_CMD = server.CreateObject("ADODB.command")
                ' Permintaan_Barang_D_CMD.activeConnection = MM_pigo_STRING
                ' Permintaan_Barang_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Permintaan_Barang_D]([Perm_IDH],[Perm_pdID],[Perm_pdQty],[Perm_pdHargaJual],[Perm_pdUpTo],[Perm_pdTax],[Perm_AktifYN])VALUES('"& Permintaan_Barang_H("id") &"','"& produkid(a) &"',"& jumlah(a) &","& harga(a) &",0,0,'Y')"
                ' 'response.write Permintaan_Barang_D_CMD.commandText &"<br><br>"
                ' set Permintaan_Barang_D = Permintaan_Barang_D_CMD.execute

                ' set Update_CMD = server.CreateObject("ADODB.command")
                ' Update_CMD.activeConnection = MM_pigo_STRING
                ' Update_CMD.commandText = "INSERT INTO [dbo].[MKT_M_Stok]([st_Tanggal],[st_pdID],[st_pdQty],[st_pdHarga],[st_pdStatus],[st_updateID],[st_UpdateTime],[st_AktifYN])VALUES('"& now() &"','"& produkid(a) &"',"& jumlah(a) &","& harga(a) &",2,'"& request.cookies("custID") &"','"& now() &"','Y')"
                ' 'response.write  Update_CMD.commandText &"<br><br>"
                ' set Update = Update_CMD.execute

                ' set delete_CMD = server.CreateObject("ADODB.command")
                ' delete_CMD.activeConnection = MM_pigo_STRING
                ' delete_CMD.commandText = "DELETE FROM [dbo].[MKT_T_Keranjang] WHERE cart_custID ='"& request.Cookies("custID") &"' and cart_pdID = '"& produkid(a) &"'"
                ' 'response.write delete_CMD.commandText &"<br><br>"
                ' set delete = delete_CMD.execute

        next

        response.redirect Link_Payment
%>


