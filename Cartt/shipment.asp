<!--#include file="../connections/pigoConn.asp"--> 

<%
        if request.Cookies("custEmail")="" then

        response.redirect("../")

        end if

        ' id = mid(request.form("pdID"),1,len(request.form("pdID"))-1)
        subtotal = request.form("subtotal")
        qty = request.form("qty")

        id = Split(request.form("id"),",")

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

        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="detail-cart.css">
        <script src="../js/jquery-3.6.0.min.js"></script>

        <title>Official PIGO</title>
        <style>
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
        </style>
    </head>
<body>
    <div class="header">
        <div class="container" style="margin-top:15px">
            <div class="row align-items-center">
                <div class="col-4">
                    <a class="backk" href="<%=base_url%>/Keranjang/" style="text-decoration:none" ><span> <i class="fas fa-chevron-circle-left"></i>   Official PIGO   </span><i class="fas fa-grip-lines-vertical"></i></a> <span class="text-header">   CheckOut   </span>
                </div>
            </div>
        </div>
    </div>
    <div class="container mb-2" style="margin-top:5rem">
    <form class="form-tr" action="../Transaksi/P-transaksi.asp" method="POST">
        <!-- Alamat Penerima -->
            <div class="row align-items-center alm-pengiriman">
                <div class="col-9">
                    <span class="txt-pesanan"> Alamat Pengiriman </span>
                    <div class="row align-items-center mt-2 ">
                        <div class="col-3">
                            <input  class="txt-pesanan-inp" type="hidden" name="alamatpenerima" id="alamatpenerima" value="<%=alamat("almID")%>">
                            <input  class="txt-pesanan-inp" type="hidden" name="customerid" id="customerid" value="<%=Customer("custID")%>">
                            <input  class="txt-pesanan-inp" type="hidden" name="rekidcust" id="rekidcust" value="<%=Customer("rkID")%>">
                            <input  class="txt-pesanan-inp" type="hidden" name="bankidcust" id="bankidcust" value="<%=Customer("rkBankID")%>">
                            <input  class="txt-pesanan-inp" type="hidden" name="nomorrkcust" id="nomorrkcust" value="<%=Customer("rkNomorRk")%>">
                            <input class="txt-pesanan-inp" type="Text" name="namapenerima" id="namapenerima" value="<%=alamat("almNamaPenerima")%>"><br>
                            <span class="txt-pesanan" >[<%=Customer("almPhonePenerima")%>]</span><br>
                            <span class="txt-pesanan" >[<%=Customer("almLabel")%>]</span><br>
                        </div>
                        <div class="col-7">
                            <span class="txt-pesanan" > <%=Customer("almLengkap")%></span><br>
                            <span class="txt-pesanan" > <%=Customer("almKel")%>, <%=Customer("almKec")%>,<%=Customer("almKota")%>, <%=Customer("almProvinsi")%></span><br>
                            <span class="txt-pesanan" > <%=Customer("almkdpos")%></span><br>
                        </div>
                        <div class="col-2">
                            <span class="txt-pesanan"> Ubah Alamat </span>
                        </div>
                    </div>
                </div>
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

        <div class="row">
            <div class="col-9">
                <div class="row detail mt-3 align-items-center">
                    <div class="col-6">
                        <span class="txt-detail"> Detail Pesanan </span>
                    </div>
                    <div class="col-2 text-center">
                        <span class="txt-detail"> Harga Produk </span>
                    </div>
                    <div class="col-2 text-center">
                        <span class="txt-detail"> Jumlah </span>
                    </div>
                    <div class="col-2 text-center">
                        <span class="txt-detail"> Subtotal </span>
                    </div>
                </div>
            </div>
        </div>

        <%     
            no=0
            do while not seller.eof
            no=no+1
        %>
        <input class="txt-pesanan" type="hidden" name="slid" id="slid<%=no%>" value="<%=seller("cart_slID")%>">
        <div class="row pesanan">
            <div class="col-9">
                <div class="row align-items-center">
                    <div class="col-12">
                        <span class="txt-pesanan"> <%=seller("slName")%> </span> - 

                        <input class="txt-pesanan" type="hidden" name="rekidsl" id="rekidsl" value="<%=seller("rkID")%>" style="width:17rem">
                        <input class="txt-pesanan" type="hidden" name="bankidsl" id="bankidsl" value="<%=seller("rkBankID")%>" style="width:17rem">
                        <input class="txt-pesanan" type="hidden" name="nomorrksl" id="nomorrksl" value="<%=seller("rkNomorRk")%>" style="width:17rem">
                        <input class="txt-pesanan" type="hidden" name="idseller" id="idseller" value="<%=seller("cart_slID")%>" style="width:17rem">
                        <% 
                            alamattoko_cmd.commandText = "SELECT MKT_M_Alamat.almKota, MKT_M_Alamat.almID FROM MKT_M_Seller LEFT OUTER JOIN  MKT_M_Alamat ON MKT_M_Seller.sl_almID = MKT_M_Alamat.almID RIGHT OUTER JOIN  MKT_T_Keranjang ON MKT_M_Seller.sl_custID = MKT_T_Keranjang.cart_slID where MKT_T_Keranjang.cart_slID = '"& seller("cart_slID") &"' GROUP BY  MKT_M_Alamat.almKota, MKT_M_Alamat.almID "
                            'response.write produk_cmd.commandText
                            set alamattoko = alamattoko_cmd.execute
                        %>
                        <input class="txt-pesanan" type="text" name="asalkota" id="asalkota<%=alamattoko("almID")%>" value="<%=alamattoko("almKota")%>" style="width:17rem">
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
                            produk_cmd.commandText = "SELECT MKT_M_Alamat.almKota,MKT_T_Keranjang.cart_pdID, MKT_M_Alamat.almID, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_M_Produk.pdID, MKT_M_Produk.pdBerat, MKT_M_Produk.pdVolume, MKT_M_Produk.pdHargaJual, MKT_T_Keranjang.cart_slID, MKT_T_Keranjang.cartQty, MKT_M_Produk.pd_almID FROM MKT_M_Produk LEFT OUTER JOIN  MKT_M_Alamat ON MKT_M_Produk.pd_almID = MKT_M_Alamat.almID RIGHT OUTER JOIN  MKT_T_Keranjang ON MKT_M_Produk.pdID = MKT_T_Keranjang.cart_pdID  where (MKT_T_Keranjang.cart_slID = '"& seller("cart_slID") &"')  AND (MKT_T_Keranjang.cart_custID = '"& seller("cart_custID") &"') " &  FilterFix  &" GROUP BY MKT_M_Alamat.almKota, MKT_M_Alamat.almID, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_M_Produk.pdID, MKT_M_Produk.pdBerat, MKT_M_Produk.pdVolume, MKT_M_Produk.pdHargaJual, MKT_T_Keranjang.cart_slID, MKT_T_Keranjang.cartQty, MKT_M_Produk.pd_almID,MKT_T_Keranjang.cart_pdID"
                            'response.write produk_cmd.commandText
                            set produk = produk_cmd.execute
                        %>

                        <% 
                            pd = 0
                            do while not produk.eof
                            pd = pd +1

                        %>
                        
                        <div class="row align-items-center mt-2">
                            <div class="col-1">
                                <img src="data:image/png;base64,<%=produk("pdImage1")%>" width="80" height="80" alt="data:image/png;base64,<%=produk("pdImage1")%>"/>
                            </div>
                            <div class="col-5 text-center">
                                <input class="txt-pesanan" type="text" name="pdNama" id="pdNama" value="<%=produk("pdNama")%>" style="width:17rem">
                                <input class="txt-pesanan" type="hidden" name="pdID" id="pdID" value="<%=produk("pdID")%>" style="width:17rem">
                                <input class="txt-pesanan" type="hidden" name="pdBerat" id="pdBerat<%=alamattoko("almID")%>" value="<%=produk("pdBerat")%>" style="width:17rem">
                                <input class="txt-pesanan" type="hidden" name="pdVolume" id="pdVolume<%=alamattoko("almID")%>" value="<%=produk("pdVolume")%>" style="width:17rem">
                                <input class="txt-pesanan" type="hidden" name="hitungongkir" id="hitungongkir<%=alamattoko("almID")%>" value="" style="width:17rem">
                                <input class="txt-pesanan" type="hidden" name="grams" id="grams<%=alamattoko("almID")%>" value="" style="width:17rem">
                            </div>
                            <div class="col-2 text-center ">
                                <input class="txt-pesanan input-txt" type="hidden" name="pdHargaJual" id="pdHargaJual" value="<%=produk("pdHargaJual")%>" style="width:7rem"> <br>
                            </div>
                            <div class="col-2 text-center ">
                                <input class="txt-pesanan input-txt" type="text" name="pdQty" id="pdQty" value="<%=produk("cartQty")%>" style="width:7rem"> <br>
                            </div>
                            <div class="col-2 text-center ">
                                <% total = produk("pdHargaJual")*produk("cartQty") %>
                                <input class="txt-pesanan input-txt" type="text" name="pdSubtotal" id="pdSubtotal" value="<%=total%>" style="width:7rem"> <br>
                            </div>
                            <% 
                            
                                totalseller = totalseller + total 
                                totalqty = totalqty + produk("cartQty")
                            
                            %>
                            <!--<div class="row align-items-center">
                                <div class="col-10">
                                    <input  name="asuransi" id="asuransi<%'=produk("pdID")%>" class="mt-1 align-items-center form-check-input text-span" type="checkbox" value="Y" id="flexCheckChecked" >
                                    <label class=" align-items-center form-check-label text-span" for="flexCheckChecked"> Asuransi Pengiriman</label>
                                </div>
                                <div class="col-2 text-center">
                                    <input readonly class="" type="number" name="pdSubtotal" id="pdSubtotal" value="" style="width:7rem"> <br>
                                </div>
                            </div>
                            <div class="row align-items-center">
                                <div class="col-12">
                                    <input name="packing" id="packing" class="form-check-input text-span" type="checkbox" value="Y" id="flexCheckChecked">
                                    <label class="form-check-label text-span" for="flexCheckChecked"> Proteksi Pengiriman </label>
                                </div>
                            </div>-->
                        </div>

                        <% 
                            produk.movenext
                            loop 
                            tpd = pd
                        %>
                        <input type="hidden" name="totalproduk" id="totalproduk" value="<%=tpd%>" >
                        <div class="row align-items-center mt-2">
                            <div class="col-6 me-4">
                                <div class="row align-items-center">
                                    <div class="col-2 me-4">
                                        <span class="txt-pesanan"> Catatan </span>
                                    </div>
                                    <div class="col-2">
                                        <input type="text" class="txt-pesanan form-detail" name="catatansl" id="catatansl" value="" style="width:19rem" placeholder="Tuliskan Catatan Untuk Seller">
                                    </div>
                                </div>
                            </div>
                            <div class="col-5">
                                <div class="row align-items-center">
                                    <div class="col-9 ms-3">
                                        <span class="txt-pesanan">Total</span>
                                    </div>
                                    <div class="col-2 ms-2">
                                        <input class=" text-center txt-pesanan form-inp"type="hidden" name="totalqtysl" id="totalqtysl" value="<%=totalqty%>" style="width:3.5rem">
                                        <input class=" text-center txt-pesanan form-inp"type="text" name="totalsl" id="totalsl" value="<%=totalseller%>" style="width:3.5rem">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-3 pesanan-d">
                <div class="row">
                    <div class="col-7 me-2">
                        <span class="txt-pesanan"> Voucher Seller </span>
                    </div>
                    <div class="col-3">
                        <input class="btn-detail"type="button" name="vouchersl" id="vouchersl" value="Pilih Voucher">
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <span class="txt-pesanan"> Pengiriman </span><br>
                        <select name="ongkirsl" id="ongkirsl<%=alamattoko("almID")%>" class="form-detail ongkirsl txt-pesanan" aria-label="Default select example">
                            <script>
                                let asalkotaa<%=alamattoko("almID")%> = $('#asalkota<%=alamattoko("almID")%>').val();
                                $.getJSON(`https://www.dakotacargo.co.id/api/pricelist/index.asp?ak=${asalkotaa<%=alamattoko("almID")%>}&tpr=${propinsi}&tko=${kota}&tke=${kecamatan}`,function(data){ 
                                    $.each(data, function(i, data) {
                                        $('#ongkirsl<%=alamattoko("almID")%>').append('<option class="text-span"value="'+i+'">'+i+'</option>');
                                    });
                                });
                            </script>
                            <option class="text-span"value="">Pilih Pengiriman</option>
                            <option class="text-span"value="Ambil Di Toko">Ambil Di Toko</option>
                        </select>
                    </div>
                </div>
                <script>
                    let asalkota<%=alamattoko("almID")%> = $('#asalkota<%=alamattoko("almID")%>').val();
                    
                    var array = []

                    $('#ongkirsl<%=alamattoko("almID")%>').on("change",function(){
                        // console.log(asalkota<%'=alamattoko("almID")%>);
                        let ongkir<%=alamattoko("almID")%> = $('#ongkirsl<%=alamattoko("almID")%>').val();
                        let berat<%=alamattoko("almID")%> = $('#grams<%=alamattoko("almID")%>').val();
                        // console.log(berat<%=alamattoko("almID")%>);
                        
                            $.getJSON(`https://www.dakotacargo.co.id/api/pricelist/index.asp?ak=${asalkota<%=alamattoko("almID")%>}&tpr=${propinsi}&tko=${kota}&tke=${kecamatan}`,function(data){ 
                                
                                if ( ongkir<%=alamattoko("almID")%> == "kurir" ){
                                    if(berat<%=alamattoko("almID")%> >=  data.kurir[0].minkg ){
                                        // console.log(berat<%=alamattoko("almID")%> >= data.kurir[0].minkg);
                                        var totall = Number(data.kurir[0].pokok) + Number(data.kurir[0].kgnext);
                                        $("#ongkoskirimsl<%=alamattoko("almID")%>").val(Number(totall));
                                        var  o<%=alamattoko("almID")%> = Number(totall);
                                    }else{
                                        $("#ongkoskirimsl<%=alamattoko("almID")%>").val(Number(data.kurir[0].pokok));
                                        var  o<%=alamattoko("almID")%> = Number(data.kurir[0].pokok);
                                    }
                                }else if ( ongkir<%=alamattoko("almID")%> == "reguler" ) {
                                    if(berat<%=alamattoko("almID")%> >=  data.reguler[0].minkg ){
                                        // console.log(berat<%=alamattoko("almID")%> >=  data.reguler[0].minkg);
                                        var totall = Number(data.reguler[0].pokok) + Number(data.reguler[0].kgnext);
                                        $("#ongkoskirimsl<%=alamattoko("almID")%>").val(Number(totall));
                                        var  o<%=alamattoko("almID")%> = Number(totall);
                                    }else{
                                        $("#ongkoskirimsl<%=alamattoko("almID")%>").val(Number(data.reguler[0].pokok));
                                        var  o<%=alamattoko("almID")%> = Number(data.reguler[0].pokok);
                                    }
                                }else if ( ongkir<%=alamattoko("almID")%> == "Ambil Di Toko" ) {
                                    $("#ongkoskirimsl<%=alamattoko("almID")%>").val(0);
                                    var  o<%=alamattoko("almID")%> = Number(0);
                                }else{
                                    $("#ongkoskirimsl<%=alamattoko("almID")%>").val(Number(data.regulerudara[0].pokok));
                                    var  o<%=alamattoko("almID")%> = Number(data.regulerudara[0].pokok);
                                }
                                
                                var totalongkir = 0;
                                var obj = {
                                    ongkir : o<%=alamattoko("almID")%>,
                                    id,
                                }
                                array.push(obj);
                                    array.map((key)=> {
                                        totalongkir += Number(key.ongkir)
                                    });
                                var id = parseInt(document.getElementById("ongkoskirimsl<%=alamattoko("almID")%>").value);                        
                                var kurangongkir = array.filter((key)=> key.id != id)
                                array = kurangongkir
                                document.getElementById("totalongkoskirim").value = totalongkir;

                                var grandtotal = parseInt(document.getElementById("grandtotal").value);
                                var tdiskon = parseInt(document.getElementById("totaldiskon").value);
                                var totalbayar = 0;
                                totalbayar = grandtotal+totalongkir+tdiskon;
                                document.getElementById("totalbayar").value = totalbayar;

                                });
                        
                    });
                </script>
                <div class="row mt-3">
                    <div class="col-8">
                        <span class="txt-pesanan"> Ongkos Kirim </span><br>
                    </div>
                    <div class="col-4">
                        <input class="txt-pesanan form-inp"  type="text"  name="ongkoskirimsl" id="ongkoskirimsl<%=alamattoko("almID")%>" value="">
                    </div>
                </div>
            </div>
            </div>
        <% 
            grandtotal = grandtotal + totalseller 
            totalseller = 0
            grandtotalqty = grandtotalqty + totalqty
            totalqty = 0
        %>
        <% 
            seller.movenext
            loop
            nomor = no 
        %>
        <input type="hidden" name="grandtotalsl" id="grandtotalsl" value="<%=totalseller%>" >
        <input type="hidden" name="grandtotalpd" id="grandtotalpd" value="<%=grandtotalqty%>" >
        <input type="hidden" name="no" id="no" value="<%=nomor%>" >
        <div class="row pesanan" style="margin-bottom:3rem">
            <div class="col-12">
                <div class="row  align-items-center">
                    <div class="col-9 ">
                        <div class="row">
                            <div class="col-10">
                                <span class="txt-pesanan dsc"> Sub Total Pesanan </span><br>
                                <span class="txt-pesanan dsc"> Total QTY </span><br>
                                <span class="txt-pesanan dsc"> Biaya Kirim </span><br>
                                <span class="txt-pesanan dsc"> Voucher Diskon </span><br>
                                <span class="txt-pesanan dsc"> Asuransi Pengiriman </span><br>
                                <span class="txt-pesanan dsc"> Biaya Layanan </span><br>
                                <span onclick="return totalbayar()" class="txt-pesanan dsc"> Total Pembayaran</span><br>
                            </div>
                            <div class="col-2">
                            <input class="form-inp input-txt" type="text" name="grandtotal" id="grandtotal" value="<%=grandtotal%>">
                            <input class="form-inp input-txt" type="text" name="grandtotalqty" id="grandtotalqty" value="<%=grandtotalqty%>">
                            <input class="form-inp input-txt" onblur="return hitungongkir()" type="text" name="totalongkoskirim" id="totalongkoskirim" value="0">
                            <input class="form-inp input-txt" type="text" name="totaldiskon" id="totaldiskon" value="0">
                            <input class="form-inp input-txt" type="text" name="biayaasuransi" id="biayaasuransi" value="0">
                            <input class="form-inp input-txt" type="text" name="biayalayanan" id="biayalayanan" value="0">
                            <input class="form-inp input-txt" type="text" name="totalbayar" id="totalbayar" value="0">
                            </div>
                        </div>
                    </div>
                    <div class="col-3 pesanan ">
                        <div class="row text-center">
                            <div class="col-12">
                                <span class="txt-pesanan text-center"> Metode Pembayaran </span>
                            </div>
                        </div>
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
                        <div class="row align-items-center text-center mt-2">
                            <div class="col-12">
                                <input class="btn-pembayaran" type="submit" name="pembayaran" id="pembayaran" value="Buat Pesanan">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    </div>

    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>   
</body>
</html>
