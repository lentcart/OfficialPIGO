<!--#include file="../../../connections/pigoConn.asp"--> 

<%

    ' set kategori_cmd = server.createObject("ADODB.COMMAND")
    ' kategori_cmd.activeConnection = MM_PIGO_String

    ' kategori_cmd.commandText = "SELECT MKT_M_PIGO_Produk.pd_catID, MKT_M_Kategori.catID, MKT_M_Kategori.catName FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Kategori ON MKT_M_PIGO_Produk.pd_catID = MKT_M_Kategori.catID RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 WHERE MKT_T_MaterialReceipt_H.mm_custID = 'C0322000000002' GROUP BY  MKT_M_PIGO_Produk.pd_catID, MKT_M_Kategori.catID, MKT_M_Kategori.catName"
    ' 'response.write kategori_cmd.commandText
    ' set kategori = kategori_cmd.execute 

    ' set type_cmd = server.createObject("ADODB.COMMAND")
    ' type_cmd.activeConnection = MM_PIGO_String

    ' type_cmd.commandText = "SELECT pdType FROM MKT_M_Produk where pd_custID = 'C0322000000002' GROUP BY pdType "
    ' 'response.write type_cmd.commandText
    ' set typepd = type_cmd.execute

    ' set Supplier_cmd = server.createObject("ADODB.COMMAND")
	' Supplier_cmd.activeConnection = MM_PIGO_String
                
	' Supplier_cmd.commandText = "SELECT MKT_M_Supplier.spNama1, MKT_M_Supplier.spID, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_D.po_spoID FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_T_PurchaseOrder_H RIGHT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 WHERE MKT_T_MaterialReceipt_H.mm_custID = 'C0322000000002' AND MKT_T_PurchaseOrder_D.po_spoID = '1'  GROUP BY  MKT_M_Supplier.spNama1, MKT_M_Supplier.spID, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_D.po_spoID"
    
    ' 'response.write Supplier_cmd.commandText
	' set Supplier = Supplier_cmd.execute


    ' set Supplier_cmd = server.createObject("ADODB.COMMAND")
	' Supplier_cmd.activeConnection = MM_PIGO_String
			
	' Supplier_cmd.commandText = "SELECT MKT_M_Supplier.spNama1, MKT_M_Supplier.spID FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN  MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID LEFT OUTER JOIN  MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN  MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 WHERE MKT_T_MaterialReceipt_H.mm_custID = 'C0322000000002'  GROUP BY  MKT_M_Supplier.spNama1, MKT_M_Supplier.spID"
    ' 'response.write Supplier_cmd.commandText
	' set Supplier = Supplier_cmd.execute
    
    ' set Ps_cmd = server.createObject("ADODB.COMMAND")
	' Ps_cmd.activeConnection = MM_PIGO_String
			
	' Ps_cmd.commandText = "SELECT MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MONTH(MKT_T_MaterialReceipt_H.mmTanggal) AS Bulan, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType,  MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_PurchaseOrder_H.poID FROM MKT_T_MaterialReceipt_D1 LEFT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON MKT_T_MaterialReceipt_D1.mm_poID = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_H.mm_custID = 'C0322000000002' AND MKT_T_PurchaseOrder_D.po_spoID = '1' GROUP BY MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MONTH(MKT_T_MaterialReceipt_H.mmTanggal) , MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType,  MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_PurchaseOrder_H.poID ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC"

    ' 'response.write Ps_cmd.commandText

	' set Ps = Ps_cmd.execute

    
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/DataTables/datatables.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
        <script src="<%=base_url%>/DataTables/datatables.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>

        <title>Oficial PIGO</title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">
        
    <script>
        function listcust(){
                document.getElementById("datapembeli").style.display = "block";
        }
        var array = [];

        function tambah(){
            let pem= document.getElementsByClassName("tmb");

            document.getElementById("sc").style.display = "block";
            document.getElementById("sb").style.display = "none";
        }
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
        function kat(){
            var kat = document.getElementById("kategori").value;
            if( kat == "0" ){
                document.getElementById('namaproduk').disabled = true;
            }else{
                document.getElementById('namaproduk').disabled = false;
            }
        }
        function tanggal(){
            var tglawal = document.getElementById("tgla").value;
                // console.log("tanggal awal");
            if( tglawal != " " ){
                document.getElementById('tgle').disabled = false;
                document.getElementById('namacust').disabled = false;
            }else{
                document.getElementById('tgle').disabled = true;
                document.getElementById('namacust').disabled = true
            }
        }

        function tgla(){
            $.ajax({
                type: "get",
                url: "get-tanggal.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                    $('.datatr').html(url);
                    
                }
            });
        }
        function carinama(){
            var nama = document.getElementById("namaproduk").value;
            var kat = document.getElementById("kategori").value;
            $.ajax({
                type: "get",
                url: "get-namaproduk.asp",
                data : {  kategori : kat, namaproduk : nama  },
                success: function (data) {
                    $('.datatr').html(data);
                }
            });
        }
        
    </script>
    </head>
