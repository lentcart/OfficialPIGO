<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    prID = request.queryString("prID")
    tanggalivn = request.queryString("tglinvoice")
    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set PaymentRequest_cmd = server.createObject("ADODB.COMMAND")
	PaymentRequest_cmd.activeConnection = MM_PIGO_String
			
	PaymentRequest_cmd.commandText = "SELECT MKT_M_Customer.custNama, MKT_T_PaymentRequest_H.pr_custID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv, MKT_M_Customer.custPaymentTerm, MKT_T_PaymentRequest_H.prID,  MKT_T_PaymentRequest_H.pr_mmID, MKT_T_PaymentRequest_D.pr_poID, MKT_T_PurchaseOrder_D.poPajak FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H RIGHT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PaymentRequest_D.pr_poID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID ON  MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H ON MKT_M_Customer.custID = MKT_T_PaymentRequest_H.pr_custID where MKT_T_PaymentRequest_H.prID = '"& prID &"' AND MKT_T_PaymentRequest_H.prTanggalInv = '"& tanggalivn &"' GROUP BY MKT_M_Customer.custNama, MKT_T_PaymentRequest_H.pr_custID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv, MKT_M_Customer.custPaymentTerm, MKT_T_PaymentRequest_H.prID,  MKT_T_PaymentRequest_H.pr_mmID, MKT_T_PaymentRequest_D.pr_poID, MKT_T_PurchaseOrder_D.poPajak"
    'response.write PaymentRequest_cmd.commandText
	set PaymentRequest = PaymentRequest_cmd.execute


    set mm_cmd = server.createObject("ADODB.COMMAND")
	mm_cmd.activeConnection = MM_PIGO_String

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/terbilang.js"></script>

    <script>
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "PaymentRequest-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
    $(function () {
        $(".test").terbilang();
        $(".as-output-text").terbilang({
            nominal: document.getElementById("subtotal").value,
            output: 'text'
        });
    })
    </script>
    <style>
        body {
        width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
        font-size: 12px;
    }
    * {
        box-sizing: border-box;
        -moz-box-sizing: border-box;
    }
    .page {
        width: 210mm;
        min-height: 297mm;
        padding: 0mm;
        margin: 10mm auto;
        border: 0px #D3D3D3 solid;
        border-radius: 5px;
        background: white;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }
    .subpage {
        padding: 1cm;
        border: 0px red solid;
        height: 257mm;
        outline: 0cm #FFEAEA solid;
    }
    
    @page {
        size: A4;
        margin: 0;
    }
    @media print {
        html, body {
            width: 210mm;
            height: 297mm;        
        }
        .page {
            margin: 0;
            border: initial;
            border-radius: initial;
            width: initial;
            min-height: initial;
            box-shadow: initial;
            background: initial;
            page-break-after: always;
        }
    }
    </style>
    </head>
