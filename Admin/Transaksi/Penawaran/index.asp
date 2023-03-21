<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    set KeyProduk_cmd = server.createObject("ADODB.COMMAND")
	KeyProduk_cmd.activeConnection = MM_PIGO_String

        KeyProduk_cmd.commandText = "SELECT pdKey FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y' group by pdKey "
        'response.write KeyProduk_cmd.commandText

    set KeyProduk = KeyProduk_cmd.execute

    set Kategori_cmd = server.createObject("ADODB.COMMAND")
	Kategori_cmd.activeConnection = MM_PIGO_String

        Kategori_cmd.commandText = "Select * From MKT_M_Kategori Where catAktifYN = 'Y' Order BY catName ASC "
        'response.write Kategori_cmd.commandText

    set Kategori = Kategori_cmd.execute

    set Merk_cmd = server.createObject("ADODB.COMMAND")
	Merk_cmd.activeConnection = MM_PIGO_String

        Merk_cmd.commandText = "Select * From MKT_M_Merk "
        'response.write Merk_cmd.commandText

    set Merk = Merk_cmd.execute

    set Tax_CMD = server.createObject("ADODB.COMMAND")
	Tax_CMD.activeConnection = MM_PIGO_String

    Tax_CMD.commandText = "SELECT * FROM MKT_M_Tax Where TaxAktifYN = 'Y' "
    'Response.Write Tax_CMD.commandText & "<br>"

    set Tax = Tax_CMD.execute

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
            function getbussinespart(){
                var Bussines = $('input[name=keysearch]').val();            
                $.ajax({
                    type: "get",
                    url: "get-bussinespart.asp?keysearch="+Bussines,
                    success: function (url) {
                    // console.log(url);
                    $('.cont-bussinespart').html(url);
                    }
                });
            }
            function getKeyProduk(){
                $.ajax({
                    type: "get",
                    url: "get-produk.asp?katakunci="+document.getElementById("katakunci").value,
                    success: function (url) {
                    // console.log(url);
                    $('.dataproduk').html(url);
                                        
                    }
                });
            }
            
        </script>
        <style>
            #new-customer{
                display:block;
            }
            .cont-label-text:hover{
                background:#aaa;
                color:white;
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
                    <div class="col-lg-8 col-md-8 col-sm-12">
                        <span class="cont-text"> FORM PENAWARAN PRODUK </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn" > <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-12">
                        <button onclick="window.open('List-Penawaran.asp','_Self')" class="cont-btn" > LIST PENAWARAN PRODUK </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-8">
                        <span class="cont-text"> No Permintaan </span><br>
                        <input  type="text" class="nopermintaan mb-2 cont-form" name="nopermintaan" id="cont" value=""><br>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-4">
                        <span class="cont-text"> Tanggal Permintaan  </span><br>
                        <input  type="Date" class="tglpermintaan mb-2 cont-form" name="tglpermintaan" id="cont" value=""><br>
                    </div>
                </div>
                
                <div class="row mt-1 mb-2  align-items-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                    <div class="form-check">
                        <input onchange="newcustomer()" class="form-check-input" type="checkbox" value="" name="new-customer" id="new-customer">
                            <label class="cont-text form-check-label" for="new-customer" id="label-text">
                                New Bussines Partner (Customer)
                            </label>
                        </div>
                    </div>
                </div>
                <div class="cont-new-customer" id="cont-new-customer" style="display:none">
                    
                </div>
                <div class="cont-customer" id="cont-customer" style="display:block">
                    <div class="row mt-1">
                        <div class="col-lg-2 col-md-2 col-sm-12">
                            <span class="cont-text"> Kata Kunci </span><br>
                            <input onkeyup="getbussinespart()" required type="text" class="keysearch cont-form" name="keysearch" id="cont" value=""><br>
                        </div>
                        <div class="col-lg-4 col-md-10 col-sm-12 cont-bussinespart">
                        <span class="cont-text">  </span><br>
                            <select onchange="return getbussines()"  class=" cont-form" name="bussines" id="bussines" aria-label="Default select example" required>
                                <option value="">Pilih Bussines Partner</option>
                                <option value=""></option>
                            </select>
                        </div>
                    </div>

                    <div class="cont-bussines">
                        <div class="row mt-1">
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <span class="cont-text"> Nama Supplier </span><br>
                                <input readonly type="text" class="cont-form" name="namacust" id="cont" value="" ><br>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6">
                                <span class="cont-text"> Phone </span><br>
                                <input readonly type="text" class="cont-form" name="phonecust" id="cont" value="" ><br>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6">
                                <span class="cont-text"> Email </span><br>
                                <input readonly type="text" class="cont-form" name="emailcust" id="cont" value=""><br>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <span class="cont-text"> Lokasi Bussines Partner </span><br>
                                <input readonly type="text" class="cont-form" name="alamatlengkap" id="cont" value="" ><br>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6">
                                <span class="cont-text"> Kota </span><br>
                                <input readonly type="text" class="cont-form" name="kota" id="cont" value="" ><br>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6">
                                <span class="cont-text"> Nama Contact Person  </span><br>
                                <input readonly type="text" class="cont-form" name="namacp" id="cont" value="" ><br>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-4 mb-4">
                    <div class="col-lg-3 col-md-12 col-sm-12 data-pshID">
                        <button onclick="tambah()"class="cont-btn" name="btn-add" id="btn-add" style="display:block"><i class="fas fa-folder-plus"></i> Tambah Produk Permintaan </button>
                    </div>
                </div>

                <div class="cont-produk-permintaan mt-2" id="cont-permintaan" style="display:none">
                    <div class="row mt-2 ">
                        <div class="col-lg-3 col-md-6 col-sm-12">
                            <span class="cont-text"> Kategori Produk </span><br>
                            <select onchange="addkategori()" class="cont-form" name="kategori" id="kategori" aria-label="Default select example" required>
                                <option value="">Pilih Kategori</option>
                                <% do while not Kategori.eof %>
                                <option value="<%=Kategori("catID")%>"><%=Kategori("CatName")%></option>
                                <% Kategori.movenext
                                loop%>
                            </select>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-12">
                            <span class="cont-text"> Merk Produk </span><br>
                            <select onchange="getPartNumber()" disabled="true" class="cont-form" name="merk" id="merk" aria-label="Default select example" required>
                                <% do while not Merk.eof %>
                                <option value="<%=Merk("mrID")%>"><%=Merk("mrNama")%></option>
                                <% Merk.movenext
                                loop%>
                            </select>
                        </div>
                        <div class="col-lg-6 col-md-12 col-sm-12 data-partnumber">
                            <span class="cont-text">Produk </span><br>
                            <input  disabled="true"  type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" >
                        </div>
                    </div>
                    <div class="cont-dataproduk">
                        <div class="row mt-3">
                            <div class="col-lg-2 col-md-4 col-sm-4">
                                <span class="cont-text"> ID Produk </span><br>
                                <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                            </div>
                            <div class="col-lg-6 col-md-8 col-sm-8">
                                <span class="cont-text"> Detail Produk </span><br>
                                <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                            </div>
                            <div class="col-lg-2 col-md-6 col-sm-6">
                                <span class="cont-text"> Type Produk </span><br>
                                <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                            </div>
                            <div class="col-lg-2 col-md-6 col-sm-6">
                                <span class="cont-text"> Type Part </span><br>
                                <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-lg-3 col-md-6 col-sm-6">
                                <span class="cont-text"> Lokasi Rak </span><br>
                                <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-6">
                                <span class="cont-text"> Harga Beli Produk </span><br>
                                <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-4">
                                <span class="cont-text"> Harga Jual </span><br>
                                <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-12">
                                <span class="cont-text"> </span><br>
                                <button onclick="return tambahproduk()" class="cont-btn"> Tambah Produk </button>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="cont-tb " style="overflow:scroll; height:23rem">
                                <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                                    <thead class="text-center">
                                        <tr>
                                            <th> No </th>
                                            <th> Detail Produk </th>
                                            <th> Harga Beli </th>
                                            <th> PPN (%) </th>
                                            <th> UpTo (%) </th>
                                            <th> Harga Jual</th>
                                        </tr>
                                    </thead>
                                    <tbody class="data-produkpenawaran">
                                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="row  mt-2 align-items-center">
                        <div class="col-6 text-start">
                            <div class="cony-save" style="margin-top:1.2rem">
                                <button onclick="window.open('List-Penawaran.asp','_Self')"class="cont-btn" style="width:12rem"> Selesai </button>
                            </div>
                        </div>
                        <!--<div class="col-6">
                            <div class="cony-save" style="margin-top:1.2rem">
                                <button onclick="window.open('cetak-suratpenawaran.asp?pshID='+document.getElementById('pshID').value,'_Self')"class="cont-btn" style="width:12rem"> Cetak Surat Penawaran </button>
                            </div>
                        </div>-->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
    <script>
    function tambah() {
        var bussines = $('input[name=keysearch]').val();  
        var nopermintaan =$('input[name=nopermintaan]').val();
        var tglpermintaan = $('input[name=tglpermintaan]').val();
        var namacust = $('input[name=namacust]').val();
        var phonecust = $('input[name=phonecust]').val();
        var emailcust = $('input[name=emailcust]').val();
        var alamatlengkap = $('input[name=alamatlengkap]').val();
        var kota = $('input[name=kota]').val();
        var namacp = $('input[name=namacp]').val();
        if ( nopermintaan == "" ){
            $('.nopermintaan').focus();
        }else if (tglpermintaan == "" ) {
            $('.tglpermintaan').focus();
        }else if ( bussines == "" ){
            $('.keysearch').focus();
        }else{

            $.ajax({
                type: "GET",
                url: "add-penawaran.asp",
                    data:{
                            nopermintaan,
                            tglpermintaan,
                            namacust,
                            phonecust,
                            emailcust,
                            alamatlengkap,
                            kota,
                            namacp
                        },
                    success: function (data) {
                        $('.data-pshID').html(data);
                        }
                    });
            document.getElementById("cont-permintaan").style.display = "block";
            document.getElementById("btn-add").style.display = "none";
            $('#bussinespartner').attr('disabled',true);
            var permintaan = document.querySelectorAll("[id^=cont]");
            for (let i = 0; i < permintaan.length; i++) {
                permintaan[i].setAttribute("readonly", true);
            }
        }
    }

    function tambahproduk() {
        var pshID =$('input[name=pshID]').val();
        var pdID =$('input[name=pdid]').val();
        var pdHargaBeli =$('input[name=harga]').val();
        var pdTax = $('input[name=ppn]').val();
        var pdUpTo = $('input[name=upto]').val();
        var pdHargaJual = $('input[name=hargajual]').val();
        $.ajax({
            type: "GET",
            url: "add-produk.asp",
            data:{
                pshID,
                pdID,
                pdHargaBeli,
                pdTax,
                pdUpTo,
                pdHargaJual
            },
            success: function (data) {
                $('.data-produkpenawaran').html(data);
                document.getElementById("merk").value = ""
                document.getElementById("partnumber").value = ""
                document.getElementById("pdid").value = ""
                document.getElementById("pdnama").value = ""
                document.getElementById("pdtypeproduk").value = ""
                document.getElementById("typepart").value = ""
                document.getElementById("pdlokasi").value = ""
                document.getElementById("hargabeli").value = ""
                document.getElementById("upto").value = ""
                document.getElementById("ppn").value = ""
                document.getElementById("pdhargajual").value = ""
            }
        });
    }

    function batal() {
        var pshID = $('input[name=pshID]').val();
        $.ajax({
            type: "POST",
            url: "delete-penawaran.asp",
                data:{
                    pshID
                },
            success: function (data) {
                Swal.fire('Deleted !!', data.message, 'success').then(() => {
                location.reload();
                });
            }
        });
        document.getElementById("cont-permintaan").style.display = "none";
        $('#bussinespartner').removeAttr('disabled');
        $('#bussinespartner').val('');

        var permintaan = document.querySelectorAll("[id^=cont]");
        for (let i = 0; i < permintaan.length; i++) {
            permintaan[i].removeAttribute("readonly");
            permintaan[i].value = "";
        }
    }
    function newcustomer(){
        var newcustomer = document.getElementById("new-customer")
        if(newcustomer.checked == true){
                document.getElementById('label-text').setAttribute('style', 'color: red')
                document.getElementById("cont-new-customer").style.display = "block";
                $.ajax({
                    type: "GET",
                    url: "add-newcustomer.asp",
                    success: function (url) {
                        $('.cont-new-customer').html(url);
                    }
                });
                document.getElementById("cont-customer").style.display = "none";
            }else{
                document.getElementById('label-text').setAttribute('style', 'color: black')
                document.getElementById("cont-new-customer").style.display = "none";
                document.getElementById("cont-customer").style.display = "block";
            }
    }

    function addkategori(){
        var kategori = document.getElementById("kategori").value;
        if(kategori == ""){
            document.getElementById("merk").disabled = true;
        }else{
            document.getElementById("merk").disabled = false;
        }
    }

    function getPartNumber(){
        var pdkategori = document.getElementById("kategori").value;
        var pdmerk = document.getElementById("merk").value;
        $.ajax({
            type: "GET",
            url: "get-produk.asp",
            data:{
                pdkategori,
                pdmerk
            },
            success: function (data) {
                $('.data-partnumber').html(data);
            }
        });
    }

    function getproduk(){
        var pdpartnumber = document.getElementById("partnumber").value;
        $.ajax({
            type: "get",
            url: "load-produk.asp",
            data:{
                pdpartnumber
            },
            success: function (data) {
            $('.cont-dataproduk').html(data);
                                        
            }
        });
    }
    

    function tax(){
        var tax = document.getElementById("ppn").value;
        var harga = parseInt(document.getElementById("harga").value);
        if( tax == "0" ){
            var total = Number(qty*harga);
            document.getElementById("subtotalpo").value = total;
            document.getElementById("totalpo").value = total;
        }else{
            tax = 11;
            var total = Number(qty*harga);
            pajak = tax/100*total;
            subtotal = total+pajak;
            var grandtotal = Math.round(subtotal);
            document.getElementById("subtotalpo").value = total;
            document.getElementById("totalpo").value = grandtotal;
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
        var dropdown = document.getElementsByClassName("cont-dp-btn");
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
        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })

        function validasiEmailcp() {
            var cp =  $('input[name=emailcust]').val();
            var atpss=cp.indexOf("@");
            var dotss=cp.lastIndexOf(".");
            if (atpss<1 || dotss<atpss+2 || dotss+2>=cp.length) {
                Swal.fire({
                    text: 'Alamat Email Tidak Valid !'
                });
                $('input[name=emailcust]').val('');
                return false;
            } 
        }
        /* Dengan Rupiah */
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
</html>