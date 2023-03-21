<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    PermID = request.queryString("permid")
    PermTanggal = request.queryString("permtanggal")

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Permintaan_cmd = server.createObject("ADODB.COMMAND")
	Permintaan_cmd.activeConnection = MM_PIGO_String
			
	Permintaan_cmd.commandText = "SELECT PermID, PermTanggal FROM MKT_T_Permintaan_Barang_H Where PermID = '"& PermID &"'" 
    'response.write Permintaan_cmd.commandText
	set Permintaan = Permintaan_cmd.execute

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
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
    <script>
        var today = new Date();

        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        document.title = "BuktiPermintaanBarang-<%=PermID%>-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
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
                <!--#include file="../../HeaderPIGOA4.asp"-->
                <div class="row mt-2">
                    <div class="col-2">
                        <span class="txt-desc"> No Permintaan </span><br>
                        <span class="txt-desc"> Tanggal </span><br>
                    </div>
                    <div class="col-10">
                        <span class="txt-desc"> : </span>&nbsp;&nbsp;&nbsp;<span class="txt-desc"> <%=PermID%> </span><br>
                        <span class="txt-desc"> : </span>&nbsp;&nbsp;&nbsp;<span class="txt-desc"> <%=day(Permintaan("PermTanggal"))%>&nbsp;<%=MonthName(Month(Permintaan("PermTanggal")))%>&nbsp;<%=Year(Permintaan("PermTanggal"))%></span><br>
                    </div>
                </div>
                <div class="row mt-3 mb-3 text-center">
                    <div class="col-12">
                        <span class="txt-desc" style="font-size:21px"><u><b> PERMINTAAN SUKU CADANG BARU </b></u></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                            </div>
                            <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:11px">
                            <thead>
                                <tr>
                                    <th class="text-center"> No </th>
                                    <th class="text-center"> SKU/Part Number </th>
                                    <th class="text-center"> Nama Produk </th>
                                    <th class="text-center"> QTY </th>
                                    <th class="text-center"> Satuan </th>
                                </tr>
                                
                            </thead>
                            <tbody>
                            <%
                                Permintaan_cmd.commandText = "SELECT MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber,  MKT_T_Permintaan_Barang_D.Perm_IDH, MKT_M_PIGO_Produk.pdUnit FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_M_PIGO_Produk.pdID = MKT_T_Permintaan_Barang_D.Perm_pdID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_H.PermID = '"& Permintaan("PermID") &"' "
                                'response.write Permintaan_cmd.commandText
                                set Produk = Permintaan_cmd.execute 
                            %>
                            <% 
                                no = 0
                                do while not Produk.eof
                                no = no + 1 
                            %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td class="text-center"> <%=Produk("pdPartNumber")%> </td>
                                    <td> <%=Produk("pdNama")%> </td>
                                    <td class="text-center"> <%=Produk("Perm_pdQty")%> </td>
                                    <td class="text-center"> <%=Produk("pdUnit")%> </td>
                                </tr>
                            <% Produk.movenext
                            loop%>
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>
                <div class="row text-center" style="margin-top:2rem">
                    <div class="col-6">
                    <span class="txt-desc">  </span><br>
                        <span class="txt-desc"> Di Setujui Oleh </span>
                        <br>
                        <br>
                        <br>
                        <br>
                        <span><b>...................................</b></span>
                    </div>
                    <div class="col-6">
                    <span class="txt-desc"> Tanggal,................................................ </span><br>
                        <span class="txt-desc"> Di Buat Oleh </span>
                        <br>
                        <br>
                        <br>
                        <br>
                        <span><b>...................................</b></span>
                    </div>
                </div>          
            </div>          
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>