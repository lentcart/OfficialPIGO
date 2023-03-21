<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String

        Supplier_cmd.commandText = "SELECT * FROM MKT_M_Supplier WHERE sp_custID = '"& request.Cookies("custID") &"' "
        'response.write Supplier_cmd.commandText

    set Supplier = Supplier_cmd.execute

    set sp_cmd = server.createObject("ADODB.COMMAND")
	sp_cmd.activeConnection = MM_PIGO_String

        sp_cmd.commandText = "SELECT COUNT(spID) AS total FROM MKT_M_Supplier WHERE sp_custID = '"& request.Cookies("custID") &"' "
        'response.write sp_cmd.commandText

    set sp = sp_cmd.execute


%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Official PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/DataTables/datatables.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Dashboard/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
        function tambah(){
            let pem= document.getElementsByClassName("tmb");

            document.getElementById("formsupplier").style.display = "block";
            document.getElementById("tsupplier").style.display = "none";
            }
        var array = [];

        function cust(){
            let pem= document.getElementsByClassName("custID");

            document.getElementById("cust").style.display = "block";
        }

        var id = [];
        // console.log(id);
    
        function loaddata(){
            var no = document.getElementById('no').value;
            var custID = id;
            var pdidall = "";
            for ( i=1; i<=no; i++){
                id.push($(`#custID${i}`).val());
            }
            if ( pdidall.length<1 ){
                pdidall = pdidall+id;
            }else{
                    pdidall  = pdidall+","+id; 
                }
            document.getElementById("custall").value = pdidall;
            return id;

            
        }
        $('#periode').on("change",function(){
            let pr = $('#periode').val();
            console.log(pr);
            if (ongkir == "tahun" ){
                $("#cont-tahun").show();
            
            }else{
                $("#cont-tanggal").show();

            }
        });
        
        function tgla(){
            $.ajax({
                type: "get",
                url: "get-data.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                   $('.datatr').html(url);
                    
                }
            });
        }
        function tgle(){
            $.ajax({
                type: "get",
                url: "get-data.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                    
                    
                   $('.datatr').html(url);
                    
                }
            });
        }
    </script>
    </head>

<body>
   <!-- side -->
    <!--#include file="../../side.asp"-->
