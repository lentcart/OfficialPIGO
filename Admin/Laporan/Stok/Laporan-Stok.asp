<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")
    typeproduk = request.queryString("typeproduk")
    typepart = request.queryString("typepart")
    kategori = request.queryString("kategori")
    namapd = request.queryString("namapd")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Stok_CMD = server.createObject("ADODB.COMMAND")
	Stok_CMD.activeConnection = MM_PIGO_String
    If typepart = "" then 
        Stok_CMD.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal, MKT_M_Stok.st_pdHarga AS HargaAwal, MKT_M_Tax.TaxRate,  MKT_M_PIGO_Produk.pdUpTo FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID  WHERE MKT_M_PIGO_Produk.pdTypeProduk = '"& typeproduk &"'  "
        'response.write Stok_CMD.commandText
        set Stok = Stok_CMD.execute
    Else
        Stok_CMD.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal, MKT_M_Stok.st_pdHarga AS HargaAwal, MKT_M_Tax.TaxRate,  MKT_M_PIGO_Produk.pdUpTo FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE MKT_M_PIGO_Produk.pdTypePart = '"& typepart &"' AND MKT_M_PIGO_Produk.pdTypeProduk = '"& typeproduk &"'  "
        'response.write Stok_CMD.commandText
        set Stok = Stok_CMD.execute
    End IF

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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>

    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "LaporanStok-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";
    const myTimeout = setTimeout(myGreeting, 2000);

        function myGreeting() {
        // window.print();
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
    <!--<div class="container">
    <div class="row">
        <div class="col-12">
            <a href="index.asp"> Kembali </a>
        </div>
    </div>
    </div>-->
    <div class="cont-print">
        <div class="row text-center">
            <div class="col-1 me-4">
                <div class="print">
                    <button class="cont-btn" onclick="s()"><i class="fas fa-arrow-left"></i> &nbsp;&nbsp; KEMBALI </button>
                </div>
            </div>
            <div class="col-1 me-4">
                <div class="print">
                    <button class="cont-btn" onclick="s()"><i class="fas fa-print"></i> &nbsp;&nbsp; PDF </button>
                </div>
            </div>
            <div class="col-1 me-4">
                <div class="print">
                    <button class="cont-btn" onclick="s()"><i class="fas fa-download"></i> &nbsp;&nbsp; EXP EXCEL </button>
                </div>
            </div>
        </div>
    </div>
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
                <div class="row mt-3">
                    <div class="col-12">
                        <span class="cont-text" style="font-size:15px"><b> <%=typeproduk%> </b></span> <span class="cont-text" style="font-size:15px"><b> ( &nbsp; <%=typepart%> &nbsp; ) </b></span>
                        <table class="table cont-tb tb-transaksi table-bordered table-condensed mt-1" style="font-size:11px">
                            <thead>
                                <tr>
                                    <th class="text-center"> NO </th>
                                    <th class="text-center"> DETAIL PRODUK </th>
                                    <th class="text-center"> STOK AWAL </th>
                                    <th class="text-center"> PEMBELIAN </th>
                                    <th class="text-center"> PENJUALAN </th>
                                    <th class="text-center"> STOK AKHIR </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    no = 0 
                                    do while not Stok.eof
                                    no = no + 1
                                %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td>[<%=Stok("pdPartNumber")%>] &nbsp; <%=Stok("pdNama")%></td>
                                    <td class="text-center"> <%=Stok("StokAwal")%></td>
                                    <%
                                        Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian, ISNULL(MKT_M_PIGO_Produk.pdHarga, 0) AS HargaPembelian FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND pdID = '"& Stok("pdID") &"' GROUP BY MKT_M_PIGO_Produk.pdHarga"
                                        'response.write Stok_CMD.commandText &"<br>"
                                        set SaldoMasuk = Stok_CMD.execute
                                    %>
                                    <td class="text-center"> <%=SaldoMasuk("Pembelian")%> </td>
                                    <%
                                        Stok_CMD.commandText = "SELECT ISNULL(MKT_T_Transaksi_D1A.tr_pdHarga, 0) AS HargaPenjualan, ISNULL(MKT_T_Transaksi_D1A.tr_pdQty, 0) AS Penjualan FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_D1.trD1 = MKT_T_Transaksi_D1A.trD1A ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) ON  MKT_M_PIGO_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND pdID = '"& Stok("pdID") &"' "
                                        'response.write Stok_CMD.commandText &"<br>"
                                        set SaldoKeluar = Stok_CMD.execute
                                    %>
                                    <td class="text-center"> <%=SaldoKeluar("Penjualan")%> </td>
                                    <%
                                        Sisa = Stok("StokAwal")+SaldoMasuk("Pembelian")-SaldoKeluar("Penjualan")
                                    %>
                                    <td class="text-center"> <%=Sisa%></td>
                                <tr>
                                <%
                                    Stok.movenext
                                    loop
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>      
            </div>        
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>