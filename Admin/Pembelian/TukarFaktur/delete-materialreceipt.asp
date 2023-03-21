<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    TFD_ID = request.queryString("TFD_ID")
    'response.write TFD_ID

    set TukarFaktur_CMD = server.createObject("ADODB.COMMAND")
	TukarFaktur_CMD.activeConnection = MM_PIGO_String
    TukarFaktur_CMD.commandText = "DELETE MKT_T_TukarFaktur_D WHERE TFD_ID = '"& TFD_ID &"' "
    'Response.Write TukarFaktur_CMD.commandText & "<br>"
    set TukarFaktur = TukarFaktur_CMD.execute

    TukarFaktur_CMD.commandText = "SELECT * FROM MKT_T_TukarFaktur_D WHERE LEFT(TFD_ID,16) = '"& LEFT(TFD_ID,16) &"'"
    'response.write TukarFaktur_CMD.commandText &"<br><br>"
    set Faktur = TukarFaktur_CMD.execute
        
%>
<input type="hidden" name="TF_ID" id="TF_ID" value="<%=LEFT(TFD_ID,16)%>">
<div class="row">
    <div class="col-12">
        <table class="tb-dashboard cont-tb align-items-center table tb-transaksi table-bordered table-condensed mt-1">
            <thead class="text-center">
                <tr>
                    <th> NO </td>
                    <th> AKSI </td>
                    <th> ID MATERIAL RECEIPT </th>
                    <th> TOTAL RECEIPT </th>
                    <th> TOTAL TUKAR FAKTUR </th>
                    <th> SISA </th>
                </tr>
            </thead>
            <tbody>
                <%
                    no = 0 
                    do while not Faktur.eof
                    no = no + 1
                %>
                <tr>
                    <td class="text-center"> <%=no%> </td>
                    <td class="text-center"> 
                        <button onclick="deleteTukarFaktur<%=no%>()" class="cont-btn"> DELETE </button> 
                        <input type="hidden" name="TFD_ID" id="TFD_ID<%=no%>" value="<%=Faktur("TFD_ID")%>">
                    </td>
                    <td class="text-center"> <%=Faktur("TF_mmID")%> </td>
                    <td class="text-end"> <%=Replace(FormatCurrency(Faktur("TF_mmTotal")),"$","Rp. ")%> </td>
                    <td class="text-end"> <%=Replace(FormatCurrency(Faktur("TF_TFTotal")),"$","Rp. ")%> </td>
                    <td class="text-end"> <%=Replace(FormatCurrency(Faktur("TF_mmSisa")),"$","Rp. ")%> </td>
                </tr>
                <script>
                    function deleteTukarFaktur<%=no%>(){
                        var TFD_ID = document.getElementById("TFD_ID<%=no%>").value;
                        $.ajax({
                            type: "GET",
                            url: "delete-materialreceipt.asp",
                            data: {
                                TFD_ID
                            },
                            success: function (data) {
                                $('.data-TukarFaktur').html(data);
                                Swal.fire('Data Berhasil Dihapus', data.message, 'success').then(() => {
                                });
                            }
                        });
                    }
                </script>
                <%
                    Faktur.movenext
                    loop
                %>
            </tbody>
        </table>
    </div>
</div>
<div class="row mt-2 cont-simpan-tukar-faktur" id="cont-simpan-tukar-faktur">
    <div class="col-2">
        <button onclick="simpan()"class="cont-btn"> Simpan </button>
    </div>
</div>
<div class="cont-generate" id="cont-generate" style="display:none">
<div class="row mt-2">
    <div class="col-2">
        <button class="cont-btn"> Posting Jurnal </button>
    </div>
    <div class="col-2">
        <button class="cont-btn"> Cetak Tanda Terima </button>
    </div>
</div>
</div>