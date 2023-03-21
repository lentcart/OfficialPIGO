<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    set PermintaanBarang_cmd = server.createObject("ADODB.COMMAND")
	PermintaanBarang_cmd.activeConnection = MM_PIGO_String

        PermintaanBarang_cmd.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.Perm_UpdateTime, MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_M_Customer.custID,  MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName,  MKT_M_BussinesPartner.bpNama1, MKT_T_Permintaan_Barang_H.Perm_trID FROM MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_M_BussinesPartner ON MKT_T_Permintaan_Barang_H.Perm_custID = MKT_M_BussinesPartner.bpID ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID ON  MKT_T_Transaksi_H.trID = MKT_T_Permintaan_Barang_H.Perm_trID LEFT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_Permintaan_Barang_D.Perm_IDH LEFT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A WHERE (MKT_T_Permintaan_Barang_H.Perm_AktifYN = 'Y') GROUP BY MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1,  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName, MKT_T_Permintaan_Barang_H.Perm_UpdateTime,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_M_BussinesPartner.bpNama1, MKT_T_Permintaan_Barang_H.Perm_trID  "
        'response.write PermintaanBarang_cmd.commandText 

    set PermintaanBarang = PermintaanBarang_cmd.execute

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
        function getKeySupplier(){
            $.ajax({
                type: "get",
                url: "get-bussinespartner.asp?keysearch="+document.getElementById("keysearch").value,
                success: function (url) {
                // console.log(url);
                $('.keysp').html(url);
                
                }
            });
        }
        function getsupplier(){
            $.ajax({
                type: "get",
                url: "load-bussinespartner.asp?keysupplier="+document.getElementById("keysupplier").value,
                success: function (url) {
                // console.log(url);
                $('.datasp').html(url);
                                    
                }
            });
        }
        function tambah(){
            document.getElementById("cont-addpermintaan").style.display = "block"
            document.getElementById("cont-data").style.display = "none"
            document.getElementById("btn-add").style.display = "none"
        }
    </script>
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-9 col-md-9 col-sm-12">
                        <span class="cont-text"> PERMINTAAN BARANG KELUAR </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button onclick="tambah()" name="btn-add" id="btn-add" class="cont-btn" style="display:block"><i class="fas fa-plus"></i> &nbsp;&nbsp; Tambah  </button> 
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="cont-addpermintaan mb-2" id="cont-addpermintaan"  style="display:block">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <span class="cont-text"> Tujuan Permintaan  </span><br>
                            <select class="cont-form" name="PermTujuan" id="cont" aria-label="Default select example" required>
                                <option value="1">Penjualan</option>
                                <option value="2">Kebutuhan Kantor</option>
                            </select>
                        </div>
                        <div class="col-lg-4 col-md-8 col-sm-8">
                            <span class="cont-text"> No Purchase Order  </span><br>
                            <input  type="Text" class="cont-form" name="PermNo" id="cont" value=""><br>
                        </div>
                        <div class="col-lg-2 col-md-6 col-sm-6">
                            <span class="cont-text"> Tanggal PO  </span><br>
                            <input  type="Date" class="cont-form" name="PermTanggal" id="cont" value=""><br>
                        </div>
                        <div class="col-lg-2 col-md-6 col-sm-6">
                            <span class="cont-text"> Jenis PO  </span><br>
                            <select class="cont-form" name="PermJenis" id="cont" aria-label="Default select example" required>
                                <option value="1">Slow Moving</option>
                                <option value="2">Fash Moving</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mt-3 text-center">
                        <div class="col-12">
                            <div class="cont-label-text">
                                <span class="cont-text"> Bussines Partner </span>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-2">
                        <div class="col-lg-2 col-md-4 col-sm-3">
                            <span class="cont-text"> Kata Kunci </span><br>
                            <input onkeyup="return getKeySupplier()"type="text" class="cont-form" name="keysearch" id="keysearch" value=""><br>
                        </div>
                        <div class="col-lg-4 col-md-8 col-sm-9 keysp">
                            <span class="cont-text"> </span><br>
                            <select onchange="return getsupplier()"  class="cont-form" name="keysupplier" id="keysupplier" aria-label="Default select example" required>
                                <option value="">Pilih Bussines Partner</option>
                                <option value=""></option>
                            </select>
                        </div>
                    </div>

                    <div class="datasp">
                        <div class="row mt-1">
                            <div class="col-lg-2 col-md-4 col-sm-3">
                                <span class="cont-text">  Bussines Partner ID </span><br>
                                <input readonly type="text" class="cont-form" name="supplierid" id="supplierid" value="" ><br>
                            </div>
                            <div class="col-lg-4 col-md-8 col-sm-9">
                                <span class="cont-text"> Nama Bussines Partner </span><br>
                                <input readonly type="text" class="cont-form" name="namasupplier" id="namasupplier" value="" ><br>
                            </div>
                            <div class="col-lg-2 col-md-6 col-sm-6">
                                <span class="cont-text">  Phone </span><br>
                                <input readonly type="text" class="cont-form" name="supplierid" id="supplierid" value="" ><br>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <span class="cont-text"> Nama CP </span><br>
                                <input readonly type="text" class="cont-form" name="namasupplier" id="namasupplier" value="" ><br>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <span class="cont-text">  Alamat </span><br>
                                <input readonly type="text" class="cont-form" name="supplierid" id="supplierid" value="" ><br>
                            </div>
                            <div class="col-lg-4 col-md-3 col-sm-6">
                                <span class="cont-text"> Kota </span><br>
                                <input readonly type="text" class="cont-form" name="namasupplier" id="namasupplier" value="" ><br>
                            </div>
                            <div class="col-lg-2 col-md-3 col-sm-6">
                                <span class="cont-text">  NPWP </span><br>
                                <input readonly type="text" class="cont-form" name="supplierid" id="supplierid" value=""><br>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <button name="btn-tambah" id="btn-tambah" onclick="AddBussinesPart()" class="cont-btn label-po" style="display:block;"><i class="fas fa-folder-plus"></i> &nbsp;&nbsp; Generate Data Permintaan  </button>
                            
                            <button name="btn-batal" id="btn-batal" onclick="batal()" class="cont-btn label-po"style="display:none;"><i class="fas fa-folder-plus"></i> &nbsp; Batalkan Permintaan </button>
                        </div>
                    </div>

                    <div class="data-permintaan" id="data-permintaan">
                    
                    </div>

                    <div class="cont-produk-permintaan mt-2" id="cont-tambahproduk" style="display:block">
                        <div class="row mt-2 ">
                            <div class="col-lg-3 col-md-6 col-sm-12">
                                <span class="cont-text"> Kategori Produk </span><br>
                                <select disabled="true" onchange="addkategori()" class="cont-form" name="kategori" id="kategori" aria-label="Default select example" required>
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
                            <div class="row mt-2">
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <span class="cont-text"> ID Produk </span><br>
                                    <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                                </div>
                                <div class="col-lg-6 col-md-8 col-sm-8">
                                    <span class="cont-text"> Detail Produk </span><br>
                                    <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-6">
                                    <span class="cont-text"> Type Part </span><br>
                                    <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-6">
                                    <span class="cont-text"> Lokasi Rak </span><br>
                                    <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-lg-2 col-md-6 col-sm-6">
                                    <span class="cont-text"> Harga Beli Produk </span><br>
                                    <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-4">
                                    <span class="cont-text"> Up To (%) </span><br>
                                    <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-4">
                                    <span class="cont-text"> TAX (PPN) </span><br>
                                    <select disabled onchange="tax()" class=" cont-form" name="ppn" id="ppn" aria-label="Default select example" required>
                                        <option value="">Tax (PPN)</option>
                                        <% do while not Tax.eof %>
                                        <option value="<%=Tax("TaxRate")%>"><%=Tax("TaxNama")%></option>
                                        <% Tax.movenext
                                        loop %>
                                    </select>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-4">
                                    <span class="cont-text"> Harga Jual </span><br>
                                    <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-6">
                                    <span class="cont-text"> QTY Permintaan </span><br>
                                    <input readonly type="text" class="  cont-form" name="pdpermintaan" id="prodpenawaran" value="" ><br>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-12">
                                    <span class="cont-text"> </span><br>
                                    <button  class="cont-btn"> Tambah Produk </button>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="cont-tb " style="overflow:scroll; height:23rem">
                                    <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                                        <thead class="text-center">
                                            <tr>
                                                <th>No</th>
                                                <th> ID Produk </th>
                                                <th> Detail </th>
                                                <th> QTY </th>
                                                <th> Harga </th>
                                                <th> Aksi </th>
                                            </tr>
                                        </thead>
                                        <tbody class="data-produkpermintaan">
                                                            
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
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script>
        function AddBussinesPart() {
            var a = document.getElementById("cont").value;
            var PermNo = $('input[name=PermNo]').val();
            var PermTanggal = $('input[name=PermTanggal]').val();
            var PermTujuan  = $('select[name=PermTujuan]').val();
            var PermJenis  = $('select[name=PermJenis]').val();
            var Perm_custID = $('input[name=supplierid]').val();
                    $.ajax({
                    type: "GET",
                    url: "add-permintaan.asp",
                    data:{
                        PermNo,
                        PermTanggal,
                        PermTujuan,
                        PermJenis,
                        Perm_custID
                    },
                    success: function (data) {
                        console.log(data);
                        $('.data-permintaan').html(data);
                    }
                });
            
            document.getElementById("btn-tambah").style.display = "none"
            document.getElementById("btn-batal").style.display = "block"
            document.getElementById("cont-tambahproduk").style.display = "block"
            // document.getElementById("cont-Produk-PO").style.display = "block";
            $('#keysupplier').attr('disabled',true);
            $('#kategori').attr('disabled',false);
            $('#keysearch').attr('disabled',true);
            var permintaan = document.querySelectorAll("[id^=cont]");
            
            for (let i = 0; i < permintaan.length; i++) {
                permintaan[i].setAttribute("readonly", true);
                permintaan[i].setAttribute("disabled", true);
            }
                
        }

    function batal() {
        var permID = $('input[name=permID]').val();
        $.ajax({
            type: "POST",
            url: "delete-permintaan.asp",
                data:{
                    permID
                },
            success: function (data) {
                Swal.fire('Deleted !!', data.message, 'success').then(() => {
                    location.reload();
                });
            }
        });
        document.getElementById("btn-tambah").style.display = "block"
        document.getElementById("btn-batal").style.display = "none"
        document.getElementById("cont-tambahproduk").style.display = "none"
        $('#keysupplier').removeAttr('disabled');
        $('#keysupplier').val('');
        $('#keysearch').removeAttr('disabled');
        $('#keysearch').val('');
        var permintaan = document.querySelectorAll("[id^=cont]");
        
        for (let i = 0; i < permintaan.length; i++) {
            permintaan[i].removeAttribute("readonly");
            permintaan[i].removeAttribute("disabled");
            permintaan[i].value = "";
        }
    }
    function tambahproduk() {
            var Perm_IDH   = $('input[name=permID]').val();
            var Perm_pdID   = $('input[name=pdid]').val();
            var Perm_pdQty  = $('input[name=pdQty]').val();
            var Perm_pdHarga    = $('input[name=harga]').val();
            var Perm_pdUpTo    = $('input[name=upto]').val();
            var Perm_pdPPN    = $('select[name=ppn]').val();
            console.log(Perm_pdQty);
            $.ajax({
                type: "GET",
                url: "add-produk.asp",
                data:{
                    Perm_IDH,
                    Perm_pdID,
                    Perm_pdQty,
                    Perm_pdHarga,
                    Perm_pdUpTo,
                    Perm_pdPPN
                },
                success: function (data) {
                    console.log(data);
                    $('.data-produkpermintaan').html(data);
                }
            });
            var permintaan = document.querySelectorAll("[id^=pd]");
        
            for (let i = 0; i < permintaan.length; i++) {
                permintaan[i].value="";
            }
        }
        function updatebtn(){
            document.getElementById("caripo").disabled = false
            document.getElementById("jenispo").disabled = false
            document.getElementById("namapd").disabled = false
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
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>