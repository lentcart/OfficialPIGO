<!--#include file="../../../connections/pigoConn.asp"-->

<% 

    set kwitansi_CMD = server.createObject("ADODB.COMMAND")
	kwitansi_CMD.activeConnection = MM_PIGO_String

    kwitansi_CMD.commandText = "SELECT MKT_T_Kwitansi_H.KWID, MKT_T_Kwitansi_H.KWTanggal, MKT_T_Kwitansi_H.KWTotalLine, MKT_T_Kwitansi_H.KW_custID,  MKT_M_Customer.custNama FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_Kwitansi_H ON MKT_M_Customer.custID = MKT_T_Kwitansi_H.KW_custID LEFT OUTER JOIN MKT_T_Kwitansi_D ON MKT_T_Kwitansi_H.KWID = MKT_T_Kwitansi_D.KWID_H WHERE MKT_T_Kwitansi_H.KWAktifYN = 'Y'  "
    'Response.Write kwitansi_CMD.commandText & "<br>"

    set Kwitansi = kwitansi_CMD.execute

%>
<div class="row">
    <div class="col-12">
        <table class="tb-dashboard align-items-center table cont-tb table-bordered table-condensed mt-1" >
            <thead>
                <tr class="text-center">
                    <th>No</th>
                    <th>Tanggal </th>
                    <th>No Kwitansi</th>
                    <th>CUSTOMER</th>
                    <th>TOTAL LINE</th>
                    <th colspan="2">Aksi</th>
                </tr>
            </thead>
            <tbody class="dataRekap">
                <% 
                    no = 0
                    do while not Kwitansi.eof 
                    no = no+1
                %>
                <tr>
                    <td class="text-center"> <%=no%> </td>
                    <td class="text-center"> <%=CDate(Kwitansi("KWTanggal"))%><input type="hidden" name="KWID" id="KWID<%=no%>" value="<%=Kwitansi("KWID")%>"></td>
                    <td> <%=Kwitansi("KWID")%> </td>
                    <td> <%=Kwitansi("CustNama")%> </td>
                    <td class="text-center"> <%=Kwitansi("KWTotalLine")%> </td>
                    <td class="text-center"> 
                        <button onclick="window.open('Bukti-TandaTerima.asp?KWID='+document.getElementById('KWID<%=no%>').value,'_Self')" class="cont-btn"> <i class="fas fa-print"></i> &nbsp; Tanda Terima </button><br>
                        <button onclick="window.open('Bukti-Kwitansi.asp?KWID='+document.getElementById('KWID<%=no%>').value,'_Self')" class="cont-btn mt-2"> <i class="fas fa-print "></i> &nbsp; Kwitansi </button>
                    </td>
                </tr>
                <% 
                    Kwitansi.movenext
                    loop 
                %>
            </tbody>
        </table>
    </div>
</div>