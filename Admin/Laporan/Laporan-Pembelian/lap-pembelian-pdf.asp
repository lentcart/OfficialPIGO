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

                    filtercust = filtercust & addOR & " MKT_T_MaterialReceipt_H.mm_custID = '"& x &"' "

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
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID = 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String
			
	BussinesPartner_cmd.commandText = "SELECT  MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almProvinsi FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID WHERE almJenis <> 'Alamat Toko' "& FilterFix &" "& filterTanggal &" GROUP BY  MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almProvinsi "
    'response.write BussinesPartner_cmd.commandText
	set BussinesPartner = BussinesPartner_cmd.execute

    set Purchase_cmd = server.createObject("ADODB.COMMAND")
	Purchase_cmd.activeConnection = MM_PIGO_String
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
        // window.print();
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
                        <span style="font-size:21px"> LAPORAN PEMBELIAN </span><br>
                        <span> PERIODE -  <b> <%=tgla%> s.d. <%=tgle%>  </b> </span>
                    </div>
                    <div class="col-5">
                        <div class="row  align-items-center">
                            <div class="col-2">
                                <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                            </div>
                            <div class="col-10">
                                <span class="Judul-Merchant" style="font-size:22px"> <b><%=Merchant("custNama")%> </b></span><br>
                                <span class="cont-text"> <%=Merchant("almLengkap")%> </span><br>
                                <span class="cont-text"> <%=Merchant("custEmail")%> </span><br>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 mb-2" style="border-bottom:4px solid black">
                
                </div>
                <% 
                    do while not BussinesPartner.eof
                %>
                <div class="row">
                    <div class="col-2">
                        <span class="cont-text"> BUSSINES PARTNER </span><br>
                        <span class="cont-text"> EMAIL </span><br>
                        <span class="cont-text"> KONTAK </span><br>
                        <span class="cont-text"> ALAMAT LENGKAP </span>
                    </div>
                    <div class="col-7">
                        <span class="cont-text">:</span>&nbsp;<span class="cont-text"> <%=BussinesPartner("custNama")%> </span><br>
                        <span class="cont-text">:</span>&nbsp;<span class="cont-text"> <%=BussinesPartner("custEmail")%> </span><br>
                        <span class="cont-text">:</span>&nbsp;<span class="cont-text"> <%=BussinesPartner("custPhone1")%> </span><br>
                        <span class="cont-text">:</span>&nbsp;<span class="cont-text"> <%=BussinesPartner("almLengkap")%> </span><br>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-12">
                        <span class="panel-title mb-1 weight"><b> DETAIL PEMBELIAN </b></span><br>
                        <table class="table tb-transaksi table-bordered table-condensed" style=" border:1px solid black;font-size:12px">
                        <thead>
                            <tr>
                                <th class="text-center"> NO </th>
                                <th class="text-center"> PURCHASEORDER </th>
                                <th class="text-center"> ID PRODUK </th>
                                <th class="text-center"> DETAIL </th>
                                <th class="text-center"> SATUAN </th>
                                <th class="text-center"> HARGA BELI </th>
                                <th class="text-center"> PPN </th>
                                <th class="text-center"> QTY </th>
                                <th class="text-center"> TOTAL </th>
                            </tr>
                        </thead>
                        <tbody> 
                            <%
                                Purchase_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poTanggal, MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdSubtotal,  MKT_T_PurchaseOrder_D.poPajak, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_MaterialReceipt_D2.mm_poID, MKT_M_PIGO_Produk.pdUnit FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID LEFT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_MaterialReceipt_D2.mm_poID = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE (MKT_T_MaterialReceipt_H.mm_custID ='"& BussinesPartner("mm_custID") &"') GROUP BY MKT_T_PurchaseOrder_H.poTanggal, MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdSubtotal,  MKT_T_PurchaseOrder_D.poPajak, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_MaterialReceipt_D2.mm_poID, MKT_M_PIGO_Produk.pdUnit "
                                'response.write Purchase_cmd.commandText
                                set Purchase = Purchase_cmd.execute
                            %>
                            <%
                                If Purchase.eof = true then
                            %>
                                <tr class="text-center">
                                    <td colspan="9"> TIDAK TERDAPAT DATA PEMBELIAN </td>
                                <tr>
                            <% else %>
                            <%
                                no = 0 
                                do while not Purchase.eof
                                no = no + 1
                            %>
                            <tr>
                                <td class="text-center"><%=no%></td>
                                <td class="text-center"><%=Purchase("mm_poID")%>/<b><%=CDate(Purchase("poTanggal"))%></b></td>
                                <td class="text-center"><%=Purchase("mm_pdID")%></td>
                                <td><b>[<%=Purchase("pdPartNumber")%>]</b><%=Purchase("pdNama")%></td>
                                <td class="text-center"><%=Purchase("pdUnit")%></td>
                                <td class="text-center"><%=Replace(Replace(FormatCurrency(Purchase("mm_pdHarga")),"$","Rp. "),".00","")%></td>
                                <%
                                    Pajak = Purchase("mm_pdHarga")*Purchase("poPajak")/100
                                %>
                                <td class="text-center"><%=Replace(Replace(FormatCurrency(Pajak),"$","Rp. "),".00","")%></td>
                                <td class="text-center"><%=Purchase("mm_pdQtyDiterima")%></td>
                                <td class="text-center"><%=Replace(Replace(FormatCurrency(Purchase("mm_pdSubtotal")),"$","Rp. "),".00","")%></td>
                            </tr>
                            <%
                                total = total + Purchase("mm_pdSubtotal")
                            %>
                            <%
                                Purchase.movenext
                                loop
                            %>
                            <% end if %>
                        </tbody>
                        <thead>
                            <tr>
                                <th class="text-center" colspan="8"> TOTAL </th>
                                <th class="text-center"> <%=Replace(Replace(FormatCurrency(total),"$","Rp. "),".00","")%> </th>
                            </tr>
                            <%
                                GRANDTOTAL = GRANDTOTAL + TOTAL
                                total = 0
                            %>
                        </thead>
                    </table>
                    </div>
                </div>
                <%
                    SUBTOTAL = SUBTOTAL + GRANDTOTAL
                    GRANDTOTAL = 0
                %>
                <%
                    BussinesPartner.movenext
                    loop
                %>
                <hr>
                <div class="row mt-2">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed text-center" style=" border:1px solid black;font-size:14px">
                            <tr>
                                <th> TOTAL KESELURUHAN </th>
                            </tr>
                            
                            <tr>
                                <td> <%=Replace(Replace(FormatCurrency(SUBTOTAL),"$","Rp. "),".00","")%> </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>    
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>