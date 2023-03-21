<!--#include file="../connections/pigoConn.asp"--> 

<%
        if request.Cookies("custEmail")="" then

        response.redirect("../")

        end if
        set API_cmd = server.createObject("ADODB.COMMAND")
	API_cmd.activeConnection = MM_PIGO_String
    API_cmd.commandText = " SELECT * FROM GLB_M_API_Int where APIName = 'DBS' "
    'response.write API_cmd.commandText
    set API = API_cmd.execute
        set Member_cmd = server.createObject("ADODB.COMMAND")
        Member_cmd.activeConnection = MM_PIGO_String

        Member_cmd.commandText = "SELECT * From MKT_M_Customer where custDakotaGYN = 'Y' and custID ='"& request.cookies("custID") &"'  "
        'response.write Member_cmd.commandText
        set Member = Member_cmd.execute

        TransaksiID     = "TR0201230001"
        'response.Write TransaksiID & "<br>"

        set Transaksi_CMD = server.createObject("ADODB.COMMAND")
        Transaksi_CMD.activeConnection = MM_PIGO_String

        Transaksi_CMD.commandText = "SELECT SUM(MKT_T_Transaksi_D1A.tr_pdHarga*MKT_T_Transaksi_D1A.tr_pdQty) AS TotalPesanan, SUM(MKT_T_Transaksi_D1A.tr_pdQty) AS JumlahPesanan, SUM(MKT_T_Transaksi_D1.trBiayaOngkir) AS TotalOngkir FROM MKT_T_Transaksi_D1 RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A  WHERE MKT_T_Transaksi_H.tr_custID ='"& request.cookies("custID") &"' AND MKT_T_Transaksi_H.trID = '"& TransaksiID &"'  "
        'response.write Transaksi_CMD.commandText & "<br>"
        set Transaksi = Transaksi_CMD.execute

        Transaksi_CMD.commandText = "SELECT MKT_T_Transaksi_H.tr_custID, Pengirim.custNama AS NamaSeller, AlamatPengirim.almLengkap AS AlmPengirim, AlamatPengirim.almKel AS KelPengirim, AlamatPengirim.almKota AS KotaPengirim,  AlamatPengirim.almKec AS KecPengirim, Pengirim.custPhone1 AS PhonePengirim1, Pengirim.custPhone2 AS PhonePengirim2, AlamatPengirim.almKdpos AS KPosPengirim, Pengirim.custEmail AS EmailPengirim,  AlamatPenerima.alm_custID, Penerima.custNama AS NamaPenerima, AlamatPenerima.almLengkap AS AlmPenerima, AlamatPenerima.almKec AS KecPenerima, Penerima.custPhone1 AS PhonePenerima1,  Penerima.custPhone2 AS PhonePenerima2, AlamatPenerima.almKel AS KelPenerima, AlamatPenerima.almProvinsi AS ProvPenerima, AlamatPenerima.almKota AS KotaPenerima, AlamatPenerima.almKdpos AS KPosPenerima,  Penerima.custEmail AS EmailPenerima, MKT_T_Transaksi_H.trID AS NoPesanan, MKT_M_PIGO_Produk.pdNama AS NamaProduk, MKT_T_Transaksi_D1A.tr_pdHarga AS HargaProduk,  MKT_T_Transaksi_D1A.tr_pdQty AS TotalQty, MKT_M_PIGO_Produk.pdBerat AS Berat, MKT_M_PIGO_Produk.pdPanjang, MKT_M_PIGO_Produk.pdLebar, MKT_M_PIGO_Produk.pdTinggi, MKT_M_PIGO_Produk.pdVolume,  MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_D1.trPengiriman, AlamatPengirim.almLatt, AlamatPengirim.almLong FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_M_Alamat AS AlamatPenerima RIGHT OUTER JOIN MKT_M_Customer AS Penerima ON AlamatPenerima.alm_custID = Penerima.custID ON MKT_T_Transaksi_H.tr_custID = Penerima.custID ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_M_Customer AS Pengirim LEFT OUTER JOIN MKT_M_Alamat AS AlamatPengirim ON Pengirim.custID = AlamatPengirim.alm_custID RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON Pengirim.custID = MKT_T_Transaksi_D1.tr_slID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) WHERE        (AlamatPenerima.almJenis <> 'Alamat Toko') AND MKT_T_Transaksi_H.trID = '"& TransaksiID &"'  "
        'response.write Transaksi_CMD.commandText & "<br>"
        set BookingID = Transaksi_CMD.execute


