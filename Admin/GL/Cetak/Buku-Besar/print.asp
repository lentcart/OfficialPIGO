<!--#include file="../../../../Connections/pigoConn.asp" -->
<!--#include file="../../../../UpdateLOG/UpdateLOG.asp"-->

<%
    tgla        = Cdate(request.Form("tgla"))
    tgle        = Cdate(request.Form("tgle"))
    ACID1       = request.Form("ACID1")
    ACID2       = request.Form("ACID2")
    Kategori    = request.Form("Kategori")
    'response.write Kategori

    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and JR_Tanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Account_cmd = server.createObject("ADODB.COMMAND")
	Account_cmd.activeConnection = MM_PIGO_String
    if Kategori = "1" then 
        if ACID1 = "" and ACID2 = "" then
            Account_cmd.commandText = "SELECT GL_M_ChartAccount.CA_ID, GL_M_ChartAccount.CA_Name, 0 as SaldoAwalDebet, 0 as SaldoAwalKredit FROM GL_T_Jurnal_H LEFT OUTER JOIN GL_T_Jurnal_D ON GL_T_Jurnal_H.JR_ID = LEFT(GL_T_Jurnal_D.JRD_ID, 12) FULL OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE JR_Tanggal BETWEEN '"& tgla &"' and '"& tgle &"'   GROUP BY  GL_M_ChartAccount.CA_Name, GL_M_ChartAccount.CA_ID ORDER BY GL_M_ChartAccount.CA_ID "
            'response.write Account_cmd.commandText
            set Account = Account_cmd.execute
        else 
            Account_cmd.commandText = "SELECT GL_M_ChartAccount.CA_ID, GL_M_ChartAccount.CA_Name, 0 as SaldoAwalDebet, 0 as SaldoAwalKredit FROM GL_T_Jurnal_H LEFT OUTER JOIN GL_T_Jurnal_D ON GL_T_Jurnal_H.JR_ID = LEFT(GL_T_Jurnal_D.JRD_ID, 12) FULL OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE JRD_CA_ID BETWEEN '"& ACID1 &"' and '"& ACID2 &"' "& filterTanggal &"  GROUP BY  GL_M_ChartAccount.CA_Name, GL_M_ChartAccount.CA_ID ORDER BY GL_M_ChartAccount.CA_ID"
            'response.write Account_cmd.commandText
            set Account = Account_cmd.execute
        end if 
    else 
        if ACID1 = "" and ACID2 = "" then
            Account_cmd.commandText = "SELECT GL_M_ChartAccount.CA_ID,GL_M_ChartAccount.CA_ID, GL_M_ChartAccount.CA_Name, 0 as SaldoAwalDebet, 0 as SaldoAwalKredit FROM GL_M_ChartAccount RIGHT OUTER JOIN GL_T_Jurnal_D ON GL_M_ChartAccount.CA_ID = GL_T_Jurnal_D.JRD_CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID WHERE JRD_CA_ID BETWEEN '"& ACID1 &"' and '"& ACID2 &"' "& filterTanggal &" GROUP BY GL_M_ChartAccount.CA_ID, GL_M_ChartAccount.CA_Name,GL_M_ChartAccount.CA_ID ORDER BY GL_M_ChartAccount.CA_ID ASC  "
            'response.write Account_cmd.commandText
            set Account = Account_cmd.execute
        else
            Account_cmd.commandText = "SELECT GL_M_ChartAccount.CA_ID,GL_M_ChartAccount.CA_ID, GL_M_ChartAccount.CA_Name, 0 as SaldoAwalDebet, 0 as SaldoAwalKredit FROM GL_M_ChartAccount RIGHT OUTER JOIN GL_T_Jurnal_D ON GL_M_ChartAccount.CA_ID = GL_T_Jurnal_D.JRD_CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID WHERE JR_Tanggal BETWEEN '"& tgla &"' and '"& tgle &"' GROUP BY GL_M_ChartAccount.CA_ID, GL_M_ChartAccount.CA_Name,GL_M_ChartAccount.CA_ID ORDER BY GL_M_ChartAccount.CA_ID ASC  "
            'response.write Account_cmd.commandText
            set Account = Account_cmd.execute
        end if 
    end if

    Log_ServerID 	= "" 
    Log_Action   	= "PRINT"
    Log_Key         = "GL-Buku Besar"
    Log_Keterangan  = "Melakukan cetak (GL) Buku Besar Periode"& tgla &" s.d "& tgle
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
        document.title = "GeneralLedger-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
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
                        <span class="text-judul-gl"> GENERAL LEDGER </span><br>
                        <span class="text-desc-gl"> PERIODE <b><%=tgla%></b> s.d <b><%=tgle%></b> </span><br>
                    </div>
                </div>

                <div class="row ">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed" style="font-size:11px; border:1px solid white;color:black">
                            <thead style="background-color:#eee">
                                <tr class="text-center">
                                    <th> TANGGAL </th>
                                    <th> NO JURNAL </th>
                                    <th class="p-0"> KETERANGAN </th>
                                    <th> DEBET </th>
                                    <th> KREDIT </th>
                                    <th> SALDO </th>
                                </tr>
                            </thead>
                            <tbody>
                            <% do while not Account.eof %>
                                <tr style="font-weight:bold">
                                    <td class="text-center"> <%=Account("CA_ID")%> </td>
                                    <td><%=Account("CA_Name")%> </td>
                                    <td class="text-end"> SALDO AWAL :  </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Account("SaldoAwalDebet")),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Account("SaldoAwalKredit")),"$",""),".00","")%> </td>
                                <tr>
                                <%
                                    Account_cmd.commandText = "SELECT GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_D.JRD_Debet, GL_T_Jurnal_D.JRD_Kredit, GL_T_Jurnal_D.JRD_Keterangan FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID, 12) = GL_T_Jurnal_H.JR_ID WHERE GL_T_Jurnal_D.JRD_CA_ID = '"& Account("CA_ID") &"'  "& filterTanggal &" ORDER BY GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_ID ASC "
                                    'response.write Account_cmd.commandText
                                    set Detail = Account_cmd.execute
                                %>
                                <% do while not Detail.eof %>
                                <tr>
                                    <td class="text-center"> 
                                        <%=Day(CDate(Detail("JR_Tanggal")))%>/<%=Month(CDate(Detail("JR_Tanggal")))%>/<%=Year(CDate(Detail("JR_Tanggal")))%> 
                                    </td>
                                    <td class="text-center"> <%=Detail("JR_ID")%> </td>
                                    <td> <%=Detail("JRD_Keterangan")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Detail("JRD_Debet")),"$",""),".00","")%></td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Detail("JRD_Kredit")),"$",""),".00","")%></td>
                                    <%
                                        TotalDebet  = TotalDebet    +  Detail("JRD_Debet") 
                                        TotalKredit = TotalKredit   +  Detail("JRD_Kredit")
                                        
                                    %>
                                <tr>
                                <% Detail.movenext
                                loop %>
                                <%
                                    Debet           = TotalDebet +  Account("SaldoAwalDebet") 
                                    Kredit          = TotalKredit +  Account("SaldoAwalKredit") 
                                    SaldoAkhir      = Debet - Kredit
                                %>
                                <tr style="font-weight:bold;background-color:#eee; color:black">
                                    <td class="text-end" colspan="3"> SALDO AKHIR :  </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Debet),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Kredit),"$",""),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(SaldoAkhir),"$",""),".00","")%> </td>
                                <tr>
                                    <%
                                        SubKredit  = SubKredit + TotalKredit
                                        TotalKredit = 0 
                                        SubDebet  = SubDebet + TotalDebet
                                        TotalDebet = 0 
                                        TotalSaldoAkhir  = TotalSaldoAkhir + SaldoAkhir
                                        SaldoAkhir = 0 
                                    %>
                            <% Account.movenext
                            loop %>
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