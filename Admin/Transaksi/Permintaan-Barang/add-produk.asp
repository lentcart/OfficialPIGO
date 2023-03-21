
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    Perm_IDH                = request.queryString("Perm_IDH")
    Perm_pdID               = request.queryString("Perm_pdID")
    Perm_pdQty              = request.queryString("Perm_pdQty")
    Perm_pdHarga            = request.queryString("Perm_pdHarga")
    Perm_pdUpTo             = request.queryString("Perm_pdUpTo")
    Perm_pdPPN              = request.queryString("Perm_pdPPN")

    set addproduk_CMD = server.createObject("ADODB.COMMAND")
	addproduk_CMD.activeConnection = MM_PIGO_String

    addproduk_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Permintaan_Barang_D]([Perm_IDH],[Perm_pdID],[Perm_pdQty],[Perm_pdHargaJual],[Perm_pdUpTo],[Perm_pdTax],[Perm_AktifYN])VALUES('"& Perm_IDH &"','"& Perm_pdID &"',"& Perm_pdQty &","& Perm_pdHarga &","& Perm_pdUpTo &",'"& Perm_pdPPN &"','Y') "
    'Response.Write addproduk_CMD.commandText & "<br>"

    set addproduk = addproduk_CMD.execute

    set addproduk_CMD = server.createObject("ADODB.COMMAND")
	addproduk_CMD.activeConnection = MM_PIGO_String

    addproduk_CMD.commandText = "SELECT  MKT_T_Permintaan_Barang_D.Perm_IDH,MKT_M_PIGO_Produk.pdNama,MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_D.Perm_pdUpTo,  MKT_T_Permintaan_Barang_D.Perm_pdTax FROM MKT_T_Permintaan_Barang_D LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_IDH = '"& Perm_IDH &"' "
    'Response.Write addproduk_CMD.commandText & "<br>"
    set loadproduk = addproduk_CMD.execute
        
%>
<div class="row">
    <div class="col-12">
        <table class="tb-dashboard cont-tb align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="width:100%">
            <thead>
                <tr class="text-center">
                    <th> NO </th>
                    <th> ID </th>
                    <th> NAMA PRODUK </th>
                    <th> QTY </th>
                    <th> HARGA JUAL </th>
                    <th> AKSI </th>
                </tr>
            </thead>
            <tbody>
                <% 
                    no = 0
                    do while not loadproduk.eof 
                    no = no + 1
                %>
                    <tr>
                        <td class="text-center"><%=no%> </td>
                        <td class="text-center">
                            <input type="hidden" name="pdID" id="pdID<%=no%>" value="<%=loadproduk("Perm_pdID")%>">
                            <input type="hidden" name="permID" id="permID<%=no%>" value="<%=loadproduk("Perm_IDH")%>">
                            <%=loadproduk("Perm_pdID")%> 
                        </td>
                        <td><%=loadproduk("pdNama")%> </td>
                        <td class="text-center"><%=loadproduk("Perm_pdQty")%> </td>
                        <%

                            Harga = loadproduk("Perm_pdHargaJual")
                            UpTo  = Harga+(Harga*loadproduk("Perm_pdUpTo")/100)
                            Tax   = UpTo*loadproduk("Perm_pdTax")/100
                            SebelumPPN = round(UpTo)
                            SetelahPPN = round(UpTo+Tax)
                                                                
                        %>
                        <td class="text-end"><%=Replace(Replace(FormatCurrency(SetelahPPN),"$","Rp."),".00","")%> </td>
                        <td class="text-center"><button onclick="hapusdata<%=no%>()" class="cont-btn" style="width:6rem"><i class="fas fa-trash"></i> Delete </button> </td>
                    </tr>
                    <script>
                        function hapusdata<%=no%>(){
                            var pdID        = document.getElementById("pdID<%=no%>").value;
                            var permID      = document.getElementById("permID<%=no%>").value;
                            $.ajax({
                            type: "GET",
                            url: "delete-produk.asp",
                            data:{
                                pdID,
                                permID
                            },
                            success: function (data) {
                                alert('Produk Berhasil Dihapus');
                                $('.data-produkpermintaan').html(data);
                            }
                        });
                        }

                    </script>
                <% 
                    loadproduk.movenext
                    loop 
                %>
            </tbody>
        </table>
    </div>
</div>

<div class="row">
    <div class="col-12">
        <button class="cont-btn" onclick="complete('<%=Perm_IDH%>')"> Complete </button>
    </div>
</div>