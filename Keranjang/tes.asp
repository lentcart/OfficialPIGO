<!--#include file="../connections/pigoConn.asp"--> 
<%
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    id = request.queryString("pdID")

    dim pdID

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String

	Seller_cmd.commandText = "SELECT  MKT_M_Seller.slName , MKT_M_Produk.pd_custID FROM MKT_M_Seller RIGHT OUTER JOIN MKT_M_Produk ON MKT_M_Seller.sl_custID = MKT_M_Produk.pd_custID RIGHT OUTER JOIN MKT_T_Keranjang_H ON MKT_M_Produk.pdID = MKT_T_Keranjang_H.cart_pdID where MKT_T_Keranjang_H.cart_custID = '"& request.cookies("custID") &"' GROUP BY MKT_M_Seller.slName , MKT_M_Produk.pd_custID "
    'response.write Seller_cmd.commandText
    set Seller = Seller_cmd.execute

    set pdID_cmd = server.createObject("ADODB.COMMAND")
	pdID_cmd.activeConnection = MM_PIGO_String

	
%>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="../css/stylehome.css">
    <link rel="stylesheet" type="text/css" href="keranjang.css">
    <script src="../js/jquery-3.6.0.min.js"></script>

    <title>Otopigo</title>
    <script>

        var id = [];
        var harga = [];
        var qty = [];
        var tck = [];
        var arry = [];
        // console.log(id);
        
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
                $(".form-check-ck").prop('checked', true);
                document.getElementById("idproduk").value = pdidall;
                document.getElementById("total").value = subtotal;
                document.getElementById("tbarang").value = qtyy;
            }else{
                $(".form-check-ck").prop('checked', false);
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

        
        #tes{
            width:35px;
            text-align:center;
            border:none;
        }
        #tbarang{
            width:35px;
            text-align:center;
            border:none;
        }
        .ft {
            border-top: 5px solid #0dcaf0;
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color:white;
        }
        .footer-cart{
            padding: 0px 100px;
            margin-top:1px;
            margin-left:20px;
            height:10rem;
        }
        .btn {
            background-color:#0dcaf0;
            color:white;
        }

    </style>
    </head>

