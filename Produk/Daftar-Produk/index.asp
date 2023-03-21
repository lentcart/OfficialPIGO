<!--#include file="../../connections/pigoConn.asp"--> 

<%
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String
			
	produk_cmd.commandText = "SELECT * FROM [PIGO].[dbo].[MKT_M_Produk] where pd_custID = '"& request.Cookies("custID") &"' " 
	set produk = produk_cmd.execute

    set kategori_cmd = server.createObject("ADODB.COMMAND")
	kategori_cmd.activeConnection = MM_PIGO_String
			
	kategori_cmd.commandText = "SELECT * FROM MKT_M_Kategori Where catAktifYN = 'Y'  " 
	set kategori = kategori_cmd.execute

    set Total_cmd = server.createObject("ADODB.COMMAND")
	Total_cmd.activeConnection = MM_PIGO_String
			
	Total_cmd.commandText = "SELECT COUNT(pdID) as total From MKT_M_Produk where pd_custID = '"& request.Cookies("custID") &"'  " 
	set Total = Total_cmd.execute

    set StokAkhir_cmd = server.createObject("ADODB.COMMAND")
	StokAkhir_cmd.activeConnection = MM_PIGO_String
			
    set pd_cmd = server.createObject("ADODB.COMMAND")
	pd_cmd.activeConnection = MM_PIGO_String
    

%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
        <link rel="stylesheet" type="text/css" href="list-produk.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/AmagiTech/JSLoader/amagiloader.js"></script>

        <title>PIGO</title>
        
    <script>

        function openCity(evt, cityName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";
            }
            $(document).ready(function(){
            $(".nav-tabs a").click(function(){
                $(this).tab('show');
            });
            });
            
            function simpan(){
                let sim= document.getElementsByClassName("sim");

                document.getElementById("lanjut").style.display = "block";
            }
            function stok(){
                let stok= document.getElementsByClassName("btnstok");

                document.getElementById("idstok").style.display = "block";
                document.getElementById("tambahproduk").style.display = "none";
                document.getElementById("uploadproduk").style.display = "none";
                document.getElementById("detailproduk").style.display = "none";
            }
        function tambahstok(){
                let pem= document.getElementsByClassName("tmstok");

                document.getElementById("tambahstok").style.display = "block";
                document.getElementById("stmanual").style.display = "block";
                document.getElementById("gop").style.display = "none";
        }
        function stokmanual(){
                let pem= document.getElementsByClassName("stmanual");

                document.getElementById("st").style.display = "block";
                document.getElementById("tambahstok").style.display = "none";
        }
        function carikategori(){
            $.ajax({
                type: "get",
                url: "getKategori.asp?catID="+document.getElementById("catID").value,
                success: function (url) {
                    AmagiLoader.show();
                    setTimeout(() => {
                        AmagiLoader.hide();
                    }, 3000);
                    $('.datatr').html(url);
                        // console.log(url);
                }
            });
        }
        function carikondisi(){
            $.ajax({
                type: "get",
                url: "getkondisi.asp?kondisi="+document.getElementById("kondisi").value,
                success: function (url) {
                    AmagiLoader.show();
                    setTimeout(() => {
                        AmagiLoader.hide();
                    }, 3000);
                    $('.datatr').html(url);
                }
            });
        }
        function cari(){
            $.ajax({
                type: "get",
                url: "getdata.asp?cari="+document.getElementById("cari").value,
                success: function (url) {
                    $('.datatr').html(url);
                    
                        // console.log(url);
                }
            });
        }
        function refresh(){
            location.reload();
            AmagiLoader.show();
            setTimeout(() => {
                AmagiLoader.hide();
            }, 5000);
        }
        function Load(){
            AmagiLoader.show();
            setTimeout(() => {
                AmagiLoader.hide();
            }, 5000);
        }
    </script>
    <style>
        .btn-produk-rekom{
            border:none;
            border-radius:20px;
            padding:2px 20px;
            font-size:12px;
            font-weight:500;
            color:white;
            background-color:#0077a2;
        }
        .btn-produk-rekom:hover{
            border:none;
            border-radius:20px;
            padding:2px 20px;
            font-size:12px;
            font-weight:500;
            color:black;
            background-color:#aaa;
        }
    </style>
    </head>
