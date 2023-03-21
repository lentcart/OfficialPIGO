<!--#include file="../../../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")

    
    id = request.queryString("custID")
    if id = "" then
        id = "Xh868hdgXJuy86"
        set Penjualan_CMD = server.createObject("ADODB.COMMAND")
        Penjualan_CMD.activeConnection = MM_PIGO_String

            Penjualan_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID,MKT_T_Permintaan_Barang_H.Perm_custID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_spID, MKT_T_Permintaan_Barang_H.Perm_stID, MKT_T_StatusTransaksi.strName, MKT_T_StatusPembayaran.spName,  MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_T_Permintaan_Barang_H.Perm_trYN FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Permintaan_Barang_H.Perm_stID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_StatusPembayaran ON MKT_T_Permintaan_Barang_H.Perm_spID = MKT_T_StatusPembayaran.spID ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') AND  Perm_custID = '"& id &"'  GROUP BY MKT_T_Permintaan_Barang_H.PermID,MKT_T_Permintaan_Barang_H.Perm_custID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_spID, MKT_T_Permintaan_Barang_H.Perm_stID, MKT_T_StatusTransaksi.strName, MKT_T_StatusPembayaran.spName,  MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_T_Permintaan_Barang_H.Perm_trYN"
            'response.write Penjualan_CMD.commandText

        set Penjualan = Penjualan_CMD.execute
    else 
    id = Split(request.queryString("custID"),",")
    for each x in id
        if len(x) > 0 then

            filtercust = filtercust & addOR & " MKT_T_Permintaan_Barang_H.Perm_custID = '"& x &"' "

            addOR = " or " 
                    
        end if

    next

        if filtercust <> "" then
            FilterFix = "( " & filtercust & " )" 
        end if

    response.write FilterFix

    set Penjualan_CMD = server.createObject("ADODB.COMMAND")
	Penjualan_CMD.activeConnection = MM_PIGO_String

    if tgla = "" & tgle = "" then
        Penjualan_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID,MKT_T_Permintaan_Barang_H.Perm_custID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_spID, MKT_T_Permintaan_Barang_H.Perm_stID, MKT_T_StatusTransaksi.strName, MKT_T_StatusPembayaran.spName,  MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_T_Permintaan_Barang_H.Perm_trYN FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Permintaan_Barang_H.Perm_stID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_StatusPembayaran ON MKT_T_Permintaan_Barang_H.Perm_spID = MKT_T_StatusPembayaran.spID ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') AND  Perm_custID ='sdfsdgsgdrigjiregihge'  GROUP BY MKT_T_Permintaan_Barang_H.PermID,MKT_T_Permintaan_Barang_H.Perm_custID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_spID, MKT_T_Permintaan_Barang_H.Perm_stID, MKT_T_StatusTransaksi.strName, MKT_T_StatusPembayaran.spName,  MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_T_Permintaan_Barang_H.Perm_trYN"
        response.write Penjualan_CMD.commandText

        set Penjualan = Penjualan_CMD.execute
    else
        Penjualan_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID,MKT_T_Permintaan_Barang_H.Perm_custID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_spID, MKT_T_Permintaan_Barang_H.Perm_stID, MKT_T_StatusTransaksi.strName, MKT_T_StatusPembayaran.spName,  MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_T_Permintaan_Barang_H.Perm_trYN FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Permintaan_Barang_H.Perm_stID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_StatusPembayaran ON MKT_T_Permintaan_Barang_H.Perm_spID = MKT_T_StatusPembayaran.spID ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') AND PermTanggal between '"& tgla &"' and '"& tgle &"' AND "& FilterFix &"  GROUP BY MKT_T_Permintaan_Barang_H.PermID,MKT_T_Permintaan_Barang_H.Perm_custID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_spID, MKT_T_Permintaan_Barang_H.Perm_stID, MKT_T_StatusTransaksi.strName, MKT_T_StatusPembayaran.spName,  MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_T_Permintaan_Barang_H.Perm_trYN"
        response.write Penjualan_CMD.commandText

        set Penjualan = Penjualan_CMD.execute

        
        end if

    end if
%>
<% if Penjualan.eof = true then %>

    <tr>
        <td colspan="9" class="text-center"> DATA TIDAK DITEMUKAN </td>
    </tr>

<% else %>
<% 
    no = 0 
    do while not Penjualan.eof 
    no = no + 1
%>
    <tr>
        <td class="text-center"> <%=no%> </td>
        <td class="text-center"> 
            <%=Day(Penjualan("PermTanggal"))%>/<%=Month(Penjualan("PermTanggal"))%>/<%=Year(Penjualan("PermTanggal"))%> 
        </td>
        <td> <%=Penjualan("PermNo")%> </td>
        <% if Penjualan("Perm_trYN") = "N" then %>
        <td class="text-center"> PNJ-PURCORDER </td>
        <% else %>
        <td class="text-center"> PNJ-TRANSWEB </td>
        <% end if %>
        <td> <%=Penjualan("custNama")%> </td>
        <td class="text-center"> <%=Penjualan("almProvinsi")%> </td>
        <% if Penjualan("Perm_trYN") = "N" then %>
            <td class="text-center"> KREDIT </td>
            <td class="text-center"> PICK-UP </td>
        <% else %>
            <%
                Penjualan_CMD.commandText = "SELECT MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.tr_rkNomorRk, MKT_T_Transaksi_H.tr_rkBankID, MKT_T_Transaksi_D1.trPengiriman FROM MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1,12) WHERE MKT_T_Transaksi_H.tr_custID = '"& Penjualan("Perm_custID") &"' and MKT_T_Transaksi_H.trID = '"& Penjualan("PermNo") &"' GROUP BY MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.tr_rkNomorRk, MKT_T_Transaksi_H.tr_rkBankID, MKT_T_Transaksi_D1.trPengiriman "
                'response.write Penjualan_CMD.commandText
                set Pembayaran = Penjualan_CMD.execute
            %>
            <td class="text-center"> <%=Pembayaran("trJenisPembayaran")%> </td>
            <td class="text-center"> <%=Pembayaran("trPengiriman")%> </td>
        <% end if %>

        <td class="text-center"> <%=Penjualan("strName")%> </td>
        <td class="text-center"> <%=Penjualan("spName")%> </td>
        <% if Penjualan("Perm_trYN") = "N" then %>
        <td class="text-center"> <button class="cont-btn"> DETAIL-TRANS </button></td>
        <% else %>
        <td class="text-center"> <button class="cont-btn"> INVOICE-TRANS </button></td>
        <% end if %>
                            </tr>
<% Penjualan.movenext
loop %>
<% end if %>