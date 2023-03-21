<!--#include file="../../../connections/pigoConn.asp"--> 
<%
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    id = request.queryString("trID")

    set pesanan_cmd = server.createObject("ADODB.COMMAND")
	pesanan_cmd.activeConnection = MM_PIGO_String

    pesanan_cmd.commandText = "Select * From MKT_T_Pesanan_H where  ps_trID = '"& id &"' "
    'response.write pesanan_cmd.commandText
    set pesanan = pesanan_cmd.execute

    set seller_cmd = server.createObject("ADODB.COMMAND")
	seller_cmd.activeConnection = MM_PIGO_String

	seller_cmd.commandText = "SELECT MKT_M_Seller.slName,   MKT_M_Seller.sl_custID, MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec,  MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custEmail,  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi,MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_T_Transaksi_H.trJenisPembayaran,  MKT_T_Transaksi_D1.tr_strID FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_D1A.trD1A WHERE MKT_T_Transaksi_H.trID = '"& id &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' GROUP BY MKT_M_Seller.slName, MKT_M_Seller.sl_custID, MKT_M_Alamat.almID,  MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota,  MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima,MKT_M_Alamat.almKec,  MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custEmail,  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.trBiayaOngkir,  MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_T_Transaksi_H.trJenisPembayaran,  MKT_T_Transaksi_D1.tr_strID"
    'response.write seller_cmd.commandText
    set seller = seller_cmd.execute

    set buyer_cmd = server.createObject("ADODB.COMMAND")
	buyer_cmd.activeConnection = MM_PIGO_String

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

    set API_cmd = server.createObject("ADODB.COMMAND")
	API_cmd.activeConnection = MM_PIGO_String
    API_cmd.commandText = " SELECT * FROM GLB_M_API_Int where APIName = 'DBS' "
    'response.write API_cmd.commandText
    set API = API_cmd.execute
%>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../../fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="detail.css">

    <script src="../../../js/jquery-3.6.0.min.js"></script>

    <title>Otopigo</title>
    <script>
        function uk(){
            let p = Number(document.getElementById('panjang').value);
            let l = Number(document.getElementById('lebar').value);
            let t = Number(document.getElementById('tinggi').value);
            let ukr = (p*l*t);
            document.getElementById('pdukuran').value = ukr;
        }
    
    </script>

</head>
<body onload="return uk()" >

