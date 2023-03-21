<!--#INCLUDE file="../aspJSON.asp" -->
<%

    ' Cek Transaksi ( Status Pembayaran - N ) 

        set Transaksi_H_CMD = server.CreateObject("ADODB.command")
        Transaksi_H_CMD.activeConnection = MM_pigo_STRING

        Transaksi_H_CMD.commandText = "SELECT  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trPembayaranYN, MKT_T_Transaksi_D1.tr_IDBooking FROM MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1,12) WHERE trPembayaranYN = 'N' AND tr_custID = '"& request.cookies("custID") &"'"
        set Transaksi = Transaksi_H_CMD.execute 
        
    do while not Transaksi.eof

        Dim objHttp
        Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim url, payload
        url = "https://api.xendit.co/v2/invoices/?external_id="& Transaksi("trID") &""
        objHttp.Open "GET", url, False
        objHttp.setRequestHeader "Content-Type", "application/json"
        objHttp.setRequestHeader "Authorization", "Basic eG5kX2RldmVsb3BtZW50X2p3NzllSVVBTWQwTEdjd1B4S1hDcVdtZU1rVnpnZndJSlQzMlJMTUlvWTFvUjVWTkdqeEFsdmpOWkNHZmxDZDo"
        objHttp.send payload
        strReturn = objHTTP.responseText

        Set oJSON = New aspJSON
        oJSON.loadJSON(strReturn)

        For Each result In oJSON.data

            Set this = oJSON.data.item(data)

            id = this.item("id")
            JenisPay  = this.item("payment_method")
            BankCode  = this.item("bank_code")
            PayStatus = this.item("status")
            PaidAt    = this.item("paid_at")
            
            if PayStatus = "SETTLED" then 

                Dim panjang,tinggi,lebar,ukuran,key,Booking_AsalName,Booking_AsalAlamat,Booking_AsalKota,Booking_AsalKecamatan,Booking_AsalKelurahan,Booking_AsalKodepos,Booking_AsalTelp,Booking_asalTelp2,Booking_AsalEmail,Booking_TujuanNama,Booking_TujuanAlamat,Booking_TujuanKota,Booking_TujuanTelp,Booking_TujuanTelp2,Booking_TujuanKelurahan,Booking_TujuanKecamatan,Booking_TujuanPulau,Booking_TujuanKodepos,Booking_TujuanEmail,Booking_Pembayaran,Booking_Up,Booking_Ket,Booking_NoSuratJalan,Booking_NamaBarang,Booking_JenisHarga,Booking_JmlUnit,Booking_Berat,Booking_Beratvol,Booking_Ukuran,Booking_Harga,Booking_Service,Booking_servID,Booking_PackingYN,Booking_AsuransiYN,Booking_NilaiBarang,Booking_Lat,Booking_Lon,Booking_PackingHarga,Order
                set API_cmd = server.createObject("ADODB.COMMAND")
                API_cmd.activeConnection = MM_PIGO_String
                API_cmd.commandText = " SELECT * FROM GLB_M_API_Int where APIName = 'DBS' "
                set API = API_cmd.execute

                    set Transaksi_CMD = server.CreateObject("ADODB.command")
                    Transaksi_CMD.activeConnection = MM_pigo_STRING

                    Transaksi_CMD.commandText = "SELECT MKT_T_Transaksi_H.tr_custID, MKT_T_Transaksi_H.trPembayaranYN, Pengirim.custNama AS NamaSeller, AlamatPengirim.almLengkap AS AlmPengirim, AlamatPengirim.almKel AS KelPengirim, AlamatPengirim.almKota AS KotaPengirim, AlamatPengirim.almKec AS KecPengirim, Pengirim.custPhone1 AS PhonePengirim1, Pengirim.custPhone2 AS PhonePengirim2, AlamatPengirim.almKdpos AS KPosPengirim, Pengirim.custEmail AS EmailPengirim, AlamatPenerima.alm_custID, Penerima.custNama AS NamaPenerima, AlamatPenerima.almLengkap AS AlmPenerima, AlamatPenerima.almKec AS KecPenerima, Penerima.custPhone1 AS PhonePenerima1, Penerima.custPhone2 AS PhonePenerima2, AlamatPenerima.almKel AS KelPenerima, AlamatPenerima.almProvinsi AS ProvPenerima, AlamatPenerima.almKota AS KotaPenerima, AlamatPenerima.almKdpos AS KPosPenerima, Penerima.custEmail AS EmailPenerima, MKT_T_Transaksi_H.trID AS NoPesanan,SUM(MKT_T_Transaksi_D1A.tr_pdQty) AS TotalQty, SUM(MKT_M_PIGO_Produk.pdBerat) AS Berat, SUM(MKT_M_PIGO_Produk.pdPanjang*MKT_M_PIGO_Produk.pdLebar*MKT_M_PIGO_Produk.pdTinggi) AS Ukuran, SUM(MKT_M_PIGO_Produk.pdVolume) AS Volume, MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_D1.trPengiriman, AlamatPengirim.almLatt, AlamatPengirim.almLong,MKT_T_Transaksi_D1.trBiayaOngkir  FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_M_Alamat AS AlamatPenerima RIGHT OUTER JOIN MKT_M_Customer AS Penerima ON AlamatPenerima.alm_custID = Penerima.custID ON MKT_T_Transaksi_H.tr_custID = Penerima.custID ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_M_Customer AS Pengirim LEFT OUTER JOIN MKT_M_Alamat AS AlamatPengirim ON Pengirim.custID = AlamatPengirim.alm_custID RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON Pengirim.custID = MKT_T_Transaksi_D1.tr_slID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) WHERE (AlamatPenerima.almJenis <> 'Alamat Toko') AND (MKT_T_Transaksi_H.trID = '"& Transaksi("trID") &"') AND (MKT_T_Transaksi_H.trPembayaranYN = 'N') GROUP BY MKT_T_Transaksi_H.tr_custID, MKT_T_Transaksi_H.trPembayaranYN, Pengirim.custNama, AlamatPengirim.almLengkap, AlamatPengirim.almKel,AlamatPengirim.almKota, AlamatPengirim.almKec,Pengirim.custPhone1, Pengirim.custPhone2, AlamatPengirim.almKdpos,Pengirim.custEmail, AlamatPenerima.alm_custID, Penerima.custNama, AlamatPenerima.almLengkap,AlamatPenerima.almKec,Penerima.custPhone1,Penerima.custPhone2 , AlamatPenerima.almKel, AlamatPenerima.almProvinsi, AlamatPenerima.almKota,AlamatPenerima.almKdpos, Penerima.custEmail, MKT_T_Transaksi_H.trID,  MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_D1.trPengiriman, AlamatPengirim.almLatt, AlamatPengirim.almLong, MKT_T_Transaksi_D1.trBiayaOngkir"
                    set BookingID = Transaksi_CMD.execute

                        Order                       = "ORDER-PIGO-" & TransaksiID & "-" & date()
                        key                         = "304139a7188354d7e6f7651b5673a264"
                        Booking_AsalName            = BookingID("NamaSeller") 
                        Booking_AsalAlamat          = BookingID("AlmPengirim")
                        Booking_AsalKota            = BookingID("KotaPengirim")
                        Booking_AsalKecamatan       = BookingID("KecPengirim")
                        Booking_AsalKelurahan       = BookingID("KelPengirim") 
                        Booking_AsalKodepos         = BookingID("KPosPengirim")
                        Booking_AsalTelp            = BookingID("PhonePengirim1") 
                        Booking_asalTelp2           = BookingID("PhonePengirim2")
                        Booking_AsalEmail           = BookingID("EmailPengirim")
                        Booking_TujuanNama          = BookingID("NamaPenerima") 
                        Booking_TujuanAlamat        = BookingID("AlmPenerima")
                        Booking_TujuanKota          = BookingID("KotaPenerima")
                        Booking_TujuanTelp          = BookingID("PhonePenerima1")
                        Booking_TujuanTelp2         = BookingID("PhonePenerima2")
                        Booking_TujuanKelurahan     = BookingID("KelPenerima") 
                        Booking_TujuanKecamatan     = BookingID("KecPenerima")
                        Booking_TujuanPulau         = BookingID("ProvPenerima")
                        Booking_TujuanKodepos       = BookingID("KPosPenerima")
                        Booking_TujuanEmail         = BookingID("EmailPenerima") 
                        Booking_Pembayaran          = 1
                        Booking_Up                  = "G"
                        Booking_Ket                 = "F"
                        Booking_NoSuratJalan        = BookingID("NoPesanan") 
                        Booking_NamaBarang          = Order
                        Booking_JenisHarga          = 1 
                        Booking_JmlUnit             = BookingID("TotalQty") 
                        Booking_Berat               = BookingID("Berat") 
                        Booking_Beratvol            = BookingID("Volume") 
                        Booking_Ukuran              = BookingID("Ukuran")  
                        Booking_Harga               = BookingID("trBiayaOngkir") 
                        Booking_Service             = BookingID("trPengiriman") 
                        Booking_servID              = 1
                        Booking_PackingYN           = "N"
                        Booking_AsuransiYN          = "N"
                        Booking_NilaiBarang         = 0
                        Booking_Lat                 = BookingID("almLatt") 
                        Booking_Lon                 = BookingID("almLong") 
                        Booking_PackingHarga        = 0

                        Dim objHttpp
                        Set objHttpp = Server.CreateObject("Microsoft.XMLHTTP")

                        Dim urll, payloadd
                        urll = "http://103.111.190.162/dbs/customerapps/orderBooking/add/?key=304139a7188354d7e6f7651b5673a264&Booking_AsalName="& Booking_AsalName &"&Booking_AsalAlamat="& Booking_AsalAlamat &"&Booking_AsalKota="& Booking_AsalKota &"&Booking_AsalKecamatan="& Booking_AsalKecamatan &"&Booking_AsalKelurahan="& Booking_AsalKelurahan &"&Booking_AsalKodepos="& Booking_AsalKodepos &"&Booking_AsalTelp="& Booking_AsalTelp &"&Booking_asalTelp2="& Booking_asalTelp2 &"&Booking_AsalEmail="& Booking_AsalEmail &"&Booking_TujuanNama="& Booking_TujuanNama &"&Booking_TujuanAlamat="& Booking_TujuanAlamat &"&Booking_TujuanKota="& Booking_TujuanKota &"&Booking_TujuanTelp2="& Booking_TujuanTelp2 &"&Booking_TujuanKelurahan="& Booking_TujuanKelurahan &"&Booking_TujuanKecamatan="& Booking_TujuanKecamatan &"&Booking_TujuanPulau="& Booking_TujuanPulau &"&Booking_TujuanKodepos="& Booking_TujuanKodepos &"&Booking_TujuanEmail="& Booking_TujuanEmail &"&Booking_Pembayaran="& Booking_Pembayaran &"&Booking_Up="& Booking_Up &"&Booking_Ket="& Booking_Ket &"&Booking_NoSuratJalan="& TransaksiID &"&Booking_NamaBarang="& Order &"&Booking_JenisHarga="& Booking_JenisHarga &"&Booking_JmlUnit="& Booking_JmlUnit &"&Booking_Berat="& Booking_Berat &"&Booking_Beratvol="& Booking_Beratvol &"&Booking_Ukuran="& Booking_Ukuran &"&Booking_Harga="& Booking_Harga &"&Booking_Service="& Booking_Service &"&Booking_servID="& Booking_servID &"&Booking_PackingYN="& Booking_PackingYN &"&Booking_AsuransiYN="& Booking_AsuransiYN &"&Booking_NilaiBarang="& Booking_NilaiBarang &"&Booking_Lat="& Booking_Lat &"&Booking_Lon="& Booking_Lon &"&Booking_PackingHarga="& Booking_PackingHarga &""
                        objHttpp.Open "GET", urll, False
                        objHttpp.setRequestHeader "Content-Type", "application/json"
                        objHttpp.send payloadd

                        CreateBooking = objHTTPP.responseText

                        Set BookingJSON = New aspJSON
                        BookingJSON.loadJSON(CreateBooking)

                        Set thiss = BookingJSON.data
                        BookingID = thiss.item("BOOKING ID")

                        set Transaksi_CMD = server.CreateObject("ADODB.command")
                        Transaksi_CMD.activeConnection = MM_pigo_STRING

                        Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_H set trJenisPembayaran = '"& JenisPay &"' ,  trPembayaranYN = 'Y', tr_spID = '02', tr_BankCode = '"& BankCode &"', tr_StatusPayment = '"& PayStatus &"', tr_PaidAt = '"& PaidAt &"' Where trID = '"& Transaksi("trID") &"'"
                        response.write Transaksi_CMD.commandText &"<br><br>"
                        set UpdateTransaksiH = Transaksi_CMD.execute

                        Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_D1 set tr_IDBooking = '"& BookingID &"', tr_strID = '01'  Where Left(trD1,12) = '"& Transaksi("trID") &"' "
                        response.write Transaksi_CMD.commandText &"<br><br>"
                        set UpdateTransaksiD = Transaksi_CMD.execute
            Else
        
                set Transaksi_CMD = server.CreateObject("ADODB.command")
                Transaksi_CMD.activeConnection = MM_pigo_STRING

                PembayaranYN    = "X"
                StatusTransaksi = "04"
                StatusPembayaran = "03"

                Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_H set trJenisPembayaran = '"& JenisPay &"' ,  trPembayaranYN = '"& PembayaranYN &"', tr_spID = '"& StatusPembayaran &"', tr_BankCode = '"& BankCode &"', tr_StatusPayment = '"& PayStatus &"', tr_PaidAt = '"& PaidAt &"' Where trID = '"& Transaksi("trID") &"'"
                'response.write Transaksi_CMD.commandText &"<br><br>"
                set UpdateTransaksiH = Transaksi_CMD.execute

                Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_D1 set tr_IDBooking = '"& BookingID &"', tr_strID = '"& StatusTransaksi &"' Where Left(trD1,12) = '"& Transaksi("trID") &"' "
                'response.write Transaksi_CMD.commandText &"<br><br>"
                set UpdateTransaksiD = Transaksi_CMD.execute

            end if 

        Next

    Transaksi.movenext
    loop
%>

