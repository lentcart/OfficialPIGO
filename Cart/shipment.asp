<!--#include file="../connections/pigoConn.asp"--> 

<%
        if request.Cookies("custEmail")="" then

        response.redirect("../")

        end if

        ' id = mid(request.form("pdID"),1,len(request.form("pdID"))-1)
        subtotal = request.form("total")
        qty = request.form("tbarang")

        id = Split(request.form("idproduk"),",")

        for each x in id
            if len(x) > 0 then

                    filterProduk = filterProduk & addOR & " MKT_T_Keranjang.cart_pdID = '"& x &"' "
                    addOR = " or " 

            end if
        next
        if filterProduk <> "" then
            FilterFix = " and  ( " & filterProduk & " )" 
        end if
        

    set Customer_cmd = server.createObject("ADODB.COMMAND")
	Customer_cmd.activeConnection = MM_PIGO_String

	Customer_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel,  MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt AS LatDestination , MKT_M_Alamat.almLong AS LongDestination,  MKT_M_Rekening.rkID, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk,MKT_M_Alamat.almID, MKT_T_Keranjang.cart_custID FROM MKT_M_Rekening RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Rekening.rk_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_Keranjang ON MKT_M_Customer.custID = MKT_T_Keranjang.cart_custID WHERE MKT_T_Keranjang.cart_custID = '"& request.Cookies("custID")&"' AND almJenis <> 'Alamat Toko' GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong,  MKT_M_Rekening.rkID, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk,MKT_M_Alamat.almID, MKT_T_Keranjang.cart_custID "
    'response.write Customer_cmd.commandText
    set Customer = Customer_cmd.execute

    set alamat_cmd = server.createObject("ADODB.COMMAND")
	alamat_cmd.activeConnection = MM_PIGO_String

	alamat_cmd.commandText = "SELECT * From MKT_M_Alamat where alm_custID = '"& request.cookies("custID") &"' "
    'response.write alamat_cmd.commandText
    set alamat = alamat_cmd.execute

    set Member_cmd = server.createObject("ADODB.COMMAND")
	Member_cmd.activeConnection = MM_PIGO_String

	Member_cmd.commandText = "SELECT * From MKT_M_Customer where custDakotaGYN = 'Y' and custID ='"& request.cookies("custID") &"'  "
    'response.write Member_cmd.commandText
    set Member = Member_cmd.execute

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String

	Seller_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_T_Keranjang.cart_slID, MKT_T_Keranjang.cart_custID, MKT_M_Seller.sl_custID, MKT_M_Rekening.rkID, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk, MKT_M_Seller.sl_almID,  MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt AS LatOrigin,  MKT_M_Alamat.almLong AS LongOrigin FROM MKT_M_Seller LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Seller.sl_almID = MKT_M_Alamat.almID LEFT OUTER JOIN MKT_M_Rekening ON MKT_M_Seller.sl_custID = MKT_M_Rekening.rk_custID RIGHT OUTER JOIN MKT_T_Keranjang ON MKT_M_Seller.sl_custID = MKT_T_Keranjang.cart_slID WHERE (MKT_T_Keranjang.cart_custID = '"& request.cookies("custID") &"') "& FilterFix &"  AND MKT_M_Rekening.rkJenis = 'Rekening Seller' AND almJenis = 'Alamat Toko' GROUP BY MKT_M_Seller.slName, MKT_T_Keranjang.cart_slID, MKT_T_Keranjang.cart_custID, MKT_M_Seller.sl_custID, MKT_M_Rekening.rkID, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk, MKT_M_Seller.sl_almID, MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong " 
    'response.write Seller_cmd.commandText
    set Seller = Seller_cmd.execute

    set alamattoko_cmd = server.createObject("ADODB.COMMAND")
	alamattoko_cmd.activeConnection = MM_PIGO_String

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

    

