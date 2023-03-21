<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../../admin/")
    
    end if

    Periode                     = "1"
    Tgla                        = "2022-10-01"
    Tgle                        = "2022-10-30"
    pdID                        = "P072200001"
    Tahun                       = YEAR(CDate(Tgla))
    

        SAPD_Bulan                 = Month(CDate(Tgla))
        
        
        set KartuStok_CMD = server.createObject("ADODB.COMMAND")
        KartuStok_CMD.activeConnection = MM_PIGO_String
        KartuStok_CMD.commandText = "SELECT MKT_M_PIGO_Produk.pdPartNumber, MKT_M_PIGO_Produk.pdNama, MKT_T_SAPD.* FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_SAPD ON MKT_M_PIGO_Produk.pdID = MKT_T_SAPD.SAPD_pdID WHERE SAPD_Bulan = '"& SAPD_Bulan &"' AND SAPD_pdID = '"& pdID &"' "
        Response.Write KartuStok_CMD.commandText
        set Stok = KartuStok_CMD.execute
        
        set Stok_CMD = server.CreateObject("ADODB.command")
        Stok_CMD.activeConnection = MM_pigo_STRING
        Stok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_D2.mm_pdID = '"& Stok("SAPD_pdID") &"' AND (MKT_T_MaterialReceipt_H.mmTanggal BETWEEN '"& Tgla &"' AND '"& Tgle &"' ) AND YEAR(MKT_T_MaterialReceipt_H.mmTanggal ) = '"& Tahun &"' ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC "
        response.Write Stok_CMD.commandText & "<br><br>"
        set Pembelian = Stok_CMD.execute

        do while not Pembelian.eof
            Tanggal     = Day(CDate(Pembelian("mmTanggal")))
            if len(Tanggal)    = 1 then
                Tanggal = "0" & Tanggal
            end if
            SAPD_Pembelian             = SAPD_Pembelian +","+ "SAPD_Pembelian"&Tanggal
            SAPD_HargaPembelian        = SAPD_HargaPembelian +","+ "SAPD_HargaPembelian"&Tanggal
        response.Write SAPD_Pembelian & "<br><br>"
        Pembelian.movenext
        loop
        Beli = Beli + SAPD_Pembelian
        HargaBeli = HargaBeli + SAPD_HargaPembelian
        response.Write HargaBeli & "<br><br>"

        Stok_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_pdID = '"& Stok("SAPD_pdID") &"' AND (MKT_T_Permintaan_Barang_H.PermTanggal BETWEEN '"& Tgla &"' AND '"& Tgle &"' ) AND YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '"& Tahun &"' ORDER BY MKT_T_Permintaan_Barang_H.PermTanggal ASC "
        response.Write Stok_CMD.commandText & "<br><br>"
        set Penjualan = Stok_CMD.execute
        
        do while not Penjualan.eof
            Tanggal     = Day(CDate(Penjualan("PermTanggal")))
            if len(Tanggal)    = 1 then
                Tanggal = "0" & Tanggal
            end if
            SAPD_Penjualan             = SAPD_Penjualan +","+ "SAPD_Penjualan"&Tanggal
            SAPD_HargaPenjualan        = SAPD_HargaPenjualan +","+ "SAPD_HargaPenjualan"&Tanggal
        response.Write SAPD_Penjualan & "<br><br>"
        Penjualan.movenext
        loop
        Jual = Jual + SAPD_Penjualan
        HargaJual = HargaJual + SAPD_HargaPenjualan
        response.Write Jual & "<br><br>"
        response.Write HargaJual & "<br><br>"

        set KartuStok_CMD = server.createObject("ADODB.COMMAND")
        KartuStok_CMD.activeConnection = MM_PIGO_String
        KartuStok_CMD.commandText = "SELECT MKT_M_PIGO_Produk.pdPartNumber, MKT_M_PIGO_Produk.pdNama, MKT_T_SAPD.SAPD_SaldoAwal AS SaldoAwal, MKT_T_SAPD.SAPD_HargaSaldoAwal AS HargaSaldoAwal "& Beli &" "& HargaBeli &" "& Jual &" "& HargaJual &" FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_SAPD ON MKT_M_PIGO_Produk.pdID = MKT_T_SAPD.SAPD_pdID WHERE (MKT_T_SAPD.SAPD_Bulan = '"& SAPD_Bulan &"') AND (MKT_T_SAPD.SAPD_pdID = '"& pdID &"')"
        Response.Write KartuStok_CMD.commandText
        set KartuStok = KartuStok_CMD.execute


    

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
        document.title = "KartuStokProduk-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
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
                        <span style="font-size:25px"><b> KARTU STOK /PRODUK </b></span><br>
                        <% if Periode = "1" then %>
                            <span style="font-size:13px"> Periode <b> <%=tgla%> s.d. <%=tgle%> </b></span>
                        <% else %>
                            <span style="font-size:13px"> Periode Bulan <b> <%=MonthName(Month(tgla))%> </b></span>
                        <% end if  %>
                    </div>
                    <div class="col-6">
                        <div class="row align-items-center">
                            <div class="col-2">
                                <img src="<%=base_url%>/assets/logo/1.png" class="logo me-3" alt="" width="60" height="65" />
                            </div>
                            <div class="col-10">
                                <span class="Judul-Merchant" style="font-size:25px; color:#0077a2"> <b>PT. PERKASA INDAH GEMILANG OETAMA</b></span><br>
                                <span class="txt-desc"> Jln. Alternatif Cibubur, Komplek Ruko Cibubur Point Automotiv Center Blok B No. 12B Cimangis,</span><span class="txt-desc"> Depok – Jawa Barat </span><br>
                                <span class="txt-desc"> Telp : (021) 8459 6001 / 0811-8838-008 - </span><span class="txt-desc"> otopigo.sekertariat@gmail.com </span><br>
                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 mb-2" style="border-bottom:4px solid black">

                </div>
                <div class="row mt-2">
                    <div class="col-2">
                        <span class="cont-text"> DETAIL PRODUK  </span>

                    </div>
                    <div class="col-2">
                        &nbsp; :  &nbsp;<span class="cont-text"> <%=KartuStok("pdNama")%> </span><br>
                        &nbsp; :  &nbsp;<span class="cont-text"> <%=KartuStok("pdPartNumber")%> </span><br>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <table class="table vertical-align-center cont-tb table-bordered table-condensed mt-1" style="font-size:11px;">
                            <thead style="background-color:#eee; color:black">
                                <tr>
                                    <th class="text-center" rowspan = "2"> TANGGAL </th>
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
                                <%
                                    no = 0 
                                    do while not KartuStok.eof
                                    no = no + 1
                                %>
                                <tr>
                                <%
                                    set Stok_CMD = server.CreateObject("ADODB.command")
                                    Stok_CMD.activeConnection = MM_pigo_STRING
                                    Stok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_D2.mm_pdID = '"& Stok("SAPD_pdID") &"' AND (MKT_T_MaterialReceipt_H.mmTanggal BETWEEN '"& Tgla &"' AND '"& Tgle &"' ) AND YEAR(MKT_T_MaterialReceipt_H.mmTanggal ) = '"& Tahun &"' ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC "
                                    response.Write Stok_CMD.commandText & "<br><br>"
                                    set Pembelian = Stok_CMD.execute
                                %>
                                <%    do while not Pembelian.eof 
                                Tanggal     = Day(CDate(Pembelian("mmTanggal")))
                                        if len(Tanggal)    = 1 then
                                            Tanggal = "0" & Tanggal
                                        end if
                                        SAPD_Pembelian             = "SAPD_Pembelian"&Tanggal &" AS Pembelian"
                                        SAPD_Pembeliann             = "SAPD_Pembelian"&Tanggal 
                                        SAPD_HargaPembelian        = "SAPD_HargaPembelian"&Tanggal
                                    response.Write SAPD_Pembelian & "<br><br>"
                                    set KartuStok_CMD = server.createObject("ADODB.COMMAND")
                                    KartuStok_CMD.activeConnection = MM_PIGO_String
                                    KartuStok_CMD.commandText = "SELECT MKT_M_PIGO_Produk.pdPartNumber, MKT_M_PIGO_Produk.pdNama, MKT_T_SAPD.SAPD_SaldoAwal AS SaldoAwal, MKT_T_SAPD.SAPD_HargaSaldoAwal AS HargaSaldoAwal, "& SAPD_Pembelian &" FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_SAPD ON MKT_M_PIGO_Produk.pdID = MKT_T_SAPD.SAPD_pdID WHERE (MKT_T_SAPD.SAPD_Bulan = '"& SAPD_Bulan &"') AND (MKT_T_SAPD.SAPD_pdID = '"& pdID &"') "
                                    Response.Write KartuStok_CMD.commandText
                                    set KartuStok = KartuStok_CMD.execute
                                %>
                                    <td class="text-center"> <%=SAPD_Pembeliann%> </td>
                                    <!--SaldoAwal-->
                                        <td class="text-center"> <%=KartuStok("SaldoAwal")%> </td>
                                        <td class="text-end"> <%=Replace(replace(FormatCurrency(KartuStok("HargaSaldoAwal")),"$","Rp. "),".00","")%> </td>
                                        <td class="text-end"> 
                                            <% JumlahSaldoAwal = KartuStok("SaldoAwal")*KartuStok("HargaSaldoAwal") %>
                                            <%=Replace(replace(FormatCurrency(JumlahSaldoAwal),"$","Rp. "),".00","")%> 
                                        </td class="text-center">
                                    <!--SaldoAwal-->
                                    
                                    <!--Pembelian-->
                                        <td class="text-center"> <%=KartuStok("Pembelian")%> </td>
                                        <td class="text-end"> <%=Replace(replace(FormatCurrency(KartuStok("HargaPembelian")),"$","Rp. "),".00","")%> </td>
                                        <td class="text-end"> 
                                            <% JumlahPembelian = KartuStok("Pembelian")*KartuStok("HargaPembelian") %>
                                            <%=Replace(replace(FormatCurrency(JumlahPembelian),"$","Rp. "),".00","")%> 
                                        </td class="text-center">
                                    <!--Pembelian-->
                                        <% 
                                            Sisa            = KartuStok("SaldoAwal")+KartuStok("Pembelian")
                                            Jumlah          = JumlahSaldoAwal+JumlahPembelian
                                            
                                        %>
                                    <!--Penjualan-->
                                        <td class="text-center"> <%=KartuStok("Penjualan")%> </td>
                                        <td class="text-end"> <%=Replace(replace(FormatCurrency(KartuStok("HargaPenjualan")),"$","Rp. "),".00","")%> </td>
                                        <td class="text-end"> 
                                            <% JumlahPenjualan = KartuStok("Penjualan")*KartuStok("HargaPenjualan") %>
                                            <%=Replace(replace(FormatCurrency(JumlahPenjualan),"$","Rp. "),".00","")%> 
                                        </td class="text-center">
                                    <!--Penjualan-->
                                        <% 
                                            TotalSisa       = TotalSisa + Sisa -  KartuStok("Penjualan") 
                                            GrandJumlah     = GrandJumlah + Jumlah - JumlahPenjualan
                                            Harga           = Round(GrandJumlah/TotalSisa)
                                        %>
                                    <!--Sisa-->
                                        
                                    <td class="text-center"> <%=TotalSisa%> </td>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(Harga),"$","Rp. "),".00","")%> </td>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(GrandJumlah),"$","Rp. "),".00","")%> </td>
                                    <!--Sisa-->
                                </tr>


                                <%    Pembelian.movenext
                                    loop
                                    Beli = Beli + SAPD_Pembelian
                                    HargaBeli = HargaBeli + SAPD_HargaPembelian
                                    response.Write HargaBeli & "<br><br>"
                                %>
                                    
                                <%
                                    KartuStok.movenext
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
    <script>
        function s(){
            $(".cont-print").hide();  
            window.print();
        }
    </script>
</html>