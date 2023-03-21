<!--#include file="../../../../connections/pigoConn.asp"-->

<% 
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    poID = request.queryString("poID") 
    pdID = request.queryString("pdID") 
    poQtyProduk = request.queryString("poQtyProduk") 
    poHargaSatuan = request.queryString("poHargaSatuan") 
    poPajak = request.queryString("poPajak") 
    poSubTotal = request.queryString("poSubTotal") 
    poTotal = request.queryString("poTotal") 
    
    set PurchaseOrder_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_CMD.activeConnection = MM_pigo_STRING

    PurchaseOrder_CMD.commandText = " UPDATE MKT_T_PurchaseOrder_D set poQtyProduk = '"& poQtyProduk &"', poHargaSatuan = '"& poHargaSatuan &"', poPajak = '"& poPajak &"', poSubTotal = '"& poSubTotal &"', poTotal = '"& poTotal &"' Where poID_H = '"& poID &"' AND po_pdID = '"& pdID &"' "
    'response.write PurchaseOrder_CMD.commandText &"<br><br>"
    set PurchaseOrder = PurchaseOrder_CMD.execute

    set produk_CMD = server.CreateObject("ADODB.command")
    produk_CMD.activeConnection = MM_pigo_STRING
    produk_CMD.commandText = "SELECT MKT_T_PurchaseOrder_D.po_pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak,  MKT_T_PurchaseOrder_D.poSubTotal FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE MKT_T_PurchaseOrder_H.poID = '"& poID &"' "
    'response.write Produk_cmd.commandText
    set produk = produk_CMD.execute

%>
<div class="row" id="cont-detailpo">
    <div class="col-12">
        <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
            <tr class="text-center">
                <th> ID Produk </th>
                <th> Detail </th>
                <th> QTY </th>
                <th> Harga </th>
                <th> PPN </th>
                <th> Total </th>
            </tr>
                <% 
                    no = 0 
                    do while not produk.eof 
                    no = no + 1
                %>
                <tr>
                    <td class="text-center"> 
                        <button onclick="getproduk<%=no%>()"class="cont-btn" style="width:7rem"><i class="fas fa-edit"></i>&nbsp;&nbsp;<%=produk("po_pdID")%></button>
                        <input type="hidden" class="text-center" name="pdID" id="pdID<%=no%>" value="<%=produk("po_pdID")%>">
                    </td>
                    <td> <b><%=produk("pdPartNumber")%></b> - <%=produk("pdNama")%></td>
                    <td class="text-center"> <%=produk("poQtyProduk")%></td>
                    <td class="text-center"> <%=produk("poHargaSatuan")%></td>
                    <td class="text-center"> <%=produk("poPajak")%></td>
                    <td class="text-center"> <%=produk("poSubTotal")%></td>
                </tr>

                <script>
                    function getproduk<%=no%>(){
                        $.ajax({
                            type: "get",
                            url: "../loadproduk.asp?pdID="+document.getElementById("pdID<%=no%>").value,
                            success: function (url) {
                                $('#cont-revisipo').html(url);
                                document.getElementById("cont-detailpo").style.display = "none" ;
                                document.getElementById("btn-simpanperubahan").style.display = "block";
                            }
                        });
                    }
                </script>
                        
                <%
                    produk.movenext
                    loop 
                %>
            </table>
        </div>
    </div>
</div>