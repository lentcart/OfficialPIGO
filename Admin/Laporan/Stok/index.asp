<!--#include file="../../../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String
    Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal,  MKT_M_Stok.st_pdHarga AS HargaAwal, MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') GROUP BY MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty,  MKT_M_Stok.st_pdHarga, MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo"
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
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="navigasi" style="margin:20px;">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb ">
                <li class="breadcrumb-item me-1">
                <a href="<%=base_url%>/Admin/home.asp"style="color:white" >DASHBOARD</a></li>
                <li class="breadcrumb-item me-1"style="background-color:#aaa;"><a href="index.asp" style="color:white">LAPORAN STOK</a></li>
                <li class="breadcrumb-item me-1"><a href="Kartu-Stok/" style="color:white">KARTU STOK</a></li>
            </ol>
        </nav>
    </div>
    <div class="cont-laporan">
        <div class="cont-laporan-detail">
            <div class="row">
                <div class="col-4">
                    <span class="cont-text"> Periode Laporan </span><br>
                </div>
                <div class="col-2">
                    <span class="cont-text"> Pilih Type Produk </span><br>
                </div>
                <div class="col-2">
                    <span class="cont-text"> Pilih Type Part </span><br>
                </div>
            </div>

            <div class="row align-items-center mt-2">
                <div class="col-2">
                    <input onchange="getdata()"  class="text-center cont-form" type="date" name="tgla" id="tgla" value="">
                </div>
                <div class="col-2">
                    <input onchange="getdata()"  class="text-center cont-form" type="date" name="tgle" id="tgle" value="">
                </div>
                <div class="col-2">
                    <select onchange="getdata()" class="cont-form" name="typeproduk" id="typeproduk" aria-label="Default select example">
                        <option value=""> Pilih Filter </option>
                        <% do while not TypePD.eof %>
                        <option value="<%=TypePD("pdTypeProduk")%>"> <%=TypePD("pdTypeProduk")%> </option>
                        <% TypePD.movenext
                        loop %>
                    </select>
                </div>
                <div class="col-2">
                    <select onchange="getdata()" class="cont-form" name="typepart" id="typepart" aria-label="Default select example">
                        <option value=""> Pilih Filter </option>
                        <% do while not TypePART.eof %>
                        <option value="<%=TypePART("pdTypePart")%>"> <%=TypePART("pdTypePart")%> </option>
                        <% TypePART.movenext
                        loop %>
                    </select>
                </div>
                <!--<div class="col-1 me-4">
                    <button class="cont-btn" onclick="window.open('Kartu-Stok.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&typeproduk='+document.getElementById('typeproduk').value+'+&typepart='+document.getElementById('typepart').value,'_Self')" style="width:8rem"><i class="fas fa-file"></i> &nbsp; Kartu Stok</button>
                </div>-->
                <div class="col-1">
                    <button class="cont-btn" onclick="window.open('Laporan-Stok.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&typeproduk='+document.getElementById('typeproduk').value+'+&typepart='+document.getElementById('typepart').value,'_Self')"><i class="fas fa-file"></i> &nbsp; Laporan</button>
                </div>
                <div class="col-1">
                    <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i></button>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-4">
                    <span class="breadcrumb-item cont-text"> Filter Berdasarkan </span><br>
                </div>
                <div class="col-2">
                    <span class="breadcrumb-item cont-text"> Kategori Produk </span><br>
                </div>
                <div class="col-2">
                    <span class="breadcrumb-item cont-text"> Nama Produk </span><br>
                </div>
            </div>

            <div class="row mt-2">
                <div class="col-4">
                    <select disabled class="cont-form" aria-label="Default select example">
                        <option value=""> Pilih Filter </option>
                        <option value="1"> Harga Terendah </option>
                        <option value="2"> Harga Tertinggi </option>
                        <option value="3"> Tanggal Upload Produk </option>
                        <option value="4"> Penjualan Tertinggi </option>
                        <option value="5"> Penjualan Terendah </option>
                    </select>
                </div>
                <div class="col-2">
                    <select onchange="getdata(),kategori()"  name="kategori" id="kategori" class="cont-form" aria-label="Default select example">
                        <option value=""> Pilih Kategori Produk </option>
                        <% do while not kategori.eof %>
                        <option value="<%=kategori("catID")%>"><%=kategori("catName")%></option>
                        <% kategori.movenext
                        loop %>
                    </select>
                </div>
                <div class="col-6">
                    <input disabled="true" onkeyup="getdata()" class="namaproduk cont-form" type="search" name="namaproduk" id="namaproduk" value="" placeholder="Masukan Nama Produk">
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
                                <th colspan="2">DETAL PRODUK</th>
                                <th>STOK</th>
                                <th>PEMBELIAN</th>
                                <th>PENJUALAN</th>
                                <th>SISA</th>
                                <th>RAK</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                no = 0
                                do while not Produk.eof 
                                no = no + 1
                            %>
                            <tr>
                                <td class="text-center"> <%=no%> </td>
                                <td class="text-center"> <button class="cont-btn"> <%=Produk("pdID")%> </button> </td>
                                <td class="text-center"><%=Produk("pdPartNumber")%></td>
                                <td>
                                    <%=Produk("pdNama")%>
                                    <input type="hidden" name="pdID" id="pdID<%=Produk("pdID")%>" value="<%=Produk("pdID")%>">
                                </td>
                                <td class="text-center"><%=Produk("StokAwal")%></td>
                                <%
                                        Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian, ISNULL(MKT_M_PIGO_Produk.pdHarga, 0) AS HargaPembelian FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND pdID = '"& Produk("pdID") &"' GROUP BY MKT_M_PIGO_Produk.pdHarga"
                                        'response.write Stok_CMD.commandText &"<br>"
                                        set SaldoMasuk = Stok_CMD.execute
                                    %>
                                    <td class="text-center"> <%=SaldoMasuk("Pembelian")%> </td>
                                    <%
                                        Stok_CMD.commandText = "SELECT ISNULL(MKT_T_Transaksi_D1A.tr_pdHarga, 0) AS HargaPenjualan, ISNULL(MKT_T_Transaksi_D1A.tr_pdQty, 0) AS Penjualan FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_D1.trD1 = MKT_T_Transaksi_D1A.trD1A ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) ON  MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND pdID = '"& Produk("pdID") &"' "
                                        'response.write Stok_CMD.commandText &"<br>"
                                        set SaldoKeluar = Stok_CMD.execute
                                    %>
                                    <td class="text-center"> <%=SaldoKeluar("Penjualan")%> </td>
                                    <%
                                        Sisa = Produk("StokAwal")+SaldoMasuk("Pembelian")-SaldoKeluar("Penjualan")
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
    </script>
</html>