<body>
    <!--Breadcrumb-->
    <div class="container mt-3">
        <div class="navigasi" >
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb ">
                    <li class="breadcrumb-item">
                    <a href="<%=base_url%>/Seller/" >Seller Home</a></li>
                    <li class="breadcrumb-item"><a href="index.asp" >Daftar Produk</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <hr size="10px" color="#ececec">
    
    <!--Body Seller-->
    <div class="container" style="background-color:none">
        <div class="daftarpr">
            <div class="row mb-2">
                <div class="col-lg-0 col-md-0 col-sm-0 col-10  mt-1">
                    <span class="txt-judul-produk"> (<%=total("total")%>) Produk </span>
                </div>
                <div class="col-lg-0 col-md-0 col-sm-0 col-2  mt-1">
                    <a href = "../Tambah-Produk/" class=" weight"> Tambah Produk </a>
                </div>

                <div class="list-produk">
                    <div class="row">
                        <div class="col-7">
                            <div class="input-group">
                            <input class="form-list-produk me-1" name="cari" id="cari" type="text" class=" text-kategori1"   Placeholder="Cari Nama Produk Atau SKU/Part Number" required style="width:25rem">
                                <div class="input-group-append">
                                    <span onclick="cari()"class=" form-list-produk input-group-text" id="basic-addon2"  style="width:3.2rem; border-left-radius:0px">Cari</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 ">
                            <button onclick="refresh()" class=" text-center form-list-produk" style="width:4.4rem;"> Refresh </button>
                        </div>
                        <div class="col-2">
                            <select onchange="carikategori()"class="form-list-produk" name="catID" id="catID" class="mt-2 text-kategori2" aria-label="Default select example ">
                                <option value="">Kategori</option>
                                <% do while not kategori.eof %>
                                <option value="<%=kategori("catID")%>"><%=kategori("catName")%></option>
                                <% kategori.movenext
                                loop %>
                            </select>
                        </div>
                        <div class="col-2">
                            <select onchange="carikondisi()" class="form-list-produk" name="kondisi" id="kondisi" class="mt-2 text-kategori2" aria-label="Default select example ">
                                <option value="">Kondisi</option>
                                <option value="Y">Baru</option>
                                <option value="N">Bekas</option>
                            </select>
                        </div>
                    </div>
                </div>
                    <div class="row">
                        <%do while not produk.eof%>
                        <div class="col-2">
                            <div class="card mt-3 mb-2 me-2">
                                <img src="data:image/png;base64,<%=produk("pdImage1")%>" class="card-img-top rounded" alt="...">
                                <div class="card-body">
                                    <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="<%=produk("pdNama")%>"><br>
                                    <div class="row mt-1" style="color:black; font-weight:bold; font-size:9px">
                                        <div class="col-9">
                                            <input class="hg-card" type="text" name="pdHarga" id="pdHarga" value="<%=Replace(FormatCurrency(produk("pdHargaJual")),"$","Rp.  ")%>"><br>
                                        </div>
                                        <div class="col-3">
                                            <div class="dropdown">
                                                <button class="btn-dp" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style=" font-size:10px;border:none; color:white; background-color:#0dcaf0"><i class="fas fa-list-ul"></i></button>
                                                <ul class="dropdown-menu text-center" aria-labelledby="dropdownMenuButton1">
                                                    <li>
                                                        <a class="dropdown-item" href="#"><input class="btn-cetak-po" type="button" value="Tambah Stok"  onClick="window.open('../Tambah-Stok/?produkid=<%=produk("pdID")%>','_self')"></a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="#"><input class="btn-cetak-po" type="button" value="Edit"  onClick="window.open('../Update-Produk/?pdid=<%=produk("pdID")%>','_self')"></a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" ><input class="btn-cetak-po" type="button" value="Hapus"  onClick="window.open('../Update-Produk/P-deleteproduk.asp?pdid=<%=produk("pdID")%>','_self')"></a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-2 " style="color:black; font-weight:bold; font-size:9px">
                                        <div class="col-9">
                                            <span> Stok </span><br>
                                            <span> Penjualan  </span><br>
                                            <span> Stok Akhir </span>
                                        </div>
                                        <div class="col-3 text-center">
                                            <span> <%=produk("pdStok")%> </span><br>
                                            <%
                                                pd_cmd.commandText = "SELECT ISNULL(SUM(MKT_T_Transaksi_D1A.tr_pdQty),0) AS total FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  produk("pdID") &"') AND (MKT_M_Produk.pd_custID = '"&  produk("pd_custID") &"')"
                                                'response.write pd_cmd.commandText
                                                set pd = pd_cmd.execute
                                            %>
                                            <span> <%=pd("total")%>  </span><br>
                                            <%
                                                StokAkhir_cmd.commandText = "SELECT ISNULL(SUM(MKT_T_Transaksi_D1A.tr_pdQty),0) AS Penjualan, MKT_M_Produk.pdID, MKT_M_Produk.pdStok, ISNULL(SUM(MKT_M_Produk.pdStok - MKT_T_Transaksi_D1A.tr_pdQty),0) AS total FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D2 ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D2.trD2 FULL OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_D1A.trD1A WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  produk("pdID") &"') AND (MKT_M_Produk.pd_custID = '"&  produk("pd_custID") &"') GROUP BY  MKT_M_Produk.pdID, MKT_M_Produk.pdStok"
                                                'response.write StokAkhir_cmd.commandText
                                                set StokAkhir = StokAkhir_cmd.execute
                                            %>
                                                
                                            <%if StokAkhir.eof = true then %>
                                                <span> <%=produk("pdStok")%> </span>
                                            <%else%>
                                                <% do while not StokAkhir.eof %>
                                                <span> <%=StokAkhir("total")%> </span>
                                                <%StokAkhir.movenext
                                                loop%>
                                            <%end if%>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            lastpdID = produk("pdID") 
                            produk.movenext
                            loop
                            response.Cookies("lpd")=lastpdID 
                        %>
                    </div> 

                    <div class="row" id="<%=lastpdID%>">
                    </div>
                    <div class="row mt-4 text-center">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <button class="btn-produk-rekom" onclick="refreshh(),loadproduk()"> LIHAT LAINNYA </button>
                        </div>
                    </div>
                </div>
        </div>

</body>
    <script>
    function loadproduk(){
            var produkid = `<%=lastpdID%>`;
            // console.log(produkid);
            $.get(`getproduk.asp?x=${produkid}`,function(data){
                // console.log(data);
                $('#'+produkid+'').html(data);
            })
        }
        function openDialog() {
        document.getElementById('fileid').click();
        }
    </script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>