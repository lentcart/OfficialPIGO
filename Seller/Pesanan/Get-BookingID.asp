<!--#include file="../../connections/pigoConn.asp"-->
<!--#INCLUDE file="../../aspJSON.asp" -->
<%

    JumlahUnit          = request.queryString("jmlunit")
    TransaksiID         = request.queryString("trID")
    custID              = request.queryString("custID")
    SellerID            = request.queryString("slID")

    Dim panjang,tinggi,lebar,ukuran,key,Booking_AsalName,Booking_AsalAlamat,Booking_AsalKota,Booking_AsalKecamatan,Booking_AsalKelurahan,Booking_AsalKodepos,Booking_AsalTelp,Booking_asalTelp2,Booking_AsalEmail,Booking_TujuanNama,Booking_TujuanAlamat,Booking_TujuanKota,Booking_TujuanTelp,Booking_TujuanTelp2,Booking_TujuanKelurahan,Booking_TujuanKecamatan,Booking_TujuanPulau,Booking_TujuanKodepos,Booking_TujuanEmail,Booking_Pembayaran,Booking_Up,Booking_Ket,Booking_NoSuratJalan,Booking_NamaBarang,Booking_JenisHarga,Booking_JmlUnit,Booking_Berat,Booking_Beratvol,Booking_Ukuran,Booking_Harga,Booking_Service,Booking_servID,Booking_PackingYN,Booking_AsuransiYN,Booking_NilaiBarang,Booking_Lat,Booking_Lon,Booking_PackingHarga,Order


    set API_cmd = server.createObject("ADODB.COMMAND")
    API_cmd.activeConnection = MM_PIGO_String
    API_cmd.commandText = " SELECT * FROM GLB_M_API_Int where APIName = 'DBS' "
    set API = API_cmd.execute

        set Transaksi_CMD = server.CreateObject("ADODB.command")
        Transaksi_CMD.activeConnection = MM_pigo_STRING

        Transaksi_CMD.commandText = "SELECT MKT_T_Transaksi_H.tr_custID, MKT_T_Transaksi_H.trPembayaranYN, Pengirim.custNama AS NamaSeller, AlamatPengirim.almLengkap AS AlmPengirim, AlamatPengirim.almKel AS KelPengirim,  AlamatPengirim.almKota AS KotaPengirim, AlamatPengirim.almKec AS KecPengirim, Pengirim.custPhone1 AS PhonePengirim1, Pengirim.custPhone2 AS PhonePengirim2, AlamatPengirim.almKdpos AS KPosPengirim,  Pengirim.custEmail AS EmailPengirim, AlamatPenerima.alm_custID, Penerima.custNama AS NamaPenerima, AlamatPenerima.almLengkap AS AlmPenerima, AlamatPenerima.almKec AS KecPenerima,  Penerima.custPhone1 AS PhonePenerima1, Penerima.custPhone2 AS PhonePenerima2, AlamatPenerima.almKel AS KelPenerima, AlamatPenerima.almProvinsi AS ProvPenerima, AlamatPenerima.almKota AS KotaPenerima,  AlamatPenerima.almKdpos AS KPosPenerima, AlamatPenerima.almLatt AS LattPenerima, AlamatPenerima.almLong AS LongPenerima, Penerima.custEmail AS EmailPenerima, MKT_T_Transaksi_H.trID AS NoPesanan,  SUM(MKT_T_Transaksi_D1A.tr_pdQty) AS TotalQty, SUM(MKT_M_PIGO_Produk.pdBerat) AS Berat, SUM(MKT_M_PIGO_Produk.pdPanjang * MKT_M_PIGO_Produk.pdLebar * MKT_M_PIGO_Produk.pdTinggi) AS Ukuran,  SUM(MKT_M_PIGO_Produk.pdVolume) AS Volume, MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_D1.trPengiriman, AlamatPengirim.almLatt AS LattPengirim, AlamatPengirim.almLong AS LongPengirim,  MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_H.trJenisPembayaran, SUM(MKT_T_Transaksi_D1A.tr_pdHarga*MKT_T_Transaksi_D1A.tr_pdQty) AS NilaiBarang FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_M_Alamat AS AlamatPenerima RIGHT OUTER JOIN MKT_M_Customer AS Penerima ON AlamatPenerima.alm_custID = Penerima.custID ON MKT_T_Transaksi_H.tr_custID = Penerima.custID ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_M_Customer AS Pengirim LEFT OUTER JOIN MKT_M_Alamat AS AlamatPengirim ON Pengirim.custID = AlamatPengirim.alm_custID RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON Pengirim.custID = MKT_T_Transaksi_D1.tr_slID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) WHERE (AlamatPenerima.almJenis <> 'Alamat Toko') AND (MKT_T_Transaksi_H.trID = '"& TransaksiID &"') AND MKT_T_Transaksi_H.tr_custID = '"& custID &"' AND MKT_T_Transaksi_D1.tr_slID = '"& SellerID &"' GROUP BY MKT_T_Transaksi_H.tr_custID, MKT_T_Transaksi_H.trPembayaranYN, Pengirim.custNama, AlamatPengirim.almLengkap, AlamatPengirim.almKel, AlamatPengirim.almKota, AlamatPengirim.almKec, Pengirim.custPhone1,  Pengirim.custPhone2, AlamatPengirim.almKdpos, Pengirim.custEmail, AlamatPenerima.alm_custID, Penerima.custNama, AlamatPenerima.almLengkap, AlamatPenerima.almKec, Penerima.custPhone1, Penerima.custPhone2,  AlamatPenerima.almKel, AlamatPenerima.almProvinsi, AlamatPenerima.almKota, AlamatPenerima.almKdpos, AlamatPenerima.almLatt, AlamatPenerima.almLong, Penerima.custEmail, MKT_T_Transaksi_H.trID,  MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_D1.trPengiriman, AlamatPengirim.almLatt, AlamatPengirim.almLong, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_H.trJenisPembayaran"
        set BookingID = Transaksi_CMD.execute

        if  JumlahUnit = "Y" then 
            Booking_JmlUnit             = 1
        else
            Booking_JmlUnit             = BookingID("TotalQty")
        end if 

        if  BookingID("trJenisPembayaran")  = "BANK_TRANSFER" then 
            Booking_Pembayaran              = "7"
        end if 

        Order                       = "ORDER-PIGO-" & TransaksiID 
        key                         = "304139a7188354d7e6f7651b5673a264"
        Booking_AsalName            = BookingID("NamaSeller") 
        Booking_AsalAlamat          = BookingID("AlmPengirim")
        Booking_AsalKota            = BookingID("KotaPengirim")
        Booking_AsalKecamatan       = BookingID("KecPengirim")
        Booking_AsalKelurahan       = BookingID("KelPengirim") 
        Booking_AsalKodepos         = BookingID("KPosPengirim")
        Booking_AsalTelp            = BookingID("PhonePengirim1") 
        Booking_asalTelp2           = BookingID("PhonePengirim2")
        Booking_AsalEmail           = Replace(BookingID("EmailPengirim"),"@","(at)")
        Booking_TujuanNama          = BookingID("NamaPenerima") 
        Booking_TujuanAlamat        = BookingID("AlmPenerima")
        Booking_TujuanKota          = BookingID("KotaPenerima")
        Booking_TujuanTelp          = BookingID("PhonePenerima1")
        Booking_TujuanTelp2         = BookingID("PhonePenerima2")
        Booking_TujuanKelurahan     = BookingID("KelPenerima") 
        Booking_TujuanKecamatan     = BookingID("KecPenerima")
        Booking_TujuanPulau         = BookingID("ProvPenerima")
        Booking_TujuanKodepos       = BookingID("KPosPenerima")
        Booking_TujuanEmail         = Replace(BookingID("EmailPenerima"),"@","(at)")
        Booking_Pembayaran          = Booking_Pembayaran 
        Booking_Up                  = ""
        Booking_Ket                 = TransaksiID
        Booking_NoSuratJalan        = TransaksiID 
        Booking_NamaBarang          = Order
        Booking_JenisHarga          = 1 'Reguler
        Booking_JmlUnit             = Booking_JmlUnit 
        Booking_Berat               = BookingID("Berat")/1000 
        Booking_Beratvol            = BookingID("Volume")/1000
        Booking_Ukuran              = BookingID("Ukuran")  
        Booking_Harga               = BookingID("trBiayaOngkir") 
        Booking_Service             = BookingID("trPengiriman") 
        Booking_servID              = 1
        Booking_PackingYN           = "N"
        Booking_AsuransiYN          = "N"
        Booking_NilaiBarang         = BookingID("NilaiBarang") 
        Booking_Lat                 = BookingID("LattPengirim") 
        Booking_Lon                 = BookingID("LongPengirim") 
        Booking_PackingHarga        = BookingID("Ukuran")*0.7+12000
        Booking_VerificationID      = Right(TransaksiID,6)
        Booking_AktifYN             = "Y"
        Booking_DimensiBarang       = "B00" 'Reguler
        Booking_LatPenerima         = BookingID("LattPenerima") 
        Booking_LonPenerima         = BookingID("LongPenerima") 

        Dim objHttpp
        Set objHttpp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim urll, payloadd
        urll = "http://103.111.190.162/dbs/customerapps/orderBooking/add/?key=304139a7188354d7e6f7651b5673a264&Booking_AsalName="& Booking_AsalName &"&Booking_AsalAlamat="& Booking_AsalAlamat &"&Booking_AsalKota="& Booking_AsalKota &"&Booking_AsalKecamatan="& Booking_AsalKecamatan &"&Booking_AsalKelurahan="& Booking_AsalKelurahan &"&Booking_AsalKodepos="& Booking_AsalKodepos &"&Booking_AsalTelp="& Booking_AsalTelp &"&Booking_asalTelp2="& Booking_asalTelp2 &"&Booking_AsalEmail="& Booking_AsalEmail &"&Booking_TujuanNama="& Booking_TujuanNama &"&Booking_TujuanAlamat="& Booking_TujuanAlamat &"&Booking_TujuanKota="& Booking_TujuanKota &"&Booking_TujuanTelp2="& Booking_TujuanTelp2 &"&Booking_TujuanKelurahan="& Booking_TujuanKelurahan &"&Booking_TujuanKecamatan="& Booking_TujuanKecamatan &"&Booking_TujuanPulau="& Booking_TujuanPulau &"&Booking_TujuanKodepos="& Booking_TujuanKodepos &"&Booking_TujuanEmail="& Booking_TujuanEmail &"&Booking_Pembayaran="& Booking_Pembayaran &"&Booking_Up="& Booking_Up &"&Booking_Ket="& Booking_Ket &"&Booking_NoSuratJalan="& TransaksiID &"&Booking_NamaBarang="& Order &"&Booking_JenisHarga="& Booking_JenisHarga &"&Booking_JmlUnit="& Booking_JmlUnit &"&Booking_Berat="& Booking_Berat &"&Booking_Beratvol="& Booking_Beratvol &"&Booking_Ukuran="& Booking_Ukuran &"&Booking_Harga="& Booking_Harga &"&Booking_Service="& Booking_Service &"&Booking_servID="& Booking_servID &"&Booking_PackingYN="& Booking_PackingYN &"&Booking_AsuransiYN="& Booking_AsuransiYN &"&Booking_NilaiBarang="& Booking_NilaiBarang &"&Booking_Lat="& Booking_Lat &"&Booking_Lon="& Booking_Lon &"&Booking_PackingHarga="& Booking_PackingHarga &"&Booking_VerificationID="& Booking_VerificationID &"&Booking_AktifYN="& Booking_AktifYN &"&Booking_DimensiBarang="& Booking_DimensiBarang &"&Booking_LatPenerima="& Booking_LatPenerima &"&Booking_LonPenerima="& Booking_LonPenerima &""
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

        Transaksi_CMD.commandText = "UPDATE MKT_T_Transaksi_D1 set tr_IDBooking = '"& BookingID &"', tr_strID = '02'  Where Left(trD1,12) = '"& TransaksiID &"' "
        set UpdateTransaksiD = Transaksi_CMD.execute

        Dim objHttppp
        Set objHttppp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim url, payload
        url = "http://103.111.190.162/dbs/CustomerApps/orderBooking/paymentVerif/?key=304139a7188354d7e6f7651b5673a264&bookID="& BookingID &"&bookBayarYN=Y&bookPaymentID=&poinused=&poinearned="
        objHttppp.Open "GET", url, False
        objHttppp.setRequestHeader "Content-Type", "application/json"
        objHttppp.send payload

%>

