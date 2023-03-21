<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    ' id = request.queryString("custID")
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))
    'response.write tahun &"<BR>"


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    'response.write tgla &"<BR>"
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))

    id = Split(request.queryString("custID"),",")

    for each x in id
            if len(x) > 0 then

                    filtercust = filtercust & addOR & " MKT_T_Transaksi_H.tr_custID = '"& x &"' "

                    addOR = " or " 
                    
            end if
        next

        if filtercust <> "" then
            FilterFix = "and  ( " & filtercust & " )" 
        end if

        ' response.write FilterFix


    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and mmTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= '"& request.Cookies("custID") &"'  "
	set Merchant = Merchant_cmd.execute

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String
			
	Seller_cmd.commandText = "SELECT MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Customer.custNama,MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where MKT_M_Seller.sl_custID = '"& request.Cookies("custID") &"' "
	set Seller = Seller_cmd.execute


    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String
			
	Supplier_cmd.commandText =" SELECT MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spStatusKr, MKT_M_Supplier.spStatusTax, MKT_M_Supplier.spPartnerG, MKT_M_Supplier.spNpwp, MKT_M_Supplier.spPembayaran,  MKT_M_Supplier.spTransaksi, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spDiscount, MKT_M_Supplier.spVendor, MKT_M_Supplier.spManufacture, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spProv,  MKT_M_Supplier.spKab, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spPhone2, MKT_M_Supplier.spFax, MKT_M_Supplier.spEmail, MKT_M_Supplier.spWilayah, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spPhoneCP,  MKT_M_Supplier.spEmailCP, MKT_M_Supplier.spJabatanCP, MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_H.mm_custID = '"& request.Cookies("custID") &"' "& FilterFix & filterTanggal &" GROUP BY MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spStatusKr, MKT_M_Supplier.spStatusTax, MKT_M_Supplier.spPartnerG, MKT_M_Supplier.spNpwp, MKT_M_Supplier.spPembayaran,  MKT_M_Supplier.spTransaksi, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spDiscount, MKT_M_Supplier.spVendor, MKT_M_Supplier.spManufacture, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spProv,  MKT_M_Supplier.spKab, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spPhone2, MKT_M_Supplier.spFax, MKT_M_Supplier.spEmail, MKT_M_Supplier.spWilayah, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spPhoneCP,  MKT_M_Supplier.spEmailCP, MKT_M_Supplier.spJabatanCP, MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal"
    'response.write Supplier_cmd.commandText
	set Supplier = Supplier_cmd.execute

    set PO_cmd = server.createObject("ADODB.COMMAND")
	PO_cmd.activeConnection = MM_PIGO_String

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
        document.title = "Laporan-Pembelian-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-<%=request.Cookies("custEmail")%>";
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
                        <span> Laporan Pembelian Produk <b>[ <%=request.Cookies("custNama")%> ]</b> </span><br>
                        <span> Periode Tanggal <b> [ <%=tgla%> s.d. <%=tgle%> ]  </b> </span>
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

                <%if Supplier.eof = true then %>

                    <div class="row text-center mt-4 mb-4">
                        <div class="col-12">
                            <span style="font-size:20px"><b> DATA PENJUALAN TIDAK DITEMUKAN !</b></span>
                        </div>
                    </div>

                <%else%>

                <%do while not Supplier.eof%>
                <div class="row">
                <div class="col-2">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <span class="txt-desc"> Nama Supplier </span><br>
                            <span class="txt-desc"> Email </span><br>
                            <span class="txt-desc"> Kontak </span><br>
                            <span class="txt-desc"> Alamat Lengkap </span>
                        </div>
                    </div>
                </div>
                <div class="col-7 p-0">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <span class="txt-desc"><%=Supplier("spNama1")%> [<%=Supplier("spPaymentTerm")%>]</span><br>
                            <span class="txt-desc"><%=Supplier("spEmail")%></span><br>
                            <span class="txt-desc"><%=Supplier("spPhone1")%> | <%=Supplier("spPhone2")%> - [<%=Supplier("spNamaCP")%>]</span><br>
                            <span class="txt-desc"><%=Supplier("spAlamat")%></span><br>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
            <span class="panel-title mb-1 weight">No PurchaseOrder </span><br>
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed" style=" border:1px solid black;font-size:12px">
                    <thead>
                        <tr>
                            <th class="text-center"> Tanggal Transaksi </th>
                            <th class="text-center"> Purchase Order </th>
                            <th class="text-center"> Nama Produk </th>
                            <th class="text-center"> Type Produk </th>
                            <th class="text-center"> Harga </th>
                            <th class="text-center"> Jumlah </th>
                            <th class="text-center"> Total </th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        produk_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,    MKT_M_PIGO_Produk.pdImage, MKT_T_PurchaseOrder_D.po_pdID, MKT_M_PIGO_Produk.pdUnit,  MKT_M_PIGO_Produk.pdPartNumber,  MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_M_PIGO_Produk.pdTypeProduk FROM MKT_M_StatusPurchaseOrder RIGHT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_T_PurchaseOrder_D.po_pdID ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID ON  MKT_M_StatusPurchaseOrder.spoID = MKT_T_PurchaseOrder_D.po_spoID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H RIGHT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID AND MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE MKT_T_MaterialReceipt_H.mmID  = '"& Supplier("mmID")&"'GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_M_StatusPurchaseOrder.spoID, MKT_M_StatusPurchaseOrder.spoName, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdImage,  MKT_M_PIGO_Produk.pdNama, MKT_T_PurchaseOrder_D.po_pdID, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_M_PIGO_Produk.pdTypeProduk "
                        'response.write produk_cmd.commandText
                        set produk = produk_CMD.execute
                    %>

                    <%do while not produk.eof%>
                        <tr>
                            <td class="text-center"><%=Cdate(Supplier("mmTanggal"))%>-<%=Supplier("mmID")%></td>
                            <td class="text-center"><b><%=produk("poID")%></b> - <%=CDate(produk("poTanggal"))%></td>
                            <td><b>[ <%=produk("pdPartNumber")%> ]</b> - <%=produk("pdNama")%></td>
                            <td><%=produk("pdTypeProduk")%> </td>
                            <td class="text-center"><%=Replace(FormatCurrency(produk("mm_pdHarga")),"$","Rp. ")%></td>
                            <td class="text-center"><%=produk("mm_pdQtyDiterima")%></td>
                            <% total =  produk("mm_pdHarga") * produk("mm_pdQtyDiterima")%>
                            <td class="text-center"><%=Replace(FormatCurrency(total),"$","Rp.  ")%></td>
                            <%subtotal = subtotal + total %>
                        </tr>
                       
                        <% 
                        produk.movenext
                        loop%>
                         <tr>
                            <td class="text-center"colspan="6"><b>Sub Total</b></td>
                            <td class="text-center"><%=Replace(FormatCurrency(subtotal),"$","Rp.  ")%></td>
                         <%
                         grandTotal =  grandTotal + subtotal
                        subtotal = 0

                        'response.write grandTotal
                        %>   
                        </tr>
                    </tbody>
                </table>
                </div>
            </div>

        <%
        response.flush
        Supplier.movenext
        loop%>
        
        <%end if%>
        <div class="panel panel-default">
            <div class="row">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1 text-center" style=" border:1px solid black;font-size:14px">
                        <tr>
                            <th colspan="8"> Total Keseluruhan </th>
                        </tr>
                        <tr>
                            <td> <%=Replace(FormatCurrency(grandTotal),"$","Rp.  ")%> </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
            </div>    
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>