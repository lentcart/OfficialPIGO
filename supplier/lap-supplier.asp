<!--#include file="../Connections/pigoConn.asp" -->
<%

	dim Supplier
    set Supplier_cmd = server.createObject("ADODB.COMMAND")
	Supplier_cmd.activeConnection = MM_PIGO_String
			
	Supplier_cmd.commandText = "SELECT* FROM [PIGO].[dbo].[MKT_M_Supplier] where spAktifYN = 'Y' " 
	set Supplier = Supplier_cmd.execute

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-Supplier - " & now() & ".xls"
%>
<!doctype html>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PIGO</title>
    </head>
<body>
    <table class="table table-bordered table-condensed">
        <thead>
            <tr>
                <th class="text-center col-xs-1">ID Supplier</th>
                <th class="text-center col-xs-1">Nama Supplier</th>
                <th class="text-center col-xs-1" colspan="4">Kontak</th>
                <th class="text-center col-xs-1" colspan="2">Alamat Supplier</th>
                <th class="text-center col-xs-1" colspan="2" >Keterangan</th>
            </tr>
        </thead>
        <tbody>
        <%do while not Supplier.eof%>
            <tr>
                <td class="text-center"><%=Supplier("spID")%></td>
                <td class="text-center"><%=Supplier("spNama")%></td>
                <td class="text-center"><%=Supplier("spTelp1")%></td>
                <td class="text-center"><%=Supplier("spTelp2")%></td>
                <td class="text-center"><%=Supplier("spTelp3")%></td>
                <td class="text-center"><%=Supplier("spEmail")%></td>
                <td class="text-center"><%=Supplier("spAlmLengkap")%></td>
                <td class="text-center"><%=Supplier("spAlmProvinsi")%></td>
                <td class="text-center"><%=Supplier("spDesc")%></td>
                <td class="text-center"><%=Supplier("spUpdateTime")%></td>
            </tr>
        <%Supplier.movenext
        loop%>
        </tbody>
    </table>
</body>
</html>