<!--#include file="../../../../Connections/pigoConn.asp" -->
<!--#include file="../../../../UpdateLOG/UpdateLOG.asp"-->
<%
    bulan       = request.Form("bulan")
    tahun       = request.Form("tahun")
    Tanggal = bulan&"-01-"&tahun

    MutasiBulanIniD = "MSCA_SaldoBln"&bulan&"D"
    MutasiBulanIniK = "MSCA_SaldoBln"&bulan&"K"

    set LabaRugi_CMD = server.createObject("ADODB.COMMAND")
	LabaRugi_CMD.activeConnection = MM_PIGO_String
			
	LabaRugi_CMD.commandText = "select CONVERT(varchar,dateadd(d,-(day(dateadd(m,1,'"& Tanggal &"'))),dateadd(m,1,'"& Tanggal &"')),106) as tgl"
	set Periode = LabaRugi_CMD.execute

	LabaRugi_CMD.commandText = "SELECT CA_ID , CA_Name FROM GL_M_ChartAccount WHERE CA_Type = 'D'  "
	set Acc = LabaRugi_CMD.execute

    'DEBET

        if bulan = "1" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D"
        else if bulan = "2" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D"
        else if bulan = "3" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D "
        else if bulan = "4" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D "
        else if bulan = "5" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D "
        else if bulan = "6" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D "
        else if bulan = "7" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D "
        else if bulan = "8" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D"
        else if bulan = "9" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D "
        else if bulan = "10" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D + MSCA_SaldoBln10D "
        else if bulan = "11" then 
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D + MSCA_SaldoBln10D + MSCA_SaldoBln11D"
        else
            MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D + MSCA_SaldoBln10D + MSCA_SaldoBln11D + MSCA_SaldoBln12D"
        end if end if end if end if end if end if end if end if end if end if end if 

    'DEBET

    'KREDIT

        if bulan = "1" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K"
        else if bulan = "2" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K"
        else if bulan = "3" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K "
        else if bulan = "4" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K "
        else if bulan = "5" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K "
        else if bulan = "6" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K "
        else if bulan = "7" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K "
        else if bulan = "8" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K"
        else if bulan = "9" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K "
        else if bulan = "10" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K + MSCA_SaldoBln10K "
        else if bulan = "11" then 
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K + MSCA_SaldoBln10K + MSCA_SaldoBln11K"
        else
            MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K + MSCA_SaldoBln10K + MSCA_SaldoBln11K + MSCA_SaldoBln12K"
        end if end if end if end if end if end if end if end if end if end if end if 

    'KREDIT

    Log_ServerID 	= "" 
    Log_Action   	= "PRINT"
    Log_Key         = "GL-Laba Rugi"
    Log_Keterangan  = "Melakukan cetak (GL) Laba Rugi Periode Bulan : "& bulan &" Tahun : "& tahun
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
    <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script>
        var today = new Date();

        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
            document.title = "Laba/Rugi-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";
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
        .inp-labarugi-h{
            width:8rem;
            border:none;
            border-bottom:1px solid black;
            font-weight:bold;
        }
        .inp-labarugi-d{
            width:8rem;
            border:none;
            border-bottom:1px solid black;
        }
        input:hover{
            background-color:white;
            color:black;
        }
        input:read-only {
            background-color:white;
            color:black;
        }
        table{
            padding:0px;
            font-size:13px;
        }
        hr{
            border:2px solid black;
        }
    </style>
    </head>
