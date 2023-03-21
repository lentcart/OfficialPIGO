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

	Customer_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel,  MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong,  MKT_M_Rekening.rkID, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk,MKT_M_Alamat.almID, MKT_T_Keranjang.cart_custID FROM MKT_M_Rekening RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Rekening.rk_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_Keranjang ON MKT_M_Customer.custID = MKT_T_Keranjang.cart_custID WHERE MKT_T_Keranjang.cart_custID = '"& request.Cookies("custID")&"' GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong,  MKT_M_Rekening.rkID, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk,MKT_M_Alamat.almID, MKT_T_Keranjang.cart_custID "
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

	Seller_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_T_Keranjang.cart_slID, MKT_T_Keranjang.cart_custID, MKT_M_Seller.sl_custID, MKT_M_Rekening.rkID, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk FROM MKT_M_Seller LEFT OUTER JOIN MKT_M_Rekening ON MKT_M_Seller.sl_custID = MKT_M_Rekening.rk_custID RIGHT OUTER JOIN MKT_T_Keranjang ON MKT_M_Seller.sl_custID = MKT_T_Keranjang.cart_slID WHERE (MKT_T_Keranjang.cart_custID = '"&request.cookies("custID")&"') "& FilterFix &"  AND MKT_M_Rekening.rkJenis = 'Rekening Seller' GROUP BY MKT_M_Seller.slName, MKT_T_Keranjang.cart_slID, MKT_T_Keranjang.cart_custID, MKT_M_Seller.sl_custID, MKT_M_Rekening.rkID, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk " 
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

        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="detail-cart.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script>

        function listongkir(id){
            let propinsi = $('#prov').val();
            let kota = $('#kota').val();
            let kecamatan = $('#kec').val();
            let kelurahan = $('#kel').val();

            let asalkotaa = $('#asalkota'+id).val();
            console.log(asalkotaa);
            $.getJSON(`https://www.dakotacargo.co.id/api/pricelist/index.asp?ak=${asalkotaa}&tpr=${propinsi}&tko=${kota}&tke=${kecamatan}`,function(data){ 
                $.each(data, function(i, data) {
                    $("#list-ongkir"+id).append(`
                            <div class="cont-list-ongkir">
                                <table class="table">
                                    <tr>
                                        <th colspan="2" class="card-pesanan-text">`+i+`</th>
                                    </tr>
                                    <tr>
                                        <td> 
                                            <input class="form-check-input " onchange=test('${i}','','${data[0].pokok}','${i}','${id}') type="radio" name="cekongkir" value="`+data[0].pokok+`" id="cktest">
                                        </td>
                                        <td>
                                            <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; `+i+`  </span><br>
                                            <span class="card-pesanan-desc"> Rp. `+data[0].pokok+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        `);
                });
            });

            var opsipengiriman = document.getElementById("cont-list-ongkir"+ id);
            if(opsipengiriman.style.display == "none"){
                opsipengiriman.style.display = "block"
            }else{
                opsipengiriman.style.display = "none"
            }
            var Ongkir  = Number(document.getElementById("totalongkoskirim").value);
            var Bayar = Number(document.getElementById("totalbayar").value);
            var berat   = document.getElementById("pdBerat"+id).value;
            console.log(berat);
                
            $.getJSON(`http://103.111.190.162/dbs/customerapps/dimensi/`,function(data){ 
                var a = data.detail;
                var b = ""
                for(i=0; i<a.length; i++){
                    if( berat >= 5){
                        xx = a[i].id
                    console.log(xx);
                    }
                    b += `
                            <div class="cont-list-ongkir">
                                <table class="table">
                                    <tr>
                                        <th colspan="2" class="card-pesanan-text"> Ukuran Pengiriman (`+a[i].nama+`)</th>
                                    </tr>
                                    <tr>
                                        <td> 
                                            <input class="form-check-input " onchange=test('${a[i].id}','${a[i].nama}','${a[i].Instant_Tarif}','Instant','${id}') type="radio" name="cekongkir" value="`+a[i].id+`" id="cktest">
                                        </td>
                                        <td>
                                            <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Instant  </span><br>
                                            <span class="card-pesanan-desc"> Rp. `+a[i].Instant_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> 
                                            <input class="form-check-input " onchange=test('${a[i].id}','${a[i].nama}','${a[i].SameDay_Tarif}','SameDay','${id}') type="radio" name="cekongkir" value="`+a[i].id+`" id="cktest">
                                        </td>
                                        <td>
                                            <span class="card-ongkir-text"> <i class="fas fa-truck-moving"></i>&nbsp; Same Day  </span><br>
                                            <span class="card-pesanan-desc"> Rp. `+a[i].SameDay_Tarif+` </span><br><span class="card-pesanan-desc"> <i class="fas fa-info-circle"></i> &nbsp; Biaya sudah termasuk asuransi pengiriman </span><br> 
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        `
                    document.getElementById("list-ongkir"+id).innerHTML = b ;
                var d = $("#ongkoskirim"+id).remove().append(b);
                }
            });
            TotalBayar = Number(Bayar-Ongkir);
            // document.getElementById("totalongkoskirim").value = 0 ;
            console.log(TotalBayar);
            document.getElementById("totalbayar").value = TotalBayar;
        }

        function test(x,b,c,d,sl) {
            console.log(c);
            var Ongkir = Number(document.getElementById("totalongkoskirim").value);
            var Bayar = Number(document.getElementById("totalbayar").value);
            console.log(Ongkir);
            var IdOngkir 
            var NamaOngkir
            var HargaOngkir
            let propinsi = $('#prov').val();
            let kota = $('#kota').val();
            let kecamatan = $('#kec').val();
            let kelurahan = $('#kel').val();

            let asalkotaa = $('#asalkota'+sl).val();
            console.log(asalkotaa);
            $.getJSON(`https://www.dakotacargo.co.id/api/pricelist/index.asp?ak=${asalkotaa}&tpr=${propinsi}&tko=${kota}&tke=${kecamatan}`,function(data){ 
                $.each(data, function(i, data) {
                    if( i == x  ){
                    $('#ongkosnyanih'+sl).append(`
                        <div id="ongkoskirim${sl}">
                            <div class="row align-items-center mb-3 mt-2" >
                                <div class="col-8" id="card-ongkir'${sl}'">
                                    <span class="card-pesanan-text"> <i class="fas fa-truck-moving"></i>  &nbsp; `+i+` </span><br>
                                    <span class="card-pesanan-desc"> `+i+` -  Rp. `+data[0].pokok+` </span>
                                    <input type="hidden" name="pengiriman-sl" id="pengiriman-sl${sl}" value="`+i+`">
                                    <input type="hidden" name="ongkir-seller" id="ongkir-seller${sl}" value="`+data[0].pokok+`">
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
                });
            });
            $.getJSON(`http://103.111.190.162/dbs/customerapps/dimensi/`,function(data){ 
                var a = data.detail;
                    var n  = ""
                for(i=0; i<a.length; i++){
                    if( a[i].id == x  ){
                        IdOngkir = a[i].id;
                        NamaOngkir = a[i].nama;
                        HargaOngkir = c;
                        $('#ongkosnyanih'+sl).append(`
                        <div id="ongkoskirim${sl}">
                            <div class="row align-items-center mb-3 mt-2" >
                                <div class="col-8" id="card-ongkir'${sl}'">
                                    <span class="card-pesanan-text"> <i class="fas fa-truck-moving"></i>  &nbsp; Ukuran Pengiriman (`+NamaOngkir+`) </span><br>
                                    <span class="card-pesanan-desc"> `+d+` -  Rp. `+HargaOngkir+` </span>
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
            });
            if ( Ongkir == 0 ){
                var ongkirseller = Number(c);
                var TotalOngkir  = Number(ongkirseller);
                var TotalBayar   = Number(Bayar+ongkirseller);
                document.getElementById("totalongkoskirim").value = TotalOngkir;
                document.getElementById("totalbayar").value = TotalBayar;
            }else{
                var ongkirseller = Number(c);
                var TotalOngkir  = Number(Ongkir+ongkirseller);
                var TotalBayar   = Number(Bayar+TotalOngkir);
                document.getElementById("totalongkoskirim").value = TotalOngkir;
                document.getElementById("totalbayar").value = TotalBayar;
            }

            var opsipengiriman = document.getElementById("cont-list-ongkir"+ sl);
            if(opsipengiriman.style.display == "block"){
                opsipengiriman.style.display = "none"
            }else{
                opsipengiriman.style.display = "block"
            }
        }
        </script>
        <title> OFFICIAL PIGO </title>
        <style>
            .list-ongkir{
                overflow-x:hidden;
                overflow-y:scroll;
                height:10rem;
                background-color:white;
                display:none;
                box-shadow: 0 4px 8px 0 rgba(196, 196, 196, 0.2), 0 6px 20px 0 rgba(218, 218, 218, 0.19);
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
                font-size:12px;
                font-family: "Poppins", sans-serif;
                font-weight:550;
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
    <form action="../Transaksi/new.asp" method="POST">
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
                            <script>
                                let propinsi = $('#prov').val();
                                let kota = $('#kota').val();
                                let kecamatan = $('#kec').val();
                                let kelurahan = $('#kel').val();
                            </script>
                        <!-- Alamat Penerima -->
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
                                </div>
                                <input class="txt-pesanan" type="hidden" name="SRekeningID" id="SRekeningID" value="<%=seller("rkID")%>">
                                <input class="txt-pesanan" type="hidden" name="SBankID" id="SBankID" value="<%=seller("rkBankID")%>">
                                <input class="txt-pesanan" type="hidden" name="SNomorRekening" id="SNomorRekening" value="<%=seller("rkNomorRk")%>">
                                <input class="txt-pesanan" type="hidden" name="SellerID" id="SellerID" value="<%=seller("cart_slID")%>">
                                <% 
                                    alamattoko_cmd.commandText = "SELECT MKT_M_Alamat.almKota, MKT_M_Alamat.almID FROM MKT_M_Seller LEFT OUTER JOIN  MKT_M_Alamat ON MKT_M_Seller.sl_almID = MKT_M_Alamat.almID RIGHT OUTER JOIN  MKT_T_Keranjang ON MKT_M_Seller.sl_custID = MKT_T_Keranjang.cart_slID where MKT_T_Keranjang.cart_slID = '"& seller("cart_slID") &"' GROUP BY  MKT_M_Alamat.almKota, MKT_M_Alamat.almID "
                                    'response.write produk_cmd.commandText
                                    set alamattoko = alamattoko_cmd.execute
                                %>
                                <input class="txt-pesanan" type="hidden" name="asalkota" id="asalkota<%=seller("cart_slID")%>" value="<%=alamattoko("almKota")%>" style="width:17rem">
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
                                produk_cmd.commandText = "SELECT MKT_M_Produk.pdID,MKT_M_Alamat.almKota,MKT_T_Keranjang.cart_pdID, MKT_M_Alamat.almID, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama,MKT_M_Produk.pdHargaJual,  MKT_T_Keranjang.cartQty, MKT_M_Produk.pdBerat, MKT_M_Produk.pdPanjang,MKT_M_Produk.pdLebar, MKT_M_Produk.pdVolume, MKT_M_Produk.pdTinggi, MKT_T_Keranjang.cart_slID,  MKT_M_Produk.pd_almID FROM MKT_M_Produk LEFT OUTER JOIN  MKT_M_Alamat ON MKT_M_Produk.pd_almID = MKT_M_Alamat.almID RIGHT OUTER JOIN  MKT_T_Keranjang ON MKT_M_Produk.pdID = MKT_T_Keranjang.cart_pdID  where (MKT_T_Keranjang.cart_slID = '"& seller("cart_slID") &"')  AND (MKT_T_Keranjang.cart_custID = '"& seller("cart_custID") &"') " &  FilterFix  &" GROUP BY MKT_M_Alamat.almKota, MKT_M_Alamat.almID, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_M_Produk.pdID, MKT_M_Produk.pdBerat, MKT_M_Produk.pdVolume, MKT_M_Produk.pdHargaJual, MKT_T_Keranjang.cart_slID, MKT_T_Keranjang.cartQty,MKT_M_Produk.pdTinggi,MKT_M_Produk.pdPanjang,MKT_M_Produk.pdLebar,  MKT_M_Produk.pd_almID,MKT_T_Keranjang.cart_pdID"
                                'response.write produk_cmd.commandText
                                set produk = produk_cmd.execute
                            %>
                            <% 
                                pd = 0
                                do while not produk.eof
                                pd = pd +1
                            %>
                                <div class="row align-items-center mb-3 mt-2">
                                    <div class="col-2">
                                        <img src="data:image/png;base64,<%=produk("pdImage1")%>" width="80" height="80" alt="data:image/png;base64,<%=produk("pdImage1")%>"/>
                                    </div>
                                    <div class="col-9">
                                        <span class="card-pesanan-text"> <%=produk("pdNama")%> </span><br>
                                        <i class="fas fa-tags" style="font-size:11px; color:#7e0909"></i> &nbsp;<span class="card-pesanan-harga"> <%=Replace(Replace(FormatCurrency(produk("pdHargaJual")),"$","Rp. "),".00","")%> </span><br>

                                        <i class="fas fa-box-open" style="font-size:11px; color:#7e0909"></i> &nbsp;<span class="card-pesanan-desc"> <%=produk("cartQty")%></span> <span class="card-pesanan-desc"> (<%=produk("pdBerat")%> kg) </span>

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

                                    <!--Proteksi Produk-->
                                    <div class="row mt-1">
                                        <div class="col-12">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1">
                                                <label class="card-pesanan-desc form-check-label" for="inlineCheckbox1" style="color:black">Proteksi Kerusakan Total</label><br>
                                                <span class="card-pesanan-desc"> Lindungi produk anda dari kerusakan ataupun kejadian tidak terduga </span><br>
                                                <span class="card-pesanan-desc"> Rp. 10.000 </span>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Proteksi Produk-->
                                </div>
                            <%
                                TotalPesanan = TotalPesanan + Total
                                TotalQty     = TotalQty + produk("cartQty")
                            %>
                            <% 
                                produk.movenext
                                loop 
                                tpd = pd
                            %>
                            <input type="hidden" name="totalproduk" id="totalproduk" value="<%=tpd%>" >
                            <!--Catatan Seller-->
                                <div class="row mb-2 align-items-center">
                                    <div class="col-2">
                                        <span class="card-pesanan-desc"> Catatan </span>
                                    </div>
                                    <div class="col-10">
                                        <input type="text" class="card-pesanan-desc form-detail" name="catatan-sl" id="catatan-sl" value=""  placeholder="Tuliskan Catatan Untuk Seller">
                                    </div>
                                </div>
                            <!--Catatan Seller-->
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
                                let asalkotaa<%=alamattoko("almID")%> = $('#asalkota<%=alamattoko("almID")%>').val();
                                $.getJSON(`https://www.dakotacargo.co.id/api/pricelist/index.asp?ak=${asalkotaa<%=alamattoko("almID")%>}&tpr=${propinsi}&tko=${kota}&tke=${kecamatan}`,function(data){ 
                                    $.each(data, function(i, data) {
                                        $('#list-ongkir<%=seller("cart_slID")%>').append('<option class="text-span"value="'+i+'">'+i+'</option>');
                                    });
                                });
                            </script>
                            <div class="list-ongkir" id="cont-list-ongkir<%=seller("cart_slID")%>" style="display:none">
                                <div id="list-ongkir<%=seller("cart_slID")%>">

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
                            </div>
                            <div class="col-4 text-end">
                            <input class="form-inp input-txt" type="text" name="grandtotal" id="grandtotal" value="<%=GrandTotalPesanan%>">
                            <input class="form-inp input-txt" type="text" name="GrandTotalQty" id="GrandTotalQty" value="<%=GrandTotalQty%>">
                            <input class="form-inp input-txt" onblur="return hitungongkir()" type="text" name="totalongkoskirim" id="totalongkoskirim" value="0">
                            <input class="form-inp input-txt" type="text" name="totaldiskon" id="totaldiskon" value="0">
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
            var TotalPembayaran     = TotalPesanan+TotalOngkir+TotalDiskon;
            document.getElementById("totalbayar").value = TotalPembayaran
        });
        function getInvoice(){
                var external_id = "ORDERID-00098900";
                var amount      = 9000;
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'P-Invoice.asp',
                        data:{
                                external_id:external_id,
                                amount: amount,
                            },
                        traditional: true,
                        success: function (data) {
                            const obj = JSON.parse(data);
                            var c
                            c =
                            obj.invoice_url
                            window.location.href = c
                        }
                    });
            }
    </script>
</html>