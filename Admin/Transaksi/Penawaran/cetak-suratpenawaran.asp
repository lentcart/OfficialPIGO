<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    pshID = request.queryString("pshID")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute
    
	Merchant_cmd.commandText = "SELECT MKT_T_Penawaran_H.PenwNoPermintaan, MKT_T_Penawaran_H.PenwTglPermintaan, MKT_T_Penawaran_H.PenwNamaCust, MKT_T_Penawaran_H.PenwPhone, MKT_T_Penawaran_H.PenwEmail,  MKT_T_Penawaran_H.PenwAlamat, MKT_T_Penawaran_H.PenwKota, MKT_T_Penawaran_H.PenwID FROM MKT_T_Penawaran_D RIGHT OUTER JOIN MKT_T_Penawaran_H ON MKT_T_Penawaran_D.PenwIDH = MKT_T_Penawaran_H.PenwID WHERE MKT_T_Penawaran_H.PenwID = '"& pshID &"'  GROUP BY MKT_T_Penawaran_H.PenwNoPermintaan, MKT_T_Penawaran_H.PenwTglPermintaan, MKT_T_Penawaran_H.PenwNamaCust, MKT_T_Penawaran_H.PenwPhone, MKT_T_Penawaran_H.PenwEmail,  MKT_T_Penawaran_H.PenwAlamat, MKT_T_Penawaran_H.PenwKota, MKT_T_Penawaran_H.PenwID"
	set customer = Merchant_cmd.execute


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
        document.title = "SuratPenawaran-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";
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
            <!--#include file="../../HeaderPIGO.asp"-->
                <div class="row text-end mt-2">
                    <div class="col-12">
                        <span class="txt-desc"> Bekasi, <%=day(date())%>&nbsp;<%=MonthName(Month(date()))%>&nbsp;<%=Year(date())%></span><br>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-1">
                        <span class="txt-desc"> No </span><br>
                        <span class="txt-desc"> Lamp </span><br>
                        <span class="txt-desc"> Hal </span><br>
                    </div>
                    <div class="col-9">
                        <span class="txt-desc"> : </span>&nbsp;&nbsp;&nbsp;<span class="txt-desc"> <%=customer("PenwID")%> </span><br>
                        <span class="txt-desc"> : </span>&nbsp;&nbsp;&nbsp;<span class="txt-desc"> - </span><br>
                        <span class="txt-desc"> : </span>&nbsp;&nbsp;&nbsp;<span class="txt-desc"> <u>PENAWARAN HARGA PRODUK</u> </span><br>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <span class="txt-desc"> Kepada Yth, </span><br>
                        <span class="txt-desc"> <%=customer("PenwNamaCust")%> </span><br>
                        <span class="txt-desc"> <%=customer("PenwAlamat")%> </span><br>
                        <span class="txt-desc"> <%=customer("PenwKota")%> </span><br>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-12">
                        <span class="txt-desc"> Dengan hormat, </span><br>
                        <span class="txt-desc"> Sehubungan dengan Surat Permintaan Nomor : <b><%=customer("PenwNoPermintaan")%></b> pada Tanggal <b><%=day(customer("PenwTglPermintaan"))%></b>/<b><%=Month(customer("PenwTglPermintaan"))%></b>/<b><%=Year(customer("PenwTglPermintaan"))%></b>&nbsp; , Maka dengan ini kami PT. Perkasa Indah Gemilang Oetama bermaksud untuk mengajukan penawaran harga sesuai dengan surat permintaan diatas. Adapun spesifikasi produk yang dibutuhkan sebagai berikut :  </span><br>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px;border:1px solid black">
                        <thead class="text-center">
                            <tr>
                                <th> No </th>
                                <th> Detail  </th>
                                <th> Harga  </th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            Merchant_cmd.commandText = "SELECT MKT_T_Penawaran_D.Penw_pdID, MKT_T_Penawaran_D.Penw_pdHargaBeli, MKT_T_Penawaran_D.Penw_pdTaxID, MKT_T_Penawaran_D.Penw_pdUpTo, MKT_T_Penawaran_D.Penw_pdHargaJual,  MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Tax.TaxRate FROM MKT_T_Penawaran_D LEFT OUTER JOIN MKT_M_Tax ON MKT_T_Penawaran_D.Penw_pdTaxID = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Penawaran_D.Penw_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_Penawaran_H ON MKT_T_Penawaran_D.PenwIDH = MKT_T_Penawaran_H.PenwID  WHERE (MKT_T_Penawaran_H.PenwID = '"& customer("PenwID")&"' )"
                            'response.write Merchant_cmd.commandText 
                            set produk = Merchant_cmd.execute
                        %>
                        <% 
                            no = 0 
                            do while not produk.eof 
                            no = no + 1
                        %>
                            <tr>
                                <td class="text-center"> <%=no%> </td>
                                <td><b>[<%=produk("pdPartNumber")%>]</b>&nbsp;&nbsp;<%=produk("pdNama")%> </td>
                                <td class="text-center"><%=Replace(Replace(FormatCurrency(produk("Penw_pdHargaJual")),"$","Rp. "),".00","")%> </td>
                            </tr>
                        <% produk.movenext
                        loop %>
                        </tbody>
                    </table>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <span class="txt-desc"> Demikian surat penawaran harga ini kami sampaikan, atas perhatian dan kerjasamanya kami mengucapkan terima kasih . </span><br>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-12">
                        <span class="txt-desc"> Catatan Penawaran </span><br>
                        <span class="txt-desc"> 1 &nbsp;&nbsp; Harga Produk Sudah Termasuk PPN </span><br>
                        <span class="txt-desc"> 2 &nbsp;&nbsp; Harga Produk Dapat Berubah Sewaktu Waktu </span><br>
                        <span class="txt-desc"> 3 &nbsp;&nbsp; Barang Makita Bergaransi 24 Bulan</span><br>
                        <span class="txt-desc"> &nbsp;&nbsp;    &nbsp;&nbsp;&nbsp;&nbsp;3.1 &nbsp;&nbsp; - &nbsp;&nbsp;12 Bulan Gratis Sparepart dan bulan 12 - 24 Sparepart Diskon 40%     </span><br>
                        <span class="txt-desc"> 4 &nbsp;&nbsp; Garansi Baterai 6 Bulan</span><br>
                        <span class="txt-desc"> 5 &nbsp;&nbsp;TOP (Term of Payment) : 30 Hari</span><br>
                    </div>
                </div>
                
                <div class="row" style="margin-top:2rem">
                    <div class="col-12">
                        <span class="txt-desc"> Hormat Kami,</span><br>
                        <span class="txt-desc"> Pimpinan PT. Perkasa Indah Gemilang Oetama</span><br><br><br><br><br>
                        <span class="txt-desc"> Remilo Susanti </span><br>


                </div>
            </div>          
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>