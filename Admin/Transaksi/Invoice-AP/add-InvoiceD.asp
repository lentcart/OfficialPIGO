<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    InvAP_IDH   = request.queryString("InvAP_IDH")
    InvAP_LineFrom    = request.queryString("InvAP_LineFrom")
    InvAP_poID   = request.queryString("InvAP_poID")
    InvAP_Keterangan    = request.queryString("InvAP_Keterangan")
    InvAP_Jumlah    = request.queryString("InvAP_Jumlah")
    InvAP_Tax   = request.queryString("InvAP_Tax")
    InvAP_TotalLine = request.queryString("InvAP_TotalLine")
        
    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING
    InvoiceVendor_CMD.commandText = "INSERT INTO [dbo].[MKT_T_InvoiceVendor_D1]([InvAP_DLine],[InvAP_Keterangan],[InvAP_Jumlah],[InvAP_Tax],[InvAP_TotalLine],[InvAP_UpdateTime])VALUES('"& InvAP_LineFrom &"','"& InvAP_Keterangan &"',"& InvAP_Jumlah &","& InvAP_Tax &","& InvAP_TotalLine &",'"& now() &"')"
    'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
    set InvoiceVendor = InvoiceVendor_CMD.execute

    InvoiceVendor_CMD.commandText = "SELECT * FROM MKT_T_InvoiceVendor_D1 Where InvAP_DLine = '"& InvAP_LineFrom &"' "
    'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
    set InvoiceVendorD = InvoiceVendor_CMD.execute

%>
<div class="cont-dataInoviceD">
    <div class="row mt-2 mb-1">
        <div class="col-12">
            <table class="tb-dashboard cont-tb align-items-center table tb-transaksi table-bordered table-condensed mt-1">
                <thead>
                    <tr class="text-center">
                        <th>NO</th>
                        <th>KETERANGAN </th>
                        <th>JUMLAH</th>
                        <th>TAX</th>
                        <th>TOTAL LINE</th>
                    </tr>
                </thead>
                <tbody class="dataRekap">
                    <% 
                        no = 0 
                        do while not InvoiceVendorD.eof 
                        no = no + 1
                    %>
                        <tr>
                            <td class="text-center"><%=no%></td>
                            <td ><%=InvoiceVendorD("InvAP_Keterangan")%></td>
                            <td class="text-end"><%=Replace(Replace(FormatCurrency(InvoiceVendorD("InvAP_Jumlah")),"$","Rp. "),".00","")%></td>
                            <td class="text-end"><%=Replace(Replace(FormatCurrency(InvoiceVendorD("InvAP_Tax")),"$","Rp. "),".00","")%></td>
                            <td class="text-end"><%=Replace(Replace(FormatCurrency(InvoiceVendorD("InvAP_TotalLine")),"$","Rp. "),".00","")%></td>
                            <% grandtotal = grandtotal + InvoiceVendorD("InvAP_TotalLine") %>
                        </tr>
                    <% InvoiceVendorD.movenext
                    loop %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="row mt-2 mb-2">
    <div class="col-lg-9 col-md-9 col-sm-9 text-end">
        <span class="cont-text"> Grand Total </span>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-3 text-end">
        <span class="cont-text" style="font-size:18px"> <%=Replace(Replace(FormatCurrency(grandtotal),"$","Rp. "),".00","")%> </span>
        <input type="hidden" name="grandtotal" id="grandtotal" value="<%=grandtotal%>">
    </div>
</div>

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12 text-end">
        <button onclick="UpdateInvoice()" class="cont-btn"> Selesai </button>
    </div>
</div>
<script>
    function UpdateInvoice() {
        var InvAP_IDH                   = $('input[name=InvAPID]').val();
        var InvAP_GrandTotal            = $('input[name=grandtotal]').val();
        $.ajax({
            type: "POST",
            url: "update-InvoiceH.asp",
            data:{
                InvAP_IDH,
                InvAP_GrandTotal
            },
            success: function (data) {
                Swal.fire('Data Berhasil Di Proses', data.message, 'success').then(() => {
                location.reload();
                });
            }
        });
    }
</script>