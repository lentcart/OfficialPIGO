<!--#include file="../Connections/pigoConn.asp" -->
<%
    id = request.queryString("spID")
    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))

    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and sp_pdTglPembelian between '"& tgla &"' and '"& tgle &"' "
    end if
	dim lappem
    set lappem_cmd = server.createObject("ADODB.COMMAND")
	lappem_cmd.activeConnection = MM_PIGO_String
			
	lappem_cmd.commandText = "SELECT dbo.MKT_M_Supplier.spID, dbo.MKT_M_Supplier.spNama, dbo.MKT_M_Supplier.spAlmLengkap, dbo.MKT_M_Supplier.spAlmProvinsi, dbo.MKT_M_Supplier.spTelp1, dbo.MKT_M_Supplier.spTelp2, dbo.MKT_M_Supplier.spTelp3, dbo.MKT_M_Supplier.spEmail, dbo.MKT_M_Supplier.spDesc, dbo.MKT_M_Supplier.spUpdateTime, dbo.MKT_M_Supplier_P.sp_pdID, dbo.MKT_M_Supplier_P.sp_spNama, dbo.MKT_M_Supplier_P.sp_pdNama, dbo.MKT_M_Supplier_P.sp_pdQty, dbo.MKT_M_Supplier_P.sp_pdHarga, dbo.MKT_M_Supplier_P.sp_pdType, dbo.MKT_M_Supplier_P.sp_pdMerk, dbo.MKT_M_Supplier_P.sp_pdKat, dbo.MKT_M_Supplier_P.sp_pdBerat, dbo.MKT_M_Supplier_P.sp_pdTinggi, dbo.MKT_M_Supplier_P.sp_pdLebar, dbo.MKT_M_Supplier_P.sp_pdPanjang, dbo.MKT_M_Supplier_P.sp_pdVolume, dbo.MKT_M_Supplier_P.sp_pdTglPembelian, dbo.MKT_M_Supplier_P.sp_pdUpdateTime FROM dbo.MKT_M_Supplier LEFT OUTER JOIN dbo.MKT_M_Supplier_P ON dbo.MKT_M_Supplier.spID = dbo.MKT_M_Supplier_P.sp_spNama where dbo.MKT_M_Supplier.spID = '"& id &"' " & filterTanggal & " order by sp_pdTglPembelian "
    response.write  lappem_cmd.commandText
	set lappem = lappem_cmd.execute

    ' Response.ContentType = "application/vnd.ms-excel"
    ' Response.AddHeader "content-disposition", "filename=Lap-Detail-Supplier - " & now() & ".xls"
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
            <tr>
                <td class="text-center"><%=lappem("spID")%></td>
                <td class="text-center"><%=lappem("spNama")%></td>
                <td class="text-center"><%=lappem("spTelp1")%></td>
                <td class="text-center"><%=lappem("spTelp2")%></td>
                <td class="text-center"><%=lappem("spTelp3")%></td>
                <td class="text-center"><%=lappem("spEmail")%></td>
                <td class="text-center"><%=lappem("spAlmLengkap")%></td>
                <td class="text-center"><%=lappem("spAlmProvinsi")%></td>
                <td class="text-center"><%=lappem("spDesc")%></td>
                <td class="text-center"><%=lappem("spUpdateTime")%></td>
            </tr>
        </tbody>
    </table>
    <table class="table table-bordered table-condensed mt-4">
        <thead>
            <tr>
                <th class="text-center col-xs-1" >Time Update</th>
                <th class="text-center col-xs-1">Kode Barang</th>
                <th class="text-center col-xs-1">Nama Barang</th>
                <th class="text-center col-xs-1">Tanggal Pembelian Barang</th>
                <th class="text-center col-xs-1" colspan="3">Keterangan</th>
                <th class="text-center col-xs-1">Harga Satuan Barang</th>
                <th class="text-center col-xs-1">Jumlah Barang</th>
            </tr>
        </thead>
        <tbody>
        <%do while not lappem.eof%>
            <tr>
                <td class="text-center"><%=lappem("spUpdateTime")%></td>
                <td class="text-center"><%=lappem("sp_pdID")%></td>
                <td class="text-center"><%=lappem("sp_pdNama")%></td>
                <td class="text-center"><%=lappem("sp_pdTglPembelian")%></td>
                <td class="text-center"><%=lappem("sp_pdKat")%></td>
                <td class="text-center"><%=lappem("sp_pdType")%></td>
                <td class="text-center"><%=lappem("sp_pdMerk")%></td>
                <td class="text-center"><%=lappem("sp_pdHarga")%></td>
                <td class="text-center"><%=lappem("sp_pdQty")%></td>
            </tr>
        <%lappem.movenext
        loop%>
        </tbody>
    </table>
</body>
</html>