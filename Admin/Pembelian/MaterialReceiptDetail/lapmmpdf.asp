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
        filterTanggal = " mmTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

	set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String
			
	BussinesPartner_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almLengkap, MKT_M_Customer.custPhone1,  MKT_M_Customer.custNamaCP FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_M_Alamat.almJenis <> 'Alamat Toko' GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi,MKT_M_Alamat.almLengkap, MKT_M_Customer.custPhone1,  MKT_M_Customer.custNamaCP "
    'response.write BussinesPartner_cmd.commandText
	set BussinesPartner = BussinesPartner_cmd.execute

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!--#include file="../../IconPIGO.asp"-->

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
        document.title = "Laporan-MaterialReceipt-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
    </script>
    <style>
        body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: white;
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
                        <span style="font-size:25px; color:#0077a2; font-weight:bold"> LAPORAN MATERIAL RECEIPT </span><br>
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

                <% do while not BussinesPartner.eof%>
                <div class="row">
                    <div class="col-2">
                        <span> Bussines Partner </span>
                    </div>
                    <div class="col-10 p-0">
                        <span> : </span> &nbsp; <span> <%=BussinesPartner("custNama")%> </span><br>
                        <span> : </span> &nbsp; <span> <%=BussinesPartner("almLengkap")%> - <%=BussinesPartner("almProvinsi")%> </span><br>
                        <span> : </span> &nbsp; <span> <%=BussinesPartner("custNamaCP")%> - <%=BussinesPartner("custPhone1")%> </span><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        <span> Payment Term </span>
                    </div>
                    <div class="col-10 p-0">
                        <span> : </span> &nbsp; <span> n/<%=BussinesPartner("custPaymentTerm")%> </span><br>
                    </div>
                </div>
                
                
                <div class="row mt-1">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                            <thead>
                                <tr class="text-center">
                                    <th> NO </th>
                                    <th> DETAIL PRODUK </th>
                                    <th> UNIT </th>
                                    <th> HARGA </th>
                                    <th> QTY </th>
                                    <th> SUBTOTAL </th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                            <%
                                produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE MKT_T_MaterialReceipt_H.mm_custID = '"& BussinesPartner("custID") &"' GROUP BY MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga,  MKT_T_MaterialReceipt_D2.mm_pdSubtotal, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber "
                                'response.write produk_cmd.commandText
                                set produk = produk_cmd.execute

                            %>
                            <% do while not produk.eof %>
                                <tr>
                                    <td class="text-center"> <%=produk("no")%> </td>
                                    <td> [<%=produk("pdPartNumber")%> ] - <%=produk("pdNama")%> </td>
                                    <td class="text-center"> <%=produk("pdUnit")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(produk("mm_pdHarga")),"$","Rp.  "),".00","")%> </td>
                                    <td class="text-center"> <%=produk("mm_pdQtyDiterima")%> </td>
                                    <%
                                        subtotal = produk("mm_pdHarga") * produk("mm_pdQtyDiterima")
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(subtotal),"$","Rp.  "),".00","")%> </td>
                                </tr>
                                <%
                                    totalqty = totalqty + produk("mm_pdQty") 
                                    grandtotal = grandtotal + subtotal 
                                %>

                                
                            <% produk.movenext
                            loop  %>
                                <%
                                    grandsubtotal = grandsubtotal + grandtotal
                                    grandtotal = 0
                                    grandtotalqty = grandtotalqty + totalqty
                                    totalqty = 0
                                %>
                                <tr>
                                    <th class="text-center"colspan="5"> TOTAL </th>
                                    <th class="text-end"> <%=Replace(Replace(FormatCurrency(grandsubtotal),"$","Rp.  "),".00","")%> </th>
                                </tr>
                                <%
                                    totalsubtotal = totalsubtotal + grandsubtotal
                                    grandsubtotal =0
                                    totalkeseluruhan = totalkeseluruhan + grandtotalqty
                                    grandtotalqty = 0
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <% BussinesPartner.movenext
                loop %>
            </div>    
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>