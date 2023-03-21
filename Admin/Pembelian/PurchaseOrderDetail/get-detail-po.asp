
<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 

    response.redirect("../admin/")
    
    end if
    
    poID = request.queryString("poID")

    set BussinesPartner = server.createObject("ADODB.COMMAND")
	BussinesPartner.activeConnection = MM_PIGO_String

        BussinesPartner.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE MKT_T_PurchaseOrder_H.poID = '"& poID &"' GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi"
        'response.write Produk_cmd.commandText

    set BussinesPartner = BussinesPartner.execute

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String


%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-11 col-md-10 col-sm-12">
                        <span class="cont-text"> DETAIL  PURCHASE ORDER  : <%=poID%> </span>
                    </div>
                    <div class="col-lg-1 col-md-2 col-sm-12">
                        <button class="cont-btn" onclick="window.open('../PurchaseOrderDetail/','_Self')"> Kembali </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <span class="cont-text"> Data Bussines Partner </span>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <span class="cont-text"> Nama  </span><br>
                        <span class="cont-text"> Alamat  </span><br>
                    </div>
                    <div class="col-lg-10 col-md-10 col-sm-10">
                        <span class="cont-text"> <%=BussinesPartner("custNama")%> </span><br>
                        <span class="cont-text"> <%=BussinesPartner("almLengkap")%>  </span><br>
                    </div>
                </div>
            </div>
            
            <div class="row p-2">
                <div class="col-lg-10 col-md-10 col-sm-10 text-start">
                    <span class="cont-text"> DATA PRODUK PURCHASE ORDER</span>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-2 text-end">
                    <button class="cont-btn" onclick="window.open('lap-detail-po.asp?poid='+document.getElementById('poid').value,'_Self')"> Cetak </button>
                </div>
            </div>
            
            <div class="row  align-items-center p-2">
                <div class="col-12">
                    <div class="cont-tb" style="overflow:scroll">
                        <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px; width:100rem">
                            <thead>
                                <tr class="text-center">
                                    <th>NO</th>
                                    <th>TGL PO</th>
                                    <th>NAMA </th>
                                    <th>HARGA PRODUK</th>
                                    <th>PO QTY</th>
                                    <th>HARGA PO </th>
                                    <th> PO PAJAK </th>
                                    <th> STATUS </th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                            <%
                                produk_cmd.commandText = " SELECT MKT_T_PurchaseOrder_H.poID,MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_D.po_pdID, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poPdUnit,  MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak, MKT_M_PIGO_Produk.pdNama, MKT_T_PurchaseOrder_D.poSubTotal, MKT_M_StatusPurchaseOrder.spoName,  MKT_M_PIGO_Produk.pdHarga,MKT_T_PurchaseOrder_D.po_spoID FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_StatusPurchaseOrder ON MKT_T_PurchaseOrder_D.po_spoID = MKT_M_StatusPurchaseOrder.spoID LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE MKT_T_PurchaseOrder_H.poID = '"& poID &"' AND MKT_T_PurchaseOrder_H.po_custID = '"& BussinesPartner("custID") &"' "
                                'response.write Produk_cmd.commandText
                                set produk = produk_cmd.execute
                            %>
                            <% 
                                no = 0
                                do while not produk.eof 
                                no = no + 1
                            %>
                            <tr>
                                <td class="text-center"><%=no%></td>
                                <td class="text-center">
                                    <%=CDate(produk("poTanggal"))%>
                                    <input type="hidden" name="poid" id="poid" value="<%=produk("poID")%>">
                                </td>
                                <td><%=produk("pdNama")%> - [<%=produk("pdPartNumber")%>]</td>
                                <td class="text-center"><%=Replace(FormatCurrency(produk("pdHarga")),"$","Rp. ")%></td>
                                <td class="text-center"><%=produk("poQtyProduk")%></td>
                                <td class="text-center"><%=Replace(FormatCurrency(produk("poHargaSatuan")),"$","Rp. ")%></td>
                                <td class="text-center"><%=produk("poPajak")%></td>
                                <td class="text-center"><%=produk("spoName")%></td>
                            </tr>
                            <% 
                                produk.movenext
                                loop 
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
    <script>
    function AddBussinesPart() {
        var poTanggal = $('input[name=tanggalpo]').val();
        var poJenis = $('select[name=jenisinvoice]').val();
        var poJenisOrder = $('select[name=jenisorder]').val();
        var poTglOrder = $('input[name=tanggalorder]').val();
        var poTglDiterima = $('input[name=tanggalditerima]').val();
        var poStatusKredit = $('select[name=statuskredit]').val();
        var poDropShip = $('input[name=dropship]').val();
        var po_spID = $('select[name=bussinespartner]').val();
        var poKonfPem = $('select[name=poKonfPem]').val();
        $.ajax({
            type: "GET",
            url: "add-purchaseorder.asp",
            data:{
                poTanggal,
                poJenis,
                poJenisOrder,
                poTglOrder,
                poTglDiterima,
                poStatusKredit,
                poDropShip,
                po_spID,
                poKonfPem
            },
            success: function (data) {
                console.log(data);
                
                $('.data-POID').html(data);
                }
            });
        document.getElementById("btn-addpo").style.display = "none"
        document.getElementById("cont-Produk-PO").style.display = "block";
        $('#bussinespartner').attr('disabled',true);
        var permintaan = document.querySelectorAll("[id^=cont]");
        
        for (let i = 0; i < permintaan.length; i++) {
            permintaan[i].setAttribute("readonly", true);
            permintaan[i].setAttribute("disabled", true);
        }
            
    }
    function batal() {
        var poID = $('input[name=poID]').val();
        $.ajax({
            type: "POST",
            url: "delete-purchaseorder.asp",
                data:{
                    poID
                },
            success: function (data) {
                Swal.fire('Deleted !!', data.message, 'success').then(() => {
                location.reload();
                });
            }
        });
        document.getElementById("cont-Produk-PO").style.display = "none";
        $('#bussinespartner').removeAttr('disabled');
        $('#bussinespartner').val('');
        var permintaan = document.querySelectorAll("[id^=cont]");
        
        for (let i = 0; i < permintaan.length; i++) {
            permintaan[i].removeAttribute("readonly");
            permintaan[i].removeAttribute("disabled");
            permintaan[i].value="";
        }
    }
        function getBussines(){
            var s = document.getElementById("bussinespartner").value;
            //console.log(s);
            
            $.ajax({
                type: "get",
                url: "get-Bussines.asp?bussines="+s,
                success: function (url) {
                // console.log(url);
                $('.cont-Bussines').html(url);
                                    
                }
            });
        }
        function tax(){
            var tax = document.getElementById("ppn").value;
            var qty = parseInt(document.getElementById("qtyproduk").value);
            var harga = parseInt(document.getElementById("harga").value);
            //console.log(tax);
            
            if( tax == "0" ){
                var total = Number(qty*harga);
                document.getElementById("subtotalpo").value = total;
                document.getElementById("totalpo").value = total;
                // console.log(total);
                
            }else{
                tax = 11;
                var total = Number(qty*harga);
                pajak = tax/100*total;
                subtotal = total+pajak;
                var grandtotal = Math.round(subtotal);
                document.getElementById("subtotalpo").value = total;
                document.getElementById("totalpo").value = grandtotal;
                // console.log(subtotal);
                
            }

        }
        // function totalline(){
        //     var qty = parseInt(document.getElementById("qtyproduk").value);
        //     var harga = parseInt(document.getElementById("harga").value);
        //     var total = Number(qty*harga);
        //     document.getElementById("subtotalpo").value = total;
        //     // console.log(qty, harga, total);
        // };
        // document.addEventListener("DOMContentLoaded", function(event) {
        //     totalline();
        // });
        function getproduk(){
            var pdID = document.getElementById("pdID").value;
            
            $.ajax({
                type: "get",
                url: "loadproduk.asp?pdID="+document.getElementById("pdID").value,
                success: function (url) {
                // console.log(url);
                $('.datapd').html(url);
                                    
                }
            });
        }

        function sendproduk(){
            var poID = $('#poID').val();
            var poTanggal = $('input[name=tanggalpo]').val();
            var po_pdID = $('#produkid').val();
            var poQtyProduk = $('#qtyproduk').val();
            var poPdUnit = $('#unitproduk').val();
            var poHarga = $('#hargabulat').val();
            var poPajak = $('#ppn').val();
            var poDiskon = $('#diskon').val();
            var poSubTotal = $('#subtotalpo').val();
            var poTotal = $('#totalpo').val();
            $.ajax({
                type: "get",
                url: "add-produkpo.asp",
                    data:{
                        poID,
                        poTanggal,
                        po_pdID,
                        poQtyProduk,
                        poPdUnit,
                        poHarga,
                        poPajak,
                        poDiskon,
                        poSubTotal,
                        poTotal
                    },
                success: function (data) {
                    document.getElementById("loader-page").style.display = "block";
                    setTimeout(() => {
                    document.getElementById("loader-page").style.display = "none";
                    
                        // Swal.fire({
                        //     title: 'Ingin Menambah Produk Lagi ?',
                        //     showDenyButton: true,
                        //     showCancelButton: true,
                        //     confirmButtonText: 'Iya',
                        //     denyButtonText: `Tidak`,
                        //     }).then((result) => {
                        //     if (result.isConfirmed) {
                        //         location.reload();
                        //     } else if (result.isDenied) {
                        //         window.open(`../PurchaseOrderDetail/buktipo.asp?poID=${poID}&tanggalpo=${poTanggal}`,`_Self`)
                        //     }
                        // })
                    }, 1000);
                    document.getElementById("katakunci").value = "";
                    document.getElementById("namaproduk").value = "";
                    document.getElementById("skuproduk").value = "";
                    document.getElementById("lokasirak").value = "";
                    document.getElementById("unitproduk").value = 0;
                    document.getElementById("harga").value = 0;
                    document.getElementById("qtyproduk").value = 0;
                    document.getElementById("ppn").value = "";
                    document.getElementById("subtotalpo").value = 0;
                    document.getElementById("totalpo").value = 0;
                    document.getElementById("diskon").value = "0";
                    document.getElementById("pdID").value = "";

                    $('.data-produk').html(data);
                }
            });
        }
        function aaa(){
            var bb = document.getElementById("calc").value;
            var c = Math.round(eval(bb));
                document.getElementById("harga").value = eval(c);
                document.getElementById("hargabulat").value = eval(c);
        }
        function openkalkulator(){
            var btnkal = document.getElementById("kalkulator");
            if(btnkal.checked == true){
                document.getElementById("cont-calculator-PO").style.display = "block";
            }else{
                document.getElementById("cont-calculator-PO").style.display = "none";
                document.getElementById("qtyproduk").value = 0;
                document.getElementById("subtotalpo").value = 0;
                document.getElementById("totalpo").value = 0;
            }
        }
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
        var modal = document.getElementById("myModal");
        var btn = document.getElementById("myBtn");
        var span = document.getElementsByClassName("closee")[0];
        btn.onclick = function() {
            modal.style.display = "block";
        }
        span.onclick = function() {
            modal.style.display = "none";
        }
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</html>