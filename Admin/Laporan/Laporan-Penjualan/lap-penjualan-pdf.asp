<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    ' id = request.queryString("custID")
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))
    'response.write tahun &"<BR>"


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    'response.write tgla &"<BR>"
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))

    id = Split(request.queryString("custID"),",")

    for each x in id
            if len(x) > 0 then

                    filtercust = filtercust & addOR & " MKT_T_Permintaan_Barang_H.Perm_custID = '"& x &"' "

                    addOR = " or " 
                    
            end if
        next

        if filtercust <> "" then
            FilterFix = "and  ( " & filtercust & " )" 
        end if

        ' response.write FilterFix


    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and MKT_T_Permintaan_Barang_H.PermTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID = 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Penjualan_CMD = server.createObject("ADODB.COMMAND")
	Penjualan_CMD.activeConnection = MM_PIGO_String
			
	Penjualan_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') "& FilterFix &" "& filterTanggal &"  AND PermTujuan = '1' GROUP BY MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,MKT_M_Customer.custID"
    'response.write Penjualan_CMD.commandText
	set BussinesPartner = Penjualan_CMD.execute

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
        document.title = "Laporan-Penjualan-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-<%=request.Cookies("custEmail")%>";
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
                        <span style="font-size:21px"> LAPORAN PENJUALAN </span><br>
                        <span> PERIODE -  <b> <%=tgla%> s.d. <%=tgle%>  </b> </span>
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
                        <span class="panel-title mb-1 weight"><b> DETAIL PENJUALAN </b></span><br>
                        <table class="table tb-transaksi table-bordered table-condensed" style=" border:1px solid black;font-size:12px">
                        <thead>
                            <tr>
                                <th class="text-center"> NO </th>
                                <th class="text-center"> TGL TRANSAKSI </th>
                                <th class="text-center"> ID PRODUK </th>
                                <th class="text-center"> DETAIL </th>
                                <th class="text-center"> SATUAN </th>
                                <th class="text-center"> QTY </th>
                                <th class="text-center"> HARGA </th>
                                <th class="text-center"> UPTO (%) </th>
                                <th class="text-center"> PPN (%) </th>
                                <th class="text-center"> TOTAL </th>
                            </tr>
                        </thead>
                        <tbody> 
                        <%
                            Penjualan_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermTanggaL, MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermNo,MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_D.Perm_pdUpTo,  MKT_T_Permintaan_Barang_D.Perm_pdTax, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_M_PIGO_Produk.pdID = MKT_T_Permintaan_Barang_D.Perm_pdID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_H.Perm_custID = '"& BussinesPartner("custID") &"' AND PermTujuan = '1' "
                            'response.write Penjualan_CMD.commandText
                            set Penjualan = Penjualan_CMD.execute
                        %>
                        <% 
                            no = 0 
                            do while not Penjualan.eof 
                            no = no + 1 
                        %>
                        
                        <tr>
                            <td class="text-center"> <%=no%> </td>
                            <td class="text-center"> <%=DAY(Penjualan("PermTanggaL"))%>/<%=MONTH(Penjualan("PermTanggaL"))%>/<%=YEAR(Penjualan("PermTanggaL"))%></td>
                            <td class="text-center"> <%=Penjualan("Perm_pdID")%></td>
                            <td> <b>[ <%=Penjualan("pdPartNumber")%> ]</b> <%=Penjualan("pdNama")%></td>
                            <td class="text-center"> <%=Penjualan("pdUnit")%></td>
                            <td class="text-center"> <%=Penjualan("Perm_pdQty")%></td>
                            <td class="text-end">    <%=Replace(Replace(FormatCurrency(Penjualan("Perm_pdHargaJual")),"$","Rp. "),".00","")%></td>
                            <td class="text-center"> <%=Penjualan("Perm_pdUpTo")%></td>
                            <td class="text-center"> <%=Penjualan("Perm_pdTax")%></td>
                            <%
                                Qty         = Penjualan("Perm_pdQty")
                                Harga       = Penjualan("Perm_pdHargaJual")
                                PPN         = Penjualan("Perm_pdTax")
                                UPTO        = Penjualan("Perm_pdUpTo")

                                Total       = Qty*Harga
                                ReturnPPN   = Round(Total+(Total*PPN/100))
                                ReturnUPTO  = Round(ReturnPPN*UPTO/100)
                                SubTotal    = Round(ReturnPPN+ReturnUPTO)
                            %>
                            <td class="text-end"> <%=Replace(Replace(FormatCurrency(SubTotal),"$","Rp. "),".00","")%></td>
                            <%
                                GrandTotal  = GrandTotal + SubTotal
                            %>
                        </tr>
                        <% penjualan.movenext
                        loop %>
                        <tr>
                            <td class="text-end" colspan="9"><b> SUBTOTAL </b></td>
                            <td class="text-end"><b> <%=Replace(Replace(FormatCurrency(GrandTotal),"$","Rp. "),".00","")%> </b></td>
                        </tr>
                        <%
                            SubGrandTotal = SubGrandTotal + GrandTotal
                            GrandTotal = 0 
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

                %>
                <div class="panel panel-default">
            <div class="row">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1 text-center" style="font-size:15px">
                        <tr>
                            <th colspan="8"><b> TOTAL KESELURUHAN </b></th>
                        </tr>
                        <tr>
                            <td><b> <%=Replace(Replace(FormatCurrency(SubGrandTotal),"$","Rp.  "),".00","")%> </b></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
            </div>    
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>
<%
    ' Response.ContentType = "application/vnd.ms-excel"
    ' Response.AddHeader "content-disposition", "filename=Lap-Penjualan - " & now() & ".xls"
%>
<table>
</table>