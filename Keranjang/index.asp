<!--#include file="../connections/pigoConn.asp"--> 
<%
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    id = request.queryString("pdID")

    dim pdID
    set pdID_cmd = server.createObject("ADODB.COMMAND")
	pdID_cmd.activeConnection = MM_PIGO_String

	pdID_cmd.commandText = "SELECT dbo.MKT_T_Keranjang.cartQty, dbo.MKT_M_Produk.pdID, dbo.MKT_M_Produk.pdNama,dbo.MKT_M_Produk.pdSku, dbo.MKT_M_Produk.pd_custID, dbo.MKT_M_Produk.pdType, dbo.MKT_M_Produk.pdStok, dbo.MKT_M_Produk.pdHargaJual, dbo.MKT_M_Produk.pdImage1 FROM dbo.MKT_T_Keranjang LEFT OUTER JOIN dbo.MKT_M_Produk ON dbo.MKT_T_Keranjang.cart_pdID = dbo.MKT_M_Produk.pdID where MKT_T_Keranjang.cart_custID = '"& request.cookies("custID") &"'  order by convert(datetime,cartUpdateTime) desc"
    'response.write pdID_cmd.commandText
    set pdID = pdID_cmd.execute

    set StokAkhir_cmd = server.createObject("ADODB.COMMAND")
	StokAkhir_cmd.activeConnection = MM_PIGO_String


