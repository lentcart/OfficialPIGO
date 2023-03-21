<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_Produk WHERE pd_custID = '"& request.Cookies("custID") &"' "
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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Dashboard/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
        $(document).ready(function() {
            $('#example').DataTable( {
            });
        });
    </script>
    </head>
<body>
<!-- side -->
    <!--#include file="../../side.asp"-->
<!-- side -->
    <div class="main-body" style="overflow-y:scroll">
        <table id="example" class="display" style="width:100%">
        <thead>
            <tr>
                <th>Nama Produk</th>
                <th>Type Produk</th>
                <th>Harga</th>
                <th>Stok</th>
                <th>SKU/Part Number</th>
            </tr>
        </thead>
        <tbody>
        <% do while not Produk.eof %>
            <tr>
                <td><%=Produk("pdNama")%></td>
                <td><%=Produk("pdType")%></td>
                <td><%=Produk("PdHargaJual")%></td>
                <td><%=Produk("pdStok")%></td>
                <td><%=Produk("pdSku")%></td>
            </tr>
        <% Produk.movenext
        loop%>
        </tbody>
    </table>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>