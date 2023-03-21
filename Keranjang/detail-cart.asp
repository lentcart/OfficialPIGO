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

                    filterProduk = filterProduk & addOR & " MKT_T_Keranjang_H.cart_pdID = '"& x &"' "
                    addOR = " or " 

            end if
        next

        if filterProduk <> "" then
            FilterFix = " and  ( " & filterProduk & " )" 
        end if
        
        'response.write filterProduk

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

    set transaksi_cmd = server.createObject("ADODB.COMMAND")
	transaksi_cmd.activeConnection = MM_PIGO_String

	transaksi_cmd.commandText = "SELECT dbo.MKT_T_Keranjang_H.cartQty, dbo.MKT_T_Keranjang_H.cart_custID, dbo.MKT_M_Produk.pdID, dbo.MKT_M_Produk.pdNama, dbo.MKT_M_Produk.pd_mrID, dbo.MKT_M_Produk.pdType,dbo.MKT_M_Produk.pdImage1, dbo.MKT_M_Produk.pdDesc1, dbo.MKT_M_Produk.pdSku, dbo.MKT_M_Produk.pdStok, dbo.MKT_M_Produk.pdHargaJual,  dbo.MKT_M_Produk.pd_catID, dbo.MKT_M_Produk.pd_custID FROM dbo.MKT_M_Produk LEFT OUTER JOIN dbo.MKT_T_Keranjang_H ON dbo.MKT_M_Produk.pdID = dbo.MKT_T_Keranjang_H.cart_pdID where dbo.MKT_T_Keranjang_H.cart_custID = '"& request.Cookies("custID") &"' " &  FilterFix 
    'response.write transaksi_cmd.commandText
    set transaksi = transaksi_cmd.execute

    set tr_cmd = server.createObject("ADODB.COMMAND")
	tr_cmd.activeConnection = MM_PIGO_String

	tr_cmd.commandText = "SELECT dbo.MKT_T_Keranjang_H.cartQty, dbo.MKT_T_Keranjang_H.cart_custID, dbo.MKT_M_Produk.pdID, dbo.MKT_M_Produk.pdNama, dbo.MKT_M_Produk.pd_mrID, dbo.MKT_M_Produk.pdType,dbo.MKT_M_Produk.pdImage1, dbo.MKT_M_Produk.pdDesc1, dbo.MKT_M_Produk.pdSku, dbo.MKT_M_Produk.pdStok, dbo.MKT_M_Produk.pdHargaJual,  dbo.MKT_M_Produk.pd_catID, dbo.MKT_M_Produk.pd_custID FROM dbo.MKT_M_Produk LEFT OUTER JOIN dbo.MKT_T_Keranjang_H ON dbo.MKT_M_Produk.pdID = dbo.MKT_T_Keranjang_H.cart_pdID where dbo.MKT_T_Keranjang_H.cart_custID = '"& request.Cookies("custID") &"' " &  FilterFix 
    'response.write tr_cmd.commandText
    set tr = tr_cmd.execute

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

        <title>PIGO</title>
        <script>

        var id = [];
        var hg = [];
        var qty = [];

        function loaddata(id){
            var tqty = 0; 
        var no = document.getElementById('no').value;
        var ongkir = parseInt(document.getElementById('ongkoskirim').value);
        for ( i=1; i<=no; i++){
            id.push($(`#cart${i}`).val());
            hg.push($(`#cartharga${i}`).val()); 
            qty.push($(`#cartqty${i}`).val()); 
            var sb = Number(hg*qty+ongkir);
            document.getElementById('subtotalproduk').value = sb;
            var a = document.getElementById('totalqty').value;
            var b = document.getElementById('stok').value;
            var stok = Number(b-a);
            document.getElementById('updatestok').value = stok;
        }
        
        return hg,id;

    }
        </script>
    </head>
