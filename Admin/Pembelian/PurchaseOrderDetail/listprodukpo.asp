<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    namapd = request.queryString("namapd")
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
    Merchant_cmd.activeConnection = MM_PIGO_String
                
        Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute
    
    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText ="SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk,  MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenis, MKT_T_PurchaseOrder_H.poJenisOrder,  MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spTransaksi, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spNamaCP FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Supplier.spID = MKT_T_PurchaseOrder_H.po_spID LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE MKT_M_PIGO_Produk.pdNama = '"& namapd &"' AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' AND '"& tgle &"' GROUP BY MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenis, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spTransaksi, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spNamaCP " 
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
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        window.print();
        document.title = "List-Produk-PO-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-<%=request.Cookies("custEmail")%>";
    </script>
    <style>
        body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: white;
            font-size:12px;
            font-weight:450;
        }
        * {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
        }
        .page {
            width: 355.6mm;
            min-height: 215.9mm;
            padding: 10mm;
            margin: auto;
            border: none;
            border-radius: 5px;
            background: white;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .subpage {
            padding: 0cm;
            border:none;
            height:100%;
            outline: 0cm green solid;
        }
        
        @page {
            size: landscape;
            margin: 0;
        }
        @media print {
            html, body {
                width: 355.6mm;
            min-height: 215.9mm;        
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
                <div class="row align-items-center">
                    <div class="col-7">
                        <span style="font-size:16px; font-weight:bold"> Pembelian Produk Purchase Order </span><br>
                    </div>
                    <div class="col-5">
                        <div class="row">
                            <div class="col-2">
                                <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                            </div>
                            <div class="col-10">
                                <span class="Judul-Merchant"> <%=Merchant("custNama")%> </span><br>
                                <span class="Txt-Merchant"> <%=Merchant("custPhone1")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone2")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone3")%> </span><br>
                                <span class="Txt-Merchant"> <%=Merchant("almLengkap")%> </span><br>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3 mb-3" style="border-bottom:4px solid #eee">
                </div>
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                            <thead>
                                <tr class="text-center">
                                    <th> No </th>
                                    <th> No Purchase Order </th>
                                    <th> Supplier </th>
                                    <th> Nama Produk </th>
                                    <th> Unit </th>
                                    <th> QTY </th>
                                    <th> Harga </th>
                                    <th> Sub Total </th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                            <% do while not PurchaseOrder.eof %>
                                <tr>
                                    <td class="text-center"> <%=PurchaseOrder("no")%> </td>
                                    <td class="text-center"> <%=PurchaseOrder("poID")%>/<%=Cdate(PurchaseOrder("poTanggal"))%> </td>
                                    <td> <%=PurchaseOrder("spNama1")%> [<%=PurchaseOrder("spAlamat")%>] </td>
                                    <td> [<%=PurchaseOrder("pdPartNumber")%>] - <%=PurchaseOrder("pdNama")%> </td>
                                    <td class="text-center"> <%=PurchaseOrder("pdUnit")%> </td>
                                    <td class="text-center"> <%=PurchaseOrder("poQtyProduk")%> </td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(PurchaseOrder("poHargaSatuan")),"$","Rp. ")%> </td>
                                    <% total = PurchaseOrder("poQtyProduk")*PurchaseOrder("poHargaSatuan")%>
                                    <td class="text-center"> <%=Replace(FormatCurrency(total),"$","Rp. ")%> </td>
                                    <% 
                                        subtotal = subtotal + total 
                                        totalqty = totalqty + PurchaseOrder("poQtyProduk")
                                    %>
                                </tr>
                            <% PurchaseOrder.movenext
                            loop  %>
                                <tr>
                                    <td class="text-center"colspan="5"> Grand Total</td>
                                    <td colspan="2"class="text-center"> <%=totalqty %> </td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(subtotal),"$","Rp. ")%> </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>  
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>