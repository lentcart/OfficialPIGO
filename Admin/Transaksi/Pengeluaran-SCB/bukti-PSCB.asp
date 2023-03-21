<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    pscID = request.queryString("pscID")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Pengeluaran_cmd = server.createObject("ADODB.COMMAND")
	Pengeluaran_cmd.activeConnection = MM_PIGO_String
			
	Pengeluaran_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_H.pscType,  MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama,  MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1 FROM MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Permintaan_Barang_H.Perm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_PengeluaranSC_H.psc_permID LEFT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_Permintaan_Barang_D.Perm_IDH WHERE (MKT_T_PengeluaranSC_H.pscID ='"& pscID &"')  GROUP BY MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_H.pscType,  MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama,  MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1 "
    'response.write Pengeluaran_cmd.commandText
	set Pengeluaran = Pengeluaran_cmd.execute

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
        // window.print();
        document.title = "BuktiPSCB-<%=pscID%>-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";

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
            <% do while not Pengeluaran.eof%>
            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <div class="col-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> No PSCB </span><br>
                                    <span class="txt-desc"> Pelanggan </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-8 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span>&nbsp;&nbsp;<span class="txt-desc"><%=Pengeluaran("pscID")%></span><br>
                                    <span class="txt-desc"> : </span>&nbsp;&nbsp;<span class="txt-desc"><%=Pengeluaran("custNama")%></span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> No Permintaan  </span><br>
                                    <span class="txt-desc"> Tanggal </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-8 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span>&nbsp;&nbsp;<span class="txt-desc"><%=Pengeluaran("permID")%></span><br>
                                    <span class="txt-desc"> : </span>&nbsp;&nbsp;<span class="txt-desc"><%=day(pengeluaran("pscTanggal"))%>&nbsp;<%=monthName(month(pengeluaran("pscTanggal")))%>&nbsp;<%=year(pengeluaran("pscTanggal"))%>&nbsp;</span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row text-center mt-3">
                <div class="col-12">
                    <span class="txt-desc" style="font-size:18px"><b>BUKTI PENGELUARAN SUKU CADANG BARU</b></span><br>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        </div>
                        <table class="table tb-transaksi cont-tb table-bordered table-condensed mt-1" style="font-size:11px; border:1px solid black">
                        <thead>
                            <tr>
                                <th class="text-center"> No </th>
                                <th class="text-center"> Kode Produk </th>
                                <th class="text-center"> Nama Produk </th>
                                <th class="text-center"> QTY </th>
                                <th class="text-center"> Unit </th>
                                <th class="text-center"> Harga</th>
                                <th class="text-center"> Sub Total</th>
                            </tr>
                            
                        </thead>
                        <tbody>
                        <% 
                            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no, MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber,  MKT_M_PIGO_Produk.pdUnit FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_M_PIGO_Produk.pdID = MKT_T_Permintaan_Barang_D.Perm_pdID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_PengeluaranSC_H.psc_permID ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_PengeluaranSC_H.pscID = '"& Pengeluaran("pscID") &"' GROUP BY  MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber,  MKT_M_PIGO_Produk.pdUnit"    
                            'response.write produk_cmd.commandText
	                        set produk = produk_cmd.execute
                        %>
                        <% do while not produk.eof%>
                            <tr>
                                <td class="text-center"> <%=produk("no")%> </td>
                                <td> <%=produk("pdPartNumber")%> </td>
                                <td> <%=produk("pdNama")%> </td>
                                <td class="text-center"> <%=produk("Perm_pdQty")%> </td>
                                <td class="text-center"> <%=produk("pdUnit")%> </td>
                                <td class="text-end"> <%=Replace(Replace(FormatCurrency(produk("Perm_pdHargaJual")),"$","Rp.  "),".00","")%> </td>
                                <% total = produk("Perm_pdQty") * produk("Perm_pdHargaJual") %>
                                <td class="text-end"> <%=Replace(Replace(FormatCurrency(total),"$","Rp.  "),".00","")%> </td>
                                <% subtotal = subtotal + total %>
                            </tr>
                            <%
                                subtotal = subtotal + totalpo
                            %>
                            <% produk.movenext
                            loop%>
                            <tr>
                                <th colspan="6" class="text-right"> Grand Total </th>
                                <td class="text-end"> <%=Replace(Replace(FormatCurrency(subtotal),"$","Rp.  "),".00","")%> </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
            <% Pengeluaran.movenext
            loop %>  
            <div class="row text-center" style="margin-top:2rem">
                <div class="col-6">
                    <span class="txt-desc"> </span><br>
                    <span class="txt-desc"> Diserahkan Oleh,</span><br><br><br>
                    <span class="txt-desc"><u>.....................................</u></span><br>
                </div>
                <div class="col-6">
                    <span class="txt-desc"> Tanggal,.......................................</span><br>
                    <span class="txt-desc"> Diterima Oleh,</span><br><br><br>
                    <span class="txt-desc"><u>.....................................</u></span><br>
                </div>
            </div>          
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>