<!--Breadcrumb-->
    <div class="container mt-3">
        <div class="navigasi" >
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb ">
                    <li class="breadcrumb-item"><a href="../../Profile/" >Home</a></li>
                    <li class="breadcrumb-item"><a href="../../Pesanan/" >Pesanan Saya</a></li>
                    <li class="breadcrumb-item"><a href="" >Rincian Pesanan</a></li>
                </ol>
            </nav>
        </div>
    </div> 
    <hr size="10px" color="#ececec">
    <div class="container" style="">
        <form class="P-pesanan" action="P-pesananditerima.asp" method="POST" >
            <div class="row align-items-center" style=" background-color:white; padding:10px;border:2px solid #ececec">
                <div class="col-12">
                    <span> <%=Transaksi("strName")%> </span>
                    <div class="row align-items-center mt-3">
                        <div class="col-2">
                            <span> Kode Pesanan  </span><br>
                            <span> Tanggal Pesanan  </span>
                        </div>
                        <div class="col-1 p-0">
                            <span> :  </span><br>
                            <span> :  </span>
                        </div>
                        <div class="col-4 p-0">
                            <input readonly class="dt-produk" type="text" name="nopesanan" id="nopesanan" value="<%=Pesanan("psID")%>"><br>
                            <input readonly class="dt-produk" type="text" name="tglpesanan" id="tglpesanan" value="<%=Transaksi("tanggaltr")%>">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row align-items-center"style="display:none">
                <div class="col-12">
                    <input type="hidden" name="tr_custID" id="tr_custID" value="<%=Transaksi("tr_custID")%>"><br>
                    <input type="hidden" name="trID" id="trID" value="<%=Transaksi("trID")%>">
                </div>
            </div>

            <div class="row mt-1  mb-1 align-items-center" style=" background-color:white; padding:10px;border:2px solid #ececec; border-radius:10px">
                <div class="col-3">
                    <span> <input readonly class="dt-produk weight" name="namaseller" id="namaseller" type="text" value="<%=Transaksi("namaseller")%> "style="font-size:20px"> </span>
                </div>
                <div class="col-9">
                    <div class="row">
                        <div class="col-8">
                            <input readonly class="dt-produk weight" name="almpengiriman" id="almpengiriman" type="text" value="<%=Transaksi("selleralm")%>" style="width:15rem"><br>
                            <input readonly class="dt-produk" name="kotapengirim" id="kotapengirim" type="hidden" value="<%=Transaksi("sellerkota")%>">
                            <input readonly class="dt-produk" name="kecpengirim" id="kecpengirim" type="hidden" value="<%=Transaksi("sellerkec")%>">
                            <input readonly class="dt-produk" name="kelpengirim" id="kelpengirim" type="hidden" value="<%=Transaksi("sellerkel")%>">
                            <input readonly class="dt-produk" name="kdpospengirim" id="kdpospengirim" type="hidden" value="<%=Transaksi("sellerkdpos")%>">
                            <input readonly class="dt-produk" name="lat" id="lat" type="hidden" value="<%=Transaksi("sellerlatt")%>">
                            <input readonly class="dt-produk" name="lon" id="lon" type="hidden" value="<%=Transaksi("sellerlong")%>">
                            <input readonly class="dt-produk weight" name="emailpengirim" id="emailpengirim" type="text" value="<%=Transaksi("emailseller")%>" style="width:15rem"><br>
                            <input readonly class="dt-produk weight" name="phone2pengirim" id="phone2pengirim" type="text" value="<%=Transaksi("phoneseller")%>" style="width:15rem">
                            <input readonly class="dt-produk" name="phone1pengirim" id="phone1pengirim" type="hidden" value="<%=Transaksi("sellerphone")%>">
                        </div>
                    </div>
                </div>
            </div>
                <div class="row align-items-center" style=" background-color:white; padding:10px;border:2px solid #ececec; border-radius:10px">
                    <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                        <span> <input readonly class="dt-produk weight" type="text" name="namapenerima" id="namapenerima" value="<%=Transaksi("custNama")%>"> </span>
                    </div>
                    <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                        <span> <input readonly class="dt-produk weight" type="text" name="namapenerima" id="namapenerima" value="<%=Transaksi("custEmail")%>"  style="width:15rem"> </span>
                    </div>
                    <table class="table mt-3 table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th class="text-center"> Nama Produk </th>
                                <th class="text-center"> Harga Satuan </th>
                                <th class="text-center"> Berat (gram) </th>
                                <th class="text-center"> Ukuran (cm) </th>
                                <th class="text-center"> Volume </th>
                                <th class="text-center"> QTY </th>
                                <th class="text-center"> Total </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input readonly class="dt-produk" type="text" name="namaproduk" id="namaproduk" value="<%=Transaksi("pdNama")%>"></td>
                                <td><input readonly class="inp-produk" type="text" name="hg" id="hg" value="<%=Replace(FormatCurrency(Transaksi("tr_pdHarga")),"$","Rp.  ")%>"><br></td>
                                <input readonly class="inp-produk" type="hidden" name="pdharga" id="pdharga" value="<%=Transaksi("tr_pdHarga")%>"> <br>
                                <td><input style="text-align:center"readonly class="inp-produk" type="text" name="pdberat" id="pdberat" value="<%=Transaksi("pdBerat")%>"></td>
                                    <input readonly  type="hidden" name="panjang" id="panjang" value="<%=Transaksi("pdPanjang")%>">
                                    <input readonly  type="hidden" name="lebar" id="lebar" value="<%=Transaksi("pdLebar")%>">
                                    <input readonly  type="hidden" name="tinggi" id="tinggi" value="<%=Transaksi("pdTinggi")%>">
                                <td class="text-center"><input style="text-align:center"readonly  class="inp-produk" type="text" name="pdukuran" id="pdukuran" value="0"></td>
                                <td class="text-center"><input style="text-align:center"readonly class="inp-produk" type="text" name="pdvolume" id="pdvolume" value="<%=Transaksi("pdVolume")%>"> <br></td>
                                <td class="text-center"><input style="text-align:center"readonly class="inp-produk" type="text" name="totalqty" id="totalqty" value="<%=Transaksi("tr_pdQty")%>"></td>
                                <td class="text-center"><input style="text-align:center"readonly class="inp-produk" type="text" name="tb" id="tb" value="<%=Replace(FormatCurrency(Transaksi("trSubTotal")),"$","Rp.  ")%>"></td>
                                <input readonly class="inp-produk" type="hidden" name="totalbayar" id="totalbayar" value="<%=Transaksi("trSubTotal")%>">
                            </tr>
                        </tbody>
                    </table>
                <div class="pengiriman" style="display:none">
                    <div class="row align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                            <span class="weight"> Pengiriman </span>
                        </div> 
                    </div>
                    <div class="row align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2">
                            <span class="dt-text"> Jenis Pengiriman</span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                            <input readonly class="inp-produk" type="text" name="jpengiriman" id="jpengiriman" value="<%=Transaksi("trPengiriman")%>">
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2">
                            <span class="dt-text"> Jenis Pembayaran</span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                            <input readonly class="inp-produk" type="text" name="jpembayaran" id="jpembayaran" value="<%=Transaksi("trJenisPembayaran")%>">
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2">
                            <span class="dt-text"> Layanan Tambahan Produk</span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                            <input readonly class="inp-produk" type="text" name="layanan" id="layanan" value="<%=Transaksi("pdLayanan")%>">
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2">
                            <span class="dt-text"> Packing Produk</span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <input readonly class="inp-produk" type="text" name="packing" id="packing" value="<%=Transaksi("trPacking")%>" >
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <span class="dt-text"> Biaya Packing </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                            <input  class="inp-produk" type="text" name="bpacking" id="bpacking" value="0">
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2">
                            <span class="dt-text"> Asuransi Pengiriman</span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <input readonly class="inp-produk" type="text" name="asuransi" id="asuransi" value="<%=Transaksi("trAsuransi")%>" >
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <span class="dt-text"> Biaya Asuransi </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                            <input  class="inp-produk" type="text" name="basuransi" id="basuransi" value="0">
                        </div>
                    </div>
                
                    <div class="row align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2">
                            <span class="dt-text"> Catatan Pesanan </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                            <textarea class="inp-produk" type="text" name="ketpd" id="ketpd" value="0" style="width:30.8rem"></textarea>
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2">
                            <span class="dt-text"> Konfirmasi Pesanan </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2" style="display:none">
                            <select class="inp-produk" name="statustransaksi" id="statustransaksi">
                                <option value="04">Pesanan Selesai</option>
                            </select>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2">
                            <span class="dt-text"> Pesanan Telah Sesuai :</span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-1 mt-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="konfirmasips" id="konfirmasips" value="Y" checked>
                                <span class="dt-text"> Ya </span>
                            </div>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-1 mt-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="konfirmasips" id="konfirmasips" value="N" >
                                <span class="dt-text"> Tidak </span>
                            </div>
                        </div>
                    </div>
                    <div class="row align-items-center" style="display:none">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                            <input readonly class="dt-produk" type="hidden" name="phone1penerima" id="phone1penerima" value="<%=Transaksi("custPhone1")%>">
                            <input readonly class="dt-produk" type="hidden" name="phone2penerima" id="phone2penerima" value="<%=Transaksi("custPhone2")%>">
                            <input readonly class="dt-produk" type="hidden" name="emailpenerima" id="emailpenerima" value="<%=Transaksi("custemail")%>"> 
                            <input readonly class="dt-produk" type="hidden" name="almpenerima" id="almpenerima" value="<%=Transaksi("almlengkap")%>">
                            <input readonly class="dt-produk" type="hidden" name="kotapenerima" id="kotapenerima" value="<%=Transaksi("almKota")%>"> 
                            <input readonly class="dt-produk" type="hidden" name="kelpenerima" id="kelpenerima" value="<%=Transaksi("almKel")%>"> 
                            <input readonly class="dt-produk" type="hidden" name="kecpenerima" id="kecpenerima" value="<%=Transaksi("almkec")%>"> 
                            <input readonly class="dt-produk" type="hidden" name="provpenerima" id="provpenerima" value="<%=Transaksi("almprovinsi")%>"> 
                            <input readonly class="dt-produk" type="hidden" name="kdpospenerima" id="kdpospenerima" value="<%=Transaksi("almkdpos")%>"> 
                            <input readonly class="dt-produk" type="hidden" name="lattpenerima" id="lattpenerima" value="<%=Transaksi("almlatt")%>"> 
                            <input readonly class="dt-produk" type="hidden" name="longpenerima" id="longpenerima" value="<%=Transaksi("almlong")%>">
                        </div>
                    </div>
                </div>
                </div>
            </form>
    </div>
