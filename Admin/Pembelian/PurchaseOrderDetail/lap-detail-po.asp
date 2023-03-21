<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    poID = request.queryString("poid")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'   "
	set Merchant = Merchant_cmd.execute

	set supplier_cmd = server.createObject("ADODB.COMMAND")
	supplier_cmd.activeConnection = MM_PIGO_String
			
	supplier_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poJenisOrder,MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi,  MKT_T_PurchaseOrder_H.poTanggal FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H Where poID = '"& poID &"' AND almJenis <> 'Alamat Toko' GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi, MKT_T_PurchaseOrder_H.poJenisOrder,  MKT_T_PurchaseOrder_H.poTanggal"
    'response.write supplier_cmd.commandText
	set supplier = supplier_cmd.execute

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
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        window.print();
        document.title = "BuktiPO-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";
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

            <% do while not supplier.eof%>
                <div class="row p-2">
                    <div class="col-12 p-0">
                        <span style="font-size:14px"><b> <%=supplier("custNama")%> </b></span><br>
                        <span> <%=supplier("almLengkap")%> - <%=supplier("almProvinsi")%> </span><br>
                        <span> <%=supplier("custNamaCP")%> - <%=supplier("custPhone1")%> </span><br>
                        <span> n/<%=supplier("custPaymentTerm")%> </span><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6">
                        <table class="table  table-bordered table-condensed mt-1" style="font-size:12px">
                            <tr class="text-center">
                                <th> Purchase Order ID </th>
                                <th> Tanggal </th>
                                <th> Jenis Order </th>
                            </tr>
                            <tr class="text-center">
                                <td> <%=supplier("poID")%> </td>
                                <td> <%=day(supplier("poTanggal"))%>&nbsp;<%=MonthName(month((supplier("poTanggal"))))%>&nbsp;<%=year(supplier("poTanggal"))%> </td>
                                <% if supplier("poJenisOrder") = "1" then %>
                                <td> Slow Moving </td>
                                <% else %>
                                <td> Fast Moving </td>
                                <% end if %>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <div class="row mt-1">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                            <thead>
                                <tr class="text-center">
                                    <th> No </th>
                                    <th> Nama Produk </th>
                                    <th> Unit </th>
                                    <th> QTY </th>
                                    <th> Harga </th>
                                    <th> Sub Total </th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                            <%
                                produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenis, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.po_custID, MKT_T_PurchaseOrder_D.po_pdID, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk,  MKT_T_PurchaseOrder_D.poPdUnit, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_D.poDiskon, MKT_T_PurchaseOrder_D.poSubTotal, MKT_M_PIGO_Produk.pdID,  MKT_M_PIGO_Produk.pdNama FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID where MKT_T_PurchaseOrder_H.poID = '"& supplier("poID") &"' AND MKT_T_PurchaseOrder_H.po_custID = '"& supplier("custID") &"'"
                                'response.write produk_cmd.commandText
                                set produk = produk_cmd.execute

                            %>
                            <% do while not produk.eof %>
                                <tr>
                                    <td class="text-center"> <%=produk("no")%> </td>
                                    <td> <b>[<%=produk("pdPartNumber")%>] </b>&nbsp;<%=produk("pdNama")%> </td>
                                    <td class="text-center"> <%=produk("poPdUnit")%> </td>
                                    <td class="text-center"> <%=produk("poQtyProduk")%> </td>
                                    <td class="text-center"> <%=Replace(Replace(FormatCurrency(produk("poHargaSatuan")),"$","Rp.  "),".00","")%> </td>
                                    <td class="text-center"> <%=Replace(Replace(FormatCurrency(produk("poSubTotal")),"$","Rp.  "),".00","")%> </td>
                                </tr>
                                <%
                                    totalqty = totalqty + produk("poQtyProduk") 
                                    totalharga  = totalharga + produk("poHargaSatuan")
                                    grandtotal = grandtotal + produk("poSubTotal")
                                    
                                %>
                            <% produk.movenext
                            loop  %>
                                <%
                                    grandtotalqty = grandtotalqty + totalqty
                                    totalqty = 0
                                    grantotalharga = grandtotalharga + totalharga
                                    totalharga = 0
                                    grandsubtotal = grandsubtotal + grandtotal
                                    grandtotal = 0
                                %>
                                <tr>
                                    <th class="text-center" colspan="5"> Total </th>

                                    <th class="text-center"> <%=Replace(Replace(FormatCurrency(grandsubtotal),"$","Rp. "),".00","")%> </th>
                                </tr>
                                    <%
                                        GranQTY = GranQTY + grandtotalqty
                                        grandtotalqty = 0
                                        totalkeseluruhan = totalkeseluruhan + grandsubtotal
                                        grandsubtotal = 0


                                    %>
                            </tbody>
                            
                        </table>
                    </div>
                </div>
                <% supplier.movenext
                loop %>
            </div>  
            <div class=" mt-4 row text-center">
                <div class="col-12">
                    <span style="font-size:17px"><b> Total Keseluruhan</b> </span><br>
                    <span style="font-size:17px"><b> <%=Replace(FormatCurrency(totalkeseluruhan),"$","Rp.  ")%> </b> </span>
                </div>
            </div>         
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>