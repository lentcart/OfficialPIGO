<!--#include file="../connections/pigoConn.asp"--> 

<%
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    id = request.queryString("pdID")
    sb = request.queryString("Sub")
    qty = request.queryString("totalqty")

    set alamat_cmd = server.createObject("ADODB.COMMAND")
	alamat_cmd.activeConnection = MM_PIGO_String

	alamat_cmd.commandText = "SELECT * From MKT_M_Alamat where alm_custID = '"& request.cookies("custID") &"' "
    'response.write alamat_cmd.commandText
    set alamat = alamat_cmd.execute

    set tr_cmd = server.createObject("ADODB.COMMAND")
	tr_cmd.activeConnection = MM_PIGO_String

	tr_cmd.commandText = "SELECT dbo.MKT_M_Produk.pdID, dbo.MKT_M_Produk.pdImage1, dbo.MKT_M_Produk.pdNama, dbo.MKT_M_Produk.pd_catID, dbo.MKT_M_Produk.pd_mrID, dbo.MKT_M_Produk.pdType, dbo.MKT_M_Produk.pdHargaJual, dbo.MKT_M_Produk.pdStok, dbo.MKT_M_Produk.pdSku, dbo.MKT_M_Produk.pd_custID, dbo.MKT_M_Customer.custNama, dbo.MKT_M_Customer.custEmail, dbo.MKT_M_Customer.custPhone1, dbo.MKT_M_Alamat.almID FROM dbo.MKT_M_Produk LEFT OUTER JOIN dbo.MKT_M_Customer ON dbo.MKT_M_Produk.pd_custID = dbo.MKT_M_Customer.custID LEFT OUTER JOIN dbo.MKT_M_Alamat ON dbo.MKT_M_Customer.custID = dbo.MKT_M_Alamat.alm_custID where pdID = '"& id &"' " 
    'response.write tr_cmd.commandText
    set tr = tr_cmd.execute
    set Member_cmd = server.createObject("ADODB.COMMAND")
	Member_cmd.activeConnection = MM_PIGO_String

	Member_cmd.commandText = "SELECT * From MKT_M_Customer where custDakotaGYN = 'Y' and custID ='"& request.cookies("custID") &"'  "
    'response.write Member_cmd.commandText
    set Member = Member_cmd.execute


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
        <link rel="stylesheet" type="text/css" href="belisekarang.css">
        <script src="../js/jquery-3.6.0.min.js"></script>

        <title>PIGO</title>
        <script>
        function Tambah() {
            let btnPls = document.getElementsByTagName("plus");
            var harga = parseInt(document.getElementById("pdHargaJual").value);
            let input = parseInt(document.getElementById("totalqtysl").value);
            if (input === input){
                let nilaitambah = 0
                nilaitambah =  input++;
                console.log(nilaitambah);
                document.getElementById("totalqtysl").value = input++;
            }
            let stotal = document.getElementById("totalqtysl").value*harga;
            
            
            document.getElementById('tharga').value = stotal;
            document.getElementById('totalbayar').value = stotal;

            var grandtotal = parseInt(document.getElementById("tharga").value);
            
            var ongkoskirim = parseInt(document.getElementById("ongkoskirimsl").value);
            var tdiskon = parseInt(document.getElementById("diskon").value);
            var tasuransi = parseInt(document.getElementById("basuransi").value);
            var totalbayar = 0;
            totalbayar = grandtotal+(ongkoskirim+tdiskon+tasuransi);
            
            document.getElementById("totalbayar").value = totalbayar;
        }
        function Kurang() {
            let input = parseInt(document.getElementById("totalqtysl").value);
            var harga = parseInt(document.getElementById('pdHargaJual').value);
            if (input === input){
                let nilaikurang = input--;
                    document.getElementById("totalqtysl").value = input--;
                }
            document.getElementById('tharga').value = document.getElementById('tharga').value -harga;
            document.getElementById('tharga').value = document.getElementById('totalbayar').value -harga;

            var grandtotal = parseInt(document.getElementById("tharga").value);
            
            var ongkoskirim = parseInt(document.getElementById("ongkoskirimsl").value);
            var tdiskon = parseInt(document.getElementById("diskon").value);
            var tasuransi = parseInt(document.getElementById("basuransi").value);
            var totalbayar = 0;
            totalbayar = grandtotal+(ongkoskirim+tdiskon+tasuransi);
            
            document.getElementById("totalbayar").value = totalbayar;
        }
        function subproduk(){
            var harga= parseInt(document.getElementById('pdHargaJual').value);
            var qty = parseInt(document.getElementById('totalqtysl').value);
            var pengiriman = parseInt(document.getElementById('ongkoskirimsl').value);
            var diskon = parseInt(document.getElementById('diskon').value);
            var asuransi = parseInt(document.getElementById('basuransi').value);

            var stotal = harga*qty;
            document.getElementById('tharga').value = stotal;
            document.getElementById('ongkoskirimsl').value = pengiriman;
            var s = Number(stotal+pengiriman+diskon+asuransi);
            // console.log(s);  
            document.getElementById('totalbayar').value = s;
            };
            document.addEventListener("DOMContentLoaded", function(event) {
                subproduk();
                });
        </script>
    </head>
