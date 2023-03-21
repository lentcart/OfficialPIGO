<!--#include file="../../../connections/pigoConn.asp"--> 

<% 
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    set PermintaanBarang_cmd = server.createObject("ADODB.COMMAND")
	PermintaanBarang_cmd.activeConnection = MM_PIGO_String

    tgla            = request.queryString("tgla")
    tgle            = request.queryString("tgle")
    PermJenis       = request.queryString("PermJenis")
    PermID          = request.queryString("PermID")

    if PermID = "" then
        if PermJenis = "" then
            PermintaanBarang_cmd.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_custID,  MKT_T_Permintaan_Barang_H.Perm_UpdateTime,  MKT_T_Permintaan_Barang_H.Perm_AktifYN, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almKota FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') and PermTanggal between '"& tgla &"' and '"& tgle &"' "
            'response.write PermintaanBarang_cmd.commandText 
            set PermintaanBarang = PermintaanBarang_cmd.execute
        else
            PermintaanBarang_cmd.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_custID,  MKT_T_Permintaan_Barang_H.Perm_UpdateTime,  MKT_T_Permintaan_Barang_H.Perm_AktifYN, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almKota FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') and PermJenis = '"& PermJenis &"' "
            'response.write PermintaanBarang_cmd.commandText 
            set PermintaanBarang = PermintaanBarang_cmd.execute
        end if
    else    
        PermintaanBarang_cmd.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_custID,  MKT_T_Permintaan_Barang_H.Perm_UpdateTime,  MKT_T_Permintaan_Barang_H.Perm_AktifYN, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almKota FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') and PermID LIKE '%"& PermID &"%' "
        'response.write PermintaanBarang_cmd.commandText 
        set PermintaanBarang = PermintaanBarang_cmd.execute
    end if 

%>
<% If PermintaanBarang.eof = true then %>
    <tr>
        <td class="text-center" colspan="8"> Data Tidak Ditemukan  </td>
    </tr>
<% else %>
    <% 
        no = 0 
        do while not PermintaanBarang.eof 
        no = no + 1
    %>
        <%
            PermintaanBarang_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Permintaan_Barang_D.Perm_pdID),0) AS PDID FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_H.PermID = '"& PermintaanBarang("PermID") &"'"
            'response.write PermintaanBarang_cmd.commandText 
            set Perm = PermintaanBarang_cmd.execute
        %>
        <%  if Perm("PDID") = 0 then  %>
            <tr style=" background-color:red">
                <td class="text-center"> <%=no%> </td>
                <td class="text-center">
                    <button class="cont-btn"> <%=PermintaanBarang("PermID")%> </button> 
                </td>
                <td class="text-center" colspan="6">  </td>
                <td class="text-center">  <button class="cont-btn"> DELETE </button></td>
            </tr>
        <%  else %>
            <tr>
                <td class="text-center"> <%=no%> </td>
                <td class="text-center"> 
                    <input type="hidden" name="PermID" id="PermID<%=no%>" value="<%=PermintaanBarang("PermID")%>">
                    <button class="cont-btn" onclick="window.open('bukti-permintaan.asp?PermID='+document.getElementById('PermID<%=no%>').value,'_Self')"> <%=PermintaanBarang("PermID")%> </button> 
                </td>
                <td class="text-center"> <%=PermintaanBarang("PermNo")%> </td>
                <td class="text-center"> 
                    <%=Day(CDATE(PermintaanBarang("PermTanggal")))%>/<%=Month(CDATE(PermintaanBarang("PermTanggal")))%>/<%=Year(CDATE(PermintaanBarang("PermTanggal")))%> 
                </td>
                <td> <%=PermintaanBarang("custNama")%> </td>
                <td class="text-center"> <%=PermintaanBarang("almKota")%> </td>

                <% If PermintaanBarang("PermTujuan") = "1" then %>
                <td class="text-center"> Penjualan </td>
                <% else %>
                <td class="text-center"> Pemakaian Sendiri </td>
                <% end if %>

                <% if PermintaanBarang("Perm_PSCBYN") = "N" then %>
                <td class="text-center"> <button onclick="window.open('../Pengeluaran-SCB/?PermID='+document.getElementById('PermID<%=no%>').value,'_Self')" class="cont-btn"> GENERATE PSC </td>
                <% else %>
                <td class="text-center"> <button class="cont-btn" style="background-color:#27c021; color:white"> <i class="fas fa-check"></i> </td>
                <% end if  %>
            </tr>
        <%  end if %>
    <% 
        PermintaanBarang.movenext
        loop 
    %>
<% end if %>