<!-- side -->

    <div class="main-body" style="overflow-y:scroll">
        <div class="row">
            <div class="col-12">
                <button class="btn-sp" type="button" name="tmb" id="tmb" onclick="return tambah()">Tambah Suplier </button>
            </div>
        </div>
        <div class="row" style="display:none; padding:20px 20px" id="formsupplier">
            <div class="col-12">
                <div class=""  >
                    <form class="form-sp" action="P-Supplier.asp" method="post">
                        <div class="row">
                            <div class="col-12">
                                <span class="text-sp"> Nama Supplier </span><br>
                                <input class="text-s-input mb-3 mt-1"type="text" name="spNama" id="spNama" value="" style="width:36rem" placeholder="Nama Supplier" required><br>
                                <span class="text-sp"> Nama CP Supplier </span><br>
                                <input class="text-s-input mb-3 mt-1"type="text" name="spNamaCP" id="spNamaCP" value="" style="width:36rem" placeholder="Nama Contact Person Supplier" required><br>
                                <span class="text-sp"> Kontak </span><br>
                                <div class="row mt-1">
                                <div class="col-4 mb-3 mt-1">
                                    <input class="text-s-input"type="number" name="spTelp1" id="spTelp1" value="" style="width:15rem" placeholder="Nomor Telepon" required><br>
                                    </div>
                                    <div class="col-4 mb-3 mt-1">
                                        <input class="text-s-input"type="number" name="spTelp2" id="spTelp2" value="" style="width:15rem" placeholder="Nomor Telepon" required><br>
                                    </div>
                                    <div class="col-4 mb-3 mt-1">
                                        <input class="text-s-input"type="number" name="spTelp3" id="spTelp3" value="" style="width:15rem" placeholder="Fax" required><br>
                                    </div>
                                </div>
                                <div class="row mb-3 ">
                                    <div class="col-4">
                                        <span class="text-sp"> Email</span><br>
                                        <input class="text-s-input mt-1"type="text" name="spEmail" id="spEmail" value="" style="width:15rem" placeholder="Alamat Email" required><br>
                                    </div>
                                    <div class="col-8">
                                        <span class="text-sp"> Alamat Lengkap</span><br>
                                        <input class="text-s-input mt-1"type="text" name="spAlmLengkap" id="spAlmLengkap" value="" style="width:36rem" placeholder="(Nama Jalan, RT/RT, No. Blok, Kel, Kec, Kota)" required><br>
                                    </div>
                                </div>
                                <div class="row mb-3 mt-2">
                                    <div class="col-4">
                                        <span class="text-sp"> Provinsi</span><br>
                                        <select class="text-s-input mt-1" style="padding:5px; width:15rem" required name="provinsi" id="provinsi" >
                                            <Option> Pilih Provinsi </option>
                                        </select>
                                        <!--<input class="text-sp"type="select" name="spAlmProvinsi" id="spAlmProvinsi" value="" style="width:15rem"><br>-->
                                    </div>
                                    <div class="col-4">
                                        <span class="text-sp"> Kab/Kota </span><br>
                                        <input class="text-s-input mt-1"type="text" name="spDesc" id="spDesc" value="" style="width:15rem" required><br>
                                    </div>
                                    <div class="col-4">
                                        <span class="text-sp"> Jangka Waktu Pembayaran</span><br>
                                        <input class="text-s-input mt-1"type="text" name="spDesc" id="spDesc" value="" style="width:15rem" required><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input class="btn-sp" type="submit"  value="Simpan" style="width:5rem"><br>
                        <hr>
                    </form>
                </div>
            </div>
        </div>
    <div id="tsupplier">
        <div class="row mt-3">
            <div class="col-12">
                <div class="card mb-2 me-2" style="width:100%;overflow:hidden;background-color:white; border-radius:10px">
                        <div class="row mt-1">
                            <div class="col-8">
                                <span class=" text-dp"> Supplier </span>
                            </div>
                            <div class="col-1">
                                <span class=" text-dp"> Cari </span>
                            </div>
                            <div class="col-2">
                                <input class="text-s-input" type="text" name="" id="" value="" style="width:14rem">
                            </div>
                        </div>
                        <div class="card-body"  style="overflow-y:scroll; height:10rem">
                            <table class="table  table-bordered table-condensed" style="font-size:11px">
                                <thead class="text-center">
                                <tr> 
                                    <th> Nama Supplier </th>
                                    <th> Alamat Lengkap </th>
                                    <th> Provinsi</th>
                                    <th colspan="3"> Nomor Telepon </th>
                                    <th> Email </th>
                                    <th> Keterangan </th>
                                    <th> Aksi </th>
                                </tr>
                                </thead>
                                <tbody>
                                <%do while not Supplier.EOF%>
                                <tr> 
                                    <td><%=Supplier("spNama")%></td>
                                    <td><%=Supplier("spAlmLengkap")%></td>
                                    <td><%=Supplier("spAlmProvinsi")%></td>
                                    <td><%=Supplier("spTelp1")%></td>
                                    <td><%=Supplier("spTelp2")%></td>
                                    <td><%=Supplier("spTelp3")%></td>
                                    <td><%=Supplier("spEmail")%></td>
                                    <td><%=Supplier("spDesc")%></td>
                                    <td><input type="button" value="Tambah Produk" onClick="window.open('Tambah-produk.asp?spid=<%=Supplier("spID")%>','_self')"></td>
                                </tr>
                                <%Supplier.movenext
                                loop%>
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer">
                            <span class=" text-dp"> Total Supplier (<%=sp("total")%>) </span>
                        </div>
                    </div>
            </div>
        </div>
        
    </div>
    </div>
</body>


    <script>
        
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