%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
        <link rel="stylesheet" type="text/css" href="keranjang.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>

        <title> OFFICIAL PIGO </title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

        <script>

            var id = [];
            var harga = [];
            var qty = [];
            var tck = [];
            var arry = [];
            
            function loaddata(){
                var no = document.getElementById('no').value;
                var jml = document.getElementById('no').value;
                for ( i=1; i<=no; i++){
                    id.push($(`#cart${i}`).val());
                    harga.push($(`#cartharga${i}`).val()); 
                    qty.push($(`#cartqty${i}`).val()); 
                }
                // console.log(id,harga,qty);
                return harga,id;
            }
            var array= [];

            function checkAll() {
                var pdid = id;
                var pdharga = harga;
                var pdqty = qty;
                var qtyy = 0;
                var hargaa = 0;
                var subtotal = 0;
                var pdidall = "";

                for(i=0; i<pdid.length; i++){
                    var total = pdharga[i]*pdqty[i];
                    qtyy = parseInt(qtyy)+parseInt(pdqty[i]);
                    hargaa = parseInt(hargaa)+parseInt(pdharga[i]);
                    subtotal = subtotal+total;
                }
                    if ( pdidall.length<1 ){
                        pdidall = pdidall+id;
                    }else{
                            pdidall  = pdidall+","+id; 
                        }

                if($("#checkall").is(':checked')){
                    $(".form-check-input").prop('checked', true);
                    document.getElementById("idproduk").value = pdidall;
                    document.getElementById("total").value = subtotal;
                    document.getElementById("tbarang").value = qtyy;
                }else{
                    $(".form-check-input").prop('checked', false);
                        document.getElementById("idproduk").value = 0;
                    document.getElementById("total").value = 0;
                    document.getElementById("tbarang").value = 0;
                }
                }

            function checkbarang(id,harga,qty){
                var obj = {
                    id:id,
                    harga:harga,
                    qty:qty,
                    total:Number(harga*qty),
                }
                arry.push(obj);
            }
            $("form").submit(function(){
                $.ajax({
                    type: "post",
                    url: "detail-cart.asp",
                    data: { id : id },
                    success: function (data) {
                        console.log(data);
                        
                    }
                });
            });
        </script>
        <style>
            .del { 
                text-decoration: line-through;
                color:#aaa;
                font-size:12px
            }
            .sale{
                background-color:red;
                width:2.3rem;
                height:1.2rem;
                padding-top:8px;
                padding-bottom:8px;
                color:white;
                border-radius:5px;
                font-size:12px;
            }
            .inp-cart{
                width:100%;
                border:1px solid grey;
                border-radius:10px;
                padding:5px 10px;
            }
            .cart-btn{
                border:none;
                font-size:13px;
                padding:5px 10px;
                font-weight:bold;
                border-radius:10px;
            }
            .modal-cart {
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

            /* Modal Content */
            .modal-content-cart {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            margin-top: 2rem;
            border-radius:10px;
            padding: 0;
            border: 1px solid #888;
            width: 40%;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
            -webkit-animation-name: animatetop;
            -webkit-animation-duration: 0.4s;
            animation-name: animatetop;
            animation-duration: 0.4s
            }

            /* Add Animation */
            @-webkit-keyframes animatetop {
            from {top:-300px; opacity:0} 
            to {top:0; opacity:1}
            }

            @keyframes animatetop {
            from {top:-300px; opacity:0}
            to {top:0; opacity:1}
            }

            /* The Close Button */
            .close-cart {
            color: black;
            float: right;
            font-size: 28px;
            font-weight: bold;
            }


            .modal-header-cart {
            padding: 10px 20px 2px 16px;
            border-radius:10px;
            font-size:15px;
            font-weight:bold;
            background-color: white;
            color: black;
            }

            .modal-body-cart {padding: 2px 16px;}

            .modal-footer-cart {
            padding: 10px 20px 2px 16px;
            border-radius:10px;
            font-size:15px;
            font-weight:bold;
            background-color: white;
            color: black;
            }
        </style>

    </head>
    <body onload="loaddata()">
        <!-- Header -->
            <!--#include file="../header.asp"-->
        <!-- Header -->
        <div class="container" style="margin-top:8rem;">
            <%if pdID.eof = true then %>
                <div class="row text-center mt-4 mb-4">
                    <div class="col-12">
                    <img src="<%=base_url%>/assets/logo/maskotnew.png" alt="" width="150" height="150"><br>
                        <span class="txt-judul-cart"><b> Keranjangmu Masih Kosong </b></span><br>
                        <span class="txt-judul-cart"><b> Silahkan Pilih Produk Favoritmu</b></span><br>
                        <a href="../" role="button" class="btn btn-cart">Mulai Belanja</a>
                    </div>
                </div>
            <%else%>
            <form class="formck" action="shipment.asp" method="POST">
                <div class="row">
                    <div class="col-8">
                        <div class="pd-cart ">
                            <input class="form-check-input me-4" type="checkbox" onchange="checkAll(this,<%=pdID("pdID")%>,<%=pdID("pdHargaJual")%>,<%=pdID("cartQty")%>)"  value="<%=pdID("pdID")%>" name="checkall" id="checkall">
                            <label class="txt-judul-cart" for="checkall"> Pilih Semua Produk</label>
                        </div>

                        <% 
                            no=0
                            do while not pdID.eof
                            no=no+1
                        %> 

                        <script>
                            function tambahqty<%=pdID("pdID")%>(ck,e,pdid) {
                                let pdID = document.getElementById("produkid<%=pdID("pdID")%>").value;
                                let Input = Number(document.getElementById("tes<%=pdID("pdID")%>").value);
                                let total = Number(document.getElementById("total").value);
                                let MaxQTY = Number(document.getElementById("tes<%=pdID("pdID")%>").max);
                                console.log(Input);
                                console.log(MaxQTY);
                                var SumQTY = Input;
                                    if ( Input >= MaxQTY ){
                                        document.getElementById("tes<%=pdID("pdID")%>").value = Input;
                                        Swal.fire({
                                            icon: 'info',
                                            title: 'Stok Produk Ini Hanya Tersedia' + MaxQTY ,
                                            showConfirmButton: false,
                                            timer: 1500
                                        })
                                    }else{
                                        SumQTY = Input++ +1;
                                        $.ajax({
                                            type: "GET",
                                            url: "update-qty.asp",
                                            data: {
                                                Input,
                                                pdID
                                            },
                                            success: function (data) {
                                            }
                                        });
                                    }
                                    $(".ck-produk<%=pdID("pdID")%>").prop('checked', true);
                                    document.getElementById("tes<%=pdID("pdID")%>").value = SumQTY;
                                    if (SumQTY==1){
                                        total.value = ck;
                                    }else{
                                        let subtotal = ck*SumQTY;
                                        total.value = subtotal;
                                        document.getElementById("total").value = subtotal;
                                        document.getElementById("tbarang").value = SumQTY;
                                    }
                                }
                                    
                            function kurangqty<%=pdID("pdID")%>(ck,e,pdid) {
                                let Inputt = Number(document.getElementById("tes<%=pdID("pdID")%>").value);
                                let total  = Number(document.getElementById("total").value);
                                let MinQTY = Number(document.getElementById("tes<%=pdID("pdID")%>").min);
                                var SumQTY = Inputt;

                                if ( Inputt == MinQTY ){
                                    SumQTY = Inputt;
                                }else{
                                    SumQTY = Inputt - 1;
                                }
                                document.getElementById("tes<%=pdID("pdID")%>").value = SumQTY;

                                if (SumQTY==1){
                                    total.value = ck;
                                }else{
                                    let subtotal = ck*SumQTY;
                                    total.value = subtotal;
                                    document.getElementById("total").value = subtotal;
                                    document.getElementById("tbarang").value = SumQTY;
                                }
                                $.ajax({
                                    type: "GET",
                                    url: "update-qty.asp",
                                    data: { Input : SumQTY ,  pdID : pdid},
                                    success: function (data) {
                                        console.log(data);
                                    }
                                });
                                $(".ck-produk<%=pdID("pdID")%>").prop('checked', true);
                            }

                            var array = [];
                            function checkbarang<%=pdID("pdID")%>(ck,e,d,f){
                                var total = 0;
                                var tqty = 0;
                                var id = ck.value+",";
                                if (ck.checked){
                                    var jml = d*e+"";
                                    var obj = {
                                        qty:e,
                                        harga:d,
                                        id,
                                        total:Number(e*d),
                                        tqty:Number(e)
                                    }
                                    array.push(obj);
                                        array.map((key)=> {
                                        idp = (key.id)
                                        total += Number(key.total)
                                        tqty += Number(key.tqty)
                                    });
                                    document.getElementById("total").value = total;
                                    document.getElementById("idproduk").value = document.getElementById("idproduk").value + id;
                                    document.getElementById("jumlah").value = document.getElementById("jumlah").value +jml;
                                    document.getElementById("tbarang").value= tqty;
                                }else{
                                    var uncek = array.filter((key)=> key.id != id)
                                    array = uncek
                                        array.map((key)=> {
                                            idp = (key.id)
                                        total += Number(key.total)
                                        tqty += Number(key.tqty)
                                    });
                                    $("#checkall").prop('checked', false);
                                    produkid = document.getElementById("idproduk").value;
                                document.getElementById("total").value = total;
                                document.getElementById("idproduk").value = id;
                                document.getElementById("jumlah").value = document.getElementById("jumlah").value +jml;
                                document.getElementById("tbarang").value= tqty;
                                }
                                
                            }
                        </script>
                        <input type="hidden" name="cart" id="cart<%=no%>" value="<%=pdID("pdID")%>" >
                        <input type="hidden" name="cartharga" id="cartharga<%=no%>" value="<%=pdID("pdHargaJual")%>" >
                        <input type="hidden" name="cartqty" id="cartqty<%=no%>" value="<%=pdID("cartQty")%>" >
                        <input type="hidden" name="pdcust" id="pdcust<%=no%>" value="<%=pdID("pd_custID")%>" >

                        <div class="pd-seller mt-2" id="produk">
                            <div class="row align-items-center">
                                <div class="col-1">
                                    <input class="form-check-input ck-produk<%=pdID("pdID")%>" type="checkbox" onclick="ck()" onchange="checkbarang<%=pdID("pdID")%>(this,<%=pdID("cartQty")%>,<%=pdID("pdHargaJual")%>)" value="<%=pdID("pdID")%>" name="checkbox-barang" id="<%=pdID("pdID")%>">
                                    <!--
                                    <input class="form-check-input" type="checkbox" onclick="return checkbarang('<%'=pdid("pdId")%>','<%'=pdid("pdHargaJual")%>','<%'=pdid("cartQty")%>')" name="checkbox-barang" id="checkbox-barang<%'=no%>" value="<%'=pdid("pdId")%>,<%'=pdid("pdHargaJual")%>,<%'=pdid("cartQty")%>">
                                    -->
                                </div>
                                <div class="col-2">
                                    <img src="data:image/png;base64,<%=pdID("pdImage1")%>" class="img-produk-cart" alt=""/>
                                </div>
                                <div class="col-6">
                                    <span class="txt-produk-name"><%=pdID("pdNama")%></span>
                                    <input type="hidden" name="produkid" id="produkid<%=pdID("pdID")%>" value="<%=pdID("pdID")%>"><br>
                                    <input class="txt-hg-cart" type="hidden" name="harga" id="harga" value="<%=pdId("pdhargaJual")%>" >
                                    <%
                                        If pdID("pdType") = "" then
                                    %>
                                    <span class="txt-desc-cart"><%=pdID("pdSku")%></span><br>
                                    <% else %>
                                    <span class="txt-desc-cart"><%=pdID("pdType")%></span><br>
                                    <% end if %>
                                    <input class="txt-produk-harga" type="text" name="" id="" value="<%=Replace(Replace(FormatCurrency(pdId("pdhargaJual")),"$","Rp. "),".00","")%>" readonly>
                                    <div class="row">
                                        <div class="col-3 ">
                                            <input class="del txt-produk-harga" type="text" name="" id="" value="<%=Replace(Replace(FormatCurrency(125000),"$","Rp. "),".00","")%>">
                                        </div>
                                        <div class="col-3">
                                            <input class="sale txt-produk-harga" type="text" name="" id="" value="50 %">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <button name="minus" id="minus<%=pdID("pdID")%>" type="button" class=" btn-qty btn-dark btn-sm minus" onclick="return kurangqty<%=pdID("pdID")%>('<%=pdID("pdHargaJual")%>','<%=pdID("cartQty")%>','<%=pdID("pdID")%>')"><i class="fas fa-minus"></i></button>

                                    <input class="inp-qty" type="text" name="tes" id="tes<%=pdID("pdID")%>" value="<%=pdID("cartQty")%>" min="1" max="<%=pdID("pdStok")%>">

                                    <button name="plus" id="plus<%=pdID("pdID")%>" type="button" class=" btn-qty btn-dark btn-sm plus" onclick="return tambahqty<%=pdID("pdID")%>('<%=pdID("pdHargaJual")%>','<%=pdID("cartQty")%>','<%=pdID("pdID")%>')"><i class="fas fa-plus"></i></button>
                                </div>
                                <div class="col-1">
                                    <a href="P-deleteproduk.asp?pdid=<%=pdID("pdID")%>" class="img-delete-produk"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                        </div>
                        <% 
                            pdID.movenext
                            loop  
                            nomor = no 
                        %> 
                        <input type="hidden" name="no" id="no" value="<%=nomor%>" >
                    </div>
                    
                    <div class="col-4 align-items-center" >
                        <div class="pd-seller align-items-center mt-2" >
                            <div class="row text-center ">
                                <div class="col-12">
                                    <button  id="myBtn-cart" class="txt-inp-submit" style="border:none"> Pakai Voucher / Kode Promo </button>
                                </div>
                            </div>
                        </div>
                        <div class="align-items-center mt-4" style="display:none">
                            <input type="number" name="jumlah" id="jumlah" value="" >
                        </div>
                        <div class="pd-seller align-items-center mt-3" >
                            <div class="row text-center mb-2">
                                <div class="col-12">
                                    <span class="txt-judul-cart" style="color:#0077a2">Detail Pesanan</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-5 ">
                                    <span class="txt-desc-cart"> Total Produk </span><br>
                                    <span class="txt-desc-cart"> Total Harga </span><br>
                                    <span class="txt-desc-cart"> Total Diskon </span>
                                </div>
                                <div class="col-1 me-2">
                                    <span class="txt-desc-cart"> </span><br>
                                    <span class="txt-desc-cart">Rp. </span><br>
                                    <span class="txt-desc-cart">Rp. </span>
                                </div>
                                <div class="col-4">
                                    <input  class="text-end txt-desc-cart inp-total"readonly type="number" name="tbarang" id="tbarang" value="0" onblur="tbarang()"><br>
                                    <input  class="text-end txt-desc-cart inp-total"readonly type="number" name="total" id="total" value="0"><br>
                                    <input  class="text-end txt-desc-cart inp-total"readonly type="number" name="diskon" id="diskon" value="0">
                                </div>
                            </div>
                            <input type="hidden" name="idproduk" id="idproduk" value="">
                            <input type="hidden" name="idpdcust" id="idpdcust" value="">
                        </div>
                        <div class="pd-seller align-items-center mt-2" >
                            <div class="row text-center ">
                                <div class="col-12">
                                    <input class="text-center txt-inp-submit" type="submit" value="Checkout">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <%end if%>
            <!-- The Modal -->
                <div id="myModal-cart" class="modal-cart">

                <!-- Modal content -->
                <div class="modal-content-cart">
                    <div class="modal-header-cart">
                        <span class="close-cart">&times;</span>
                        <span>Voucher / Kode Promo</span>
                    </div>
                        <div class="row mt-3 align-items-center">
                            <div class="col-10">
                                <input type="text" class="inp-cart"  value="" placeholder="Masukan Kode Promo">
                            </div>
                            <div class="col-2">
                                <button class="cart-btn"> Terapkan </button>
                            </div>
                        </div>
                    <hr>
                    <div class="modal-body-cart">
                    </div>
                </div>
            <!-- The Modal -->
        </div>
    </body>
    <script>
        function ck(){
            var checkboxes = document.getElementsByName('checkbox-barang');
                    
            var vals = " ";
            for (var i=0, n=checkboxes.length; i<n; i++) 
                {
                    if (checkboxes[i].checked)
                    {
                        vals += checkboxes[i].value+",";
                    }
                }
                if (vals) vals = vals.substring(1);
                // console.log(vals);
            }
            // function cks(){
            //     var cknya = $('input[name=checkbox-barang]');
            //     var Total = document.getElementById('total');
            //     cknya.addEventListener('blur', function(e)
            //     {
            //         Total.value = formatRupiah(this.value, 'Rp. ');
            //     });
            // }
	
	/* Fungsi */
	function formatRupiah(angka, prefix)
	{
		var number_string = angka.replace(/[^,\d]/g, '').toString(),
			split	= number_string.split(','),
			sisa 	= split[0].length % 3,
			rupiah 	= split[0].substr(0, sisa),
			ribuan 	= split[0].substr(sisa).match(/\d{3}/gi);
			
		if (ribuan) {
			separator = sisa ? '.' : '';
			rupiah += separator + ribuan.join('.');
		}
		
		rupiah = split[1] != undefined ? rupiah + ',' + split[1] : rupiah;
		return prefix == undefined ? rupiah : (rupiah ? 'Rp. ' + rupiah : '');
	}
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>  
</html>