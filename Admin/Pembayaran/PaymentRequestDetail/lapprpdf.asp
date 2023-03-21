<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))



    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and prTanggalInv between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= '"& request.Cookies("custID") &"'  "
	set Merchant = Merchant_cmd.execute

	set supplier_cmd = server.createObject("ADODB.COMMAND")
	supplier_cmd.activeConnection = MM_PIGO_String
			
	supplier_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.po_spID, MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat,  MKT_M_Supplier.spProv, MKT_M_Supplier.spPhone1 FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Supplier.spID = MKT_T_PurchaseOrder_H.po_spID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE MKT_T_PurchaseOrder_H.po_custID = '"& request.Cookies("custID") &"' " & filterTanggal & "  GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.po_spID, MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPaymentTerm,  MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spAlamat,  MKT_M_Supplier.spProv, MKT_M_Supplier.spPhone1"
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
        document.title = "Laporan-PurchaseOrder-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
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
                <div class="row">
                    <div class="col-7">
                        <span> Laporan Purchase Order </span><br>
                        <span> Periode - <b> <%=tgla%> s.d. <%=tgle%> </b></span>
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
                <% do while not supplier.eof%>
                <div class="row">
                    <div class="col-2">
                        <span> Bussines Partner </span>
                    </div>: 
                    <div class="col-6 p-0">
                        <span> <%=supplier("spNama1")%> </span><br>
                        <span> <%=supplier("spAlamat")%> - <%=supplier("spProv")%> </span><br>
                        <span> <%=supplier("spNamaCP")%> - <%=supplier("spPhone1")%> </span><br>
                        <span>  </span><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        <span> Payment Term </span>
                    </div>: 
                    <div class="col-6 p-0">
                        <span> n/<%=supplier("spPaymentTerm")%> </span><br>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                            <thead>
                                <tr class="text-center">
                                    <th> No </th>
                                    <th> Tanggal </th>
                                    <th> No Purchase Order </th>
                                    <th> Jenis PO </th>
                                    <th> Jenis Order </th>
                                    <th colspan="2"> Nama Produk </th>
                                    <th> Unit </th>
                                    <th> QTY </th>
                                    <th> Harga </th>
                                    <th> Sub Total </th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                            <%
                                produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenis, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.po_spID, MKT_T_PurchaseOrder_D.po_pdID, MKT_T_PurchaseOrder_D.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk,  MKT_T_PurchaseOrder_D.poPdUnit, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_D.poDiskon, MKT_T_PurchaseOrder_D.poSubTotal, MKT_M_PIGO_Produk.pdID,  MKT_M_PIGO_Produk.pdNama FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID where MKT_T_PurchaseOrder_H.poID = '"& supplier("poID") &"' AND MKT_T_PurchaseOrder_H.po_spID = '"& supplier("po_spID") &"'"
                                'response.write produk_cmd.commandText
                                set produk = produk_cmd.execute

                            %>
                            <% do while not produk.eof %>
                                <tr>
                                    <td class="text-center"> <%=produk("no")%> </td>
                                    <td class="text-center"> <%=produk("poTanggal")%> </td>
                                    <td class="text-center"> <%=produk("poID")%> </td>
                                    <td class="text-center"> <%=produk("poJenis")%> </td>
                                    <td class="text-center"> <%=produk("poJenisOrder")%> </td>
                                    <td> <%=produk("pdPartNumber")%> </td>
                                    <td> <%=produk("pdNama")%> </td>
                                    <td class="text-center"> <%=produk("poPdUnit")%> </td>
                                    <td class="text-center"> <%=produk("poQtyProduk")%> </td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(produk("poHargaSatuan")),"$","Rp.  ")%> </td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(produk("poSubTotal")),"$","Rp.  ")%> </td>
                                </tr>
                                <%
                                    totalqty = totalqty + produk("poQtyProduk") 
                                    subtotal = subtotal + produk("poSubTotal") 
                                %>

                                
                            <% produk.movenext
                            loop  %>
                                <%
                                    grandtotalqty = grandtotalqty + totalqty
                                    totalqty = 0
                                %>
                                <tr>
                                    <th class="text-center"colspan="8"> Total </th>
                                    <th class="text-center"colspan="2"> <%=grandtotalqty%> Produk</th>
                                    <th class="text-center"> <%=Replace(FormatCurrency(subtotal),"$","Rp.  ")%> </th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <% supplier.movenext
                loop %>
            </div>    
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>