<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    InvAPID         = request.queryString("InvAPID")
    InvAP_Tanggal   = request.queryString("InvAP_Tanggal")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
    set jatuhtempo_cmd = server.createObject("ADODB.COMMAND")
	jatuhtempo_cmd.activeConnection = MM_PIGO_String
    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

	Merchant_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, MKT_T_InvoiceVendor_D.InvAP_Ket FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_InvoiceVendor_H LEFT OUTER JOIN MKT_T_InvoiceVendor_D LEFT OUTER JOIN MKT_T_InvoiceVendor_D1 ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_D1.InvAP_DLine ON MKT_T_InvoiceVendor_H.InvAPID = MKT_T_InvoiceVendor_D.InvAP_IDH ON  MKT_M_Customer.custID = MKT_T_InvoiceVendor_H.InvAP_custID WHERE MKT_T_InvoiceVendor_H.InvAPID = '"& InvAPID &"' AND MKT_T_InvoiceVendor_H.InvAP_Tanggal = '"& InvAP_Tanggal &"' GROUP BY MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, MKT_T_InvoiceVendor_D.InvAP_Ket"
    'response.Write Merchant_cmd.commandText
	set InvoiceVendor = Merchant_cmd.execute

    if InvoiceVendor("InvAP_Ket") = "TF" then

        Payterm = InvoiceVendor("custPaymentTerm")
        
        Merchant_cmd.commandText = "SELECT MKT_T_InvoiceVendor_D.InvAP_Line, MKT_T_InvoiceVendor_H.InvAPID FROM MKT_T_TukarFaktur_D RIGHT OUTER JOIN MKT_T_InvoiceVendor_D LEFT OUTER JOIN MKT_T_TukarFaktur_H ON MKT_T_InvoiceVendor_D.InvAP_Line = MKT_T_TukarFaktur_H.TF_ID LEFT OUTER JOIN MKT_T_InvoiceVendor_D1 ON MKT_T_InvoiceVendor_D.InvAP_Line = MKT_T_InvoiceVendor_D1.InvAP_DLine RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID ON LEFT(MKT_T_TukarFaktur_D.TFD_ID, 16) = MKT_T_TukarFaktur_H.TF_ID WHERE (MKT_T_InvoiceVendor_D.InvAP_Ket = '"& InvoiceVendor("InvAP_Ket")&"') and InvAP_IDH = '"& InvAPID &"' GROUP BY MKT_T_InvoiceVendor_D.InvAP_Line, MKT_T_InvoiceVendor_H.InvAPID "
        'response.Write Merchant_cmd.commandText & "<br><br>"
        set TukarFaktur = Merchant_cmd.execute
        'response.Write TukarFaktur("InvAP_Line") & "<br><br>"

        Merchant_cmd.commandText = "SELECT MKT_T_TukarFaktur_D.TF_mmID FROM MKT_T_TukarFaktur_D RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) = MKT_T_TukarFaktur_H.TF_ID WHERE MKT_T_TukarFaktur_H.TF_ID = '"& TukarFaktur("InvAP_Line") &"' "
        'response.Write Merchant_cmd.commandText & "<br><br>"
        set MaterialReceipt = Merchant_cmd.execute
        do while not MaterialReceipt.eof
            'response.Write MaterialReceipt("TF_mmID")  & "<br><br>"
            MM = MaterialReceipt("TF_mmID")

            Merchant_cmd.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_PurchaseOrder_H.po_JatuhTempo FROM MKT_T_MaterialReceipt_H RIGHT OUTER JOIN MKT_T_TukarFaktur_D ON MKT_T_MaterialReceipt_H.mmID = MKT_T_TukarFaktur_D.TF_mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 LEFT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_MaterialReceipt_D1.mm_poID = MKT_T_PurchaseOrder_H.poID ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON LEFT(MKT_T_TukarFaktur_D.TFD_ID, 16) = MKT_T_TukarFaktur_H.TF_ID WHERE MKT_T_MaterialReceipt_H.mmID = '"& MaterialReceipt("TF_mmID") &"' GROUP BY MKT_T_MaterialReceipt_D1.mm_poID,MKT_T_PurchaseOrder_H.po_JatuhTempo"
            'response.Write Merchant_cmd.commandText & "<br><br>"
            set PurchaseOrder = Merchant_cmd.execute
            'response.Write PurchaseOrder("po_JatuhTempo") & "<br><br>"
            PO = PurchaseOrder("mm_poID")
            JatuhTempoPembayaran = PurchaseOrder("po_JatuhTempo")

            produk_cmd.commandText = "SELECT MKT_T_PurchaseOrder_D.po_pdID, MKT_M_PIGO_Produk.pdNama AS Keterangan, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poPdUnit,  MKT_T_PurchaseOrder_D.poHargaSatuan AS Jumlah, MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_D.poSubTotal AS TotalLine, MKT_T_PurchaseOrder_D.poTotal FROM MKT_T_InvoiceVendor_H LEFT OUTER JOIN MKT_T_TukarFaktur_H RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_TukarFaktur_H.TF_ID = MKT_T_InvoiceVendor_D.InvAP_Line LEFT OUTER JOIN MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_TukarFaktur_D1 LEFT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_TukarFaktur_D1.TFD1_poID = MKT_T_PurchaseOrder_H.poID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_TukarFaktur_D ON LEFT(MKT_T_TukarFaktur_D1.TFD1_ID,16) = LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) ON MKT_T_TukarFaktur_H.TF_ID = LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) LEFT OUTER JOIN MKT_T_InvoiceVendor_D1 ON MKT_T_InvoiceVendor_D.InvAP_Line = MKT_T_InvoiceVendor_D1.InvAP_DLine ON MKT_T_InvoiceVendor_H.InvAPID = MKT_T_InvoiceVendor_D.InvAP_IDH WHERE MKT_T_PurchaseOrder_H.poID = '"& PurchaseOrder("mm_poID") &"' AND MKT_T_InvoiceVendor_H.InvAPID = '"& InvAPID &"' AND MKT_T_InvoiceVendor_H.InvAP_custID = '"& InvoiceVendor("custID") &"'"
            'response.write produk_cmd.commandText
            set produk = produk_cmd.execute
            produkitem = produk("poQtyProduk")
            produksatuan = produk("poPdUnit")
            tax = produk("poPajak")

        MaterialReceipt.movenext
        loop


    else 

        Payterm = 0
        JatuhTempoPembayaran = InvAP_Tanggal

        produk_cmd.commandText = "SELECT MKT_T_InvoiceVendor_D1.InvAP_Keterangan AS Keterangan, MKT_T_InvoiceVendor_D1.InvAP_Jumlah as Jumlah , MKT_T_InvoiceVendor_D1.InvAP_Tax as Tax, MKT_T_InvoiceVendor_D1.InvAP_TotalLine as TotalLine FROM MKT_T_InvoiceVendor_D LEFT OUTER JOIN MKT_T_InvoiceVendor_D1 ON MKT_T_InvoiceVendor_D.InvAP_Line = MKT_T_InvoiceVendor_D1.InvAP_DLine RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID Where MKT_T_InvoiceVendor_H.InvAPID = '"& InvAPID &"' AND MKT_T_InvoiceVendor_H.InvAP_custID = '"& InvoiceVendor("custID") &"'  "
        'response.write produk_cmd.commandText
        set produk = produk_cmd.execute
        produkitem = 1
        produksatuan = ""
        tax = produk("Tax")
        
    end if

    

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
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script>
        var today = new Date();

        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
            // window.print();
            document.title = "BuktiFaktur-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";

        $(function () {
            $(".test").terbilang();
            $(".as-output-text").terbilang({
                nominal: document.getElementById("subtotal").value,
                output: 'text'
            });
        })
    </script>
    <style>
        .tb-faktur{
            border:0px;
            border-bottom:2px solid black;
            border-top:2px solid black;
        }
        .dotted {
            border: 2px dotted black; 
            width:100%;
            border-style: none none dotted; 
            color: #fff; 
            background-color: #fff; }
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
            .footer{
                margin-top:3rem;
                padding:2px 30px;
                border: 0px red solid;
                height: 100%;
                outline: 0cm #FFEAEA solid;
            }
            .cont-footer{
                padding:10px 5px;
                background:#eee;
                color:black;
                border:1px solid #eee;
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
                <div class="row mt-2" style="border-bottom:3px solid black">
                </div>
                <% Merchant.movenext
                loop%> 
                <div class="row mt-3" style="font-size:10px">
                    <div class="col-2">
                        <span class="txt-desc"> BussinesPartner </span><br>
                        <span class="txt-desc"> PO ID </span><br>
                        <span class="txt-desc"> Receipt No </span><br>
                    </div>
                    <div class="col-4">
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp;<%=InvoiceVendor("custNama")%> </span><br>
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp; <%=PO%></span><br>
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp; <%=MM%></span><br>
                    </div>
                    <div class="col-2">
                        <span class="txt-desc"> No Invoice </span><br>
                        <span class="txt-desc"> Tanggal</span><br>
                        <span class="txt-desc"> TOP </span><br>
                        <span class="txt-desc"> Jatuh Tempo </span><br>
                        
                    </div>
                    <div class="col-4">
                        <span class="txt-desc"> <b><span class="txt-desc"> : </span>&nbsp;&nbsp; <%=InvAPID%> </span></b><br>
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp; <%=day(InvAP_Tanggal)%>&nbsp;<%=MonthName(Month(InvAP_Tanggal))%>&nbsp;<%=Year(InvAP_Tanggal)%></span><br>
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp; <%=Payterm%> </span><br>
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp; <%=day(JatuhTempoPembayaran)%>&nbsp;<%=MonthName(Month(JatuhTempoPembayaran))%>&nbsp;<%=Year(JatuhTempoPembayaran)%></span><br>
                    </div>
                </div>
                <div class="row  mt-4  text-center">
                    <div class="col-12">
                        <span class="txt-desc" style="font-size:20px"><u>  P A Y M E N T &nbsp; R E Q U E S T  </u></span><br>
                        <span class="txt-desc"><%=InvAPID%> / <%=CDate(InvAP_Tanggal)%>  </span><br>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed mt-2" style="font-size:12px">   <thead>
                                <tr>
                                    <th class="text-center"> No </th>
                                    <th class="text-center"> Satuan </th>
                                    <th class="text-center"> Qty</th>
                                    <th class="text-center"> Harga</th>
                                    <th class="text-center"> Sub Total</th>
                                </tr>
                            </thead>
                            <tbody style="border-top:1px solid black">
                            <% do while not produk.eof %>
                                <tr>
                                    <td><%=produk("keterangan")%> </td>
                                    <td><%=produksatuan%> </td>
                                    <td><%=produkitem%> </td>
                                    <td class="text-end"><%=Replace(Replace(FormatCurrency(produk("jumlah")),"$","Rp. "),".00","")%> </td>
                                    <td class="text-end"><%=Replace(Replace(FormatCurrency(produk("TotalLine")),"$","Rp. "),".00","")%> </td>
                                    <%
                                        total = total + produk("TotalLine")
                                    %>
                                </tr>
                            <% produk.movenext
                            loop %>
                            <%
                                subtotal = subtotal + total
                            %>
                            </tbody>
                            <thead>
                                <tr style="border-top:1px solid black">
                                    <th colspan="4"> Sub Total Item </th>
                                    <th class="text-end"><%=Replace(Replace(FormatCurrency(subtotal),"$","Rp. "),".00","")%></th>
                                </tr>
                                <%
                                    totaltax = tax/100*subtotal
                                %>
                                <tr>
                                    <th colspan="4"> Jumlah Tax </th>
                                    <th class="text-end"><%=Replace(Replace(FormatCurrency(totaltax),"$","Rp. "),".00","")%></th>
                                </tr>
                                <% grandtotal = subtotal+totaltax %>
                                <tr>
                                    <th colspan="4"> Grand Total</th>
                                    <th class="text-end"> <input class="text-end"type="hidden" name="subtotal" id="subtotal"  value="<%=grandtotal%>" style=" width:5rem; font-weight:bold"><%=Replace(Replace(FormatCurrency(grandtotal),"$","Rp. "),".00","")%></th>
                                </tr>
                            </thead>
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
                <div class="row text-center" style="margin-top:2rem">
                <div class="col-4">
                    <span class="txt-desc"> </span><br>
                    <span class="txt-desc"> Dibuat Oleh,</span><br><br><br><br>
                    <span class="txt-desc"><u>...........................</u></span><br>
                </div>
                <div class="col-4">
                    <span class="txt-desc"></span><br>
                    <span class="txt-desc"> Disetujui Oleh,</span><br><br><br><br>
                    <span class="txt-desc"><u>F. Deni Arijanto</u></span><br>
                </div>
                <div class="col-4">
                    <span class="txt-desc"> Tanggal, <%=Cdate(date())%> </span><br>
                    <span class="txt-desc"> Mengetahui,</span><br><br><br><br>
                    <span class="txt-desc"><u>...........................</u></span><br>
                </div>
            </div>
            </div>
        </div>
    </div>
</body>
    <script>
            var total = document.getElementById('total').value;
            var fax = document.getElementById('fax').value;
            var subtotal = document.getElementById('subtotall').value;
            
            var	reverse1 = total.toString().split('').reverse().join('');
            var reverse2 = fax.toString().split('').reverse().join('');
            var reverse3 = subtotal.toString().split('').reverse().join('');
            var ribuan1 	= reverse1.match(/\d{1,3}/g);
            var ribuan2 	= reverse2.match(/\d{1,3}/g);
            var ribuan3 	= reverse3.match(/\d{1,3}/g);
                ribuan1	= ribuan1.join('.').split('').reverse().join('');
                ribuan2	= ribuan2.join('.').split('').reverse().join('');
                ribuan3	= ribuan3.join('.').split('').reverse().join('');
            
            // Cetak hasil	
            document.getElementById('total').value = ("Rp."+ribuan1);
            document.getElementById('fax').value = ("Rp."+ribuan2);
            document.getElementById('subtotall').value = ("Rp."+ribuan3);
    </script>

    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>