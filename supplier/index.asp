<!--#include file="../connections/pigoConn.asp"--> 
<% if request.Cookies("custEmail")="" then

response.redirect("../")

end if
%> 
<% 

e= Request.queryString("e")

%> 
<%

    dim Supplier
    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String
			
	Supplier_cmd.commandText = "SELECT * FROM [PIGO].[dbo].[MKT_M_Supplier_H] where spAktifYn = 'Y' " 
	set Supplier = Supplier_cmd.execute
   
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="supplier.css">
        <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
        <script src="../js/jquery-3.6.0.min.js"></script>

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
    <div class="container mt-3">
        <div class="navigasi" >
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb ">
                    <li class="breadcrumb-item">
                    <a href="../Seller/index.asp" >Seller Home</a></li>
                    <li class="breadcrumb-item"><a href="index.asp" >Supplier</a></li>
                </ol>
            </nav>
        </div>
    </div>
    <hr size="10px" color="#ececec">
    
    <!--Body Supplier-->
    <div class="container" style=" background-color:white; padding: 10px 50px">
        <div class="judul-produk" style=" background-color:white" >
            <div class="row">
                <div class="col-10">
                    <h5> Daftar Suplier <h5>
                </div>
                <div class="col-2">
                    <button class="btn-sp" type="button" name="tmb" id="tmb" onclick="return tambah()">Tambah Suplier </button>
                </div>
            </div>
            <div class="row mt-2" style="display:none; padding:20px 20px" id="sc">
                <div class="col-12">
                    <div class=""  >
                        <form class="form-sp" action="P-Supplier.asp" method="post">
                            <div class="row">
                                <div class="col-12">
                                <hr>
                                    <span class="text-span-sp "> Nama Supplier </span><br>
                                    <input class="text-sp mb-3"type="text" name="spNama" id="spNama" value="" style="width:36rem" placeholder="Nama Supplier"><br>
                                    <span class="text-span-sp "> Nomor Telepon 1 </span><br>
                                    <div class="row mt-1">
                                        <div class="col-4 mb-3">
                                        <input class="text-sp"type="text" name="spTelp1" id="spTelp1" value="" style="width:15rem" placeholder="Nomor Telepon 1"><br>
                                        </div>
                                        <div class="col-4 mb-3">
                                            <input class="text-sp"type="text" name="spTelp2" id="spTelp2" value="" style="width:15rem" placeholder="Nomor Telepon 2"><br>
                                        </div>
                                        <div class="col-4 mb-3">
                                            <input class="text-sp"type="text" name="spTelp3" id="spTelp3" value="" style="width:15rem" placeholder="Nomor Telepon 3"><br>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <span class="text-span-sp "> Email</span><br>
                                            <input class="text-sp"type="text" name="spEmail" id="spEmail" value="" style="width:15rem" placeholder="Alamat Email"><br>
                                        </div>
                                        <div class="col-8">
                                            <span class="text-span-sp "> Alamat Lengkap</span><br>
                                            <input class="text-sp"type="text" name="spAlmLengkap" id="spAlmLengkap" value="" style="width:36rem" placeholder="(Nama Jalan, RT/RT, No. Blok, Kel, Kec, Kota)"><br>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <span class="text-span-sp "> Provinsi</span><br>
                                            <select class="text-sp" style="padding:5px" >
                                                <Option> Pilih Provinsi </option>
                                            </select>
                                            <!--<input class="text-sp"type="select" name="spAlmProvinsi" id="spAlmProvinsi" value="" style="width:15rem"><br>-->
                                        </div>
                                        <div class="col-8">
                                            <span class="text-span-sp "> Deskripsi</span><br>
                                            <input class="text-sp"type="text" name="spDesc" id="spDesc" value="" style="width:15rem"><br>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="submit"  value="Simpan" style="width:5rem"><br>
                                <hr>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-2" id="sb">
            <div class="col-12">
                <div class="tb-supplier">
                    <table class="table">
                        <thead>
                            <tr>
                                <th> Nama Suplier </th>
                                <th> Nomor Telepon </th>
                                <th> Alamat </th>
                                <th class="text-center"colspan="2"> KET </th>
                            </tr>
                        </thead>
                        <tbody>
                        <%do while not Supplier.eof%>
                        <tr>
                            <td><%=Supplier("spNama")%></td>
                            <td><%=Supplier("spTelp1")%></td>
                            <td><%=Supplier("spAlmLengkap")%></td>
                            <td><%=Supplier("spDesc")%></td>
                            <td><a href="detail-sp.asp?spID=<%=Supplier("spID")%>">Detail<a></td>
                        </tr>
                        <%Supplier.movenext
                        loop%>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row mt-2" id="sb">
                <div class="col-10">
                    
                </div>
                <div class="col-2">
                    <a href="lap-supplier.asp"> Eksport To Excel </a>
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
</script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../js/bootstrap.js"></script>
    <script src="../js/popper.min.js"></script>
</html>