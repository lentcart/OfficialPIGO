<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    pdID = request.queryString("pdID")

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT pdID, pdNama FROM MKT_M_Produk WHERE pdID = '"& pdID &"' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    dim kategori
			
	set kategori_cmd = server.createObject("ADODB.COMMAND")
	kategori_cmd.activeConnection = MM_PIGO_String
			
	kategori_cmd.commandText = "SELECT [catID] ,[catName] ,[catAktifYN] FROM [PIGO].[dbo].[MKT_M_Kategori] where catAktifYN = 'Y'" 
	set kategori = kategori_cmd.execute

    dim merk

    set merk_cmd = server.createObject("ADODB.COMMAND")
	merk_cmd.activeConnection = MM_PIGO_String
			
	merk_cmd.commandText = "SELECT [mrID] ,[mrNama] ,[mrAktifYN] FROM [PIGO].[dbo].[MKT_M_Merk] where mrAktifYN = 'Y'" 
	set merk = merk_cmd.execute

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Official PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="dashboard.css">
    <link rel="stylesheet" type="text/css" href="../../../fontawesome/css/all.min.css">
    <script src="../../../js/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <script>
        function tambah(){
            let pem= document.getElementsByClassName("tmb");

            document.getElementById("formsupplier").style.display = "block";
            document.getElementById("tsupplier").style.display = "none";
            }
    </script>
   
    </head>

