<!--#include file="../Connections/pigoConn.asp" -->
<%
    id = request.queryString("spID")

	dim Supplier
    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String
			
	Supplier_cmd.commandText = "SELECT * FROM [PIGO].[dbo].[MKT_M_Supplier] where spID = '"& id &"' " 
	set Supplier = Supplier_cmd.execute

	dim Supplier_P
    set Supplier_P_cmd = server.createObject("ADODB.COMMAND")
	Supplier_P_cmd.activeConnection = MM_PIGO_String
			
	Supplier_P_cmd.commandText = "SELECT * FROM [PIGO].[dbo].[MKT_M_Supplier_P] where sp_spNama = '"& id &"' " 
	set Supplier_P = Supplier_P_cmd.execute

    ' Response.ContentType = "application/vnd.ms-excel"
    ' Response.AddHeader "content-disposition", "filename=Lap-Detail-Supplier - " & now() & ".xls"

%>

<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="penjualan.css">
    <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
    <script src="../js/jquery-3.6.0.min.js"></script>
    
    <script>
        
    </script>
    </head>
<body>
    <div class="container invoice">
        <div class="row">
            <div class="col-8">
                <a href="../Laporan/Lap-penjualan.asp" class="text-a"> Kembali </a>
            </div>
        </div>
        <div class="invoice-header">
            <div class="row align-items-center">
                <div class="col-1">
                        <div class="media-left">
                            <img src="<%=base_url%>/assets/logo1.jpg" class="rounded-pill" class="logo" alt="" width="65" height="65" />
                        </div>
                </div>
                <div class="col-4">
                    <div class="media">
                        <ul class="media-body list-unstyled">
                            <li><strong>PIGO Official</strong></li>
                        </ul>
                    </div>
                </div>
                <div class="col-7">
                    <div class="media">
                        <ul class="media-body list-unstyled">
                            <li><strong>Jl. Alternatif Cibubur,Komplek Ruko Cibubur Point Automotive Center Blok B/12B, Harjamukti, CIMANGGIS. DEPOK</strong></li>
                            <li>0811-0811-118</li>
                            <li>otopigo.sekertariat@gmail.com</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="invoice-body">
            <div class="row">
                <div class="col-3">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <span> Nama Supplier </span><br>
                            <span> Nomor Telepon </span><br>
                            <span> Email </span><br>
                            <span> Alamat Lengkap </span><br>
                            <span> Lokasi </span><br>
                            <span> Desc </span><br>
                        </div>
                    </div>
                </div>
                <div class="col-1">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <span> : </span><br>
                            <span> : </span><br>
                            <span> : </span><br>
                            <span> : </span><br>
                            <span> : </span><br>
                            <span> : </span><br>
                        </div>
                    </div>
                </div>
                <div class="col-7">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <span><%=Supplier("spNama")%></span><br>
                            <span><%=Supplier("spTelp1")%>,<%=Supplier("spTelp2")%>,<%=Supplier("spTelp3")%></span><br>
                            <span><%=Supplier("spEmail")%></span><br>
                            <span><%=Supplier("spAlmLengkap")%></span><br>
                            <span><%=Supplier("spAlmProvinsi")%></span><br>
                            <span><%=Supplier("spDesc")%></span><br>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h5 class="panel-title mb-3">Produk Supplier</h5>
                </div>
                <table class="table table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th class="text-center"> Kode Produk </th>
                            <th class="text-center"> Nama Produk </th>
                            <th class="text-center"> Tanggal Pembelian </th>
                            <th class="text-center"> Jumlah </th>
                            <th class="text-center"> Harga </th>
                            <th class="text-center"> Total </th>
                        </tr>
                    </thead>
                    <tbody>
                    <%do while not Supplier_P.eof%>
                        <tr>
                            <td><%=Supplier_P("sp_pdID")%></td>
                            <td><%=Supplier_P("sp_pdNama")%></td>
                            <td><%=Supplier_P("sp_pdTglPembelian")%></td>
                            <td ><input class="text-right"type="text" name="qty" id="qty" value="<%=Supplier_P("sp_pdQty")%>" style="text-align: right;border:none; width:8rem" readonly ></td>
                            <td ><input class="text-right"type="text" name="qty" id="qty" value="<%=Supplier_P("sp_pdHarga")%>" style="text-align: right;border:none; width:8rem" readonly ></td>
                            <td>0</td>
                        </tr>
                    <%Supplier_P.movenext
                    loop%>
                        <tr>
                            <td class="text-center"colspan="5">Sub Total</td>
                            <td >0</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="row" style="text-align:right">
                <div class="col-12">
                <a href="lap-pembelianbarang.asp?spID=<%=Supplier("spID")%>"> Eksport To Excel </a>
                </div>
            </div>
        </div>
        <div class="invoice-footer">
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
    <script src="../js/bootstrap.js"></script>
    <script src="../js/popper.min.js"></script>
</html>