<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))



    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and mmTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String
			
	Seller_cmd.commandText = "SELECT MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Customer.custNama,MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhoto FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where MKT_M_Seller.sl_custID = '"& request.Cookies("custID") &"' "
	set Seller = Seller_cmd.execute

	set Pembelian_cmd = server.createObject("ADODB.COMMAND")
	Pembelian_cmd.activeConnection = MM_PIGO_String
			
	Pembelian_cmd.commandText = "SELECT MKT_M_Supplier.spID, MKT_M_Supplier.spKey, MKT_M_Supplier.spNama1, MKT_M_Supplier.spNama2, MKT_M_Supplier.spNpwp, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spProv,   MKT_M_Supplier.spPhone1, MKT_M_Supplier.spFax, MKT_M_Supplier.spEmail, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spPhoneCP, MKT_M_Supplier.spJabatanCP FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN  MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN  MKT_T_MaterialReceipt_H LEFT OUTER JOIN  MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID ON   MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID WHERE MKT_T_MaterialReceipt_H.mm_custID = '"& request.Cookies("custID") &"' " & FilterFix & filterTanggal & "  GROUP BY  MKT_M_Supplier.spID, MKT_M_Supplier.spKey, MKT_M_Supplier.spNama1, MKT_M_Supplier.spNama2, MKT_M_Supplier.spNpwp, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spProv, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spFax, MKT_M_Supplier.spEmail, MKT_M_Supplier.spNamaCP, MKT_M_Supplier.spPhoneCP, MKT_M_Supplier.spJabatanCP"
    'response.write Pembelian_cmd.commandText
	set Pembelian = Pembelian_cmd.execute

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
    <link rel="stylesheet" type="text/css" href="../../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="penjualan.css">
    <link rel="stylesheet" type="text/css" href="../../../fontawesome/css/all.min.css">
    <script src="../../../js/jquery-3.6.0.min.js"></script>
    
    <script>
    </script>
    </head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-2">
                <a href="../lap-penjualan/" class="text-a"> Kembali </a>
            </div>
            <div class="col-4">
                
            </div>
        </div>
    </div>
    <div class="container invoice">
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
                    <span class="txt-judul"> -- LAPORAN MATERIAL RECEIPT -- </span><br>
                    <span class="txt-judul">PERIODE LAPORAN</span><br>
                    <span><b> Bulan : <%=monthname(bulan)%> </b></span><br>
                    <span><b> <%=tgla%>  </b> s.d <b> <%=tgle%> </b></span>
                </div>
            </div>
        </div>
        </div>
        <hr>
        <%if Pembelian.eof = true then %>

            <div class="row text-center mt-4 mb-4">
                <div class="col-12">
                    <span style="font-size:20px"><b> DATA PEMBELIAN TIDAK DITEMUKAN !</b></span>
                </div>
            </div>

        <%else%>
        <%do while not Pembelian.eof%>
        <div class="invoice-body" style="background-color:#eeeeee; padding: 10px 20px; border-radius:20px;">
            <div class="row">
                <div class="col-2">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <span class="txt-desc"> Nama Supplier </span><br>
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
                            <span class="txt-desc"><%=Pembelian("spNama1")%></span><br>
                            <span class="txt-desc"><%=Pembelian("spPhone1")%></span><br>
                            <span class="txt-desc"><%=Pembelian("spAlamat")%></span><br>
                            <span class="txt-desc"><%=Pembelian("spProv")%></span><br>
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
                            <th class="text-center"> No</th>
                            <th class="text-center"> Tanggal  </th>
                            <th class="text-center"> Nama Produk </th>
                            <th class="text-center"> Type Produk </th>
                            <th class="text-center"> Harga </th>
                            <th class="text-center"> Jumlah Pembelian </th>
                            <th class="text-center"> Total </th>
                        </tr>
                    </thead>
                    <tbody>
                    <% 
                    produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS nourut,  MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType, MKT_T_MaterialReceipt_D1.mm_poID,  MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_MaterialReceipt_H.mm_spID = MKT_M_Supplier.spID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MKT_T_MaterialReceipt_H.mm_spID = '"& Pembelian("spID") &"') "   & filterTanggal & "GROUP BY MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mmType, MKT_T_MaterialReceipt_D1.mm_poID,  MKT_T_MaterialReceipt_D1.mm_poTanggal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,  MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_M_PIGO_Produk.pdTypeProduk  order by mmTanggal "
                    'response.write produk_cmd.commandText
	                set produk = produk_cmd.execute %>

                    <%do while not produk.eof%>
                        <tr>
                            <td class="text-center"><%=produk("nourut")%></td>
                            <td class="text-center"><%=Cdate(produk("mmTanggal"))%></td>
                            <td><%=produk("pdNama")%></td>
                            <td><%=produk("pdTypeProduk")%></td>
                            <td ><%=Replace(FormatCurrency(produk("mm_pdHarga")),"$","Rp.  ")%></td>
                            <td class="text-center"><%=produk("mm_pdQtyDiterima")%></td>
                            <%total = produk("mm_pdQtyDiterima") * produk("mm_pdHarga") %>
                            <td><%=Replace(FormatCurrency(total),"$","Rp.  ")%></td>
                            <%subtotal = subtotal+ total %>
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
                        %>   
                        </tr>
                    </tbody>
                </table>
            </div>
            
        </div>
        <hr>

        <%
        response.flush
        Pembelian.movenext
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