<body>  
    <div class="book">
        <div class="page">
            <div class="subpage">
            <!--#include file="../../../HeaderPIGO.asp"-->
            <br>
            <div class="row  align-items-center">
                <div class="col-12">
                    <span class="cont-text" style="font-size:18px"><b> LAPORAN LABA RUGI DAN KOMPREHENSIF LAIN </b></span><br>
                    <span class="cont-text" style="font-size:12px"><i> ( Dinyatakan Dalam Satuan Rupiah ) </i></span>
                </div>
            </div>
            <table style="width:100%">
                <tr>
                    <th class="text-center"class=" me-4" style="width:35rem"></th>
                    <th class="text-center"style="width:5rem"> CATATAN </th>
                    <th class="text-center"style="width:6rem">  <%=Periode("tgl")%> </th>
                </tr>
                <tr>
                    <td><br></td>
                </tr>
                <!-- PENDAPATAN -->
                <tr>
                    <td class=" me-4" style="width:35rem"><b> Pendapatan, Bersih </b></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <% 
                        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID = 'D100.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
                        set Pendapatan = LabaRugi_CMD.execute
                        ' if Pendapatan("CA_Jenis") = "D" then
                        '     TotalPendapatan =  Pendapatan("SaldoDebet")  - Pendapatan("SaldoKredit")
                        ' else 
                        ' end if 
                        TotalPendapatan =  Pendapatan("SaldoKredit") - Pendapatan("SaldoDebet") 
                    %>
                    
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(TotalPendapatan),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <!-- PENDAPATAN -->
                <tr>
                    <td><br></td>
                </tr>
                <!-- HPP -->
                <tr>
                    <td class=" me-4" style="width:35rem"><b> Harga Pokok Penjualan </b></td>   
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <% 
                        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID = 'E100.00.00') AND MSCA_Tahun = '"& tahun &"' GROUP BY GL_M_ChartAccount.CA_Jenis"
                        'response.write LabaRugi_CMD.commandText
                        set HPP = LabaRugi_CMD.execute

                        if HPP("CA_Jenis") = "D" then
                            TotalHPP =  HPP("SaldoDebet")  - HPP("SaldoKredit")
                        else 
                            TotalHPP =  HPP("SaldoKredit") - HPP("SaldoDebet") 
                        end if 
                    %>
                    
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(TotalHPP),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <% 
                        LabaKotor = TotalPendapatan-TotalHPP
                    %>
                    <td class="me-4" style="width:35rem"><b> Laba Kotor </b></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>                    
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(LabaKotor),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <!-- HPP -->
                <tr>
                    <td><br></td>
                </tr>
                <!-- BEBAN USAHA -->
                <tr>
                    <td class="me-4" style="width:35rem"><b> Beban Usaha </b></td>
                </tr>
                <tr>
                    <td class="me-4" style="width:35rem; padding: 0px 20px">Beban Marketing & Promosi</td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <% 
                        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID BETWEEN  'F100.00.00' AND 'F114.00.00') AND (GL_M_ChartAccount.CA_Kelompok = '06') GROUP BY GL_M_ChartAccount.CA_Jenis"
                        set BMP = LabaRugi_CMD.execute
                        if BMP("CA_Jenis") = "D" then
                            TotalBMP =  BMP("SaldoDebet")  - BMP("SaldoKredit")
                        else 
                            TotalBMP =  BMP("SaldoKredit") - BMP("SaldoDebet") 
                        end if 
                    %>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-d" value="<%=Replace(Replace(FormatCurrency(TotalBMP),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <td class="me-4" style="width:35rem; padding: 0px 20px">Beban Umum dan Administrasi</td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <% 
                        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID BETWEEN  'G100.00.00' AND 'G120.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
                        set BAU = LabaRugi_CMD.execute
                        if BAU("CA_Jenis") = "D" then
                            TotalBAU =  BAU("SaldoDebet")  - BAU("SaldoKredit")
                        else 
                            TotalBAU =  BAU("SaldoKredit") - BAU("SaldoDebet") 
                        end if 
                    %>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-d" value="<%=Replace(Replace(FormatCurrency(TotalBAU),"$",""),".00","")%>"></b>
                    </td>
                    <%
                        BebanUsaha = TotalBMP+TotalBAU
                    %>
                </tr>
                <tr>
                    <td class="me-4" style="width:35rem"><b> Laba (Rugi) Usaha </b></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <% 
                        LabaRugiUsaha = LabaKotor + BebanUsaha
                    %>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(LabaRugiUsaha),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <!-- BEBAN USAHA -->
                <tr>
                    <td><br></td>
                </tr>
                <!-- PENDAPATAN LAIN LAIN -->
                <tr>
                    <td class="me-4" style="width:35rem"><b> Pendapatan dan (Beban) lain-lain </b></td>
                </tr>
                <tr>
                    <td class="me-4" style="width:35rem; padding: 0px 20px">Pendapatan Lain-Lain</td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <% 
                        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID = 'G121.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
                        set PLL = LabaRugi_CMD.execute
                        if PLL("CA_Jenis") = "D" then
                            TotalPLL =  PLL("SaldoDebet")  - PLL("SaldoKredit")
                        else 
                            TotalPLL =  PLL("SaldoKredit") - PLL("SaldoDebet") 
                        end if 
                    %>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-d" value="<%=Replace(Replace(FormatCurrency(TotalPLL),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <td class="me-4" style="width:35rem; padding: 0px 20px">Beban Lain-Lain</td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <% 
                        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID = 'G123.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
                        set BLL = LabaRugi_CMD.execute
                        if BLL("CA_Jenis") = "D" then
                            TotalBLL =  BLL("SaldoDebet")  - BLL("SaldoKredit")
                        else 
                            TotalBLL =  BLL("SaldoKredit") - BLL("SaldoDebet") 
                        end if 
                    %>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-d" value="<%=Replace(Replace(FormatCurrency(TotalBLL),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <td class="me-4" style="width:35rem"></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <% 
                        TotalPBLL = TotalPLL+TotalBLL
                    %>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(TotalPBLL),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <!-- PENDAPATAN LAIN LAIN -->
                <tr>
                    <td><br></td>
                </tr>
                <!-- EBITDA -->
                <tr>
                    <%
                        EBITDA = LabaRugiUsaha+TotalPBLL
                    %>
                    <td class="me-4" style="width:35rem"><b> Laba (Rugi) Sebelum Bunga, Tax, Depreciation & Amortization (EBITDA) </b></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(EBITDA),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <td class="me-4" style="width:35rem; padding: 0px 20px">Depreciation/Amortization</td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-d" value="<%=Replace(Replace(FormatCurrency(0),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <td><br></td>
                </tr>
                <tr>
                    <%
                        EBIT = EBITDA-DA
                    %>
                    <td class="me-4" style="width:35rem"><b> Laba (Rugi) Bersih Sebelum By. Bunga & Pajak Penghasilan (EBIT) </b></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(EBIT),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <td class="me-4" style="width:35rem; padding: 0px 20px">Beban Bunga</td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-d" value="<%=Replace(Replace(FormatCurrency(0),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <td><br></td>
                </tr>
                <tr>
                    <%
                        EBT = EBIT-BebanBunga
                    %>
                    <td class="me-4" style="width:35rem"><b> Laba (Rugi) Bersih Sebelum Pajak Penghasilan (EBT) </b></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <td class="text-end" style="width:6rem">    
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(EBT),"$",""),".00","")%>"></b>
                    </td>
                </tr>

                <%
                        LabaRugi_CMD.commandText = "SELECT FT_ID, ISNULL(FT_PajakPenghasilan,0) AS PajakPenghasilan FROM GL_T_Fiskal_H WHERE FT_Tahun = '"& tahun &"' AND FT_Bulan = '"& bulan &"'"
                        response.write  LabaRugi_CMD.commandText
                        set PajakPenghasilan = LabaRugi_CMD.execute
                %>
                <tr>
                    <td class="me-4" style="width:35rem; padding: 0px 20px">Pajak Penghasilan</td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-d" value="<%=Replace(Replace(FormatCurrency(PajakPenghasilan("PajakPenghasilan")),"$",""),".00","")%>"></b>
                    </td>
                </tr>

                <tr>
                    <td class="me-4" style="width:35rem; padding: 0px 20px">Manfaat (Beban) Pajak Tangguhan</td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-d" value="<%=Replace(Replace(FormatCurrency(0),"$",""),".00","")%>"></b></td>
                </tr>
                <tr>
                    <td><br></td>
                </tr>
                <tr>
                    <%
                        EAT = EBT+PajakPenghasilan("PajakPenghasilan")+PajakTangguhan
                    %>
                    <td class="me-4" style="width:35rem"><b> Laba (Rugi) Bersih tahun berjalan (EAT) </b></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(EAT),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <td class="me-4" style="width:35rem"><b> Pendapatan (Beban) Komprehensif Lain </b></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <%
                        TotalPBKL = 0 
                    %>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(TotalPBKL),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <tr>
                    <%
                        TotalLBK = EAT-TotalPBKL
                    %>
                    <td class="me-4" style="width:35rem"><b> Jumlah Laba (Rugi) Komprehensif  </b></td>
                    <td class="text-center"style="width:5rem"><b> - </b></td>
                    <td class="text-end" style="width:6rem">
                        <b><input type="text" readonly class="text-end inp-labarugi-h" value="<%=Replace(Replace(FormatCurrency(TotalLBK),"$",""),".00","")%>"></b>
                    </td>
                </tr>
                <!-- EBITDA -->
            </table>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>