<!--#include file="../../connections/pigoConn.asp"--> 

<%
	if request.Cookies("custEmail")="" then 

    response.redirect("../../")
    
    end if
			
	set customer_cmd =  server.createObject("ADODB.COMMAND")
    customer_cmd.activeConnection = MM_PIGO_String

    customer_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPassword, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custPhone3, MKT_M_Customer.custJk, MKT_M_Customer.custTglLahir, MKT_M_Customer.custRekening, MKT_M_Customer.custStatus, MKT_M_Customer.custRating, MKT_M_Customer.custPoinReward, MKT_M_Customer.custLastLogin, MKT_M_Customer.custVerified, MKT_M_Customer.custPhoto, MKT_M_Customer.custDakotaGYN, MKT_M_Customer.custAktifYN, MKT_M_Seller.slName, MKT_M_Seller.slVerified, MKT_M_Seller.slAktifYN, MKT_M_Seller.sl_almID FROM MKT_M_Customer LEFT OUTER JOIN  MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID where custID = '"& request.Cookies("custID") &"'"
    set customer = customer_CMD.execute

	set Seller_cmd =  server.createObject("ADODB.COMMAND")
    Seller_cmd.activeConnection = MM_PIGO_String

    Seller_cmd.commandText = "SELECT MKT_M_Seller.sl_custID, MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Seller.slVerified, MKT_M_Seller.slAktifYN FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID  where MKT_M_Customer.custID = '"& request.Cookies("custID") &"' GROUP BY  MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Seller.slVerified, MKT_M_Seller.sl_custID, MKT_M_Seller.slAktifYN "
    set Seller = Seller_CMD.execute

	set Alamat_cmd =  server.createObject("ADODB.COMMAND")
    Alamat_cmd.activeConnection = MM_PIGO_String

    Alamat_cmd.commandText = "select * from MKT_M_Alamat where alm_custID = '"& request.Cookies("custID") &"'"
    set Alamat = Alamat_CMD.execute

	set updatealamat_cmd =  server.createObject("ADODB.COMMAND")
    updatealamat_cmd.activeConnection = MM_PIGO_String

    updatealamat_cmd.commandText = "select * from MKT_M_Alamat where almID = '"& request.Cookies("almID") &"'"
    set updatealamat = updatealamat_CMD.execute

    
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="alamat.css">
        <link rel="stylesheet" type="text/css" href="../../css/stylehome.css">
        <link rel="stylesheet" type="text/css" href="../../fontawesome/css/all.min.css">
        <link rel="stylesheet" href="../../css/leaflet.css" />
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css" />
        <script src="https://unpkg.com/leaflet@1.3.1/dist/leaflet.js"></script>
        <script src="../../js/leaflet.js"></script>
        <script src="../../js/jquery-3.6.0.min.js"></script>

        <title>PIGO</title>
        
    <script>

        function loadmodal(id){
            $.ajax({
                url: 'update-alamat.asp',
                data: { id : id},
                method: 'post',
                success: function (data) {
                    function splitString(strToSplit, separator) {
                    var arry = strToSplit.split(separator);
                        $(".namapenerima").val(arry[0]);
                        $(".phonepenerima").val(arry[1]);
                        $(".prov").val(arry[2]);
                    }
                    const koma = ",";
                    splitString(data, koma); 
                }
            });
        }
        function openCity(evt, cityName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";
            }
            function semuaalamat(){
            var a = document.getElementById('semualamat').value;
                    location.reload();
            }
            function alamatpribadi(){
            var a = document.getElementById('alamatpribadi').value;
                $.get("alamatpribadi/index.asp",function(data){
                    $('#alamat-pribadi').show();
                    $('#semua-alamat').hide();
                    $('#alamat-pengirim').hide();
                    $('#alamat-pengembalian').hide();
                    $('.cont-alamatpribadi').html(data);
                });
            }
            function alamatpengirim(){
            var a = document.getElementById('alamatpengirim').value;
                $.get("alamatpengiriman/index.asp",function(data){
                    $('#alamat-pengirim').show();
                    $('#alamat-pribadi').hide();
                    $('#semua-alamat').hide();
                    $('#alamat-pengembalian').hide();
                    $('.cont-alamatpengirim').html(data);
                });
            }
            function alamatpengembalian(){
            var a = document.getElementById('alamatpengembalian').value;
                $.get("alamatpengembalian/index.asp",function(data){
                    $('#alamat-pengembalian').show();
                    $('#alamat-pengirim').hide();
                    $('#alamat-pribadi').hide();
                    $('#semua-alamat').hide();
                    $('.cont-alamatpengembalian').html(data);
                });
            }
    </script>
    <style>
        #lat, #lon { 
            text-align:right
            }
        #map {
            width:40rem;
            height:100%;
            padding:0;
            margin:0; 
            }
        .address { 
            cursor:pointer 
            }
        .address:hover { 
            color:#AA0000;text-decoration:underline
            }

        #container-rek {
            width: 45rem;
            height: 20rem;    
            margin-bottom: 20px;   
            margin-left:10px;
            margin-top:10px;
            /* background-color:grey; */
            overflow-y: auto; 
        }
        #overflow-rek {
            width:37.7rem;
            height:14rem; 
            margin-bottom: 30px;
            /* background-color:red; */
            margin-left:10px;
            padding:10px 10px;

        }
        
        </style>
    </head>
