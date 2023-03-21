<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    mmID = request.queryString("mmID")


    set MaterialReceipt_cmd = server.createObject("ADODB.COMMAND")
	MaterialReceipt_cmd.activeConnection = MM_PIGO_String

        MaterialReceipt_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_T_MaterialReceipt_H.mm_tfYN, MKT_T_MaterialReceipt_H.mm_JR_ID,  MKT_T_MaterialReceipt_H.mm_postingYN FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE (MKT_T_MaterialReceipt_H.mmAktifYN = 'Y')  AND  MKT_T_MaterialReceipt_H.mmID = '"& mmID &"' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_T_MaterialReceipt_H.mm_tfYN, MKT_T_MaterialReceipt_H.mm_JR_ID,  MKT_T_MaterialReceipt_H.mm_postingYN" 
        'response.write  MaterialReceipt_cmd.commandText 

    set MaterialReceipt = MaterialReceipt_cmd.execute
    set DataMM_cmd = server.createObject("ADODB.COMMAND")
	DataMM_cmd.activeConnection = MM_PIGO_String
%>
<% if MaterialReceipt.eof = true then %>
    <tr>
        <td colspan="6"class="text-center"> <span><b> DATA TIDAK DITEMUKAN !!! </b></span> </td>
    </tr>
<% else %>
<% 
    no = 0
    do while not MaterialReceipt.eof 
    no = no + 1
%>
    <tr>
        <td class="text-center"><%=no%></td>
        <%
            DataMM_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, ISNULL(MKT_T_MaterialReceipt_D1.mm_poID,0) AS PO, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdID,0) AS PD FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 Where mmID = '"& MaterialReceipt("mmID") &"' "                    
            'response.write  DataMM_cmd.commandText
            set MR = DataMM_cmd.execute

        %>
        <% If MR("PO") = "0" then %>
            <td class="text-center" style="color:red"><%=MaterialReceipt("mmID")%></td>
                <input type="hidden" name="tanggalmm" id="tanggalmm" value="<%=MaterialReceipt("mmTanggal")%>">
                <input type="hidden" name="mmid" id="mmid<%=no%>" value="<%=MaterialReceipt("mmID")%>">
            <td class="text-center"style="color:red">
                <%=day(Cdate(MaterialReceipt("mmTanggal")))%>/<%=Month(MaterialReceipt("mmTanggal"))%>/<%=Year(MaterialReceipt("mmTanggal"))%>
            </td>
            <td style="color:red"><%=MaterialReceipt("custNama")%></td>
            <td class="text-center" style="color:red"> - </td>
            <td class="text-center"><button class="cont-btn" onclick="hapus<%=no%>()"><i class="fas fa-trash"></i> DELETE </button> </td>
        <% else %>
            <td class="text-center">
                <input type="hidden" name="mmid" id="mmid<%=no%>" value="<%=MaterialReceipt("mmID")%>">
                <input type="hidden" name="tanggalmm" id="tanggalmm<%=no%>" value="<%=MaterialReceipt("mmTanggal")%>">
                <button class="cont-btn" onclick="window.open('buktimm.asp?mmID='+document.getElementById('mmid<%=no%>').value)" > <i class="fas fa-print"></i> <%=MaterialReceipt("mmID")%> </button>
            </td>
            <td class="text-center">
                <%=day(Cdate(MaterialReceipt("mmTanggal")))%>/<%=Month(MaterialReceipt("mmTanggal"))%>/<%=Year(MaterialReceipt("mmTanggal"))%>
            </td>
            <td><%=MaterialReceipt("custNama")%></td>
            <% if MaterialReceipt("mm_tfYN") = "N" then%>
                <td class="text-center" style="color:red"> <i class="fas fa-ban"></i> </td>
            <% else %>
                <td class="text-center" style="color:green"> <i class="fas fa-check"></i> </td>
            <% end if %>
            <td class="text-center"> 
                <%=MaterialReceipt("mm_postingYN")%>
                <input type="hidden" name="JRD_ID" id="JRD_ID<%=no%>" value="<%=MaterialReceipt("mm_JR_ID")%>">
            </td>
            <% if MaterialReceipt("mm_postingYN") = "N" then %>
            <td class="text-center"> 
                <button class="cont-btn" onclick="window.open('posting-jurnal.asp?mmID='+document.getElementById('mmid<%=no%>').value)"> POSTING JURNAL </button> 
            </td>
            <% else %>
            <td class="text-center"> 
                <button class="cont-btn" onclick="window.open('../../GL/GL-Jurnal/jurnal-voucher.asp?JR_ID='+document.getElementById('JRD_ID<%=no%>').value)"> <i class="fas fa-print"></i> <%=MaterialReceipt("mm_JR_ID")%> </button> 
            </td>
            <% end if %>
        <% end if %>
        <script>
            function hapus<%=no%>() {
                var mmID = document.getElementById("mmid<%=no%>").value;
                console.log(mmID);
                $.ajax({
                    type: "GET",
                    url: "../MaterialReceipt/delete-materialreceipt.asp",
                        data:{
                            mmID
                        },
                    success: function (data) {
                        console.log(data);
                        // Swal.fire('Deleted !!', data.message, 'success').then(() => {
                        // location.reload();
                        // });
                    }
                });
            }
        </script>
    <tr>
<%  
    MaterialReceipt.movenext
    loop
%>
<% end if %>