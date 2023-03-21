<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    ' id = request.queryString("custID")
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))
    'response.write tahun &"<BR>"


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    'response.write tgla &"<BR>"
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))

    id = Split(request.queryString("custID"),",")

    for each x in id
            if len(x) > 0 then

                    filtercust = filtercust & addOR & " MKT_T_Permintaan_Barang_H.Perm_custID = '"& x &"' "

                    addOR = " or " 
                    
            end if
        next

        if filtercust <> "" then
            FilterFix = "and  ( " & filtercust & " )" 
        end if

        ' response.write FilterFix


    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and MKT_T_Permintaan_Barang_H.PermTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID = 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Penjualan_CMD = server.createObject("ADODB.COMMAND")
	Penjualan_CMD.activeConnection = MM_PIGO_String
			
	Penjualan_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') "& FilterFix &" "& filterTanggal &"  AND PermTujuan = '1' GROUP BY MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,MKT_M_Customer.custID"
    'response.write Penjualan_CMD.commandText
	set BussinesPartner = Penjualan_CMD.execute

%>
<table>
    <tr>
        <th> LAPORAN PENJUALAN </th>
    </tr>
    <tr>
        <th> PERIODE : <%=tgla%> s.d <%=tgle%> </th>
    </tr>
    <tr>
        <th><br></th>
    </tr>
    <% 
        do while not BussinesPartner.eof 
    %>
    <tr>
        <td> BUSSINES PARTNER </td>
        <td> <%=BussinesPartner("custNama")%> </td>
    </tr>
    <% 
        BussinesPartner.movenext
        loop
    %>
</table>