<body>
<!-- Header -->
    <!--#include file="../header.asp"-->
<!-- Header -->

<div class="container" style="margin-top:7rem; ">

    <form name="transaksi" action="../Transaksi/P-transaksi.asp"  method="post">
        <div class="row">
            <div class="col-8">
                <div class="div-belisekarang mt-3 mb-4 ">
                    <span class="txt-judul">Barang Yang Di Beli</span>
                        <div class="div-pdbuy mt-1 mb-1">
                            <div class="row align-items-center mt-2 mb-2">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                    <img src="data:image/png;base64,<%=tr("pdImage1") %>"style="height:100px;width:100px;" alt=""/>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-6">
                                    <input type="hidden" name="pdID" id="pdID" value="<%=tr("pdID")%>">
                                    <input class="inp-pdbuy txt-pdbuy" type="text" name="pdnama" id="pdnama" value="<%=tr("pdNama")%>" >
                                    <input class="inp-pdbuy txt-pdbuy" type="text" name="pdtype" id="pdtype" value="<%=tr("pdType")%>" >
                                    <input class="inp-pdbuy txt-pdbuy" type="hidden" name="pdHargaJual" id="pdHargaJual" value="<%=tr("pdHargaJual")%>" >
                                    <input type="hidden" name="idseller" id="idseller" value="<%=tr("pd_custID")%>">
                                    <input class="inp-pdbuy txt-pdbuy" type="text" name="hargapdbuy" id="hargapdbuy" value="<%=Replace(FormatCurrency(tr("pdHargaJual")),"$","Rp.  ")%>" >
                                    <input name="idcust" id="idcust" value="" style="display:none"><br>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                                    <button name="minus" id="minus" type="button" class="btn-qtypd" onclick="return Kurang()" >-</button>
                                    <input type="text" name="totalqtysl" id="totalqtysl" style="text-align: center;border: none; width:3rem;" min="1" max="<%=tr("pdStok")%>" value="<%=qty%>">
                                    <button name="plus" id="plus" type="button" class="btn-qtypd" onclick="return Tambah()">+</button>
                                </div>
                            </div>
                            <!--<div class="form-check">
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
                            </div>-->
                            <input type="hidden" name="pdcustID" id="pdcustID" value="<%=tr("pd_custID")%>">
                            <input type="hidden" name="almID" id="almID" value="<%=alamat("almID")%>">
                        </div>
                        <div class="row align-items-center mt-2">
                            <div class="col-2 me-4">
                                <span class="txt-pdbuy"> Catatan </span>
                            </div>
                            <div class="col-6">
                                <input type="text" class="txt-pdbuy form-detail" name="catatansl" id="catatansl" value="" style="width:100%" placeholder="Tuliskan Catatan Untuk Seller">
                            </div>
                        </div>
                            <div class="row align-items-center mt-3">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                                    <span class="txt-judul">Pengiriman dan pembayaran</span>
                                    <table class="table table-p">
                                    <tr>
                                        <th scope="row align-items-center"></th>
                                    </tr>
                                    <tr>
                                        <td><span class="txt-pengiriman"><input type="hidden" name="alamatpenerima" id="alamatpenerima" value="<%=alamat("almID")%>"><%=alamat("almNamaPenerima")%></span><br>
                                        <span class="txt-pdbuy">[<%=alamat("almPhonePenerima")%>]</span><br>
                                        <span class="txt-pengiriman"><%=alamat("almLengkap")%></span><br>
                                        <span class="txt-pengiriman">Detail/Patokan Alamat : <b>[ <%=alamat("almDetail")%> ]</b></span><br>
                                        <span class="txt-pengiriman"><%=alamat("almProvinsi")%>,<%=alamat("almKota")%>,<%=alamat("almKec")%>,<%=alamat("almKel")%>,</span>
                                        <span ><strong><%=alamat("almKdPos")%></strong></span>
                                        </td>
                                    </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="row align-items-center mt-2 mb-2">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-6">
                                    <select  class=" txt-judul inp-pdbuy" name="pengiriman" id="pengiriman" aria-label="Default select example" style="border:1px solif black; width: 20rem;">
                                        <option  value="">Pilih Metode Pengiriman</option>
                                        <option value="Kurir">Kurir</option>
                                        <option value="Kargo">Reguler</option>
                                        <option value="Ambil Di Toko">Ambil Di Toko</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                <!--CheckOut-->
                <div class="col-lg-0 col-md-0 col-sm-0 col-4 align-items-center mt-3 mb-3 ">
                    <div class="row div-belisekarang align-items-center">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-8 ">
                            <span class="txt-judul"> Pakai  Voucher / Kode Promo </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-2 ">
                            <img src="../assets/logo/next.png" width="35" height="35">
                        </div>
                    </div>

                    <div class="row div-belisekarang mt-3 mb-1">
                        <div class="col-12">
                            <span class="txt-judul"> Ringkasan Belanja </span>
                        </div>
                    </div>
                    <div class="row div-belisekarang">
                        <div class="col-6">
                            <span class="txt-pdbuy"> totalbayar untuk Produk </span><br>
                            <span class="txt-pdbuy"> Total Ongkos Kirim </span><br>
                            <span class="txt-pdbuy"> Total Diskon </span> <br>
                            <span class="txt-pdbuy"> Asuransi Pengiriman </span>
                        </div>
                        <div class="col-2">
                            <span class="txt-pdbuy"> Rp. </span><br>
                            <span class="txt-pdbuy"> Rp. </span><br>
                            <span class="txt-pdbuy"> Rp. </span> <br>
                            <span class="txt-pdbuy"> Rp. </span>
                        </div>
                        <div class="col-4">
                            <input readonly class="inp-pdbuy txt-pdbuy" onblur="subproduk()" style="width:6rem; text-align:right; border:none" type="text" name="tharga" id="tharga" value="0"><br>
                            <input readonly class="inp-pdbuy txt-pdbuy" style="width:6rem; text-align:right; border:none" type="text" name="ongkoskirimsl" id="ongkoskirimsl" value="0">
                            <input readonly class="inp-pdbuy txt-pdbuy" style="width:6rem; text-align:right; border:none" type="text" name="diskon" id="diskon" value="0">
                            <input readonly class="inp-pdbuy txt-pdbuy" style="width:6rem; text-align:right; border:none" type="text" name="basuransi" id="basuransi" value="0">
                        </div>
                    </div>
                    <div class="row div-belisekarang mt-1 mb-1">
                        <div class="col-6">
                            <span class="txt-judul"> Total Pembayaran </span>
                        </div>
                        <div class="col-2">
                            <span class="txt-judul"> RP. </span>
                        </div>
                        <div class="col-4">
                            <input readonly class="inp-pdbuy txt-pdbuy" style="width:6rem; text-align:right; border:none" type="text" name="totalbayar" id="totalbayar" value="0">
                        </div>
                    </div>
                    <div class="row div-belisekarang mt-3">
                        <div class="col-12">
                            <span class="txt-judul"> Metode Pembayaran </span>
                                <div class="row div-belisekarang mt-2">
                                    <div class="col-12">
                                        <%if Member.eof = true then %>
                                            <div class="row">
                                                <div class="col-lg-0 col-md-0 col-sm-0 col-12 ">
                                                    <input class="form-check-input txt-pesanan " type="radio" name="jenispembayaran" id="jenispembayaran" value="COD (Bayar Di Tempat)" checked><Span class="txt-pdbuy" > COD (Bayar diTempat) </span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-0 col-md-0 col-sm-0 col-12 ">
                                                    <input class="form-check-input txt-pesanan  " type="radio" name="jenispembayaran" id="jenispembayaran" value="Transfer Bank" checked><Span class="txt-pdbuy" > Transfer Bank </span>
                                                </div>
                                            </div>
                                            <%
                                            else
                                            %>
                                            <div class="row mt-2">
                                                <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                                                    <input class="form-check-input " type="radio" name="jenispembayaran" id="jenispembayaran" value="Kredit" checked><span class="txt-pdbuy" > Kredit (Khusus Dakota Group) </span>
                                                </div>
                                            </div>
                                            <%
                                            end if
                                            %>
                                    </div>
                                </div>
                            <div class="row">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-12 ">
                                <button type="submit" value="Buat Pesanan" class="btn-pesanan mt-3 text-center"> Buat Pesanan </button>
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