<body onload="loaddata(id)">
    <div class="header">
            <div class="container">
                <div class="row align-items-center mt-2">
                    <div class="col-12 align-items-center">
                        <img src="../assets/logo1.jpg" class="rounded-pill me-4" alt="" width="65" height="65" />
                        <span class="judul-hd">PIGO</span>
                        <span class="judul-hd">|</span>
                        <span class="judul-hd">Checkout</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container" style="margin-top:6rem;background-color:#fcfcfc; ">
        <form name="transaksi" action="../Transaksi/P-transaksi.asp" method="post">
            <div class="row">
                <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                    <div class="judul-kategori  mt-3 mb-2 ">
                    <span class="text-judul">Alamat Pengiriman</span>
                    <hr>
                    <%if alamat.eof = true then %>

                    Tidak Ada Alamat

                    <%else%>
                    <div class="row">
                        <div class="col-9">
                            <table class=" table-p">
                                <td><span class="text-span"><input type="hidden" name="almID" id="almID" value="<%=alamat("almID")%>"><%=alamat("almNamaPenerima")%>,[<b><%=alamat("almPhonePenerima")%></b>]</span><br>
                                <span class="text-span"><%=alamat("almPhonePenerima")%></span><br>
                                <span class="text-span"><%=alamat("almLengkap")%></span><br>
                                <span class="text-span">Detail/Patokan Alamat : <b>[ <%=alamat("almDetail")%> ]</b></span><br>
                                <span class="text-span"><%=alamat("almProvinsi")%>,<%=alamat("almKota")%>,<%=alamat("almKec")%>,<%=alamat("almKel")%>,</span>
                                <span class="text-span"><strong><%=alamat("almKdPos")%></strong></span>
                                </td>
                            </table>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn-alm text-center text-btn "id="myBtn"> Pilih Alamat Lain </button>
                        </div>
                    </div>
                    <% end if%>

                    <hr>
                    <div class="form-floating mt-3">
                        <textarea class="form-control" name="trD1catatan" id="trD1catatan" placeholder="Catatan Pesanan" id="floatingTextarea" style="border-radius:20px;"></textarea>
                            <label class="text-span" for="floatingTextarea">Catatan Pesanan</label>
                    </div>
                </div>
                <span class="text-judul"> Detail Pesanan </span>

                <% 
                no=0
                do while not tr.eof
                no=no+1
                %>
                
                <script>
                    function subproduk(){
                        var a = parseInt(document.getElementById('subtotalproduk').value);
                        var b = parseInt(document.getElementById('ongkoskirim').value);
                        var subtotalproduk = parseInt(document.getElementById('tharga').value);
                        var ongkir = parseInt(document.getElementById('tongkoskirim').value);
                        var diskon = parseInt(document.getElementById('diskon').value);
                        var sbtotal = Number(subtotalproduk+b+diskon);
                        document.getElementById('subtotal').value = sbtotal;
                        document.getElementById('subtotalproduk').value = sbtotal;
                    };
                    document.addEventListener("DOMContentLoaded", function(event) {
                        subproduk();
                        });
                </script>

                <!--Daftar Produk Dari ProdukID-->
                <div class="judul-kategori mt-2 mb-1" style=" background-color:white; padding:10px; border-radius:10px;border:2px solid #ececec">
                    <div class="produk">
                        <div class="row">
                            <div class="col-8">
                            <!--Daftar Produk Dari Toko Yang Sama-->
                                <div class="judul-kategori" style=" background-color:white; border-radius:2px;border:2px solid #f8f8f8">
                                    <div class="row align-items-center mt-2 mb-2">
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                                            <img src="data:image/png;base64,<%=tr("pdImage1")%>"style="height:100px;width:100px;" alt="data:image/png;base64,<%=tr("pdImage1")%>"/>
                                        </div>
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-9">
                                            <span class="text-span" style="font-size:14px"><b><%=tr("pdNama")%></b></span>
                                            <input type="hidden" name="idpd" id="idpd" value="<%=tr("pdID")%>">
                                            <input type="hidden" name="stok" id="stok" value="<%=tr("pdStok")%>" >
                                            <input type="hidden" name="idcust" id="idcust" value="<%=tr("cart_custID")%>"><br>
                                            <span class="text-span" style="font-size:12px">Variasi(<b><%=tr("pdType")%></b>)</span><br>
                                            <span class="text-span" style="font-size:12px">Total Produk :
                                            <input class="text-span" style="text-align:center; width:30px; border:none" name="qty" id="qty<%=tr("pdID")%>" readonly value="<%=tr("cartQty")%>"> Barang</span><br>
                                            <b><input class="text-span" style="color:#205f6b;width:20rem; border:none" readonly type="hidden" name="harga" id="harga<%=tr("pdID")%>" value="<%=tr("pdHargaJual")%>"></b>
                                            <b><input class="text-span" style="color:#205f6b;width:20rem; border:none" readonly type="text" name="hargajual" id="hargajual<%=tr("pdID")%>" value="<%=Replace(FormatCurrency(tr("pdHargaJual")),"$","Rp.  ")%>"></b>
                                            <input type="hidden" name="idseller" id="idseller" value="<%=tr("pd_custID")%>">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--Daftar Produk Dari Toko Yang Sama-->
                            <div class="col-4">
                                <select class="form-select text-span" name="ongkir" id="ongkir" aria-label="Default select example" style="border:1px solif black; width: 13rem;">
                                    <option class="text-span" value="">Metode Pengiriman</option>
                                    <!--<option class="text-span"value="Kurir">Kurir</option>
                                    <option class="text-span"value="Reguler">Reguler</option>-->
                                    <option class="text-span"value="Ambil Di Toko">Ambil Di Toko</option>
                                    <!--<option value="1">Kurir</option>-->
                                </select>
                                <div class="row mt-3" style="margin-left:50px">
                                    <div class="col-2">
                                        <span class="text-span">Rp. </span>
                                    </div>
                                    <div class="col-8">
                                        <input class="text-span"  style="width:7rem; text-align:right; border:none" type="text" name="ongkoskirim" id="ongkoskirim" value="0">
                                    </div>
                                </div>
                            </div>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <div class="form-check">
                                            <input name="asuransi" id="asuransi" class="form-check-input text-span" type="checkbox" value="Y" id="flexCheckChecked">
                                            <label class="form-check-label text-span" for="flexCheckChecked">
                                                    Wajib Asuransi
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input name="packing" id="packing" class="form-check-input text-span" type="checkbox" value="Y" id="flexCheckChecked">
                                            <label class="form-check-label text-span" for="flexCheckChecked">
                                                    Keamanan Tambahan Untuk Produk
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <div class="row align-items-center">
                            <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                                <h2 class="accordion-header" id="heading1">
                                    <button class="btn-kategori-menu collapsed text-span" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">Sub Total Produk</button>
                                </h2>
                            </div>
                            <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                                <button class="btn-kategori-menu collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">
                                <div class="row">
                                    <div class="col-2">
                                        <span class="text-span">Rp. </span>
                                    </div>
                                    <div class="col-6">
                                        <input onload="subproduk()" readonly class="text-span" style="width:12rem;  border:none; text-align:right;" type="number" name="subtotalproduk" id="subtotalproduk" value="0">
                                    </div>
                                </div>
                                </button>
                            </div>
                            <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="heading1" data-bs-parent="#accordionExample">
                                <div class="row">
                                    <div class="col-8">
                                        <span class="text-span" >Ongkos Kirim</span><br>
                                        <span class="text-span" >Biaya Layanan</span>
                                    </div>
                                    <div class="col-3">
                                        <div class="row">
                                            <div class="col-2">
                                                <span class="text-span">Rp. </span>
                                                <span class="text-span">Rp. </span>
                                            </div>
                                            <div class="col-6">
                                                <input  readonly class="text-span" style="width:12rem;  border:none; text-align:right;" type="number" name="ongkoskirim1" id="ongkoskirim1" value="0">
                                                <input  readonly class="text-span" style="width:12rem;  border:none; text-align:right;" type="number" name="biayalayanan" id="biayalayanan" value="0">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="cart" id="cart<%=no%>" value="<%=tr("pdID")%>" >
                <input type="hidden" name="cartqty" id="cartqty<%=no%>" value="<%=tr("cartQty")%>" >
                <input type="hidden" name="tqty" id="tqty<%=no%>" value="<%=tr("cartQty")%>" >
                <input type="hidden" name="pdcustID" id="pdcustID<%=no%>" value="<%=tr("pd_custID")%>" >
                <input type="text" name="updatestok" id="updatestok" value="" >
                
                <% 
                    tr.movenext
                    loop
                    nomor = no 
                %>
                <input type="hidden" name="no" id="no" value="<%=nomor%>" >
            </div>
        <!--CheckOut-->
            <div class="col-lg-0 col-md-0 col-sm-0 col-4 align-items-center ">
                <div class="judul-kategori mb-3" style=" padding:5px; background-color:white; border-radius:20px;border-bottom:4px solid #c2c2c2">
                    <div class="row  align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <img src="../assets/logo/voucher.png" width="50" height="50">
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-8 ">
                            <span class="text-span"> Pakai  Voucher / Kode Promo </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-2 ">
                            <img src="../assets/logo/next.png" width="35" height="35">
                        </div>
                    </div>
                </div>
                <span class="text-judul"> Ringkasan Belanja </span>
                <div class="judul-kategori align-items-center mb-3 mt-2" style="padding:15px; 15px; background-color:white; border-radius:20px; border-bottom:4px solid #c2c2c2; border-top:4px solid #c2c2c2">
                    <div class="row">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-6 ">
                            <span class="text-span"> Total</span><br>
                            <span class="text-span"> Total Ongkos Kirim </span><br>
                            <span class="text-span"> Total Diskon </span> <br>
                            <span class="text-span"> Asuransi Pengiriman </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-1 me-2">
                            <span class="text-span">Rp. </span><br>
                            <span class="text-span">Rp. </span><br>
                            <span class="text-span">Rp. </span><br>
                            <span class="text-span">Rp. </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-4 ">
                            <input class="text-span" readonly  style="width:6rem; text-align:right; border:none" type="number" name="tharga" id="tharga" value="<%=subtotal%>"><br>
                            <input class="text-span" readonly style="width:6rem; text-align:right; border:none" type="number" name="tongkoskirim" id="tongkoskirim" value="0">
                            <input class="text-span" readonly style="width:6rem; text-align:right; border:none" type="number" name="diskon" id="diskon" value="0">
                            <input class="text-span" readonly style="width:6rem; text-align:right; border:none" type="number" name="basuransi" id="basuransi" value="0">
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-6 ">
                            <span class="text-span"> Total Pembayaran </span><br>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-1 me-2">
                            <span class="text-span">Rp. </span><br>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                            <input class="text-span" onblur="subproduk()" readonly style="width:6rem; text-align:right; border:none" type="number" name="subtotal" id="subtotal" value="0"><br>
                        </div>
                    </div>
                </div>
                
                <span class="text-judul"> Metode Pembayaran </span>
                <div class="judul-kategori align-items-center mt-2" style="padding:15px; 15px; background-color:white; border-radius:20px;border-bottom:4px solid #c2c2c2; border-top:4px solid #c2c2c2">
                <%if Member.eof = true then %>
                <div class="row">
                    <div class="col-lg-0 col-md-0 col-sm-0 col-12 ">
                        <input class="form-check-input text-span  " type="radio" name="Jpembayaran" id="Jpembayaran" value="COD (Bayar Di Tempat)" checked><span class="text-span" > COD (Bayar diTempat) </span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-0 col-md-0 col-sm-0 col-12 mt-2 ">
                        <input class="form-check-input text-span  " type="radio" name="Jpembayaran" id="Jpembayaran" value="Transfer Bank" checked><span class="text-span" > Transfer Bank </span>
                    </div>
                </div>
                 <%
                 else
                 %>
                <div class="row">
                    <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                        <input class="form-check-input text-span " type="radio" name="Jpembayaran" id="Jpembayaran" value="Kredit" checked><span class="text-span" > Kredit (Khusus Dakota Group) </span>
                    </div>
                </div>
                <%
                end if
                %>
                </div>
                <div class="row">
                    <div class="col-lg-0 col-md-0 col-sm-0 col-12 text-center">
                        <input type="hidden" name ="totalqty" id="totalqty" value="<%=qty%>">
                        <input type="submit" value="Buat Pesanan" class="btn-pembayaran mt-3">
                    </div>
                </div>
            </div>  
                        
        </div>
        <!--CheckOut-->
                    </div>
                </div>
            </div>
        </form>
    </div>
        <!--<input type="hidden" id="snap-token" value="0a0208b2-add2-42be-994c-465fab662f72" class="form-input">

        <button type="submit" id="pay-button" class="btn btn-primary input-group-btn">Buat Pesanan </button>
        <script type="text/javascript" src="https://app.sandbox.midtrans.com/snap/snap.js" data-client-key="SB-Mid-client-eJOzSqtIuw-eTEz2"></script>
        <script type="text/javascript">
        var payButton = document.getElementById('pay-button');
        payButton.addEventListener('click', function() {
          var snapToken = document.getElementById('snap-token').value;
          snap.pay(snapToken);
        });
      </script>-->

