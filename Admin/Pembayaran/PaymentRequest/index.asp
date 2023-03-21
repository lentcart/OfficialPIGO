<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    mmID = request.queryString("mmID")

    set MaterialReceipt_cmd = server.createObject("ADODB.COMMAND")
	MaterialReceipt_cmd.activeConnection = MM_PIGO_String

        MaterialReceipt_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, GLB_M_Bank.BankName, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1,  MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Rekening LEFT OUTER JOIN GLB_M_Bank ON MKT_M_Rekening.rkBankID = GLB_M_Bank.BankID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Rekening.rk_custID = MKT_M_Customer.custID ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID ON MKT_T_MaterialReceipt_H.mm_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 WHERE MKT_T_MaterialReceipt_H.mmID = '"& mmID &"' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, GLB_M_Bank.BankName, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1,  MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik"
        'response.Write MaterialReceipt_cmd.commandText 
    set MaterialReceipt = MaterialReceipt_cmd.execute
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
    <div id="loader-page" style="display:none" >
        <div class="container"id="loader" style="position:center; margin-top:20rem"></div>
        <div class="container cont-loader text-center" ><span> Loading ... </span></div>
    </div>
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
                                <div class="col-4 mt-1">
                                    <span class="txt-payment-request"> No Faktur / Surat Jalan BussinesPartner  </span><br>
                                    <input type="text" class=" mb-2 inp-payment-request" name="nofaktur" id="nofaktur" value="" ><br>
                                </div>
                                <div class="col-2 mt-1">
                                    <span class="txt-payment-request"> Tanggal Invoice </span><br>
                                    <input type="Date" class=" mb-2 inp-payment-request" name="tglinv" id="tglinv" value="" ><br>
                                </div>
                            </div>
                            <hr>
                            <div class="cont-mm" style="height:26rem">

                            <div class="row">
                                <div class="col-12">
                                    <div class="cont-material-rp">
                                        <div class="row">
                                            <div class="col-3">
                                                <span class="txt-payment-request"> No Material Receipt </span><br>
                                                <input readonly type="text" class=" mb-2 inp-payment-request" name="mmID" id="mmID" value="<%=MaterialReceipt("mmID")%>" style="width:15rem"><br>
                                            </div>
                                            <div class="col-3">
                                                <span class="txt-payment-request"> Tanggal Material Receipt </span><br>
                                                <input disabled type="text" class=" mb-2 inp-payment-request" name="mmTanggal" id="mmTanggal" value="<%=MaterialReceipt("mmTanggal")%>" style="width:14rem"><br>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-6">
                                                <div class="row">
                                                    <div class="col-3">
                                                        <span class="txt-payment-request">  BussinesPart ID </span><br>
                                                        <input readonly type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=MaterialReceipt("custID")%>" style="width:100%"><br>
                                                    </div>
                                                    <div class="col-9">
                                                        <span class="txt-payment-request"> Nama BussinesPartner </span><br>
                                                        <input disabled type="text" class=" mb-2 inp-payment-request" name="namasupplier" id="namasupplier" value="<%=MaterialReceipt("custNama")%>"style="width:100%" ><br>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-12">
                                                        <span class="txt-payment-request"> Lokasi BussinesPartner </span><br>
                                                        <input disabled type="text" class=" mb-2 inp-payment-request" name="lokasi" id="lokasi" value="<%=MaterialReceipt("almLengkap")%>"><br>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6 align-items-center">
                                                <div class="row">
                                                    <div class="col-3">
                                                        <span class="txt-payment-request"> PaymentTerm </span><br>
                                                        <input disabled type="text" class="text-center mb-2 inp-payment-request" name="poterm" id="poterm" value="<%=MaterialReceipt("custPaymentTerm")%>" style="width:5.8rem"><br>
                                                    </div>
                                                    <div class="col-9">
                                                        <span class="txt-payment-request"> Nama CP BussinesPartner </span><br>
                                                        <input disabled type="text" class=" mb-2 inp-payment-request" name="namacp" id="namacp" value="<%=MaterialReceipt("custNamaCP")%>"><br>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-4">
                                                        <span class="txt-payment-request"> BANK </span><br>
                                                        <input disabled type="text" class="text-center mb-2 inp-payment-request" name="poterm" id="poterm" value="<%=MaterialReceipt("BankName")%>"><br>
                                                    </div>
                                                    <div class="col-4">
                                                        <span class="txt-payment-request"> No Rekening </span><br>
                                                        <input disabled type="text" class=" mb-2 inp-payment-request" name="namacp" id="namacp" value="<%=MaterialReceipt("rkNomorRk")%>"><br>
                                                    </div>
                                                    <div class="col-4">
                                                        <span class="txt-payment-request"> Nama Pemilik Rek </span><br>
                                                        <input disabled type="text" class=" mb-2 inp-payment-request" name="namacp" id="namacp" value="<%=MaterialReceipt("rkNamaPemilik")%>"><br>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <div class="cont-material-rp"  style=" height:12rem; overflow:scroll; overflow-x:hidden">
                                        <%
                                            MaterialReceipt_cmd.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_D.poPajak FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H RIGHT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE (MKT_T_MaterialReceipt_H.mmID = '"& mmID &"') AND (MKT_T_MaterialReceipt_H.mm_custID = '"& MaterialReceipt("custID") &"') GROUP BY MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_D.poPajak"
                                            set PurchaseOrder = MaterialReceipt_cmd.execute
                                        %>
                                        <% do while not PurchaseOrder.eof %>
                                        <div class="row">
                                            <div class="col-6">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <span class="txt-payment-request"> No Purchase Order </span><br>
                                                        <input readonly type="text" class=" mb-2 inp-payment-request" name="poID" id="poID" value="<%=PurchaseOrder("poID")%>"><br>
                                                    </div>
                                                    <div class="col-6">
                                                        <span class="txt-payment-request"> Tanggal Purchase Order </span><br>
                                                        <input disabled type="text" class=" mb-2 inp-payment-request" name="poTanggal" id="poTanggal" value="<%=Cdate(PurchaseOrder("mm_poTanggal"))%>"><br>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                            <%
                                                MaterialReceipt_cmd.commandText = "SELECT SUM(mm_pdSubtotal) as SubTotal FROM MKT_T_MaterialReceipt_D2 WHERE (MKT_T_MaterialReceipt_D2.mm_poID = '"& PurchaseOrder("poID") &"')"
                                                set PO = MaterialReceipt_cmd.execute
                                            %>
                                                <div class="row">
                                                    <div class="col-4">
                                                        <span class="txt-payment-request"> Sub Total </span><br>
                                                        <input readonly type="hidden" class=" mb-2 inp-payment-request" name="poSubTotal" id="poSubTotal" value="<%=PO("SubTotal")%>">
                                                        <input readonly type="text" class=" mb-2 inp-payment-request"  value="<%=Replace(FormatCurrency(PO("SubTotal")),"$","Rp. ")%>"><br>
                                                    </div>
                                                    <div class="col-4">
                                                        <span class="txt-payment-request"> Pajak <b>( <%=PurchaseOrder("poPajak")%> % )</b> </span><br>
                                                        <%
                                                            tax = PurchaseOrder("poPajak")/100*PO("SubTotal")
                                                        %>
                                                        <input readonly type="hidden" class=" mb-2 inp-payment-request" name="poPajak" id="poPajak" value="<%=PurchaseOrder("poPajak")%>">
                                                        <input disabled type="text" class=" mb-2 inp-payment-request" value="<%=Replace(FormatCurrency(tax),"$","Rp. ")%>"><br>
                                                    </div>
                                                    <div class="col-4">
                                                        <span class="txt-payment-request"> Grand Total </span><br>
                                                        <%
                                                            GrandTotal = PO("SubTotal")+tax
                                                        %>
                                                        <input readonly type="text" class=" mb-2 inp-payment-request" value="<%=Replace(FormatCurrency(GrandTotal),"$","Rp. ")%>"><br>
                                                    </div>
                                                    <% totalk = totalk + GrandTotal%>
                                                </div>
                                            </div>
                                            
                                        </div>
                                        <% PurchaseOrder.movenext
                                        loop %>
                                    </div>
                                </div>
                            </div>
                            <div class="row align-items-center mt-2">
                                <div class="col-12">
                                    <div class="cont-material-rp">
                                        <div class="row mt-1">
                                            <div class="col-10">
                                                <span class="txt-payment-request"><b> Total Keseluruhan </b></span>
                                            </div>
                                            <div class="col-2">
                                                <input readonly type="hidden" class=" mb-2 inp-payment-request" name="SubTotal" id="SubTotal" value="<%=totalk%>">
                                                <input readonly type="text" class=" mb-2 inp-payment-request" value="<%=Replace(FormatCurrency(totalk),"$","Rp. ")%>"><br>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </div>
                            <div class="cont-mm ">
                                <div class="row align-items-center mt-4">
                                    <div class="col-2">
                                        <Input class="btn-cetak-po" type="submit" style="width:10rem" Value="Add Payment Request"> 
                                    </div>
                                    <div class="col-4">
                                        <button class="btn-cetak-po" style="width:5rem"> Batal</span>
                                    </div>
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