<!--#include file="../../Connections/pigoConn.asp" -->
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

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String
			
	Seller_cmd.commandText = "SELECT MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Customer.custNama,MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where MKT_M_Seller.sl_custID = '"& request.Cookies("custID") &"' "
	set Seller = Seller_cmd.execute

	dim report
    set report_cmd = server.createObject("ADODB.COMMAND")
	report_cmd.activeConnection = MM_PIGO_String
			
	report_cmd.commandText = "SELECT dbo.MKT_T_Transaksi_H.tr_custID, dbo.MKT_M_Customer.custNama, dbo.MKT_M_Customer.custEmail, dbo.MKT_M_Customer.custPhone1, dbo.MKT_M_Alamat.almLengkap FROM dbo.MKT_M_Customer INNER JOIN dbo.MKT_T_Transaksi_H ON dbo.MKT_M_Customer.custID = dbo.MKT_T_Transaksi_H.tr_custID INNER JOIN dbo.MKT_M_Alamat ON dbo.MKT_T_Transaksi_H.tr_almID = dbo.MKT_M_Alamat.almID LEFT OUTER JOIN dbo.MKT_T_Transaksi_D1 ON dbo.MKT_T_Transaksi_H.trID = LEFT(dbo.MKT_T_Transaksi_D1.trD1, 12) where MKT_T_Transaksi_D1.tr_slID = '"& request.cookies("custID") &"' and year(trTglTransaksi)='"&tahun&"' "& FilterFix & filterTanggal & "GROUP BY dbo.MKT_T_Transaksi_H.tr_custID, dbo.MKT_M_Customer.custNama, dbo.MKT_M_Customer.custEmail, dbo.MKT_M_Customer.custPhone1, dbo.MKT_M_Alamat.almLengkap"
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
    <title>PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="penjualan.css">
    <link rel="stylesheet" type="text/css" href="../../fontawesome/css/all.min.css">
    <script src="../../js/jspdf.min.js"></script>
    <script src="../../js/jquery-3.6.0.min.js"></script>
    
    <script>
        
        </script>
    </head>