<body>  
    <div class="book">
        <div class="page">
            <div class="subpage">
                <% do while not Merchant.eof%>
                <div class="row align-items-center">
                    <div class="col-1">
                        <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                    </div>
                    <div class="col-11 text-end">
                        <span class="Judul-Merchant" style="font-size:22px"> <b><%=Merchant("custNama")%> </b></span><br>
                        <span class="txt-desc"> <%=Merchant("almLengkap")%> </span><br>
                        <span class="txt-desc"> <%=Merchant("custEmail")%> </span><br>
                        <span class="txt-desc"> <%=Merchant("custPhone1")%> </span> / <span class="txt-desc"> <%=Merchant("custPhone2")%> </span><br>
                        
                    </div>
                </div>
                <div class="row mt-2 mb-2" style="border-bottom:3px solid #aaaaaa">
                </div>
                <% Merchant.movenext
                loop%>

                
                <% do while not PaymentRequest.eof%>
                <div class="row">
                    <div class="col-6">
                        <div class="row">
                            <div class="col-4">
                                <span class="txt-desc"> PO Ref </span><br>
                            </div>
                            <div class="col-1 p-0">
                                <span class="txt-desc"> : </span><br>
                            </div>
                            <div class="col-4 p-0 ">
                                <span class="txt-desc"> <%=PaymentRequest("prFaktur")%> </span><br>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                <span class="txt-desc"> Tanggal Invoice </span><br>
                            </div>
                            <div class="col-1 p-0">
                                <span class="txt-desc"> : </span><br>
                            </div>
                            <div class="col-4 p-0 ">
                                <span class="txt-desc"> <%=PaymentRequest("prTanggalInv")%> </span><br>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-4">
                                <span class="txt-desc"> BussinesPartner </span><br>
                                <span class="txt-desc"> No PO </span><br>
                            </div>
                            <div class="col-1 p-0">
                                <span class="txt-desc"> : </span><br>
                                <span class="txt-desc"> : </span><br>
                            </div>
                            <div class="col-7 p-0 ">
                                <span class="txt-desc"><%=PaymentRequest("custNama")%></span><br>
                                <span class="txt-desc"><%=PaymentRequest("pr_poID")%></span><br>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="row">
                            <div class="col-4">
                                <span class="txt-desc"> T.O.P </span><br>
                                <span class="txt-desc"> Jatuh Tempo </span><br>
                                <span class="txt-desc"> Receipt No</span><br>
                            </div>
                            <div class="col-1 p-0">
                                <span class="txt-desc"> : </span><br>
                                <span class="txt-desc"> : </span><br>
                                <span class="txt-desc"> : </span><br>
                            </div>
                            <div class="col-7 p-0">
                                <span class="txt-desc"><%=PaymentRequest("custPaymentTerm")%></span><br>
                                <span class="txt-desc">-</span><br>
                                <%
                                    mm_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_MaterialReceipt_H RIGHT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_MaterialReceipt_H.mmID = MKT_T_PaymentRequest_D.pr_mmID ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H ON  MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID where MKT_T_PaymentRequest_H.pr_custID = '"& PaymentRequest("pr_custID") &"' AND MKT_T_PaymentRequest_D.pr_poID = '"& PaymentRequest("pr_poID") &"' AND MKT_T_PaymentRequest_H.prID = '"& PaymentRequest("prID") &"' group by MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal "
                                    'response.write mm_cmd.commandText
                                    set mm = mm_cmd.execute
                                %>
                                <%do while not mm.eof%>
                                <span class="txt-desc"><%=mm("mmID")%></span><br>
                                <%mm.movenext
                                loop%>
                            </div>
                        </div>
                    </div>
                </div>
            <div class="row text-center mt-3">
                <div class="col-12">
                    <span class="txt-desc" style="font-size:20px">PAYMENT REQUEST</span><br>
                    <span class="txt-desc">  <%=PaymentRequest("prID")%>  </span><br>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed mt-2" style="font-size:12px">
                        <thead>
                            <tr>
                                <th class="text-center"> No </th>
                                <th class="text-center"> Item </th>
                                <th class="text-center"> Satuan </th>
                                <th class="text-center"> Qty</th>
                                <th class="text-center"> Harga</th>
                                <th class="text-center"> Sub Total</th>
                            </tr>
                            
                        </thead>
                        <tbody>
                        <% 
                            produk_cmd.commandText = "SELECT MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_PaymentRequest_D LEFT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_PaymentRequest_D.pr_mmID = MKT_T_MaterialReceipt_H.mmID RIGHT OUTER JOIN MKT_T_PaymentRequest_H ON MKT_T_PaymentRequest_D.prID_H = MKT_T_PaymentRequest_H.prID LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 ON  MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID where MKT_T_PaymentRequest_H.pr_custID = '"& PaymentRequest("pr_custID") &"'  AND MKT_T_PaymentRequest_D.pr_poID = '"& PaymentRequest("pr_poID") &"' AND MKT_T_PaymentRequest_H.prID = '"& PaymentRequest("prID") &"' group by MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal "
                            'response.write produk_cmd.commandText
                            set produk = produk_cmd.execute
                        %>
                        <% 
                            no = 0 
                            do while not produk.eof
                            no = no + 1
                        %>
                            <tr>
                                <td class="text-center"> <%=no%> </td>
                                <td> <%=produk("pdNama")%> </td>
                                <td class="text-center"> <%=produk("pdUnit")%> </td>
                                <td class="text-center"> <%=produk("mm_pdQtyDiterima")%> </td>
                                <td class="text-center"> <%=Replace(FormatCurrency(produk("mm_pdHarga")),"$","Rp.  ")%> </td>
                                <% total = produk("mm_pdQtyDiterima")*produk("mm_pdHarga") %>
                                <td class="text-center"> <%=Replace(FormatCurrency(total),"$","Rp.  ")%> </td>
                            </tr>
                            <%
                                subtotal = subtotal + total
                            %>
                            <% produk.movenext
                            loop%>
                            <tr>
                                <th colspan="5" class="text-right"> Total </th>
                                <td class="text-center"> <input type="hidden" name="subtotal" id="subtotal" value="<%=subtotal%>"> <%=Replace(FormatCurrency(subtotal),"$","Rp.  ")%> </td>
                            </tr>
                            <%
                                tax = PaymentRequest("poPajak")/100*subtotal
                            %>
                            <tr>
                                <th colspan="5" class="text-right"> TAX </th>
                                <td class="text-center"> <%=tax%> </td>
                            </tr>
                            <%
                                GrandTotal = subtotal+tax
                            %>
                            <tr>
                                <th colspan="5" class="text-right"> GrandTotal </th>
                                <td class="text-center"> <%=GrandTotal%> </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row mt-1">
                    <div class="col-2">
                        <span class="txt-desc">Terbilang</span><br>
                    </div>
                    <div class="col-10 p-0" style="border-bottom: 1px dotted black;">
                        <input type="hidden" name="total" id="total" value="12584">
                        <span class="txt-desc"> : </span>  &nbsp;&nbsp;  <b><span class="as-output-text txt-desc"></span></b>
                        <b><span class=" txt-desc">Rupiah</span></b>
                    </div>
                </div>
            <% PaymentRequest.movenext
            loop %>  
            <div class="row text-center" style="margin-top:2rem">
                <div class="col-4">
                    <span class="txt-desc"> </span><br>
                    <span class="txt-desc"> Dibuat Oleh,</span><br><br><br><br>
                    <span class="txt-desc">...........................</span><br>
                </div>
                <div class="col-4">
                    <span class="txt-desc"></span><br>
                    <span class="txt-desc"> Disetujui Oleh,</span><br><br><br><br>
                    <span class="txt-desc">F. Deni Arijanto</span><br>
                </div>
                <div class="col-4">
                    <span class="txt-desc"> Tanggal, <%=Cdate(date())%> </span><br>
                    <span class="txt-desc"> Mengetahui,</span><br><br><br><br>
                    <span class="txt-desc">...........................</span><br>
                </div>
            </div>     
            </div>          
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>