%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title> OFFICIAL PIGO </title>
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="detail-cart.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script>
            var arry =[];
            function proteksi(produkID,Nilai,Ket){
                var TProteksi   = 0
                var NProteksi   = Number(Nilai)
                var bayar       = Number($('#totalbayar').val());
                if($('#CKProteksiProduk'+produkID).is(":checked")) {
                    document.getElementById("text-proteksi"+produkID).style.color   = "#0077a2";
                    document.getElementById("desc-proteksi"+produkID).style.color   = "#0077a2";
                    document.getElementById("harga-proteksi"+produkID).style.color  = "#7e0909";
                    $('#pdProteksiYN'+produkID).val('Y');
                    $('#pdBiayaProteksi'+produkID).val('10000');
                    var obj = {
                        produkID,
                        TProteksi:Number(Nilai)
                    }
                    arry.push(obj);
                        arry.map((key)=> {
                        idp = (key.produkID)
                        TProteksi += Number(key.TProteksi)
                    });
                    document.getElementById("TotalProteksi").value = Number(TProteksi);
                    var JProteksi = Number(bayar+NProteksi);
                    $('#totalbayar').val(JProteksi)
                }else{
                    document.getElementById("text-proteksi"+produkID).style.color = "#2a2a2a";
                    document.getElementById("desc-proteksi"+produkID).style.color = "#aaa";
                    document.getElementById("harga-proteksi"+produkID).style.color = "#aaa";
                    $('#pdProteksiYN'+produkID).val('N');
                    $('#pdBiayaProteksi'+produkID).val('0');
                    var uncek = arry.filter((key)=> key.produkID != produkID)
                    arry = uncek
                    arry.map((key)=> {
                        idp = (key.produkID)
                        TProteksi += Number(key.TProteksi)
                    });
                    document.getElementById("TotalProteksi").value =  Number(TProteksi);
                    var JProteksi = Number(bayar-NProteksi);
                    $('#totalbayar').val(JProteksi)
                }
            }

            function ubahongkir(sellerid){
                document.getElementById("list-ongkir"+sellerid).innerHTML = "";
                document.getElementById("list-dimensi"+sellerid).innerHTML = "" ;
                // for (let i=0; i>a.length; i++){
                //     a[i]
                // }
                var Ongkir  = Number(document.getElementById("totalongkoskirim").value);
                var Bayar   = Number(document.getElementById("totalbayar").value);
                var TBerat = Number($('#JumlahBerat').val());

                TotalBayar = Number(Bayar-Ongkir);
                // document.getElementById("totalongkoskirim").value = 0 ;
                document.getElementById("totalbayar").value = TotalBayar;
                document.getElementById("totalongkoskirim").value = 0;

                let propinsi = $('#prov').val();
                let kota = $('#kota').val();
                let kecamatan = $('#kec').val();
                let kelurahan = $('#kel').val();
                let asalkotaa = $('#asalkota'+sellerid).val();
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'Get-Pricelist.asp',
                    data:{
                        AsalKota:asalkotaa,
                        TujuanProvinsi:propinsi,
                        TujuanKota:kota,
                        TujuanKecamatan:kecamatan
                    },
                    traditional: true,
                    success: function (data) {
                        var jsonData = JSON.parse(data);
                        var Reg = jsonData.reguler;
                        var TBerat = Number($('#JumlahBerat').val());
                        NamaPengiriman  = "Reguler";
                        HargaOngkir     = Reg[0].pokok;
                        MinKg           = Reg[0].minkg;
                        HargaNextKg     = Reg[0].kgnext;
                        var o = "";
                        if(TBerat > MinKg){
                            var HargaPokok = Number(TBerat*HargaNextKg)
                        }else{
                            var HargaPokok = HargaOngkir
                        }
                        o += `
                            <div class="cont-list-ongkir-pricelist">
                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                    <div class="row align-items-center">
                                        <div class="col-12">
                                            <input class="form-check-input cktest" onchange=test('${NamaPengiriman}','','${HargaPokok}','${NamaPengiriman}','${sellerid}') type="checkbox" name="cekongkir" value="`+HargaPokok+`" id="cktest${HargaPokok}">
                                            <label for="cktest${HargaPokok}" onchange=test('${NamaPengiriman}','','${HargaPokok}','${NamaPengiriman}','${sellerid}')>
                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; `+NamaPengiriman+`  </span><br>
                                                <span class="card-pesanan-hrg"> Rp. `+HargaPokok+` </span><br>
                                                <span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `
                        document.getElementById("list-ongkir"+sellerid).innerHTML = o ;
                        var d = $("#ongkoskirim"+sellerid).remove().append(o);
                    }
                });


                var opsipengiriman = document.getElementById("cont-list-ongkir"+ sellerid);
                if(opsipengiriman.style.display == "none"){
                    opsipengiriman.style.display = "block"
                }else{
                    opsipengiriman.style.display = "none"
                }

                var LatDestination      = document.getElementById("LatDestination").value;
                var LongDestination     = document.getElementById("LongDestination").value;
                var LatOrigin           = document.getElementById("LatOrigin"+sellerid).value;
                var LongOrigin          = document.getElementById("LongOrigin"+sellerid).value;
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: "Get-Distance.asp",
                    data:{
                        LatDestination,
                        LongDestination,
                        LatOrigin,
                        LongOrigin
                    },
                    traditional: true,
                    success: function (data) {
                        var distance = JSON.parse(data);
                        var km = Number(distance.JarakTempuh/1000)
                        $.ajax({
                        type: 'GET',
                        contentType: "application/json",
                        url: 'Get-Dimensi.asp',
                        traditional: true,
                        success: function (url) {
                            var jsonDimensi = JSON.parse(url);
                            var a = jsonDimensi.detail;
                            var b = "";
                            var Tberat = Number($('#JumlahBerat').val());
                            console.log(Tberat);
                            var Tjarak = km;
                                console.log(Tberat > 5);
                            if( Tberat > 5 ){
                                var kg = 0;
                                var result = a.filter(obj=> obj.MaxKg == kg);
                                for(i=0; i<result.length; i++){
                                    console.log(result[i].id);
                                    b += `
                                            <div class="cont-list-ongkir">
                                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                                    <div class="row align-items-center">
                                                        <div class="col-12">
                                                            <input class="form-check-input cktest" onchange=test('${result[i].id}','${result[i].nama}','${result[i].Instant_Tarif}','Instant','${sellerid}') type="checkbox" name="cekongkir" value="`+result[i].id+`" id="cktest${result[i].Instant_Tarif}">
                                                            <label for="cktest${result[i].Instant_Tarif}" onchange=test('${result[i].id}','${result[i].nama}','${result[i].Instant_Tarif}','Instant','${sellerid}')>
                                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Instant (`+result[i].nama+`) </span><br>
                                                                <span class="card-pesanan-hrg"> Rp. `+result[i].Instant_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                                    <div class="row align-items-center">
                                                        <div class="col-12">
                                                            <input class="form-check-input cktest" onchange=test('${result[i].id}','${result[i].nama}','${result[i].SameDay_Tarif}','SameDay','${sellerid}') type="checkbox" name="cekongkir" value="`+result[i].id+`" id="cktest${result[i].SameDay_Tarif}">
                                                            <label for="cktest${result[i].SameDay_Tarif}" onchange=test('${result[i].id}','${result[i].nama}','${result[i].SameDay_Tarif}','SameDay','${sellerid}')>
                                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Same Day (`+result[i].nama+`) </span><br>
                                                                <span class="card-pesanan-hrg"> Rp. `+a[i].SameDay_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        `
                                    document.getElementById("list-dimensi"+sellerid).innerHTML = b ;
                                    var d = $("#ongkoskirim"+sellerid).remove().append(b);
                                }
                            }else if(Tberat<=5){
                                var result = a.filter(obj=> obj.MaxKg <= Tberat);
                                var opsi   = result.filter(obj=> obj.MaxKg !== 0);
                                for(i=0; i<opsi.length; i++){
                                    console.log(opsi[i].id);
                                    b += `
                                            <div class="cont-list-ongkir">
                                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                                    <div class="row align-items-center">
                                                        <div class="col-12">
                                                            <input class="form-check-input cktest" onchange=test('${opsi[i].id}','${opsi[i].nama}','${opsi[i].Instant_Tarif}','Instant','${sellerid}') type="checkbox" name="cekongkir" value="`+opsi[i].id+`" id="cktest${opsi[i].Instant_Tarif}">
                                                            <label for="cktest${opsi[i].Instant_Tarif}" onchange=test('${opsi[i].id}','${opsi[i].nama}','${opsi[i].Instant_Tarif}','Instant','${sellerid}')>
                                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Instant (`+opsi[i].nama+`) </span><br>
                                                                <span class="card-pesanan-hrg"> Rp. `+opsi[i].Instant_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                                    <div class="row align-items-center">
                                                        <div class="col-12">
                                                            <input class="form-check-input cktest" onchange=test('${opsi[i].id}','${opsi[i].nama}','${opsi[i].SameDay_Tarif}','SameDay','${sellerid}') type="checkbox" name="cekongkir" value="`+opsi[i].id+`" id="cktest${opsi[i].SameDay_Tarif}">
                                                            <label for="cktest${opsi[i].SameDay_Tarif}" onchange=test('${opsi[i].id}','${opsi[i].nama}','${opsi[i].SameDay_Tarif}','SameDay','${sellerid}')>
                                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Same Day (`+opsi[i].nama+`) </span><br>
                                                                <span class="card-pesanan-hrg"> Rp. `+a[i].SameDay_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        `
                                    document.getElementById("list-dimensi"+sellerid).innerHTML = b ;
                                    var d = $("#ongkoskirim"+sellerid).remove().append(b);
                                }
                            }
                            // $.each(jsonDimensi, function(i, jsonDimensi) {
                            //     for(i=0; i<jsonDimensi.length; i++){
                            //         b += `
                            //                 <div class="cont-list-ongkir">
                            //                     <div class="cont-pengiriman mb-2" style="margin:10px">
                            //                         <div class="row align-items-center">
                            //                             <div class="col-12">
                            //                                 <input class="form-check-input cktest" onchange=test('${jsonDimensi[i].id}','${jsonDimensi[i].nama}','${jsonDimensi[i].Instant_Tarif}','Instant','${idSeller}') type="checkbox" name="cekongkir" value="`+jsonDimensi[i].id+`" id="cktest${jsonDimensi[i].Instant_Tarif}">
                            //                                 <label for="cktest${jsonDimensi[i].Instant_Tarif}" onchange=test('${jsonDimensi[i].id}','${jsonDimensi[i].nama}','${jsonDimensi[i].Instant_Tarif}','Instant','${idSeller}')>
                            //                                     <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Instant (`+jsonDimensi[i].nama+`) </span><br>
                            //                                     <span class="card-pesanan-hrg"> Rp. `+jsonDimensi[i].Instant_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                            //                                 </label>
                            //                             </div>
                            //                         </div>
                            //                     </div>
                            //                     <div class="cont-pengiriman mb-2" style="margin:10px">
                            //                         <div class="row align-items-center">
                            //                             <div class="col-12">
                            //                                 <input class="form-check-input cktest" onchange=test('${jsonDimensi[i].id}','${jsonDimensi[i].nama}','${jsonDimensi[i].SameDay_Tarif}','SameDay','${idSeller}') type="checkbox" name="cekongkir" value="`+jsonDimensi[i].id+`" id="cktest${jsonDimensi[i].SameDay_Tarif}">
                            //                                 <label for="cktest${jsonDimensi[i].SameDay_Tarif}" onchange=test('${jsonDimensi[i].id}','${jsonDimensi[i].nama}','${jsonDimensi[i].SameDay_Tarif}','SameDay','${idSeller}')>
                            //                                     <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Same Day (`+jsonDimensi[i].nama+`) </span><br>
                            //                                     <span class="card-pesanan-hrg"> Rp. `+a[i].SameDay_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                            //                                 </label>
                            //                             </div>
                            //                         </div>
                            //                     </div>
                            //                 </div>
                            //             `
                            //         document.getElementById("list-dimensi"+idSeller).innerHTML = b ;
                            //         var d = $("#ongkoskirim"+idSeller).remove().append(b);
                            //     }
                            // })
                        }
                    });
                    }
                })
            }

            function listongkir(idSeller){
                let propinsi = $('#prov').val();
                let kota = $('#kota').val();
                let kecamatan = $('#kec').val();
                let kelurahan = $('#kel').val();
                let asalkotaa = $('#asalkota'+idSeller).val();
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'Get-Pricelist.asp',
                    data:{
                        AsalKota:asalkotaa,
                        TujuanProvinsi:propinsi,
                        TujuanKota:kota,
                        TujuanKecamatan:kecamatan
                    },
                    traditional: true,
                    success: function (data) {
                        var jsonData = JSON.parse(data);
                        var Reg = jsonData.reguler;
                        var TBerat = Number($('#JumlahBerat').val());
                        i  = "reguler";
                        NamaPengiriman  = "Reguler";
                        HargaOngkir     = Reg[0].pokok;
                        MinKg           = Reg[0].minkg;
                        HargaNextKg     = Reg[0].kgnext;
                        var o = "";
                        if(TBerat > MinKg){
                            var HargaPokok = Number(TBerat*HargaNextKg)
                        }else{
                            var HargaPokok = HargaOngkir
                        }
                        o += `
                            <div class="cont-list-ongkir-pricelist">
                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                    <div class="row align-items-center">
                                        <div class="col-12">
                                            <input class="form-check-input cktest" onchange=test('${i}','','${HargaPokok}','${NamaPengiriman}','${idSeller}') type="checkbox" name="cekongkir" value="`+HargaPokok+`" id="cktest${HargaPokok}">
                                            <label for="cktest${HargaPokok}" onchange=test('${i}','','${HargaPokok}','${NamaPengiriman}','${idSeller}')>
                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; `+NamaPengiriman+`  </span><br>
                                                <span class="card-pesanan-hrg"> Rp. `+HargaPokok+` </span><br>
                                                <span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `
                        document.getElementById("list-ongkir"+idSeller).innerHTML = o ;
                        var d = $("#ongkoskirim"+idSeller).remove().append(o);
                        // $.each(jsonData, function(i, jsonData) {
                        //     NamaPengiriman  = i;
                        //     HargaOngkir     = jsonData[0].pokok;
                        //     MinKg           = jsonData[0].minkg;
                        //     HargaNextKg     = jsonData[0].kgnext;
                        //     var KgNext      = TBerat-MinKg;
                            
                        // })
                    }
                });


                var opsipengiriman = document.getElementById("cont-list-ongkir"+ idSeller);
                if(opsipengiriman.style.display == "none"){
                    opsipengiriman.style.display = "block"
                }else{
                    opsipengiriman.style.display = "none"
                }

                var Ongkir  = Number(document.getElementById("totalongkoskirim").value);
                var Bayar   = Number(document.getElementById("totalbayar").value);
                var berat   = document.getElementById("pdBerat"+idSeller).value;

                var LatDestination      = document.getElementById("LatDestination").value;
                var LongDestination     = document.getElementById("LongDestination").value;
                var LatOrigin           = document.getElementById("LatOrigin"+idSeller).value;
                var LongOrigin          = document.getElementById("LongOrigin"+idSeller).value;
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: "Get-Distance.asp",
                    data:{
                        LatDestination,
                        LongDestination,
                        LatOrigin,
                        LongOrigin
                    },
                    traditional: true,
                    success: function (data) {
                        var distance = JSON.parse(data);
                        var km = Number(distance.JarakTempuh/1000)
                        $.ajax({
                        type: 'GET',
                        contentType: "application/json",
                        url: 'Get-Dimensi.asp',
                        traditional: true,
                        success: function (url) {
                            var jsonDimensi = JSON.parse(url);
                            var a = jsonDimensi.detail;
                            var b = "";
                            var Tberat = Number($('#JumlahBerat').val());
                            console.log(Tberat);
                            var Tjarak = km;
                                console.log(Tberat > 5);
                            if( Tberat > 5 ){
                                var kg = 0;
                                var result = a.filter(obj=> obj.MaxKg == kg);
                                for(i=0; i<result.length; i++){
                                    console.log(result[i].id);
                                    b += `
                                            <div class="cont-list-ongkir">
                                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                                    <div class="row align-items-center">
                                                        <div class="col-12">
                                                            <input class="form-check-input cktest" onchange=test('${result[i].id}','${result[i].nama}','${result[i].Instant_Tarif}','Instant','${idSeller}') type="checkbox" name="cekongkir" value="`+result[i].id+`" id="cktest${result[i].Instant_Tarif}">
                                                            <label for="cktest${result[i].Instant_Tarif}" onchange=test('${result[i].id}','${result[i].nama}','${result[i].Instant_Tarif}','Instant','${idSeller}')>
                                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Instant (`+result[i].nama+`) </span><br>
                                                                <span class="card-pesanan-hrg"> Rp. `+result[i].Instant_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                                    <div class="row align-items-center">
                                                        <div class="col-12">
                                                            <input class="form-check-input cktest" onchange=test('${result[i].id}','${result[i].nama}','${result[i].SameDay_Tarif}','SameDay','${idSeller}') type="checkbox" name="cekongkir" value="`+result[i].id+`" id="cktest${result[i].SameDay_Tarif}">
                                                            <label for="cktest${result[i].SameDay_Tarif}" onchange=test('${result[i].id}','${result[i].nama}','${result[i].SameDay_Tarif}','SameDay','${idSeller}')>
                                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Same Day (`+result[i].nama+`) </span><br>
                                                                <span class="card-pesanan-hrg"> Rp. `+a[i].SameDay_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        `
                                    document.getElementById("list-dimensi"+idSeller).innerHTML = b ;
                                    var d = $("#ongkoskirim"+idSeller).remove().append(b);
                                }
                            }else if(Tberat<=5){
                                var result = a.filter(obj=> obj.MaxKg <= Tberat);
                                var opsi   = result.filter(obj=> obj.MaxKg !== 0);
                                for(i=0; i<opsi.length; i++){
                                    console.log(opsi[i].id);
                                    b += `
                                            <div class="cont-list-ongkir">
                                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                                    <div class="row align-items-center">
                                                        <div class="col-12">
                                                            <input class="form-check-input cktest" onchange=test('${opsi[i].id}','${opsi[i].nama}','${opsi[i].Instant_Tarif}','Instant','${idSeller}') type="checkbox" name="cekongkir" value="`+opsi[i].id+`" id="cktest${opsi[i].Instant_Tarif}">
                                                            <label for="cktest${opsi[i].Instant_Tarif}" onchange=test('${opsi[i].id}','${opsi[i].nama}','${opsi[i].Instant_Tarif}','Instant','${idSeller}')>
                                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Instant (`+opsi[i].nama+`) </span><br>
                                                                <span class="card-pesanan-hrg"> Rp. `+opsi[i].Instant_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="cont-pengiriman mb-2" style="margin:10px">
                                                    <div class="row align-items-center">
                                                        <div class="col-12">
                                                            <input class="form-check-input cktest" onchange=test('${opsi[i].id}','${opsi[i].nama}','${opsi[i].SameDay_Tarif}','SameDay','${idSeller}') type="checkbox" name="cekongkir" value="`+opsi[i].id+`" id="cktest${opsi[i].SameDay_Tarif}">
                                                            <label for="cktest${opsi[i].SameDay_Tarif}" onchange=test('${opsi[i].id}','${opsi[i].nama}','${opsi[i].SameDay_Tarif}','SameDay','${idSeller}')>
                                                                <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Same Day (`+opsi[i].nama+`) </span><br>
                                                                <span class="card-pesanan-hrg"> Rp. `+a[i].SameDay_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        `
                                    document.getElementById("list-dimensi"+idSeller).innerHTML = b ;
                                    var d = $("#ongkoskirim"+idSeller).remove().append(b);
                                }
                            }
                            // $.each(jsonDimensi, function(i, jsonDimensi) {
                            //     for(i=0; i<jsonDimensi.length; i++){
                            //         b += `
                            //                 <div class="cont-list-ongkir">
                            //                     <div class="cont-pengiriman mb-2" style="margin:10px">
                            //                         <div class="row align-items-center">
                            //                             <div class="col-12">
                            //                                 <input class="form-check-input cktest" onchange=test('${jsonDimensi[i].id}','${jsonDimensi[i].nama}','${jsonDimensi[i].Instant_Tarif}','Instant','${idSeller}') type="checkbox" name="cekongkir" value="`+jsonDimensi[i].id+`" id="cktest${jsonDimensi[i].Instant_Tarif}">
                            //                                 <label for="cktest${jsonDimensi[i].Instant_Tarif}" onchange=test('${jsonDimensi[i].id}','${jsonDimensi[i].nama}','${jsonDimensi[i].Instant_Tarif}','Instant','${idSeller}')>
                            //                                     <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Instant (`+jsonDimensi[i].nama+`) </span><br>
                            //                                     <span class="card-pesanan-hrg"> Rp. `+jsonDimensi[i].Instant_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                            //                                 </label>
                            //                             </div>
                            //                         </div>
                            //                     </div>
                            //                     <div class="cont-pengiriman mb-2" style="margin:10px">
                            //                         <div class="row align-items-center">
                            //                             <div class="col-12">
                            //                                 <input class="form-check-input cktest" onchange=test('${jsonDimensi[i].id}','${jsonDimensi[i].nama}','${jsonDimensi[i].SameDay_Tarif}','SameDay','${idSeller}') type="checkbox" name="cekongkir" value="`+jsonDimensi[i].id+`" id="cktest${jsonDimensi[i].SameDay_Tarif}">
                            //                                 <label for="cktest${jsonDimensi[i].SameDay_Tarif}" onchange=test('${jsonDimensi[i].id}','${jsonDimensi[i].nama}','${jsonDimensi[i].SameDay_Tarif}','SameDay','${idSeller}')>
                            //                                     <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Same Day (`+jsonDimensi[i].nama+`) </span><br>
                            //                                     <span class="card-pesanan-hrg"> Rp. `+a[i].SameDay_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                            //                                 </label>
                            //                             </div>
                            //                         </div>
                            //                     </div>
                            //                 </div>
                            //             `
                            //         document.getElementById("list-dimensi"+idSeller).innerHTML = b ;
                            //         var d = $("#ongkoskirim"+idSeller).remove().append(b);
                            //     }
                            // })
                        }
                    });
                    }
                })
                

                TotalBayar = Number(Bayar-Ongkir);
                // document.getElementById("totalongkoskirim").value = 0 ;
                document.getElementById("totalbayar").value = TotalBayar;
            }

            var array =  []; 
            function test(x,b,c,d,sl) {
                console.log(x);
                console.log(b);
                console.log(c);
                console.log(sl);
                var BiayaOngkir = 0;
                var Bayar = Number(document.getElementById("totalbayar").value);
                var TotalBayar  = 0;
                var ck = document.getElementById("cktest"+c);
                if (ck.checked == true){
                    var obj = {
                        BiayaOngkir:Number(c)
                    }
                    array.push(obj);
                        array.map((key)=> {
                        BiayaOngkir = Number(key.BiayaOngkir)
                        TotalBayar = Bayar+BiayaOngkir
                    }); 
                    document.getElementById("totalongkoskirim").value = BiayaOngkir;
                    document.getElementById("totalbayar").value = TotalBayar;
                }
                var IdOngkir 
                var NamaOngkir
                var HargaOngkir
                let propinsi = $('#prov').val();
                let kota = $('#kota').val();
                let kecamatan = $('#kec').val();
                let kelurahan = $('#kel').val();
                let asalkotaa = $('#asalkota'+sl).val();
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'Get-Pricelist.asp',
                    data:{
                        AsalKota:asalkotaa,
                        TujuanProvinsi:propinsi,
                        TujuanKota:kota,
                        TujuanKecamatan:kecamatan
                    },
                    traditional: true,
                    success: function (data) { 
                    var jsonData = JSON.parse(data);
                    var TBerat = Number($('#JumlahBerat').val());
                    var Reg      = jsonData.reguler;
                    i  = "reguler";
                    NamaPengiriman  = "Reguler";
                    HargaOngkir     = Reg[0].pokok;
                    MinKg           = Reg[0].minkg;
                    HargaNextKg     = Reg[0].kgnext;
                    var KgNext      = TBerat-MinKg;
                    if(TBerat > MinKg){
                        var HargaPokok = Number(TBerat*HargaNextKg)
                    }else{
                        var HargaPokok = HargaOngkir
                    }
                    if( i == x  ){
                        $('#ongkosnyanih'+sl).append(`
                            <div id="ongkoskirim${sl}">
                                <div class="row align-items-center mb-3 mt-2" >
                                    <div class="col-8" id="card-ongkir'${sl}'">
                                        <span class="card-pesanan-text"> <i class="fas fa-truck-moving"></i>  &nbsp; `+NamaPengiriman+` </span><br>
                                        <span class="card-pesanan-hrg"> Rp. `+HargaPokok+` </span>
                                            <input type="hidden" name="pengiriman-sl" id="pengiriman-sl${sl}" value="`+NamaPengiriman+`">
                                            <input type="hidden" name="ongkir-seller" id="ongkir-seller${sl}" value="`+HargaPokok+`">
                                            <br>
                                            <span class="card-pesanan-desc"> Estimasi pesanan sampai 1-3 hari </span><br>
                                            <span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br>
                                        </div>
                                        <div class="col-4 text-end">
                                            <div class="form-check">
                                            <button type="button"  id="btnPilih" class="btn-pengiriman-pesanan" onclick="ubahongkir('`+sl+`')"> Ubah Pengiriman </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                `);
                            }
                        // $.each(jsonData, function(i, jsonData) {
                        //     NamaPengiriman  = i;
                        //     HargaOngkir     = jsonData[0].pokok;
                        //     MinKg           = jsonData[0].minkg;
                        //     HargaNextKg     = jsonData[0].kgnext;
                             
                            
                        // })
                    }
                });

                var xxxxxxxxx = x;
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'Get-Dimensi.asp',
                    traditional: true,
                    success: function (url) {
                    var jsonDimensi = JSON.parse(url);
                    var a = jsonDimensi.detail;
                    var n = ""
                        $.each(jsonDimensi, function(i, jsonDimensi) {
                            for(i=0; i<jsonDimensi.length; i++){
                                if( jsonDimensi[i].id == x  ){
                                    IdOngkir = jsonDimensi[i].id;
                                    NamaOngkir = jsonDimensi[i].nama;
                                    HargaOngkir = c;
                                    
                                    $('#ongkosnyanih'+sl).append(`
                                        <div id="ongkoskirim${sl}">
                                            <div class="row align-items-center mb-3 mt-2" >
                                                <div class="col-8" id="card-ongkir'${sl}'">
                                                    <span class="card-pesanan-text"> <i class="fas fa-truck-moving"></i>  &nbsp; `+d+` (`+NamaOngkir+`) </span><br>
                                                    <span class="card-pesanan-hrg"> Rp. `+HargaOngkir+` </span>
                                                    <input type="hidden" name="pengiriman-sl" id="pengiriman-sl${sl}" value="`+d+`">
                                                    <input type="hidden" name="ongkir-seller" id="ongkir-seller${sl}" value="`+HargaOngkir+`">
                                                    <br>
                                                    <span class="card-pesanan-desc"> Estimasi pesanan sampai 1-3 hari </span><br>
                                                    <span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br>
                                                </div>
                                                <div class="col-4 text-end">
                                                    <div class="form-check">
                                                    <button type="button"  id="btnPilih" class="btn-pengiriman-pesanan" onclick="listongkir('`+sl+`')"> Ubah Pengiriman </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    `);
                                }
                            }
                        })
                    }
                })
                
                // if ( Ongkir == 0 ){
                //     var ongkirseller = Number(c);
                //     var TotalOngkir  = Number(ongkirseller);
                //     var TotalBayar   = Number(Bayar+ongkirseller);
                //     document.getElementById("totalongkoskirim").value = TotalOngkir;
                //     document.getElementById("totalbayar").value = TotalBayar;
                // }else{
                //     var ongkirseller = Number(c);
                //     var TotalOngkir  = Number(Ongkir+ongkirseller);
                //     var TotalBayar   = Number(Bayar+TotalOngkir);
                //     document.getElementById("totalongkoskirim").value = TotalOngkir;
                //     document.getElementById("totalbayar").value = TotalBayar;
                // }

                var opsipengiriman = document.getElementById("cont-list-ongkir"+ sl);
                if(opsipengiriman.style.display == "block"){
                    opsipengiriman.style.display = "none"
                }else{
                    opsipengiriman.style.display = "block"
                }
            }
        </script>

        <style>
            #proteksipr{
                display:none;
            }
            .list-ongkir{
                overflow-x:hidden;
                overflow-y:scroll;
                height:10rem;
                background-color:white;
                display:none;
                box-shadow: 0 4px 8px 0 rgba(196, 196, 196, 0.2), 0 6px 20px 0 rgba(218, 218, 218, 0.19);
            }
            .cktest{
                display:block;
            }
            .text-shipment-judul{
                font-size:14px;
                color:#7e0909;
                font-family: "Poppins", sans-serif;
                font-weight:550;
                padding:10px 10px;
            }
            .card-ongkir-text{
                color:#7e0909;
                font-size:13px;
                font-family: "Poppins", sans-serif;
                font-weight:bold;
                text-transform: uppercase;
            }
            a:hover {
                text-decoration: none !important;
                color: #b61515;
                
                }
            a{
                color:white;
                font-size:22px;
                font-weight:bold;
                font-family: "Poppins", sans-serif;
            }
            .cont-pengiriman{
                padding:5px 10px;
            }
            .cont-pengiriman:hover{
                background-color:#eee;
                padding:5px 10px;
            }
            .card-alamat-penerima{
                background-color:white;
                box-shadow: 0 4px 8px 0 rgba(196, 196, 196, 0.2), 0 6px 20px 0 rgba(218, 218, 218, 0.19);
                padding:15px 20px;
                border-radius:20px;
            }
            .card-alamat-text{
                color:#0077a2;
                font-weight:550;
                font-family: "Poppins", sans-serif;
            }
            .card-pesanan{
                background-color:white;
                box-shadow: 0 4px 8px 0 rgba(196, 196, 196, 0.2), 0 6px 20px 0 rgba(218, 218, 218, 0.19);
                padding:15px 20px;
                border-radius:20px;
            }
            .card-pesanan-text{
                color:#0077a2;
                font-weight:550;
                font-size:13px;
                font-family: "Poppins", sans-serif;
                border:none;
                text-transform: uppercase;
            }
            .card-pesanan-harga{
                color:#7e0909;
                font-weight:550;
                font-size:13px;
                font-family: "Poppins", sans-serif;
                border:none;
            }
            .card-pesanan-desc{
                color:#aaa;
                font-weight:550;
                font-size:11px;
                font-family: "Poppins", sans-serif;
                border:none;
            }
            .card-pesanan-hrg{
                color:#aaa;
                font-weight:550;
                font-size:12px;
                font-family: "Poppins", sans-serif;
                border:none;
            }
            .btn-pengiriman-pesanan{
                background-color:#7e0909;
                color:white;
                padding:2px 15px;
                border:none;
                font-weight:550;
                border-radius:20px;
                font-family: "Poppins", sans-serif;
                font-size:12px;
            }
            .NamaPengiriman{
                background-color:#0077a2;
                color:white;
                font-size:13px;
                font-weight:550px;
                padding:5px 20px;
                margin:5px;
                border-radius:5px;
                text-transform: uppercase;
            }

            /* The Modal (background) */
            .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            }
            .flexCheckDefault{
                display:none
            }
            /* Modal Content */
            .modal-content {
            background-color: #fefefe;
            margin: auto;
            border-radius:20px;
            padding: 20px;
            border: 1px solid #888;
            width: 40%;
            }

            /* The Close Button */
            .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            }

            .close:hover,
            .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
            }
            #card-price-ongkir{
                height:15rem;
                overflow-x:hidden;
                overflow-y:scroll;

            }
            .card-voucher{
                background-color:white;
                box-shadow: 0 4px 8px 0 rgba(196, 196, 196, 0.2), 0 6px 20px 0 rgba(218, 218, 218, 0.19);
                padding:15px 20px;
                border-radius:20px;
            }
            .card-detail{
                background-color:white;
                box-shadow: 0 4px 8px 0 rgba(196, 196, 196, 0.2), 0 6px 20px 0 rgba(218, 218, 218, 0.19);
                padding:15px 20px;
                border-radius:20px;
            }
            .btn-pay{
                background-color:#0077a2;
                color:white;
                padding:5px 100px;
                border:none;
                border-radius:20px;
                font-weight:550;
                font-size:12px;
                font-family: "Poppins", sans-serif;
            }
            /* width */
            ::-webkit-scrollbar {
            width: 1px;
            height: 5px;
            }
            
            /* Track */
            ::-webkit-scrollbar-track {
            box-shadow: blue;
            border-radius: 5px;
            height: 1px;
            }
            
            /* Handle */
            ::-webkit-scrollbar-thumb {
            background: rgb(122, 0, 0); 
            border-radius: 5px;
            height: 1px;
            }
            .form-detail{
                border: 1px solid #aaa;
                border-radius:5px;
                padding:2px 15px;
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
                    <span class="text-header" style="color:#0077a2">   Pengiriman   </span>
                </div>
                <div class="col-1 p-0">
                </div>
                <div class="col-4">
                </div>
            </div>
        </div>
    </div>
    <form action="Create-Invoice.asp" method="POST">
    <div class="container mb-2" style="margin-top:5.5rem">
        <div class="row">
            <div class="col-8">
                <div class="row">
                    <div class="col-12">
                        <span class="text-shipment-judul"> Alamat Pengiriman </span>
                        <!-- Alamat Penerima -->
                        <input  class="txt-pesanan-inp" type="hidden" name="AlamatID" id="AlamatID" value="<%=alamat("almID")%>">
                        <input  class="txt-pesanan-inp" type="hidden" name="CustomerID" id="CustomerID" value="<%=Customer("custID")%>">
                        <input  class="txt-pesanan-inp" type="hidden" name="RekeningID" id="RekeningID" value="<%=Customer("rkID")%>">
                        <input  class="txt-pesanan-inp" type="hidden" name="BankID" id="BankID" value="<%=Customer("rkBankID")%>">
                        <input  class="txt-pesanan-inp" type="hidden" name="NomorRekening" id="NomorRekening" value="<%=Customer("rkNomorRk")%>">
                        <input  class="txt-pesanan-inp" type="hidden" name="NamaPenerima" id="NamaPenerima" value="<%=alamat("almNamaPenerima")%>">
                        <div class="card-alamat-penerima">
                            <div class="row">
                                <div class="col-12">
                                    <span class="card-alamat-text" > <i class="fas fa-map-marker-alt">  </i> </span> &nbsp; <span class="card-alamat-text" ><%=alamat("almNamaPenerima")%></span> &nbsp; <b>|</b> &nbsp; <span class="txt-pesanan" ><%=Customer("almPhonePenerima")%></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <span class="txt-pesanan" > <%=Customer("almLengkap")%></span> - <span class="txt-pesanan" > <%=Customer("almKel")%> , <%=Customer("almKec")%> , <%=Customer("almKota")%>, <%=Customer("almProvinsi")%></span> , <span class="txt-pesanan" > <%=Customer("almkdpos")%></span><br>
                                    <span class="txt-pesanan" >[<%=Customer("almLabel")%>]</span>
                                </div>
                            </div>
                            <div class="card-footer mt-2">
                                <span class="card-alamat-text"> Catatan Alamat </span>
                            </div>
                            <input type="hidden"name="prov" id="prov" value="<%=Customer("almProvinsi")%>">
                            <input type="hidden"name="kota" id="kota" value="<%=Customer("almKota")%>">
                            <input type="hidden"name="kec" id="kec" value="<%=Customer("almKec")%>">
                            <input type="hidden"name="kel" id="kel" value="<%=Customer("almKel")%>">
                            <input type="hidden"name="LatDestination" id="LatDestination" value="<%=Customer("LatDestination")%>">
                            <input type="hidden"name="LongDestination" id="LongDestination" value="<%=Customer("LongDestination")%>">
                            <script>
                                let propinsi = $('#prov').val();
                                let kota = $('#kota').val();
                                let kecamatan = $('#kec').val();
                                let kelurahan = $('#kel').val();
                            </script>
                        <!-- Alamat Penerima -->
                        </div>
                    </div>
                </div>
                <div class="row mt-4 ">
                    <div class="col-12">
                        <span class="text-shipment-judul"> Pesanan Anda </span>
                        <%     
                            no=0
                            do while not seller.eof
                            no=no+1
                        %>
                        <div class="card-pesanan mb-2">

                            <!-- SellerID -->
                                <input class="txt-pesanan" type="hidden" name="slid" id="slid<%=no%>" value="<%=seller("cart_slID")%>">
                            <!-- SellerID -->

                            <div class="row">
                                <div class="col-10">
                                    <span class="card-pesanan-text"> <i class="fas fa-store-alt"></i> &nbsp; &nbsp; <%=seller("slName")%></span>
                                    <input class="txt-pesanan" type="hidden" name="SRekeningID" id="SRekeningID" value="<%=seller("rkID")%>">
                                    <input class="txt-pesanan" type="hidden" name="SAlamatID" id="SAlamatID" value="<%=seller("sl_almID")%>">
                                    <input class="txt-pesanan" type="hidden" name="SBankID" id="SBankID" value="<%=seller("rkBankID")%>">
                                    <input class="txt-pesanan" type="hidden" name="SNomorRekening" id="SNomorRekening" value="<%=seller("rkNomorRk")%>">
                                    <input class="txt-pesanan" type="hidden" name="SellerID" id="SellerID" value="<%=seller("cart_slID")%>">
                                </div>
                                    <% 
                                        alamattoko_cmd.commandText = "SELECT MKT_M_Alamat.almKota, MKT_M_Alamat.almID FROM MKT_M_Seller LEFT OUTER JOIN  MKT_M_Alamat ON MKT_M_Seller.sl_almID = MKT_M_Alamat.almID RIGHT OUTER JOIN  MKT_T_Keranjang ON MKT_M_Seller.sl_custID = MKT_T_Keranjang.cart_slID where MKT_T_Keranjang.cart_slID = '"& seller("cart_slID") &"' GROUP BY  MKT_M_Alamat.almKota, MKT_M_Alamat.almID "
                                        'response.write alamattoko_cmd.commandText
                                        set alamattoko = alamattoko_cmd.execute
                                    %>
                                    <input class="txt-pesanan" type="hidden" name="asalkota" id="asalkota<%=seller("cart_slID")%>" value="<%=alamattoko("almKota")%>" style="width:17rem">
                                    <input class="txt-pesanan" type="hidden" name="LatOrigin" id="LatOrigin<%=seller("cart_slID")%>" value="<%=seller("LatOrigin")%>" style="width:17rem">
                                    <input class="txt-pesanan" type="hidden" name="LongOrigin" id="LongOrigin<%=seller("cart_slID")%>" value="<%=seller("LongOrigin")%>" style="width:17rem">
                                <div class="col-2 text-end">
                                    <span class="card-pesanan-text"> <i class="fas fa-truck"></i> &nbsp;&nbsp; <%=alamattoko("almKota")%> </span>
                                </div>
                            </div>
                            <hr>
                            <script>
                                $(document).ready(function(){
                                    let berat = Number($('#pdBerat<%=alamattoko("almID")%>').val());
                                    let volume = Number($('#pdVolume<%=alamattoko("almID")%>').val());
                                    if ( berat >= volume ){
                                        $('#hitungongkir<%=alamattoko("almID")%>').val(berat);
                                    }else{
                                        $('#hitungongkir<%=alamattoko("almID")%>').val(volume);
                                    }
                                    let grams = document.getElementById('hitungongkir<%=alamattoko("almID")%>').value/1000;
                                    document.getElementById("grams<%=alamattoko("almID")%>").value = grams;
                                });
                                
                                function totalbayar(){
                                    var grandtotal = parseInt(document.getElementById("grandtotal").value);
                                    var tongkir = parseInt(document.getElementById("totalongkoskirim").value);
                                    var tdiskon = parseInt(document.getElementById("totaldiskon").value);
                                    var totalbayar = 0;
                                    totalbayar = grandtotal+tongkir+tdiskon;
                                    document.getElementById("totalbayar").value = totalbayar;
                                    
                                }
                            </script>
                            <%
                                produk_cmd.commandText = "SELECT MKT_M_Produk.pdID,MKT_M_Alamat.almKota,MKT_T_Keranjang.cart_pdID, MKT_M_Alamat.almID, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama,MKT_M_Produk.pdHargaJual, MKT_T_Keranjang.cartQty, MKT_M_Produk.pdBerat, SUM(MKT_M_Produk.pdBerat) AS TotalBerat, MKT_M_Produk.pdPanjang,MKT_M_Produk.pdLebar, MKT_M_Produk.pdVolume, MKT_M_Produk.pdTinggi, SUM(MKT_M_Produk.pdPanjang*MKT_M_Produk.pdLebar*MKT_M_Produk.pdTinggi) AS TotalUkuran, SUM(MKT_M_Produk.pdVolume) AS TotalVolume, MKT_T_Keranjang.cart_slID,  MKT_M_Produk.pd_almID FROM MKT_M_Produk LEFT OUTER JOIN  MKT_M_Alamat ON MKT_M_Produk.pd_almID = MKT_M_Alamat.almID RIGHT OUTER JOIN  MKT_T_Keranjang ON MKT_M_Produk.pdID = MKT_T_Keranjang.cart_pdID  where (MKT_T_Keranjang.cart_slID = '"& seller("cart_slID") &"')  AND (MKT_T_Keranjang.cart_custID = '"& seller("cart_custID") &"') " &  FilterFix  &" GROUP BY MKT_M_Alamat.almKota, MKT_M_Alamat.almID, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_M_Produk.pdID, MKT_M_Produk.pdBerat, MKT_M_Produk.pdVolume, MKT_M_Produk.pdHargaJual, MKT_T_Keranjang.cart_slID, MKT_T_Keranjang.cartQty,MKT_M_Produk.pdTinggi,MKT_M_Produk.pdPanjang,MKT_M_Produk.pdLebar,  MKT_M_Produk.pd_almID,MKT_T_Keranjang.cart_pdID"
                                'response.write produk_cmd.commandText
                                set produk = produk_cmd.execute
                                
                            %>
                            <% 
                                pd = 0
                                do while not produk.eof
                                pd = pd +1
                                
                            %>
                                <div class="row align-items-center mt-2">
                                    <div class="col-2">
                                        <img src="data:image/png;base64,<%=produk("pdImage1")%>" width="80" height="80" alt="data:image/png;base64,<%=produk("pdImage1")%>"/>
                                    </div>
                                    <div class="col-9">
                                        <span class="card-pesanan-text"> <%=produk("pdNama")%> </span><br>
                                        <i class="fas fa-tags" style="font-size:11px; color:#7e0909"></i> &nbsp;<span class="card-pesanan-harga"> <%=Replace(Replace(FormatCurrency(produk("pdHargaJual")),"$","Rp. "),".00","")%> </span><br>

                                        <i class="fas fa-box-open" style="font-size:11px; color:#7e0909"></i> &nbsp;
                                        <span class="card-pesanan-desc"> <%=produk("cartQty")%></span>

                                        <input class="txt-pesanan input-txt" type="hidden" name="pdHargaJual" id="pdHargaJual" value="<%=produk("pdHargaJual")%>">
                                        <input class="txt-pesanan input-txt" type="hidden" name="pdQty" id="pdQty" value="<%=produk("cartQty")%>">
                                        <% Total = produk("pdHargaJual")*produk("cartQty") %>
                                        <input class="txt-pesanan input-txt" type="hidden" name="pdSubtotal" id="pdSubtotal" value="<%=total%>" style="width:7rem">
                                    </div>
                                    <div class="col-1">
                                        <a > <i class="fas fa-ellipsis-v"></i> </a>
                                    </div>
                                    <input class="txt-pesanan" type="hidden" name="pdID" id="pdID" value="<%=produk("pdID")%>">
                                    <input class="txt-pesanan" type="hidden" name="pdBerat" id="pdBerat<%=seller("cart_slID")%>" value="<%=produk("pdBerat")%>">
                                    <input class="txt-pesanan" type="hidden" name="pdPanjang" id="pdPanjang<%=alamattoko("almID")%>" value="<%=produk("pdPanjang")%>">
                                    <input class="txt-pesanan" type="hidden" name="pdLebar" id="pdLebar<%=alamattoko("almID")%>" value="<%=produk("pdLebar")%>">
                                    <input class="txt-pesanan" type="hidden" name="pdTinggi" id="pdTinggi<%=alamattoko("almID")%>" value="<%=produk("pdTinggi")%>">
                                    <input class="txt-pesanan" type="hidden" name="pdVolume" id="pdVolume<%=alamattoko("almID")%>" value="<%=produk("pdVolume")%>">
                                    <input class="txt-pesanan" type="hidden" name="hitungongkir" id="hitungongkir<%=alamattoko("almID")%>" value="">
                                    <input class="txt-pesanan" type="hidden" name="grams" id="grams<%=alamattoko("almID")%>" value="">
                                </div>
                                <!--Proteksi Produk-->
                                <div class="row">
                                    <div class="col-12">
                                        <input class="form-check-input" onchange="proteksi('<%=produk("pdID")%>','10000','Y')" type="checkbox" id="CKProteksiProduk<%=produk("pdID")%>" value="N">
                                        <input name="pdProteksiYN" id="pdProteksiYN<%=produk("pdID")%>" type="hidden" value="N">
                                        <input name="pdBiayaProteksi" id="pdBiayaProteksi<%=produk("pdID")%>" type="hidden" value="0">
                                        <div class="form-check form-check-inline">
                                            <label class="card-pesanan-desc text-proteksi form-check-label" for="CKProteksiProduk" id="text-proteksi<%=produk("pdID")%>" style="color:black">Proteksi Kerusakan Total</label><br>
                                            <span class="card-pesanan-desc desc-proteksi" id="desc-proteksi<%=produk("pdID")%>"> Lindungi produk anda dari kerusakan ataupun kejadian tidak terduga </span><br>
                                            <span class="card-pesanan-desc harga-proteksi" id="harga-proteksi<%=produk("pdID")%>"> Rp. 10.000 </span>
                                        </div>
                                    </div>
                                </div>
                                <!--Proteksi Produk-->
                                <script>
                                //     $('#CKProteksiProduk').change(function(){
                                //     if($(this).is(":checked")) {
                                //         document.getElementById("text-proteksi").style.color = "#0077a2";
                                //         document.getElementById("desc-proteksi").style.color = "#0077a2";
                                //         document.getElementById("harga-proteksi").style.color = "#7e0909";
                                //         $('#pdProteksiYN').val('Y');
                                //         $('#pdBiayaProteksi').val('10000');
                                //         $('#proteksiproduk').show();
                                //         $('#proteksipr').show();
                                //         var bayar = Number($('#totalbayar').val());
                                //         var proteksi = Number(bayar+10000);
                                //         $('#totalbayar').val(proteksi)
                                //     } else {
                                //         document.getElementById("text-proteksi").style.color = "black";
                                //         document.getElementById("desc-proteksi").style.color = "#aaa";
                                //         document.getElementById("harga-proteksi").style.color = "#aaa";
                                //         $('#pdProteksiYN').val('N');
                                //         $('#pdBiayaProteksi').val('0');
                                //         $('#proteksiproduk').hide();
                                //         $('#proteksipr').hide();
                                //         var bayar = Number($('#totalbayar').val());
                                //         var proteksi = Number(bayar-10000);
                                //         $('#totalbayar').val(proteksi);
                                //     }
                                // });
                                </script>
                                
                            <%
                                TotalBerat      = TotalBerat + produk("pdBerat")
                                TotalVolume     = TotalVolume + produk("TotalVolume")
                                if TotalBerat>TotalVolume then
                                    JumlahBerat = TotalBerat/1000
                                else
                                    JumlahBerat = TotalVolume/1000
                                end if
                                TotalPesanan    = TotalPesanan + Total
                                TotalQty        = TotalQty + produk("cartQty")
                            %>
                            <% 
                                produk.movenext
                                loop 
                                tpd = pd
                            %>
                            <input type="hidden" name="totalproduk" id="totalproduk" value="<%=tpd%>" >
                            <input type="hidden" name="TotalBerat" id="TotalBerat" value="<%=TotalBerat%>" >
                            <input type="hidden" name="TotalVolume" id="TotalVolume" value="<%=TotalVolume%>" >
                            <input type="hidden" name="JumlahBerat" id="JumlahBerat" value="<%=JumlahBerat%>" >
                            <!--Catatan Seller-->
                                <div class="row mb-2 mt-2 align-items-center">
                                    <div class="col-2">
                                        <span class="card-pesanan-desc"> Catatan </span>
                                    </div>
                                    <div class="col-10">
                                        <input type="text" class="card-pesanan-desc form-detail" name="catatan-sl" id="catatan-sl" value=""  placeholder="Tuliskan Catatan Untuk Seller">
                                    </div>
                                </div>
                            <!--Catatan Seller-->
                            <hr>
                            <!--Ongkos Kirim / Seller-->
                            <div class="card-ongkir<%=seller("cart_slID")%>" id="ongkosnyanih<%=seller("cart_slID")%>">
                                <div  id="ongkoskirim<%=seller("cart_slID")%>">
                                    <div class="row align-items-center mb-3 mt-2" >
                                        <div class="col-8" id="card-ongkir<%=seller("cart_slID")%>">
                                            <span class="card-pesanan-text"> <i class="fas fa-truck-moving"></i>  &nbsp; Pilih Pengiriman > </span><br>
                                        </div>
                                        <div class="col-4 text-end">
                                            <div class="form-check">
                                            <button type="button"  class="btn-pengiriman-pesanan"  id="btnPilih" onclick="listongkir('<%=seller("cart_slID")%>')"> PIlih Pengiriman</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script>
                                // let asalkotaa<%=alamattoko("almID")%> = $('#asalkota<%=alamattoko("almID")%>').val();
                                // $.ajax({
                                //     type: 'GET',
                                //     contentType: "application/json",
                                //     url: 'Get-Pricelist.asp',
                                //     data:{
                                //         AsalKota:asalkotaa<%=alamattoko("almID")%>
                                //     },
                                //     traditional: true,
                                //     success: function (data) {
                                //         $.each(data, function(i, data) {
                                //             $('#list-ongkir<%=seller("cart_slID")%>').append('<option class="text-span"value="'+i+'">'+i+'</option>');
                                //         });
                                //     }
                                // });
                            </script>
                            <div class="list-ongkir" id="cont-list-ongkir<%=seller("cart_slID")%>" style="display:none">
                                <div id="list-ongkir<%=seller("cart_slID")%>">

                                </div>
                                <div id="list-dimensi<%=seller("cart_slID")%>">

                                </div>
                            </div>
                            <!--Ongkos Kirim / Seller-->
                            <% 
                                GrandTotalPesanan   = GrandTotalPesanan + TotalPesanan 
                                TotalPesanan        = 0
                                GrandTotalQty       = GrandTotalQty + TotalQty
                                TotalQty            = 0
                            %>
                        </div>
                            <% 
                                seller.movenext
                                loop
                                JumlahSeller = no 
                            %>
                            <input type="hidden" name="grandtotalpd" id="grandtotalpd" value="<%=GrandTotalQty%>" >
                            <input type="hidden" name="JumlahSeller" id="JumlahSeller" value="<%=JumlahSeller%>" >
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="row">
                    <div class="col-12">
                        <span class="text-shipment-judul"> Voucher dan Promo </span>
                        <div class="card-voucher">
                            <div class="row">
                                <div class="col-11">
                                    <span class="txt-pesanan dsc"> <i class="fas fa-ticket-alt"></i> Kode Promo dan Voucher </span>
                                </div>
                                <div class="col-1">
                                    <span> <i class="fas fa-chevron-right"></i> </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-12">
                        <span class="text-shipment-judul"> Detail Pesanan </span>
                        <div class="card-detail">
                            <div class="row">
                                <div class="col-8">
                                <span class="txt-pesanan dsc"> Sub Total Pesanan </span><br>
                                <span class="txt-pesanan dsc"> Total QTY </span><br>
                                <span class="txt-pesanan dsc"> Biaya Kirim </span><br>
                                <span class="txt-pesanan dsc"> Voucher Diskon </span><br>
                                <span class="txt-pesanan dsc"> Biaya Layanan </span><br>
                                <span class="txt-pesanan dsc"> Biaya Penanganan </span><br>
                                <span class="txt-pesanan dsc" id="proteksiproduk"> Proteksi Produk </span>
                            </div>
                            <div class="col-4 text-end">
                            <input class="form-inp input-txt" type="text" name="grandtotal" id="grandtotal" value="<%=GrandTotalPesanan%>">
                            <input class="form-inp input-txt" type="text" name="GrandTotalQty" id="GrandTotalQty" value="<%=GrandTotalQty%>">
                            <input class="form-inp input-txt" onblur="return hitungongkir()" type="text" name="totalongkoskirim" id="totalongkoskirim" value="0">
                            <input class="form-inp input-txt" type="text" name="totaldiskon" id="totaldiskon" value="0">
                            <input class="form-inp input-txt" type="text" name="biayalayanan" id="biayalayanan" value="1000">
                        <input class="form-inp input-txt" type="text" name="biayapenanganan" id="biayapenanganan" value="1000">
                            <input class="form-inp input-txt" type="text" name="TotalProteksi" id="TotalProteksi" value="0">
                            </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-8">
                                    <span class="txt-pesanan dsc"  onclick="return totalbayar()"> Total Pembayaran </span><br>
                                </div>
                                <div class="col-4 text-end">
                                    <input class="form-inp input-txt" type="text" name="totalbayar" id="totalbayar" value="0">
                                </div>
                            </div>
                            <div class="row text-center mt-4">
                                <div class="col-12">
                                    <input type="submit" class="btn-pay" value="Buat Pesanan"> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script> 

    <script>
        $( document ).ready(function() {
            var TotalPesanan        = Number(document.getElementById("grandtotal").value);
            var TotalOngkir         = Number(document.getElementById("totalongkoskirim").value);
            var TotalDiskon         = Number(document.getElementById("totaldiskon").value);
            var BiayaLayanan        = Number(document.getElementById("biayalayanan").value);
            var BiayaPenanganan     = Number(document.getElementById("biayapenanganan").value);
            var TotalPembayaran     = TotalPesanan+TotalOngkir+TotalDiskon+BiayaLayanan+BiayaPenanganan;
            document.getElementById("totalbayar").value = TotalPembayaran
        });
    </script>
</html>