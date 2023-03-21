<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

        PermID = request.queryString("PermID")
        set Pengeluaran_CMD = server.createObject("ADODB.COMMAND")
        Pengeluaran_CMD.activeConnection = MM_PIGO_String

        Pengeluaran_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID,MKT_T_Permintaan_Barang_H.PermNo,MKT_T_Permintaan_Barang_H.Perm_trYN, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPhone2,  MKT_M_Customer.custPhone1, MKT_M_Customer.custEmail, MKT_M_Alamat.almLengkap, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, GLB_M_Bank.BankName FROM GLB_M_Bank RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_M_Rekening RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Rekening.rk_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID ON MKT_T_Permintaan_Barang_H.Perm_custID = MKT_M_Customer.custID ON GLB_M_Bank.BankID = MKT_M_Rekening.rkBankID WHERE almJenis <> 'Alamat Toko' and rkJenis <> 'Rekening Seller' and rkStatus = '1' and PermID = '"& PermID &"' "
        'response.write Pengeluaran_CMD.commandText 
        set Permintaan = Pengeluaran_CMD.execute
%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--#include file="../../IconPIGO.asp"-->

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        <script>
            function getKeySupplier(){
                $.ajax({
                    type: "get",
                    url: "get-bussinespartner.asp?keysearch="+document.getElementById("keysearch").value,
                    success: function (url) {
                    // console.log(url);
                    $('.keysp').html(url);
                    
                    }
                });
            }
            function getsupplier(){
                $.ajax({
                    type: "get",
                    url: "load-bussinespartner.asp?keysupplier="+document.getElementById("keysupplier").value,
                    success: function (url) {
                    // console.log(url);
                    $('.datasp').html(url);
                                        
                    }
                });
            }
            function tambah(){
                document.getElementById("cont-addpermintaan").style.display = "block"
                document.getElementById("cont-data").style.display = "none"
                document.getElementById("btn-add").style.display = "none"
            }
        </script>
        <style>
            .cont-sub{
                width:8rem; 
                background-color:#eee; 
                border:none; 
                color:black;
            }
        </style>
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-9 col-md-9 col-sm-12">
                        <span class="cont-text"> PENGELUARAN SUKU CADANG BARU </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button onclick="window.open('../Permintaan-Barang/List-Permintaan.asp','_Self')" name="btn-add" id="btn-add" class="cont-btn" style="display:block"><i class="fas fa-clipboard-list"></i>&nbsp;&nbsp; LIST PERMINTAAN</button> 
                    </div>
                </div>
            </div>
            <form class="" action="P-Pengeluaran-SCB.asp" method="POST">
                <div class="cont-background mt-2">
                    <div class="row">
                        <div class="col-6">
                            <span class="cont-text"> Type Dokumen  </span><br>
                            <select  class="cont-form" name="pscType" id="pscType" aria-label="Default select example" required >
                                <option value="">Pilih</option>
                                <option value="01">MM Shipment Indirect</option>
                                <option value="02">MM Shipment PIGO</option>
                            </select>
                        </div>
                        <div class="col-2">
                            <span class="cont-text"> Tanggal Pengeluaran </span><br>
                            <input  type="Date" class="cont-form" name="pscTanggal" id="pscTanggal" value="" required><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <span class="cont-text"> Deskripsi </span><br>
                            <textarea  name="pscDesc" id="pscDesc" class="cont-text" style="width:100%">Pengeluaran Suku Cadang Baru - <%=PermID%></textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3">
                            <span class="cont-text"> Delivery Rule </span><br>
                            <select  class="cont-form" name="pscDelRule" id="pscDelRule" aria-label="Default select example" required>
                                <option value="">Pilih</option>
                                <option value="01">After Receipt</option>
                                <option value="02">Availability</option>
                                <option value="03">Compelete Line</option>
                                <option value="04">Complete Order</option>
                                <option value="05">Force</option>
                                <option value="06">Manual</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <span class="cont-text"> Delivery Via </span><br>
                            <select  class="cont-form" name="pscDelVia" id="pscDelVia" aria-label="Default select example" required>
                                <option value="">Pilih</option>
                                <option value="01">Pickup</option>
                                <option value="02">Delivery</option>
                                <option value="03">Shipper</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <span class="cont-text"> Priority </span><br>
                            <select   class="cont-form" name="pscDelPriority" id="pscDelPriority" aria-label="Default select example" required>
                                <option value="">Pilih</option>
                                <option value="01">High</option>
                                <option value="02">Low</option>
                                <option value="03">Medium</option>
                                <option value="04">Minor</option>
                                <option value="05">Urgent</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <span class="cont-text"> Freight Cost Rule </span><br>
                            <select  class="cont-form" name="pscFCRule" id="pscFCRule" aria-label="Default select example" required>
                                <option value="">Pilih</option>
                                <option value="01">Freight Included</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="cont-background mt-2">
                    <div class="row">
                        <div class="col-4">
                            <span class="cont-text"> No Permintaan  </span><br>
                            <input required readonly type="text" class="cont-form" value="<%=Permintaan("PermID")%> - (<%=Permintaan("PermNo")%>)">
                            <input type="hidden" class="cont-form" name="psc_permID" id="psc_permID" value="<%=Permintaan("PermID")%>">
                            <input readonly type="hidden" class="cont-form" name="PermNo" id="PermNo" value="<%=Permintaan("PermNo")%>">
                            <input readonly type="hidden" class="cont-form" name="Perm_trYN" id="Perm_trYN" value="<%=Permintaan("Perm_trYN")%>">
                        </div>
                        <div class="col-2">
                            <span class="cont-text"> Tanggal  </span><br>
                            <input required readonly type="text" class="text-center cont-form" name="tglpermintaan" id="tglpermintaan" value="<%=Day(CDate(Permintaan("PermTanggal")))%>-<%=MonthName(Month(Permintaan("PermTanggal")))%>-<%=Year(CDate(Permintaan("PermTanggal")))%>" ><br>
                        </div>
                        <div class="col-2">
                            <span class="cont-text"> Tujuan Pengeluaran </span><br>
                            <% if Permintaan("PermTujuan") = "1" then %>
                            <input required readonly type="text" class="text-center cont-form" name="tujuanpermintaan" id="tujuanpermintaan" value="Penjualan"><br>
                            <% else %>
                            <input required readonly type="text" class="text-center cont-form" name="tujuanpermintaan" id="tujuanpermintaan" value="Pemakaian Sendiri"><br>
                            <% end if %>
                        </div>
                        <div class="col-4">
                            <span class="cont-text"> Nama Bussines Partner </span><br>
                            <input required readonly type="hidden" class="cont-form" name="psc_custID" id="psc_custID" value="<%=Permintaan("custID")%>" >
                            <input readonly type="text" class="cont-form" name="namacustomer" id="namacustomer" value="<%=Permintaan("custNama")%>" ><br>
                        </div>
                    </div>
                </div>

                <div class="cont-data-tb mt-2">
                    <div class="row mt-2 d-flex flex-row-reverse">
                        <div class="col-12">
                            <div class="cont-daftar-permintaan">
                                <table class="tb-dashboard cont-tb align-items-center table tb-transaksi table-bordered table-condensed mt-1">
                                    <thead class="text-center">
                                        <tr>
                                            <th> NO </th>
                                            <th> DETAIL PRODUK </th>
                                            <th> QTY </th>
                                            <th> HARGA </th>
                                            <th> UPTO (%) </th>
                                            <th> PPN (%) </th>
                                            <th> SUBTOTAL </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        Pengeluaran_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_Permintaan_Barang_D.Perm_pdQty, MKT_T_Permintaan_Barang_D.Perm_pdUpTo, MKT_T_Permintaan_Barang_D.Perm_pdTax, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual FROM MKT_M_Tax RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_M_Tax.TaxID = MKT_M_PIGO_Produk.pdTax RIGHT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_M_PIGO_Produk.pdID = MKT_T_Permintaan_Barang_D.Perm_pdID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID Where MKT_T_Permintaan_Barang_H.PermID = '"& PermID &"'"
                                        'response.write Pengeluaran_CMD.commandText 
                                        set Produk = Pengeluaran_CMD.execute
                                    %>
                                    <%
                                        no = 0 
                                        do while not Produk.eof
                                        no = no + 1 
                                    %>
                                        <tr>
                                            <td class="text-center"> <%=no%> </td>
                                            <td> <%=Produk("pdNama")%> [<%=Produk("pdPartNumber")%>] </td>
                                            <td class="text-center"> <%=Produk("Perm_pdQty")%> </td>
                                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(Produk("Perm_pdHargaJual")),"$","Rp. "),".00","")%> </td>
                                            <td class="text-center"> <%=Produk("Perm_pdTax")%> </td>
                                            <td class="text-center"> <%=Produk("Perm_pdUpTo")%> </td>
                                            <%
                                                Qty         = Produk("Perm_pdQty")
                                                Harga       = Produk("Perm_pdHargaJual")
                                                PPN         = Produk("Perm_pdTax")
                                                UPTO        = Produk("Perm_pdUpTo")

                                                Total       = Qty*Harga
                                                ReturnPPN   = Total+(Total*PPN/100)
                                                ReturnUPTO  = ReturnPPN*UPTO/100
                                                SubTotal    = ReturnPPN+ReturnUPTO
                                            %>
                                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(SubTotal),"$","Rp. "),".00","")%> </td>
                                            <%  TotalQty    = TotalQty + Qty 
                                                GrandTotal  = GrandTotal + SubTotal 
                                                SubTotal = 0 
                                            %>
                                        </tr>

                                    <%
                                        Produk.movenext
                                        loop
                                    %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="cont-background mt-2">
                    <div class="row align-items-center text-end">
                        <div class="col-8">
                            <span class="cont-text"> TOTAL PRODUK  </span><br>
                            <span class="cont-text"> GRAND TOTAL PERMINTAAN  </span><br>
                        </div>
                        <div class="col-4">
                            <span class="cont-text"> <%=TotalQty%> Qty </span><br>
                            <span class="cont-text" style="font-size:18px; color:#940005"> <%=Replace(Replace(FormatCurrency(GrandTotal),"$","Rp. "),".00","")%> </span>
                            <input required readonly type="hidden" class="text-center cont-form" name="pscSubtotal" id="pscSubtotal" value="<%=GrandTotal%>" >
                        </div>
                    </div>
                    <div class=" mt-3 row align-items-center">
                        <div class="col-12">
                            <div class="cont-save">
                                <input class="cont-btn" type="submit" name="Load Produk" id="Load Produk" value="Simpan">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
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
        var dropdown = document.getElementsByClassName("cont-dp-btn");
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
        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })
        /* Dengan Rupiah */

        
        /* Fungsi */
        function formatRupiah(angka, prefix)
        {
            var number_string = angka.replace(/[^,\d]/g, '').toString(),
                split	= number_string.split(','),
                sisa 	= split[0].length % 3,
                rupiah 	= split[0].substr(0, sisa),
                ribuan 	= split[0].substr(sisa).match(/\d{3}/gi);
                
            if (ribuan) {
                separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');
            }
            
            rupiah = split[1] != undefined ? rupiah + ',' + split[1] : rupiah;
            return prefix == undefined ? rupiah : (rupiah ? 'Rp. ' + rupiah : '');
        }

    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>