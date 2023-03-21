<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    permID = request.queryString("permID")

    set PermintaanBarang_cmd = server.createObject("ADODB.COMMAND")
	PermintaanBarang_cmd.activeConnection = MM_PIGO_String

        PermintaanBarang_cmd.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal,MKT_T_Permintaan_Barang_H.Perm_UpdateTime ,MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1,  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Permintaan_Barang_H.Perm_custID = MKT_M_Customer.custID ON MKT_T_Transaksi_H.trID = MKT_T_Permintaan_Barang_H.Perm_trID ON  MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID LEFT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_T_Transaksi_H.trID = left(MKT_T_Transaksi_D1.trD1,12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A Where MKT_T_Permintaan_Barang_H.permID = '"& permID &"'  GROUP BY MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1,  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName,MKT_T_Permintaan_Barang_H.Perm_UpdateTime  "
        'response.write PermintaanBarang_cmd.commandText 

        set PermintaanBarang = PermintaanBarang_cmd.execute

    poid = request.queryString("poID")

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String

        Supplier_cmd.commandText = "SELECT * FROM MKT_M_Supplier WHERE spAktifYN = 'Y'  "
        'response.write Supplier_cmd.commandText

    set Supplier = Supplier_cmd.execute

    set KeySupplier_cmd = server.createObject("ADODB.COMMAND")
	KeySupplier_cmd.activeConnection = MM_PIGO_String

        KeySupplier_cmd.commandText = "SELECT spKey FROM MKT_M_Supplier WHERE spAktifYN = 'Y'  group by spKey "
        'response.write KeySupplier_cmd.commandText

    set KeySupplier = KeySupplier_cmd.execute

    set KeyProduk_cmd = server.createObject("ADODB.COMMAND")
	KeyProduk_cmd.activeConnection = MM_PIGO_String

        KeyProduk_cmd.commandText = "SELECT pdKey FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y' group by pdKey "
        'response.write KeyProduk_cmd.commandText

    set KeyProduk = KeyProduk_cmd.execute


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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
        $(document).ready(function() {
            $('#example').DataTable( {
            });
        });

        $('#keysearch').on("change",function(){
            let keysp = $('#keysearch').val();
            console.log("a");
        });

        function getKeySupplier(){
            $.ajax({
                type: "get",
                url: "getKeySupplier.asp?keysearch="+document.getElementById("keysearch").value,
                success: function (url) {
                // console.log(url);
                $('.keysp').html(url);
                                    
                }
            });
        }
        function getsupplier(){
            $.ajax({
                type: "get",
                url: "loadsupplier.asp?keysupplier="+document.getElementById("keysupplier").value,
                success: function (url) {
                // console.log(url);
                $('.datasp').html(url);
                                    
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
                <div class="judul-PO">
                    <div class="row align-items-center">
                        <div class="col-10">
                            <span class="txt-po-judul"> Pengeluaran Suku Cadang Baru </span>
                        </div>
                        <div class="col-2">
                            <button class=" btn-tambah-po txt-po-judul" onclick="window.open('../PSCBDetail/','_Self')" style="font-size:12px"> PSCB - Detail </button>
                        </div>
                    </div>
                </div>
                <div class="purchase-order">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <form class="" action="P-Pscb.asp" method="POST">
                                <div class="row mt-2">
                                    <div class="col-6">
                                        <span class="txt-purchase-order"> No Permintaan Suku Cadang Baru </span><br>
                                        <input required type="text" class=" mb-2 inp-purchase-order" name="nopermintaan" id="nopermintaan" value="" ><br>
                                    </div>
                                    <div class="col-4">
                                        <span class="txt-purchase-order"> Tanggal  </span><br>
                                        <input required type="Date" class=" mb-2 inp-purchase-order" name="tglpermintaan" id="tglpermintaan" value="" style="width:13rem"><br>
                                    </div>
                                    <div class="col-2">
                                        <span class="txt-purchase-order"> Tujuan Pengeluaran </span><br>
                                        <select class=" mb-2 inp-purchase-order" name="typedokumen" id="typedokumen" aria-label="Default select example" required>
                                                    <option selected>Pilih</option>
                                                    <option value="MM Shipment">Penjualan Barang</option>
                                                    <option value="MM Shipment Indirect">Pemakaian Kantor</option>
                                                </select>
                                    </div>
                                </div>
                                <div class="row mt-1">
                                    <span class="label-po txt-purchase-order"> Pengeluaran Suku Cadang </span>
                                    <div class="col-12">
                                        <div class="row mt-2">
                                            <div class="col-6">
                                                <span class="txt-purchase-order"> Type Dokumen  </span><br>
                                                <select class=" mb-2 inp-purchase-order" name="typedokumen" id="typedokumen" aria-label="Default select example" required>
                                                    <option selected>Pilih</option>
                                                    <option value="MM Shipment">MM Shipment</option>
                                                    <option value="MM Shipment Indirect">MM Shipment Indirect</option>
                                                    <option value="MM Shipment PIGO">MM Shipment PIGO</option>
                                                </select>
                                            </div>
                                            <div class="col-2">
                                                <span class="txt-purchase-order"> Tanggal Pengeluaran </span><br>
                                                <input required type="Date" class=" mb-2 inp-purchase-order" name="tglpscb" id="tglpscb" value="" style="width:10rem"><br>
                                            </div>
                                            <div class="col-2">
                                                <span class="txt-purchase-order"> Movement Date </span><br>
                                                <input required type="Date" class=" mb-2 inp-purchase-order" name="movedate" id="movedate" value="" style="width:10rem"><br>
                                            </div>
                                            <div class="col-2">
                                                <span class="txt-purchase-order"> Account Date </span><br>
                                                <input required type="Date" class=" mb-2 inp-purchase-order" name="accdate" id="accdate" value="" style="width:9.5rem"><br>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <span class="txt-payment-request"> Deskripsi </span><br>
                                        <textarea name="desc" id="desc" class="txt-payment-request" style="width:63rem; height:2rem">Pengeluaran Suku Cadang Baru : </textarea>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-3">
                                        <span class="txt-purchase-order"> Delivery Rule </span><br>
                                        <select style="width:15rem" class=" mb-2 inp-purchase-order" name="delrule" id="delrule" aria-label="Default select example" required>
                                            <option selected>Pilih</option>
                                            <option value="After Receipt">After Receipt</option>
                                            <option value="Availability">Availability</option>
                                            <option value="Compelete Line">Compelete Line</option>
                                            <option value="Complete Order">Complete Order</option>
                                            <option value="Force">Force</option>
                                            <option value="Manual">Manual</option>
                                        </select>
                                    </div>
                                    <div class="col-3">
                                        <span class="txt-purchase-order"> Delivery Via </span><br>
                                        <select style="width:15rem" class=" mb-2 inp-purchase-order" name="delvia" id="delvia" aria-label="Default select example" required>
                                            <option selected>Pilih</option>
                                            <option value="Pickup">Pickup</option>
                                            <option value="Delivery">Delivery</option>
                                            <option value="Shipper">Shipper</option>
                                        </select>
                                    </div>
                                    <div class="col-3">
                                        <span class="txt-purchase-order"> Priority </span><br>
                                        <select style="width:15rem" class=" mb-2 inp-purchase-order" name="Priority" id="Priority" aria-label="Default select example" required>
                                            <option selected>Pilih</option>
                                            <option value="High">High</option>
                                            <option value="Low">Low</option>
                                            <option value="Medium">Medium</option>
                                            <option value="Minor">Minor</option>
                                            <option value="Urgent">Urgent</option>
                                        </select>
                                    </div>
                                    <div class="col-3">
                                        <span class="txt-purchase-order"> Freight Cost Rule </span><br>
                                        <select style="width:15rem" class=" mb-2 inp-purchase-order" name="fcrule" id="fcrule" aria-label="Default select example" required>
                                            <option selected>Pilih</option>
                                            <option value="Freight Included">Freight Included</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mt-1">
                                    <span class="label-po txt-purchase-order"> Bussines Partner </span>
                                        <div class="col-12">
                                            <div class="row">
                                                <div class="col-2">
                                                    <span class="txt-purchase-order"> Kata Kunci </span><br>
                                                <select onchange="return getKeySupplier()" style="width:10rem" class=" mb-2 inp-purchase-order" name="keysearch" id="keysearch" aria-label="Default select example" required>
                                                    <option value="">Pilih</option>
                                                    <% do while not KeySupplier.eof%>
                                                    <option value="<%=KeySupplier("spKey")%>"><%=KeySupplier("spKey")%></option>
                                                    <% KeySupplier.movenext
                                                    loop%>
                                                </select>
                                                </div>
                                                <div class="col-2 keysp">
                                                    <span class="txt-purchase-order"> </span><br>
                                                <select onchange="return getsupplier()" style="width:19.4rem" class="mb-2 inp-purchase-order" name="keysupplier" id="keysupplier" aria-label="Default select example" required>
                                                    <option value="">Pilih Supplier</option>
                                                    <option value=""></option>
                                                </select>
                                                </div>
                                            </div>
                                        </div>
                                    <div class="row datasp">
                                        <div class="col-6">
                                            <div class="row">
                                                <div class="col-8">
                                                    <span class="txt-purchase-order">  Supplier ID </span><br>
                                                    <input required type="text" class=" mb-2 inp-purchase-order" name="supplierid" id="supplierid" value="" ><br>
                                                    <span class="txt-purchase-order"> Nama Supplier </span><br>
                                                    <input required type="text" class=" mb-2 inp-purchase-order" name="namasupplier" id="namasupplier" value="" ><br>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 align-items-center">
                                            <div class="row">
                                                <div class="col-6">
                                                    <span class="txt-purchase-order"> Jangan Waktu Pembayaran PO </span><br>
                                                    <input required type="text" class=" mb-2 inp-purchase-order" name="poterm" id="poterm" value="" style="width:15rem"><br>
                                                </div>
                                                <div class="col-6">
                                                    <span class="txt-purchase-order"> Lokasi Supplier </span><br>
                                                    <input required type="text" class=" mb-2 inp-purchase-order" name="lokasi" id="lokasi" value="" style="width:15rem"><br>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-6">
                                                    <span class="txt-purchase-order"> Nama CP Supplier </span><br>
                                                    <input required type="text" class=" mb-2 inp-purchase-order" name="namacp" id="namacp" value="" style="width:15rem"b><br>
                                                </div>
                                                <div class="col-6">
                                                    <input type="checkbox" class="mb-2 mt-4" name="dropship" id="dropship" value="Y">
                                                    <label required for="dropship" class="txt-purchase-order"> Drop Shipment </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row label-po  align-items-center text-center mt-1">
                                    <div class="col-12">
                                        <input class="btn-supplier-baru" type="submit" name="Load Produk" id="Load Produk" value="Load Produk">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>