<body >
<!-- Header -->
    <!--#include file="../../header.asp"-->
<!-- Header -->

<!--Body-->

    <div class="alamat" style="margin-top:6rem; padding: 20px 20px">
        <div class="row" >
            <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                        <button class="dropdown-btn mt-3" >Akun Saya<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct text-dr">
                                <a class="text-dr" href="<%=base_url%>/Customer/Profile/">Profile</a>
                                <a class="text-dr" href="<%=base_url%>/Customer/Alamat/">Alamat Saya </a>
                                <a class="text-dr" href="<%=base_url%>/Customer/Rekening/">Rekening</a>
                            </div>
                        <button class="dropdown-btn" >Pesanan<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct text-dr">
                                <a class="text-dr" href="<%=base_url%>/Customer/Pesanan/">Pesanan Saya</a>
                                <a class="text-dr" href="">Pengiriman</a>
                                <a class="text-dr" href="">Pengembalian</a>
                            </div>
                        <button class="dropdown-btn" >Notifikasi<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct text-dr">
                                <a class="text-dr" href="<%=base_url%>/Customer/Notifikasi/Pesanan/">Notifikasi Pesanan</a>
                                <a class="text-dr" href="">Notifikasi Chat</a>
                                <a class="text-dr" href="">Promo Official PIGO</a>
                                <a class="text-dr" href="">Penilaian</a>
                                <a class="text-dr" href="">Info Offical PIGO</a>
                            </div>
                        <button class="dropdown-btn" >Poin Reward<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct">
                                <a class="text-dr" href="">Poin Reward</a>
                            </div>
                    </div>
            <!--Sub Body-->
            <div class="col-lg-0 col-md-0 col-sm-0 col-9 mt-3" style="margin-left:20px">
            <div class="row div-alamat">
                <div class="col-10">
                    <span class="txt-alamat-judul"> Alamat Saya </span>
                </div>
                <div class="col-2">
                    <button class="btn-tambah" id="myBtnal"> Tambah Alamat </button>
                </div>
                <div class="tabs justify-content-between mt-2">
                    <div class="row">
                        <div class="col-3">
                            <button id="semualamat" onclick="semuaalamat()"onclick="openCity(event, 'semua-alamat')" style="font-size:12px">Semua Alamat</button>
                        </div>
                        <div class="col-3">
                            <button id="alamatpribadi" onclick="alamatpribadi()" class="tablinks" onclick="openCity(event, 'alamat-pribadi')" style="font-size:12px">Alamat Pribadi</button>
                        </div>
                        <div class="col-3">
                            <button id="alamatpengirim" onclick="alamatpengirim()" class="tablinks" onclick="openCity(event, 'alamat-pengirim')" style="font-size:12px">Alamat Pengiriman</button>
                        </div>
                        <div class="col-3">
                            <button id="alamatpengembalian" onclick="alamatpengembalian()" class="tablinks" onclick="openCity(event, 'alamat-pengembalian')" style="font-size:12px">Alamat Pengembalin</button>
                        </div>
                    </div>
                </div>
                
                <div id="semua-alamat" class=" mt-2">
                    <div class="row" id="row-semuaalamat">
                        <div class="col-12 cont-semuaalamat">
                            <% do while not Alamat.EOF %>
                            <div class="row d-alamat mt-3">
                                <div class="col-10">
                                    <div class="row mt-1">
                                        <div class="col-12">
                                            <span class="txt-dsc-alamat"> <%=Alamat("almJenis")%> </span><br>
                                        </div>
                                    </div>
                                    <div class="row mt-1">
                                        <div class="col-4">
                                            <span class="txt-dsc-alamat"> <%=Alamat("almNamaPenerima")%> </span><br>
                                        </div>
                                        <div class="col-6">
                                            <span class="txt-dsc-alamat label-alamat"> <%=Alamat("almLabel")%> </span><br>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-12">
                                            <span class="txt-dsc-alamat"> <b><%=Alamat("almPhonePenerima")%></b> </span><br>
                                            <span class="txt-dsc-alamat"> <%=Alamat("almLengkap")%> </span><br>
                                            <span class="txt-dsc-alamat"> <%=Alamat("almDetail")%> </span><br>
                                            <span class="txt-dsc-alamat"> <%=Alamat("almKel")%> - <%=Alamat("almKec")%> - <%=Alamat("almKota")%> - <%=Alamat("almProvinsi")%> - <%=Alamat("almKdpOs")%></span><br>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <span class="txt-dsc-alamat"> Ubah Alamat </span>
                                </div>
                            </div>
                            <% Alamat.movenext
                            loop%>
                        </div>
                    </div>
                </div>

                <div id="alamat-pribadi" class=" mt-2" style="display:none">
                    <div class="row" id="row-alamatpribadi">
                        <div class="col-12 cont-alamatpribadi">
                                
                        </div>
                    </div>
                </div>
                <div id="alamat-pengirim" class=" mt-2" style="display:none">
                    <div class="row" id="row-alamatpengirim">
                        <div class="col-12 cont-alamatpengirim">
                                
                        </div>
                    </div>
                </div>
                <div id="alamat-pengembalian" class=" mt-2" style="display:none">
                    <div class="row" id="row-alamatpengembalian">
                        <div class="col-12 cont-alamatpengembalian">
                                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Tambah Alamat -->
