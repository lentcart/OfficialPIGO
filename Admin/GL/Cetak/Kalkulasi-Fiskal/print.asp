<!--#include file="../../../../Connections/pigoConn.asp" -->
<!--#include file="../../../../UpdateLOG/UpdateLOG.asp"-->
<%
    FTID        = request.queryString("FTID")

    set KalkulasiFiskal_CMD = server.createObject("ADODB.COMMAND")
	KalkulasiFiskal_CMD.activeConnection = MM_PIGO_String
    KalkulasiFiskal_CMD.commandText = "SELECT * FROM GL_T_Fiskal_H WHERE FT_ID = '"& FTID &"' "
    set KalkulasiFiskal = KalkulasiFiskal_CMD.execute

    Log_ServerID 	= "" 
    Log_Action   	= "PRINT"
    Log_Key         = "GL-Kalkulasi Fiskal"
    Log_Keterangan  = "Melakukan cetak (GL) Kalkulasi Fiskal KODE FTID : "& FTID 
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
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
        var today = new Date();

        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
            // window.print();
            document.title = "KalkulasiFiskal-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";
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
    <div class="book">
        <div class="page">
            <div class="subpage">
            <div class="row mt-1 align-items-center">
                <div class="col-12">
                    <span class="cont-text" style="font-size:17px"><b> PERHITUNGAN LABA/RUGI FISKAL - <%=MonthName(KalkulasiFiskal("FT_Bulan"))%> &nbsp; <%=KalkulasiFiskal("FT_Tahun")%></b></span><br><br>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed" style="font-size:12px; border:1px solid white;color:black;">
                    <% do while not KalkulasiFiskal.eof %>
                        <tr>
                            <td colspan="3"><b> LABA (RUGI) HASIL USAHA </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(KalkulasiFiskal("FT_NilaiHasilUsaha")),"$","Rp. "),".00","")%> </b></td>
                        </tr>
                        <tr>
                            <td colspan="4"><b> KOREKSI: </b></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td colspan="2"><b> 1. Koreksi Negatif </b></td>
                        </tr>
                        <%
                            KalkulasiFiskal_CMD.commandText = "SELECT GL_T_Fiskal_H.FT_ID, GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi,GL_T_Fiskal_D.FTD_Value FROM GL_T_Fiskal_H LEFT OUTER JOIN GL_M_Fiskal_H LEFT OUTER JOIN GL_M_Fiskal_D ON GL_M_Fiskal_H.FM_ID = GL_M_Fiskal_D.FMD_ID RIGHT OUTER JOIN GL_T_Fiskal_D ON GL_M_Fiskal_H.FM_ID = GL_T_Fiskal_D.FM_ID ON GL_T_Fiskal_H.FT_ID = GL_T_Fiskal_D.FTD_ID WHERE FT_ID = '"& FTID &"' AND  FM_JenisKoreksi = 'N'  GROUP BY GL_T_Fiskal_H.FT_ID, GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi,GL_T_Fiskal_D.FTD_Value "
                            set KoreksiNegatif = KalkulasiFiskal_CMD.execute
                        %>
                        <% do while not KoreksiNegatif.eof%>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><%=KoreksiNegatif("FM_Nama")%></td>
                            <td class="text-end"><%=Replace(Replace(FormatCurrency(Round(KoreksiNegatif("FTD_Value"))),"$","Rp. "),".00","")%></td>
                            <% TotalKN = Round(TotalKN + KoreksiNegatif("FTD_Value"))%>
                        </tr>
                        <% KoreksiNegatif.movenext
                        loop %>
                        <tr>
                            <td></td>
                            <td colspan="2"><b> Jumlah Koreksi Negatif </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(TotalKN),"$","Rp. "),".00","")%></b></td>
                        </tr>
                        <tr>
                            <td> </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td colspan="2"><b> 2. Koreksi Positif </b></td>
                        </tr>
                        <%
                            KalkulasiFiskal_CMD.commandText = "SELECT GL_T_Fiskal_H.FT_ID, GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi,GL_T_Fiskal_D.FTD_Value FROM GL_T_Fiskal_H LEFT OUTER JOIN GL_M_Fiskal_H LEFT OUTER JOIN GL_M_Fiskal_D ON GL_M_Fiskal_H.FM_ID = GL_M_Fiskal_D.FMD_ID RIGHT OUTER JOIN GL_T_Fiskal_D ON GL_M_Fiskal_H.FM_ID = GL_T_Fiskal_D.FM_ID ON GL_T_Fiskal_H.FT_ID = GL_T_Fiskal_D.FTD_ID WHERE FT_ID = '"& FTID &"' AND  FM_JenisKoreksi = 'P'  GROUP BY GL_T_Fiskal_H.FT_ID, GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi,GL_T_Fiskal_D.FTD_Value "
                            set KoreksiPositif = KalkulasiFiskal_CMD.execute
                        %>
                        <% do while not KoreksiPositif.eof%>
                        <tr>
                            <td></td>
                            <td></td>
                            <td> <%=KoreksiPositif("FM_Nama")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(KoreksiPositif("FTD_Value")),"$","Rp. "),".00","")%> </td>
                            <% TotalKP = Round(TotalKP + KoreksiPositif("FTD_Value"))%>
                        </tr>
                        <% KoreksiPositif.movenext
                        loop %>
                        <tr>
                            <td></td>
                            <td colspan="2"><b> Jumlah Koreksi Positif </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(TotalKP),"$","Rp. "),".00","")%></b></td>
                        </tr>
                        <%
                            LabaRugiFiskal = Round(KalkulasiFiskal("FT_NilaiHasilUsaha")- TotalKN + TotalKP)
                        %>
                        <tr>
                            <td colspan="3"><b> LABA RUGI FISKAL </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(LabaRugiFiskal),"$","Rp. "),".00","")%></b></td>
                        </tr>
                        <tr>
                            <td colspan="3"><b> DPP PPh Psl.25/29 </b></td>
                            <td class="text-end"><b><%=Replace(Replace(FormatCurrency(KalkulasiFiskal("FT_DPP")),"$","Rp. "),".00","")%></b></td>
                        </tr>
                        <tr>
                            <td colspan="3"><b> KOMPENSASI KERUGIAN </b></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td colspan="2"><b> Kompensasi Kerugian Tahun Fiskal <%=KalkulasiFiskal("FT_Tahun")%> </b></td>
                            <td class="text-end"><%=Replace(Replace(FormatCurrency(KalkulasiFiskal("FT_Kompensasi")),"$","Rp. "),".00","")%></td>
                        </tr>
                        <%
                            PajakFiskal = KalkulasiFiskal("FT_DPP") - KalkulasiFiskal("FT_Kompensasi")
                        %>
                        <tr>
                            <td colspan="3"><b> Laba (Rugi) Usaha menurut Pajak/Fiskal (Setelah Kompensasi Kerugian Fiskal) </b></td>
                            <td class="text-end"><b><%=Replace(Replace(FormatCurrency(PajakFiskal),"$","Rp. "),".00","")%></b></td>
                        </tr>
                        <%

                            'Pajak Penghasilan
                                set LabaRugi_CMD = server.createObject("ADODB.COMMAND") 
                                LabaRugi_CMD.activeConnection = MM_PIGO_String

                                FT_Bulan = "10"
                                'DEBET

                                    if FT_Bulan = "1" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D"
                                    else if FT_Bulan = "2" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D"
                                    else if FT_Bulan = "3" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D "
                                    else if FT_Bulan = "4" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D "
                                    else if FT_Bulan = "5" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D "
                                    else if FT_Bulan = "6" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D "
                                    else if FT_Bulan = "7" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D "
                                    else if FT_Bulan = "8" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D"
                                    else if FT_Bulan = "9" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D "
                                    else if FT_Bulan = "10" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D + MSCA_SaldoBln10D "
                                    else if FT_Bulan = "11" then 
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D + MSCA_SaldoBln10D + MSCA_SaldoBln11D"
                                    else
                                        MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D + MSCA_SaldoBln10D + MSCA_SaldoBln11D + MSCA_SaldoBln12D"
                                    end if end if end if end if end if end if end if end if end if end if end if 

                                'DEBET

                                'KREDIT

                                    if FT_Bulan = "1" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K"
                                    else if FT_Bulan = "2" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K"
                                    else if FT_Bulan = "3" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K "
                                    else if FT_Bulan = "4" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K "
                                    else if FT_Bulan = "5" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K "
                                    else if FT_Bulan = "6" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K "
                                    else if FT_Bulan = "7" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K "
                                    else if FT_Bulan = "8" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K"
                                    else if FT_Bulan = "9" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K "
                                    else if FT_Bulan = "10" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K + MSCA_SaldoBln10K "
                                    else if FT_Bulan = "11" then 
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K + MSCA_SaldoBln10K + MSCA_SaldoBln11K"
                                    else
                                        MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K + MSCA_SaldoBln10K + MSCA_SaldoBln11K + MSCA_SaldoBln12K"
                                    end if end if end if end if end if end if end if end if end if end if end if 

                                'KREDIT

                                LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID = 'D100.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
                                set Pendapatan = LabaRugi_CMD.execute

                                TotalPendapatan =  Pendapatan("SaldoKredit") - Pendapatan("SaldoDebet") 

                                if PajakFiskal < 0 then
                                    PajakPenghasilan = 0
                                else
                                    if TotalPendapatan < 4800000000 then

                                        PajakPenghasilan = round(DPP*(22/100*50/100))

                                    else if TotalPendapatan > 4800000000 then

                                        PajakPenghasilan = round(4800000000/22/100*KalkulasiFiskal("FT_NilaiHasilUsaha"))

                                    else 

                                        PajakPenghasilan = round(22/100*KalkulasiFiskal("FT_NilaiHasilUsaha"))

                                    end if end if
                                end if 
                            'Pajak Penghasilan
                        %>
                        <tr>
                            <td colspan="3"><b> PAJAK PENGHASILAN </b></td>
                            <td class="text-end"><b><%=Replace(Replace(FormatCurrency(KalkulasiFiskal("FT_PajakPenghasilan")),"$","Rp. "),".00","")%></b></td>
                        </tr>
                        <tr>
                            <td colspan="3"><b> PERHITUNGAN PPh Psl.25/29 YANG TERUTANG </b></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td colspan="2"><b> Kredit Pajak </b></td>
                        </tr>
                        <%
                            KalkulasiFiskal_CMD.commandText = "SELECT GL_T_Fiskal_H.FT_ID, GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi,GL_T_Fiskal_D.FTD_Value FROM GL_T_Fiskal_H LEFT OUTER JOIN GL_M_Fiskal_H LEFT OUTER JOIN GL_M_Fiskal_D ON GL_M_Fiskal_H.FM_ID = GL_M_Fiskal_D.FMD_ID RIGHT OUTER JOIN GL_T_Fiskal_D ON GL_M_Fiskal_H.FM_ID = GL_T_Fiskal_D.FM_ID ON GL_T_Fiskal_H.FT_ID = GL_T_Fiskal_D.FTD_ID WHERE FT_ID = '"& FTID &"' AND  FM_JenisKoreksi = 'K'  GROUP BY GL_T_Fiskal_H.FT_ID, GL_M_Fiskal_H.FM_Nama, GL_M_Fiskal_H.FM_JenisKoreksi,GL_T_Fiskal_D.FTD_Value "
                            set KreditPajak = KalkulasiFiskal_CMD.execute
                        %>
                        <% do while not KreditPajak.eof%>
                        <tr>
                            <td></td>
                            <td></td>
                            <td> <%=KreditPajak("FM_Nama")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(KreditPajak("FTD_Value")),"$","Rp. "),".00","")%> </td>
                            <% TotalKRP = Round(TotalKRP + KreditPajak("FTD_Value"))%>
                        </tr>
                        
                        <% KreditPajak.movenext
                        loop %>
                        <tr>
                            <td></td>
                            <td colspan="2"><b> Jumlah Kredit Pajak </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(TotalKRP),"$","Rp. "),".00","")%></b></td>
                        </tr>
                        <%
                            PajakTerhutang = KalkulasiFiskal("FT_PajakPenghasilan") - TotalKRP
                        %>
                        <tr>
                            <td></td>
                            <td colspan="2"><b> PPh Psl.29 yang terutang (Pajak Dibyr Dimuka) </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(PajakTerhutang),"$","Rp. "),".00","")%> </b></td>
                        </tr>
                    <% KalkulasiFiskal.movenext
                    loop %>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>