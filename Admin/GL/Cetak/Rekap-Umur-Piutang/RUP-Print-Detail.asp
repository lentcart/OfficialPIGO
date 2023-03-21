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
            FilterFix = " AND ( " & filtercust & " )" 
        end if

    if RUP_Tanggala="" or RUP_Tanggale = "" then
        filterTanggal = ""
    else
        filterTanggal = " and GL_T_RekapUmurPiutang.RUP_Tanggal between '"& RUP_Tanggala &"' and '"& RUP_Tanggale &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID = 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set RUP_CMD = server.createObject("ADODB.COMMAND")
	RUP_CMD.activeConnection = MM_PIGO_String
			
	RUP_CMD.commandText = "SELECT MKT_M_Customer.custID,MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Alamat.almLengkap,GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_Tahun FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN GL_T_RekapUmurPiutang ON MKT_M_Customer.custID = GL_T_RekapUmurPiutang.RUP_custID WHERE almJenis <> 'Alamat Toko'  "& FilterFix &" "& filterTanggal &"AND RUP_Jenis = '"& RUP_Jenis &"' GROUP BY   MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Alamat.almLengkap,GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_Tahun "
    'response.write RUP_CMD.commandText
	set BussinesPartner = RUP_CMD.execute

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
                    <div class="col-7">
                    <% IF RUP_Jenis = "AR" then %>
                        <span style="font-size:21px"> REKAP UMUR PIUTANG USAHA -  <%=RUP_Jenis%> </span><br>
                        <span> Per Tanggal <b> <%=RUP_Tanggala%> s.d <%=RUP_Tanggale%></b> </span>
                    <% else %>
                        <span style="font-size:21px"> REKAP UMUR UTANG USAHA -  <%=RUP_Jenis%> </span><br>
                        <span> Per Tanggal <b> <%=RUP_Tanggala%> s.d <%=RUP_Tanggale%> </b> </span>
                    <% end if %>
                    </div>
                    <div class="col-5">
                        <div class="row  align-items-center">
                            <div class="col-2">
                                <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                            </div>
                            <div class="col-10">
                                <span class="Judul-Merchant" style="font-size:22px"> <b><%=Merchant("custNama")%> </b></span><br>
                                <span class="cont-text"> <%=Merchant("almLengkap")%> </span><br>
                                <span class="cont-text"> <%=Merchant("custEmail")%> </span><br>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 mb-2" style="border-bottom:4px solid black">
                
                </div>
                <% 
                    do while not BussinesPartner.eof
                %>
                <div class="row">
                    <div class="col-2">
                        <span class="cont-text"> BUSSINES PARTNER </span><br>
                        <span class="cont-text"> EMAIL </span><br>
                        <span class="cont-text"> KONTAK </span><br>
                        <span class="cont-text"> ALAMAT LENGKAP </span>
                    </div>
                    <div class="col-7">
                        <span class="cont-text">:</span>&nbsp;<span class="cont-text"> <%=BussinesPartner("custNama")%> </span><br>
                        <span class="cont-text">:</span>&nbsp;<span class="cont-text"> <%=BussinesPartner("custEmail")%> </span><br>
                        <span class="cont-text">:</span>&nbsp;<span class="cont-text"> <%=BussinesPartner("custPhone1")%> </span><br>
                        <span class="cont-text">:</span>&nbsp;<span class="cont-text"> <%=BussinesPartner("almLengkap")%> </span><br>
                    </div>
                    
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed" style=" border:1px solid black;font-size:12px">
                        <thead>
                            <tr>
                                <th rowspan = "2" class="text-center"> NO</th>
                                <th rowspan = "2" class="text-center"> TAHUN </th>
                                <th rowspan = "2" class="text-center"> KETERANGAN </th>
                                <th class="text-center" colspan="7"> UMUR UTANG USAHA (HARI) </th>
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
                            RUP_CMD.commandText = "SELECT RUP_Tahun,RUP_Jenis,RUP_Tanggal,RUP_Keterangan,ISNULL(RUP0130,0) AS RUP0130,ISNULL(RUP3160,0) AS RUP3160,ISNULL(RUP6190,0) AS RUP6190,ISNULL(RUP91180,0) AS RUP91180,ISNULL(RUP181360,0) AS RUP181360,ISNULL(RUP366,0) AS RUP366,ISNULL(RUPPasal23,0) AS RUPPasal23,ISNULL(RUPLainnya,0) AS RUPLainnya,ISNULL(RUP_Total,0) AS RUP_Total,RUP_custID,RUP_AktifYN,RUP_UpdateID,RUP_UpdateTime  FROM GL_T_RekapUmurPiutang WHERE RUP_custID = '"& BussinesPartner("custID") &"' AND RUP_Jenis = '"& RUP_Jenis &"'"                      
                            'response.write Penjualan_CMD.commandText
                            set RUP = RUP_CMD.execute
                        %>
                        <% 
                            no = 0 
                            do while not RUP.eof 
                            no = no + 1 
                        %>
                        
                        <tr>
                            <td class="text-center"> <%=no%> </td>
                            <td class="text-center"> <%=RUP("RUP_Tahun")%> </td>
                            <td class="text-start"> <%=RUP("RUP_Keterangan")%> </td>
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
                        <% RUP.movenext
                        loop %>
                        <tr>
                            <td class="text-Center" colspan="3"><b> SUBTOTAL </b></td>
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
                    BussinesPartner.movenext
                    loop
                %>
                <%
                    GRANDTOTALP0130      = GRANDTOTALP0130 + GrandSUBRUP0130
                    GRANDTOTALP3160      = GRANDTOTALP3160 + SUBRUP3160
                    GRANDTOTALP6190      = GRANDTOTALP6190 + SUBRUPP6190
                    GRANDTOTALP91180     = GRANDTOTALP91180 + SUBRUPP91180
                    GRANDTOTALP181360    = GRANDTOTALP181360 + SUBRUPP181360
                    GRANDTOTALP366       = GRANDTOTALP366 + SUBRUPP366
                    GRANDTOTALPPasal23   = GRANDTOTALPPasal23 + SUBRUPPPasal23
                    GRANDTOTALPLainnya   = GRANDTOTALPLainnya + SUBRUPPLainnya
                    GRAND           = GRAND + GrandTotal
                
                %>
                <table class="table tb-transaksi table-bordered table-condensed" style=" border:1px solid black;font-size:12px">
                    <thead>
                            <tr>
                                <th rowspan = "2" colspan="3" class="text-center"> </th>
                                <th class="text-center" colspan="7"> UMUR UTANG USAHA (HARI) </th>
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
                        <tr>
                            <td class="text-Center" colspan="3" style="width:30rem"><b> GRANDTOTAL  </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(GRANDTOTALP0130),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP3160),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP6190),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP91180),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP181360),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUP366),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUPPasal23),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(SUBRUPLainnya),"$","Rp. "),".00","")%> </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(GRAND),"$","Rp. "),".00","")%> </b></td>
                        </tr>
                </table>
        </div>
            </div>    
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>