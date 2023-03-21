<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    bulan = request.queryString("bulan")
    tahun = request.queryString("tahun")

    MutasiBulanIniD = "MSCA_SaldoBln"&bulan&"D"
    MutasiBulanIniK = "MSCA_SaldoBln"&bulan&"K"

    Tanggal = bulan&"-01-"&tahun

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
%>
<table>
</table>
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
    </style>
    </head>
<body>  
    <div class="book">
        <div class="page">
            <div class="subpage">
            <div class="row mt-1 align-items-center">
                <div class="col-12">
                    <span class="cont-text" style="font-size:20px"><b> PT. PERKASA INDAH GEMILANG OETAMA </b></span><br>
                    <span class="cont-text" style="font-size:15px"> Laporan Laba Rugi Dan Komprehensif Lain </span><br>
                    <span class="cont-text" style="font-size:12px"> (Dinyatakan Dalam Satuan Rupiah) </span>
                </div>
            </div>
            <!--<div class="row mt-4">
                <div class="col-7">
                    <span>  </span>
                </div>
                <div class="col-2">
                    <span class="cont-text"><b> CATATAN </b></span>
                </div>
                <div class="text-center  col-3">
                    <span class="cont-text"><b> <%'=Periode("tgl")%> </b></span>
                </div>
            </div>-->
            <div class="row mt-2">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed" style="font-size:12px; border:1px solid white;color:black">
                            <thead>
                            <tr class="text-center">
                                <th></th>
                                <th> CATATAN </th>
                                <th> <%=Periode("tgl")%> </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><b> Pendapatan, Bersih </b></td>
                                <td>  </td>
                                <% 
                                    LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, SUM("& MSCA_SaldoBlnD &") AS SaldoDebet, SUM("& MSCA_SaldoBlnK &") AS SaldoKredit FROM GL_M_ChartAccount INNER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_ID = 'D100.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
                                    set Pendapatan = LabaRugi_CMD.execute
                                    if Pendapatan("CA_Jenis") = "D" then
                                        Total =  Pendapatan("SaldoDebet")  - Pendapatan("SaldoKredit")
                                    else 
                                        Total =  Pendapatan("SaldoKredit") - Pendapatan("SaldoDebet") 
                                    end if 
                                %>
                                <td class="text-end" style="border-bottom:1px solid black"> <%=Replace(Replace(FormatCurrency(Total),"$",""),".00","")%> </td>

                            </tr>
                                <td> Harga Pokok Penjualan </td>
                                <td>  </td>
                                <% 
                                    LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, SUM("& MSCA_SaldoBlnD &") AS SaldoDebet, SUM("& MSCA_SaldoBlnK &") AS SaldoKredit FROM GL_M_ChartAccount INNER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_ID = 'E100.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
                                    set Pendapatan = LabaRugi_CMD.execute
                                    if Pendapatan("CA_Jenis") = "D" then
                                        Total =  Pendapatan("SaldoDebet")  - Pendapatan("SaldoKredit")
                                    else 
                                        Total =  Pendapatan("SaldoKredit") - Pendapatan("SaldoDebet") 
                                    end if 
                                %>
                                <td class="text-end" style="border-bottom:1px solid black"> <%=Replace(Replace(FormatCurrency(Total),"$",""),".00","")%> </td>
                            </tr>
                            </tr>
                                <td> Laba Kotor </td>
                                <td>  </td>
                                <% 
                                    LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, SUM("& MSCA_SaldoBlnD &") AS SaldoDebet, SUM("& MSCA_SaldoBlnK &") AS SaldoKredit FROM GL_M_ChartAccount INNER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_ID = 'E100.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
                                    set Pendapatan = LabaRugi_CMD.execute
                                    
                                    if Pendapatan("CA_Jenis") = "D" then
                                        Total =  Pendapatan("SaldoDebet")  - Pendapatan("SaldoKredit")
                                    else 
                                        Total =  Pendapatan("SaldoKredit") - Pendapatan("SaldoDebet") 
                                    end if 
                                %>
                                <td class="text-end" style="border-bottom:1px solid black"> <%=Replace(Replace(FormatCurrency(Total),"$",""),".00","")%> </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-7">
                    <span class="cont-text"><b> Harga Pokok Penjualan </b></span><br>
                    <span class="cont-text"><b> Laba Kotor </b></span>
                </div>
                <div class="col-2">
                    <span>  </span>
                </div>
                <div class="col-3">
                    <% 
                        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, SUM("& MSCA_SaldoBlnD &") AS SaldoDebet, SUM("& MSCA_SaldoBlnK &") AS SaldoKredit FROM GL_M_ChartAccount INNER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_ID = 'E100.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
                        set HPP = LabaRugi_CMD.execute
                        if HPP("CA_Jenis") = "D" then
                            Total =  HPP("SaldoDebet")  - HPP("SaldoKredit")
                        else 
                            Total =  HPP("SaldoKredit") - HPP("SaldoDebet") 
                        end if 
                    %>
                    <span> <%=Replace(Replace(FormatCurrency(Total),"$",""),".00","")%> </span>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-7">
                    <span class="cont-text"><b> Bebas Usaha </b></span><br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cont-text"> Beban Marketing & Promosi </span><br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cont-text"> Beban Umum dan Administrasi </span><br>
                    <span class="cont-text"><b> Laba (Rugi) Usaha </b></span><br>
                </div>
                <div class="col-2">
                    <span>  </span>
                </div>
                <div class="col-3">
                    <span> </span>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-7">
                    <span class="cont-text"><b> Pendapatan dan (Beban) lain-lain</b></span><br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cont-text"> Pendapatan Lain-Lain </span><br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cont-text"> Beban Lain-Lain </span><br>
                </div>
                <div class="col-2">
                    <span>  </span>
                </div>
                <div class="col-3">
                    <span> </span>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed" style="font-size:12px; border:1px solid white;color:black">
                            <thead style="background-color:#eee">
                            <tr class="text-center">
                                <th> DETAIL </th>
                                <th> CATATAN </th>
                                <th>  </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ' LabaRugi_CMD.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount Where CA_Kelompok between '04' and '07' and CA_Type = 'H' and CA_Golongan = 'L/R' and CA_ID = 'D100.00.00' "
                                ' set Pendapatan = LabaRugi_CMD.execute
                            %>
                            <tr>
                                <td> Pendapatan, Bersih </td>
                                <td> Pendapatan, Bersih </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    $(function () {
        $(".test").terbilang();
        $(".as-output-text").terbilang({
            nominal: document.getElementById("subtotal").value,
            output: 'text'
        });
    })
</script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>