<body>
    <div class="container" style="margin-top:1rem">
    <div class="row align-items-center mb-4">
        <div class="col-1">
            <img src="<%=base_url%>/assets/logo/logopigo.png" alt="" width="40" height="60">
        </div>
        <div class="col-10">
            <span class="text-judul me-4"> Official PIGO </span>
            <span class="text-desc "> CheckOut </span>
        </div>
    </div>
    <hr style="border: 5px solid #eee">
        <form class="formck" action="detail-cart.asp" method="POST">
            <div class="row align-items-center">
                <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                    <%if Seller.eof = true then %>
                    <div class="row text-center">
                        <div class="col-12">
                            <span style="font-size:20px"><b> KERANJANG MASIH KOSONG </b></span><BR>
                            <span style="font-size:20px"><b> SILAHKAN PILIH PRODUK FAVORITMU </b></span>
                        </div>
                    </div>

                    <%else%>

                    <div class="pd-cart">
                        <input class="form-check-input me-2" type="checkbox" name="checkall" id="checkall">
                        <label for="checkall"> Pilih Semua Produk </label>
                    </div>

                    <% 
                    no=0
                    do while not Seller.eof
                    no=no+1
                    %> 
                    <div class="row align-items-center mt-2">
                        <div class="col-12">
                            <div class="pd-seller mt-2">
                                <input class="form-check-input me-2" type="checkbox" value="" id="flexCheckDefault">
                                <label for="checkall"><%=Seller("slName")%></label>

                                <%
                                    pdID_cmd.commandText = "SELECT MKT_T_Keranjang_H.cartQty, MKT_M_Produk.pdID, MKT_M_Seller.slName , MKT_M_Produk.pdNama, MKT_M_Produk.pd_custID, MKT_M_Produk.pdType, MKT_M_Produk.pdStok, MKT_M_Produk.pdHargaJual, MKT_M_Produk.pdImage1 FROM MKT_M_Seller RIGHT OUTER JOIN MKT_M_Produk ON MKT_M_Seller.sl_custID = MKT_M_Produk.pd_custID RIGHT OUTER JOIN MKT_T_Keranjang_H ON MKT_M_Produk.pdID = MKT_T_Keranjang_H.cart_pdID where MKT_M_Produk.pd_custID= '"& Seller("pd_custID") &"' "
                                    'response.write pdID_cmd.commandText
                                    set pdID = pdID_cmd.execute
                                %>
                                <%do while not pdID.eof%>
                                <script>
                                        function tambahqty<%=pdID("pdID")%>(ck,e,pdid) {
                                            let input = document.getElementById("tes<%=pdID("pdID")%>").value;
                                            let total = document.getElementById("total");
                                            if (input === input){
                                                let e =  input++ +1;
                                                document.getElementById("tes<%=pdID("pdID")%>").value = input++;
                                                if (e==1){
                                                    total.value = ck;
                                                }else{
                                                    let subtotal = ck*e;
                                                    total.value = subtotal;
                                                }
                                                $.ajax({
                                                    type: "post",
                                                    url: "update-qty.asp",
                                                    data: { qty : e ,  pdID : pdid},
                                                    success: function (data) {
                                                    }
                                                });
                                            }
                                        }
                                        function kurangqty<%=pdID("pdID")%>(ck,e,pdid) {
                                            let input = document.getElementById("tes<%=pdID("pdID")%>").value;
                                            let total = document.getElementById("total");
                                            if (input === input ){
                                                let e = input--;
                                                document.getElementById("tes<%=pdID("pdID")%>").value = input--;
                                                if (e==1){
                                                    total.value = ck;
                                                }else{
                                                    let subtotal = ck-e;
                                                    total.value = subtotal;
                                                }
                                            }
                                            $.ajax({
                                                    type: "post",
                                                    url: "update-qty.asp",
                                                    data: { qty : input ,  pdID : pdid},
                                                    success: function (data) {
                                                    }
                                                });
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
                                                    total += Number(key.total)
                                                    tqty += Number(key.tqty)
                                            });
                                            
                                            document.getElementById("total").value = total;
                                            document.getElementById("idproduk").value = document.getElementById("idproduk").value +id;
                                            document.getElementById("jumlah").value = document.getElementById("jumlah").value +jml;
                                            document.getElementById("tbarang").value= tqty;

                                            }else{
                                                var uncek = array.filter((key)=> key.id != id)
                                                array = uncek
                                                    array.map((key)=> {
                                                    total += Number(key.total)
                                                    tqty += Number(key.tqty)
                                            });

                                            // console.log(tqty);
                                            document.getElementById("total").value = total;
                                            document.getElementById("idproduk").value = document.getElementById("idproduk").value +id;
                                            document.getElementById("jumlah").value = document.getElementById("jumlah").value +jml;
                                            document.getElementById("tbarang").value= tqty;
                                            }
                                
                                        }

                                </script>
                                <div class="row pd-rw align-items-center mt-3">
                                    <div class="col-1">
                                        <input class="form-check-ck" type="checkbox" onclick="ck()" onchange="checkbarang<%=pdID("pdID")%>(this,<%=pdID("cartQty")%>,<%=pdID("pdHargaJual")%>)" value="<%=pdID("pdID")%>" name="checkbox-barang" id="<%=pdID("pdID")%>">
                                    </div>
                                    <div class="col-2 p-0">
                                        <img src="data:image/png;base64,<%=pdID("pdImage1")%>" style="height:100px;width: 100px;" alt=""/>
                                    </div>
                                    <div class="col-6">
                                        <input type="text" class="pd-text pd-form" name="pdnama" id="pdnama" value="<%=pdID("pdNama")%>"><br> 
                                        <input type="text" class="pd-text pd-form" name="pdnama" id="pdnama" value="<%=pdID("pdID")%>"><br> 
                                        <input type="text" class="pd-text pd-form" name="pdType" id="pdType" value="<%=pdID("pdType")%>"><br>
                                        <input type="text" class="pd-text pd-form" name="pdHarga" id="pdHarga" value="<%=Replace(FormatCurrency(pdID("pdHargaJual")),"$","Rp.  ")%>">
                                    </div>
                                    <div class="col-2">
                                        <button name="minus" id="minus<%=pdID("pdID")%>" type="button" class="btn-pdQty btn-dark btn-sm minus" onclick="return kurangqty<%=pdID("pdID")%>('<%=pdID("pdHargaJual")%>','<%=pdID("cartQty")%>','<%=pdID("pdID")%>')"><i class="fas fa-minus"></i></button>

                                        <input class="pd-form-input" name="tes" id="tes<%=pdID("pdID")%>" value="<%=pdID("cartQty")%>">
                                        
                                        <button name="plus" id="plus<%=pdID("pdID")%>" type="button" class="btn-pdQty btn-dark btn-sm plus" onclick="return tambahqty<%=pdID("pdID")%>('<%=pdID("pdHargaJual")%>','<%=pdID("cartQty")%>','<%=pdID("pdID")%>')"><i class="fas fa-plus"></i></button>
                                    </div>
                                    <div class="col-1">
                                        <a href="P-deleteproduk.asp?pdid=<%=pdID("pdID")%>" type="button" class="btn-hapuspd"><img src="<%=base_url%>/assets/logo/delete.png" style="height:35px;width: 35px;" alt=""/></a>
                                    </div>
                                </div>
                                <input type="hidden" name="cart" id="cart<%=no%>" value="<%=pdID("pdID")%>" >
                                <input type="hidden" name="cartharga" id="cartharga<%=no%>" value="<%=pdID("pdHargaJual")%>" >
                                <input type="hidden" name="cartqty" id="cartqty<%=no%>" value="<%=pdID("cartQty")%>" >
                                <input type="hidden" name="pdcust" id="pdcust<%=no%>" value="<%=pdID("pd_custID")%>" >
                                <% pdID.movenext
                                    loop  
                                    nomor = no 
                                %> 
                            </div>
                        </div>
                    </div>

                    <% 
                        Seller.movenext
                        loop 
                    %> 
                    <%end if%>

                    <input type="hidden" name="no" id="no" value="<%=nomor%>" >
                </div>

                <div class="col-lg-0 col-md-0 col-sm-0 col-4 align-items-center" >
                    <div class="pd-cart">
                        <div class="row  align-items-center">
                            <div class="col-lg-0 col-md-0 col-sm-0 col-8 ">
                                <span> Pakai  Voucher / Kode Promo </span>
                            </div>
                        </div>
                    </div>

                    <div class="judul-kategori align-items-center mt-4" style="display:none">
                        <input type="number" name="jumlah" id="jumlah" value="" >
                    </div>

                    <div class="pd-checkout  mt-3">
                        <div class="row text-center">
                            <div class="col-12">
                                <span class="pd-text"> Detail Pesanan </span>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-lg-0 col-md-0 col-sm-0 col-5 ">
                                <span class="pd-text"> Total Barang </span><br>
                                <span class="pd-text"> Total Harga </span><br>
                                <span class="pd-text"> Total Diskon </span>
                            </div>
                            <div class="col-lg-0 col-md-0 col-sm-0 col-1 me-1">
                                <span class="pd-text"></span><br>
                                <span class="pd-text">Rp. </span><br>
                                <span class="pd-text">Rp. </span>
                            </div>
                            <div class="col-lg-0 col-md-0 col-sm-0 col-5">
                                <input class="pd-text" style="width:4.9rem;" onblur="tbarang()"readonly type="number" name="tbarang" id="tbarang" value="0" >Barang
                                <input class="pd-text" readonly style="width:9rem; text-align:right; border:none" type="number" name="total" id="total" value="0"><br>
                                <input class="pd-text" readonly style="width:9rem; text-align:right; border:none" type="number" name="diskon" id="diskon" value="0">
                            </div>
                        </div>

                        <input type="hidden" name="idproduk" id="idproduk" value="" readonly >
                        <input type="hidden" name="idpdcust" id="idpdcust" value="" readonly >
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="pd-checkout text-center">
                            
                            <input class=" text-center pd-input-checkout" type="submit" value="Pilih Pembayaran">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    
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

    </script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../js/bootstrap.js"></script>
</body>
</html>