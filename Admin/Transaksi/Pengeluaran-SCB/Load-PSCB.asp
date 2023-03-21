<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    set PengeluaranBarang_CMD = server.createObject("ADODB.COMMAND")
	PengeluaranBarang_CMD.activeConnection = MM_PIGO_String

    tgla            = request.queryString("tgla")
    tgle            = request.queryString("tgle")
    PSCB_Type       = request.queryString("PSCB_Type")
    PSCB_ID          = request.queryString("PSCBID")

    if PSCB_ID = "" then
        if PSCB_Type = "" then
            PengeluaranBarang_CMD.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal,  MKT_T_PengeluaranSC_H.psc_InvARYN,MKT_T_PengeluaranSC_H.psc_SJYN FROM MKT_T_Permintaan_Barang_H RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_PengeluaranSC_H.psc_permID WHERE PermTanggal between '"& tgla &"' and '"& tgle &"' "
            'response.write PengeluaranBarang_CMD.commandText 
            set Pengeluaran = PengeluaranBarang_CMD.execute
        else
            PengeluaranBarang_CMD.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal,  MKT_T_PengeluaranSC_H.psc_InvARYN,MKT_T_PengeluaranSC_H.psc_SJYN FROM MKT_T_Permintaan_Barang_H RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_PengeluaranSC_H.psc_permID WHERE pscType = '"& PSCB_Type &"' "
            'response.write PengeluaranBarang_CMD.commandText 
            set Pengeluaran = PengeluaranBarang_CMD.execute
        end if
    else    
        PengeluaranBarang_CMD.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal,  MKT_T_PengeluaranSC_H.psc_InvARYN,MKT_T_PengeluaranSC_H.psc_SJYN FROM MKT_T_Permintaan_Barang_H RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_PengeluaranSC_H.psc_permID WHERE pscID LIKE '%"& PSCB_ID &"%' "
        'response.write PengeluaranBarang_CMD.commandText 
        set Pengeluaran = PengeluaranBarang_CMD.execute
    end if 

%>
<% If Pengeluaran.eof = true then %>
    <tr>
        <td class="text-center" colspan="8"> Data Tidak Ditemukan  </td>
    </tr>
<% else %>
    <%
        no = 0
        do while not Pengeluaran.eof
        no = no + 1
    %>
        <tr>
            <td class="text-center"> <%=no%> </td>
            <td class="text-center"> 
                <input type="hidden" name="pscID" id="pscID<%=Pengeluaran("pscID")%>" value="<%=Pengeluaran("pscID")%>">
                <button class="cont-btn" onclick="window.open('bukti-PSCB.asp?pscID='+document.getElementById('pscID<%=Pengeluaran("pscID")%>').value)"> <%=Pengeluaran("pscID")%> </button>
            </td>
            <td class="text-center"> <%=CDate(Pengeluaran("pscTanggal"))%> </td>
            <td class="text-center"> <%=Pengeluaran("pscType")%> </td>
            <td class="text-center"> <%=Pengeluaran("permID")%>/<%=Pengeluaran("permTanggal")%> </td>

            <% if Pengeluaran("psc_SJYN") = "Y" then %>
                <%
                    Pengeluaran_cmd.commandText = "SELECT MKT_T_SuratJalan_H.SJID FROM MKT_T_SuratJalan_H RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D.pscIDH WHERE MKT_T_PengeluaranSC_H.pscID = '"& pengeluaran("pscID") &"'"
                    'response.write Pengeluaran_cmd.commandText 
                    set SuratJalan = Pengeluaran_cmd.execute
                %>
            <td class="text-center"> 
                <input type="hidden" name="sjid" id="sjid<%=no%>" value="<%=SuratJalan("SJID")%>">
                <button class="cont-btn" onclick="window.open('../../SuratJalan/bukti-suratjalan.asp?SJID='+document.getElementById('sjid<%=no%>').value,'_Self')"> BUKTI SURAT JALAN</button> 
            </td>
            <% else %>
            <td class="text-center"> <button class="cont-btn" onclick="window.open('../../SuratJalan/detail.asp?pscID='+document.getElementById('pscID<%=Pengeluaran("pscID")%>').value,'_Self')"> SURAT JALAN </button> </td>
            <% end if %>
        </tr>
    <%
        Pengeluaran.movenext
        loop
    %>
<% end if %>