<!--#include file="../../../connections/pigoConn.asp"--> 
 
<% 

e= Request.queryString("e")

%> 
<%
    if request.Cookies("custEmail")="" then

    response.redirect("../../../")

    end if

    set kategori_cmd = server.createObject("ADODB.COMMAND")
    kategori_cmd.activeConnection = MM_PIGO_String

    kategori_cmd.commandText = "SELECT * FROM MKT_M_Kategori where catAktifYN = 'Y' "
    'response.write kategori_cmd.commandText
    set kategori = kategori_cmd.execute 

    set type_cmd = server.createObject("ADODB.COMMAND")
    type_cmd.activeConnection = MM_PIGO_String

    type_cmd.commandText = "SELECT pdType FROM MKT_M_Produk where pd_custID = '"& request.Cookies("custID") &"' GROUP BY pdType "
    'response.write type_cmd.commandText
    set typepd = type_cmd.execute

    set Customer_cmd = server.createObject("ADODB.COMMAND")
	Customer_cmd.activeConnection = MM_PIGO_String
			
	Customer_cmd.commandText = "SELECT MKT_M_Customer.custNama, MKT_M_Customer.custID,  MKT_M_Customer.custEmail FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN  MKT_T_Transaksi_H ON MKT_M_Customer.custID = MKT_T_Transaksi_H.tr_custID RIGHT OUTER JOIN  MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) where MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' GROUP BY MKT_M_Customer.custNama, MKT_M_Customer.custID, MKT_M_Customer.custEmail"
    
    'response.write Customer_cmd.commandText
	set Customer = Customer_cmd.execute

    set Transaksi_cmd = server.createObject("ADODB.COMMAND")
	Transaksi_cmd.activeConnection = MM_PIGO_String
			
	Transaksi_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.trD1A, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.tr_strID, MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_M_Produk.pdID, MKT_M_Produk.pdNama, MKT_M_Produk.pdType, MKT_M_Produk.pdSku, MKT_M_Customer.custNama, MKT_M_Customer.custEmail FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID  WHERE  MKT_T_Transaksi_D1.tr_slID  = '"& request.Cookies("custID") &"' and  MKT_T_Transaksi_D1.tr_strID = '03'  GROUP BY MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.trD1A, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.tr_strID, MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_M_Produk.pdID, MKT_M_Produk.pdNama, MKT_M_Produk.pdType, MKT_M_Produk.pdSku, MKT_M_Customer.custNama, MKT_M_Customer.custEmail "
    'response.write Transaksi_cmd.commandText
	set Transaksi = Transaksi_cmd.execute

    
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
        <link rel="stylesheet" type="text/css" href="penjualan.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
        <script src="<%=base_url%>/DataTables/datatables.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>

        <title>PIGO</title>
        
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
        // function customerid(){
        //     var a = document.getElementById('customerid').value;
            
        //     if (a == ""){
        //         $.get("../../ajax/get-customer.asp",function(data){
        //             $('#cont-cust').show();
        //             $('.modal-cust').html(data);

        //         })        
        //     }else if ( a !== "" ){
        //         $.get(`ajax/get-produk.asp?a=${a}`,function(data){
        //             $('.modal-src').html(data);
        //         })
        //     }
        // }
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
                document.getElementById('pdtype').disabled = true;
            }else{
                document.getElementById('pdtype').disabled = false;
                var pdtype = document.getElementById('pdtype').value;
                if ( pdtype == "0"){
                    document.getElementById('namaproduk').disabled = true;
                }else{
                    document.getElementById('namaproduk').disabled = false;
                }
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
            var pdtype = document.getElementById("pdtype").value;
            $.ajax({
                type: "get",
                url: "get-namaproduk.asp",
                data : {  kategori : kat, pdtype : pdtype, namaproduk : nama  },
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
                    <a href="<%=base_url%>/Seller/" >Seller Home</a></li>
                    <li class="breadcrumb-item"><a href="#" >Laporan</a></li>
                    <li class="breadcrumb-item"><a href="index.asp" >Laporan Penjualan</a></li>
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
            <div class="row">
                <div class="col-4">
                    <span class="txt-desc"> Tanggal Transaksi  </span><br>
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
                    <span class="txt-desc"> Pilih Berdasarkan Pembeli Seller : [ <%=request.Cookies("custNama")%> ]  </span><br>
                    <div class="row">
                        <div class="col-12">
                            <input   class=" inp-penjualan-cari txt-desc" type="hidden" name="customer" id="customer" value="">
                            <input disabled="true" onfocus="listcust()" class=" inp-penjualan-cari txt-desc" type="text" name="namacust" id="namacust" value="" placeholder="Pilih Tanggal Awal dan Tanggal Akhir Terlebih Dahulu">
                        </div>
                    </div>
                </div>
                <div class="col-2">
                    <div class="dropdown">
                        <button class="btn-download-lap txt-desc dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        Download Laporan 
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <li>
                                <button class="btn-sp txt-desc" onclick="window.open('lappdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&custID='+document.getElementById('customer').value,'_Self')">Laporan PDF</button>
                            </li>
                            <li>
                                <button class="btn-sp txt-desc" onclick="window.open('lapexc.asp?custID='+document.getElementById('customer').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Excel </button>
                            </li>
                            <li>
                                <button class="btn-sp txt-desc" onclick="window.open('lap-penjualan-harian.asp?custID='+document.getElementById('customer').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Harian</button>
                            </li>
                            <li>
                                <button class="btn-sp txt-desc" onclick="window.open('lap-penjualan-bulanan.asp?custID='+document.getElementById('customer').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Bulanan</button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="datapembeli"  style="display:none; height:10rem; overflow-x:hidden;overflow-y:scroll">
            <div class="row mt-2">
                <div class="col-4 me-2">
                </div>
                <div class="col-6">
                    <table class="table inp-penjualan-cari table-bordered table-condensed"  style=" font-size:12px" >
                    <% do while not customer.eof %>
                    
                        <tr>
                            <td class="text-center" style="width:5px"><input onchange="ckcust<%=customer("custID")%>(this,<%=customer("custID")%>)" type="checkbox" name="<%=customer("custNama")%>" id="<%=customer("custID")%>" value="<%=customer("custID")%>" ></td>
                            <td><%=customer("custNama")%></td>
                        </tr>
                        
                    <script>
                    var array = [];
                        console.log(array);
                    function ckcust<%=customer("custID")%>(ck){
                        var custID = ck.value+",";
                        var namacust = ck.name+",";
                        console.log(custID);
                        var id = ck.value+",";
                        if (ck.checked){
                            var obj = { 
                                custID : id,
                                namacust,
                            }
                            array.push(obj);
                                array.map((key)=> {
                                    cust = custID;
                                    nama = namacust;
                                    console.log(nama);
                                    document.getElementById("customer").value = cust;
                                    document.getElementById("namacust").value = namacust;
                        });
                        console.log(array);
                        
                        
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
                        // function ckcust<%=customer("custID")%>(id){
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
                    <% customer.movenext
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
                <div class="col-3">
                    <span class="txt-desc"> Filter Sesuai : </span><br>
                    <select disabled class="inp-penjualan-cari txt-desc form-select" aria-label="Default select example" style="width:12rem">
                        <option selected> Pilih Filter </option>
                        <option value="1"> Harga Terendah </option>
                        <option value="2"> Harga Tertinggi </option>
                        <option value="3"> Tanggal Upload Produk </option>
                        <option value="3"> Penjualan Tertinggi </option>
                        <option value="3"> Penjualan Terendah </option>
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
                <div class="col-2">
                    <span class="txt-desc"> Type Produk </span><br>
                    <select onchange="kat()" disabled="true" name="pdtype" id="pdtype" class="inp-penjualan-cari txt-desc form-select" aria-label="Default select example" style="width:12rem">
                        <option value="0" selected> Pilih Type Produk </option>
                        <% do while not typepd.eof %>
                        <option value="<%=typepd("pdType")%>"><%=typepd("pdType")%></option>
                        <% typepd.movenext
                        loop %>
                    </select>
                </div>
                
                <div class="col-5">
                    <span class="txt-desc" Style="color:red"><b><i> * Pilih Kategori Produk dan Type Produk Terlebih Dahulu </b></i></span><br>
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
                                    <th> Tanggal </th>
                                    <th> Jenis Pembayaran </th>
                                    <th> Nama Customer</th>
                                    <th> Ongkos Kirim  </th>
                                    <th> Nama Produk </th>
                                    <th> Harga </th>
                                    <th> QTY  </th>
                                    <th> Total Pembelian  </th>
                                </tr>
                            </thead>
                            <tbody class="datatr" style="overflow-y:auto; ">
                            <% do while not Transaksi.eof %>
                                <tr>
                                    <td class="text-center"> <%=Transaksi("trID")%> - <%=CDate(Transaksi("trTglTransaksi"))%> </td>
                                    <td class="text-center"> <%=Transaksi("trJenisPembayaran")%> </td>
                                    <td> <%=Transaksi("custNama")%> [<%=Transaksi("custEmail")%>]</td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(Transaksi("trBiayaOngkir")),"$","Rp. ")%></td>
                                    <td> <%=Transaksi("pdNama")%> </td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(Transaksi("tr_pdHarga")),"$","Rp. ")%> </td>
                                    <td class="text-center"> <%=Transaksi("tr_pdQty")%> </td>
                                    <% totalpembelian = Transaksi("trBiayaOngkir")+Transaksi("tr_pdHarga")*Transaksi("tr_pdQty")%>
                                    <td class="text-center"> <%=Replace(FormatCurrency(totalpembelian),"$","Rp. ")%> </td>
                                </tr>
                            <% Transaksi.movenext
                            loop %>
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
    .To(notifications)
    .fadeOut(3000, function() {
    n.remove();
    });
    }
    });
</script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>