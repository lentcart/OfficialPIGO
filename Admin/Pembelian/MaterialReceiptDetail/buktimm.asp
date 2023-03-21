<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    mmID = request.queryString("mmID")
    tanggalmm = request.queryString("mmTanggal")
    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set MaterialReceipt_cmd = server.createObject("ADODB.COMMAND")
	MaterialReceipt_cmd.activeConnection = MM_PIGO_String
			
	MaterialReceipt_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, MKT_T_MaterialReceipt_H.mm_custID,  MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi, MKT_M_Customer.custPhone1, MKT_M_Customer.custFax, MKT_M_Customer.custNpwp, MKT_M_Customer.custNamaCP, MKT_M_Customer.custEmail,  MKT_T_PurchaseOrder_H.poDesc FROM MKT_T_PurchaseOrder_H RIGHT OUTER JOIN MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID WHERE (MKT_T_MaterialReceipt_H.mmID ='"& mmID &"') and MKT_M_Alamat.almJenis <> 'Alamat Toko' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi, MKT_M_Customer.custPhone1, MKT_M_Customer.custFax, MKT_M_Customer.custNpwp, MKT_M_Customer.custNamaCP, MKT_M_Customer.custEmail, MKT_T_PurchaseOrder_H.poDesc"
    'response.write MaterialReceipt_cmd.commandText
	set MaterialReceipt = MaterialReceipt_cmd.execute


    set po_cmd = server.createObject("ADODB.COMMAND")
	po_cmd.activeConnection = MM_PIGO_String

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
            document.title = "BuktiMReceipt-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
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
                <% do while not MaterialReceipt.eof%>
                <div class="row mt-3">
                    <div class="col-8">
                        <div class="row">
                            <div class="col-4">
                                <span class="txt-desc"> Telah Di Terima Dari </span><br>
                                <span class="txt-desc"> CP</span><br>
                                <span class="txt-desc"> Kontak </span>
                            </div>
                            <div class="col-8 p-0">
                            <% if MaterialReceipt("custID") <> "C001-CASH" then %>
                                <span class="txt-desc"> : </span>&nbsp;&nbsp;<span class="txt-desc"> <%=MaterialReceipt("custNama")%>  </span><br>
                            <% else %>
                                <span class="txt-desc"> : </span>&nbsp;&nbsp;<span class="txt-desc"> <%=MaterialReceipt("poDesc")%>  </span><br>
                            <% end if %>
                                <span class="txt-desc"> : </span>&nbsp;&nbsp;<span class="txt-desc"> <%=MaterialReceipt("custNamaCP")%> </span> - <span class="txt-desc"><%=MaterialReceipt("custPhone1")%></span><br>
                                <span class="txt-desc"> : </span>&nbsp;&nbsp;<span class="txt-desc"> Fax </span> - <span class="txt-desc"><%=MaterialReceipt("custFax")%></span><br>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="row">
                            <div class="col-4">
                                <span class="txt-desc"> Tanggal </span><br>
                                <span class="txt-desc"> No PO </span><br>
                            </div>
                            <div class="col-1 p-0">
                                <span class="txt-desc"> : </span><br>
                                <span class="txt-desc"> : </span><br>
                            </div>
                            <div class="col-6 p-0">
                                <span class="txt-desc"><%=Day(CDate(MaterialReceipt("mmTanggal")))%>&nbsp;<%=MonthName(Month(MaterialReceipt("mmTanggal")))%>&nbsp;<%=Year(MaterialReceipt("mmTanggal"))%></span><br>
                                <%
                                    po_cmd.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_MaterialReceipt_D1.mm_poTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 where MKT_T_MaterialReceipt_H.mm_custID = '"& MaterialReceipt("custID") &"' AND (MKT_T_MaterialReceipt_H.mmID ='"& mmID &"') group by MKT_T_MaterialReceipt_D1.mm_poID, MKT_T_MaterialReceipt_D1.mm_poTanggal  "
                                    'response.write po_cmd.commandText
                                    set po = po_cmd.execute
                                %>
                                <% do while not po.eof%>
                                    <span class="txt-desc"><%=po("mm_poID")%></span><br>
                                <% po.movenext
                                loop%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        <span class="txt-desc"> Alamat </span><br>
                    </div>
                    <div class="col-10 p-0">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span class="txt-desc">:</span>&nbsp;&nbsp;<span class="txt-desc"> <%=MaterialReceipt("almLengkap")%> </span><br>
                    </div>
                </div>
                <div class="row text-center mt-3 mb-2">
                    <div class="col-12">
                        <span class="txt-desc" style="font-size:28px"> <u> MATERIAL RECEIPT </u> </span><br>
                        <span class="txt-desc">  <%=MaterialReceipt("mmID")%>/<%=Day(CDate(MaterialReceipt("mmTanggal")))%>/<%=Month(MaterialReceipt("mmTanggal"))%>/<%=Year(MaterialReceipt("mmTanggal"))%></span>  </span><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <table class="table cont-tb cont-text table-bordered table-condensed mt-1" style="font-size:12px">
                            <thead>
                                <tr>
                                    <th class="text-center"> NO </th>
                                    <th class="text-center"> SKU/ PART NUMBER </th>
                                    <th class="text-center"> DETAIL </th>
                                    <th class="text-center"> RAK </th>
                                    <th class="text-center"> SATUAN </th>
                                    <th class="text-center"> QTY </th>
                                </tr>
                                
                            </thead>
                            <tbody>
                            <% 
                                produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdKey, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_PIGO_Produk.pdLokasi,   MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_H.mmID FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID RIGHT OUTER JOIN  MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID where MKT_T_MaterialReceipt_H.mm_custID = '"& MaterialReceipt("custID") &"' AND (MKT_T_MaterialReceipt_H.mmID ='"& MaterialReceipt("mmID")  &"')  "
                                'response.write produk_cmd.commandText
                                set produk = produk_cmd.execute
                            %>
                            <% do while not produk.eof%>
                                <tr>
                                    <td class="text-center"> <%=produk("no")%> </td>
                                    <td> <%=produk("pdPartNumber")%> </td>
                                    <td> <%=produk("pdNama")%> </td>
                                    <td class="text-center"> <%=produk("pdLokasi")%> </td>
                                    <td class="text-center"> <%=produk("pdUnit")%> </td>
                                    <td class="text-center"> <%=produk("mm_pdQtyDiterima")%> </td>
                                    <% totalqty = totalqty+produk("mm_pdQtyDiterima") %>
                                </tr>
                                <%
                                    subtotal = subtotal + totalpo
                                %>
                                <% produk.movenext
                                loop%>
                                <tr>
                                    <th colspan="5" class="text-right"> Total QTY </th>
                                    <td class="text-center"> <%=totalqty%> </td>
                                </tr>
                            
                            </tbody>
                        </table>
                    </div>
                </div>
                <% MaterialReceipt.movenext
                loop %>  
                <div class="row text-center" style="margin-top:2rem">
                    <div class="col-6">
                        <span class="txt-desc"> </span><br>
                        <span class="txt-desc"> Dibuat Oleh,</span><br><br><br><br>
                        <span class="txt-desc"><u>.............................................</u></span><br>
                    </div>
                    <div class="col-6">
                        <span class="txt-desc"> Tanggal,..............................</span><br>
                        <span class="txt-desc"> Mengetahui,</span><br><br><br><br>
                        <span class="txt-desc"><u>.............................................</u></span><br>
                    </div>
                </div>  
            </div>          
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>