<input type="hidden"name="prov" id="prov" value="<%=alamat("almProvinsi")%>">
<input type="hidden"name="kota" id="kota" value="<%=alamat("almKota")%>">
<input type="hidden"name="kec" id="kec" value="<%=alamat("almKec")%>">
<input type="hidden"name="kel" id="kel" value="<%=alamat("almKel")%>">

</body>
    <script> 

    let provinsi = $('#prov').val();
    let kota = $('#kota').val();
    let kecamatan = $('#kec').val();
    let kelurahan = $('#kel').val();

    $('#pengiriman').on("change",function(){
        let pengiriman = $('#pengiriman').val();
        $.getJSON(`https://www.dakotacargo.co.id/api/pricelist/index.asp?ak=bekasi&tpr=${provinsi}&tko=${kota}&tke=${kecamatan}`,function(data){ 
            // console.log(data.reguler[0].pokok);
            if (pengiriman == "Kurir"){
                let ongkoskirimsl = $("#ongkoskirimsl").val(Number(data.kurir[0].pokok));
            }else if (pengiriman == "Kargo") {
                let ongkoskirimsl = $("#ongkoskirimsl").val(Number(data.reguler[0].pokok));
            }else if (pengiriman == "Ambil Di Toko") {
                let ongkoskirimsl = $("#ongkoskirimsl").val(Number(0));
            }else{
                let ongkoskirimsl = $("#ongkoskirimsl").val(Number(data.regulerudara[0].pokok));
            }

            var grandtotal = parseInt(document.getElementById("tharga").value);
            
            var ongkoskirim = parseInt(document.getElementById("ongkoskirimsl").value);
            var tdiskon = parseInt(document.getElementById("diskon").value);
            var tasuransi = parseInt(document.getElementById("basuransi").value);
            var totalbayar = 0;
            totalbayar = grandtotal+(ongkoskirim+tdiskon+tasuransi);
            
            document.getElementById("totalbayar").value = totalbayar;

        });
    });

</script>
 <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>