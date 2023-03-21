<!--#include file="../../../../Connections/pigoConn.asp" -->
<!--#include file="../../../../UpdateLOG/UpdateLOG.asp"-->
<%
    RUP_Tanggala     = Request.QueryString("tgla")
    RUP_Tanggale     = Request.QueryString("tgle")
    RUP_Jenis        = Request.QueryString("jenis")
    RUP_custID       = Split(request.queryString("custID"),",")

    for each x in RUP_custID
            if len(x) > 0 then

                    filtercust = filtercust & addOR & " GL_T_RekapUmurPiutang.RUP_custID = '"& x &"' "

                    addOR = " or " 

            end if
        next

        if filtercust <> "" then
            FilterFix = "( " & filtercust & " )" 
        end if

    if RUP_Tanggala="" or RUP_Tanggale = "" then
        filterTanggal = ""
    else
        filterTanggal = " and GL_T_RekapUmurPiutang.RUP_Tanggal between '"& RUP_Tanggala &"' and '"& RUP_Tanggale &"' "
    end if

    set RUP_CMD = server.createObject("ADODB.COMMAND")
	RUP_CMD.activeConnection = MM_PIGO_String

	RUP_CMD.commandText = "SELECT MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_custID, GL_T_RekapUmurPiutang.RUP_Tahun, ISNULL(SUM(GL_T_RekapUmurPiutang.RUP0130), 0) AS RUP0130,  ISNULL(SUM(GL_T_RekapUmurPiutang.RUP3160), 0) AS RUP3160, ISNULL(SUM(GL_T_RekapUmurPiutang.RUP6190), 0) AS RUP6190, ISNULL(SUM(GL_T_RekapUmurPiutang.RUP91180), 0) AS RUP91180,  ISNULL(SUM(GL_T_RekapUmurPiutang.RUP181360), 0) AS RUP181360, ISNULL(SUM(GL_T_RekapUmurPiutang.RUP366), 0) AS RUP366, ISNULL(SUM(GL_T_RekapUmurPiutang.RUPPasal23), 0) AS RUPPasal23,  ISNULL(SUM(GL_T_RekapUmurPiutang.RUPLainnya), 0) AS RUPLainnya, ISNULL(SUM(GL_T_RekapUmurPiutang.RUP_Total), 0) AS RUP_Total FROM GL_T_RekapUmurPiutang LEFT OUTER JOIN MKT_M_Customer ON GL_T_RekapUmurPiutang.RUP_custID = MKT_M_Customer.custID WHERE  "& FilterFix &" "& filterTanggal &" AND RUP_Jenis = '"& RUP_Jenis &"'GROUP BY MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_custID, GL_T_RekapUmurPiutang.RUP_Tahun"
    'response.write RUP_CMD.commandText
	set RUP = RUP_CMD.execute

    Log_ServerID 	= "" 
    Log_Action   	= "PRINT"
    Log_Key         = "GL-RU Piutang"
    Log_Keterangan  = "Melakukan cetak (GL) RU Piutang Type : "& RUP_Jenis &" Periode Tanggal : "& RUP_Tanggala &" s.d "& RUP_Tanggale
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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
        var today = new Date();

        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
            // window.print();
        document.title = "Rekap Umur Piutang -"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-<%=request.Cookies("custEmail")%>";
        function printpdf(){
            $(".cont-print").hide();  
            window.print();
        }
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
                    <button class="cont-btn" onclick="window.open('index.asp','_Self')"><i class="fas fa-arrow-left"></i> &nbsp;&nbsp; KEMBALI </button>
                </div>
            </div>
            <div class="col-1 me-4">
                <div class="print">
                    <button class="cont-btn" onclick="printpdf()"><i class="fas fa-print"></i> &nbsp;&nbsp; PDF </button>
                </div>
            </div>
            <div class="col-1 me-4">
                <div class="print">
                    <button class="cont-btn"><i class="fas fa-download"></i> &nbsp;&nbsp; EXP EXCEL </button>
                </div>
            </div>
        </div>
    </div>
    <div class="book">
        <div class="page">
            <div class="subpage">
                <div class="row align-items-center">
                    <div class="col-5">
                        <% IF RUP_Jenis = "AR" then %>
                            <span style="font-size:21px"> REKAP UMUR PIUTANG USAHA -  <%=RUP_Jenis%> </span><br>
                            <span> Per Tanggal <b> <%=RUP_Tanggal%> </b> </span>
                        <% else %>
                            <span style="font-size:21px"> REKAP UMUR UTANG USAHA -  <%=RUP_Jenis%> </span><br>
                            <span> Per Tanggal <b> <%=RUP_Tanggal%> </b> </span>
                        <% end if %>
                    </div>
                    <div class="col-7">
                        <div class="row  align-items-center">
                            <div class="col-2">
                                <img src="<%=base_url%>/assets/logo/1.png" class="logo me-3" alt="" width="80" height="85" />
                            </div>
                            <div class="col-10">
                                <span class="Judul-Merchant" style="font-size:25px; color:#0077a2"> <b>PT. PERKASA INDAH GEMILANG OETAMA</b></span><br>
                                <span class="txt-desc"> Jln. Alternatif Cibubur, Komplek Ruko Cibubur Point Automotiv Center Blok B No. 12B Cimangis,</span><br>
                                <span class="txt-desc"> Depok – Jawa Barat </span><br>
                                <span class="txt-desc"> otopigo.sekertariat@gmail.com </span><br>
                                <span class="txt-desc"> Telp : (021) 8459 6001 / 0811-8838-008 </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 mb-2" style="border-bottom:4px solid black">
                
                </div>
                
                <div class="row mt-3">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed" style=" border:1px solid black;font-size:12px">
                        <thead>
                            <tr>
                                <th rowspan = "2" class="text-center"> NO</th>
                                <th rowspan = "2" class="text-center"> TAHUN </th>
                                <th rowspan = "2" class="text-center"> KETERANGAN </th>
                                <th class="text-center" colspan="7"> UMUR PIUTANG USAHA (HARI) </th>
                                <th rowspan = "2" class="text-center"> LAINNYA </th>
                                <th rowspan = "2" class="text-center"> TOTAL </th>
                            </tr>
                            <tr>
                                <th rowspan = "2" class="text-center"> 01 - 30 </th>
                                <th rowspan = "2" class="text-center"> 31 - 60 </th>
                                <th rowspan = "2" class="text-center"> 61 - 90 </th>
                                <th rowspan = "2" class="text-center"> 91 - 181 </th> 
                                <th rowspan = "2" class="text-center"> 181 - 360  </th>
                                <th rowspan = "2" class="text-center"> > 1 TAHUN </th>
                                <th rowspan = "2" class="text-center"> PPh 23 </th>
                                
                            </tr>
                        </thead>
                        <tbody> 
                        <% 
                            no = 0 
                            do while not RUP.eof
                            no = no + 1 
                        %>
                        <tr>
                            <td class="text-center"> <%=no%> </td>
                            <td class="text-center"> <%=RUP("RUP_Tahun")%> </td>
                            <td class="text-start"> <%=RUP("custNama")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(RUP("RUP0130")),"$","Rp. "),".00","")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(RUP("RUP3160")),"$","Rp. "),".00","")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(RUP("RUP6190")),"$","Rp. "),".00","")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(RUP("RUP91180")),"$","Rp. "),".00","")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(RUP("RUP181360")),"$","Rp. "),".00","")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(RUP("RUP366")),"$","Rp. "),".00","")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(RUP("RUPPasal23")),"$","Rp. "),".00","")%> </td>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(RUP("RUPLainnya")),"$","Rp. "),".00","")%> </td>
                            <%
                                Total = RUP("RUP0130")+RUP("RUP3160")+RUP("RUP6190")+RUP("RUP91180")+RUP("RUP181360")+RUP("RUP366")+RUP("RUPPasal23")+RUP("RUPLainnya")
                            %>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(Total),"$","Rp. "),".00","")%> </td>
                            <%
                                SUBRUP0130      = SUBRUP0130 + RUP("RUP0130")
                                SUBRUP3160      = SUBRUP3160 + RUP("RUP3160")
                                SUBRUP6190      = SUBRUP6190 + RUP("RUP6190")
                                SUBRUP91180     = SUBRUP91180 + RUP("RUP91180")
                                SUBRUP181360    = SUBRUP181360 + RUP("RUP181360")
                                SUBRUP366       = SUBRUP366 + RUP("RUP366")
                                SUBRUPPasal23   = SUBRUPPasal23 + RUP("RUPPasal23")
                                SUBRUPLainnya   = SUBRUPLainnya + RUP("RUPLainnya")
                                SubTotal        = SubTotal + Total
                            %>
                        </tr>
                        <%
                    RUP.movenext
                    loop
                %>
                        <tr>
                            <td class="text-Center" colspan="3"><b> GRANDTOTAL </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP0130),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP3160),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP6190),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP91180),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP181360),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP366),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUPPasal23),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUPLainnya),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SubTotal),"$","Rp. "),".00","")%> </b></td>
                        </tr>
                        <%
                            GrandSUBRUP0130 = GrandSUBRUP0130 + SUBRUP0130
                            SUBRUP0130 = 0 
                            GrandTotal = GrandTotal + SubTotal
                            SubTotal = 0 
                        %>
                        </tbody>
                    </table>
                    </div>
                </div>
                
                <% 

                %>
            </div>
        </div>
            </div>    
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>