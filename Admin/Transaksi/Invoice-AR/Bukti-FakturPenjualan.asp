<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    InvARID = request.queryString("InvARID")
    InvARTanggal = request.queryString("InvARTanggal")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

	Merchant_cmd.commandText = "SELECT DATEADD(day, MKT_T_Faktur_Penjualan.InvARPayTerm, MKT_T_Faktur_Penjualan.InvARTanggal) AS DateAdd, MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal,  MKT_T_Faktur_Penjualan.InvARPayTerm, MKT_T_PengeluaranSC_H.pscID, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Customer.custFax, MKT_M_Customer.custNpwp,  MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_T_Faktur_Penjualan.InvAR_SJID FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_T_PengeluaranSC_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PengeluaranSC_H.psc_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D.pscIDH RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_PengeluaranSC_H.pscID = MKT_T_Faktur_Penjualan.InvAR_pscID ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') AND InvARID = '"& InvARID &"' GROUP BY MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal, MKT_T_PengeluaranSC_H.pscID, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1,  MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota,MKT_T_Faktur_Penjualan.InvARPayTerm, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Customer.custFax,MKT_M_Customer.custNpwp,MKT_T_Faktur_Penjualan.InvAR_SJID"
	set Faktur = Merchant_cmd.execute


%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-6">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!--#include file="../../IconPIGO.asp"-->

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/DataTables/datatables.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script>
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "BuktiFaktur-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";

    $(function () {
        $(".test").terbilang();
        $(".as-output-text").terbilang({
            nominal: document.getElementById("subtotal").value,
            output: 'text'
        });
    })
    </script>
    <style>
        .tb-faktur{
            border:0px;
            border-bottom:2px solid black;
            border-top:2px solid black;
        }
        .dotted {
            border: 2px dotted black; 
            width:100%;
            border-style: none none dotted; 
            color: #fff; 
            background-color: #fff; }
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
            .footer{
                margin-top:3rem;
                padding:2px 30px;
                border: 0px red solid;
                height: 100%;
                outline: 0cm #FFEAEA solid;
            }
            .cont-footer{
                padding:10px 5px;
                background:#eee;
                color:black;
                border:1px solid #eee;
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
                <!--#include file="../../HeaderPIGOA4.asp"-->
                <div class="row mt-3" style="font-size:10px">
                    <div class="col-2">
                        <span class="txt-desc"> No Nota </span><br>
                        <span class="txt-desc"> Tanggal </span><br>
                        <span class="txt-desc"> Dokumen No </span><br>
                    </div>
                    <div class="col-5">
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp;<%=Faktur("InvARID")%> </span><br>
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp;<%=day(Faktur("InvARTanggal"))%>&nbsp;<%=MonthName(Month(Faktur("InvARTanggal")))%>&nbsp;<%=Year(Faktur("InvARTanggal"))%></span><br>
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp;<%=Faktur("InvAR_SJID")%></span><br>
                    </div>
                    <div class="col-2">
                        <span class="txt-desc"> T.O.P </span><br>
                        <span class="txt-desc"> Tgl JatuhTempo </span><br>
                    </div>
                    <div class="col-3">
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp; n/<%=Faktur("InvARPayTerm")%> </span><br>
                        <span class="txt-desc"> <span class="txt-desc"> : </span>&nbsp;&nbsp; <%=day(Faktur("DateAdd"))%>&nbsp;<%=MonthName(Month(Faktur("DateAdd")))%>&nbsp;<%=Year(Faktur("DateAdd"))%></span><br>
                    </div>
                </div>
                <div class="row  mt-4  text-center">
                    <div class="col-12">
                        <span class="txt-desc" style="font-size:20px">  F A K T U R  &nbsp;&nbsp; P E N J U A L A N   </span><br>
                        <span class="txt-desc">    </span><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        <span class="txt-desc"> Nama Cust </span>
                    </div>
                    <div class="col-9">
                        <span class="txt-desc"> <%=Faktur("custNama")%></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        <span class="txt-desc"> Alamat </span>
                    </div>
                    <div class="col-8">
                        <span class="txt-desc"> <%=Faktur("almLengkap")%> </span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        <span class="txt-desc"> No Telp / HP </span>
                    </div>
                    <div class="col-9">
                        <span class="txt-desc"> <%=Faktur("custPhone1")%> </span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        <span class="txt-desc"> No Fax </span>
                    </div>
                    <div class="col-9">
                        <span class="txt-desc"> <%=Faktur("custFax")%> </span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        <span class="txt-desc"> NPWP</span>
                    </div>
                    <div class="col-9">
                        <span class="txt-desc"> <%=Faktur("custNpwp")%> </span>
                    </div>
                </div>
                <div class="row mt-4 mb-4">
                    <div class="col-12">
                        <div class="panel panel-default">
                            <table class="table txt-desc table-borderless p-0">
                            <thead class="text-center"style="border-top:1px solid black">
                                <tr>
                                    <th> NO </th>
                                    <th> DETAIL PRODUK  </th>
                                    <th colspan="2"> QTY </th>
                                    <th> HARGA </th>
                                    <th> TOTAL </th>
                                </tr>
                            </thead>
                            <tbody style="border-top:1px solid black">
                            <%
                                Merchant_cmd.commandText = "SELECT MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTotalLine, MKT_T_SuratJalan_D.SJID_pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber,MKT_M_PIGO_Produk.pdUnit, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty,  MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax FROM MKT_T_SuratJalan_D LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_SuratJalan_D.SJID_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_SuratJalan_H ON LEFT(MKT_T_SuratJalan_D.SJIDH,18) = MKT_T_SuratJalan_H.SJID RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_SuratJalan_H.SJID = MKT_T_Faktur_Penjualan.InvAR_SJID  WHERE MKT_T_Faktur_Penjualan.InvARID = '"& InvARID &"' and MKT_T_Faktur_Penjualan.InvAR_custID = '"& Faktur("custID") &"' GROUP BY MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTotalLine, MKT_T_SuratJalan_D.SJID_pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber,MKT_M_PIGO_Produk.pdUnit, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty,  MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax"
                                'response.Write Merchant_cmd.commandText
                                set Produk = Merchant_cmd.execute 
                            %>
                            <%  
                                no = 0
                                do while not Produk.eof 
                                no = no + 1
                            %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td> <b>[<%=Produk("pdPartNumber")%>]</b> <%=Produk("pdNama")%> </td>
                                    <td class="text-center"> <%=Produk("SJID_pdQty")%> </td>
                                    <td class="text-center"> <%=Produk("pdUnit")%> </td>
                                    <%
                                        Qty         = Produk("SJID_pdQty")
                                        Harga       = Produk("SJIDD_pdHargaJual")
                                        PPN         = Produk("SJID_pdTax")
                                        UPTO        = Produk("SJID_pdUpto")

                                        Total       = Qty*Harga
                                        UP          = Harga+(Harga*UPTO/100)
                                        ReturnUPTO  = Total+(Total*UPTO/100)
                                        ReturnPPN   = ReturnPPN*PPN/100
                                        SubTotal    = ReturnPPN+ReturnUPTO

                                        GrandTotal = GrandTotal + SubTotal 
                                        SubTotal = 0
                                    
                                    %>
                                    <td class="text-end"> 
                                        <%=Replace(Replace(FormatCurrency(UP),"$","Rp.   "),".00","")%> 
                                    </td>
                                    <%
                                        TotalProduk = Produk("SJID_pdQty") * UP
                                    %>
                                    <td class="text-end"><%=Replace(Replace(FormatCurrency(TotalProduk),"$","Rp. "),".00","")%></td>
                                    <%
                                        d = d + TotalProduk
                                        PPNKeluaran = Round(Produk("SJID_pdTax")/100*d)
                                    %>
                                    <%
                                        GrandTotal = d+PPNKeluaran
                                    %>
                                </tr>
                            <% Produk.movenext
                            loop %>
                            </tbody>
                            <thead>
                                <tr style="border-top:1px solid black">
                                    <th colspan="5"> SUB TOTAL ITEM </th>
                                    <th class="text-end">  <%=Replace(Replace(FormatCurrency(d),"$","Rp. "),".00","")%> </th>
                                </tr>
                                <tr>
                                    <th colspan="5"> VAT/TAX</th>
                                    <th class="text-end"><%=Replace(Replace(FormatCurrency(PPNKeluaran),"$","Rp. "),".00","")%></th>
                                </tr>
                                <tr>
                                    <th colspan="5"> GRAND TOTAL</th>
                                    <th class="text-end"> 
                                        <%=Replace(Replace(FormatCurrency(GrandTotal),"$","Rp. "),".00","")%> 
                                        <input type="hidden" name="subtotal" id="subtotal" value="<%=GrandTotal%>">
                                    </th>
                                </tr>
                            </thead>
                        </table>
                        </div>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-2">
                        <span class="txt-desc">Terbilang</span><br>
                    </div>
                    <div class="col-10 p-0" style="border-bottom: 1px dotted black;">
                        <input type="hidden" name="total" id="total" value="12584">
                        <span class="txt-desc"> : </span>  &nbsp;&nbsp;  <b><span class="as-output-text txt-desc"></span></b>
                        <b><span class=" txt-desc">Rupiah</span></b>
                    </div>
                </div>
                <!--<div class="row mt-4">
                    <div class="col-2">
                        <span class="text-desc"> Terbilang </span>
                    </div>
                    <div class="col-1">
                        <span class="text-desc"> : </span>
                    </div>
                    <div class="col-9" style="border-bottom: 1px dotted black;">
                        <span > Terbilasdvsdvsdvsdvdsvsdvsdvsdvsdvsdvngsdfsdfsfsdfsdf </span>
                    </div>
                </div>-->
                <!--<div class="row mt-4">
                    <div class="col-12">
                        <span class="text-desc"style="font-size:11px; font-weight:bold"> Perhatikan </span> <br>
                        <span class="text-desc" style="font-size:11px; font-weight:bold"> Pembayaran ini sah apabila pada Nota ini telah ditanda tangani dan dicap "LUNAS" oleh kasir atau penagih. Perusahaan tidak bertanggung jawab atas segala pembayaran yang tidak bertanda bukti seperti berikut diatas  </span> <br>
                    </div>
                </div>-->
            </div>
            <div class="footer text-center">
                <div class="cont-footer">
                    <div class="row">
                    <div class="col-12">
                        <span> Pembayaran Transfer Melalui Bank BCA : </span> <br>
                        <span> A/C : 6755118889 </span> <span> a.n PT. Perkasa Indah Gemilang Oetama </span>
                    </div>
                </div>
                </div>
                
            </div>
        </div>
    </div>
</body>
    <script>
            var total = document.getElementById('total').value;
            var fax = document.getElementById('fax').value;
            var subtotal = document.getElementById('subtotall').value;
            
            var	reverse1 = total.toString().split('').reverse().join('');
            var reverse2 = fax.toString().split('').reverse().join('');
            var reverse3 = subtotal.toString().split('').reverse().join('');
            var ribuan1 	= reverse1.match(/\d{1,3}/g);
            var ribuan2 	= reverse2.match(/\d{1,3}/g);
            var ribuan3 	= reverse3.match(/\d{1,3}/g);
                ribuan1	= ribuan1.join('.').split('').reverse().join('');
                ribuan2	= ribuan2.join('.').split('').reverse().join('');
                ribuan3	= ribuan3.join('.').split('').reverse().join('');
            
            // Cetak hasil	
            document.getElementById('total').value = ("Rp. "+ribuan1);
            document.getElementById('fax').value = ("Rp. "+ribuan2);
            document.getElementById('subtotall').value = ("Rp. "+ribuan3);
    </script>

    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>