<!-- Body -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../../../js/bootstrap.js"></script>
    <script src="../../../js/popper.min.js"></script>
    <script>

        function Timer(duration, display)   
            {
                var timer = duration, hours, minutes, seconds;
                setInterval(function () {
                    hours = parseInt((timer /3600)%24, 10)
                    minutes = parseInt((timer / 60)%60, 10)
                    seconds = parseInt(timer % 60, 10);

                            hours = hours < 10 ? "0" + hours : hours;
                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    display.text(hours +":"+minutes + ":" + seconds);

                            --timer;
                }, 1000);
            }

            jQuery(function ($) 
            {
                var twentyFourHours = 24 * 60 * 60;
                var display = $('#remainingTime');
                Timer(twentyFourHours, display);
        });

        function sendajax(){
            var key="cc7b7748ffe244a61d122e8578a3aab1";
            var Booking_AsalName=$('#namaseller').val(); 
            var Booking_AsalAlamat=$('#almpengirim').val();
            var Booking_AsalKota=$('#kotapengirim').val();
            var Booking_AsalKecamatan=$('#kecpengirim').val();
            var Booking_AsalKelurahan=$('#kelpengirim').val(); 
            var Booking_AsalKodepos=Number($('#kdpospengirim').val());
            var Booking_AsalTelp=$('#phone1pengirim').val(); 
            var Booking_asalTelp2=$('#phone2pengirim').val();
            var Booking_AsalEmail=$('#emailpengirim').val();
            var Booking_TujuanNama=$('#namapenerima').val(); 
            var Booking_TujuanAlamat=$('#almpenerima').val();
            var Booking_TujuanKota=$('#kotapenerima').val();
            var Booking_TujuanTelp=$('#phone1penerima').val();
            var Booking_TujuanTelp2=$('#phone2penerima').val();
            var Booking_TujuanKelurahan=$('#kelpenerima').val(); 
            var Booking_TujuanKecamatan=$('#kecpenerima').val();
            var Booking_TujuanPulau=$('#provpenerima').val();
            var Booking_TujuanKodepos=Number($('#kdpospenerima').val());
            var Booking_TujuanEmail=$('#emailpenerima').val(); 
            var Booking_Pembayaran=1; //Jenis Pembayaran ( 1 : cash )
            var Booking_Up="G";
            var Booking_Ket="F"; 
            var Booking_NoSuratJalan=$('#nopesanan').val(); 
            var Booking_NamaBarang=$('#namaproduk').val(); 
            var Booking_JenisHarga=1; 
            var Booking_JmlUnit=Number($('#totalqty').val()); 
            var Booking_Berat=Number($('#pdberat').val()); 
            var Booking_Beratvol=Number($('#pdvolume').val()); 
            var Booking_Ukuran=Number($('#pdukuran').val()); 
            var Booking_Harga=Number($('#totalbayar').val()); 
            var Booking_Service=$('#jpengiriman').val(); 
            var Booking_servID=1; 
            var Booking_PackingYN=$('#packing').val(); 
            var Booking_AsuransiYN=$('#asuransi').val();
            var Booking_NilaiBarang=$('#pdharga').val(); 
            var Booking_Lat=$('#lat').val(); 
            var Booking_Lon=$('#lon').val(); 
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
            

            const getBalance = () => {
                fetch('https://api.xendit.co/available_virtual_account_banks', {
                    method: 'post',
                    headers: {
                        Authorization: `Basic eG5kX2RldmVsb3BtZW50X1VWSTF0SGZqb1Q1aDVVNkRNUzdxZk9YeUpDWVp2d3VwV0l4SnhHeXNpRGpXaktqcnNGZ1N4SVk3YXhlaVEzOg==`
                    }
                    .then((res) => {
                    return res.json()
                    console.log(res)
                    })
                    .then((json) => {
                    console.log(json)
                    })
                });

                }

            // $.ajax({
            //     type: 'GET',
            //     url: 'https://api.xendit.co/available_virtual_account_banks',
            //         data:{
            //                 Authorization: `Basic eG5kX2RldmVsb3BtZW50X1VWSTF0SGZqb1Q1aDVVNkRNUzdxZk9YeUpDWVp2d3VwV0l4SnhHeXNpRGpXaktqcnNGZ1N4SVk3YXhlaVEzOg==`
            //             },
            //         traditional: true,
            //         success: function (data) {
            //         console.log(data);
            //         }
            //     });
            
                                    
            
    </script>
</body>
<!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../../../js/bootstrap.js"></script>
    <script src="../../../js/popper.min.js"></script>
</html>
