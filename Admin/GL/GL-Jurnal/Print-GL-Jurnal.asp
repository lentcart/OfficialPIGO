 <!--#include file="../../../Connections/pigoConn.asp" -->
 <!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->
<%
    Jurnal_Tgla     = Request.QueryString("Jurnal_Tgla")
    Jurnal_Tgle     = Request.QueryString("Jurnal_Tgle")
    Jurnal_Type     = Request.QueryString("Jurnal_Type")
    Jurnal_ID       = Request.QueryString("Jurnal_ID")

    set Jurnal_CMD = server.createObject("ADODB.COMMAND")
	Jurnal_CMD.activeConnection = MM_PIGO_String

    if Jurnal_ID = "" then 

        if Jurnal_Type = "" then 
            Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON GL_T_Jurnal_D.JRD_ID = GL_T_Jurnal_H.JR_ID WHERE JR_Tanggal BETWEEN '"& Jurnal_Tgla &"' AND '"& Jurnal_Tgle &"'  GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type ORDER BY JR_Tanggal ASC"
            set Jurnal = Jurnal_CMD.execute
        else
            Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON GL_T_Jurnal_D.JRD_ID = GL_T_Jurnal_H.JR_ID WHERE JR_Tanggal BETWEEN '"& Jurnal_Tgla &"' AND '"& Jurnal_Tgle &"'  AND JR_Type = '"& Jurnal_Type &"' GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type ORDER BY JR_Tanggal ASC"
            set Jurnal = Jurnal_CMD.execute
        end if 
        Log_ServerID 	= "" 
        Log_Action   	= "PRINT"
        Log_Key         = "GL-Laporan Jurnal"
        Log_Keterangan  = "Melakukan cetak (GL) Laporan Jurnal periode tanggal  : "& tgla &" s.d "& tgle &" dengan kategori : "& Kategori &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    else
    
        Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON GL_T_Jurnal_D.JRD_ID = GL_T_Jurnal_H.JR_ID WHERE JR_Tanggal BETWEEN '"& Jurnal_Tgla &"' AND '"& Jurnal_Tgle &"'  AND JR_ID LIKE '%"& Jurnal_ID &"%' GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type ORDER BY JR_Tanggal ASC"
    
        set Jurnal = Jurnal_CMD.execute

        Log_ServerID 	= "" 
        Log_Action   	= "PRINT"
        Log_Key         = "GL-Laporan Jurnal"
        Log_Keterangan  = "Melakukan cetak (GL) Laporan Jurnal ID "& Jurnal_ID &" periode tanggal  : "& tgla &" s.d "& tgle &" dengan kategori : "& Kategori &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)
        
    end if 

        
    
%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> Official PIGO </title>

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
        document.title = "Laporan-GeneralLedger-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
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
        .cont-tb{
            font-size:11px;
            border:1px solid white;
        }
    </style>
    </head>