<body>
    <div class="container" >
        <div class="row">
            <div class="col-2">
                <a href="../lap-penjualan/" class="text-a"> Kembali </a>
            </div>
            <div class="col-4">
                
            </div>
        </div>
    </div>
    <div class="container invoice" id="myTable">
        <div class="invoice-header">
            <div class="row align-items-center">
                <div class="col-1">
                    <div class="media-left">
                        <img src="data:image/png;base64,<%=seller("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                    </div>
                </div>
                <div class="col-4">
                    <div class="media">
                        <ul class="media-body list-unstyled">
                            <li class="txt-judul"><%=seller("slName")%></li>
                        </ul>
                    </div>
                </div>
                <div class="col-7">
                    <div class="media">
                        <ul class="media-body list-unstyled">
                            <li><strong><%=seller("almLengkap")%></strong></li>
                            <li><%=seller("custPhone1")%></li>
                            <li><%=seller("custEmail")%></li>
                        </ul>
                    </div>
                </div>
            </div>
        <hr>
        <div class="invoice-body">
            <div class="row text-center">
                <div class="col-12">
                    <span class="txt-judul"> -- LAPORAN PENJUALAN -- </span><br>
                    <span class="txt-judul">PERIODE LAPORAN</span><br>
                    <span><b> Bulan : <%=monthname(bulan)%> </b></span><br>
                    <span><b> <%=tgla%>  </b> s.d <b> <%=tgle%> </b></span>
                </div>
            </div>
        </div>
        </div>
        <hr>
        <%if report.eof = true then %>

            <div class="row text-center mt-4 mb-4">
                <div class="col-12">
                    <span style="font-size:20px"><b> DATA PENJUALAN TIDAK DITEMUKAN !</b></span>
                </div>
            </div>

        <%else%>
        <%do while not report.eof%>
        <div class="invoice-body" style="background-color:#eeeeee; padding: 10px 20px; border-radius:20px;">
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
                <div class="col-1 p-0">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <span class="txt-desc"> : </span><br>
                            <span class="txt-desc"> : </span><br>
                            <span class="txt-desc"> : </span><br>
                            <span class="txt-desc"> : </span><br>
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
            <hr>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span class="panel-title mb-3 weight">Ringkasan Pembelian</span>
                </div>
                <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                    <thead>
                        <tr>
                            <th class="text-center"> Tanggal Transaksi </th>
                            <th class="text-center"> Kode Produk </th>
                            <th class="text-center"> Nama Produk </th>
                            <th class="text-center"> Harga </th>
                            <th class="text-center"> Jumlah </th>
                            <th class="text-center"> Total </th>
                        </tr>
                    </thead>
                    <tbody>
                    <% 'produk_cmd.commandText = "SELECT  MKT_T_Transaksi_D1A.tr_pdID FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_Transaksi_D1A ON left(MKT_T_Transaksi_D1.trD1,12) = left(MKT_T_Transaksi_D1A.trD1A,12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_H.tr_custID = '"& report("tr_custID") &"' "
                    produk_cmd.commandText = "SELECT dbo.MKT_T_Transaksi_D1A.tr_pdID, dbo.MKT_M_Produk.pdNama, dbo.MKT_T_Transaksi_D2.trSubTotal, dbo.MKT_T_Transaksi_H.trTglTransaksi, dbo.MKT_T_Transaksi_D1A.tr_pdQty, dbo.MKT_T_Transaksi_D1A.tr_pdHarga, dbo.MKT_M_Produk.pdHargaJual FROM dbo.MKT_T_Transaksi_D2 RIGHT OUTER  JOIN dbo.MKT_T_Transaksi_H ON LEFT(dbo.MKT_T_Transaksi_D2.trD2, 12) = dbo.MKT_T_Transaksi_H.trID LEFT OUTER JOIN                           dbo.MKT_M_Produk RIGHT OUTER JOIN dbo.MKT_T_Transaksi_D1A ON dbo.MKT_M_Produk.pdID = dbo.MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN dbo.MKT_T_Transaksi_D1 ON LEFT(dbo.MKT_T_Transaksi_D1A.trD1A, 12) = LEFT(dbo. MKT_T_Transaksi_D1.trD1, 12) ON dbo.MKT_T_Transaksi_H.trID = LEFT(dbo.MKT_T_Transaksi_D1.trD1, 12) WHERE (dbo.MKT_T_Transaksi_H. tr_custID = '"& report("tr_custID") &"') "  & FilterFix & filterTanggal & " order by trTglTransaksi "
            'response.write produk_cmd.commandText
	                set produk = produk_cmd.execute %>

                    <%do while not produk.eof%>
                        <tr>
                            <td class="text-center"><%=Cdate(produk("trTglTransaksi"))%></td>
                            <td class="text-center"><%=produk("tr_pdID")%></td>
                            <td><%=produk("pdNama")%></td>
                            <td ><%=Replace(FormatCurrency(produk("tr_pdHarga")),"$","Rp.  ")%></td>
                            <td class="text-center"><%=produk("tr_pdQty")%></td>
                            <td><%=Replace(FormatCurrency(produk("trSubTotal")),"$","Rp.  ")%></td>
                            <%subtotal = subtotal + produk("trSubTotal") %>
                        </tr>
                       
                        <% 
                        produk.movenext
                        loop%>
                         <tr>
                            <td class="text-center"colspan="5"><b>Sub Total</b></td>
                            <td ><%=Replace(FormatCurrency(subtotal),"$","Rp.  ")%></td>
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
        <hr>

        <%
        response.flush
        report.movenext
        loop%>
        
        <%end if%>
        <div class="panel panel-default">
            <div class="row">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1 text-center" style="font-size:12px">
                        <tr>
                            <th colspan="8"> Total Keseluruhan </th>
                        </tr>
                        <tr>
                            <td> <%=Replace(FormatCurrency(grandTotal),"$","Rp.  ")%></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="invoice-footer text-center mt-3">
            Thank you for choosing our services.
            <br />
            <strong>~PIGO Official~</strong>
        </div>
    </div>
        </div>
    </div>
</body>

    <script>

        
    </script>
   <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>