%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="detail-cart.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>

        <title> OFFICIAL PIGO </title>
        <script>
            function sendbooking(){
                var panjang = `<%=BookingID("pdPanjang")%>`;
                var tinggi = `<%=BookingID("pdTinggi")%>`;
                var lebar = `<%=BookingID("pdLebar")%>`;
                var ukuran = Number(panjang*tinggi*lebar);
                console.log(ukuran);
                var key="251430d8d9be0cab3bdc774a2dd51fbd";
                var Booking_AsalName=`<%=BookingID("NamaSeller")%>`; 
                var Booking_AsalAlamat=`<%=BookingID("AlmPengirim")%>`;
                var Booking_AsalKota=`<%=BookingID("KotaPengirim")%>`;
                var Booking_AsalKecamatan=`<%=BookingID("KecPengirim")%>`;
                var Booking_AsalKelurahan=`<%=BookingID("KelPengirim")%>`; 
                var Booking_AsalKodepos=`<%=BookingID("KPosPengirim")%>`;
                var Booking_AsalTelp=`<%=BookingID("PhonePengirim1")%>`; 
                var Booking_asalTelp2=`<%=BookingID("PhonePengirim2")%>`;
                var Booking_AsalEmail=`<%=BookingID("EmailPengirim")%>`;
                var Booking_TujuanNama=`<%=BookingID("NamaPenerima")%>`; 
                var Booking_TujuanAlamat=`<%=BookingID("AlmPenerima")%>`;
                var Booking_TujuanKota=`<%=BookingID("KotaPenerima")%>`;
                var Booking_TujuanTelp=`<%=BookingID("PhonePenerima1")%>`;
                var Booking_TujuanTelp2=`<%=BookingID("PhonePenerima2")%>`;
                var Booking_TujuanKelurahan=`<%=BookingID("KelPenerima")%>`; 
                var Booking_TujuanKecamatan=`<%=BookingID("KecPenerima")%>`;
                var Booking_TujuanPulau=`<%=BookingID("ProvPenerima")%>`;
                var Booking_TujuanKodepos=`<%=BookingID("KPosPenerima")%>`;
                var Booking_TujuanEmail=`<%=BookingID("EmailPenerima")%>`; 
                var Booking_Pembayaran=1; //Jenis Pembayaran ( 1 : cash )
                var Booking_Up="G";
                var Booking_Ket="F"; 
                var Booking_NoSuratJalan=`<%=BookingID("NoPesanan")%>`; 
                var Booking_NamaBarang=`<%=BookingID("NamaProduk")%>`; 
                var Booking_JenisHarga=1; 
                var Booking_JmlUnit=`<%=BookingID("TotalQty")%>`; 
                var Booking_Berat=`<%=BookingID("Berat")%>`; 
                var Booking_Beratvol=`<%=BookingID("pdVolume")%>`; 
                var Booking_Ukuran=ukuran; 
                var Booking_Harga=`<%=BookingID("trTotalPembayaran")%>`; 
                var Booking_Service=`<%=BookingID("trPengiriman")%>`; 
                var Booking_servID=1; 
                var Booking_PackingYN="N"; 
                var Booking_AsuransiYN="N";
                var Booking_NilaiBarang=`<%=BookingID("HargaProduk")%>`; 
                var Booking_Lat=`<%=BookingID("almLatt")%>`; 
                var Booking_Lon=`<%=BookingID("almLong")%>`; 
                var Booking_PackingHarga=0;
                $.ajax({
                type: 'GET',
                url: '<%=API("APIUrl")%>dbs/customerapps/orderBooking/add/',
                    data:{
                            key:key,
                            Booking_AsalName:Booking_AsalName, 
                            Booking_AsalAlamat:Booking_AsalAlamat, 
                            Booking_AsalKota:Booking_AsalKota, 
                            Booking_AsalKecamatan:Booking_AsalKecamatan,
                            Booking_AsalKelurahan:Booking_AsalKelurahan, 
                            Booking_AsalKodepos:Booking_AsalKodepos,
                            Booking_AsalTelp:Booking_AsalTelp,
                            Booking_asalTelp2:Booking_asalTelp2,
                            Booking_AsalEmail:Booking_AsalEmail, 
                            Booking_TujuanNama:Booking_TujuanNama,
                            Booking_TujuanAlamat:Booking_TujuanAlamat,
                            Booking_TujuanKota:Booking_TujuanKota,
                            Booking_TujuanKota:Booking_TujuanKota, 
                            Booking_TujuanTelp2:Booking_TujuanTelp2,
                            Booking_TujuanKelurahan:Booking_TujuanKelurahan,
                            Booking_TujuanKecamatan:Booking_TujuanKecamatan,
                            Booking_TujuanPulau:Booking_TujuanPulau,
                            Booking_TujuanKodepos:Booking_TujuanKodepos,
                            Booking_TujuanEmail:Booking_TujuanEmail,
                            Booking_Pembayaran:Booking_Pembayaran,
                            Booking_Up:Booking_Up,
                            Booking_Ket:Booking_Ket,
                            Booking_NoSuratJalan:Booking_NoSuratJalan,
                            Booking_NamaBarang:Booking_NamaBarang, 
                            Booking_JenisHarga:Booking_JenisHarga,
                            Booking_JmlUnit:Booking_JmlUnit,
                            Booking_Berat:Booking_Berat,
                            Booking_Beratvol:Booking_Beratvol, 
                            Booking_Ukuran:Booking_Ukuran,
                            Booking_Harga:Booking_Harga,
                            Booking_Service:Booking_Service,
                            Booking_servID:Booking_servID,
                            Booking_PackingYN:Booking_PackingYN, 
                            Booking_AsuransiYN:Booking_AsuransiYN,
                            Booking_NilaiBarang:Booking_NilaiBarang,
                            Booking_Lat:Booking_Lat, 
                            Booking_Lon:Booking_Lon, 
                            Booking_PackingHarga:Booking_PackingHarga
                        },
                    traditional: true,
                    success: function (data) {
                        console.log(data);
                    }
                });
            }
        </script>
        <style>
            .list-payment{
                background-color:white;
                font-size:12px;
                color:#424242;
                box-shadow: 0 4px 8px 0 rgba(196, 196, 196, 0.2), 0 6px 20px 0 rgba(218, 218, 218, 0.19);
                padding:15px 20px;
                border-radius:20px;
            }
            .detail-payment{
                background-color:white;
                font-size:12px;
                color:#424242;
                box-shadow: 0 4px 8px 0 rgba(196, 196, 196, 0.2), 0 6px 20px 0 rgba(218, 218, 218, 0.19);
                padding:15px 20px;
                border-radius:20px;
            }
            .text-detail-payment{
                font-size:12px;
                font-family: "Poppins", sans-serif;
                color:#424242;
                font-weight:550;
            }
            .txt-detail-payment{
                font-size:15px;
                font-family: "Poppins", sans-serif;
                color:white;
                font-weight:550;
            }
            .btn-detail-payment{
                background-color:#0077a2;
                color:white;
                padding:5px 100px;
                border:none;
                border-radius:20px;
                font-weight:550;
                font-size:12px;
                font-family: "Poppins", sans-serif;
            }
        </style>
    </head>
