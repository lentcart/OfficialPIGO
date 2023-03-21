    <!--#include file="../../Connections/pigoConn.asp" -->
<%

    SJID = request.queryString("SJID")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set SuratJalan_cmd = server.createObject("ADODB.COMMAND")
	SuratJalan_cmd.activeConnection = MM_PIGO_String
			
	SuratJalan_cmd.commandText = "SELECT MKT_T_SuratJalan_H.SJ_Tanggal, MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_H.SJ_pscID, MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_H.SJ_custID, MKT_M_Customer.custNama, MKT_M_Alamat.almLengkap, MKT_T_PengeluaranSC_H.psc_permID,  MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermNo FROM MKT_T_PengeluaranSC_H LEFT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_PengeluaranSC_H.psc_permID = MKT_T_Permintaan_Barang_H.PermID RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_T_PengeluaranSC_H.pscID = MKT_T_SuratJalan_H.SJ_pscID LEFT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID ON MKT_T_SuratJalan_H.SJ_custID = MKT_M_Customer.custID WHERE almJenis <> 'Alamat Toko' AND  MKT_T_SuratJalan_H.SJID = '"& SJID &"' "
    'response.write SuratJalan_cmd.commandText
	set SuratJalan = SuratJalan_cmd.execute


    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!--#include file="../IconPIGO.asp"-->

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
            document.title = "SuratJalan-<%=SJID%>-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";
        const myTimeout = setTimeout(myGreeting, 2000);

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
            <!--#include file="../HeaderPIGOA4.asp"-->
            <% do while not SuratJalan.eof %>
            <div class="row mt-2">
                <div class="col-7">
                    <div class="row">
                        <div class="col-2">
                            <span class="txt-desc"> Tanggal </span><br>
                            <span class="txt-desc"> Penerima </span><br>
                        </div>
                        <div class="col-10">
                            &nbsp;&nbsp; <span class="txt-desc"> : </span>&nbsp; <span class="txt-desc"><%=Day(CDate(SuratJalan("SJ_Tanggal")))%>&nbsp;<%=MonthName(Month(SuratJalan("SJ_Tanggal")))%>&nbsp;<%=Year(SuratJalan("SJ_Tanggal"))%></span><br>
                            &nbsp;&nbsp; <span class="txt-desc"> : </span>&nbsp; <span class="txt-desc"><%=SuratJalan("custNama")%></span><br>
                        </div>
                    </div>
                </div>
                <div class="col-5" style="text-align: justify">
                    <div class="row">
                        <div class="col-5">
                            <span class="txt-desc"> No Ref </span><br>
                            <span class="txt-desc"> Tanggal Ref </span><br>
                        </div>
                        <div class="col-7 p-0">
                            <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"><%=SuratJalan("PermNo")%></span><br>
                            <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"><%=Day(CDate(SuratJalan("PermTanggal")))%>&nbsp;<%=MonthName(Month(SuratJalan("PermTanggal")))%>&nbsp;<%=Year(SuratJalan("PermTanggal"))%></span><br>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-1">
                    <span class="txt-desc"> Alamat </span><br>
                </div>
                <div class="col-11 p-0">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="txt-desc">&nbsp;:</span>&nbsp;<span class="txt-desc">&nbsp;<%=SuratJalan("almLengkap")%></span><br>
                </div>
            </div>
            <div class="row text-center mt-2">
                <div class="col-12">
                    <span class="txt-desc" style="font-size:22px"><u>  SURAT JALAN  </u></span><br>
                    <span class="txt-desc">  <%=SuratJalan("SJID")%>/<%=CDATE(SuratJalan("SJ_Tanggal"))%>  </span><br>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        </div>
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:11px">
                        <thead style="background-color:#aaa">
                            <tr>
                                <th class="text-center"> NO </th>
                                <th class="text-center"> DETAIL PRODUK </th>
                                <th class="text-center"> UNIT </th>
                                <th class="text-center"> JUMLAH </th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            SuratJalan_cmd.commandText = "SELECT MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber,  MKT_T_PengeluaranSC_D.pscD_pdID, MKT_T_PengeluaranSC_D.pscD_pdQty, MKT_M_PIGO_Produk.pdUnit FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PengeluaranSC_D.pscD_pdID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON LEFT(MKT_T_PengeluaranSC_D.pscIDH,17) = MKT_T_PengeluaranSC_H.pscID RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_T_PengeluaranSC_H.pscID = MKT_T_SuratJalan_H.SJ_pscID WHERE MKT_T_SuratJalan_H.SJ_pscID = '"& SuratJalan("SJ_pscID") &"' and MKT_T_SuratJalan_H.SJID = '"& SJID &"' "
                            'response.write SuratJalan_cmd.commandText
                            set Produk = SuratJalan_cmd.execute
                        %>
                        <%
                            no = 0 
                            do while not Produk.eof
                            no = no + 1 
                        %>
                            <tr>
                                <td class="text-center"> <%=no%> </td>
                                <td> <b><%=Produk("pdPartNumber")%></b> &nbsp;-&nbsp; <%=Produk("pdNama")%> </td>
                                <td class="text-center"> <%=Produk("pdUnit")%> </td>
                                <td class="text-center"> <%=Produk("pscD_pdQty")%> </td>
                                <%
                                    total = total + Produk("pscD_pdQty")
                                %>
                            </tr>
                        <%
                            Produk.movenext
                            loop
                        %>
                            <tr>
                                <td colspan="3"> Total QTY </td>
                                <td class="text-center"> <%=total%> </td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
            <% SuratJalan.movenext
            loop %>  
            
            <div class="row text-center" style="margin-top:0.6rem">
                <div class="col-4">
                    <br>
                    <span class="txt-desc"> Dibuat Oleh,</span><br><br><br><br>
                    <span class="txt-desc"><u>...........................................</u></span><br>
                </div>
                <div class="col-4">
                    <br>
                    <span class="txt-desc"> Gudang,</span><br><br><br><br>
                    <span class="txt-desc"><u>...........................................</u></span><br>
                </div>
                <div class="col-4">
                    <span class="txt-desc"> Tanggal,.....................................</span><br>
                    <span class="txt-desc"> Diterima Oleh,</span><br><br><br><br>
                    <span class="txt-desc"><u>...........................................</u></span><br>
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