<!--#include file="../Connections/pigoConn.asp" -->
<%

    trID = request.queryString("trID")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_T_Transaksi_D1.tr_slID, MKT_M_Seller.slName,MKT_M_Seller.sl_custID, MKT_T_Transaksi_H.tr_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2,  MKT_T_Transaksi_H.tr_almID, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_T_Transaksi_H.trTglTransaksi FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Alamat.almID = MKT_T_Transaksi_H.tr_almID LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Seller.sl_custID = MKT_T_Transaksi_D1.tr_slID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) WHERE (MKT_T_Transaksi_H.trID = '"& trID &"')"
	set Merchant = Merchant_cmd.execute

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String
			
	PurchaseOrder_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_M_Customer.custNama, MKT_M_Alamat.almLengkap, MKT_T_PurchaseOrder_D.poPajak, MKT_M_Customer.custID, MKT_M_Customer.custEmail,  MKT_M_Customer.custPhone1, MKT_M_Customer.custFax, MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID ON  MKT_M_Alamat.alm_custID = MKT_M_Customer.custID WHERE (MKT_T_PurchaseOrder_H.poID ='"& poID &"') AND (MKT_T_PurchaseOrder_H.poTanggal ='"& Tanggalpo &"') AND  (MKT_M_Alamat.almJenis <> 'Alamat Toko')  GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_M_Customer.custNama, MKT_M_Alamat.almLengkap, MKT_T_PurchaseOrder_D.poPajak, MKT_M_Customer.custID, MKT_M_Customer.custEmail,  MKT_M_Customer.custPhone1, MKT_M_Customer.custFax, MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP"
    'response.write PurchaseOrder_cmd.commandText
	set PurchaseOrder = PurchaseOrder_cmd.execute
    TransaksiID = ""& trID &""


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
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>

     
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "INV-"+today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear()+"/<%=TransaksiID%>";
    const myTimeout = setTimeout(myGreeting, 100);

        function myGreeting() {
        window.print();
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
            .watermark {
                display: inline;

                position: fixed !important;
                opacity: 0.1;
                font-size: 3em;
                width: 100%;
                text-align: center;
                z-index: 1000;
                top:0rem;
                right:15rem;
                writing-mode: vertical-lr;
                -webkit-transform: rotate(-130deg);
                -moz-transform: rotate(-180deg);
            }
            .txt1{
                font-size:50px;
                color:#ff0009;
                font-weight:bold;
                font-size:80px;
                
            }
            .txt2{
                font-size:50px;
                color:#0077a2;
                font-weight:bold;
                font-size:80px;
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
    <!--<div class="container">
    <div class="row">
        <div class="col-12">
            <a href="index.asp"> Kembali </a>
        </div>
    </div>
    </div>-->
    <div class="book">
        <div class="page">
            <div class="subpage">
                <div class="row align-items-center">
                    <div class="col-1 me-4">
                        <img src="<%=base_url%>/assets/logo/3.png" class="logo me-3" alt="" width="65" height="84" />
                    </div>
                    <div class="col-10">
                        <span class="Judul-Merchant" style="font-size:30px;color:#ff0009"><b> I N V O I C E  </b></span><br>
                        <span class="Judul-Merchant" style="font-size:15px; color:#0077a2"><b>INV/<%=TransaksiID%>/<%=Cdate(date())%></b></span><br>
                    </div>
                </div>
                
                
                <div class="row mt-4">
                    <div class="col-5">
                        <span class="cont-text"><b> Invoice Diterbitkan Oleh </b> </span><br>
                        <span class="cont-text"> Penjual : <%=Merchant("slName")%> </span>
                    </div>
                    <div class="col-7">
                        <span class="cont-text"><b> Invoice Ditujukan Untuk </b></span><br>
                        <div class="row">
                            <div class="col-5">
                                <span> Nama Pembeli </span><br>
                                <span> Tanggal Pembelian </span><br>
                                <span> Alamat Pengiriman </span><br>
                            </div>
                            <div class="col-7">
                                <span> : </span> &nbsp; <span> <%=Merchant("custNama")%>  </span><br>
                                <span> : </span> &nbsp; <span> <%=Merchant("trTglTransaksi")%>  </span><br>
                                <span> : </span> &nbsp; <span> <%=Merchant("almLengkap")%>  </span><br>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <%
                            set Produk_cmd = server.createObject("ADODB.COMMAND")
                            Produk_cmd.activeConnection = MM_PIGO_String
                                    
                            Produk_cmd.commandText = "SELECT MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdNama, MKT_M_Produk.pdBerat, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.tr_strID FROM MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Produk.pd_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A WHERE (MKT_T_Transaksi_H.trID = '"& trID &"') AND (MKT_M_Produk.pd_custID = '"& Merchant("sl_custID") &"')"
                            set Produk = Produk_cmd.execute
                        %>
                        <div class="watermark text-center">
                            <div class="row text-center" style="color:white">
                                <div class="col-12">
                                    <span class="txt2"><%=Produk("strName")%></span>
                                </div>
                            </div>
                        </div>
                        <table class="table" style="border-top:3px solid black;">
                            <thead class="text-center" style="background-color:#eee;">
                                <tr style="border-bottom:3px solid black;">
                                    <th> DETAIL PRODUK </th>
                                    <th> JUMLAH </th>
                                    <th> HARGA SATUAN </th>
                                    <th> TOTAL HARGA </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    do while not Produk.eof
                                %>
                                <tr>
                                    <td> 
                                        <span style="font-size:13px; color:#0077a2"><b> <%=Produk("pdNama")%> </b></span><br>
                                        <span> Berat &nbsp; : &nbsp;<b><%=Produk("pdBerat")%></b> </span>
                                    </td>
                                    <td class="text-center"> <%=Produk("tr_pdQty")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Produk("tr_pdHarga")),"$","Rp. "),".00","")%> </td>
                                    <%
                                        TotalHarga = Produk("tr_pdQty")*Produk("tr_pdHarga")
                                    %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(TotalHarga),"$","Rp. "),".00","")%> </td>
                                    <%
                                        Subtotal = Subtotal + TotalHarga
                                        TotalBerat = TotalBerat + Produk("pdBerat")
                                    %>
                                </tr>
                                <%
                                    Produk.movenext
                                    loop
                                %>
                            </tbody>
                            <thead>
                                <tr>
                                    <th colspan="3" class="text-end"> Total Harga 1(Barang) </th>
                                    <th class="text-end"> <%=Replace(Replace(FormatCurrency(Subtotal),"$","Rp. "),".00","")%> </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Produk_cmd.commandText = "SELECT MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_T_Transaksi_D1.trPengiriman,  MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_Transaksi_D1 RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID WHERE (MKT_T_Transaksi_H.trID = '"& trID &"')"
                                    set DetailProduk = Produk_cmd.execute
                                %>
                                <tr>
                                    <td colspan="3" class="text-end"> Total Ongkos Kirim (<%=TotalBerat%>)</td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(DetailProduk("trBiayaOngkir")),"$","Rp. "),".00","")%> </td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="text-end"> Total Diskon Barang </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(0),"$","Rp. "),".00","")%> </td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="text-end"> Biaya Asuransi Pengiriman </td>
                                    <% if DetailProduk("trAsuransi") = "Y" then %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(DetailProduk("trBAsuransi")),"$","Rp. "),".00","")%> </td>
                                    <% else %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(0),"$","Rp. "),".00","")%> </td>
                                    <% end if %>
                                </tr>
                                <tr>
                                    <th colspan="3" class="text-end"> Total Belanja </th>
                                    <%
                                        TotalBelanja = Subtotal+DetailProduk("trBAsuransi")+DetailProduk("trBiayaOngkir")
                                    %>
                                    <th colspan="3" class="text-end"> <%=Replace(Replace(FormatCurrency(TotalBelanja),"$","Rp. "),".00","")%> </th>
                                </tr>
                                <tr>
                                    <td colspan="3" class="text-end"> Biaya layanan </td>
                                    <% if DetailProduk("trPacking") = "Y" then %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(DetailProduk("trbPacking")),"$","Rp. "),".00","")%> </td>
                                    <% else %>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(0),"$","Rp. "),".00","")%> </td>
                                    <% end if %>
                                </tr>
                                <tr  style="border-bottom:3px solid black;">
                                    <th colspan="3" class="text-end"> Total Tagihan </th>
                                    <%
                                        TotalTagihan = TotalBelanja+DetailProduk("trbPacking")
                                    %>
                                    <th colspan="3" class="text-end"> <%=Replace(Replace(FormatCurrency(TotalTagihan),"$","Rp. "),".00","")%> </th>
                                </tr>
                            </tbody>
                        </table>
                        <div class="row">
                            <div class="col-6">
                                <span class="cont-text"><b> Jenis Pengiriman </b></span><br>
                                <span> <%=DetailProduk("trPengiriman")%> </span><br>
                            </div>
                            <div class="col-6">
                                <span class="cont-text"><b> Jenis Pembayaran </b></span><br>
                                <span> <%=DetailProduk("trJenisPembayaran")%> </span><br>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-12">
                        <span class="cont-text"><b> Invoice ini bersifat sah dan diproses oleh komputer </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>