<body >
    <!--Breadcrumb-->   

        <div class="container" style="margin:10px" >
        <div class="navigasi" >
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb ">
                    <li class="breadcrumb-item">
                    <a href="<%=base_url%>/Admin/dashboard.asp" >Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="#" >Laporan</a></li>
                    <li class="breadcrumb-item"><a href="index.asp" >Laporan Pembelian</a></li>
                </ol>
            </nav>
        </div>
        </div>
    <hr size="10px" color="#ececec">
    
    <!-- Laporan Penjualan -->
    <div class="penjualan">
        <div class="lap-penjualan mt-2">
            <div class="row">
                <div class="col-12">
                    <span class="txt-judul"> Periode Laporan </span><br>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-4">
                    <span class="txt-desc"> Tanggal Pembelian  </span><br>
                    <div class="row">
                        <div class="col-12">
                            <input  class="txt-desc inp-penjualan-cari text-center" type="date" name="tgla" id="tgla" value="" style="width:10rem" onchange="tgla(),tanggal()">  <span class="txt-desc"> s.d  </span>
                            <input  disabled="true" class="txt-desc inp-penjualan-cari text-center" type="date" name="tgle" id="tgle" value="" style="width:10rem" onchange="tgla(),tanggal()">
                        </div>
                    </div>
                    <script>
                    var date = new Date();

                    var day = date.getDate();
                    var month = date.getMonth() + 1;
                    var year = date.getFullYear();

                    if (month < 10) month = "0" + month;
                    if (day < 10) day = "0" + day;

                    var today = year + "-" + month + "-" + day;


                    document.getElementById("tgla").value = today;
                    document.getElementById("tgle").value = today;
                </script>
                </div>
                <div class="col-6">
                    <span class="txt-desc"> Pilih Berdasarkan Nama Supplier </span><br>
                    <div class="row">
                        <div class="col-12">
                            <input   class=" inp-penjualan-cari txt-desc" type="hidden" name="customer" id="customer" value="">
                            <input disabled="true" onfocus="listcust()" class=" inp-penjualan-cari txt-desc" type="text" name="namacust" id="namacust" value="" placeholder="Pilih Tanggal Awal dan Tanggal Akhir Terlebih Dahulu">
                        </div>
                    </div>
                </div>
                <div class="col-2">
                <span class="txt-desc"></span><br>
                    <div class="dropdown">
                        <button class="btn-download-lap txt-desc dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        Download Laporan 
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <li>
                                <button class="btn-sp txt-desc" onclick="window.open('lappdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&spID='+document.getElementById('customer').value,'_Self')">Laporan PDF</button>
                            </li>
                            <li>
                                <button class="btn-sp txt-desc" onclick="window.open('lapexc.asp?spID='+document.getElementById('customer').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Excel </button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="datapembeli"  style="display:none; height:10rem; overflow-x:hidden;overflow-y:scroll">
            <div class="row mt-2">
                <div class="col-4">
                </div>
                <div class="col-6">
                    <table class="table inp-penjualan-cari table-bordered table-condensed"  style=" font-size:12px" >
                    <% do while not Supplier.eof %>
                    
                        <tr>
                            <td class="text-center" style="width:5px"><input onchange="ckcust<%=Supplier("spID")%>(this,<%=Supplier("spID")%>)" type="checkbox" name="<%=Supplier("spNama1")%>" id="<%=Supplier("spID")%>" value="<%=Supplier("spID")%>" ></td>
                            <td><%=Supplier("spNama1")%></td>
                        </tr>
                        
                    <script>
                    var array = [];
                        // console.log(array);
                    function ckcust<%=Supplier("spID")%>(ck){
                        var spID = ck.value+",";
                        var namacust = ck.name+",";
                        // console.log(spID);
                        var id = ck.value+",";
                        if (ck.checked){
                            var obj = { 
                                spID : id,
                                namacust,
                            }
                            array.push(obj);
                                array.map((key)=> {
                                    cust = spID;
                                    nama = namacust;
                                    console.log(nama);
                                    document.getElementById("customer").value = cust;
                                    document.getElementById("namacust").value = namacust;
                        });
                        // console.log(array);
                        
                        
                        // document.getElementById("total").value = total;
                        // document.getElementById("idproduk").value = document.getElementById("idproduk").value +id;
                        // document.getElementById("jumlah").value = document.getElementById("jumlah").value +jml;
                        // document.getElementById("tbarang").value= tqty;

                        // }else{
                        //     var uncek = array.filter((key)=> key.id != id)
                        //     array = uncek
                        //         array.map((key)=> {
                        //         total += Number(key.total)
                        //         tqty += Number(key.tqty)
                        // });

                        // // console.log(tqty);
                        // document.getElementById("total").value = total;
                        // document.getElementById("idproduk").value = document.getElementById("idproduk").value +id;
                        // document.getElementById("jumlah").value = document.getElementById("jumlah").value +jml;
                        // document.getElementById("tbarang").value= tqty;
                        // }
                    }
                        // var array = []
                        // console.log(array);
                        // function ckcust<%'=customer("custID")%>(id){
                        //     var checkboxes = document.querySelectorAll('input[type=checkbox]:checked')
                        //     var ck = document.querySelectorAll('input[type=checkbox]:checked')
                        //         for (var i = 0; i < checkboxes.length; i++) {
                        //             id = checkboxes[i].value;
                        //             id = checkboxes[i].name;
                        //             console.log(id);
                                    
                        //             var obj = {
                        //                 id : checkboxes[i].value,
                        //             }
                        //         array.push(obj)
                        //         array.map(key=> {
                        //             document.getElementById("customer").value = id+",";
                        //         })
                        //     }
                        // }
                    }
                    </script>
                    <% Supplier.movenext
                    loop %>
                    </table>
                </div>
                <div class="col-2">
                </div>
            </div>
            </div>
        </div>
        <div class="lap-penjualan mt-2">
            <div class="row align-items-center ">
                <div class="col-5">
                    <span class="txt-desc"> Filter Sesuai : </span><br>
                    <select disabled class="inp-penjualan-cari txt-desc form-select" aria-label="Default select example" style="width:12rem">
                        <option selected> Pilih Filter </option>
                        <option value="1"> Harga Terendah </option>
                        <option value="2"> Harga Tertinggi </option>
                        <option value="3"> Tanggal Upload Produk </option>
                        <option value="4"> Penjualan Tertinggi </option>
                        <option value="5"> Penjualan Terendah </option>
                    </select>
                </div>
                <div class="col-2">
                    <span class="txt-desc"> Kategori Produk </span><br>
                    <select onchange="kat()" name="kategori" id="kategori" class="inp-penjualan-cari txt-desc form-select" aria-label="Default select example" style="width:12rem">
                        <option value="0" selected> Pilih Kategori Produk </option>
                        <% do while not kategori.eof %>
                        <option value="<%=kategori("catID")%>"><%=kategori("catName")%></option>
                        <% kategori.movenext
                        loop %>
                    </select>
                </div>
                <div class="col-5">
                    <span class="txt-desc" Style="color:red"><b><i> * Pilih Kategori Produk Terlebih Dahulu </b></i></span><br>
                    <input disabled="true" onkeyup="carinama()" class="txt-desc inp-penjualan-cari" type="search" name="namaproduk" id="namaproduk" value="" placeholder="Masukan Nama Produk" style="width:32rem">
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-12">
                    <div class="table-tr">
                        <table class="table  table-bordered table-condensed"  style=" font-size:12px" >
                            <thead class="text-center">
                                <tr>
                                    <th> No  </th>
                                    <th> Tanggal  </th>
                                    <th> Nama Supplier </th>
                                    <th> Nama Produk</th>
                                    <th> Qty </th>
                                    <th> Harga </th>
                                    <th> Total </th>
                                </tr>
                            </thead>
                            <tbody class="datatr" style="overflow-y:auto; ">
                            <%
                                no = 0 
                                do while not Ps.eof
                                no = no + 1
                            %>
                            
                            <tr>
                                <td class="text-center"><%=no%></td>
                                <td class="text-center"><%=MonthName(Ps("Bulan"))%> - <%=CDate(Ps("mmTanggal"))%></td>
                                <td><%=Ps("spNama1")%></td>
                                <td><%=Ps("pdNama")%></td>
                                <td class="text-center"><%=Ps("mm_pdQtyDiterima")%></td>
                                <td class="text-center"><%=Replace(FormatCurrency(Ps("mm_pdHarga")),"$","Rp. ")%></td>
                                <%total = Ps("mm_pdQtyDiterima") * Ps("mm_pdHarga") %>
                                <td class="text-center"><%=Replace(FormatCurrency(total),"$","Rp. ")%></td>
                            </tr>
                            <%
                                Ps.movenext
                                loop
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Laporan Penjualan -->

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
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>