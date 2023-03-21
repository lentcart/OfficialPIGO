<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    prID = request.queryString("prID") 
    set PaymentRequest_cmd = server.createObject("ADODB.COMMAND")
	PaymentRequest_cmd.activeConnection = MM_PIGO_String

        PaymentRequest_cmd.commandText = "SELECT MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prTanggalInv FROM MKT_T_PaymentRequest_D RIGHT OUTER JOIN  MKT_T_PaymentRequest_H ON MKT_T_PaymentRequest_D.prID_H = MKT_T_PaymentRequest_H.prID WHERE MKT_T_PaymentRequest_H.pr_custID = 'C0322000000002'  GROUP BY MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prTanggalInv"
        'response.write PaymentRequest_cmd.commandText

    set PaymentRequest = PaymentRequest_cmd.execute

    set Payment_cmd = server.createObject("ADODB.COMMAND")
	Payment_cmd.activeConnection = MM_PIGO_String

        Payment_cmd.commandText = "SELECT MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv, MKT_T_PaymentRequest_H.pr_SubTotal, MKT_T_PaymentRequest_D.pr_poPajak, MKT_M_Supplier.spID,  MKT_M_Supplier.spNama1, MKT_M_Supplier.spNama2, MKT_M_Supplier.spDesc, MKT_M_Supplier.spNpwp, MKT_M_Supplier.spPembayaran, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat,  MKT_M_Supplier.spPhone1, MKT_M_Supplier.spNoRekening, MKT_M_Supplier.spPemilikRek, GLB_M_Bank.BankName, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spBankID, GLB_M_Bank.BankID,  MKT_M_Supplier.spKey FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_PaymentRequest_H ON MKT_M_Supplier.spID = MKT_T_PaymentRequest_H.pr_spID LEFT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H LEFT OUTER JOIN GLB_M_Bank ON MKT_M_Supplier.spBankID = GLB_M_Bank.BankID WHERE MKT_T_PaymentRequest_H.prID = '"& prID &"' "
        'response.write Payment_cmd.commandText

    set Payment = Payment_cmd.execute

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
        function getpr(){
            $.ajax({
                type: "get",
                url: "loaddatapr.asp?prID="+document.getElementById("noinvoice").value,
                success: function (url) {
                // console.log(url);
                $('.datapo').html(url);
                                    
                }
            });
        }
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
                            <span class="txt-po-judul"> Payment Request </span>
                        </div>
                        <div class="col-2">
                            <button class=" btn-tambah-po txt-po-judul" onclick="window.open('../PaymentDetail/','_Self')" style="font-size:12px"> Payment Detail </button>
                        </div>
                    </div>
                </div>
                <form class="" action="P-Payment.asp" method="POST">
                <div class="payment-request">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-6 mt-1">
                                    <span class="txt-payment-request"> Bank Account  </span><br>
                                    <select  class=" mb-2 inp-payment-request" name="namabank" id="namabank" aria-label="Default select example">
                                        <option selected>Pilih</option>
                                        <option value="BCA"> BANK BCA </option>
                                    </select>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Type Dokumen </span><br>
                                    <select style="width:10rem" class=" mb-2 inp-payment-request" name="typepayment" id="typepayment" aria-label="Default select example">
                                        <option selected>Pilih</option>
                                        <option value="Payment PIGO">Payment PIGO</option>
                                    </select>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Tanggal Pembayaran </span><br>
                                    <input type="Date" class=" mb-2 inp-payment-request" name="tglpayment" id="tglpayment" value="" style="width:10rem"><br>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Tanggal Account </span><br>
                                    <input type="Date" class=" mb-2 inp-payment-request" name="tglaccount" id="tglaccount" value="" style="width:9rem"><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <span class="txt-payment-request"> Deskripsi </span><br>
                                    <textarea name="desc" id="desc" class="txt-payment-request" style="width:100%; height:2rem">Pembayaran : </textarea>
                                </div>
                            </div>
                            <div class="row mt-3 mb-3">
                                <div class="col-12">
                                    <span class="label-po txt-payment-request"> Business Partner </span>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-2">
                                    <span class="txt-purchase-order"> Kata Kunci </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=Payment("spKey")%>" ><br>
                                </div>
                                <div class="col-4 keysp">
                                    <span class="txt-purchase-order"> </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=Payment("spKey")%>,<%=Payment("spNama1")%>" style="width:19.4rem"><br>
                                </div>
                                <div class="col-2 keysp">
                                    <span class="txt-payment-request">  Supplier ID </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=Payment("spID")%>" ><br>
                                </div>
                                <div class="col-4 keysp">
                                    <span class="txt-payment-request"> Nama Supplier </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="namasupplier" id="namasupplier" value="<%=Payment("spNama1")%>" style="width:19.4rem"><br>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-2">
                                    <span class="txt-payment-request"> PayTerm </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="poterm" id="poterm" value="<%=Payment("spPaymentTerm")%>" style="width:10rem"><br>
                                </div>
                                <div class="col-4 keysp">
                                    <span class="txt-payment-request"> Nama CP Supplier </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="namacp" id="namacp" value="<%=Payment("spNamaCP")%>" style="width:19.4rem"><br>
                                </div>
                                <div class="col-6">
                                    <span class="txt-payment-request"> Lokasi Supplier </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="lokasi" id="lokasi" value="<%=Payment("spAlamat")%>" style="width:30rem"><br>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-2">
                                    <span class="txt-purchase-order"> NPWP </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=Payment("spnpwp")%>" ><br>
                                </div>
                                <div class="col-2 keysp">
                                    <span class="txt-purchase-order"> Phone</span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=Payment("spPhone1")%>,<%=Payment("spNama1")%>" style="width:10rem"><br>
                                </div>
                                <div class="col-2 keysp">
                                    <span class="txt-payment-request">  Bank ID </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=Payment("BankName")%>" ><br>
                                </div>
                                <div class="col-2 keysp">
                                    <span class="txt-payment-request"> No Rekening  </span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="namasupplier" id="namasupplier" value="<%=Payment("spNoRekening")%>" style="width:10rem"><br>
                                </div>
                                <div class="col-4 keysp">
                                    <span class="txt-payment-request"> Pemilik Rekening</span><br>
                                    <input readonly type="text" class=" mb-2 inp-payment-request" name="namasupplier" id="namasupplier" value="<%=Payment("spPemilikRek")%>" style="width:19.4rem"><br>
                                </div>
                            </div>
                            <div class="row label-po align-items-center text-center mt-1">
                                <div class="col-12">
                                    <input class="btn-supplier-baru" type="submit" name="simpan" id="simpan" value="Get Invoice">
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