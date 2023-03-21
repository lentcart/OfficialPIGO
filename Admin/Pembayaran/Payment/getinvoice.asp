<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    
    payID = request.queryString("payID")


    set Payment_cmd = server.createObject("ADODB.COMMAND")
	Payment_cmd.activeConnection = MM_PIGO_String

        Payment_cmd.commandText = "SELECT MKT_T_Payment_H.payID, MKT_T_Payment_H.payBank, MKT_T_Payment_H.payType, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payTanggalAcc, MKT_T_Payment_H.payDesc, MKT_T_Payment_H.pay_spID, MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spNamaCP FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_M_Supplier.spID = MKT_T_Payment_H.pay_spID where MKT_T_Payment_H.payID  = '"& payID &"' group by MKT_T_Payment_H.payID, MKT_T_Payment_H.payBank, MKT_T_Payment_H.payType, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payTanggalAcc, MKT_T_Payment_H.payDesc, MKT_T_Payment_H.pay_spID, MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spNamaCP "
        'response.write Payment_cmd.commandText

    set Payment = Payment_cmd.execute

    set Invoice_cmd = server.createObject("ADODB.COMMAND")
	Invoice_cmd.activeConnection = MM_PIGO_String

        Invoice_cmd.commandText = "SELECT MKT_T_PaymentRequest_H.prID FROM MKT_M_Supplier LEFT OUTER JOIN MKT_T_PaymentRequest_H ON MKT_M_Supplier.spID = MKT_T_PaymentRequest_H.pr_spID LEFT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H WHERE MKT_T_PaymentRequest_H.pr_spID = '"& payment("spID") &"' AND MKT_T_PaymentRequest_H.pr_spayID = '1' group by  MKT_T_PaymentRequest_H.prID"
        'response.write Invoice_cmd.commandText

    set Invoice = Invoice_cmd.execute
    

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
        function getInvoice(){
            $.ajax({
                type: "get",
                url: "loaddatapr.asp?prID="+document.getElementById("prID").value,
                success: function (url) {
                // console.log(url);
                $('.datainvoice').html(url);
                                    
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
                    <span class="txt-pr-judul"> Payment  </span>
                </div>
                <div class="payment-request">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-6 mt-1">
                                    <span class="txt-payment-request"> Bank Account  </span><br>
                                    <select disabled class=" mb-2 inp-payment-request" name="accountbank" id="accountbank" aria-label="Default select example">
                                        <option><%=payment("payBank")%></option>
                                    </select>
                                    <input disabled type="hidden" class=" mb-2 inp-payment-request" name="payID" id="payID" value="<%=payment("payID")%>" style="width:10rem">
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Type Dokumen </span><br>
                                    <input disabled type="text" class=" mb-2 inp-payment-request" name="typepay" id="typepay" value="<%=payment("payType")%>" style="width:10rem"><br>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Tanggal Pembayaran </span><br>
                                    <input disabled type="text" class=" mb-2 inp-payment-request" name="tglpayment" id="tglpayment" value="<%=payment("payTanggal")%>" style="width:10rem"><br>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Tanggal Account </span><br>
                                    <input disabled type="text" class=" mb-2 inp-payment-request" name="tglaccount" id="tglaccount" value="<%=payment("payTanggalAcc")%>" style="width:9rem"><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <span class="txt-payment-request"> Deskripsi </span><br>
                                    <textarea disabled name="desc" id="desc" class="txt-payment-request" style="width:100%; height:2rem"><%=payment("payDesc")%> </textarea>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <div class="row">
                                        <div class="col-8">
                                            <span class="txt-payment-request">  Supplier ID </span><br>
                                            <input required type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=payment("spID")%>" ><br>
                                            <span class="txt-payment-request"> Nama Supplier </span><br>
                                            <input required type="text" class=" mb-2 inp-payment-request" name="namasupplier" id="namasupplier" value="<%=payment("spNama1")%>" ><br>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 align-items-center">
                                    <div class="row">
                                        <div class="col-6">
                                            <span class="txt-payment-request"> Jangan Waktu Pembayaran PO </span><br>
                                            <input required type="text" class=" mb-2 inp-payment-request" name="poterm" id="poterm" value="<%=payment("spPaymentTerm")%>" style="width:15rem"><br>
                                        </div>
                                        <div class="col-6">
                                            <span class="txt-payment-request"> Lokasi Supplier </span><br>
                                            <input required type="text" class=" mb-2 inp-payment-request" name="lokasi" id="lokasi" value="<%=payment("spAlamat")%>" style="width:14.5rem"><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-8">
                                            <span class="txt-purchase-order"> No Invoice ( Payment Request )</span><br>
                                            <select onchange="return getInvoice()" class=" mb-2 inp-purchase-order" name="prID" id="prID" aria-label="Default select example" required style="width:21rem">
                                                <option value="">Pilih Invoice</option>
                                                <% do while not Invoice.eof%>
                                                <option value="<%=Invoice("prID")%>"><%=Invoice("prID")%></option>
                                                <% Invoice.movenext
                                                loop%>
                                            </select>
                                        </div>
                                        <div class="col-4">
                                            <span class="txt-purchase-order"> Add Another Invoice </span><br>
                                            <button onclick="addinvoice()"class="btn-tambah-produk" style="width:9.3rem"> Add Invoice </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="datainvoice">

                            </div>
                            <hr>
                            <div class="tableinvoice">

                            </div>
                            <div class="row label-po align-items-center text-center mt-1">
                                <div class="col-12">
                                    <button class="btn-cetak-po" style="width:20rem" onclick="window.open('../../Pembelian/Invoice/paypdf.asp?payID='+document.getElementById('payID').value+'&tglpayment='+document.getElementById('tglpayment').value,'_Self')" > Cetak Bukti Kas Keluar </button>
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
    function addinvoice(){
            var payID = $('#payID').val();            
            var pay_spID = $('#supplierid').val();            
            var pay_prID = $('#prID').val();
            var pay_total = $('#total').val();
            var pay_tax = $('#tax').val();
            var pay_subtotal = $('#subtotal').val();
            $.ajax({
                type: "get",
                url: "P-PaymentDetail.asp",
                    data:{
                            payID:payID,
                            pay_spID:pay_spID,
                            pay_prID:pay_prID,
                            pay_total:pay_total,
                            pay_tax:pay_tax,
                            pay_subtotal:pay_subtotal
                        },
                    success: function (data) {
                    // location.reload();
                    $('.tableinvoice').html(data);
                    console.log(data);
                    
                    }
                });
            }
    </script>
</html>