<body>
    <div class="side" style="overflow-y:scroll">
        <div class="row items-align-center"> 
            <div class="col-12" >
                <span class=" mt-3 judul-side mt-4  text-center" style="margin-left:2rem "> Official PIGO</span>
                <hr>
                 <button class="dropdown-btn mt-4" >Data<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct text-dr">
                        <a class="text-dr" href="../Dashboard/Data/Customer/">Customer PIGO</a>
                        <a class="text-dr" href="../Produk/Daftar-Produk/">Seller</a>
                        <a class="text-dr" href="../Supplier/">Produk</a>
                        <a class="text-dr" href="../Supplier/">Supplier</a>
                        <a class="text-dr" href="../Supplier/">Pembelian Produk</a>
                    </div>
                 <button class="dropdown-btn " >Keuangan<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct text-dr">
                        <a class="text-dr" href="../Produk/Tambah-Produk">Tambah Produk</a>
                        <a class="text-dr" href="../Produk/Daftar-Produk/">Daftar Produk</a>
                        <a class="text-dr" href="../Supplier/">Supplier</a>
                        <a class="text-dr" href="../Supplier/Produk-supplier/">Pembelian Produk</a>
                    </div>
                 <button class="dropdown-btn " >Laporan<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct text-dr">
                        <a class="text-dr" href="Laporan/Lap-penjualan/">Laporan Penjualan</a>
                        <a class="text-dr" href="../Produk/Daftar-Produk/">Laporan Barang</a>
                        <a class="text-dr" href="../Supplier/">Laporan Laba Rugi</a>
                        <a class="text-dr" href="../Supplier/Produk-supplier/">Laporan Pemasukan</a>
                        <a class="text-dr" href="../Supplier/Produk-supplier/">Laporan Pengeluaran</a>
                    </div>
                 <button class="dropdown-btn " >User<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct text-dr">
                        <a class="text-dr" href="../Produk/Tambah-Produk">User PIGO</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="main-body" style="overflow-y:scroll">
        <div class="row">
            <div class="col-10">
                <span class="font-weight-bolder" style="color:black"> Data Pembelian Produk </span>
            </div>
            <div class="col-2">
                <div class="dropdown">
                    <button class=" text-dp dropdown-btnn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        Official PIGO
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="text-dp dropdown-item" href="#">Akun PIGO </a></li>
                        <li><a class="text-dp dropdown-item" href="#">Users</a></li>
                        <li><a class="text-dp dropdown-item" href="../Dashboard/LogoutUser.asp">Log Out</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <hr>
        <div class="row mt-4" >
            <div class="col-12">
                <div class="container" style="padding:30px 30px; border: 1px solid #eeeeee; border-radius:10px;" id="sc"    >
                    <form class="spp" action="P-Pembelian.asp" method="post">
                    <input class="text-s-input" type="hidden" name="custID" id="custID" value="<%=request.Cookies("custID")%>" style="width:10rem"><br>
                        <div class="row">
                            <div class="col-3">
                                <span class="text-sp"> Tanggal Pembelian </span><br>
                            </div>
                            <div class="col-8">
                                <input class="text-s-input" type="date" name="tglpembelian" id="tglpembelian" value="<%=now()%>" style="width:10rem"><br>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-3">
                                <span class="text-sp"> Kode Produk </span><br>
                                <input class="text-s-input text-center" type="text" name="kdproduk" id="kdproduk" value="<%=pdID%>" style="width:10rem"><br>
                            </div>
                            <div class="col-6">
                                <span class="text-sp"> Nama Produk </span><br>
                                <input class="text-s-input" type="text" name="namaproduk" id="namaproduk" value="<%=Produk("pdNama")%>" style="width:35rem"><br>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-3">
                                <span class="text-sp"> Detail Produk </span><br>
                            </div>
                            <div class="col-9">
                                <div class="row">
                                    <div class="col-2">
                                        <span class="text-sp"> Jumlah </span><br>
                                        <input class="text-s-input" type="text" name="jumlahproduk" id="jumlahproduk" value="" style="width:7rem"><br>
                                    </div>
                                    <div class="col-2">
                                        <span class="text-sp"> Unit </span><br>
                                        <select class="form-select text-s-input" aria-label="Default select example" name="unit" id="unit" style="width:7rem">
                                            <option selected>Pilih Unit</option>
                                            <option value="Pcs">Pcs</option>
                                            <option value="Kg">Kg</option>
                                            <option value="Dus">Dus</option>
                                        </select>
                                    </div>
                                    <div class="col-2">
                                        <span class="text-sp"> Harga Produk </span><br>
                                        <input class="text-s-input" type="text" name="hargaproduk" id="hargaproduk" value="" style="width:19.5rem"><br>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-4">
                                        <span class="text-sp"> Merk Produk </span><br>
                                        <select class="text-s-input"aria-label="Default select example" name="merk" id="merk" style="width:15rem">
                                            <option selected class="text-span-sp">Pilih Merk</option>
                                            <%do while not merk.eof%>
                                            <option value="<%=merk("mrID")%>"><%=merk("mrNama")%></option>
                                            <%merk.movenext
                                            loop%>
                                        </select>
                                    </div>
                                    <div class="col-3">
                                        <span class="text-sp"> Type Produk </span><br>
                                        <input class="text-s-input" type="text" name="type" id="type" value="" style="width:10rem"><br>
                                    </div>
                                    <div class="col-2">
                                        <span class="text-sp"> Kondisi Produk </span><br>
                                        <select class="form-select text-s-input" aria-label="Default select example" name="kondisi" id="kondisi" style="width:8rem">
                                            <option selected>Pilih Unit</option>
                                            <option value="Y">Baru</option>
                                            <option value="N">Bekas</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-12">
                                        <span class="text-sp"> Kategori Produk </span><br>
                                        <select class="text-s-input"aria-label="Default select example" name="kategori" id="kategori" style="width:35rem">
                                            <option selected class="text-span-sp">Pilih Kategori</option>
                                            <%do while not Kategori.eof%>
                                            <option value="<%=Kategori("catID")%>"><%=Kategori("catName")%></option>
                                            <%Kategori.movenext
                                            loop%>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row mt-2">
                            <div class="col-3">
                                <span class="text-sp"> Nama Supplier </span><br>
                            </div>
                            <div class="col-9">
                                <div class="row">   
                                    <div class="col-12">
                                        <input class="text-s-input" type="text" name="namasupplier" id="namasupplier" value="" style="width:35rem"><br>
                                    </div>
                                    <div class="col-4 mt-2">
                                        <span class="text-sp"> Email </span><br>
                                        <input class="text-s-input" type="text" name="emailsupplier" id="emailsupplier" value="" style="width:15rem"><br>
                                    </div>
                                    <div class="col-4 mt-2">
                                        <span class="text-sp"> Nama Contact Person </span><br>
                                        <input class="text-s-input" type="text" name="namacp" id="namacp" value="" style="width:19.5rem"><br>
                                    </div>
                                </div>
                                <div class="row mt-2">  
                                    <div class="col-3">
                                        <span class="text-sp"> Nomor Telepon 1 </span><br>
                                        <input class="text-s-input" type="text" name="phone1" id="phone1" value="" style="width:11.1rem"><br>
                                    </div>
                                    <div class="col-3">
                                        <span class="text-sp"> Nomor Telepon 1 </span><br>
                                        <input class="text-s-input" type="text" name="phone2" id="phone2" value="" style="width:11.1rem"><br>
                                    </div>
                                    <div class="col-3">
                                        <span class="text-sp"> Nomor Telepon 1 </span><br>
                                        <input class="text-s-input" type="text" name="phone3" id="phone3" value="" style="width:11.5rem"><br>
                                    </div>
                                </div>
                                <div class="row mt-2">  
                                    <div class="col-3">
                                        <span class="text-sp"> Provinsi </span><br>
                                        <select class="form-select text-s-input" aria-label="Default select example" name="provinsi" id="provinsi">
                                            <option value="">Pilih Provinsi</option>
                                        </select>
                                    </div>
                                    <div class="col-9">
                                        <span class="text-sp"> Alamat Lengkap </span><br>
                                        <input class="text-s-input" type="text" name="alamatlengkap" id="alamatlengkap" value="" style="width:23rem"><br>
                                    </div>
                                </div>
                                <div class="row mt-2">  
                                    <div class="col-12">
                                        <span class="text-sp"> Deskripsi</span><br>
                                        <input class="text-s-input" type="text" name="deskripsi" id="deskripsi" value="" style="width:35rem"><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="submit"  value="Simpan" style="width:5rem"><br>
                    </form>
                </div>
            </div>
        </div>
</body>


    <script>
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
       
            $('#provinsi').click(function(){     
            $.getJSON(`https://dev.farizdotid.com/api/daerahindonesia/provinsi`,function(data){ 
                for(let i = 0; i < data.provinsi.length; i++){
                    $('#provinsi').append(new Option(`${data.provinsi[i].nama}`, `${data.provinsi[i].nama}`));
                    
                }

            });
        });
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>