<div id="myModalal" class="modalal">

<div class="modalal-content">
        <div class="modalal-header mt-2">
            <span class="close">&times;</span>
            <h5>Tambah Alamat Baru</h5>
        </div>
        <div class="modalal-body mt-2">
        <form method="post" action="P-alamat.asp">
            <div id="container-rek">
                <div id="overflow-rek">
                    <div class="row">
                        <div class="col-5">
                            <span class="text-updatealamat"> Nama </span><br>
                            <input class="form-updatealamat" style="width:14rem" type="text" name="namapenerima"id="namapenerima" placeholder="Masukan Nama Penerima">
                        </div>
                        <div class="col-7">
                            <div class="row" id="idphonepenerima">
                                <div class="col-12">
                                    <span class="text-updatealamat"> Nomor Telepon </span><br>
                                    <select class="select-alamat" name="phonepenerima" id="phonepenerima" style="border:1px solif black; width: 24rem;">
                                        <option class="text-updatealamat" value="">Pilh Nomor Telepon</option>
                                        <option class="text-updatealamat" value="<%=customer("custPhone1")%>"><%=customer("custPhone1")%></option>
                                        <option class="text-updatealamat" value="<%=customer("custPhone2")%>"><%=customer("custPhone2")%></option>
                                        <option class="text-updatealamat" value="<%=customer("custPhone3")%>"><%=customer("custPhone3")%></option>
                                        <option class="text-updatealamat" value="">Masukan Nomor Telepon Baru</option>
                                    </select>                                
                                </div>
                            </div>
                            
                            <div class="row" id="phonealm" style="display:none">
                                <div class="col-12">
                                    <span class="text-updatealamat"> Masukan Nomor Telepon Baru </span><br>
                                    <input class="form-updatealamat" style="width:24rem" type="text" name="phonepenerima" id="phonepenerima" value="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-5">
                            <span class="text-updatealamat"> Label Alamat </span><br>
                        </div>
                        <div class="col-7">
                            <select class="select-alamat" name="labelalamat" id="labelalamat"
                                style="border:1px solif black; width: 24rem;">
                                <option class="text-updatealamat" value="Rumah">Alamat Utama</option>
                                <option class="text-updatealamat" value="Rumah">Rumah</option>
                                <option class="text-updatealamat" value="Kantor">Kantor</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-5">
                            <span class="text-updatealamat"> Provinsi </span><br>
                        </div>
                        <div class="col-7">
                            <select class="select-alamat" name="provinsi" id="provinsi" style="border:1px solif black; width: 24rem;">
                            <option value="">Pilih provinsi</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-5">
                            <span class="text-updatealamat"> Kota/Kabupaten </span><br>
                        </div>
                        <div class="col-7">
                            <select class="select-alamat" name="kab" id="kab" style="border:1px solif black; width: 24rem;">
                            <option value="">Pilih Kota/Kabupaten</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-5">
                            <span class="text-updatealamat"> Kecamatan </span><br>
                        </div>
                        <div class="col-7">
                            <select class="select-alamat" name="kec" id="kec" style="border:1px solif black; width: 24rem;">
                                <option value="">Pilih Kecamatan</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-5">
                            <span class="text-updatealamat"> Kelurahan </span><br>
                        </div>
                        <div class="col-7">
                            <select class="select-alamat" name="kel" id="kel" style="border:1px solif black; width: 24rem;">
                                <option value="">Pilih Kelurahan</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-5">
                            <span class="text-updatealamat"> Kode Pos </span><br>
                        </div>
                        <div class="col-7">
                            <select class="select-alamat" name="kdpos" id="kdpos" style="border:1px solif black; width: 24rem;">
                                <option class="select-alamat" value="">Kode Pos</option>
                            </select>
                        </div>
                    </div>
                    <div class="row" style="display:none">
                        <div class="col-5">
                            <span class="text-updatealamat"> Koordinat </span><br>
                        </div>
                        <div class="col-3">
                            <input type="text" name="lat" id="lat" size=12 value="">
                        </div>
                        <div class="col-3">
                            <input type="text" name="lon" id="lon" size=12 value="">
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-5">
                            <span class="text-updatealamat"> Cari Alamat </span><br>
                        </div>
                        <div class="col-6">
                            <div id="search">
                                <input type="text" class="form-updatealamat" name="addr" value="" id="addr" style="width: 24rem;" placeholder="Cari Alamat"><br>
                                <button class="btn-cari" type="button" onclick="addr_search();">Cari</button><br>
                                <span class="txt-dsc-carialamat"> *Alamat yang di cari [Alamat Lengkap/Kode Pos/Kelurahan/Kecamatan/Atau Sekitarnya] </span><br>
                                <span class="txt-dsc-carialamat"> *pin lokasi dapat di pindahkan sesuai alamat  </span><br>
                                <span class="txt-dsc-carialamat"> *Klik Pada Alamat yang sesuai</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div id="results">

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">

                        </div>
                    </div>
                    <div id="map">

                    </div>
                        <script>
                        var startlat = -6.164171801212934;
                        var startlon = 106.84507323380842;
                        var options = {
                            center: [startlat, startlon],
                            zoom: 9
                        }
                        document.getElementById('lat').value = startlat;
                        document.getElementById('lon').value = startlon;

                        var map = L.map('map', options);
                        var nzoom = 12;

                        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', { attribution: 'OSM' }).addTo(map);

                        var myMarker = L.marker([startlat, startlon], { title: "Coordinates", alt: "Coordinates", draggable: true }).addTo(map).on('dragend', function () {
                            
                            var lat = myMarker.getLatLng().lat.toFixed(8);
                            var lon = myMarker.getLatLng().lng.toFixed(8);
                            var czoom = map.getZoom();
                            if (czoom < 18) {
                                nzoom = czoom + 2;
                            }
                            if (nzoom > 18) {
                                nzoom = 18;
                            }
                            if (czoom != 18) {
                                map.setView([lat, lon], nzoom);
                            } else {
                                map.setView([lat, lon]);
                            }
                            document.getElementById('lat').value = lat;
                            document.getElementById('lon').value = lon;
                            myMarker.bindPopup("Lat " + lat + "<br />Lon " + lon).openPopup();
                        });

                        function chooseAddr(lat1, lng1) {
                            myMarker.closePopup();
                            map.setView([lat1, lng1], 18);
                            myMarker.setLatLng([lat1, lng1]);
                            lat = lat1.toFixed(8);
                            lon = lng1.toFixed(8);
                            document.getElementById('lat').value = lat;
                            document.getElementById('lon').value = lon;
                            myMarker.bindPopup("Lat " + lat + "<br />Lon " + lon).openPopup();
                        }

                        function myFunction(arr) {
                            var out = "<br />";
                            var i;
                            if (arr.length > 0) {
                                for (i = 0; i < arr.length; i++) {
                                    out += "<div class='address' title='Show Location and Coordinates' onclick='chooseAddr(" + arr[i].lat + ", " + arr[i].lon + ");return false;'>" + arr[i].display_name + "</div>";
                                }
                                document.getElementById('results').innerHTML = out;
                            } else {
                                document.getElementById('results').innerHTML = "Sorry, no results...";
                            }
                        }

                        function addr_search() {
                            var inp = document.getElementById("addr");
                            var xmlhttp = new XMLHttpRequest();
                            var url = "https://nominatim.openstreetmap.org/search?format=json&limit=3&q=" + inp.value;
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var myArr = JSON.parse(this.responseText);
                                    myFunction(myArr);
                                }
                            };
                            xmlhttp.open("GET", url, true);
                            xmlhttp.send();
                        }

                    </script>
                    <div class="row">
                        <div class="col-5">
                            <span class="text-updatealamat"> Detail Alamat </span><br>
                            <textarea class="" rows="2" type="text" style="width:14rem" name="detailalamat"
                                id="detailalamat"></textarea>
                        </div>
                        <div class="col-6">
                            <span class="text-updatealamat"> Alamat Lengkap </span><br>
                            <textarea class="" type="text" style="width:24rem" name="alamatlengkap"
                                id="alamatlengkap"></textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <input class="" type="checkbox" name="jenisalamat" id="jenisalamat" value="Alamat Pribadi">
                            <span class="text-updatealamat"> Atur Sebagai Alamat Pribadi</span><br>
                            <input class="" type="checkbox" name="jenisalamat" id="jenisalamat" value="Alamat Toko">
                            <span class="text-updatealamat"> Atur Sebagai Alamat Pengiriman</span><br>
                            <input class="" type="checkbox" name="jenisalamat" id="jenisalamat" value="Alamat Pengembalian">
                            <span class="text-updatealamat"> Atur Sebagai Alamat Pengembalian</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" class="form-updatealamat" style="width:14rem" name="alamatseller"id="alamatseller" value="<%=Seller("sl_custID")%>">
        <input type="hidden" class="form-updatealamat" style="width:14rem" name="slname"id="slname" value="<%=Seller("slName")%>">
        <input type="hidden" class="form-updatealamat" style="width:14rem" name="slVerified"id="slVerified" value="<%=Seller("slVerified")%>">
        <input type="hidden" class="form-updatealamat" style="width:14rem" name="slAktifYN"id="slAktifYN" value="<%=Seller("slAktifYN")%>">
        <div class="modalal-footer mb-2">
            <input type="submit" class="btn-sim" id="btn-alamat" value="simpan">
        </div>
    </form>
