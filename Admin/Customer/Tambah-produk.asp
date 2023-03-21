<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    spid = request.queryString("spid")

    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String

        Supplier_cmd.commandText = "SELECT spNama FROM MKT_M_Supplier_H WHERE spid = '"& spid &"' "
        'response.write Supplier_cmd.commandText

    set Supplier = Supplier_cmd.execute

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
    <style>
body {font-family: Arial, Helvetica, sans-serif;}


.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  
}

/* Modal Content */
.modal-content {
  position: relative;
  background-color: #fefefe;
  margin: auto;
  padding: 0;
  border: 1px solid #888;
  border-radius : 20px;
  width: 60%;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
  -webkit-animation-name: animatetop;
  -webkit-animation-duration: 0.4s;
  animation-name: animatetop;
  animation-duration: 0.4s
}

/* Add Animation */
@-webkit-keyframes animatetop {
  from {top:-300px; opacity:0} 
  to {top:0; opacity:1}
}

@keyframes animatetop {
  from {top:-300px; opacity:0}
  to {top:0; opacity:1}
}

/* The Close Button */
.close {
  color: blue;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: grey;
  text-decoration: none;
  cursor: pointer;
}

.modal-header {
  padding: 2px 6px;
  font-size : 12px;
  background-color: white;
  color: grey;
  border-radius : 20px;
}

.modal-body {padding: 2px 16px;
border-radius : 20px;}

.modal-footer {
  padding: 2px 6px;
  font-size : 12px;
  background-color: white;
  color: grey;
  border-radius : 20px;
  }
  
</style>
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
                <span class="font-weight-bolder" style="color:black"> Data Supplier </span>
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
                        <form class="spp" action="P-produksp.asp" method="post">
                            <div class="row mb-2">
                                <div class="col-4">
                                    <span class="text-sp"> Nama Supplier </span><br>
                                </div>
                                 <div class="col-8">
                                    <input class="text-s-input" type="hidden" name="spid" id="spid" value="<%=spid%>" style="width:25rem"><br>
                                    <input class="text-s-input" type="text" name="spNama" id="spNama" value="<%=Supplier("spNama")%>" style="width:25rem"><br>
                                </div>
                            </div>
                            <div class="row mb-2 align-items-center">
                                <div class="col-4">
                                    <span class="text-sp"> Nama Produk </span><br>
                                </div>
                                <div class="col-8">
                                    <input class="text-s-input" type="text" name="sp_pdNama" id="sp_pdNama" value="" style="width:25rem"><br>
                                </div>
                            </div>
                            <div class="row mb-2 align-items-center">
                                <div class="col-4">
                                    <span class="text-sp"> Merk Produk </span><br>
                                </div>
                                <div class="col-8">
                                    <select class="text-s-input"aria-label="Default select example" name="sp_pdMerk" id="sp_pdMerk" style="width:25rem">
                                        <option selected class="text-span-sp">Pilih Merk</option>
                                        <%do while not merk.eof%>
                                        <option value="<%=merk("mrID")%>"><%=merk("mrNama")%></option>
                                        <%merk.movenext
                                        loop%>
                                    </select>
                                </div>
                            </div>
                            <div class="row mb-2 align-items-center">
                                <div class="col-4">
                                    <span class="text-sp"> Kategori Produk </span><br>
                                </div>
                                <div class="col-8">
                                    <select class="text-s-input"aria-label="Default select example" name="sp_pdKat" id="sp_pdKat" style="width:25rem">
                                        <option selected class="text-span-sp">Pilih Kategori</option>
                                        <%do while not Kategori.eof%>
                                        <option value="<%=Kategori("catID")%>"><%=Kategori("catName")%></option>
                                        <%Kategori.movenext
                                        loop%>
                                    </select>
                                </div>
                            </div>
                            <div class="row mb-2 align-items-center">
                                <div class="col-4">
                                    <span class="text-sp"> Type Produk </span><br>
                                </div>
                                <div class="col-8">
                                    <input class="text-s-input" type="text" name="sp_pdType" id="sp_pdType" value="" style="width:25rem"><br>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-4">
                                    <span class="text-sp"> Jumlah Produk </span><br>
                                </div>
                                <div class="col-3">
                                    <input class="text-s-input" type="text" name="sp_pdQty" id="sp_pdQty" value="" style="width:10rem"><span class="text-sp">  Produk </span><br>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-4">
                                    <span class="text-sp"> Harga Satuan Produk </span><br>
                                </div>
                                <div class="col-8">
                                    <span class="text-sp me-2">Rp.</span><input class="text-s-input" type="text" name="sp_pdHarga" id="sp_pdHarga" value="" style="width:8.3rem"><br>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-4">
                                    <span class="text-sp"> Tanggal Pembelian </span><br>
                                </div>
                                <div class="col-8">
                                    <input class="text-s-input" type="Date" name="sp_pdTglPembelian" id="sp_pdTglPembelian" value="" style="width:10rem"><br>
                                </div>
                            </div>
                            
                            <input type="submit"  value="Simpan" style="width:5rem"><br>
                        </form>
                    </div>
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