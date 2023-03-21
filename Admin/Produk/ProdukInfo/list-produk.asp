<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    mrID = request.queryString("mrID")    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String
			
	Produk_cmd.commandText = "SELECT MKT_M_PIGO_Produk.*, MKT_M_Tax.TaxRate FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID Where pd_mrID = '"& mrID &"'"
    'response.write Produk_cmd.commandText
	set Produk = Produk_cmd.execute


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
            document.title = "List-Harga-Produk-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";
    </script>
    <style>
            body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            font-size: 13px;
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
                <div class="row align-items-center">
                    <div class="col-1">
                        <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                    </div>
                    <div class="col-11 text-end">
                        <span class="Judul-Merchant" style="font-size:22px"> <b><%=Merchant("custNama")%> </b></span><br>
                        <span class="txt-desc"> <%=Merchant("almLengkap")%> </span><br>
                        <span class="txt-desc"> <%=Merchant("custEmail")%> </span><br>
                        <span class="txt-desc"> <%=Merchant("custPhone1")%> </span> / <span class="txt-desc"> <%=Merchant("custPhone2")%> </span><br>
                        
                    </div>
                </div>
                <div class="row mt-2" style="border-bottom:3px solid black">
                </div>

                <div class="row text-center mt-2">
                    <div class="col-12">
                        <span class="txt-desc" style="font-size:20px"><u> DAFTAR HARGA JUAL PRODUK  </u></span><br>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <table class="table cont-tb tb-transaksi table-bordered table-condensed mt-1" style="font-size:13px; color:black">
                            <thead>
                                <tr>
                                    <th class="text-center"> NO </th>
                                    <th class="text-center"> DETAIL PRODUK </th>
                                    <th class="text-center"> SKU / PART NUMBER </th>
                                    <th class="text-center"> HARGA SEBELUM PPN </th>
                                    <th class="text-center"> HARGA SETELAH PPN </th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    no = 0 
                                    do while not produk.eof
                                    no = no + 1 
                                %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td> <%=produk("pdNama")%> </td>
                                    <td> <%=produk("pdPartNumber")%> </td>
                                    <%

                                        Harga = produk("pdHarga")
                                        UpTo  = Harga+(Harga*produk("pdUpTo")/100)
                                        Tax   = UpTo*produk("TaxRate")/100
                                        SebelumPPN = round(UpTo)
                                        SetelahPPN = round(UpTo+Tax)
                                        
                                    %>
                                    <td class="text-center"> <%=Replace(Replace(Replace(FormatCurrency(SebelumPPN),"$","Rp. "),",","."),".00",",-")%> </td>
                                    <td class="text-center"> <%=Replace(Replace(Replace(FormatCurrency(SetelahPPN),"$","Rp. "),",","."),".00",",-")%> </td>
                                </tr>
                                <% produk.movenext
                                loop%>
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>
            </div>    
        </div>
    </div>
</body>
<script>
</script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>