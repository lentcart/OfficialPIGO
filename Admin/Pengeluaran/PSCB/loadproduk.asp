<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    pscID = request.queryString("pscID")

    set Pengeluaran_cmd = server.createObject("ADODB.COMMAND")
	Pengeluaran_cmd.activeConnection = MM_PIGO_String

        Pengeluaran_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_H.pscMoveDate, MKT_T_PengeluaranSC_H.pscAccDate,  MKT_T_PengeluaranSC_H.pscDesc, MKT_T_PengeluaranSC_H.pscDelvRule, MKT_T_PengeluaranSC_H.pscDelvVia, MKT_T_PengeluaranSC_H.pscPriority, MKT_T_PengeluaranSC_H.pscFCRule,  MKT_T_PengeluaranSC_H.psc_custID, MKT_T_PengeluaranSC_D1.pscD1_NoPermintaan, MKT_T_PengeluaranSC_D1.pscD1_TglPermintaan, MKT_T_PengeluaranSC_D1.pscD1_spID, MKT_M_Supplier.spID,  MKT_M_Supplier.spNama1 FROM MKT_T_PengeluaranSC_D1 LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_PengeluaranSC_D1.pscD1_spID = MKT_M_Supplier.spID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D1.pscID1_H = MKT_T_PengeluaranSC_H.pscID WHERE MKT_T_PengeluaranSC_H.pscID = '"& pscID &"'  "
        'response.write Pengeluaran_cmd.commandText

    set Pengeluaran = Pengeluaran_cmd.execute

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_PIGO_Produk WHERE pd_custID = '"& request.Cookies("custID") &"' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_PIGO_Produk WHERE pd_custID = '"& request.Cookies("custID") &"' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String

        Supplier_cmd.commandText = "SELECT * FROM MKT_M_Supplier WHERE sp_custID = '"& request.Cookies("custID") &"' "
        'response.write Supplier_cmd.commandText

    set Supplier = Supplier_cmd.execute

    set KeySupplier_cmd = server.createObject("ADODB.COMMAND")
	KeySupplier_cmd.activeConnection = MM_PIGO_String

        KeySupplier_cmd.commandText = "SELECT spKey FROM MKT_M_Supplier WHERE sp_custID = '"& request.Cookies("custID") &"' group by spKey "
        'response.write KeySupplier_cmd.commandText

    set KeySupplier = KeySupplier_cmd.execute

    set KeyProduk_cmd = server.createObject("ADODB.COMMAND")
	KeyProduk_cmd.activeConnection = MM_PIGO_String

        KeyProduk_cmd.commandText = "SELECT pdKey FROM MKT_M_PIGO_Produk WHERE pd_custID = '"& request.Cookies("custID") &"' group by pdKey "
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


        function getKeyProduk(){
            $.ajax({
                type: "get",
                url: "getKeyProduk.asp?katakunci="+document.getElementById("katakunci").value,
                success: function (url) {
                // console.log(url);
                $('.keypd').html(url);
                                    
                }
            });
        }
        function getproduk(){
            $.ajax({
                type: "get",
                url: "getproduk.asp?keyproduk="+document.getElementById("keyproduk").value,
                success: function (url) {
                // console.log(url);
                $('.datapd').html(url);
                                    
                }
            });
        }
        function subtotal(){
            var qty = parseInt(document.getElementById("jumlah").value);
            var harga = parseInt(document.getElementById("harga").value);
            var total = Number(qty*harga);
            document.getElementById("subtotal").value = total;
            
        };
        document.addEventListener("DOMContentLoaded", function(event) {
            subtotal();
        });
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
                    <span class="txt-po-judul"> Pengeluaran Suku Cadang Baru </span>
                </div>
                <div class="purchase-order">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-6">
                                    <span class="txt-purchase-order"> No Permintaan Suku Cadang Baru </span><br>
                                    <input Disabled type="text" class=" mb-2 inp-purchase-order" name="nopermintaan" id="nopermintaan" value="<%=Pengeluaran("pscD1_NoPermintaan")%>" >
                                    <input Disabled type="hidden" class=" mb-2 inp-purchase-order" name="pscID_H" id="pscID_H" value="<%=Pengeluaran("pscID")%>" >
                                </div>
                                <div class="col-6">
                                    <span class="txt-purchase-order"> Tanggal Permintaan Suku Cadang </span><br>
                                    <input Disabled type="text" class=" mb-2 inp-purchase-order" name="tglpermintaan" id="tglpermintaan" value="<%=CDate(Pengeluaran("pscD1_TglPermintaan"))%>" style="width:13rem"><br>
                                </div>
                            </div>
                            <div class="row mt-1">
                                <span class="label-po txt-purchase-order"> Pengeluaran Suku Cadang </span>
                                <div class="col-12">
                                    <div class="row mt-2">
                                        <div class="col-6">
                                            <span class="txt-purchase-order"> Type Dokumen  </span><br>
                                            <input Disabled type="text" class=" mb-2 inp-purchase-order" name="accdate" id="accdate" value="<%=Pengeluaran("pscType")%>" ><br>
                                        </div>
                                        <div class="col-2">
                                            <span class="txt-purchase-order"> Tanggal Pengeluaran </span><br>
                                            <input Disabled type="text" class=" mb-2 inp-purchase-order" name="tglpscb" id="tglpscb" value="<%=Pengeluaran("pscTanggal")%>" style="width:10rem"><br>
                                        </div>
                                        <div class="col-2">
                                            <span class="txt-purchase-order"> Movement Date </span><br>
                                            <input Disabled type="text" class=" mb-2 inp-purchase-order" name="movedate" id="movedate" value="<%=Pengeluaran("pscMoveDate")%>" style="width:10rem"><br>
                                        </div>
                                        <div class="col-2">
                                            <span class="txt-purchase-order"> Account Date </span><br>
                                            <input Disabled type="text" class=" mb-2 inp-purchase-order" name="accdate" id="accdate" value="<%=Pengeluaran("pscAccDate")%>" style="width:9.5rem"><br>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <span class="txt-payment-request"> Deskripsi </span><br>
                                    <textarea name="desc" id="desc" class="txt-payment-request" style="width:63rem; height:2rem">Pengeluaran Suku Cadang Baru : <%=Pengeluaran("pscDesc")%> </textarea>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-3">
                                    <span class="txt-purchase-order"> Delivery Rule </span><br>
                                    <input Disabled type="text" class=" mb-2 inp-purchase-order" name="accdate" id="accdate" value="<%=Pengeluaran("pscDelvRule")%>" style="width:15rem"><br>
                                </div>
                                <div class="col-3">
                                    <span class="txt-purchase-order"> Delivery Via </span><br>
                                    <input Disabled type="text" class=" mb-2 inp-purchase-order" name="accdate" id="accdate" value="<%=Pengeluaran("pscDelvVia")%>" style="width:14rem"><br>
                                </div>
                                <div class="col-3">
                                    <span class="txt-purchase-order"> Priority </span><br>
                                    <input Disabled type="text" class=" mb-2 inp-purchase-order" name="accdate" id="accdate" value="<%=Pengeluaran("pscPriority")%>" style="width:15rem"><br>
                                </div>
                                <div class="col-3">
                                    <span class="txt-purchase-order"> Freight Cost Rule </span><br>
                                    <input Disabled type="text" class=" mb-2 inp-purchase-order" name="accdate" id="accdate" value="<%=Pengeluaran("pscFCRule")%>" style="width:15rem"><br>
                                </div>
                            </div>
                            <div class="row datasp">
                                <div class="col-6">
                                    <div class="row">
                                        <div class="col-8">
                                            <span class="txt-purchase-order">  Supplier ID </span><br>
                                            <input Disabled type="text" class=" mb-2 inp-purchase-order" name="supplierid" id="supplierid" value="<%=Pengeluaran("spID")%>" ><br>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 align-items-center">
                                    <div class="row">
                                        <div class="col-6">
                                            <span class="txt-purchase-order"> Nama Supplier </span><br>
                                            <input Disabled type="text" class=" mb-2 inp-purchase-order" name="namasupplier" id="namasupplier" value="<%=Pengeluaran("spNama1")%>" style="width:31rem"><br>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row poproduk" name="poproduk" id="poproduk">
                                <span class="label-po txt-purchase-order"> Product </span>
                                <div class="col-12">
                                    <div class="row">
                                        <div class="col-2">
                                            <span class="txt-purchase-order"> Kata Kunci </span><br>
                                            <select onchange="return getKeyProduk()"  style="width:10rem" class=" mb-2 inp-purchase-order" name="katakunci" id="katakunci" aria-label="Default select example" required>
                                                <option selected>Pilih</option>
                                                <% do while not KeyProduk.eof %>
                                                <option value="<%=KeyProduk("pdKey")%>"><%=KeyProduk("pdKey")%></option>
                                                <% KeyProduk.movenext
                                                loop%>
                                            </select>
                                        </div>
                                        <div class="col-2 keypd">
                                            <span class="txt-purchase-order"> </span><br>
                                        <select onchange="return getproduk()" style="width:19.4rem" class="mb-2 inp-purchase-order" name="keyproduk" id="keyproduk" aria-label="Default select example" required>
                                            <option value="">Pilih Produk</option>
                                            <option value=""></option>
                                        </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row datapd">
                                    <input type="hidden" class=" inp-purchase-order" name="produkid" id="produkid" value="" ><br>
                                    <div class="col-6">
                                        <div class="row">
                                            <div class="col-7">
                                                <span class="txt-purchase-order"> Nama Produk </span><br>
                                                <input required type="text" class=" mb-2 inp-purchase-order" name="namaproduk" id="namaproduk" value="" style="width:100%"><br>
                                            </div>
                                            <div class="col-5">
                                                <span class="txt-purchase-order"> Part Number </span><br>
                                                <input required type="text" class=" mb-2 inp-purchase-order" name="namaproduk" id="namaproduk" value="" style="width:11.7rem"><br>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12">
                                                <button onclick="sendproduk()"class="btn-tambah-produk"> Tambah Produk </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="row">
                                            <div class="col-4">
                                                <span class="txt-purchase-order"> Harga </span><br>
                                                <input onkeyup="subtotal()" required type="text" class=" mb-2 inp-purchase-order" name="harga" id="harga" value="0" style="width:10rem"><br>
                                            </div>
                                            <div class="col-2 ">
                                                <span class="txt-purchase-order"> Jumlah  </span><br>
                                                <input onkeyup="subtotal()" required type="text" class=" mb-2 inp-purchase-order" name="jumlah" id="jumlah" value="0" style="width:5rem"><br>
                                            </div>
                                            <div class="col-2">
                                                <span class="txt-purchase-order"> Unit </span><br>
                                                <select required style="width:4rem" class=" mb-2 inp-purchase-order" name="unit" id="unit" aria-label="Default select example" required>
                                                    <option selected>Pilih</option>
                                                    <option value="Pcs">Pcs</option>
                                                    <option value="Kg">Kg</option>
                                                    <option value="Dus">Dus</option>
                                                    <option value="Pck">Pck</option>
                                                    <option value="Mm">Mm</option>
                                                    <option value="Ml">Ml</option>
                                                </select>
                                            </div>
                                            <div class="col-3">
                                                <span class="txt-purchase-order"> Sub Total </span><br>
                                                <input required type="number" class=" mb-2 inp-purchase-order" name="subtotal" id="subtotal" value="0" style="width:10rem"><br>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row label-po  align-items-center text-center mt-2" style="height:2.5rem">
                                <div class="col-12">
                                    <input class="btn-supplier-baru" type="submit" name="Load Produk" id="Load Produk" value="Cetak Bukti Pengeluaran Suku Cadang Baru">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script> 
    <script>
        function sendproduk(){
            var pscID_H = $('#pscID_H').val();            
            var pdID = $('#produkid').val();            
            var pdHarga = $('#harga').val();
            var pdQty = $('#jumlah').val();
            var pdUnit = $('#unit').val();
            var pdSubtotal = $('#subtotal').val();
            $.ajax({
                type: "get",
                url: "P-Produk.asp",
                    data:{
                            pscID_H:pscID_H,
                            pdID:pdID,
                            pdHarga:pdHarga,
                            pdQty:pdQty,
                            pdUnit:pdUnit,
                            pdSubtotal:pdSubtotal
                        },
                    success: function (data) {
                    console.log(data);
                    
                    }
                });
            }
    </script>   
</html>