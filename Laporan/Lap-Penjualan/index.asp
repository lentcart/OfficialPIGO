<!--#include file="../../connections/pigoConn.asp"--> 
<% if request.Cookies("custEmail")="" then

response.redirect("../")

end if
%> 
<% 

e= Request.queryString("e")

%> 
<%

    set Customer_cmd = server.createObject("ADODB.COMMAND")
	Customer_cmd.activeConnection = MM_PIGO_String
			
	Customer_cmd.commandText = "SELECT MKT_M_Customer.custNama, MKT_M_Customer.custID,  MKT_M_Customer.custEmail FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN  MKT_T_Transaksi_H ON MKT_M_Customer.custID = MKT_T_Transaksi_H.tr_custID RIGHT OUTER JOIN  MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) where MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' GROUP BY MKT_M_Customer.custNama, MKT_M_Customer.custID, MKT_M_Customer.custEmail"
    
    'response.write Customer_cmd.commandText
	set Customer = Customer_cmd.execute

    set Ps_cmd = server.createObject("ADODB.COMMAND")
	Ps_cmd.activeConnection = MM_PIGO_String
			
	Ps_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_H.tr_strID, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_H.tr_custID, buyer.custNama, buyer.custEmail, buyer.custPhone1, buyer.custPhone2, MKT_T_Transaksi_H.tr_almID, almbuyer.almNamaPenerima, almbuyer.almPhonePenerima, almbuyer.almLengkap, almbuyer.almLabel, almbuyer.almProvinsi, almbuyer.almLatt, almbuyer.almLong, almbuyer.almKota, almbuyer.almKel, almbuyer.almKec, almbuyer.almKdpos, MKT_T_Transaksi_H.tr_strID, MKT_T_Transaksi_H.trTglTransaksi AS tanggaltr, MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_T_Transaksi_D1A.tr_pdID, MKT_M_Produk.pdNama, MKT_M_Produk.pdLayanan, MKT_M_Produk.pdHargaBeli,MKT_M_Produk.pdHargaJual, MKT_M_Produk.pdBerat, MKT_M_Produk.pdPanjang, MKT_M_Produk.pdLebar, MKT_M_Produk.pdTinggi, MKT_M_Produk.pdVolume, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty AS trQty, MKT_M_Produk.pd_almID, almseller.almNamaPenerima AS NamaPengirim, almseller.almKota AS sellerkota, almseller.almKec AS sellerkec, almseller.almKec AS sellerkel, almseller.almProvinsi AS sellerprov, almseller.almKdpos AS sellerkdpos, almseller.almLengkap AS selleralm, almseller.almLatt AS sellerlatt, almseller.almLong AS sellerlong, almseller.almPhonePenerima AS sellerphone, MKT_M_Customer.custID, MKT_M_Customer.custNama AS namaseller, MKT_M_Customer.custEmail AS emailseller, MKT_M_Customer.custPhone1 AS phoneseller, MKT_T_Transaksi_D2.trD2, MKT_T_Transaksi_D2.trSubTotal, MKT_T_Transaksi_D2.trJenisPembayaran, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName FROM MKT_M_Alamat AS almbuyer RIGHT OUTER JOIN MKT_T_Transaksi_D2 RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_H.tr_strID ON LEFT(MKT_T_Transaksi_D2.trD2, 12) = MKT_T_Transaksi_H.trID ON almbuyer.almID = MKT_T_Transaksi_H.tr_almID LEFT OUTER JOIN MKT_M_Customer AS buyer ON MKT_T_Transaksi_H.tr_custID = buyer.custID LEFT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Customer.custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A LEFT OUTER JOIN MKT_M_Alamat AS almseller RIGHT OUTER JOIN MKT_M_Produk ON almseller.almID = MKT_M_Produk.pd_almID ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID ON MKT_T_Transaksi_D1.trD1 = LEFT(MKT_T_Transaksi_D1A.trD1A, 16) ON  MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) where  MKT_T_Transaksi_D1.tr_slID  = '"& request.Cookies("custID") &"' and  MKT_T_Transaksi_H.tr_strID = '03'"

    'response.write Ps_cmd.commandText

	set Ps = Ps_cmd.execute

    
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../DataTables/datatables.css">
        <link rel="stylesheet" type="text/css" href="list-produk.css">
        <link rel="stylesheet" type="text/css" href="penjualan.css">
        <link rel="stylesheet" type="text/css" href="supplier.css">
        <link rel="stylesheet" type="text/css" href="../../fontawesome/css/all.min.css">
        <script src="../../js/jquery-3.6.0.min.js"></script>
        <script src="../../DataTables/datatables.min.js"></script>
        <script src="../../DataTables/datatables.js"></script>

        <title>PIGO</title>
        
    <script>
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
$(document).ready(function() {
    $('#example').DataTable( {
    } );
} );
        
            
        
    </script>
    </head>
