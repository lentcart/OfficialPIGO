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

                    filtercust = filtercust & addOR & " MKT_T_Transaksi_H.tr_custID = '"& x &"' "

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
        filterTanggal = " and trTglTransaksi between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String
			
	Seller_cmd.commandText = "SELECT MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Customer.custNama,MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where MKT_M_Seller.sl_custID = 'C0322000000002' "
	set Seller = Seller_cmd.execute

	dim report

    set report_cmd = server.createObject("ADODB.COMMAND")
	report_cmd.activeConnection = MM_PIGO_String
			
	report_cmd.commandText = "SELECT dbo.MKT_T_Transaksi_H.tr_custID, dbo.MKT_M_Customer.custNama, dbo.MKT_M_Customer.custEmail, dbo.MKT_M_Customer.custPhone1, dbo.MKT_M_Alamat.almLengkap FROM dbo.MKT_M_Customer INNER JOIN dbo.MKT_T_Transaksi_H ON dbo.MKT_M_Customer.custID = dbo.MKT_T_Transaksi_H.tr_custID INNER JOIN dbo.MKT_M_Alamat ON dbo.MKT_T_Transaksi_H.tr_almID = dbo.MKT_M_Alamat.almID LEFT OUTER JOIN dbo.MKT_T_Transaksi_D1 ON dbo.MKT_T_Transaksi_H.trID = LEFT(dbo.MKT_T_Transaksi_D1.trD1, 12) where MKT_T_Transaksi_D1.tr_slID = 'C0322000000002' AND MKT_T_Transaksi_D1.tr_strID = '03' and year(trTglTransaksi)='"& tahun &"' "& FilterFix & filterTanggal & "GROUP BY dbo.MKT_T_Transaksi_H.tr_custID, dbo.MKT_M_Customer.custNama, dbo.MKT_M_Customer.custEmail, dbo.MKT_M_Customer.custPhone1, dbo.MKT_M_Alamat.almLengkap"
    'response.write report_cmd.commandText
	set report = report_cmd.execute

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

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
        document.title = "Laporan-Penjualan-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-<%=request.Cookies("custEmail")%>";
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
    <div class="book">
        <div class="page">
            <div class="subpage">
                <div class="row">
                    <div class="col-7">
                        <span> Laporan Penjualan <b>[ <%=request.Cookies("custNama")%> ]</b> </span><br>
                        <span> Periode Tanggal <b> [ <%=tgla%> s.d. <%=tgle%> ]  </b> </span>
                    </div>
                    <div class="col-5">
                        <div class="row">
                            <div class="col-2">
                                <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                            </div>
                            <div class="col-10">
                                <span class="Judul-Merchant"> <%=Merchant("custNama")%> </span><br>
                                <span class="Txt-Merchant"> <%=Merchant("custPhone1")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone2")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone3")%> </span><br>
                                <span class="Txt-Merchant"> <%=Merchant("almLengkap")%> </span><br>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3 mb-3" style="border-bottom:4px solid #eee">
                
                </div>
                <%do while not report.eof%>
                <div class="row">
                <div class="col-2">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <span class="txt-desc"> Nama Customer </span><br>
                            <span class="txt-desc"> Email </span><br>
                            <span class="txt-desc"> Nomor Telepon </span><br>
                            <span class="txt-desc"> Alamat Lengkap </span>
                        </div>
                    </div>
                </div>
                <div class="col-7 p-0">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <span class="txt-desc"><%=report("custNama")%></span><br>
                            <span class="txt-desc"><%=report("custEmail")%></span><br>
                            <span class="txt-desc"><%=report("custPhone1")%></span><br>
                            <span class="txt-desc"><%=report("almLengkap")%></span><br>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
            <span class="panel-title mb-1 weight">Ringkasan Pembelian</span>
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed" style="font-size:12px">
                    <thead>
                        <tr>
                            <th class="text-center"> Tanggal Transaksi </th>
                            <th class="text-center"> Nama Produk </th>
                            <th class="text-center"> Harga </th>
                            <th class="text-center"> Jumlah </th>
                            <th class="text-center"> Total </th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        produk_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty,  MKT_M_Produk.pdID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran, MKT_M_Produk.pdSku, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.trBiayaOngkir FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID AND LEFT(MKT_T_Transaksi_D1A.trD1A, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID  where MKT_T_Transaksi_H.tr_custID = '"& report("tr_custID") &"' and MKT_T_Transaksi_D1.tr_slID = 'C0322000000002' "  & FilterFix & filterTanggal & "  GROUP BY MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.trPengiriman, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty,  MKT_M_Produk.pdID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran, MKT_M_Produk.pdSku, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.trBiayaOngkir  "
                        'response.write produk_cmd.commandText
                        set produk = produk_CMD.execute
                    %>

                    <%do while not produk.eof%>
                        <tr>
                            <td class="text-center"><%=Cdate(produk("trTglTransaksi"))%> [  <%=produk("trID")%> ]  </td>
                            <td><b>[ <%=produk("pdSku")%> ]</b> - <%=produk("pdNama")%></td>
                            <td class="text-center"><%=Replace(FormatCurrency(produk("tr_pdHarga")),"$","Rp. ")%></td>
                            <td class="text-center"><%=produk("tr_pdQty")%></td>
                            <% total =  produk("tr_pdHarga")*produk("tr_pdQty")%>
                            <td class="text-center"><%=Replace(FormatCurrency(total),"$","Rp.  ")%></td>
                            <%subtotal = subtotal + total %>
                        </tr>
                       
                        <% 
                        produk.movenext
                        loop%>
                         <tr>
                            <td class="text-center"colspan="4"><b>Sub Total</b></td>
                            <td class="text-center"><%=Replace(FormatCurrency(subtotal),"$","Rp.  ")%></td>
                         <%
                         grandTotal =  grandTotal + subtotal
                        subtotal = 0

                        'response.write grandTotal
                        %>   
                        </tr>
                    </tbody>
                </table>
                </div>
            </div>

        <%
        response.flush
        report.movenext
        loop%>
        
        <div class="panel panel-default">
            <div class="row">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1 text-center" style="font-size:12px">
                        <tr>
                            <th colspan="8"> Total Keseluruhan </th>
                        </tr>
                        <tr>
                            <td> <%=Replace(FormatCurrency(grandTotal),"$","Rp.  ")%> </td>
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