<body>
    <div class="header" style="background-color:#eee; padding:2px 10px; height:5rem; ">
        <div class="container" style="margin-top:15px">
            <div class="row align-items-center">
                <div class="col-6 ">
                    <a class="backk" href="<%=base_url%>/Keranjang/" style="text-decoration:none;color:#0077a2" ><i class="fas fa-chevron-circle-left"></i></a> &nbsp;&nbsp;
                    <a class="backk" href="<%=base_url%>/Keranjang/" style="text-decoration:none" ><img src="<%=base_url%>/assets/logo/1.png" width="40px" height="40px"> </a> &nbsp;&nbsp;
                    <span class="text-header" style="color:#0077a2">   Pembayaran   </span>
                </div>
            </div>
        </div>
    </div>
    <div class="container mb-2" style="margin-top:5.5rem">
        <div class="row">
            <div class="col-8">
            <span class="txt-detail-payment" style="color:#0077a2"> Metode Pembayaran </span>
            <input type="hidden" name="TransaksiID" id="TransaksiID" value="<%=TransaksiID%>">
                <div class="list-payment">
                    <div class="row mt-2">
                            <div class="col-12">
                                <%if Member.eof = true then %>
                                    <div class="row">
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-12 ">
                                            <input class="form-check-input text-span  " type="radio" name="jenispembayaran" id="jenispembayaran" value="COD (Bayar Di Tempat)" checked><span class="txt-pesanan" > COD (Bayar diTempat) </span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-12 ">
                                            <input class="form-check-input txt-pesanan  " type="radio" name="jenispembayaran" id="jenispembayaran" value="Transfer Bank" checked><span class="txt-pesanan" > Transfer Bank </span>
                                        </div>
                                    </div>
                                    <%
                                    else
                                    %>
                                    <div class="row">
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                                            <input class="form-check-input txt-pesanan " type="radio" name="jenispembayaran" id="jenispembayaran" value="Kredit" checked><span class="txt-pesanan" > Kredit (Khusus Dakota Group) </span>
                                        </div>
                                    </div>
                                    <%
                                    end if
                                    %>
                            </div>
                        </div>
                </div>
            </div>
            <div class="col-4">
                <span class="txt-detail-payment"> Detail Pembayaran </span>
                <div class="detail-payment">
                    <div class="row">
                        <div class="col-8">
                            <span class="text-detail-payment"> Jumlah Pesanan </span><br>
                            <span class="text-detail-payment"> Total Pesanan </span><br>
                            <span class="text-detail-payment"> Total Ongkos Kirim </span><br>
                        </div>
                        <div class="col-4 text-end">
                            <span class="text-detail-payment"><%=Transaksi("JumlahPesanan")%></span><br>
                            <span class="text-detail-payment"><%=Replace(Replace(FormatCurrency(Transaksi("TotalPesanan")),"$","Rp.  "),".00","")%> </span><br>
                            <span class="text-detail-payment"><%=Replace(Replace(FormatCurrency(Transaksi("TotalOngkir")),"$","Rp.  "),".00","")%></span><br>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-8">
                            <span class="text-detail-payment"> Total Pembayaran </span><br>
                        </div>
                        <div class="col-4 text-end">
                        <%
                            TotalPembayaran = Transaksi("TotalPesanan")+Transaksi("TotalOngkir")
                        %>
                            <span class="text-detail-payment"><%=Replace(Replace(FormatCurrency(TotalPembayaran),"$","Rp.  "),".00","")%> </span><br>
                        </div>
                    </div>
                    <div class="row mt-3 mb-2">
                        <div class="col-12">
                            <span class="text-detail-payment"> Dengan mengkilik tombol dibawah, kamu menyetujui <b> Syarat dan Ketentuan Official PIGO </b> </span><br>
                        </div>
                    </div>
                    <div class="row mt-4 text-center">
                        <div class="col-12">
                            <input type="button" onclick="sendajax()" class="btn-detail-payment" value="Buat Pesanan">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>
        function sendajax(){
            var panjang = `<%=BookingID("pdPanjang")%>`;
            var tinggi = `<%=BookingID("pdTinggi")%>`;
            var lebar = `<%=BookingID("pdLebar")%>`;
            var ukuran = Number(panjang*tinggi*lebar);
            var key="251430d8d9be0cab3bdc774a2dd51fbd";
            var Booking_AsalName=`<%=BookingID("NamaSeller")%>`; 
            var Booking_AsalAlamat=`<%=BookingID("AlmPengirim")%>`;
            var Booking_AsalKota=`<%=BookingID("KotaPengirim")%>`;
            var Booking_AsalKecamatan=`<%=BookingID("KecPengirim")%>`;
            var Booking_AsalKelurahan=`<%=BookingID("KelPengirim")%>`; 
            var Booking_AsalKodepos=`<%=BookingID("KPosPengirim")%>`;
            var Booking_AsalTelp=`<%=BookingID("PhonePengirim1")%>`; 
            var Booking_asalTelp2=`<%=BookingID("PhonePengirim2")%>`;
            var Booking_AsalEmail=`<%=BookingID("EmailPengirim")%>`;
            var Booking_TujuanNama=`<%=BookingID("NamaPenerima")%>`; 
            var Booking_TujuanAlamat=`<%=BookingID("AlmPenerima")%>`;
            var Booking_TujuanKota=`<%=BookingID("KotaPenerima")%>`;
            var Booking_TujuanTelp=`<%=BookingID("PhonePenerima1")%>`;
            var Booking_TujuanTelp2=`<%=BookingID("PhonePenerima2")%>`;
            var Booking_TujuanKelurahan=`<%=BookingID("KelPenerima")%>`; 
            var Booking_TujuanKecamatan=`<%=BookingID("KecPenerima")%>`;
            var Booking_TujuanPulau=`<%=BookingID("ProvPenerima")%>`;
            var Booking_TujuanKodepos=`<%=BookingID("KPosPenerima")%>`;
            var Booking_TujuanEmail=`<%=BookingID("EmailPenerima")%>`; 
            var Booking_Pembayaran=1; //Jenis Pembayaran ( 1 : cash )
            var Booking_Up="G";
            var Booking_Ket="F"; 
            var Booking_NoSuratJalan=`<%=BookingID("NoPesanan")%>`; 
            var Booking_NamaBarang=`<%=BookingID("NamaProduk")%>`; 
            var Booking_JenisHarga=1; 
            var Booking_JmlUnit=`<%=BookingID("TotalQty")%>`; 
            var Booking_Berat=`<%=BookingID("Berat")%>`; 
            var Booking_Beratvol=`<%=BookingID("pdVolume")%>`; 
            var Booking_Ukuran=ukuran; 
            var Booking_Harga=`<%=BookingID("trTotalPembayaran")%>`; 
            var Booking_Service=`<%=BookingID("trPengiriman")%>`; 
            var Booking_servID=1; 
            var Booking_PackingYN="N"; 
            var Booking_AsuransiYN="N";
            var Booking_NilaiBarang=`<%=BookingID("HargaProduk")%>`; 
            var Booking_Lat=`<%=BookingID("almLatt")%>`; 
            var Booking_Lon=`<%=BookingID("almLong")%>`; 
            var Booking_PackingHarga=0;
            $.ajax({
                type: 'GET',
                url: '<%=API("APIUrl")%>dbs/customerapps/orderBooking/add/',
                data:{
                    key:key,
                    Booking_AsalName:Booking_AsalName, 
                    Booking_AsalAlamat:Booking_AsalAlamat, 
                    Booking_AsalKota:Booking_AsalKota, 
                    Booking_AsalKecamatan:Booking_AsalKecamatan,
                    Booking_AsalKelurahan:Booking_AsalKelurahan, 
                    Booking_AsalKodepos:Booking_AsalKodepos,
                    Booking_AsalTelp:Booking_AsalTelp,
                    Booking_asalTelp2:Booking_asalTelp2,
                    Booking_AsalEmail:Booking_AsalEmail, 
                    Booking_TujuanNama:Booking_TujuanNama,
                    Booking_TujuanAlamat:Booking_TujuanAlamat,
                    Booking_TujuanKota:Booking_TujuanKota,
                    Booking_TujuanKota:Booking_TujuanKota, 
                    Booking_TujuanTelp2:Booking_TujuanTelp2,
                    Booking_TujuanKelurahan:Booking_TujuanKelurahan,
                    Booking_TujuanKecamatan:Booking_TujuanKecamatan,
                    Booking_TujuanPulau:Booking_TujuanPulau,
                    Booking_TujuanKodepos:Booking_TujuanKodepos,
                    Booking_TujuanEmail:Booking_TujuanEmail,
                    Booking_Pembayaran:Booking_Pembayaran,
                    Booking_Up:Booking_Up,
                    Booking_Ket:Booking_Ket,
                    Booking_NoSuratJalan:Booking_NoSuratJalan,
                    Booking_NamaBarang:Booking_NamaBarang, 
                    Booking_JenisHarga:Booking_JenisHarga,
                    Booking_JmlUnit:Booking_JmlUnit,
                    Booking_Berat:Booking_Berat,
                    Booking_Beratvol:Booking_Beratvol, 
                    Booking_Ukuran:Booking_Ukuran,
                    Booking_Harga:Booking_Harga,
                    Booking_Service:Booking_Service,
                    Booking_servID:Booking_servID,
                    Booking_PackingYN:Booking_PackingYN, 
                    Booking_AsuransiYN:Booking_AsuransiYN,
                    Booking_NilaiBarang:Booking_NilaiBarang,
                    Booking_Lat:Booking_Lat, 
                    Booking_Lon:Booking_Lon, 
                    Booking_PackingHarga:Booking_PackingHarga
                },
                traditional: true,
                success: function (data) {
                    console.log(data);
                }
            });
        }
    </script>
</html>