</div>
<!--Tambah Alamat-->
</div>
<!--#include file="../../footer.asp"--> 
</body>
    <script>
        // MODAL
            var modal = document.getElementById("myModalal");
            var btn = document.getElementById("myBtnal");
            var span = document.getElementsByClassName("close")[0];
            btn.onclick = function() {
                modal.style.display = "block";
            }
            span.onclick = function() {
                modal.style.display = "none";
            }
            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        // MODAL

        // GET DAFTAR PROVINSI
            $('#provinsi').click(function(){ 
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'GetProvinsi.asp',
                    traditional: true,
                    success: function (data) {
                        var jsonData = JSON.parse(data)
                        var Prov = jsonData.provinsi
                        for(let i = 0; i < Prov.length; i++){
                            $('#provinsi').append(new Option(`${Prov[i].nama}`, `${Prov[i].nama}`));
                        }
                    }
                })
            });
        // GET DAFTAR PROVINSI

        // GET PROVINSI
            $('#provinsi').change(function(){
                var kunci = "aProp";
                let prov = $('#provinsi').val();
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'GetKodePos.asp',
                    data: {
                        kunci,
                        keterangan:prov
                    },
                    traditional: true,
                    success: function (data) {
                        var jsonDataProv = JSON.parse(data)
                        const ids = jsonDataProv.map(o => o.KotaKabupaten);
                        const newData = jsonDataProv.filter(({KotaKabupaten}, index) => !ids.includes(KotaKabupaten, index + 1));
                        for(var i=0; i<newData.length; i++){
                            $('#kab').append(new Option(`${newData[i].KotaKabupaten}`, `${newData[i].KotaKabupaten}`));
                        }
                    }
                })
            })
        // GET PROVINSI

        // GET KABUPATEN
            $('#kab').change(function(){
                var kunci = "aKab";
                let kab = $('#kab').val();
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'GetKodePos.asp',
                    data: {
                        kunci,
                        keterangan:kab
                    },
                    traditional: true,
                    success: function (data) {
                        var jsonDataKab = JSON.parse(data)
                        const ids = jsonDataKab.map(o => o.KecamatanDistrik);
                        const newData = jsonDataKab.filter(({KecamatanDistrik}, index) => !ids.includes(KecamatanDistrik, index + 1));
                        for(var i=0; i<newData.length; i++){
                            $('#kec').append(new Option(`${newData[i].KecamatanDistrik}`, `${newData[i].KecamatanDistrik}`));
                        }
                    }
                })
            })
        // GET KABUPATEN

        // GET KECAMATAN
            $('#kec').change(function(){
                let kunci = "aKec"
                let kec = $('#kec').val();
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'GetKodePos.asp',
                    data: {
                        kunci,
                        keterangan:kec
                    },
                    traditional: true,
                    success: function (data) {
                        var jsonDataKec = JSON.parse(data)
                        const ids = jsonDataKec.map(o => o.KecamatanDistrik);
                        for(i=0; i<jsonDataKec.length; i++){
                            $('#kel').append(new Option(`${jsonDataKec[i].DesaKelurahan}`, `${jsonDataKec[i].DesaKelurahan}`));
                        }
                    }
                })
            });
        // GET KECAMATAN
            
        // GET KELURAHAN
            $('#kel').change(function(){
                let kunci = "aKel"
                let kel = $('#kel').val();
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'GetKodePos.asp',
                    data: {
                        kunci,
                        keterangan:kel
                    },
                    traditional: true,
                    success: function (data) {
                        var jsonDataKel = JSON.parse(data)
                        for(i=0; i<jsonDataKel.length; i++){
                        $('#kdpos').append(new Option(`${jsonDataKel[i].KodePos}`, `${jsonDataKel[i].KodePos}`));
                    }
                    }
                })
            });
        // GET KELURAHAN

        // COMMAND
            // $('#provinsi').click(function(){     
            //     $.getJSON(`https://dev.farizdotid.com/api/daerahindonesia/provinsi`,function(data){ 
            //         for(let i = 0; i < data.provinsi.length; i++){
            //             $('#provinsi').append(new Option(`${data.provinsi[i].nama}`, `${data.provinsi[i].nama}`));
                            
            //         }
            //     });
            // });

            // $('#provinsi').change(function(){
            //     let prov = $('#provinsi').val();
            //     $.getJSON(`https://www.dakotacargo.co.id/api/api_glb_M_kodepos.asp?key=15f6a51696a8b034f9ce366a6dc22138&id=11022019000001&aProp=${prov}`,function(data){ 
            //         const ids = data.map(o => o.KotaKabupaten);
            //         const newData = data.filter(({KotaKabupaten}, index) => !ids.includes(KotaKabupaten, index + 1));
            //         for(var i=0; i<newData.length; i++){
            //             console.log(newData[i].KotaKabupaten);
            //                 $('#kab').append(new Option(`${newData[i].KotaKabupaten}`, `${newData[i].KotaKabupaten}`));
            //         }
            //     });
            // });

            // $('#kab').change(function(){
            //     let kab = $('#kab').val();
            //     $.getJSON(`https://www.dakotacargo.co.id/api/api_glb_M_kodepos.asp?key=15f6a51696a8b034f9ce366a6dc22138&id=11022019000001&aKab=${kab}`,function(data){ 
            //         const ids = data.map(o => o.KecamatanDistrik);
            //         const newData = data.filter(({KecamatanDistrik}, index) => !ids.includes(KecamatanDistrik, index + 1));
            //         for(var i=0; i<newData.length; i++){
            //             console.log(data[i].KecamatanDistrik);
            //                 $('#kec').append(new Option(`${newData[i].KecamatanDistrik}`, `${newData[i].KecamatanDistrik}`));
            //         }
            //     });
            // });

            // $('#kota').change(function(){
            //     let kota = $('#kota').val();
            //     $.getJSON(`https://www.dakotacargo.co.id/api/api_glb_M_kodepos.asp?key=15f6a51696a8b034f9ce366a6dc22138&id=11022019000001&aProp=${kota}`,function(data){
            //         for(var i=0; i<data.length; i++){
            //                 $('#kec').append(new Option(`${data[i].KecamatanDistrik}`, `${data[i].KecamatanDistrik}`));
            //         }
            //     });
            // });

            // $('#kec').change(function(){
            //     let kec = $('#kec').val();
            //     $.getJSON(`https://www.dakotacargo.co.id/api/api_glb_M_kodepos.asp?key=15f6a51696a8b034f9ce366a6dc22138&id=11022019000001&aKec=${kec}`,function(data){ 
            //         const ids = data.map(o => o.KecamatanDistrik);
            //         for(i=0; i<data.length; i++){
            //             $('#kel').append(new Option(`${data[i].DesaKelurahan}`, `${data[i].DesaKelurahan}`));
            //         }
            //     });
            // });

            // $('#kel').change(function(){
            //     let kel = $('#kel').val();
            //     $.getJSON(`https://www.dakotacargo.co.id/api/api_glb_M_kodepos.asp?key=15f6a51696a8b034f9ce366a6dc22138&id=11022019000001&aKel=${kel}`,function(data){ 
            //         // console.log(data[0].KecamatanDistrik) 
            //         for(i=0; i<data.length; i++){
            //             $('#kdpos').append(new Option(`${data[i].KodePos}`, `${data[i].KodePos}`));
            //         }
            //     });
            // });
        // COMMAND

        $('#phonepenerima').change(function(){
            let phone = $('#phonepenerima').val();
            if (phone == "" ){
                $('#phonealm').show();
                $('#idphonepenerima').hide();
            }else {
                $('#phonealm').hide();
            }
        });

            
        // Dropdown Button
            var dropdown = document.getElementsByClassName("dropdown-btn");
            var i;
            for (i = 0; i < dropdown.length; i++) {
                dropdown[i].addEventListener("click", function() {
                    this.classList.toggle("active");
                    var dropdownContent = this.nextElementSibling;
                    if (dropdownContent.style.display === "block") {
                        dropdownContent.style.display = "none";
                    }else {
                        dropdownContent.style.display = "block";
                    }
                });
            }
        // Dropdown Button

    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <% Server.execute ("../getTransaksiUpdateCust.asp") %>
</html>