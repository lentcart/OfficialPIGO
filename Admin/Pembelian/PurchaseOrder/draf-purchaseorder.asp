<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    poID = request.form("poID")

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String

        BussinesPartner_cmd.commandText = "SELECT * FROM MKT_M_BussinesPartner WHERE bpAktifYN = 'Y' "
        'response.write BussinesPartner_cmd.commandText

    set BussinesPartner = BussinesPartner_cmd.execute

    set KeyProduk_cmd = server.createObject("ADODB.COMMAND")
	KeyProduk_cmd.activeConnection = MM_PIGO_String

        KeyProduk_cmd.commandText = "SELECT pdKey FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y'"
        'response.write KeyProduk_cmd.commandText

    set KeyProduk = KeyProduk_cmd.execute


%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
        function contcall(){
            document.getElementById("cont-calculator").style.display = "block"
        }
        function getBussinesPartner(){
            var Bussines = $('input[name=keysearch]').val();            
            $.ajax({
                type: "get",
                url: "get-bussinespart.asp?keysearch="+Bussines,
                success: function (url) {
                // console.log(url);
                $('.cont-BussinesPart').html(url);
                }
            });
        }
        
        function getsupplier(){
            $.ajax({
                type: "get",
                url: "loadsupplier.asp?keysupplier="+document.getElementById("keysupplier").value,
                success: function (url) {
                // console.log(url);
                $('.datasp').html(url);
                                    
                }
            });
        }
        function tampilproduk(){
            let pem= document.getElementsByClassName("simpan");

            document.getElementById("poproduk").style.display = "block";
        }

        function getKeyProduk(){
            $.ajax({
                type: "get",
                url: "get-Produk.asp?katakunci="+document.getElementById("katakunci").value,
                success: function (url) {
                // console.log(url);
                $('.keypd').html(url);
                                    
                }
            });
        }
        
        // function subtotal(){
        //     var qty = parseInt(document.getElementById("qtyproduk").value);
        //     var harga = parseInt(document.getElementById("harga").value);
        //     var total = Number(qty*harga);
        //     document.getElementById("subtotalpo").value = total;
            
        // };
        // document.addEventListener("DOMContentLoaded", function(event) {
        //     subtotal();
        // });
        function Batal() {
            Swal.fire({
            title: 'Anda Yakin Akan Membatalkan Proses Ini Tanpa Menyimpan ?',
            showCancelButton: true,
            confirmButtonText: 'Yakin',
            }).then((result) => {
            if (result.isConfirmed) {
                window.open('../PurchaseOrderDetail/', '_Self');
            } 
            })
        }
    </script>
    <style>

        #clear{
            width: 14.3rem;
            color:black;
            font-weight:bold;
            font-size:12px;
            border: 1px solid #d4d4d4;
            border-radius: 3px;
            padding: 2px;
            box-shadow: 0 2px 3px 0 rgba(10, 10, 10, 0.2),0 6px 20px 0 rgba(175, 175, 175, 0.19);
            background-color: #eee;
        }

        .formstyle{
            width:15rem;
            height:15.3rem;
            margin: auto;
            background:#aaa;
            border-radius: 10px;
            padding: 5px;
        }

        .inp-cal{
            width: 44px;
            background-color: green;
            color: black;
            font-weight:bold;
            border: 1px solid #d4d4d4;
            border-radius: 0px;
            padding: 5px 5px;
            margin: 5px;
            box-shadow: 0 2px 3px 0 rgba(10, 10, 10, 0.2),0 6px 20px 0 rgba(175, 175, 175, 0.19);
            font-size: 12px;
        }
        #kalkulator{
            display:none;
            margin-left:-20px;
        }

        #calc{
            width: 14.4rem;
            font-size:12px;
            color: blue;
            font-weight:bold;
            padding: 6px 10px;
            background:#aaa;
            border: 1px solid #d4d4d4;
            border-radius: 5px;
            margin: auto;
        }
    </style>
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-10 col-md-10 col-sm-12">
                        <span class="cont-text">sd<%=poID%> PURCHASE ORDER </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button class="cont-btn" onclick="return Batal()"> Batal </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <span class="cont-text"> Tanggal PO  </span><br>
                        <input required type="Date" class="  cont-form" name="tanggalpo" id="cont" value=""><br>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <span class="cont-text"> Jenis Order </span><br>
                        <select class="  cont-form" name="jenisorder" id="cont" aria-label="Default select example" required>
                            <option selected>Pilih</option>
                            <option value="1">Slow Moving</option>
                            <option value="2">Fast Moving</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                    <span class="cont-text"> Status Credit </span><br>
                        <select class="  cont-form" name="statuskredit" id="cont" aria-label="Default select example" required>
                            <option selected>Pilih</option>
                            <option value="01">Kredit</option>
                            <option value="02">Cash</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <span class="cont-text"> Tanggal Order  </span><br>
                        <input required type="Date" class="  cont-form" name="tanggalorder" id="cont" value=""><br>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <span class="cont-text"> Tanggal Penerimaan </span><br>
                        <input required type="Date" class="  cont-form" name="tanggalditerima" id="cont" value=""><br>
                    </div>
                </div>

                <div class="row mt-2 mb-2 text-center ">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="cont-label-text">
                            <span class=" cont-text"> Bussines Partner </span>
                        </div>
                    </div>
                </div>

                <div class="row text-align-center mt-2">
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <span class="cont-text"> Kata Kunci </span><br>
                        <input required  onkeyup="getBussinesPartner()" type="text" class="cont-form" name="keysearch" id="cont" value=""><br>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-12 cont-BussinesPart">

                    </div>
                </div>

                <div class="cont-Bussines">
                    <div class="row">
                        <div class="col-lg-2 col-md-6 col-sm-12">
                            <span class="cont-text">  BussinesPartner ID </span><br>
                            <input required type="text" class="  cont-form" name="supplierid" id="cont" value=""><br>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <span class="cont-text"> Nama BussinesPartner </span><br>
                            <input required type="text" class="  cont-form" name="namasupplier" id="cont" value="" ><br>
                        </div>
                        <div class="col-lg-1 col-md-2 col-sm-12">
                            <span class="cont-text"> PayTerm</span><br>
                            <input required type="text" class="  cont-form" name="poterm" id="cont" value="" ><br>
                        </div>
                        <div class="col-lg-5 col-md-10 col-sm-12">
                            <span class="cont-text"> Nama CP BussinesPartner </span><br>
                            <input required type="text" class="  cont-form" name="namacp" id="cont" value="" ><br>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <span class="cont-text"> Lokasi BussinesPartner </span><br>
                            <input required type="text" class="  cont-form" name="lokasi" id="cont" value="" ><br>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <span class="cont-text"> Perhitungan Jatuh Tempo Pembayaran </span><br>
                                <select   class=" cont-form" name="poKonfPem" id="cont" aria-label="Default select example" required>
                                <option value="">Pilih</option>
                                <option value=""> Penerimaan Barang (MM)</option>
                                <option value=""> Invoice/Faktur</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row align-items-center mt-2">
                    <div class="col-lg-3 col-md-6 col-sm-12  data-POID">
                        <button onclick="AddBussinesPart()" class="cont-btn" name="btn-addpo" id="btn-addpo"> <i class="fas fa-folder-plus"></i>&nbsp;&nbsp;Tambah Produk Purchase Order </button>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-12">
                                    
                    </div>
                </div>

                <div class="cont-Produk-PO mt-2" id="cont-Produk-PO" style="display:none">
                    <div class="row">
                        <div class="col-lg-2 col-md-3 col-sm-12">
                            <span class="cont-text"> Kata Kunci </span><br>
                            <input required onkeyup="getKeyProduk()" type="text" class="  cont-form" name="katakunci" id="katakunci" value=""><br>
                        </div>
                        <div class="col-lg-4 col-md-3 col-sm-12 keypd">
                            <span class="cont-text"> </span><br>
                            <select   class=" cont-form" name="s" id="s" aria-label="Default select example" required>
                                <option value="">Pilih Produk</option>
                                <option value=""></option>
                            </select>
                        </div>
                    </div>
                    <div class="row datapd">
                        <input type="hidden" class=" cont-form" name="produkid" id="produkid" value="" ><br>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <span class="cont-text"> Nama Produk </span><br>
                                <input readonly type="text" class="  cont-form" name="namaproduk" id="namaproduk" value="" ><br>
                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-12">
                                        <div class="row">
                                            <div class="col-lg-10 col-md-6 col-sm-12">
                                                <span class="cont-text"> Harga </span><br>
                                                <input readonly type="number" class=" text-center  cont-form" name="harga" id="harga" value="0" style="width:100%">
                                            </div>
                                            <div class="col-lg-2 col-md-6 col-sm-12"   style="margin-top:26px;margin-left:-8px">
                                                <input  type="checkbox" id="kalkulator">
                                                <label class="side-toggle" for="kalkulator"> <span class="fas fa-calculator" style="font-size:17px"> </span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-12">
                                        <span class="cont-text"> Diskon </span><br>
                                        <input  readonly type="number" class=" cont-form" name="diskon" id="diskon" value="0"><br>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-12">
                                        <span class="cont-text"> QTY Produk </span><br>
                                        <input  readonly type="number" class="  text-center  cont-form" name="qtyproduk" id="qtyproduk" value="0"><br>
                                    </div>
                                </div>
                            </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-6 col-sm-12">
                                                <span class="cont-text"> SKU/Part Number</span><br>
                                                <input readonly type="text" class=" text-center  cont-form" name="skuproduk" id="skuproduk" value="" ><br>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-sm-12">
                                                <span class="cont-text"> Lokasi Rak </span><br>
                                                <input readonly type="text" class="  cont-form" name="lokasirak" id="lokasirak" value="" ><br>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-12">
                                                <span class="cont-text"> Unit </span><br>
                                                <input readonly type="text" class="  text-center  cont-form" name="unitproduk" id="unitproduk" value="" ><br>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-4 col-md-4 col-sm-12">
                                                <span class="cont-text"> Sub Total </span><br>
                                                <input readonly type="number" class=" text-center  cont-form" name="subtotalpo" id="subtotalpo" value="0"><br>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-sm-12">
                                                <span class="cont-text"> TAX (PPN) </span><br>
                                                <select disabled="true" class=" cont-form" name="ppn" id="ppn" aria-label="Default select example" >
                                                    <option value="">Pilih Produk</option>
                                                </select>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-sm-12">
                                                <span class="cont-text">  </span><br>
                                                <input readonly type="number" class=" text-center  cont-form" name="totalpo" id="totalpo" value="0"><br>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-3 mb-3">
                                    <div class="col-lg-8 col-md-8 col-sm-8 ">
                                    <span class="cont-text"> </span><br>
                                        <button onclick="sendproduk()"class=" btn-addpo cont-btn"> Tambah Produk </button>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-4">
                                        <span class="cont-text"> Status Purchase Order </span><br>
                                        <select class="cont-form" name="statuspo" id="statuspo" aria-label="Default select example" required>
                                            <option value="">Pilih</option>
                                            <option value="1">Draf</option>
                                            <option value="2">Complete</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="cont-tb" style="padding:2px 5px; height:15rem">
                                
                                
                                <div class="row">
                                    <div class="col-12">
                                        <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                                            <thead>
                                                <tr class="text-center">
                                                    <th>No</th>
                                                    <th>ID Produk</th>
                                                    <th>Nama Produk</th>
                                                    <th>QTY</th>
                                                    <th>Harga</th>
                                                    <th>PPN</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody class="data-produk">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                </div>
                                <div class="row  mt-1">
                                    <div class="col-3 text-start">
                                        <button onclick="statuspo()" name="btn-selesai" id="btn-selesai" class="cont-btn"> Selesai </button>
                                        <button onclick="window.open('../PurchaseOrderDetail/buktipo.asp?poID='+document.getElementById('poID').value+'&poTanggal='+document.getElementById('poTanggal').value,'_Self')" class="cont-btn" name="btn-cetakpo" id="btn-cetakpo" style="display:none"> Cetak Bukti PO </button>
                                    </div>
                                    <div class="col-3 text-start">
                                        <button onclick="window.open('../PurchaseOrderDetail/','_Self')" class="cont-btn" name="btn-listpo" id="btn-listpo" style="display:none"> List PO </button>
                                    </div>
                                    <!--<div class="col-6 text-end">
                                        <button onclick="window.open('../PurchaseOrderDetail/buktipo.asp?poID='+document.getElementById('poID').value+'&poTanggal='+document.getElementById('poTanggal').value,'_Self')" class="cont-btn" style="width:13rem"> Selesai ( Cetak Bukti PO ) </button>
                                    </div>-->
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
    <script>
    function AddBussinesPart() {
        var poTanggal = $('input[name=tanggalpo]').val();
        var poJenis = $('select[name=jenisinvoice]').val();
        var poJenisOrder = $('select[name=jenisorder]').val();
        var poTglOrder = $('input[name=tanggalorder]').val();
        var poTglDiterima = $('input[name=tanggalditerima]').val();
        var poStatusKredit = $('select[name=statuskredit]').val();
        var poDropShip = $('input[name=dropship]').val();
        var po_spID = $('select[name=bussinespartner]').val();
        var poKonfPem = $('select[name=poKonfPem]').val();
        $.ajax({
            type: "GET",
            url: "add-purchaseorder.asp",
            data:{
                poTanggal,
                poJenis,
                poJenisOrder,
                poTglOrder,
                poTglDiterima,
                poStatusKredit,
                poDropShip,
                po_spID,
                poKonfPem
            },
            success: function (data) {
                $('.data-POID').html(data);
                }
            });
        document.getElementById("btn-addpo").style.display = "none"
        document.getElementById("cont-Produk-PO").style.display = "block";
        $('#bussinespartner').attr('disabled',true);
        var permintaan = document.querySelectorAll("[id^=cont]");
        
        for (let i = 0; i < permintaan.length; i++) {
            permintaan[i].setAttribute("readonly", true);
            permintaan[i].setAttribute("disabled", true);
        }
            
    }
    function batal() {
        var poID = $('input[name=poID]').val();
        $.ajax({
            type: "POST",
            url: "delete-purchaseorder.asp",
                data:{
                    poID
                },
            success: function (data) {
                Swal.fire('Deleted !!', data.message, 'success').then(() => {
                location.reload();
                });
            }
        });
        document.getElementById("cont-Produk-PO").style.display = "none";
        $('#bussinespartner').removeAttr('disabled');
        $('#bussinespartner').val('');
        var permintaan = document.querySelectorAll("[id^=cont]");
        
        for (let i = 0; i < permintaan.length; i++) {
            permintaan[i].removeAttribute("readonly");
            permintaan[i].removeAttribute("disabled");
            permintaan[i].value="";
        }
    }
    function statuspo(){
        var status = document.getElementById("statuspo").value;
        var poID = $('#poID').val();
        if (status == ""){
            alert("Status PO Masih Kosong !!!");
        }else {
            $.ajax({
                type: "POST",
                url: "update-purchaseorder.asp",
                data:{
                    poID,
                    status
                },
                success: function (data) {
                    document.getElementById("btn-listpo").style.display = "block";
                    document.getElementById("btn-cetakpo").style.display = "block";
                    document.getElementById("btn-selesai").style.display = "none";
                }
            });
        }
    }
        function getBussines(){
            var s = document.getElementById("bussinespartner").value;
            //console.log(s);
            
            $.ajax({
                type: "get",
                url: "get-Bussines.asp?bussines="+s,
                success: function (url) {
                // console.log(url);
                $('.cont-Bussines').html(url);
                                    
                }
            });
        }
        function tax(){
            var tax = document.getElementById("ppn").value;
            var qty = parseInt(document.getElementById("qtyproduk").value);
            var harga = parseInt(document.getElementById("harga").value);
            //console.log(tax);
            
            if( tax == "0" ){
                var total = Number(qty*harga);
                document.getElementById("subtotalpo").value = total;
                document.getElementById("totalpo").value = total;
                // console.log(total);
                
            }else{
                tax = 11;
                var total = Number(qty*harga);
                pajak = tax/100*total;
                subtotal = total+pajak;
                var grandtotal = Math.round(subtotal);
                document.getElementById("subtotalpo").value = total;
                document.getElementById("totalpo").value = grandtotal;
                // console.log(subtotal);
                
            }

        }
        function totalline(){
            var qty = parseInt(document.getElementById("qtyproduk").value);
            var harga = parseInt(document.getElementById("harga").value);
            var total = Number(qty*harga);
            document.getElementById("subtotalpo").value = total;
            // console.log(qty, harga, total);
        };
        document.addEventListener("DOMContentLoaded", function(event) {
            totalline();
        });
        function getproduk(){
            var pdID = document.getElementById("pdID").value;
            
            $.ajax({
                type: "get",
                url: "loadproduk.asp?pdID="+document.getElementById("pdID").value,
                success: function (url) {
                // console.log(url);
                $('.datapd').html(url);
                                    
                }
            });
        }

        function sendproduk(){
            var poID = $('#poID').val();
            var poTanggal = $('input[name=tanggalpo]').val();
            var po_pdID = $('#produkid').val();
            var poQtyProduk = $('#qtyproduk').val();
            var poPdUnit = $('#unitproduk').val();
            var poHarga = $('#hargabulat').val();
            var poPajak = $('#ppn').val();
            var poDiskon = $('#diskon').val();
            var poSubTotal = $('#subtotalpo').val();
            var poTotal = $('#totalpo').val();
            $.ajax({
                type: "get",
                url: "add-produkpo.asp",
                    data:{
                        poID,
                        poTanggal,
                        po_pdID,
                        poQtyProduk,
                        poPdUnit,
                        poHarga,
                        poPajak,
                        poDiskon,
                        poSubTotal,
                        poTotal
                    },
                success: function (data) {
                    document.getElementById("loader-page").style.display = "block";
                    setTimeout(() => {
                    document.getElementById("loader-page").style.display = "none";
                    
                        // Swal.fire({
                        //     title: 'Ingin Menambah Produk Lagi ?',
                        //     showDenyButton: true,
                        //     showCancelButton: true,
                        //     confirmButtonText: 'Iya',
                        //     denyButtonText: `Tidak`,
                        //     }).then((result) => {
                        //     if (result.isConfirmed) {
                        //         location.reload();
                        //     } else if (result.isDenied) {
                        //         window.open(`../PurchaseOrderDetail/buktipo.asp?poID=${poID}&tanggalpo=${poTanggal}`,`_Self`)
                        //     }
                        // })
                    }, 1000);
                    document.getElementById("katakunci").value = "";
                    document.getElementById("namaproduk").value = "";
                    document.getElementById("skuproduk").value = "";
                    document.getElementById("lokasirak").value = "";
                    document.getElementById("unitproduk").value = 0;
                    document.getElementById("harga").value = 0;
                    document.getElementById("qtyproduk").value = 0;
                    document.getElementById("ppn").value = "";
                    document.getElementById("subtotalpo").value = 0;
                    document.getElementById("totalpo").value = 0;
                    document.getElementById("diskon").value = "0";
                    document.getElementById("pdID").value = "";

                    $('.data-produk').html(data);
                }
            });
        }
        function aaa(){
            var bb = document.getElementById("calc").value;
            var c = Math.round(eval(bb));
                document.getElementById("harga").value = eval(c);
                document.getElementById("hargabulat").value = eval(c);
        }
        function openkalkulator(){
            var btnkal = document.getElementById("kalkulator");
            if(btnkal.checked == true){
                document.getElementById("cont-calculator-PO").style.display = "block";
            }else{
                document.getElementById("cont-calculator-PO").style.display = "none";
                document.getElementById("qtyproduk").value = 0;
                document.getElementById("subtotalpo").value = 0;
                document.getElementById("totalpo").value = 0;
            }
        }
        var dropdown = document.getElementsByClassName("dropdown-btn");
            var i;

            for (i = 0; i < dropdown.length; i++) {
                dropdown[i].addEventListener("click", function() {
                this.classList.toggle("active");
                var dropdownContent = this.nextElementSibling;
                if (dropdownContent.style.display === "block") {
                dropdownContent.style.display = "none";
                } else {
                dropdownContent.style.display = "block";
                }
            });
        }
        var modal = document.getElementById("myModal");
        var btn = document.getElementById("myBtn");
        var span = document.getElementsByClassName("closee")[0];
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
    </script>
</html>