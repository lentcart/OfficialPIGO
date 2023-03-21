<!--#include file="../../../../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../../../../admin/")
    
    end if
    
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

    Produk_cmd.commandText = "SELECT pdID, pdNama, pdPartNumber, pdLokasi FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y' "
    'response.write Produk_cmd.commandText
    set Produk = Produk_cmd.execute

    set Stok_CMD = server.createObject("ADODB.COMMAND")
	Stok_CMD.activeConnection = MM_PIGO_String
    set Stok_cmd = server.createObject("ADODB.COMMAND")
	Stok_cmd.activeConnection = MM_PIGO_String

	Stok_cmd.commandText = " SELECT pdTypeProduk FROM MKT_M_PIGO_Produk Where pdAktifYN = 'Y' GROUP BY pdTYpeProduk"
    set TypePD = Stok_cmd.execute

	Stok_cmd.commandText = " SELECT  pdTypePart FROM MKT_M_PIGO_Produk Where pdAktifYN = 'Y' GROUP BY pdTypePart"
    set TypePART = Stok_cmd.execute

    set kategori_cmd = server.createObject("ADODB.COMMAND")
    kategori_cmd.activeConnection = MM_PIGO_String
    kategori_cmd.commandText = "SELECT catID, catName From MKT_M_Kategori WHERE catAktifYN = 'Y' "
    'response.write kategori_cmd.commandText
    set kategori = kategori_cmd.execute 
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        <title>Oficial PIGO</title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">
    </head>
    <script>
        function kategori(){
            var kategori = document.getElementById("kategori").value;
            if( kategori == "" ){
                $('#namaproduk').prop("disabled", true);;
            }else{
                $('#namaproduk').prop("disabled", false);;
            }
        }
    </script>
    <style>
        .proseskartustok{
            display:block;
        }
        .periodekartustok{
            display:none;
        }
    </style>
    <!--#include file="../../../loaderpage.asp"-->
