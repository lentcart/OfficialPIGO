<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    mmID = request.queryString("mmID")

    set mm_cmd = server.createObject("ADODB.COMMAND")
	mm_cmd.activeConnection = MM_PIGO_String

        mm_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType, MKT_T_MaterialReceipt_H.mmMoveDate, MKT_T_MaterialReceipt_H.mmAccDate, MKT_M_Supplier.spID,  MKT_M_Supplier.spKey, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spNamaCP FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Supplier.spID = MKT_T_MaterialReceipt_H.mm_spID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_H.mmID = '"& mmID &"' "
        'response.write mm_cmd.commandText

    set mm = mm_cmd.execute


    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String

        Supplier_cmd.commandText = "SELECT * FROM MKT_M_Supplier WHERE sp_custID = 'C0322000000002'  "
        'response.write Supplier_cmd.commandText

    set Supplier = Supplier_cmd.execute

    set KeySupplier_cmd = server.createObject("ADODB.COMMAND")
	KeySupplier_cmd.activeConnection = MM_PIGO_String

        KeySupplier_cmd.commandText = "SELECT spKey FROM MKT_M_Supplier WHERE sp_custID = 'C0322000000002'  group by spKey "
        'response.write KeySupplier_cmd.commandText

    set KeySupplier = KeySupplier_cmd.execute

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_M_Supplier.spID FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Supplier.spID = MKT_T_PurchaseOrder_H.po_spID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE po_custID = 'C0322000000002'   and MKT_T_PurchaseOrder_H.po_spID = '"& mm("spID") &"' AND MKT_T_PurchaseOrder_D.po_spoID = '0'  OR  MKT_T_PurchaseOrder_D.po_spoID = '2' group by MKT_T_PurchaseOrder_H.poID, MKT_M_Supplier.spID "
        'response.write PurchaseOrder_cmd.commandText

    set PurchaseOrder = PurchaseOrder_cmd.execute



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
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
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
        function getpo(){
            $.ajax({
                type: "get",
                url: "loaddatapo.asp?poID="+document.getElementById("poID").value,
                success: function (url) {
                // console.log(url);
                $('.datapo').html(url);
                                    
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
                    <span class="txt-po-judul"> Material Receipt </span>
                </div>
                <div class="purchase-order">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <div class="row mt-2">
                                <div class="col-2">
                                    <span class="txt-purchase-order"> Tanggal </span><br>
                                    <input readonly type="Date" class=" mb-2 inp-purchase-order" name="tanggalmm" id="tanggalmm" value="<%=mm("mmTanggal")%>" style="width:10rem"><br>
                                </div>
                                <div class="col-4">
                                    <span class="txt-purchase-order">  Material Receipt  </span><br>
                                    <input readonly type="text" class=" mb-2 inp-purchase-order" name="mmID" id="mmID" value="<%=mm("mmID")%>" ><br>
                                </div>
                                <div class="col-2">
                                    <span class="txt-purchase-order"> Type Dokumen </span><br>
                                    <input readonly type="text" class=" mb-2 inp-purchase-order" name="mmType" id="mmType" value="<%=mm("mmType")%>" style="width:10rem"><br>
                                </div>
                                <div class="col-2">
                                    <span class="txt-purchase-order"> Movement Date </span><br>
                                    <input readonly type="Date" class=" mb-2 inp-purchase-order" name="mmMoveDate" id="mmMoveDate" value="<%=mm("mmMoveDate")%>" style="width:10rem"><br>
                                </div>
                                <div class="col-2">
                                    <span class="txt-purchase-order"> Account Date </span><br>
                                    <input readonly type="Date" class=" mb-2 inp-purchase-order" name="mmAccDate" id="mmAccDate" value="<%=mm("mmAccDate")%>" style="width:9.2rem"><br>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-12">
                                <span class="label-po txt-purchase-order"> Bussines Partner </span>
                                    <div class="row mt-3">
                                        <div class="col-2">
                                            <span class="txt-purchase-order"> Kata Kunci </span><br>
                                            <input readonly type="text" class=" mb-2 inp-purchase-order" name="supplierid" id="supplierid" value="<%=mm("spKey")%>" style="width:10rem" ><br>
                                        </div>
                                        <div class="col-4 keysp">
                                            <span class="txt-purchase-order"> </span><br>
                                            <input readonly type="text" class=" mb-2 inp-purchase-order" name="supplierid" id="supplierid" value="<%=mm("spKey")%>,<%=mm("spNama1")%>" ><br>
                                        </div>
                                        <div class="col-2 keysp">
                                            <span class="txt-purchase-order">  Supplier ID </span><br>
                                            <input readonly type="text" class=" mb-2 inp-purchase-order" name="supplierid" id="supplierid" value="<%=mm("spID")%>" style="width:10rem" ><br>
                                        </div>
                                        <div class="col-4 keysp">
                                            <span class="txt-purchase-order"> Nama Supplier </span><br>
                                            <input readonly type="text" class=" mb-2 inp-purchase-order" name="namasupplier" id="namasupplier" value="<%=mm("spNama1")%>" ><br>
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-2">
                                            <span class="txt-purchase-order">Payment</span><br>
                                            <input readonly type="text" class=" mb-2 inp-purchase-order" name="poterm" id="poterm" value="<%=mm("spPaymentTerm")%>" style="width:10rem"><br>
                                        </div>
                                        <div class="col-4 keysp">
                                            <span class="txt-purchase-order"> Nama CP Supplier </span><br>
                                            <input readonly type="text" class=" mb-2 inp-purchase-order" name="namacp" id="namacp" value="<%=mm("spNamaCP")%>"><br>
                                        </div>
                                        <div class="col-4 keysp">
                                            <span class="txt-purchase-order"> Lokasi Supplier </span><br>
                                            <input readonly type="text" class=" mb-2 inp-purchase-order" name="lokasi" id="lokasi" value="<%=mm("spAlamat")%>" ><br>
                                        </div>
                                        <div class="col-2 keysp">
                                            <input  readonly type="checkbox" class="mb-2 mt-4" name="dropship" id="dropship" value="Y" checked>
                                            <label  for="dropship" class="txt-purchase-order"> Drop Shipment </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row align-items-center mt-2">
                                <hr>
                                <div class="col-8">
                                    <span class="txt-purchase-order"> NO Purchase Order</span><br>
                                    <select onchange="getpo()"style="width:10rem" class=" mb-2 inp-purchase-order" name="poID" id="poID" aria-label="Default select example">
                                        <option selected>Pilih</option>
                                        <% do while not PurchaseOrder.eof %>
                                        <option value="<%=PurchaseOrder("poID")%>"><%=PurchaseOrder("poID")%></option>
                                        <% PurchaseOrder.movenext
                                        loop%>
                                    </select>
                                </div>
                                <div class="col-4">
                                    <span style="font-size:13px; font-weight:bold; color: #df9375"> <i class="fas fa-sticky-note"></i> Proses Pengajuan </span> - <span style="font-size:13px; font-weight:bold; color: #65bde6"> <i class="fas fa-sticky-note"></i> Tidak Terpenuhi</span>
                                </div>
                                <div class="row datapo" style="height:14.5rem; overflow:scroll;overflow-x:hidden">
                                    
                                </div>
                            </div>
                            <div class="cont-mm">
                            <div class="row  align-items-center  mt-2">
                                <div class="col-3">
                                    <button class="btn-cetak-po" style="width:10rem" onclick="window.open('../MaterialReceiptDetail/buktimm.asp?mmID='+document.getElementById('mmID').value+'&tanggalmm='+document.getElementById('tanggalmm').value,'_Self')" > Cetak Material Receipt </button>
                                </div>
                                <div class="col-4">
                                    <button class="btn-cetak-po" style="width:5rem" onclick="window.open('../MaterialReceiptDetail/','_Self')" > Selesai </button>
                                </div>
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
        
    </script>
</html>