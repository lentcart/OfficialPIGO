<!--#include file="../../../../Connections/pigoConn.asp" -->
<!--#include file="../../../../UpdateLOG/UpdateLOG.asp"-->
<%
    bulan = request.Form("Bulan")
    tahun = request.Form("Tahun")

    MutasiBulanIniD = "MSCA_SaldoBln"&bulan&"D"
    MutasiBulanIniK = "MSCA_SaldoBln"&bulan&"K"

    set NeracaSaldo_cmd = server.createObject("ADODB.COMMAND")
	NeracaSaldo_cmd.activeConnection = MM_PIGO_String

	NeracaSaldo_cmd.commandText = "select CONVERT(varchar,dateadd(d,-(day(dateadd(m,1,getdate()))),dateadd(m,1,getdate())),106) as tgl"
	set Periode = NeracaSaldo_cmd.execute

	NeracaSaldo_cmd.commandText = "SELECT CA_ID , CA_Name FROM GL_M_ChartAccount WHERE CA_Type = 'D'  "
	set NeracaSaldo = NeracaSaldo_cmd.execute

    Log_ServerID 	= "" 
    Log_Action   	= "PRINT"
    Log_Key         = "GL-Laporan Ekuitas"
    Log_Keterangan  = "Melakukan cetak (GL) Laporan Ekuitas Periode Bulan : "& bulan &" Tahun : "& tahun
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> OFFICIAL PIGO </title>

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
        document.title = "NeracaSaldo-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
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
        .text-judul-gl{
            font-size:24px;
            font-weight:bold;
            color:black;
        }
        .text-desc-gl{
            font-size:13px;
            font-weight:500;
            color:black;
        }
        .table td, table th {
        text-align: center;
        vertical-align: center;
        }
    </style>
    </head>
<body>  
    <div class="book">
        <div class="page">
            <div class="subpage">
                <div class="row">
                    <div class="col-11">
                        <span class="text-judul-gl"> PT. PERKASA INDAH GEMILANG OETAMA </span><br>
                        <span class="text-desc-gl"> Jalan Alternatif Cibubur, Cimangis, Depok – Jawa Barat</span><br>
                        <span class="text-desc-gl"> oficial@otopigo.com</span><br>
                        <span class="text-desc-gl"> 0881-8808-8088</span><br>
                    </div>
                    <div class="col-1">
                        <img src="<%=base_url%>/assets/logo/3.png" class="logo me-3" alt="" width="65" height="85" />
                    </div>
                </div>
                <div class="row mt-3 mb-3" >
                    <div class="col-12">
                        <span class="text-desc-gl"><b> LAPORAN PERUBAHAN EKUITAS </b></span><br>
                        <span class="text-desc-gl" style="font-size:11px"> Untuk Tahun yang Berakhir Pada Tanggal 30 November <%=tahun%> </span><br>
                        <span class="text-desc-gl" style="font-size:11px"> (Dinyatakan dalam satuan Rupiah) </span><br>
                    </div>
                </div>

                <div class="row ">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed" style="font-size:11px; border:1px solid white;color:black">
                            <thead style="background-color:#eee">
                                <tr>
                                    <th class="text-center"> MODAL SAHAM </th>
                                    <th class="text-center"> PENGUKURAN KEMBALI IMBALAN PASCA KERJA </th>
                                    <th class="text-center"> SALDO LABA (RUGI) </th>
                                    <th class="text-center"> MODAL SAHAM HIBAH </th>
                                    <th class="text-center"> JUMLAH EKUITAS </th>
                                </tr>
                            </thead>
                            <tbody>
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