<body onload="loaddata()">
    <!--Breadcrumb-->   

        <div class="container" style="margin:10px" >
        <div class="navigasi" >
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb ">
                    <li class="breadcrumb-item">
                    <a href="../../Seller/index.asp" >Seller Home</a></li>
                    <li class="breadcrumb-item"><a href="#" >Laporan</a></li>
                    <li class="breadcrumb-item"><a href="index.asp" >Laporan Penjualan</a></li>
                </ol>
            </nav>
        </div>
        </div>
    <hr size="10px" color="#ececec">
    
    <!--Body Supplier-->
        <div class="judul-produk" style=" background-color:white; margin:45px; margin-top:0">  
            <div class="row align-items-center" id="sb">
                <div class="col-5">
                <span class="text-span-sp"> Periode Laporan </span>
                    <input class="text-sp text-center" type="date" name="tgla" id="tgla" value="" style="width:10rem" onchange="tgla()"> s.d
                    <input class="text-sp text-center" type="date" name="tgle" id="tgle" value="" style="width:10rem" onchange="tgla()">
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
                <div class="col-5">
                <div class="row">
                    <div class="col-12">
                        <span class="text-span-sp">  Customer </span>
                        <script>
                        function custt(){
                            $.ajax({
                                type: "get",
                                url: "get-data.asp?customerid="+document.getElementById("customerid").value+"&tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                                success: function (url) {
                                    // console.log(url);
                                $('.datatr').html(url);
                                    
                                }
                            });
                        }
                        </script>
                        <input onfocus="return cust()"  type="text" name="customerid" id="customerid" value="" style=" font-size:11px; padding:5px; width:25rem; border-radius:10px; border:1px solid #eeeeee" readonly>
                    </div>
                </div>
                <div class="row " style="display:none;" id="cust">
                    <div class="col-12 ">
                        <div class="ck" style="width:25rem;  background-color:white; margin-left:4.2rem; border-radius:10px; border:1px solid #eeeeee; padding:10px 10px; heigth:100%">


                            <%do while not Customer.eof%>
                             <script>
                        
                                function checkcust<%=Customer("custID")%>(cek){
                                    // var array = []
                                    // // console.log(array);
                                    
                                    //     var checkboxes = document.querySelectorAll('input[type=checkbox]:checked')
                                    //     for (var i = 0; i < checkboxes.length; i++) {
                                    //         var obj = {
                                    //             id : checkboxes[i].value,
                                    //         }
                                    //     array.push(obj)
                                    //     array.map(key=> {
                                    //         document.getElementById("customerid").value = id[i];
                                    //     })
                                    // }
                                

                                    if (cek.checked){
                                        var id = cek.value+",";
                                        document.getElementById("customerid").value = document.getElementById("customerid").value +id;
                                    }else{

                                    }
                                }
                            </script>


                                <input class=""  type="checkbox" name="checkbox-custid" id="<%=Customer("custID")%>" value="<%=Customer("custID")%>" onchange="checkcust<%=Customer("custID")%>(this,<%=Customer("custID")%>);custt()">
                                <span class="text-updatealamat"  style="font-size:12px"><%=Customer("custNama")%></span><br>
                                
                            <%Customer.movenext
                            loop%>

                        </div>
                    </div>
                </div>
                </div>
                <div class="col-2">
                <div class="dropdown">
                <button class="dp-btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                    Download Laporan 
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                    <li><button class="btn-sp" onclick="window.open('lap-penjualan.asp?custID='+document.getElementById('customerid').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')">Laporan PDF</button></li>
                    <li><button class="btn-sp" onclick="window.open('exp-excel.asp?custID='+document.getElementById('customerid').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Excel </button></li>
                    <li><button class="btn-sp" onclick="window.open('lap-harian.asp?custID='+document.getElementById('customerid').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Harian</button></li>
                    <li><button class="btn-sp" onclick="window.open('lap-bulanan.asp?custID='+document.getElementById('customerid').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Bulanan</button></li>
                </ul>
                </div>
                
            </div>
            <!--<div class="row" id="cont-cust">
                <div class="col-12">
                
                </div>
            </div>-->
            <div class="row mt-4" id="sb">
                <div class="col-12">
                    <div class="table-tr">
                        <table class="table  table-bordered table-condensed" table id="example" style=" font-size:11px" >
                            <thead class="text-center">
                                <tr>
                                    <th> Tanggal </th>
                                    <th> Nama Customer</th>
                                    <th> Nama Produk </th>
                                    <th> Harga Beli </th>
                                    <th> Harga Jual </th>
                                    <th> QTY  </th>
                                    <th> Total Pembelian  </th>
                                    <th> Keterangan </th>
                                </tr>
                            </thead>
                            <tbody class="datatr" style="overflow-y:auto; ">
                            <%
                                no=0
                                do while not Ps.eof
                                no=no+1
                            %>
                            
                            <input type="hidden" name="custID" id="custID<%=no%>" value="<%=ps("tr_custID")%>" >
                            <tr>
                                <td><%=Ps("trTglTransaksi")%></td>
                                <td><%=Ps("custNama")%></td>
                                <td><%=Ps("pdNama")%></td>
                                <td><%=Replace(FormatCurrency(Ps("pdHargaBeli")),"$","Rp.  ")%></td>
                                <td><%=Replace(FormatCurrency(Ps("tr_pdHarga")),"$","Rp.  ")%></td>
                                <td><%=Ps("tr_pdQty")%></td>
                                <td><%=Replace(FormatCurrency(Ps("trSubTotal")),"$","Rp.  ")%></td>
                                <td><%=Ps("strName")%></td>
                            </tr>
                            <%
                                Ps.movenext
                                loop
                                nomor = no
                            %>
                            <input type="hidden" name="no" id="no" value="<%=nomor%>" >
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Body Supplier-->

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