<input type="hidden"name="prov" id="prov" value="<%=alamat("almProvinsi")%>">
<input type="hidden"name="kota" id="kota" value="<%=alamat("almKota")%>">
<input type="hidden"name="kec" id="kec" value="<%=alamat("almKec")%>">
<input type="hidden"name="kel" id="kel" value="<%=alamat("almKel")%>">

</body>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../js/bootstrap.js"></script>
    <script src="../js/popper.min.js"></script>
    <script> 
    // Get the modal
    var modal = document.getElementById("modalalamat");

    // Get the button that opens the modal
    var btn = document.getElementById("myBtn");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close-alamat")[0];

    // When the user clicks the button, open the modal 
    btn.onclick = function() {
    modal.style.display = "block";
    }

    // When the user clicks on <span> (x), close the modal
    // span.onclick = function() {
    //   modal.style.display = "none";
    // }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
    }

    let provinsi = $('#prov').val();
    let kota = $('#kota').val();
    let kecamatan = $('#kec').val();
    let kelurahan = $('#kel').val();

    // $('#ongkir').on("focus", function(){
    //     $.getJSON(`https://www.dakotacargo.co.id/api/pricelist/index.asp?ak=bekasi&tpr=${provinsi}&tko=${kota}&tke=${kecamatan}`,function(data){ 
    //             console.log(data);
    //             //  $('#ongkir').append(`<option value="1">`+data[0]+`</option><option value="2">`+data[0]+`</option>`);
    //     });
    // })

    $('#ongkir').on("change",function(){
        let ongkir = $('#ongkir').val();
        $.getJSON(`https://www.dakotacargo.co.id/api/pricelist/index.asp?ak=bekasi&tpr=${provinsi}&tko=${kota}&tke=${kecamatan}`,function(data){ 
            // console.log(data.reguler[0].pokok);
            if (ongkir == "Kurir" ){

                $("#ongkoskirim").val(Number(data.kurir[0].pokok));
                $("#ongkoskirim1").val(Number(data.kurir[0].pokok));
                $("#tongkoskirim").val(Number(data.kurir[0].pokok));
            }else if (ongkir == "Reguler" ) {

                $("#ongkoskirim").val(Number(data.reguler[0].pokok));
                $("#ongkoskirim1").val(Number(data.reguler[0].pokok));
                $("#tongkoskirim").val(Number(data.reguler[0].pokok));
                
            }else if (ongkir == "Ambil Di Toko" ) {

                $("#ongkoskirim").val(Number(0));
                $("#ongkoskirim1").val(Number(0));
                $("#tongkoskirim").val(Number(0));
                
            }else{
                $("#ongkoskirim").val(Number(data.regulerudara[0].pokok));

            }
            
        });
    });
            $ajax({
                
            })
            $.ajax({
                url: "https://app.sandbox.midtrans.com/snap/v1/transactions",
                method: "post",
                headers: {
                    Accept: "application/json",
                    Authorization: "Basic U0ItTWlkLXNlcnZlci1RdlBUOVN6NUk3RFBSaWM2SmZ2VXVxSFg6",
                    "Content-Type": "application/json",
                },
                data:
                {
                transaction_details: {
                    order_id: "ORDER-102-{{$timestamp}}",
                    gross_amount: 10000
                },
                credit_card: {
                    secure: true
                },
                item_details: [{
                    id: "ITEM1",
                    price: 10000,
                    quantity: 1,
                    name: "Midtrans Bear"
                }],
                customer_details: {
                    first_name: "TEST",
                    last_name: "MIDTRANSER",
                    email: "noreply@example.com",
                    phone: "+628123456",
                    billing_address: {
                    first_name: "TEST",
                    last_name: "MIDTRANSER",
                    email: "noreply@example.com",
                    phone: "081 2233 44-55",
                    address: "Sudirman",
                    city: "Jakarta",
                    postal_code: "12190",
                    country_code: "IDN"
                    },
                    shipping_address: {
                    first_name: "TEST",
                    last_name: "MIDTRANSER",
                    email: "noreply@example.com",
                    phone: "0812345678910",
                    address: "Sudirman",
                    city: "Jakarta",
                    postal_code: "12190",
                    country_code: "IDN"
                    }
                }
                },
                success: function (data) {
                    console.log(data);
                }
            });
            

</script>
</html>
