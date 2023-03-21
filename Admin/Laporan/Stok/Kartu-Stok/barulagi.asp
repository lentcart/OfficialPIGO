<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../../admin/")
    
    end if

    Periode         = request.queryString("Periode")
    if Periode = "1" then 
        Tgla        = request.queryString("")
        Tgle        = request.queryString("")
        pdID        = request.queryString("pdID")

        set KartuStok_CMD = server.createObject("ADODB.COMMAND")
        KartuStok_CMD.activeConnection = MM_PIGO_String
        KartuStok_CMD.commandText = "SELECT * FROM MKT_T_SAPDB WHERE SAPDB_pdID = '"& pdID &"' AND SAPDB_Tahun = '"& YEAR(Tanggal) &"' "
        Response.Write KartuStok_CMD.commandText
        set KartuStok = KartuStok_CMD.execute

    else

        Tanggal     = request.queryString("Tanggal")
        pdID        = request.queryString("pdID")

        set KartuStok_CMD = server.createObject("ADODB.COMMAND")
        KartuStok_CMD.activeConnection = MM_PIGO_String
        KartuStok_CMD.commandText = "SELECT MKT_T_SAPDB.SAPDB_pdID,MKT_T_SAPDB.SAPDB_SaldoAwal, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber FROM MKT_T_SAPDB LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_SAPDB.SAPDB_pdID = MKT_M_PIGO_Produk.pdID WHERE SAPDB_pdID = '"& pdID &"' AND SAPDB_Tahun = '"& YEAR(Tanggal) &"' "
        Response.Write KartuStok_CMD.commandText
        set KartuStok = KartuStok_CMD.execute

    end if 


    

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
                        <span style="font-size:25px"><b> KARTU STOK /PRODUK </b></span><br>
                        <% if Periode = "1" then %>
                            <span> Periode <b> <%=tgla%> s.d. <%=tgle%> </b></span>
                        <% else %>
                            <span> Periode Bulan <b> <%=MonthName(Month(Tanggal))%> </b></span>
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
                    <div class="col-12">
                        <table class="table vertical-align-center cont-tb table-bordered table-condensed mt-1" style="font-size:11px;">
                            <thead class="vertical-align-center  align-items-center">
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
                                    Bulan           = Month(Tanggal)
                                    SAPDB_Pembelian = "SAPDB_Pembelian"&Bulan

                                    KartuStok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_SAPDB.SAPDB_pdID, "& SAPDB_Pembelian &" FROM MKT_T_SAPDB LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_SAPDB.SAPDB_pdID = MKT_T_MaterialReceipt_D2.mm_pdID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MONTH(MKT_T_MaterialReceipt_H.mmTanggal) = '"& Bulan &"') and  MKT_T_SAPDB.SAPDB_pdID = '"& KartuStok("SAPDB_pdID") &"'"
                                    set SaldoAwal = KartuStok_CMD.execute

                                    KartuStok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_SAPDB.SAPDB_pdID, "& SAPDB_Pembelian &" FROM MKT_T_SAPDB LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_SAPDB.SAPDB_pdID = MKT_T_MaterialReceipt_D2.mm_pdID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MONTH(MKT_T_MaterialReceipt_H.mmTanggal) = '"& Bulan &"') and  MKT_T_SAPDB.SAPDB_pdID = '"& KartuStok("SAPDB_pdID") &"'"
                                    set Pembelian = KartuStok_CMD.execute

                                    KartuStok_CMD.commandText = "SELECT ISNULL(SUM(Perm_pdQty),0) AS Penjualan FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MONTH(PermTanggal) = '10') AND (YEAR(PermTanggal) = '2022') AND (Perm_pdID = '"& KartuStok("SAPDB_pdID") &"') "
                                    set Penjualan = KartuStok_CMD.execute
                                %>
                                <tr>
                                    <td> <%=Pembelian("mmTanggal")%> </td>
                                </tr>
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