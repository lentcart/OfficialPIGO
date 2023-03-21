<!--#include file="../../../../Connections/pigoConn.asp" -->
<!--#include file="../../../../UpdateLOG/UpdateLOG.asp"-->
<%
    bulan = request.Form("Bulan")
    tahun = request.Form("Tahun")

    MutasiBulanIniD = "MSCA_SaldoBln"&bulan&"D"
    MutasiBulanIniK = "MSCA_SaldoBln"&bulan&"K"

    set NeracaSaldo_cmd = server.createObject("ADODB.COMMAND")
	NeracaSaldo_cmd.activeConnection = MM_PIGO_String
    
    Tanggal = bulan&"-01-"&tahun
    
    NeracaSaldo_cmd.commandText = "select CONVERT(varchar,dateadd(d,-(day(dateadd(m,1,'"& Tanggal &"'))),dateadd(m,1,'"& Tanggal &"')),106) as tgl"
    set Periode = NeracaSaldo_cmd.execute

	NeracaSaldo_cmd.commandText = "SELECT CA_ID , CA_Name, CA_Jenis  FROM GL_M_ChartAccount WHERE CA_Type = 'D'  "
	set NeracaSaldo = NeracaSaldo_cmd.execute

    if bulan = "01" then 

        SA = "(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD) AS Debet,(GL_T_MutasiSaldoCA.MSCA_SaldoAwalK) AS Kredit  "

    else if bulan = "02" then 

        SA = "(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD+(MSCA_SaldoBln01D)-(MSCA_SaldoBln01K)) AS Debet, (GL_T_MutasiSaldoCA.MSCA_SaldoAwalK+(MSCA_SaldoBln01K)-(MSCA_SaldoBln01D)) AS Kredit "

    else if bulan = "3" then 
        SA = "(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD+(MSCA_SaldoBln01D+MSCA_SaldoBln02D)-(MSCA_SaldoBln01K+MSCA_SaldoBln02K)) AS Debet, (GL_T_MutasiSaldoCA.MSCA_SaldoAwalK+(MSCA_SaldoBln01K+MSCA_SaldoBln02K)-(MSCA_SaldoBln01D+MSCA_SaldoBln02D)) AS Kredit "
    else if bulan = "4" then
        SA = "(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD+(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D)-(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K)) AS Debet, (GL_T_MutasiSaldoCA.MSCA_SaldoAwalK+(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K)-(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D)) AS Kredit "
    else if bulan = "5" then 
        SA = "(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD+(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D)-(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K)) AS Debet, (GL_T_MutasiSaldoCA.MSCA_SaldoAwalK+(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K)-(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D)) AS Kredit "
    else if bulan = "6" then
        SA = "(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD+(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D)-(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K)) AS Debet, (GL_T_MutasiSaldoCA.MSCA_SaldoAwalK+(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K)-(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D)) AS Kredit "
    else if bulan = "7" then 
        SA = "(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD+(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D)-(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K)) AS Debet, (GL_T_MutasiSaldoCA.MSCA_SaldoAwalK+(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K)-(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D)) AS Kredit "
    else if bulan = "8" then
        SA = "(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD+(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D)-(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K)) AS Debet, (GL_T_MutasiSaldoCA.MSCA_SaldoAwalK+(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K)-(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D)) AS Kredit "
    else if bulan = "9" then 
        SA = "(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD+(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D+MSCA_SaldoBln08D)-(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K+MSCA_SaldoBln08K)) AS Debet, (GL_T_MutasiSaldoCA.MSCA_SaldoAwalK+(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K+MSCA_SaldoBln08K)-(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D+MSCA_SaldoBln08D)) AS Kredit "
    else if bulan = "10" then 

    else if bulan = "11" then 
    else 
    end if  end if   end if end if end if end if end if  end if  end if  end if  end if 

    Log_ServerID 	= "" 
    Log_Action   	= "PRINT"
    Log_Key         = "GL-Neraca Saldo"
    Log_Keterangan  = "Melakukan cetak (GL) Neraca Saldo Periode Bulan : "& bulan &" Tahun : "& tahun
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)
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
                <div class="row mt-3 mb-3 text-center" >
                    <div class="col-12">
                        <span class="text-judul-gl"> NERACA SALDO </span><br>
                        <span class="text-desc-gl"> PERIODE <b><%=Periode("tgl")%></b> </span><br>
                    </div>
                </div>

                <div class="row ">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed" style="font-size:11px; border:1px solid white;color:black">
                            <thead style="background-color:#eee">
                                <tr>
                                    <th class="text-center" rowspan = "2"> KODE ACC </th>
                                    <th class="text-center" rowspan = "2"> NAMA ACCOUNT</th>
                                    <th class="text-center" colspan = "2"> SALDO AWAL</th>
                                    <th class="text-center" colspan = "2"> MUTASI BULAN INI </th>
                                    <th class="text-center" colspan = "2"> MUTASI YTD </th>
                                    <th class="text-center" colspan = "2"> SALDO AKHIR </th>
                                </tr>
                                <tr>
                                    <th class="text-center" rowspan = "2">DEBET</th>
                                    <th class="text-center" rowspan = "2">KREDIT</th>
                                    <th class="text-center" rowspan = "2">DEBET</th>
                                    <th class="text-center" rowspan = "2">KREDIT</th>
                                    <th class="text-center" rowspan = "2">DEBET</th>
                                    <th class="text-center" rowspan = "2">KREDIT</th>
                                    <th class="text-center" rowspan = "2">DEBET</th>
                                    <th class="text-center" rowspan = "2">KREDIT</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% do while not NeracaSaldo.eof%>
                                <tr>
                                    <td> <%=NeracaSaldo("CA_ID")%> </td>
                                    <td class="text-start"> <%=NeracaSaldo("CA_Name")%> </td>
                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT "& SA &", GL_M_ChartAccount.CA_ID FROM GL_T_MutasiSaldoCA  LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID WHERE GL_T_MutasiSaldoCA.MSCA_CAID = '"& NeracaSaldo("CA_ID") &"' AND GL_T_MutasiSaldoCA.MSCA_Tahun = '"& Tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set SaldoAwal = NeracaSaldo_cmd.execute
                                        if SaldoAwal.eof = true then
                                            db = 0 
                                            kd = 0 
                                        else
                                        ' Saldo Normal
                                            if NeracaSaldo("CA_Jenis") = "D" then 
                                                SaldoDebet  = SaldoAwal("Debet")
                                                Saldokredit = 0
                                            else
                                                SaldoDebet  = 0
                                                Saldokredit = SaldoAwal("kredit")
                                            end if 
                                        ' Saldo Normal
                                        end if 
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(SaldoDebet),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Saldokredit),"$",""),".00","")%> </td>
                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(GL_T_MutasiSaldoCA."& MutasiBulanIniD &",0) AS Debet, ISNULL(GL_T_MutasiSaldoCA."& MutasiBulanIniK &",0) AS Kredit,GL_M_ChartAccount.CA_ID FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND GL_T_MutasiSaldoCA.MSCA_Tahun = '"& Tahun &"'  "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiBulanIni = NeracaSaldo_cmd.execute
                                        if MutasiBulanIni.eof = true then
                                            md = 0 
                                            mk = 0 
                                        else    
                                            md = MutasiBulanIni("Debet")
                                            mk = MutasiBulanIni("Kredit")
                                        end if 
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(md),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(mk),"$",""),".00","")%> </td>

                                    <% if Bulan = "1" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "2" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "3" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03D),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "4" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "5" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "6" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "7" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "8" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D+MSCA_SaldoBln08D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K+MSCA_SaldoBln08K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "9" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D+MSCA_SaldoBln08D+MSCA_SaldoBln09D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K+MSCA_SaldoBln08K+MSCA_SaldoBln09K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "10" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D+MSCA_SaldoBln08D+MSCA_SaldoBln09D+MSCA_SaldoBln10D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K+MSCA_SaldoBln08K+MSCA_SaldoBln09K+MSCA_SaldoBln10K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else if Bulan = "11" then %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D+MSCA_SaldoBln08D+MSCA_SaldoBln09D+MSCA_SaldoBln10D+MSCA_SaldoBln11D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K+MSCA_SaldoBln08K+MSCA_SaldoBln09K+MSCA_SaldoBln10K+MSCA_SaldoBln11K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% else %>

                                    <%
                                        NeracaSaldo_cmd.commandText = "SELECT ISNULL(SUM(MSCA_SaldoBln01D+MSCA_SaldoBln02D+MSCA_SaldoBln03D+MSCA_SaldoBln04D+MSCA_SaldoBln05D+MSCA_SaldoBln06D+MSCA_SaldoBln07D+MSCA_SaldoBln08D+MSCA_SaldoBln09D+MSCA_SaldoBln10D+MSCA_SaldoBln11D+MSCA_SaldoBln12D),0) as Debet, ISNULL(SUM(MSCA_SaldoBln01K+MSCA_SaldoBln02K+MSCA_SaldoBln03K+MSCA_SaldoBln04K+MSCA_SaldoBln05K+MSCA_SaldoBln06K+MSCA_SaldoBln07K+MSCA_SaldoBln08K+MSCA_SaldoBln09K+MSCA_SaldoBln10K+MSCA_SaldoBln11K+MSCA_SaldoBln12K),0) as Kredit FROM GL_T_MutasiSaldoCA RIGHT OUTER JOIN GL_M_ChartAccount ON GL_T_MutasiSaldoCA.MSCA_CAID = GL_M_ChartAccount.CA_ID Where CA_ID = '"& NeracaSaldo("CA_ID") &"' AND MSCA_Tahun = '"& tahun &"' "
                                        'response.write NeracaSaldo_cmd.commandText
                                        set MutasiYTD = NeracaSaldo_cmd.execute
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Debet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(MutasiYTD("Kredit")),"$",""),".00","")%> </td>

                                    <% end if %><% end if %><% end if %><% end if %><% end if %><% end if %><% end if %><% end if %><% end if %><% end if %><% end if %>


                                    <%
                                        SaldoAkhirDebet     = SaldoDebet + md - mk
                                        SaldoAkhirKredit    = SaldoKredit 
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(SaldoAkhirDebet),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(SaldoAkhirKredit),"$",""),".00","")%> </td>
                                    
                                </tr>
                            <% NeracaSaldo.movenext
                            loop%>
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