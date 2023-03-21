<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE po_custID = '"& request.Cookies("custID") &"' and MKT_T_PurchaseOrder_D.po_prYN = 'N' group by poID "
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
    <script>
        function getpo(){
            $.ajax({
                type: "get",
                url: "loaddatapo.asp?poID="+document.getElementById("nopo").value,
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
                    <div class="row align-items-center">
                        <div class="col-9">
                            <span class="txt-po-judul"> Payment Request </span>
                        </div>
                        <div class="col-3">
                            <button class=" btn-tambah-po txt-po-judul" onclick="window.open('../PaymentRequestDetail/','_Self')"> Payment Request Detail </button>
                        </div>
                    </div>
                </div>
                <form class="" action="P-PaymentRequest.asp" method="POST">
                <div class="payment-request">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-6 mt-1">
                                    <span class="txt-payment-request"> No Faktur / Surat Jalan Supplier  </span><br>
                                    <input type="text" class=" mb-2 inp-payment-request" name="nofaktur" id="nofaktur" value="" style="width:12rem"><br>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Type Dokumen </span><br>
                                    <select style="width:10rem" class=" mb-2 inp-payment-request" name="typeinvoice" id="typeinvoice" aria-label="Default select example">
                                        <option selected>Pilih</option>
                                        <option value="Invoice PIGO">Invoice PIGO</option>
                                    </select>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Tanggal Invoice </span><br>
                                    <input type="Date" class=" mb-2 inp-payment-request" name="tglinvoice" id="tglinvoice" value="" style="width:10rem"><br>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Tanggal Account </span><br>
                                    <input type="Date" class=" mb-2 inp-payment-request" name="tglaccount" id="tglaccount" value="" style="width:10rem"><br>
                                </div>
                            </div>
                            <div class="row">
                            <span class="label-po txt-payment-request"> Purchase Order </span>
                                <div class="col-6">
                                    <span class="txt-payment-request"> No Purchase Order  </span> <br>
                                    <select onchange="return getpo()" class=" mb-2 inp-payment-request" name="nopo" id="nopo" aria-label="Default select example">
                                        <option selected>Pilih</option>
                                        <% do while not PurchaseOrder.eof %>
                                        <option value="<%=PurchaseOrder("poID")%>"><%=PurchaseOrder("poID")%></option>
                                        <% PurchaseOrder.movenext
                                        loop%>
                                    </select>
                                </div>
                            </div>
                        <div class="datapo">
                            <div class="row">
                                <div class="col-3">
                                    <span class="txt-payment-request"> Tanggal Order  </span><br>
                                    <input type="text" class=" mb-2 inp-payment-request" name="tglorder" id="tglorder" value="" style="width:15rem"><br>
                                </div>
                                <div class="col-3">
                                    <span class="txt-payment-request"> Jenis Purchase Order </span><br>
                                    <input type="text" class=" mb-2 inp-payment-request" name="jenispo" id="jenispo" value="" style="width:14rem"><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <div class="row">
                                        <div class="col-8">
                                            <span class="txt-payment-request">  Supplier ID </span><br>
                                            <input required type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="" ><br>
                                            <span class="txt-payment-request"> Nama Supplier </span><br>
                                            <input required type="text" class=" mb-2 inp-payment-request" name="namasupplier" id="namasupplier" value="" ><br>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 align-items-center">
                                    <div class="row">
                                        <div class="col-6">
                                            <span class="txt-payment-request"> Jangan Waktu Pembayaran PO </span><br>
                                            <input required type="text" class=" mb-2 inp-payment-request" name="poterm" id="poterm" value="" style="width:15rem"><br>
                                        </div>
                                        <div class="col-6">
                                            <span class="txt-payment-request"> Lokasi Supplier </span><br>
                                            <input required type="text" class=" mb-2 inp-payment-request" name="lokasi" id="lokasi" value="" style="width:15rem"><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-6">
                                            <span class="txt-payment-request"> Nama CP Supplier </span><br>
                                            <input required type="text" class=" mb-2 inp-payment-request" name="namacp" id="namacp" value="" style="width:31rem"><br>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                            <div class="row label-po align-items-center text-center mt-1">
                                <div class="col-12">
                                    <input class="btn-supplier-baru" type="submit" name="simpan" id="simpan" value="Generate Receipt From Invoice">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>