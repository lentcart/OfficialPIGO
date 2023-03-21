<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    		
	poID = request.queryString("poID")
    tanggalpo = request.queryString("poTanggal")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String
			
	PurchaseOrder_cmd.commandText = "SELECT poStatusKredit FROM MKT_T_PurchaseOrder_H WHERE poID = '"& poID &"' "
    'response.write PurchaseOrder_cmd.commandText
	set StatusKredit = PurchaseOrder_cmd.execute

    if StatusKredit("poStatusKredit") = "01" then 
        PurchaseOrder_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_M_Customer.custNama as custNama, MKT_M_Alamat.almLengkap as almLengkap, MKT_T_PurchaseOrder_D.poPajak, MKT_M_Customer.custID, MKT_M_Customer.custEmail as custEmail,  MKT_M_Customer.custPhone1 as custPhone1, MKT_M_Customer.custFax as custFax, MKT_M_Customer.custNpwp as custNpwp, MKT_M_Customer.custPaymentTerm as custPaymentTerm, MKT_M_Customer.custNamaCP as custNamaCP FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID ON  MKT_M_Alamat.alm_custID = MKT_M_Customer.custID WHERE (MKT_T_PurchaseOrder_H.poID ='"& poID &"') AND (MKT_T_PurchaseOrder_H.poTanggal ='"& Tanggalpo &"') AND  (MKT_M_Alamat.almJenis <> 'Alamat Toko')  GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_M_Customer.custNama, MKT_M_Alamat.almLengkap, MKT_T_PurchaseOrder_D.poPajak, MKT_M_Customer.custID, MKT_M_Customer.custEmail,  MKT_M_Customer.custPhone1, MKT_M_Customer.custFax, MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP"
        'response.write PurchaseOrder_cmd.commandText
        set PurchaseOrder = PurchaseOrder_cmd.execute
    else
        PurchaseOrder_cmd.commandText = "SELECT MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.poTglOrder,  MKT_T_PurchaseOrder_H.poDesc as custNama,0 as custNamaCP FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID  where poID = '"& poID &"' and poStatusKredit = '"& StatusKredit("poStatusKredit") &"'  GROUP BY MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.poTglOrder,  MKT_T_PurchaseOrder_H.poDesc"
        'response.write PurchaseOrder_cmd.commandText
        set PurchaseOrder = PurchaseOrder_cmd.execute
    end if 


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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/DataTables/datatables.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
        var today = new Date();

        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
            // window.print();
            document.title = "BuktiPO-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";
        const myTimeout = setTimeout(myGreeting, 2000);

            function myGreeting() {
            window.print();
            }
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
            <!--#include file="../../HeaderPIGOA4.asp"-->
            <% do while not PurchaseOrder.eof %>
            <div class="row mt-2">
                <div class="col-5">
                    <div class="row">
                        <div class="col-2">
                            <span class="txt-desc"> Kepada</span><br>
                            <span class="txt-desc"> CP </span><br>
                        </div>
                        <div class="col-10">
                            &nbsp;&nbsp; <span class="txt-desc"> : </span>&nbsp; <span class="txt-desc"><%=PurchaseOrder("custNama")%></span><br>
                            &nbsp;&nbsp; <span class="txt-desc"> : </span>&nbsp; <span class="txt-desc"><%=PurchaseOrder("custNamaCP")%></span><br>
                        </div>
                    </div>
                </div>
                <div class="col-7" style="text-align:justify">
                    <div class="row">
                        <div class="col-2">
                            <span class="txt-desc"> Send To </span><br>
                            <span class="txt-desc"> Alamat </span><br>
                        </div>
                        <div class="col-10 p-0">
                            <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"><%=Merchant("custNama")%></span><br>
                            <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"><%=Merchant("almLengkap")%></span><br>
                        </div>
                    </div>
                </div>
            </div>
            <% if StatusKredit("poStatusKredit") = "01" then %>
            <div class="row mt-2">
                <div class="col-1">
                    <span class="txt-desc"> Alamat </span><br>
                    <span class="txt-desc"> Kontak </span>
                </div>  
                <div class="col-11">
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"><%=PurchaseOrder("almLengkap")%></span><br>
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"> Telepon</span> - <span class="txt-desc"><%=PurchaseOrder("custPhone1")%></span><br>
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"> Fax</span> - <span class="txt-desc"><%=PurchaseOrder("custFax")%></span><br>
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"> Email</span> - <span class="txt-desc"><%=PurchaseOrder("custEmail")%></span><br>
                </div>  
            </div>  
            <div class="row">
                <div class="col-1">
                    <span class="txt-desc"> Tanggal</span><br>
                    <span class="txt-desc"> T.O.P </span><br>
                </div>  
                <div class="col-11">
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"> <%=day(Purchaseorder("poTanggal"))%>&nbsp;<%=MonthName(month((Purchaseorder("poTanggal"))))%>&nbsp;<%=year(Purchaseorder("poTanggal"))%></span><br>
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"> n/<%=Purchaseorder("custPaymentTerm")%> </span><br>
                </div>  
            </div> 
            <% end if %> 
            <div class="row text-center mt-3">
                <div class="col-12">
                    <span class="txt-desc" style="font-size:20px"><u>  PURCHASE ORDER  </u></span><br>
                    <span class="txt-desc">  <%=PurchaseOrder("poID")%>/<%=Day(CDATE(PurchaseOrder("poTanggal")))%>/<%=Month(CDATE(PurchaseOrder("poTanggal")))%>/<%=Year(CDATE(PurchaseOrder("poTanggal")))%>  </span><br>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        </div>
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:11px">
                        <thead style="background-color:#aaa">
                            <tr>
                                <th class="text-center"> No </th>
                                <th class="text-center"> SKU/Part Number </th>
                                <th class="text-center"> Nama Produk </th>
                                <th class="text-center"> QTY </th>
                                <th class="text-center"> Harga </th>
                                <th class="text-center"> Total </th>
                            </tr>
                            
                        </thead>
                        <tbody>
                        <% if StatusKredit("poStatusKredit") = "01" then %>
                        <%
                            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS nourut, MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, round(MKT_T_PurchaseOrder_D.poHargaSatuan,0) AS Harga,MKT_T_PurchaseOrder_D.poSubTotal FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN   MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN  MKT_T_PurchaseOrder_H LEFT OUTER JOIN  MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID  where MKT_T_PurchaseOrder_H.po_custID = '"& PurchaseOrder("custID") &"' AND (MKT_T_PurchaseOrder_H.poTanggal ='"& PurchaseOrder("poTanggal")  &"') AND (MKT_T_PurchaseOrder_H.poID ='"& PurchaseOrder("poID")  &"') "
                            'response.write produk_cmd.commandText
                            set produk = produk_cmd.execute
                        %>
                        <% else %>
                            <%
                            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS nourut, MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, round(MKT_T_PurchaseOrder_D.poHargaSatuan,0) AS Harga,MKT_T_PurchaseOrder_D.poSubTotal FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN   MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN  MKT_T_PurchaseOrder_H LEFT OUTER JOIN  MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE  (MKT_T_PurchaseOrder_H.poTanggal ='"& PurchaseOrder("poTanggal")  &"') AND (MKT_T_PurchaseOrder_H.poID ='"& PurchaseOrder("poID")  &"') "
                            'response.write produk_cmd.commandText
                            set produk = produk_cmd.execute
                        %>
                        <% end if %>
                        <% do while not produk.eof%>
                            <tr>
                                <td class="text-center"> <%=produk("nourut")%> </td>
                                <td> <%=produk("pdPartNumber")%> </td>
                                <td> <%=produk("pdNama")%> </td>
                                <td class="text-center"> <%=produk("poQtyProduk")%> </td>
                                <td class="text-end"> <%=Replace(Replace(FormatCurrency(produk("Harga")),"$","Rp.  "),".00","")%> </td>
                                <td class="text-end"> <%=Replace(Replace(FormatCurrency(produk("poSubTotal")),"$","Rp.  "),".00","")%> </td>
                            </tr>
                            <%
                                subtotal = subtotal + produk("poSubTotal")
                            %>
                            <% produk.movenext
                            loop%>
                            <tr>
                                <th colspan="5" class="text-center"> Total </th>
                                <td class="text-end"> <%=Replace(Replace(FormatCurrency(subtotal),"$","Rp.  "),".00","")%> </td>
                            </tr>
                            <%
                                tax = PurchaseOrder("poPajak")/100*subtotal
                            %>
                            <tr>
                                <th colspan="5" class="text-center"> TAX </th>
                                <td class="text-end"> <%=Replace(Replace(FormatCurrency(tax),"$","Rp.  "),".00","")%> </td>
                            </tr>
                            <%
                                GrandTotal = subtotal+tax
                            %>
                            <tr>
                                <th colspan="5" class="text-center"> GrandTotal </th>
                                <td class="text-end">
                                    <input type="hidden" name="subtotal" id="subtotal" value="<%=GrandTotal%>">
                                    <%=Replace(Replace(FormatCurrency(GrandTotal),"$","Rp.  "),".00","")%> 
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
            <% PurchaseOrder.movenext
            loop %>  
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
                <div class="col-12">
                    <span class="txt-desc"> Tanggal, .................................... </span><br>
                    <span class="txt-desc"> Hormat Kami,</span><br>
                    <span class="txt-desc"> PT. Perkasa Indah Gemilang Oetama</span><br><br><br><br>
                    <span class="txt-desc"><u> F.Deni Arijanto </u></span><br>


                </div>
            </div>          
        </div>
    </div>
</body>
<script>
    $(function () {
        $(".test").terbilang();
        $(".as-output-text").terbilang({
            nominal: document.getElementById("subtotal").value,
            output: 'text'
        });
    })
</script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>