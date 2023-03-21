<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    prID = request.queryString("prID")


    set PaymentRequest_cmd = server.createObject("ADODB.COMMAND")
	PaymentRequest_cmd.activeConnection = MM_PIGO_String

        PaymentRequest_cmd.commandText = "SELECT MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prType, MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prTanggalInv, MKT_T_PaymentRequest_H.prTanggalAcc, MKT_T_PaymentRequest_H.pr_poID, MKT_T_PaymentRequest_H.pr_spID, MKT_T_PaymentRequest_H.pr_custID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenis, MKT_T_PurchaseOrder_H.poTglOrder, MKT_M_Supplier.spNama1, MKT_M_Supplier.spID, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spNamaCP FROM MKT_T_PaymentRequest_H LEFT OUTER JOIN  MKT_M_Supplier ON MKT_T_PaymentRequest_H.pr_spID = MKT_M_Supplier.spID LEFT OUTER JOIN  MKT_T_PurchaseOrder_H ON MKT_T_PaymentRequest_H.pr_poID = MKT_T_PurchaseOrder_H.poID WHERE MKT_T_PaymentRequest_H.prID = '"& prID &"'"
        'response.write PaymentRequest_cmd.commandText

    set PaymentRequest = PaymentRequest_cmd.execute

    set MaterialReceipt_cmd = server.createObject("ADODB.COMMAND")
	MaterialReceipt_cmd.activeConnection = MM_PIGO_String

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText = "SELECT poID FROM MKT_T_PurchaseOrder_H WHERE po_custID = '"& request.Cookies("custID") &"' group by poID "
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
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
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
                    <span class="txt-pr-judul"> Payment Request </span>
                </div>
                <div class="payment-request">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-6 mt-1">
                                    <span class="txt-payment-request"> No Faktur / Surat Jalan Supplier  </span><br>
                                    <input disabled type="text" class=" mb-2 inp-payment-request" name="nofaktur" id="nofaktur" value="<%=PaymentRequest("prFaktur")%>" style="width:12rem"><br>
                                    <input disabled type="hidden" class=" mb-2 inp-payment-request" name="prID" id="prID" value="<%=PaymentRequest("prID")%>" style="width:12rem">
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Type Dokumen </span><br>
                                    <select disabled style="width:10rem" class=" mb-2 inp-payment-request" name="typeinvoice" id="typeinvoice" aria-label="Default select example">
                                        <option value="<%=PaymentRequest("prType")%>"><%=PaymentRequest("prType")%></option>
                                    </select>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Tanggal Invoice </span><br>
                                    <input  disabled type="Date" class=" mb-2 inp-payment-request" name="tglinvoice" id="tglinvoice" value="<%=PaymentRequest("prTanggalInv")%>" style="width:10rem"><br>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Tanggal Account </span><br>
                                    <input disabled type="Date" class=" mb-2 inp-payment-request" name="tglaccount" id="tglaccount" value="<%=PaymentRequest("prTanggalAcc")%>" style="width:10rem"><br>
                                </div>
                            </div>
                            <div class="row">
                            <span class="label-po txt-payment-request"> Purchase Order </span>
                                <div class="col-6">
                                    <span class="txt-payment-request"> No Purchase Order  </span> <br>
                                    <select disabled class=" mb-2 inp-payment-request" name="nopo" id="nopo" aria-label="Default select example">
                                        <option value="<%=PaymentRequest("pr_poID")%>"><%=PaymentRequest("pr_poID")%></option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-3">
                                    <span class="txt-payment-request"> Tanggal Order  </span><br>
                                    <input disabled type="text" class=" mb-2 inp-payment-request" name="tglorder" id="tglorder" value="<%=PaymentRequest("poTglOrder")%>" style="width:15rem"><br>
                                </div>
                                <div class="col-3">
                                    <span class="txt-payment-request"> Jenis Purchase Order </span><br>
                                    <input disabled type="text" class=" mb-2 inp-payment-request" name="jenispo" id="jenispo" value="<%=PaymentRequest("poJenis")%>" style="width:14rem"><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <div class="row">
                                        <div class="col-8">
                                            <span class="txt-payment-request">  Supplier ID </span><br>
                                            <input disabled  type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=PaymentRequest("pr_spID")%>" ><br>
                                            <span class="txt-payment-request"> Nama Supplier </span><br>
                                            <input disabled type="text" class=" mb-2 inp-payment-request" name="namasupplier" id="namasupplier" value="<%=PaymentRequest("spNama1")%>" ><br>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 align-items-center">
                                    <div class="row">
                                        <div class="col-6">
                                            <span class="txt-payment-request"> Jangan Waktu Pembayaran PO </span><br>
                                            <input disabled type="text" class=" mb-2 inp-payment-request" name="poterm" id="poterm" value="<%=PaymentRequest("spPaymentTerm")%>" style="width:15rem"><br>
                                        </div>
                                        <div class="col-6">
                                            <span class="txt-payment-request"> Lokasi Supplier </span><br>
                                            <input disabled type="text" class=" mb-2 inp-payment-request" name="lokasi" id="lokasi" value="<%=PaymentRequest("spAlamat")%>" style="width:15rem"><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-6">
                                            <span class="txt-payment-request"> Nama CP Supplier </span><br>
                                            <input disabled type="text" class=" mb-2 inp-payment-request" name="namacp" id="namacp" value="<%=PaymentRequest("spNamaCp")%>" style="width:31rem"><br>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <span class="label-po txt-payment-request"> Material Receipt </span>
                                <div class="col-12">
                                    <%
                                        MaterialReceipt_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D1.mm_poID, MKT_M_PIGO_Produk.pdID,MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_prYN FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 ON  MKT_M_Supplier.spID = MKT_T_PurchaseOrder_H.po_spID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H  WHERE MKT_T_PurchaseOrder_H.poID = '"& PaymentRequest("pr_poID") &"' and MKT_T_MaterialReceipt_D2.mm_prYN = 'N'  group by MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D1.mm_poID, MKT_M_PIGO_Produk.pdID,MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_prYN"
                                        'response.write MaterialReceipt_cmd.commandText

                                        set MaterialReceipt = MaterialReceipt_cmd.execute
                                    %>
                                    <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                                        <thead>
                                            <tr>
                                                <th class="text-center"> Material Receipt ID </th>
                                                <th class="text-center"> Qty Produk Di Terima </th>
                                                <th class="text-center"> Harga Produk </th>
                                                <th class="text-center"> Total </th>
                                                <th class="text-center"> Aksi </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% do while not MaterialReceipt.eof %>
                                            <% if MaterialReceipt("mm_prYN") = "Y" then %>
                                            <tr>
                                                <td class="text-center"><input disable class="text-center"Type="text" name="mmID" id="mmID<%=MaterialReceipt("pdID")%>" value="<%=MaterialReceipt("mmID")%>"> <input disable class="text-center"Type="hidden" name="poID" id="poID<%=MaterialReceipt("pdID")%>" value="<%=MaterialReceipt("mm_poID")%>"><input class="text-center"Type="hidden" name="pdID" id="pdID<%=MaterialReceipt("pdID")%>" value="<%=MaterialReceipt("pdID")%>"></td>
                                                <td class="text-center"><input disable class="text-center"Type="text" name="pdditerima" id="pdditerima" value="<%=MaterialReceipt("mm_pdQtyDiterima")%>"> </td>
                                                <td class="text-center"><input disable class="text-center"Type="text" name="harga" id="harga" value="<%=MaterialReceipt("mm_pdHarga")%>"> </td>
                                                <td class="text-center"><input disable class="text-center"Type="text" name="subtotal" id="subtotal<%=MaterialReceipt("pdID")%>" value="<%=MaterialReceipt("mm_pdSubtotal")%>"> </td>
                                                <td class="text-center"><span> Done </span></td>
                                            </tr>
                                            <% else %>
                                            <tr>
                                                <td class="text-center"><input class="text-center"Type="text" name="mmID" id="mmID<%=MaterialReceipt("pdID")%>" value="<%=MaterialReceipt("mmID")%>"> <input class="text-center"Type="hidden" name="poID" id="poID<%=MaterialReceipt("pdID")%>" value="<%=MaterialReceipt("mm_poID")%>"><input class="text-center"Type="hidden" name="pdID" id="pdID<%=MaterialReceipt("pdID")%>" value="<%=MaterialReceipt("pdID")%>"></td>
                                                <td class="text-center"><input class="text-center"Type="text" name="pdditerima" id="pdditerima" value="<%=MaterialReceipt("mm_pdQtyDiterima")%>"> </td>
                                                <td class="text-center"><input class="text-center"Type="text" name="harga" id="harga" value="<%=MaterialReceipt("mm_pdHarga")%>"> </td>
                                                <td class="text-center"><input class="text-center"Type="text" name="subtotal" id="subtotal<%=MaterialReceipt("pdID")%>" value="<%=MaterialReceipt("mm_pdSubtotal")%>"> </td>
                                                <td class="text-center"><button onclick="sendinvoice<%=MaterialReceipt("pdID")%>()"> Send Invoice </button></td>
                                            </tr>
                                            <script>
                                                function sendinvoice<%=MaterialReceipt("pdID")%>(){
                                                    var prID_H = $('#prID').val(); 
                                                    var poID = $('#poID<%=MaterialReceipt("pdID")%>').val();
                                                    var mmID = $('#mmID<%=MaterialReceipt("pdID")%>').val();
                                                    var mm_pdSubtotal = $('#subtotal<%=MaterialReceipt("pdID")%>').val();
                                                    var mm_pdID = $('#pdID<%=MaterialReceipt("pdID")%>').val();
                                                    
                                                    $.ajax({
                                                        type: "post",
                                                        url: "P-PaymentRequestD.asp",
                                                            data:{
                                                                    prID_H:prID_H,
                                                                    poID:poID,
                                                                    mmID:mmID,
                                                                    mm_pdSubtotal:mm_pdSubtotal,
                                                                    mm_pdID:mm_pdID
                                                                },
                                                            success: function (data) {
                                                                Swal.fire({
                                                                    icon: 'succses',
                                                                    text: 'Payment Request Berhasil'
                                                                });
                                                            }
                                                        });
                                                    }
                                            </script>
                                            <%end if%>
                                            <% MaterialReceipt.movenext
                                            loop%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row label-po align-items-center text-center mt-1">
                                <div class="col-12">
                                    <button class="btn-cetak-po" style="width:20rem" onclick="window.open('../PaymentRequestDetail/buktipr.asp?prID='+document.getElementById('prID').value+'&tglinvoice='+document.getElementById('tglinvoice').value,'_Self')"  > Cetak Payment Request </button>
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
</html>