<body>  
    <div class="book">
        <div class="page">
            <div class="subpage">
                <div class="row align-items-center">
                    <div class="col-11 text-start">
                        <span class="Judul-Merchant" style="font-size:20px; color:#0077a2"> <b>PT. PERKASA INDAH GEMILANG OETAMA</b></span><br>
                        <span class="txt-desc"> Jln. Alternatif Cibubur, Komplek Ruko Cibubur Point Automotiv Center Blok B No. 12B Cimangis,</span><span class="txt-desc"> Depok – Jawa Barat </span><br>
                        <span class="txt-desc"> otopigo.sekertariat@gmail.com </span><br>
                        <span class="txt-desc"> Telp : (021) 8459 6001 / 0811-8838-008 </span>
                                    
                    </div>
                    <div class="col-1">
                        <img src="<%=base_url%>/assets/logo/1.png" class="logo me-3" alt="" width="80" height="85" />
                    </div>
                </div>
                <div class="row text-center">
                    <div class="col-12">
                        <span style="font-size:20px;"> <b> LAPORAN JURNAL </b></span><br>
                        <span> Periode : <b> <%=DAY(CDate(Jurnal_Tgla))%>/<%=MONTH(CDate(Jurnal_Tgla))%>/<%=YEAR(CDate(Jurnal_Tgla))%>  s.d.  <%=DAY(CDate(Jurnal_Tgle))%>/<%=MONTH(CDate(Jurnal_Tgle))%>/<%=YEAR(CDate(Jurnal_Tgle))%> </b></span>
                    </div>
                </div>
                <div class="row mt-3 mb-3" style="border-bottom:4px solid black">
                
                </div>

                <div class="row mt-1">
                    <div class="col-12">
                        <table class="table cont-tb table-bordered table-condensed mt-1" >
                            <thead class="text-center">
                                <tr>
                                    <th> NO </th>
                                    <th> NO JURNAL </th>
                                    <th> TANGGAL </th>
                                    <th colspan="2"> KETERANGAN </th>
                                    <th colspan="2"> TYPE JURNAL </th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    no = 0 
                                    do while not Jurnal.eof
                                    no = no + 1
                                %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td class="text-center"> <%=Jurnal("JR_ID")%> </td>
                                    <td class="text-center"> <%=DAY(CDate(Jurnal("JR_Tanggal")))%>/<%=MONTH(CDate(Jurnal("JR_Tanggal")))%>/<%=YEAR(CDate(Jurnal("JR_Tanggal")))%> </td>
                                    <td class="" colspan="2"> <%=Jurnal("JR_Keterangan")%> </td>
                                    <% if Jurnal("JR_Type") = "K" then %>
                                    <td colspan="2" class="text-center"> Kas Keluar </td>
                                    <% else if Jurnal("JR_Type") = "T" then %>
                                    <td colspan="2" class="text-center"> Terima Kas </td>
                                    <% else %>
                                    <td colspan="2" class="text-center"> Memorial </td>
                                    <% end if %> <% end if %>
                                </tr>
                                <%
                                    Jurnal_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Name, GL_T_Jurnal_D.JRD_CA_ID, GL_T_Jurnal_D.JRD_Keterangan, GL_T_Jurnal_D.JRD_Debet, GL_T_Jurnal_D.JRD_Kredit FROM GL_T_Jurnal_D LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID WHERE        (GL_T_Jurnal_H.JR_Tanggal BETWEEN '"& Jurnal_Tgla &"' AND '"& Jurnal_Tgle &"') AND (GL_T_Jurnal_H.JR_ID = '"& Jurnal("JR_ID") &"' ) ORDER BY GL_T_Jurnal_H.JR_Tanggal"
                                    set JurnalDetail= Jurnal_CMD.execute
                                %>
                                <% 
                                    do while not JurnalDetail.eof
                                %>
                                <tr>
                                    <td  colspan="3" class="text-center"> <%=JurnalDetail("JRD_CA_ID")%> </td>
                                    <td> <%=JurnalDetail("CA_Name")%> </td>
                                    <td> <%=JurnalDetail("JRD_Keterangan")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(JurnalDetail("JRD_Debet")),"$","Rp. "),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(JurnalDetail("JRD_Kredit")),"$","Rp. "),".00","")%> </td>
                                    <%
                                        TotalDebet = TotalDebet + JurnalDetail("JRD_Debet")
                                        TotalKredit = TotalKredit + JurnalDetail("JRD_Debet")
                                    %>
                                </tr>
                                
                                <% 
                                    JurnalDetail.movenext
                                    loop
                                %>
                                <tr style="background-color:#aaa">
                                    <td  colspan="5" class="text-start"> SUBTOTAL </td>
                                    <td  class="text-end"> <%=Replace(Replace(FormatCurrency(TotalDebet),"$","Rp. "),".00","")%> </td>
                                    <td  class="text-end"> <%=Replace(Replace(FormatCurrency(TotalKredit),"$","Rp. "),".00","")%> </td>
                                </tr>
                                <%
                                    SubTotalDebet = SubTotalDebet + TotalDebet
                                    TotalDebet = 0 
                                    SubTotalKredit = SubTotalKredit + TotalKredit
                                    TotalKredit = 0 
                                %>
                                <% 
                                    Jurnal.movenext
                                    loop 
                                %>
                                <%
                                    GrandTotalDebet = GrandTotalDebet + SubTotalDebet
                                    GrandTotalKredit = GrandTotalKredit + SubTotalKredit
                                %>
                                <tr style="background-color:#aaa">
                                    <td  colspan="5" class="text-start"> GRANDTOTAL </td>
                                    <td  class="text-end"> <%=Replace(Replace(FormatCurrency(GrandTotalDebet),"$","Rp. "),".00","")%> </td>
                                    <td  class="text-end"> <%=Replace(Replace(FormatCurrency(GrandTotalKredit),"$","Rp. "),".00","")%> </td>
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
</html>