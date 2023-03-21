<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../../admin/")
    
    end if
    tgla        = Cdate(request.queryString("tgla"))
    tgle        = Cdate(request.queryString("tgle"))
    bulan       = month(request.queryString("tgla"))
    tahun       = year(request.queryString("tgla"))
    typeproduk  = request.queryString("typeproduk")
    typepart    = request.queryString("typepart")


    set Stok_CMD = server.createObject("ADODB.COMMAND")
	Stok_CMD.activeConnection = MM_PIGO_String
    If typepart = "" then 
        Stok_CMD.commandText = "SELECT MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdTypePart FROM MKT_T_Transaksi_D1 RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID FULL OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_PIGO_Produk.pdID FULL OUTER JOIN MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID WHERE MKT_M_PIGO_Produk.pdTypeProduk = '"& typeproduk &"' and mmTanggal BETWEEN '"& tgla &"' and '"& tgle &"' OR trTglTransaksi BETWEEN '"& tgla &"' and '"& tgle &"' and pdTypePart <> ''  GROUP BY MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdTypePart"
        'response.write Stok_CMD.commandText
        set Stok = Stok_CMD.execute
    Else
        Stok_CMD.commandText = "SELECT MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdTypePart FROM MKT_T_Transaksi_D1 RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID FULL OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_PIGO_Produk.pdID FULL OUTER JOIN MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID WHERE MKT_M_PIGO_Produk.pdTypePart = '"& typepart &"' AND MKT_M_PIGO_Produk.pdTypeProduk = '"& typeproduk &"' and mmTanggal BETWEEN '"& tgla &"' and '"& tgle &"' OR trTglTransaksi BETWEEN '"& tgla &"' and '"& tgle &"' GROUP BY MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdTypePart"
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
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "KartuStok-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
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
                    <div class="col-6">
                        <span style="font-size:25px"><b> KARTU STOK </b></span><br>
                        <span> PERIODE <b> <%=tgla%> s.d. <%=tgle%> </b></span>
                    </div>
                    <div class="col-6">
                        <div class="row align-items-center">
                            <div class="col-1 me-4">
                                <img src="<%=base_url%>/assets/logo/1.png" class="logo me-3" alt="" width="65" height="65" />
                            </div>
                            <div class="col-10">
                                <span class="Judul-Merchant" style="font-size:25px; color:#0077a2"> <b>PT. PERKASA INDAH GEMILANG OETAMA</b></span><br>
                                <span class="txt-desc"> Jln. Alternatif Cibubur, Komplek Ruko Cibubur Point Automotiv Center Blok B No. 12B Cimangis,</span><span class="txt-desc"> Depok – Jawa Barat </span><br>
                                <span class="txt-desc"> otopigo.sekertariat@gmail.com </span> - <span class="txt-desc"> Telp : (021) 8459 6001 / 0811-8838-008 </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 mb-2" style="border-bottom:4px solid black">
                
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <table class="table vertical-align-center cont-tb table-bordered table-condensed mt-1" style="font-size:10px;">
                            <thead style="background-color:#eee; color:black">
                                <tr>
                                    <th class="text-center" rowspan = "2"> NO </th>
                                    <th class="text-center" rowspan = "2"> DETAIL</th>
                                    <th class="text-center" colspan = "3"> SALDO AWAL</th>
                                    <th class="text-center" colspan = "3"> MASUK </th>
                                    <th class="text-center" colspan = "3"> KELUAR </th>
                                    <th class="text-center" colspan = "3"> SISA </th>
                                </tr>
                                <tr>
                                    <th class="text-center" rowspan = "2">Unit</th>
                                    <th class="text-center" rowspan = "2">H/Unit (Rp)</th>
                                    <th class="text-center" rowspan = "2">Jumlah (Rp)</th>
                                    <th class="text-center" rowspan = "2">Unit</th>
                                    <th class="text-center" rowspan = "2"> H/Unit (Rp)</th>
                                    <th class="text-center" rowspan = "2">Jumlah (Rp)</th>
                                    <th class="text-center" rowspan = "2">Unit</th>
                                    <th class="text-center" rowspan = "2"> H/Unit (Rp)</th>
                                    <th class="text-center" rowspan = "2">Jumlah (Rp)</th>
                                    <th class="text-center" rowspan = "2">Unit</th>
                                    <th class="text-center" rowspan = "2"> H/Unit (Rp)</th>
                                    <th class="text-center" rowspan = "2">Jumlah (Rp)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% do while not Stok.eof %>
                                <tr style="background-color:#aaa">
                                    <th class="text-center" colspan="2">TYPE PRODUK</th>
                                    <th class="text-center" colspan="3"><%=Stok("pdTypeProduk")%></th>
                                    <th class="text-center" colspan="9"><%=Stok("pdTypePart")%></th>
                                </tr>
                                <%
                                    Stok_CMD.commandText = "SELECT pdID, pdNama, pdPartNumber FROM MKT_M_PIGO_Produk WHERE  pdTypeProduk = '"& Stok("pdTypeProduk") &"' AND pdTypePart = '"& Stok("pdTypePart") &"'"
                                    'response.write Stok_CMD.commandText
                                    set Produk = Stok_CMD.execute
                                %>
                                
                                <% 
                                    no =0
                                    do while not Produk.eof 
                                    no = no + 1
                                %>
                                    <tr>
                                        <td class="text-center"> <%=no%> </td>
                                        <td>[<%=Produk("pdPartNumber")%>] &nbsp; - &nbsp; <%=Produk("pdNama")%> </td>
                                        <%
                                            Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_M_Stok.st_pdQty), 0) AS SaldoAwal, ISNULL(MKT_M_Stok.st_pdHarga, 0) AS HargaSaldoAwal FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE MKT_M_PIGO_Produk.pdID = '"& Produk("pdID") &"' GROUP BY MKT_M_Stok.st_pdHarga"
                                            'response.write Stok_CMD.commandText
                                            set SaldoAwal = Stok_CMD.execute
                                        %>
                                        <td class="text-center"> <%=SaldoAwal("SaldoAwal")%> </td>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(SaldoAwal("HargaSaldoAwal")),"$","Rp. "),".00","")%> </td>
                                        <%
                                            JumlahSaldoAwal = SaldoAwal("SaldoAwal")*SaldoAwal("HargaSaldoAwal")
                                        %>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(JumlahSaldoAwal),"$","Rp. "),".00","")%> </td>
                                        
                                        <%
                                            Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdHarga, 0) AS HargaPembelian FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE pdID = '"& Produk("pdID") &"' GROUP BY MKT_T_MaterialReceipt_D2.mm_pdHarga"
                                            'response.write Stok_CMD.commandText &"<br>"
                                            set SaldoMasuk = Stok_CMD.execute
                                        %>
                                        <td class="text-center"> <%=SaldoMasuk("Pembelian")%> </td>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(SaldoMasuk("HargaPembelian")),"$","Rp. "),".00","")%> </td>
                                        <%
                                            JumlahSaldoMasuk = SaldoMasuk("Pembelian")*SaldoMasuk("HargaPembelian")
                                        %>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(JumlahSaldoMasuk),"$","Rp. "),".00","")%> </td>

                                        <%
                                            Stok_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty), 0) AS Penjualan, ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, 0) AS HargaPenjualan, ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdUpTo,0) AS Perm_pdUpTo,  ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdTax,0) AS Perm_pdTax FROM MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_Permintaan_Barang_D.Perm_IDH RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID WHERE MKT_M_PIGO_Produk.pdID = '"& Produk("pdID") &"' GROUP BY MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_D.Perm_pdUpTo, MKT_T_Permintaan_Barang_D.Perm_pdTax"
                                            'response.write Stok_CMD.commandText &"<br>"
                                            set SaldoKeluar = Stok_CMD.execute
                                            Harga = SaldoKeluar("HargaPenjualan")
                                            UPTO  = Harga+(Harga*SaldoKeluar("Perm_pdUpTo")/100)
                                            PPN   = UPTO*SaldoKeluar("Perm_pdTax")/100
                                            Total = round(UPTO+PPN)


                                        %>
                                        <td class="text-center"> <%=SaldoKeluar("Penjualan")%> </td>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(Total),"$","Rp. "),".00","")%> </td>
                                        <%
                                            JumlahSaldoKeluar = SaldoKeluar("Penjualan")*Total
                                        %>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(JumlahSaldoKeluar),"$","Rp. "),".00","")%> </td>
                                        <%
                                            SisaUnit            = SaldoAwal("SaldoAwal") + SaldoMasuk("Pembelian") - SaldoKeluar("Penjualan")
                                            JumlahUnit          = JumlahSaldoAwal + JumlahSaldoMasuk - JumlahSaldoKeluar

                                            if JumlahUnit = 0 then
                                            HargaUnit = round(JumlahUnit+SisaUnit)
                                            else
                                                If JumlahUnit = 0 then
                                                    HargaUnit = 0
                                                else
                                                    HargaUnit =  round(JumlahUnit/SisaUnit)
                                                end if 
                                            end if
                                        %>
                                        <td class="text-center"> <%=SisaUnit%> </td>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(HargaUnit),"$","Rp. "),".00","")%> </td>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(JumlahUnit),"$","Rp. "),".00","")%> </td>
                                    </tr>
                                    <%
                                        SubUnitSaldoAwal = SubUnitSaldoAwal + SaldoAwal("SaldoAwal")
                                        SubHargaSaldoAwal = SubHargaSaldoAwal + SaldoAwal("HargaSaldoAwal")
                                        SubJumlahSaldoAwal = SubJumlahSaldoAwal + JumlahSaldoAwal

                                        SubUnitPembelian = SubUnitPembelian + SaldoMasuk("Pembelian")
                                        SubHargaPembelian = SubHargaPembelian + SaldoMasuk("HargaPembelian")
                                        SubJumlahPembelian = SubJumlahPembelian + JumlahSaldoMasuk

                                        SubUnitPenjualan = SubUnitPenjualan + SaldoKeluar("Penjualan")
                                        SubHargaPenjualan = SubHargaPenjualan + Total
                                        SubJumlahPenjualan = SubJumlahPenjualan + JumlahSaldoKeluar
                                        
                                        SubUnitSisa = SubUnitSisa + SisaUnit
                                        SubHargaSisa = SubHargaSisa + HargaUnit
                                        SubJumlahSisa = SubJumlahSisa + JumlahUnit
                                    %>
                                <%
                                    Produk.movenext
                                    loop
                                %>  
                                    <tr>
                                        <th colspan="2"> SUB TOTAL </th>
                                        <th colspan="3"class="text-end"> <%=Replace(Replace(FormatCurrency(SubJumlahSaldoAwal),"$","Rp."),".00","")%> </th>
                                        <th colspan="3"class="text-end"> <%=Replace(Replace(FormatCurrency(SubJumlahPembelian),"$","Rp."),".00","")%> </th>
                                        <th colspan="3"class="text-end"> <%=Replace(Replace(FormatCurrency(SubJumlahPenjualan),"$","Rp."),".00","")%> </th>
                                        <th colspan="3"class="text-end"> <%=Replace(Replace(FormatCurrency(SubJumlahSisa),"$","Rp."),".00","")%> </th>

                                    </tr>
                                    <%
                                        GrandUnitSaldoAwal = GrandUnitSaldoAwal + SubUnitSaldoAwal
                                        GrandHargaSaldoAwal = GrandHargaSaldoAwal + SubHargaSaldoAwal
                                        GrandJumlahSaldoAwal = GrandJumlahSaldoAwal + SubJumlahSaldoAwal

                                        GrandUnitPembelian = GrandUnitPembelian + SubUnitPembelian
                                        GrandHargaPembelian = GrandHargaPembelian + SubHargaPembelian
                                        GrandJumlahPembelian = GrandJumlahPembelian + SubJumlahPembelian

                                        GrandUnitPenjualan = GrandUnitPenjualan + SubUnitPenjualan
                                        GrandHargaPenjualan = GrandHargaPenjualan + SubHargaPenjualan
                                        GrandJumlahPenjualan = GrandJumlahPenjualan + SubJumlahPenjualan

                                        GrandUnitSisa = GrandUnitSisa + SubUnitSisa
                                        GrandHargaSisa = GrandHargaSisa + SubHargaSisa
                                        GrandJumlahSisa = GrandJumlahSisa + SubJumlahSisa
                                    %>

                                    <%
                                        SubTotalUnitSaldoAwal = SubTotalUnitSaldoAwal + SubUnitSaldoAwal
                                        SubUnitSaldoAwal = 0
                                        SubTotalHargaSaldoAwal = SubTotalHargaSaldoAwal + SubHargaSaldoAwal
                                        SubHargaSaldoAwal = 0
                                        SubTotalJumlahSaldoAwal = SubTotalJumlahSaldoAwal + SubJumlahSaldoAwal
                                        SubJumlahSaldoAwal = 0

                                        SubTotalUnitPembelian = SubTotalUnitPembelian + SubUnitPembelian
                                        SubUnitPembelian = 0
                                        SubTotalHargaPembelian = SubTotalHargaPembelian + SubHargaPembelian
                                        SubHargaPembelian = 0
                                        SubTotalJumlahPembelian = SubTotalJumlahPembelian + SubJumlahPembelian
                                        SubJumlahPembelian = 0

                                        SubTotalUnitPenjualan = SubTotalUnitPenjualan + SubUnitPenjualan
                                        SubUnitPenjualan = 0
                                        SubTotalHargaPenjualan = SubTotalHargaPenjualan + SubHargaPenjualan
                                        SubHargaPenjualan = 0
                                        SubTotalJumlahPenjualan = SubTotalJumlahPenjualan + SubJumlahPenjualan
                                        SubJumlahPenjualan = 0

                                        SubTotalUnitSisa = SubTotalUnitSisa + SubUnitSisa
                                        SubUnitSisa = 0
                                        SubTotalHargaSisa = SubTotalHargaSisa + SubHargaSisa
                                        SubHargaSisa = 0
                                        SubTotalJumlahSisa = SubTotalJumlahSisa + SubJumlahSisa
                                        SubJumlahSisa = 0
                                    %>
                                    
                                <% Stok.movenext
                                loop %>
                                    <tr>   
                                        <th colspan="2"> TOTAL KESELURUHAN </th>
                                        <th colspan="3" class="text-end"> <%=Replace(Replace(FormatCurrency(GrandJumlahSaldoAwal),"$","Rp. "),".00","")%> </th>
                                        <th colspan="3" class="text-end"> <%=Replace(Replace(FormatCurrency(GrandJumlahPembelian),"$","Rp. "),".00","")%> </th>
                                        <th colspan="3" class="text-end"> <%=Replace(Replace(FormatCurrency(GrandJumlahPenjualan),"$","Rp. "),".00","")%> </th>
                                        <th colspan="3" class="text-end"> <%=Replace(Replace(FormatCurrency(GrandJumlahSisa),"$","Rp. "),".00","")%> </th>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
    <script>
        function s(){
            $(".cont-print").hide();  
            window.print();
        }
    </script>
</html>