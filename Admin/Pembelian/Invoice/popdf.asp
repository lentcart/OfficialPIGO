<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    poID = request.queryString("poID")
    tanggalpo = request.queryString("tanggalpo")
    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= '"& request.Cookies("custID") &"'  "
	set Merchant = Merchant_cmd.execute

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String
			
	PurchaseOrder_cmd.commandText = "SELECT MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spPhone2, MKT_M_Supplier.spFax, MKT_M_Supplier.spEmail, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spAlamat, MKT_T_PurchaseOrder_H.poID,MKT_T_PurchaseOrder_H.poTanggal, MKT_M_Customer.custNama, MKT_M_Alamat.almLengkap, MKT_T_PurchaseOrder_D.poPajak FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_M_Customer LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID ON MKT_M_Supplier.spID = MKT_T_PurchaseOrder_H.po_spID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE (MKT_T_PurchaseOrder_H.poID ='"& poID &"') AND (MKT_T_PurchaseOrder_H.poTanggal ='"& Tanggalpo &"') GROUP BY MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spPhone2, MKT_M_Supplier.spFax, MKT_M_Supplier.spEmail, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spAlamat, MKT_T_PurchaseOrder_H.poTanggal,MKT_M_Customer.custNama, MKT_M_Alamat.almLengkap, MKT_T_PurchaseOrder_D.poPajak,MKT_T_PurchaseOrder_H.poID " 
    'response.write PurchaseOrder_cmd.commandText
	set PurchaseOrder = PurchaseOrder_cmd.execute


    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

%>

<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="invoice.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    
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
        background-color: #FAFAFA;
        font: 12pt "Tahoma";
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
    <div class="container invoice">
        <div class="invoice-header">
        <% do while not Merchant.eof%>
            <div class="row">
                <div class="col-4">
                    <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                </div>
                <div class="col-6">
                    <span class="Judul-Merchant"> <%=Merchant("custNama")%> </span><br>
                    <span class="Txt-Merchant"> <%=Merchant("custPhone1")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone2")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone3")%> </span><br>
                    <span class="Txt-Merchant"> <%=Merchant("almLengkap")%> </span><br>
                </div>
            </div>
            <% Merchant.movenext
            loop%>
            <hr>
            <div class="invoice-body" style="background-color:#eeeeee;  border-radius:20px;">
            <% do while not PurchaseOrder.eof%>
            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <div class="col-3">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> Kepada</span><br>
                                    <span class="txt-desc"> Alamat </span><br>
                                    <span class="txt-desc"> CP</span><br>
                                    <span class="txt-desc"> Kontak </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-7 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"><%=PurchaseOrder("spNama1")%></span><br>
                                    <span class="txt-desc"><%=PurchaseOrder("spAlamat")%></span><br>
                                    <span class="txt-desc"><%=PurchaseOrder("spnamaCP")%></span><br>
                                    <span class="txt-desc"> Telepon</span> - <span class="txt-desc"><%=PurchaseOrder("spPhone1")%></span><br>
                                    <span class="txt-desc"> Fax</span> - <span class="txt-desc"><%=PurchaseOrder("spFax")%></span><br>
                                    <span class="txt-desc"> Email</span> - <span class="txt-desc"><%=PurchaseOrder("spEmail")%></span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> Tanggal PO </span><br>
                                    <span class="txt-desc"> T.O.P </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> <%=Cdate(Purchaseorder("poTanggal"))%> </span><br>
                                    <span class="txt-desc"> n/<%=Purchaseorder("spPaymentTerm")%> </span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-2">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> Send To</span><br>
                                    <span class="txt-desc"> Alamat </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-7 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"><%=PurchaseOrder("custNama")%></span><br>
                                    <span class="txt-desc"><%=PurchaseOrder("almLengkap")%></span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-12">
                    <span class="txt-desc" style="font-size:20px">  PURCHASE ORDER  </span><br>
                    <span class="txt-desc">  <%=PurchaseOrder("poID")%>  </span><br>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        </div>
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                        <thead>
                            <tr>
                                <th class="text-center"> No </th>
                                <th class="text-center"> SKU/Part Number </th>
                                <th class="text-center"> Nama Produk </th>
                                <th class="text-center"> Jumlah QTY </th>
                                <th class="text-center"> Harga Satuan </th>
                                <th class="text-center"> Total </th>
                            </tr>
                            
                        </thead>
                        <tbody>
                        <%
                            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS nourut, MKT_M_PIGO_Produk.pdNama, MKT_T_PurchaseOrder_D.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poHargaSatuan FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN   MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN  MKT_T_PurchaseOrder_H LEFT OUTER JOIN  MKT_M_Supplier ON MKT_T_PurchaseOrder_H.po_spID = MKT_M_Supplier.spID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID  where MKT_T_PurchaseOrder_H.po_spID = '"& PurchaseOrder("spID") &"' AND (MKT_T_PurchaseOrder_H.poTanggal ='"& PurchaseOrder("poTanggal")  &"') AND (MKT_T_PurchaseOrder_H.poID ='"& PurchaseOrder("poID")  &"')  "
                            'response.write produk_cmd.commandText
	                        set produk = produk_cmd.execute
                        %>
                        <% do while not produk.eof%>
                            <tr>
                                <td class="text-center"> <%=produk("nourut")%> </td>
                                <td> <%=produk("pdPartNumber")%> </td>
                                <td> <%=produk("pdNama")%> </td>
                                <td class="text-center"> <%=produk("poQtyProduk")%> </td>
                                <td class="text-center"> <%=produk("poHargaSatuan")%> </td>
                                <% totalpo = produk("poQtyProduk") * produk("poHargaSatuan") %>
                                <td class="text-center"> <%=totalpo%> </td>
                            </tr>
                            <%
                                subtotal = subtotal + totalpo
                            %>
                            <% produk.movenext
                            loop%>
                            <tr>
                                <th colspan="5" class="text-right"> Total </th>
                                <td class="text-center"> <%=subtotal%> </td>
                            </tr>
                            <%
                                tax = PurchaseOrder("poPajak")/100*subtotal
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
            </div>
            <% PurchaseOrder.movenext
            loop %>  
            <div class="row text-center" style="margin-top:2rem">
                <div class="col-12">
                    <span class="txt-desc"> Tanggal, <%=Cdate(date())%> </span><br>
                    <span class="txt-desc"> Hormat Kami,</span><br>
                    <span class="txt-desc"> PT. Perkasa Indah Gemilang Oetama</span><br><br><br><br>
                    <span class="txt-desc"> F.Deni Arijanto </span><br>


                </div>
            </div>          
        </div>
    </div>
</body>

    <script>

        
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>