<!--#include file="../../../Connections/pigoConn.asp" -->

<%  
    InvAR_custID      = request.queryString("InvAR_custID")
    InvAR_tgla        = request.queryString("InvAR_tgla")
    InvAR_tgle        = request.queryString("InvAR_tgle")
    InvARID           = request.queryString("InvARID")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String

    if InvAR_custID = "" then
        BussinesPartner_cmd.commandText = "SELECT MKT_T_Faktur_Penjualan.InvAR_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Alamat.almLengkap FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_M_Customer.custID = MKT_T_Faktur_Penjualan.InvAR_custID WHERE MKT_T_Faktur_Penjualan.InvARID = '"& InvARID &"'  "
        'response.write BussinesPartner_cmd.commandText
        set BussinesPartner = BussinesPartner_cmd.execute
    else
        BussinesPartner_cmd.commandText = "SELECT MKT_T_Faktur_Penjualan.InvAR_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Alamat.almLengkap FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_M_Customer.custID = MKT_T_Faktur_Penjualan.InvAR_custID WHERE MKT_T_Faktur_Penjualan.InvAR_custID = '"& InvAR_custID &"' AND MKT_T_Faktur_Penjualan.InvARTanggal BETWEEN '"& InvAR_tgla &"' and '"& InvAR_tgle &"' "
        'response.write BussinesPartner_cmd.commandText
        set BussinesPartner = BussinesPartner_cmd.execute
    end if

    set FakturPenjualan_cmd = server.createObject("ADODB.COMMAND")
	FakturPenjualan_cmd.activeConnection = MM_PIGO_String
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
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script>
        var today = new Date();

        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "TandaTerima-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";

        
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
    <div class="book">
        <div class="page">
            <div class="subpage">
                <!--#include file="../../HeaderPIGO.asp"-->
                <div class="row mt-3" style="font-size:10px">
                    <div class="col-12">
                        <span class="txt-desc"> Kepada Yth, </span><br>
                        <span class="txt-desc"> Bag.Keuangan <b><%=BussinesPartner("custNama")%></b> </span><br>
                    </div>
                </div>
                <div class="row  mt-3  text-center">
                    <div class="col-12">
                        <span class="txt-desc" style="font-size:20px"> TANDA TERIMA INVOICE</span><br>
                    </div>
                </div>

                <div class="row mt-3 mb-4">
                    <div class="col-12">
                        <div class="panel panel-default">
                            <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:11px;border:1px solid black">
                            <thead class="text-center">
                                <tr>
                                    <th> NO </th>
                                    <th> TANGGAL </th>
                                    <th> NO DOKUMEN </th>
                                    <th> NILAI </th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                if InvAR_custID = "" then 
                                    FakturPenjualan_CMD.commandText = "SELECT MONTH(MKT_T_Faktur_Penjualan.InvARTanggal) AS bulan, MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal, MKT_T_PengeluaranSC_H.psc_custID, MKT_T_Faktur_Penjualan.InvARTotalLine FROM MKT_T_PengeluaranSC_D RIGHT OUTER JOIN MKT_T_SuratJalan_H LEFT OUTER JOIN MKT_T_SuratJalan_D ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH, 18) LEFT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_SuratJalan_H.SJID = MKT_T_Faktur_Penjualan.InvAR_SJID ON MKT_T_PengeluaranSC_D.pscIDH = MKT_T_PengeluaranSC_H.pscID WHERE MKT_T_PengeluaranSC_H.psc_custID = '"& BussinesPartner("InvAR_custID") &"' and MKT_T_Faktur_Penjualan.InvARID = '"& InvARID &"' GROUP BY  MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal, MKT_T_PengeluaranSC_H.psc_custID, MKT_T_Faktur_Penjualan.InvARTotalLine"
                                    'Response.Write FakturPenjualan_CMD.commandText & "<br>"
                                    set Faktur = FakturPenjualan_CMD.execute

                                else
                                    FakturPenjualan_CMD.commandText = "SELECT MONTH(MKT_T_Faktur_Penjualan.InvARTanggal) AS bulan, MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal, MKT_T_PengeluaranSC_H.psc_custID, MKT_T_Faktur_Penjualan.InvARTotalLine FROM MKT_T_PengeluaranSC_D RIGHT OUTER JOIN MKT_T_SuratJalan_H LEFT OUTER JOIN MKT_T_SuratJalan_D ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH,18) LEFT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_SuratJalan_H.SJID = MKT_T_Faktur_Penjualan.InvAR_SJID ON MKT_T_PengeluaranSC_D.pscIDH = MKT_T_PengeluaranSC_H.pscID WHERE MKT_T_PengeluaranSC_H.psc_custID = '"& BussinesPartner("InvAR_custID") &"' and MKT_T_Faktur_Penjualan.InvARTanggal BETWEEN '"& InvAR_tgla &"' and '"& InvAR_tgle &"' GROUP BY  MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal, MKT_T_PengeluaranSC_H.psc_custID, MKT_T_Faktur_Penjualan.InvARTotalLine "
                                    'Response.Write FakturPenjualan_CMD.commandText & "<br>"
                                    set Faktur = FakturPenjualan_CMD.execute
                                end if 
                            %>
                            <% 
                                no = 0
                                do while not Faktur.eof 
                                no = no+1
                            %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td class="text-center"> 
                                        <%=CDate(Faktur("InvARTanggal"))%>
                                        <input type="hidden" name="permID" id="permID<%=no%>" value="<%=Faktur("InvARID")%>">
                                    </td>
                                    <td class="text-center"> <%=Faktur("InvARID")%> </td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(Faktur("InvARTotalLine")),"$","Rp. ")%> </td>
                                    <% GrandTotal = GrandTotal + Faktur("InvARTotalLine") %>
                                <tr>
                            <% 
                                Faktur.movenext
                                loop 
                            %>
                            </tbody>
                            <thead>
                                <tr>
                                    <th colspan="3" class="text-center"> GRAND TOTAL</th>
                                    <th class="text-center"> 
                                        <input class="text-center"type="text" name="totalnilai" id="totalnilai"  value="<%=Replace(FormatCurrency(GrandTotal),"$","Rp. ")%>" style=" width:9rem; font-weight:bold;border:none"> 
                                    </th>
                                </tr>
                            </thead>
                        </table>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <span class="txt-desc"> Bekasi, ...........................</span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6">
                        <span class="txt-desc"> Yang Menyerahkan, </span>
                    </div>
                    <div class="col-3">
                        <span class="txt-desc"> Yang Mengetahui, </span>
                    </div>
                    <div class="col-2">
                        <span class="txt-desc"> Yang Menerima, </span>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-6 mt-4">
                        <span class="txt-desc"> <u>.......................................</u> </span>
                    </div>
                    <div class="col-3 mt-4">
                        <span class="txt-desc"> <u>......................................</u> </span>
                    </div>
                    <div class="col-2 mt-4">
                        <span class="txt-desc"> <u>......................................</u> </span>
                    </div>
                </div>
                <!--<div class="row mt-4">
                    <div class="col-12">
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:11px;border:1px solid black">
                            <thead class="text-center">
                                <tr>
                                    <th> Tanggal </th>
                                    <th> No Kwitansi </th>
                                    <th> Nilai </th>
                                </tr>
                            </thead>
                            <tbody class="text-center">
                                <tr>
                                    <td> <%'=Kwitansi("KWTanggal")%> </td>
                                    <td> <%'=Kwitansi("KWID")%> </td>
                                    <td> <%'=Kwitansi("KWTotalLine")%> </td>
                                    <%
                                        'KWTotalNilai = KWTotalNilai + Kwitansi("KWTotalLine")
                                    %>
                                </tr>
                            </tbody>
                            <thead class="text-center">
                                <tr>
                                    <th colspan="2"> Total Tagihan </th>
                                    <th><%'=KWTotalNilai%> </th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>-->
            </div>
        </div>
    </div>
</body>
    <script>
            var total = document.getElementById('totalnilai').value;
            
            var	reverse1 = total.toString().split('').reverse().join('');
            var ribuan1 	= reverse1.match(/\d{1,3}/g);
                ribuan1	= ribuan1.join('.').split('').reverse().join('');
            
            // Cetak hasil	
            document.getElementById('totalnilai').value = ("Rp."+ribuan1);
    </script>

    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>