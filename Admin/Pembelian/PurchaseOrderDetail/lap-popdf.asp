 <!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
        response.redirect("../../../admin/")
    end if

    tgla    = Cdate(request.queryString("tgla"))
    tgle    = Cdate(request.queryString("tgle"))
    bulan   = month(request.queryString("tgla"))
    tahun   = year(request.queryString("tgla"))

    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))

    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and poTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'   "
	set Merchant = Merchant_cmd.execute

	set supplier_cmd = server.createObject("ADODB.COMMAND")
	supplier_cmd.activeConnection = MM_PIGO_String
			
	supplier_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi  FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H Where poTanggal between '"& tgla &"' and '"& tgle &"' AND almJenis <> 'Alamat Toko' GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi  "
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

        <title> OFFICIAL PIGO </title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

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
                    <div class="col-5">
                        <span style="font-size:25px; color:#0077a2; font-weight:bold"> LAPORAN PURCHASE ORDER </span><br>
                        <span><b> PERIODE LAPORAN : <%=Day(CDate(tgla))%>/<%=Month(CDate(tgla))%>/<%=Year(CDate(tgla))%> &nbsp; S.D &nbsp; <%=Day(CDate(tgle))%>/<%=Month(CDate(tgle))%>/<%=Year(CDate(tgle))%> </b></span>
                    </div>
                    <div class="col-7">
                        <div class="row">
                            <div class="col-12 text-end">
                            <!--#include file="../../HeaderPIGOF4.asp"-->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3 mb-3" style="border-bottom:4px solid #0077a2">
                </div>

                <% 
                    no = 0 
                    do while not supplier.eof
                    no = no + 1
                %>
                    <div class="row">
                        <div class="col-2">
                            <span> Bussines Partner </span>
                        </div>
                        <div class="col-10 p-0">
                            <span> :  </span>&nbsp;<span> <%=supplier("custNama")%> </span><br>
                            &nbsp;&nbsp;<span> <%=supplier("almLengkap")%> - <%=supplier("almProvinsi")%> </span><br>
                            &nbsp;&nbsp;<span> <%=supplier("custNamaCP")%> - <%=supplier("custPhone1")%> </span><br>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-2">
                            <span> Payment Term </span>
                        </div>
                        <div class="col-6 p-0">
                            <span> :  </span>&nbsp;<span> n/<%=supplier("custPaymentTerm")%> </span><br>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:11px; border:1px solid black">
                                <thead>
                                    <tr class="text-center">
                                        <th> NO </th>
                                        <th> PURCHASE ORDER ID </th>
                                        <th> JENIS ORDER </th>
                                        <th> GRAND TOTAL </th>
                                        <th> STATUS </th>
                                        <th> TANGGAL ORDER </th>
                                        <th> TANGGAL PERKIRAAN </th>
                                        <th> TANGGAL PENERIMAAN </th>
                                        <th> NO INVOICE / FAKTUR </th>
                                        <th> TANGGAL FAKTUR </th>
                                        <th> JATUH TEMPO </th>
                                    </tr>
                                </thead>
                                <tbody class="datatr">
                                <%
                                    produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY poID) AS no, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_StatusPurchaseOrder.spoName, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poTglDiterima FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_StatusPurchaseOrder ON MKT_T_PurchaseOrder_D.po_spoID = MKT_M_StatusPurchaseOrder.spoID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID where MKT_T_PurchaseOrder_H.po_custID = '"& supplier("custID") &"' AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"' and MKT_T_PurchaseOrder_H.poAktifYN = 'Y' GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_StatusPurchaseOrder.spoName, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poTglDiterima "
                                    'response.write produk_cmd.commandText
                                    set produk = produk_cmd.execute
                                %>
                                <% 
                                    do while not produk.eof 
                                %>
                                    <tr>
                                        <td class="text-center"> <%=produk("no")%> </td>
                                        <td class="text-center"> <%=produk("poID")%> </td>
                                        <% if produk("poJenisOrder") = "1" then %>
                                        <td class="text-center"> Slow Moving </td>
                                        <% else %>
                                        <td class="text-center"> Fast Moving </td>
                                        <% end if %>

                                        <%
                                            produk_cmd.commandText = "SELECT sum(MKT_T_PurchaseOrder_D.poTotal)as grandtotal FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_StatusPurchaseOrder ON MKT_T_PurchaseOrder_D.po_spoID = MKT_M_StatusPurchaseOrder.spoID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID Where poID = '"& produk("poID") &"' AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"'  "
                                            'response.write produk_cmd.commandText
                                            set Gtotal = produk_cmd.execute
                                        %>

                                        <td class="text-end">
                                            <%=Replace(Replace(Replace(FormatCurrency(Gtotal("grandtotal")),"$","Rp.  "),".00",""),",",".")%>
                                        </td>
                                        <td class="text-center"> <%=produk("spoName")%> </td>
                                        <td class="text-center"> <%=day(CDate(produk("poTanggal")))%>/<%=Month(produk("poTanggal"))%>/<%=year(produk("poTanggal"))%> </td>
                                        <td class="text-center"> 
                                            <%=day(CDate(produk("poTglDiterima")))%>/<%=Month(produk("poTglDiterima"))%>/<%=year(produk("poTglDiterima"))%>
                                        </td>

                                        <%
                                            produk_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D2.mm_poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID  WHERE (MKT_T_PurchaseOrder_H.poID = '"& produk("poID") &"') AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"' GROUP BY MKT_T_MaterialReceipt_H.mmTanggal "
                                            'response.write produk_cmd.commandText
                                            set Penerimaan = produk_cmd.execute
                                        %>

                                        <% if Penerimaan.eof = true then %>
                                        <td class="text-center"> Pending </td>
                                        <% else %>
                                        <td class="text-center"> 
                                            <%=day(CDate(Penerimaan("mmTanggal")))%>/<%=Month(Penerimaan("mmTanggal"))%>/<%=year(Penerimaan("mmTanggal"))%>
                                        </td>
                                        <% end if %>

                                        <%
                                            produk_cmd.commandText = "SELECT MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Tanggal FROM MKT_T_TukarFaktur_D1 LEFT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_TukarFaktur_D1.TFD1_poID = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_TukarFaktur_D ON LEFT(MKT_T_TukarFaktur_D1.TFD1_ID, 20) = MKT_T_TukarFaktur_D.TFD_ID RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON LEFT(MKT_T_TukarFaktur_D.TFD_ID, 16) = MKT_T_TukarFaktur_H.TF_ID RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_TukarFaktur_H.TF_ID = MKT_T_InvoiceVendor_D.InvAP_Line RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID WHERE (MKT_T_PurchaseOrder_H.poID = '"& produk("poID") &"') AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"'  Group by MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Tanggal"
                                            'response.write produk_cmd.commandText
                                            set invoice = produk_cmd.execute
                                        %>

                                        <% if invoice.eof = true then %>
                                        <td class="text-center"style="color:red" > Pending </td>
                                        <td class="text-center" style="color:red"> - </td>
                                        <% else %>
                                        <td class="text-center"> <%=invoice("InvAPID")%> </td>
                                        <td class="text-center"> 
                                            <%=day(CDate(invoice("InvAP_Tanggal")))%>/<%=Month(invoice("InvAP_Tanggal"))%>/<%=year(invoice("InvAP_Tanggal"))%>
                                        </td>
                                        <% end if %>

                                        <%
                                            produk_cmd.commandText = "SELECT po_payYN,po_JatuhTempo FROM MKT_T_PurchaseOrder_H WHERE (MKT_T_PurchaseOrder_H.poID = '"& produk("poID") &"') AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' and '"& tgle &"' AND MKT_T_PurchaseOrder_H.po_custID = '"& supplier("custID") &"' "
                                            'response.write produk_cmd.commandText
                                            set PayYN = produk_cmd.execute
                                        %>

                                        <% if PayYN("po_payYN") = "Y" then %>
                                            <td class="text-center "style="color:green">LUNAS</td>
                                        <% else %>
                                            <% if PayYN("po_JatuhTempo") = "1900-01-01" then %>
                                                <td class="text-center "style="color:red">Pending</td>
                                            <%else%>
                                                <td class="text-center"> <%=CDate(PayYN("po_JatuhTempo"))%></td>
                                                <% 
                                                    sekarang = date()
                                                    sisahari = CDate(PayYN("po_JatuhTempo")) - sekarang
                                                %>
                                            <% end if %>
                                        <% end if %>
                                    </tr>
                                    <%
                                        grandtotal = grandtotal + Gtotal("grandtotal")
                                        
                                    %>
                                <% 
                                    produk.movenext
                                    loop 
                                %>
                                <%
                                    grandtotalqty = grandtotalqty + totalqty
                                    totalqty = 0
                                    grantotalharga = grandtotalharga + totalharga
                                    totalharga = 0
                                    grandsubtotal = grandsubtotal + grandtotal
                                    grandtotal = 0
                                %>
                                <tr>
                                    <th class="text-end" colspan="10"> SUBTOTAL </th>

                                    <th class="text-end"> <%=Replace(Replace(Replace(FormatCurrency(grandsubtotal),"$","Rp.  "),".00",""),",",".")%> </th>
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
                <% 
                    supplier.movenext
                    loop 
                %>
            </div>  
            <div class=" mt-4 row text-end">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:13px">
                        <tr>
                            <th> <b> TOTAL KESELURUHAN </b> </th>
                        </tr>
                        <tr>
                        <td>  <b><%=Replace(Replace(Replace(FormatCurrency(totalkeseluruhan),"$","Rp.  "),".00",""),",",".")%></b> </td>
                        </tr>
                    </table>
                </div>
            </div>  
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>