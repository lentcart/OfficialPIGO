<!--#include file="../../connections/pigoConn.asp"--> 
<% if request.Cookies("custEmail")="" then

response.redirect("../")

end if
%> 
<% 

e= Request.queryString("e")

%> 
<%

    dim Supplier_P
    set Supplier_P_cmd = server.createObject("ADODB.COMMAND")
	Supplier_P_cmd.activeConnection = MM_PIGO_String
			
	Supplier_P_cmd.commandText = " " 
	set Supplier_P = Supplier_P_cmd.execute

    dim Supplier
			
	set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String
			
	Supplier_cmd.commandText = "SELECT * From MKT_M_Supplier_H where spAktifYN = 'Y' " 
	set Supplier = Supplier_cmd.execute

    dim sp
			
	set sp_cmd = server.createObject("ADODB.COMMAND")
	sp_cmd.activeConnection = MM_PIGO_String
			
	sp_cmd.commandText = "SELECT * From MKT_M_Supplier_H where spAktifYN = 'Y' " 
	set sp = sp_cmd.execute
    
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

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="list-produk.css">
        <link rel="stylesheet" type="text/css" href="supplier.css">
        <link rel="stylesheet" type="text/css" href="../.../fontawesome/css/all.min.css">
        <!-- Load jQuery -->
    <!-- Load Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <!-- Load the plugin bundle. -->
    <link rel="stylesheet" href="../../css/filter_multi_select.css" />
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="../../js/filter-multi-select-bundle.min.js"></script>
        <script src="../../js/jquery-3.6.0.min.js"></script>

        <title>PIGO</title>
        
    <script>
        function tambah(){
            let pem= document.getElementsByClassName("tmb");

            document.getElementById("sc").style.display = "block";
            document.getElementById("sb").style.display = "none";
      }
    </script>
    </head>
