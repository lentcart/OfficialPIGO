<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    dim TanggalAwal,TanggalAkhir,JenisWallet,ReportJenis,ReportTipe,Tgla,Tgle,ReportNama,DownloadReport

    TanggalAwal         = CDate(Request.queryString("TanggalAwal"))
    TanggalAkhir        = CDate(Request.queryString("TanggalAkhir"))
    JenisWallet         = Request.queryString("WallJenis")
    ReportJenis         = Request.queryString("WallJenis")
    ReportTipe          = Request.queryString("ReportTipe")
    Tgla                =  day(TanggalAwal)  & month(TanggalAwal)   & year(TanggalAwal)
    Tgle                =  day(TanggalAkhir) & month(TanggalAkhir)  & year(TanggalAkhir)
    ReportNama          = "PIGO-ReportSeller-"& Request.queryString("WallJenisDesc") &"-"& Tgla &"-"& Tgle &".xls"


    if TanggalAwal="" or TanggalAkhir = "" then
        FillterTanggal = ""
    else
        FillterTanggal = " AND Wall_DateAcc BETWEEN '"& TanggalAwal &"' AND '"& TanggalAkhir &"' "
    end if

	set Report_CMD = server.createObject("ADODB.COMMAND")
	Report_CMD.activeConnection = MM_PIGO_String

	Report_CMD.commandText = "SELECT MKT_M_Seller.slName FROM MKT_M_Seller RIGHT OUTER JOIN MKT_T_SaldoSeller ON MKT_M_Seller.sl_custID = MKT_T_SaldoSeller.Wall_SellerID WHERE Wall_SellerID = '"& request.Cookies("custID") &"' "
	set Seller = Report_CMD.execute

	Report_CMD.commandText = "SELECT * FROM [pigo].[dbo].[MKT_T_SaldoSeller] WHERE Wall_Jenis = '"& JenisWallet &"' AND Wall_SellerID = '"& request.Cookies("custID") &"' "& FillterTanggal &" AND Wall_Status = 'C' ORDER BY Wall_UpdateTime DESC"
	set SaldoSeller = Report_CMD.execute

	Report_CMD.commandText = "SELECT COUNT(Wall_ID) AS JumlahTransaksiK, ISNULL(SUM(Wall_Amount),0) AS TotalK FROM MKT_T_SaldoSeller WHERE (Wall_Jenis = '01') AND Wall_SellerID = '"& request.Cookies("custID") &"' "& FillterTanggal &" AND Wall_Status = 'C' "
	set Kredit = Report_CMD.execute

	Report_CMD.commandText = "SELECT COUNT(Wall_ID) AS JumlahTransaksiD, ISNULL(SUM(Wall_Amount),0) AS TotalD FROM MKT_T_SaldoSeller WHERE (Wall_Jenis = '02') AND Wall_SellerID = '"& request.Cookies("custID") &"' "& FillterTanggal &" AND Wall_Status = 'C'  "
	set Debit = Report_CMD.execute

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename="& ReportNama 

%>

<table class="table" >
    <tr>
        <td colspan="7" class="text-start" style="font-size:20px"><b> REKENING KORAN - OFFICIAL PIGO </b></td>
    </tr>
    <tr>
        <td colspan="7" class="text-start"> PERIODE LAPORAN : <%=TanggalAwal%> S.D <%=TanggalAkhir%></td>
    </tr>
    <tr>
        <td colspan="7" class="text-start" > Nama Seller : <%=Seller("SlName")%></td>
    </tr>
    <tr>
        <th> <br> </th>
    </tr>

    <tr>
        <td><b> RINGKASAN </b></td>
    </tr>
    <tr>
        <td colspan="3" class="text-Center"> Kredit  </td>
        <td class="text-start">  </td>
        <td colspan="3" class="text-Center"> Debit  </td>
    </tr>
    <tr>
        <td colspan="3" class="text-start"> Jumalah Transaksi : <%=Kredit("JumlahTransaksiK")%> </td>
        <td class="text-start">  </td>
        <td colspan="3" class="text-start"> Jumalah Transaksi : <%=Debit("JumlahTransaksiD")%> </td>
    </tr>
    <tr>
        <td colspan="3" class="text-start"> Total : <%=Kredit("TotalK")%> </td>
        <td class="text-start">  </td>
        <td colspan="3" class="text-start"> Total : <%=Debit("TotalD")%> </td>
    </tr>

    <tr>
        <th> NO </th>
        <th> TANGGAL </th>
        <th> JENIS PENERIMAAN </th>
        <th> JUMLAH </th>
        <th> DESKRIPSI </th>
        <th> STATUS </th>
        <th> SALDO </th>
    </tr>
    <%
        no = 0
        do while not SaldoSeller.eof
        no = no + 1
    %>
    <tr>
        <td> <%=no%> </td>
        <td> <%=SaldoSeller("Wall_DateAcc")%> </td>
        <% if SaldoSeller("Wall_Jenis") = "01" then %>
        <td> Saldo Seller </td>
        <% else if SaldoSeller("Wall_Jenis") = "02" then%>
        <td> Rekening Seller </td>
        <% end if %> <% end if %>
        <td> <%=SaldoSeller("Wall_Amount")%> </td>
        <td> <%=SaldoSeller("Wall_Desc")%> </td>
        <% if SaldoSeller("Wall_Status") = "C" then %>
        <td> Complete </td>
        <% else %>
        <td> Waiting </td>
        <% end if %>
        <td> <%=SaldoSeller("Wall_Saldo")%> </td>
        
    </tr>
    <%
        SaldoSeller.movenext
        loop
    %>
</table>