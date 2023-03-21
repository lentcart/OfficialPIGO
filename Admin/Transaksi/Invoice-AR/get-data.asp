<!--#include file="../../../Connections/pigoConn.asp" -->

<% 

    InvARBulan = request.queryString("InvARBulan")
    InvARTanggala = request.queryString("InvARTanggala")
    InvARTanggale = request.queryString("InvARTanggale")

    set FakturPenjualan_CMD = server.createObject("ADODB.COMMAND")
	FakturPenjualan_CMD.activeConnection = MM_PIGO_String
    if InvARTanggala = "" and InvARTanggale =  "" then 

    FakturPenjualan_CMD.commandText = "SELECT  MONTH(MKT_T_Faktur_Penjualan.InvARTanggal) AS bulan, MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal, MKT_T_PengeluaranSC_H.psc_custID, MKT_M_Customer.custNama, MKT_T_Faktur_Penjualan.InvARTotalLine, MKT_T_Faktur_Penjualan.InvARPPN,  MKT_T_Faktur_Penjualan.InvARGrandTotal FROM MKT_T_PengeluaranSC_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PengeluaranSC_H.psc_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_PengeluaranSC_H.pscID = MKT_T_Faktur_Penjualan.InvAR_pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D.pscID1_H WHERE  MONTH(MKT_T_Faktur_Penjualan.InvARTanggal) = '"& InvARBulan &"' "
    'Response.Write FakturPenjualan_CMD.commandText & "<br>"

    set rekapBulan = FakturPenjualan_CMD.execute

    else 

    FakturPenjualan_CMD.commandText = "SELECT  MONTH(MKT_T_Faktur_Penjualan.InvARTanggal) AS bulan, MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvARTanggal, MKT_T_PengeluaranSC_H.psc_custID, MKT_M_Customer.custNama, MKT_T_Faktur_Penjualan.InvARTotalLine, MKT_T_Faktur_Penjualan.InvARPPN,  MKT_T_Faktur_Penjualan.InvARGrandTotal FROM MKT_T_PengeluaranSC_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PengeluaranSC_H.psc_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_PengeluaranSC_H.pscID = MKT_T_Faktur_Penjualan.InvAR_pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D.pscID1_H WHERE  MKT_T_Faktur_Penjualan.InvARTanggal BETWEEN = '"& InvARTanggala &"' AND '"& InvARTanggale &"' "
    'Response.Write FakturPenjualan_CMD.commandText & "<br>"

    set rekapBulan = FakturPenjualan_CMD.execute

    end if 
%> 
<% 
    no = 0
    do while not rekapBulan.eof 
    no = no+1
%>
<tr>
    <td class="text-center"> <%=no%> </td>
    <td class="text-center"> <%=CDate(rekapBulan("InvARTanggal"))%><input type="hidden" name="permID" id="permID<%=no%>" value="<%=rekapBulan("InvARID")%>"></td>
    <td> <%=rekapBulan("InvARID")%> </td>
    <td> <%=rekapBulan("CustNama")%> </td>
    <td class="text-center"> <%=rekapBulan("InvARTotalLine")%> </td>
    <td class="text-center"> <%=rekapBulan("InvARPPN")%> </td>
    <td class="text-center"> <%=rekapBulan("InvARGrandTotal")%> </td>
</tr>
<% 
    rekapBulan.movenext
    loop 
%>