<!--#include file="../../Connections/pigoConn.asp" --> 

<% 

    set SuratJalan_CMD = server.createObject("ADODB.COMMAND")
	SuratJalan_CMD.activeConnection = MM_PIGO_String

    tgla            = request.queryString("tgla")
    tgle            = request.queryString("tgle")
    SJID            = request.queryString("PSCBID")

    if SJID = "" then
        SuratJalan_CMD.commandText = "SELECT MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_H.SJ_pscID, MKT_T_SuratJalan_H.SJ_Tanggal, MKT_T_SuratJalan_H.SJ_custID, MKT_M_Customer.custNama, MKT_T_SuratJalan_H.SJ_TerimaYN,  MKT_T_SuratJalan_H.SJ_PostingYN, MKT_T_SuratJalan_H.SJ_JR_ID , MKT_T_SuratJalan_H.SJ_InvARYN, MKT_T_SuratJalan_H.SJ_InvARID  FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_M_Customer.custID = MKT_T_SuratJalan_H.SJ_custID WHERE SJ_Tanggal between '"& tgla &"' and '"& tgle &"' "
        response.write SuratJalan_CMD.commandText 
        set SuratJalan = SuratJalan_CMD.execute
    else    
        SuratJalan_CMD.commandText = "SELECT MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_H.SJ_pscID, MKT_T_SuratJalan_H.SJ_Tanggal, MKT_T_SuratJalan_H.SJ_custID, MKT_M_Customer.custNama, MKT_T_SuratJalan_H.SJ_TerimaYN,  MKT_T_SuratJalan_H.SJ_PostingYN, MKT_T_SuratJalan_H.SJ_JR_ID , MKT_T_SuratJalan_H.SJ_InvARYN, MKT_T_SuratJalan_H.SJ_InvARID  FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_M_Customer.custID = MKT_T_SuratJalan_H.SJ_custID WHERE SJID LIKE '%"& SJID &"%' "
        response.write SuratJalan_CMD.commandText 
        set SuratJalan = SuratJalan_CMD.execute
    end if 

%>
<% If SuratJalan.eof = true then %>
    <tr>
        <td class="text-center" colspan="9"> Data Tidak Ditemukan  </td>
    </tr>
<% else %>
    <%
        no = 0 
        do while not SuratJalan.eof
        no = no + 1
    %>
    <tr>
        <td class="text-center"> <%=no%> </td>
        <td class="text-center"> 
            <input type="hidden" name="SJID" id="SJID<%=SuratJalan("SJID")%>" value="<%=SuratJalan("SJID")%>">
            <button  onclick="window.open('bukti-suratjalan.asp?SJID='+document.getElementById('SJID<%=SuratJalan("SJID")%>').value)" class="cont-btn"><%=SuratJalan("SJID")%> </button>
        </td>
        <td class="text-center"> <%=Day(CDate(SuratJalan("SJ_Tanggal")))%>/<%=Month(SuratJalan("SJ_Tanggal"))%>/<%=Year(CDate(SuratJalan("SJ_Tanggal")))%></td>
        <td class="text-center"> <%=SuratJalan("SJ_pscID")%> </td>
        <td> <%=SuratJalan("custNama")%> </td>

            <% if SuratJalan("SJ_TerimaYN") = "N" then %>
            <td class="text-center" colspan="2"> <button class="cont-btn" onclick="window.open('verifikasi-suratjalan.asp?SJID='+document.getElementById('SJID<%=SuratJalan("SJID")%>').value,'_Self')"> VERIFIKASI SURAT JALAN </button> </td>
            <% else %>
            <td class="text-center"> <button class="cont-btn" style="background-color:green; color:white"> <i class="fas fa-check"></i> </button>  </td>
                <% if SuratJalan("SJ_InvARYN") = "N" then %>
                    <td class="text-center"> <button  onclick="window.open('../Transaksi/Invoice-AR/Add-Faktur.asp?SJID='+document.getElementById('SJID<%=SuratJalan("SJID")%>').value,'_Self')" class="cont-btn"> <i class="fas fa-folder-plus"></i> ADD FAKTUR/INV </button> </td>
                <% else %>
                    <td class="text-center"> 
                        <input type="hidden" name="InvARID" id="InvARID<%=no%>" value="<%=SuratJalan("SJ_InvARID")%>">
                        <button class="cont-btn" onclick="window.open('../Transaksi/Invoice-AR/Bukti-FakturPenjualan.asp?InvARID='+document.getElementById('InvARID<%=no%>').value)"> <i class="fas fa-print"></i> <%=SuratJalan("SJ_InvARID")%> </button>
                    </td>
                <% end if %>
            <% end if %>

            <% if SuratJalan("SJ_PostingYN") = "N" then %>
            <td class="text-center"> <%=SuratJalan("SJ_PostingYN")%> </td>
            <td class="text-center"> <button onclick="window.open('posting-jurnal.asp?SJID='+document.getElementById('SJID<%=SuratJalan("SJID")%>').value,'_Self')"  class="cont-btn"> POSTING JURNAL </button> </td>
            <% else %>
            <td class="text-center"> 
                <input type="hidden" name="JR_ID" id="JR_ID<%=no%>" value="<%=SuratJalan("SJ_JR_ID")%>">
                <%=SuratJalan("SJ_PostingYN")%>
            </td>
            <td class="text-center"> <button class="cont-btn" onclick="window.open('../GL/GL-Jurnal/jurnal-voucher.asp?JR_ID='+document.getElementById('JR_ID<%=no%>').value)"> <i class="fas fa-print"></i> <%=SuratJalan("SJ_JR_ID")%></button> </td>
            <% end if %>
    </tr>
    <%
        SuratJalan.movenext
        loop
    %>
<% end if %>