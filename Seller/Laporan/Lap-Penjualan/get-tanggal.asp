<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")


    id = Split(request.queryString("customerid"),",")

    for each x in id
            if len(x) > 0 then

                    filtercust = filtercust & addOR & " MKT_T_Transaksi_H.tr_custID = '"& x &"' "

                addOR = " or " 

            end if
        next

        if filtercust <> "" then
            FilterFix = "and  ( " & filtercust & " )" 
        end if

    set Transaksi_cmd = server.createObject("ADODB.COMMAND")
	Transaksi_cmd.activeConnection = MM_PIGO_String
			
	Transaksi_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.trD1A, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdID,  MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi,  MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.tr_strID, MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_M_Produk.pdID,  MKT_M_Produk.pdNama, MKT_M_Produk.pdType, MKT_M_Produk.pdSku, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Produk.pd_catID, MKT_M_Kategori.catID, MKT_M_Kategori.catName FROM MKT_M_Kategori RIGHT OUTER JOIN MKT_M_Produk ON MKT_M_Kategori.catID = MKT_M_Produk.pd_catID RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID  WHERE  MKT_T_Transaksi_D1.tr_slID  = '"& request.Cookies("custID") &"' and  MKT_T_Transaksi_D1.tr_strID = '03'  "& FilterFix & "and trTglTransaksi between '"  & tgla & "' and '"  & tgle & "' GROUP BY MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.trD1A, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdID,  MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi,  MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.tr_strID, MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_M_Produk.pdID,  MKT_M_Produk.pdNama, MKT_M_Produk.pdType, MKT_M_Produk.pdSku, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Produk.pd_catID, MKT_M_Kategori.catID, MKT_M_Kategori.catName   "
    'response.write Transaksi_cmd.commandText
	set Transaksi = Transaksi_cmd.execute
    
%>

<% do while not Transaksi.eof %>
    <tr>
        <td class="text-center"> <%=Transaksi("trID")%> - <%=CDate(Transaksi("trTglTransaksi"))%> </td>
        <td class="text-center"> <%=Transaksi("trJenisPembayaran")%> </td>
        <td> <%=Transaksi("custNama")%> [<%=Transaksi("custEmail")%>]</td>
        <td class="text-center"> <%=Replace(FormatCurrency(Transaksi("trBiayaOngkir")),"$","Rp. ")%></td>
        <td> <%=Transaksi("pdNama")%> </td>
        <td class="text-center"> <%=Replace(FormatCurrency(Transaksi("tr_pdHarga")),"$","Rp. ")%> </td>
        <td class="text-center"> <%=Transaksi("tr_pdQty")%> </td>
        <% totalpembelian = Transaksi("trBiayaOngkir")+Transaksi("tr_pdHarga")*Transaksi("tr_pdQty")%>
        <td class="text-center"> <%=Replace(FormatCurrency(totalpembelian),"$","Rp. ")%> </td>
    </tr>
<% Transaksi.movenext
loop %>