<body>
    <div class="navigasi" style="margin:20px;">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb ">
                <li class="breadcrumb-item me-1"><a href="<%=base_url%>/Admin/home.asp"style="color:white" >DASHBOARD</a></li>
                <li class="breadcrumb-item me-1"><a href="../index.asp" style="color:white">LAPORAN STOK</a></li>
                <li class="breadcrumb-item me-1"style="background-color:#aaa;"><a href="index.asp" style="color:white">KARTU STOK</a></li>
            </ol>
        </nav>
    </div>
    <div class="cont-laporan">
        <div class="cont-laporan-detail">
            <div class="row">
                <div class="col-6">
                    <span class="breadcrumb-item cont-text"> KARTU STOK KESELURUHAN </span><br>
                    <div class="row mt-2">
                        <div class="col-3">
                            <span class="cont-text"> Tanggal </span><br>
                            <input onchange="getdata()"  class="text-center cont-form" type="date" name="tgla" id="tgla" value="">
                        </div>
                        <div class="col-3">
                            <br>
                            <input onchange="getdata()"  class="text-center cont-form" type="date" name="tgle" id="tgle" value="">
                        </div>
                        <div class="col-6">
                            <br>
                            <select onchange="getdata(),kategori()"  name="kategori" id="kategori" class="cont-form" aria-label="Default select example">
                                <option value=""> Pilih Kategori Produk </option>
                                <% do while not kategori.eof %>
                                <option value="<%=kategori("catID")%>"><%=kategori("catName")%></option>
                                <% kategori.movenext
                                loop %>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-6">
                            <select onchange="getdata()" class="cont-form" name="typeproduk" id="typeproduk" aria-label="Default select example">
                                <option value=""> Pilih Type Produk</option>
                                <% do while not TypePD.eof %>
                                <option value="<%=TypePD("pdTypeProduk")%>"> <%=TypePD("pdTypeProduk")%> </option>
                                <% TypePD.movenext
                                loop %>
                            </select>
                        </div>
                        <div class="col-6">
                            <select onchange="getdata()" class="cont-form" name="typepart" id="typepart" aria-label="Default select example">
                                <option value=""> Pilih Type Part </option>
                                <% do while not TypePART.eof %>
                                <option value="<%=TypePART("pdTypePart")%>"> <%=TypePART("pdTypePart")%> </option>
                                <% TypePART.movenext
                                loop %>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <button class="cont-btn" onclick="window.open('Kartu-Stok.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&typeproduk='+document.getElementById('typeproduk').value+'+&typepart='+document.getElementById('typepart').value,'_Self')"><i class="fas fa-file"></i> &nbsp; Kartu Stok</button>
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <span class="breadcrumb-item cont-text"> KARTU STOK /PRODUK </span><br>
                    <div class="proseskartustok">
                        <div class="row align-items-center mt-2">
                            <div class="col-3">
                                <span class="cont-text"> Periode Tanggal </span>
                                <input type="date" class="cont-form" name="tanggala" id="tanggala" value="" >
                            </div>
                            <div class="col-3">
                            <br>
                                <input type="date" class="cont-form" name="tanggale" id="tanggale" value="" >
                            </div>
                            <div class="col-3">
                            <br>
                                <select class="cont-form" name="periode" id="periode">
                                    <option value="">Pilih Periode</option>
                                    <option value="1">Hari</option>
                                    <option value="2">Bulan</option>
                                </select>
                            </div>
                            <div class="col-3">
                            <br>
                                <button onclick="return PKartuStok()"class="cont-btn"> Proses Kartu Stok </button>
                            </div>
                        </div>
                    </div>
                    <div class="periodekartustok">
                        <div class="row  text-center align-items-center mt-4">
                            <div class="col-12 text-center"  id="pKartuStok">
                            </div>
                        </div>
                        <div class="row align-items-center mt-1" id="periodekartustok">
                            <div class="col-3">
                            <br>
                                <select class="cont-form" name="periodeks" id="periodeks">
                                    <option value="">Pilih Periode</option>
                                    <option value="1">Hari</option>
                                    <option value="2">Bulan</option>
                                </select>
                            </div>
                            <div class="col-3">
                            <br>
                                <input type="date" class="cont-form" name="tanggalks" id="tanggalks" value="" >
                            </div>
                            <div class="col-3">
                            <br>
                                <input type="date" class="cont-form" name="tanggalks" id="tanggalks" value="" >
                            </div>
                            <div class="col-3">
                            <br>
                                <button class="cont-btn"> Kartu Stok /Produk</button>
                            </div>
                        </div>
                        <div class="row align-items-center mt-3" id="periodekartustok">
                            <div class="col-3">
                                <span class="cont-text"> Nama Produk </span>
                            </div>
                            <div class="col-9">
                                <input onkeyup="GetProdukNama()" class="cont-form" type="text" name="pdNama" id="pdNama" value="" style="width:100%">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="cont-produk">
            <div class="row d-flex flex-row-reverse p-1">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <table class="align-items-center cont-tb table tb-transaksi table-bordered">
                        <thead>
                            <tr class="text-center">
                                <th>NO</th>
                                <th>ID PRODUK</th>
                                <th>DETAL PRODUK</th>
                                <th>STOK</th>
                                <th>PEMBELIAN</th>
                                <th>PENJUALAN</th>
                                <th>SISA</th>
                                <th>RAK</th>
                            </tr>
                        </thead>
                        <tbody class="KartuStokTable">
                            <% 
                                no = 0
                                do while not Produk.eof 
                                no = no + 1
                            %>
                            <tr>
                                <td class="text-center"> <%=no%> </td>
                                <td class="text-center"> <%=Produk("pdID")%> </td>
                                <td>
                                    [<i><%=Produk("pdPartNumber")%></i>] <%=Produk("pdNama")%>
                                    <input type="hidden" name="pdID" id="pdID<%=Produk("pdID")%>" value="<%=Produk("pdID")%>">
                                </td>
                                <%
                                        Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_M_Stok.st_pdQty), 0) AS SaldoAwal, ISNULL(MKT_M_Stok.st_pdHarga,0) AS HargaSaldoAwal FROM MKT_M_PIGO_Produk INNER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE MKT_M_PIGO_Produk.pdID = '"& Produk("pdID") &"' GROUP BY MKT_M_Stok.st_pdHarga"
                                        'response.write Stok_CMD.commandText &"<br>"
                                        set SaldoAwal = Stok_CMD.execute
                                    %>
                                <td class="text-center"><%=SaldoAwal("SaldoAwal")%></td>
                                <%
                                        Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian, ISNULL(MKT_M_PIGO_Produk.pdHarga, 0) AS HargaPembelian FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE  pdID = '"& Produk("pdID") &"' GROUP BY MKT_M_PIGO_Produk.pdHarga"
                                        'response.write Stok_CMD.commandText &"<br>"
                                        set SaldoMasuk = Stok_CMD.execute
                                    %>
                                    <td class="text-center"> <%=SaldoMasuk("Pembelian")%> </td>
                                    <%
                                        Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty),0) AS Penjualan, ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdHargaJual,0) AS HargaPenjualan FROM MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_Permintaan_Barang_D.Perm_IDH RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID WHERE MKT_M_PIGO_Produk.pdID = '"& Produk("pdID") &"' GROUP BY MKT_T_Permintaan_Barang_D.Perm_pdHargaJual    "
                                        'response.write Stok_CMD.commandText &"<br>"
                                        set SaldoKeluar = Stok_CMD.execute
                                    %>
                                    <td class="text-center"> <%=SaldoKeluar("Penjualan")%> </td>
                                    <%
                                        Sisa = SaldoAwal("SaldoAwal")+SaldoMasuk("Pembelian")-SaldoKeluar("Penjualan")
                                    %>
                                    <td class="text-center"> <%=Sisa%></td>
                                <td class="text-center"><%=Produk("pdLokasi")%></td>
                            </tr>
                            <% 
                                Produk.movenext
                                loop
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>
        function getdata(){
            var tgla = document.getElementById("tgla").value;
            var tgle = document.getElementById("tgle").value;
            var typeproduk = document.getElementById("typeproduk").value;
            var typepart   = document.getElementById("typepart").value;
            var kategori   = document.getElementById("kategori").value;
            var namapd     = document.getElementById("namaproduk").value;
            $.ajax({
                type: "get",
                url: "load-stok.asp",
                data : 
                {
                    tgla,
                    tgle,
                    typeproduk,
                    typepart,
                    kategori,
                    namapd
                },
                success: function (data) {
                    $('.cont-produk').html(data);
                }
            });
        }
        function PKartuStok(){
            var Tanggala = document.getElementById("tanggala").value;
            var Tanggale = document.getElementById("tanggale").value;
            var periode  = document.getElementById("periode").value;
            console.log(periode);
            if ( Tanggala == "" ){
                alert("Tanggal Kosong")
            } else {
                if ( periode == "") {
                    alert("Pilih Periode Kartu Stok !");
                }else if ( periode == "1") {
                    $.ajax({
                        type: "GET",
                        url: "Bulan.asp",
                        data : {
                            Tanggala,
                            Tanggale
                        },
                        success: function (data) {
                            $('#pKartuStok').append('<span class="breadcrumb-item cont-text"> Proses Kartu Stok Berhasil ! </span><br>');
                            $(".proseskartustok").hide();
                            $(".periodekartustok").show();
                        }
                    });
                } else {
                    $.ajax({
                        type: "GET",
                        url: "ProsesBulan.asp",
                        data : {
                            Tanggala,
                            Tanggale
                        },
                        success: function (data) {
                            $('#pKartuStok').append('<span class="breadcrumb-item cont-text"> Proses Kartu Stok Berhasil ! </span><br>');
                            $(".proseskartustok").hide();
                            $(".periodekartustok").show();
                        }
                    });
                }
            }
            
        }

        function GetProdukNama(){
            var pdNama = document.getElementById("pdNama").value;
            $.ajax({
                type: "GET",
                url: "getProduk.asp",
                data : {
                    pdNama
                },
                success: function (data) {
                    $('.KartuStokTable').html(data);
                }
            });
        }
    </script>
</html>