<body>
    <!--Breadcrumb-->

        <div class="container" style="margin:10px" >
        <div class="navigasi" >
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb ">
                    <li class="breadcrumb-item">
                    <a href="../Seller/index.asp" >Seller Home</a></li>
                    <li class="breadcrumb-item"><a href="../" >Supplier</a></li>
                    <li class="breadcrumb-item"><a href="index.asp" >Produk Supplier</a></li>
                </ol>
            </nav>
        </div>
        </div>
    <hr size="10px" color="#ececec">
    
    <!--Body Supplier-->
        <div class="judul-produk" style=" background-color:white; margin:45px; margin-top:0">
            <div class="row mb-3" style="padding:10px 10px; border-bottom:5px solid #eeeeee; border-radius:10px">
                <div class="col-10">
                    <h5> Daftar Produk Supplier <h5>
                </div>
                <div class="col-2">
                    <button class="btn-sp text-span-sp" type="button" name="tmb" id="tmb" onclick="return tambah()">Tambah Produk </button>
                </div>
            </div>
            <div class="row mt-4" >
                <div class="col-12">
                    <div class="container" style="padding:30px 30px; border: 1px solid #eeeeee; border-radius:10px; display:none" id="sc"    >
                        <form class="spp" action="P-Produk-Supplier.asp" method="post">
                            <div class="row mb-2">
                                <div class="col-4">
                                    <span class="text-span-sp"> Nama Supplier </span><br>
                                </div>
                                <div class="col-8">
                                    <select class="text-sp"aria-label="Default select example" name="sp_spNama" id="sp_spNama" style="width:36rem">
                                        <option selected class="text-span-sp">Pilih Nama Supplier</option>
                                        <%do while not Supplier.eof%>
                                        <option value="<%=Supplier("spID")%>"><%=Supplier("spNama")%></option>
                                        <%Supplier.movenext
                                        loop%>
                                    </select>
                                </div>
                            </div>
                            <div class="row mb-2 align-items-center">
                                <div class="col-4">
                                    <span class="text-span-sp"> Nama Produk </span><br>
                                </div>
                                <div class="col-8">
                                    <input class="text-sp" type="text" name="sp_pdNama" id="sp_pdNama" value="" style="width:15rem"><br>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-4">
                                    <span class="text-span-sp"> Jumlah Produk </span><br>
                                </div>
                                <div class="col-8">
                                    <input class="text-sp" type="text" name="sp_pdQty" id="sp_pdQty" value="" style="width:15rem"><br>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-4">
                                    <span class="text-span-sp"> Harga Satuan Produk </span><br>
                                </div>
                                <div class="col-8">
                                    <input class="text-sp" type="text" name="sp_pdHarga" id="sp_pdHarga" value="" style="width:15rem"><br>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-4">
                                    <span class="text-span-sp"> Tanggal Pembelian </span><br>
                                </div>
                                <div class="col-8">
                                    <input class="text-sp" type="Date" name="sp_pdTglPembelian" id="sp_pdTglPembelian" value="" style="width:15rem"><br>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-4">                                    
                                    <span class="text-span-sp"> Type </span><br>
                                    <input class="text-sp" type="text" name="sp_pdType" id="sp_pdType" value="" style="width:15rem"><br>
                                </div>

                                <div class="col-4">
                                    <span class="text-span-sp"> Merk </span><br>
                                    <select class="text-sp"aria-label="Default select example" name="sp_pdMerk" id="sp_pdMerk" class="form-select mt-2 text-kategori2" aria-label="Default select example" style="width:15rem">
                                    <option value="">Pilih Merk Produk</option>
                                    <% do while not merk.eof %>
                                    <option value="<%=merk("mrID") %> "><%=merk("mrNama")%></option>
                                    <% merk.movenext
                                        loop %>
                                    </select>
                                </div>

                                <div class="col-4">
                                    <span class="text-span-sp"> Kategori </span><br>
                                    <select class="text-sp"aria-label="Default select example" name="sp_pdKat" id="sp_pdKat" style="width:15rem">
                                        <option selected class="text-span-sp">Pilih Kategori</option>
                                        <%do while not Kategori.eof%>
                                        <option value="<%=Kategori("catID")%>"><%=Kategori("catName")%></option>
                                        <%Kategori.movenext
                                        loop%>
                                    </select>
                                </div>
                            </div>
                            <input type="submit"  value="Simpan" style="width:5rem"><br>
                        </form>
                    </div>
                </div>
            </div>
            <div class="row mt-2" id="sb">
                <div class="col-5">
                <span class="text-span-sp"> Periode Laporan </span>
                 : <input class="text-sp text-center"type="date" name="tgla" id="tgla" value="" style="width:10rem"> s.d
                <input class="text-sp text-center" type="date" name="tgle" id="tgle" value="" style="width:10rem">
                </div>
                <div class="col-5">
                <span class="text-span-sp">  Supplier </span>
                <select multiple class="filter-multi-select" style="width:10rem" name="spID" id="spID">
                    <%do while not sp.eof%>
                        <option value="<%=sp("spID")%>"><%=sp("spNama")%></option>
                    <%sp.movenext
                    loop%>
                </select>
                </div>
                <div class="col-2">
                <button class="btn-sp text-span-sp" onclick="window.open('lap-pembarang.asp?spID='+document.getElementById('spID').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Buat Laporan </button>
            </div>
            <div class="row mt-4" id="sb">
                <div class="col-12">
                    <div class="">
                        <table class="table  table-bordered table-condensed">
                            <thead class="text-center">
                                <tr>
                                    <th> Nama Produk </th>
                                    <th> Jumlah Produk </th>
                                    <th> Harga </th>
                                    <th> Merk </th>
                                    <th> Kategori </th>
                                    <th> Nama Supplier </th>
                                    <th> KET </th>
                                </tr>
                            </thead>
                            <tbody>
                            <%do while not Supplier_P.eof%>
                            <tr>
                                <td><%=Supplier_P("sp_pdNama")%></td>
                                <td><%=Supplier_P("sp_pdQty")%></td>
                                <td><%=Supplier_P("sp_pdHarga")%></td>
                                <td><%=Supplier_P("sp_pdMerk")%></td>
                                <td><%=Supplier_P("sp_pdKat")%></td>
                                <td><%=Supplier_P("spNama")%></td>
                                <td><a href="">Detail</a></td>
                            </tr>
                            <%Supplier_P.movenext
                            loop%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Body Supplier-->
    <!-- Button trigger modal -->



</body>
<script>
    function openDialog() {
    document.getElementById('fileid').click();
    }

    // Use the plugin once the DOM has been loaded.
      $(function () {
        // Apply the plugin 
        var notifications = $('#notifications');
        $('#animals').on("optionselected", function(e) {
          createNotification("selected", e.detail.label);
        });
        $('#animals').on("optiondeselected", function(e) {
          createNotification("deselected", e.detail.label);
        });
        function createNotification(event,label) {
          var n = $(document.createElement('span'))
            .text(event + ' ' + label + "  ")
            .addClass('notification')
            .appendTo(notifications)
            .fadeOut(3000, function() {
              n.remove();
            });
        }
      });
</script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../../js/bootstrap.js"></script>
    <script src="../../js/popper.min.js"></script>
</html>