<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    jenisorder = request.queryString("jenispo")
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
    Merchant_cmd.activeConnection = MM_PIGO_String
    Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText ="SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.po_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail,  MKT_M_Customer.custPhone1, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almLengkap FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE MKT_T_PurchaseOrder_H.poJenisOrder = '"& jenisorder &"' AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' AND '"& tgle &"' AND almJenis = 'Alamat Pribadi' OR almJenis = 'Alamat BS' GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.po_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail,  MKT_M_Customer.custPhone1, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almLengkap ORDER BY  MKT_T_PurchaseOrder_H.poTanggal ASC" 
        'rebponse.write PurchaseOrder_cmd.commandText

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
        // window.print();
        document.title = "ListJenisOrderPO-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFFICIAL PIGO";
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
    <!--<div class="container">
    <div class="row">
        <div class="col-12">
            <a href="index.asp"> Kembali </a>
        </div>
    </div>
    </div>-->
    <div class="book">
        <div class="page">
            <div class="subpage">
                <% do while not Merchant.eof%>
                <div class="row align-items-center">
                    <div class="col-1 me-4">
                        <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                    </div>
                    <div class="col-7">
                        <span class="Judul-Merchant"> <%=Merchant("custNama")%> </span><br>
                        <span class="Txt-Merchant"> <%=Merchant("custPhone1")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone2")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone3")%> </span><br>
                        <span class="Txt-Merchant"> <%=Merchant("almLengkap")%> </span><br>
                    </div>
                </div>
                <div class="row mt-2" style="border-bottom:4px solid #aaaaaa">

                </div>
                <% Merchant.movenext
                loop%>

                <div class="row mt-3 mb-3">
                    <div class="col-8">
                        <span class="Judul-Merchant"> Periode Pembelian Produk : <b><%=CDate(tgla)%></b> s.d <b><%=CDate(tgle)%></b> </span><br>
                    </div>
                    <div class="col-4">
                        <span class="Judul-Merchant"> Jenis Order : <b><%=jenisorder%></b> </span><br>
                    </div>
                </div>
                <% if PurchaseOrder.eof = true then %>
                <div class="row text-center mt-3 mb-3">
                    <div class="col-12">
                        <span class="Judul-Merchant"> <b> DATA TIDAK DITEMUKAN </b> </span><br>
                    </div>
                </div>
                <% else %>
                <% do while not PurchaseOrder.eof%>
                <div class="row">
                    <div class="col-3">
                        <span> No PurchaseOrder </span><br>
                        <span> BussinesPartner </span><br>
                    </div>
                    <div class="col-1">
                        <span> : </span><br>
                        <span> : </span><br>
                    </div>
                    <div class="col-7">
                        <span> <%=PurchaseOrder("poID")%> - [ <%=CDate(PurchaseOrder("poTanggal"))%> ]</span><br>
                        <span> <%=PurchaseOrder("custNama")%> </span><br>
                        <span> <%=PurchaseOrder("almLengkap")%> </span><br>
                    </div>
                </div>
                <div class="row mt-3 mb-3">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                            <thead>
                                <tr class="text-center">
                                    <th> NO </th>
                                    <th> NAMA PRODUK </th>
                                    <th> UNIT </th>
                                    <th> HARGA </th>
                                    <th> QTY </th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                            <%
                            set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
                                PurchaseOrder_cmd.activeConnection = MM_PIGO_String

                                    PurchaseOrder_cmd.commandText ="SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poHargaSatuan,  MKT_T_PurchaseOrder_D.poPajak FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID WHERE MKT_T_PurchaseOrder_H.poJenisOrder = '"& jenisorder &"' AND MKT_T_PurchaseOrder_H.poTanggal between '"& tgla &"' AND '"& tgle &"'AND MKT_T_PurchaseOrder_H.poID = '"& PurchaseOrder("poID") &"' AND MKT_T_PurchaseOrder_H.po_custID = '"& PurchaseOrder("po_custID") &"' GROUP BY MKT_T_PurchaseOrder_H.poTanggal,MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poHargaSatuan,  MKT_T_PurchaseOrder_D.poPajak ORDER BY MKT_T_PurchaseOrder_H.poTanggal ASC" 
                                    'response.write PurchaseOrder_cmd.commandText

                                set ProdukPO = PurchaseOrder_cmd.execute
                            %>
                            <% do while not ProdukPO.eof %>
                                <tr>
                                    <td class="text-center"> <%=ProdukPO("no")%> </td>
                                    <td> [<%=ProdukPO("pdPartNumber")%>] - <%=ProdukPO("pdNama")%> </td>
                                    <td class="text-center"> <%=ProdukPO("pdUnit")%> </td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(ProdukPO("poHargaSatuan")),"$","Rp. ")%> </td>
                                    <td class="text-center"> <%=ProdukPO("poQtyProduk")%> </td>
                                    <% total = total + ProdukPO("poQtyProduk") %>
                                </tr>
                            <% ProdukPO.movenext
                            loop  %>
                                <tr>
                                    <td class="text-center"colspan="4"> Grand Total</td>
                                    <td class="text-center"> <%=total%> </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            <% PurchaseOrder.movenext
            loop %>  
            <% end if %>
            </div>          
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>