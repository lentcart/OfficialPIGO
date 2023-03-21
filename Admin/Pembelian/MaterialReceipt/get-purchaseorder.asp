
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    key = request.queryString("poID")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) as nourut, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_D.po_pdID, MKT_M_PIGO_Produk.pdPartNumber,  MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poPdUnit, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_D.poID_H,  MKT_T_PurchaseOrder_D.poDiskon, MKT_T_PurchaseOrder_D.poSubTotal, MKT_T_PurchaseOrder_D.poTotal, MKT_T_PurchaseOrder_D.po_spoID, MKT_M_PIGO_Produk.pdKey, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama,  MKT_M_PIGO_Produk.pdPartNumber AS Expr1, MKT_M_PIGO_Produk.pdLokasi, MKT_M_StatusPurchaseOrder.spoName FROM MKT_M_StatusPurchaseOrder RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_StatusPurchaseOrder.spoID = MKT_T_PurchaseOrder_D.po_spoID LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID Where MKT_T_PurchaseOrder_H.poID = '"& key &"' AND MKT_T_PurchaseOrder_D.po_spoID = '0' OR  MKT_T_PurchaseOrder_D.po_spoID = '2'"
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute
        
    set statuspo_CMD = server.createObject("ADODB.COMMAND")
	statuspo_CMD.activeConnection = MM_PIGO_String

    set sisa_CMD = server.createObject("ADODB.COMMAND")
	sisa_CMD.activeConnection = MM_PIGO_String
%>
<div class="row">
    <div class="col-12">
        <div class="cont-tb" id="cont-tb">
            <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                <thead>
                    <tr>
                        <th class="text-center"> AKSI </th>
                        <th class="text-center"> NO </th>
                        <th class="text-center" colspan="2"> DETAIL PRODUK </th>
                        <th class="text-center"> QTY PO </th>
                        <th class="text-center"> QTY MM </th>
                        <th class="text-center"> HARGA </th>
                        <th class="text-center"> TOTAL </th>
                        <th class="text-center"> STATUS </th>
                        <th class="text-center"> KET </th>
                    </tr>
                </thead>
                <tbody>
                    <%do while not dproduk.eof%>
                        <script>
                            function subtotal<%=dproduk("pdID")%>(){
                                var pajak = parseInt(document.getElementById("pajak<%=dproduk("pdID")%>").value);
                                var qty = parseInt(document.getElementById("mmpdQty<%=dproduk("pdID")%>").value);
                                var qtyditerima = parseInt(document.getElementById("qtyditerima<%=dproduk("pdID")%>").value);
                                var harga = parseInt(document.getElementById("harga<%=dproduk("pdID")%>").value);
                                var ppn = harga+(harga*pajak/100);
                                var total = Number(qtyditerima*ppn);
                                document.getElementById("subtotal<%=dproduk("pdID")%>").value = total;
                                
                            };
                            document.addEventListener("DOMContentLoaded", function(event) {
                                subtotal<%=dproduk("pdID")%>();
                            });
                            function qty<%=dproduk("pdID")%>(){
                                var qtyPO = document.getElementById("mmpdQty<%=dproduk("pdID")%>").value;
                                var qtyMM = document.getElementById("qtyditerima<%=dproduk("pdID")%>").value;
                                if( qtyMM != qtyPO ){
                                    document.getElementById("statuspo<%=dproduk("pdID")%>").value="2"
                                    document.getElementById("statuspoo<%=dproduk("pdID")%>").value="Tidak Terpenuhi"
                                }else{
                                    document.getElementById("statuspo<%=dproduk("pdID")%>").value="1"
                                    document.getElementById("statuspoo<%=dproduk("pdID")%>").value="Terpenuhi"
                                }
                            }
                            function sendmm<%=dproduk("pdID")%>(){
                                var mmIDStatus = "ADD";
                                var mmID_D = $('#mmID').val();    
                                var mm_pdID  = $('#pdID<%=dproduk("pdID")%>').val();    
                                var mm_pdQty = $('#mmpdQty<%=dproduk("pdID")%>').val();    
                                var mm_pdQtyDiterima = $('#qtyditerima<%=dproduk("pdID")%>').val();
                                var mm_pdSubtotal = $('#subtotal<%=dproduk("pdID")%>').val();
                                var statuspo = $('#statuspo<%=dproduk("pdID")%>').val();
                                var poid = $('#poid<%=dproduk("pdID")%>').val();
                                var potanggal = $('#potanggal<%=dproduk("pdID")%>').val();
                                var harga = $('#harga<%=dproduk("pdID")%>').val();
                                console.log(mmIDStatus);
                                let cek<%=dproduk("pdID")%> = document.getElementById("CKMM<%=dproduk("pdID")%>");
                                if ( mm_pdQtyDiterima == "0" ){
                                    $('#qtyditerima<%=dproduk("pdID")%>').focus();
                                    Swal.fire({
                                        icon: 'warning',
                                        text: 'Masukan Jumlah QTY Yang Diterima'
                                    });
                                    return false;
                                }else{
                                    $.ajax({
                                        type: "get",
                                        url: "add-produkmm.asp",
                                        data:{
                                                mmIDStatus,
                                                mmID_D,
                                                mm_pdID,
                                                mm_pdQty,
                                                mm_pdQtyDiterima,
                                                mm_pdSubtotal,
                                                statuspo,
                                                poid,
                                                potanggal,
                                                harga
                                            },
                                        success: function (data) {
                                            $('.cont-Status-mm').html(data);
                                            Swal.fire('Berhasil', data.message, 'success').then(() => {
                                                document.getElementById("btn-send<%=dproduk("pdID")%>").style.display = "none" 
                                                document.getElementById("btn-done<%=dproduk("pdID")%>").style.display = "block"
                                                document.getElementById("CKMM<%=dproduk("pdID")%>").style.display = "block"
                                                $("#CKMM<%=dproduk("pdID")%>").prop('checked', true);
                                                $("#qtyditerima<%=dproduk("pdID")%>").prop('disabled', true);
                                            });
                                        }
                                    });
                                }
                            }
                            function upCek<%=dproduk("pdID")%>(){
                                var mmIDStatus = "UPDATE";
                                var mmID_D = $('#mmID').val();    
                                var mm_pdID  = $('#pdID<%=dproduk("pdID")%>').val();    
                                var mm_pdQty = $('#mmpdQty<%=dproduk("pdID")%>').val();    
                                var mm_pdQtyDiterima = $('#qtyditerima<%=dproduk("pdID")%>').val();
                                var mm_pdSubtotal = $('#subtotal<%=dproduk("pdID")%>').val();
                                var statuspo ="0";
                                var poid = $('#poid<%=dproduk("pdID")%>').val();
                                var potanggal = $('#potanggal<%=dproduk("pdID")%>').val();
                                var harga = $('#harga<%=dproduk("pdID")%>').val();
                                let cek<%=dproduk("pdID")%> = document.getElementById("CKMM<%=dproduk("pdID")%>");
                                console.log(mmIDStatus);
                                if (!cek<%=dproduk("pdID")%>.checked){
                                    $.ajax({
                                        type: "get",
                                        url: "add-produkmm.asp",
                                        data:{
                                                mmIDStatus,
                                                mmID_D,
                                                mm_pdID,
                                                mm_pdQty,
                                                mm_pdQtyDiterima,
                                                mm_pdSubtotal,
                                                statuspo,
                                                poid,
                                                potanggal,
                                                harga
                                            },
                                        success: function (data) {
                                            document.getElementById("btn-send<%=dproduk("pdID")%>").style.display = "block" ;
                                                document.getElementById("btn-done<%=dproduk("pdID")%>").style.display = "none";
                                                document.getElementById("CKMM<%=dproduk("pdID")%>").style.display = "none";
                                                $("#CKMM<%=dproduk("pdID")%>").prop('checked', false);
                                                $("#qtyditerima<%=dproduk("pdID")%>").prop('disabled', false);
                                        }
                                    });
                                }
                            }
                        </script>
                        <% if dproduk("po_spoID") = "2" then%>
                            <% 

                                statuspo_CMD.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) as nourut, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_D.po_spoID, MKT_T_PurchaseOrder_D.poSubTotal, MKT_M_StatusPurchaseOrder.spoName, MKT_T_PurchaseOrder_D.po_pdID, (MKT_T_PurchaseOrder_D.poQtyProduk-MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima) AS sisa, MKT_M_PIGO_Produk.pdID, MKT_T_PurchaseOrder_H.poTanggal, MKT_M_PIGO_Produk.pdPartNumber,  MKT_M_PIGO_Produk.pdNama, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poHargaSatuan FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID LEFT OUTER JOIN MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID LEFT OUTER JOIN MKT_M_StatusPurchaseOrder ON MKT_T_PurchaseOrder_D.po_spoID = MKT_M_StatusPurchaseOrder.spoID ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON  MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE (MKT_T_PurchaseOrder_D.poID_H = '"& dproduk("poiD") &"') AND (MKT_T_PurchaseOrder_D.po_pdID = '"& dproduk("po_pdID") &"') AND (MKT_T_PurchaseOrder_D.po_spoID = '2') group by  MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_D.po_spoID, MKT_T_PurchaseOrder_D.poSubTotal, MKT_M_StatusPurchaseOrder.spoName, MKT_T_PurchaseOrder_D.po_pdID,  MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima,MKT_T_PurchaseOrder_D.poQtyProduk, MKT_M_PIGO_Produk.pdID, MKT_T_PurchaseOrder_H.poTanggal, MKT_M_PIGO_Produk.pdPartNumber,  MKT_M_PIGO_Produk.pdNama, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poHargaSatuan"
                                'Response.Write statuspo_CMD.commandText & "<br>"

                                set statuspo = statuspo_CMD.execute
                                
                            %>
                            <% do while not statuspo.eof%>
                            <tr style="background-color:#65bde6; color:black">
                                <td class="text-center">
                                    <input onchange="upCek<%=dproduk("pdID")%>()" class="CKMM" type="checkbox" name="CKMM" id="CKMM<%=dproduk("pdID")%>" value="" style="display:none"><input required type="hidden" name="pdID" id="pdID<%=statuspo("pdID")%>" value="<%=statuspo("pdID")%>" >
                                </td>
                                <input  type="hidden" name="poid" id="poid<%=statuspo("pdID")%>" value="<%=statuspo("poID")%>">
                                <input  type="hidden" name="potanggal" id="potanggal<%=statuspo("pdID")%>" value="<%=statuspo("poTanggal")%>">

                                <td class="text-center"><%=statuspo("nourut")%> </td>

                                <td><%=statuspo("pdPartNumber")%> </td>

                                <td><input readonly type="text" name="namaproduk" id="namaproduk" value="<%=statuspo("pdNama")%>" style="width:11rem; border:none;background-color:#65bde6;"> </td>

                                <td class="text-center"><%=statuspo("sisa")%>
                                    <input required type="hidden" name="mmpdQty" id="mmpdQty<%=statuspo("pdID")%>" value="<%=statuspo("sisa")%>"> 
                                </td>

                                <td class="text-center">
                                    <input class="text-center"required type="number" onblur="qty<%=dproduk("pdID")%>()" onkeyup="subtotal<%=statuspo("pdID")%>()" name="qtyditerima" id="qtyditerima<%=statuspo("pdID")%>" value="0" style="width:3rem;background-color:#65bde6;">
                                </td>

                                <td  class="text-center"><%=statuspo("poHargaSatuan")%>
                                    <input  type="hidden" name="harga" id="harga<%=statuspo("pdID")%>" value="<%=statuspo("poHargaSatuan")%>">
                                </td>

                                <td><input class="text-center" readonly type="text" name="subtotal" id="subtotal<%=statuspo("pdID")%>" value="<%=statuspo("poSubtotal")%>" style="border:none; width:5rem;background-color:#65bde6;"> </td>

                                <td>
                                    <input class="text-center" readonly type="hidden" name="statuspo" id="statuspo<%=dproduk("pdID")%>" value="" style="border:none; width:2rem">
                                    <input class="text-center" readonly type="text" name="statuspoo" id="statuspoo<%=dproduk("pdID")%>" value="" style="border:none;width:7rem;background-color:#65bde6;">
                                </td>
                                <td>
                                    <button name="btn-send" id="btn-send<%=dproduk("pdID")%>"class="cont-btn"onclick="sendmm<%=dproduk("pdID")%>()" style="width:4rem"> SEND </button>
                                    <button name="btn-done" id="btn-done<%=dproduk("pdID")%>"class="cont-btn" style="display:none"> <i class="fas fa-check"></i> </button>
                                </td>
                            </tr>
                            <% statuspo.movenext
                            loop%>
                        <% else %>

                        <% if dproduk("po_spoID") = "1" then%>
                        
                        <tr style="background-color:#df9375">
                            <td class="text-center"><input disabled  type="checkbox" name="" id=""><input  type="hidden" name="pdID" id="pdID<%=dproduk("pdID")%>" value="<%=dproduk("pdID")%>"></td>
                            <input  type="hidden" name="poid" id="poid<%=dproduk("pdID")%>" value="<%=dproduk("poID")%>">
                            <input  type="hidden" name="potanggal" id="potanggal<%=dproduk("pdID")%>" value="<%=dproduk("poTanggal")%>">
                            <td class="text-center"><%=dproduk("nourut")%> </td>

                            <td><%=dproduk("pdPartNumber")%> </td>

                            <td><input readonly type="text" name="namaproduk" id="namaproduk" value="<%=dproduk("pdNama")%>" style="width:11rem; border:none"> </td>


                            <td class="text-center"><%=dproduk("poQtyProduk")%></td>

                            <td class="text-center">
                                <%=dproduk("poQtyProduk")%>
                            </td>

                            <td  class="text-center"><%=dproduk("poHargaSatuan")%>
                                <input  type="hidden" name="harga" id="harga<%=dproduk("pdID")%>" value="<%=dproduk("poHargaSatuan")%>">
                                <input  type="hidden" name="pajak" id="pajak<%=dproduk("pdID")%>" value="<%=dproduk("poPajak")%>">
                            </td>

                            <td>
                                <input class="text-center"  disabled readonly  type="text" name="subtotal" id="subtotal<%=dproduk("pdID")%>" value="" style="border:none; width:5rem">
                            </td>
                            <td>
                                <%=dproduk("spoName")%>
                            </td>

                            <td class="text-center"><span class="text-center label-stpo1"> <i class="fas fa-check"></i> </span> </td>
                        </tr>
                    

                        <%else%>
                        
                        <tr style="background-color:#df9375; color:black">
                            <td class="text-center">
                                <input onchange="upCek<%=dproduk("pdID")%>()" class="CKMM" type="checkbox" name="CKMM" id="CKMM<%=dproduk("pdID")%>" style="display:none"><input required type="hidden" name="pdID" id="pdID<%=dproduk("pdID")%>" value="<%=dproduk("pdID")%>" >
                            </td>
                            <input  type="hidden" name="poid" id="poid<%=dproduk("pdID")%>" value="<%=dproduk("poID")%>">
                            <input  type="hidden" name="potanggal" id="potanggal<%=dproduk("pdID")%>" value="<%=dproduk("poTanggal")%>">

                            <td class="text-center"><%=dproduk("nourut")%> </td>

                            <td><%=dproduk("pdPartNumber")%> </td>

                            <td><input readonly type="text" name="namaproduk" id="namaproduk" value="<%=dproduk("pdNama")%>" style="width:11rem; background-color:#df9375;border:none"> </td>

                            <td class="text-center"><%=dproduk("poQtyProduk")%>
                                <input required type="hidden" name="mmpdQty" id="mmpdQty<%=dproduk("pdID")%>" value="<%=dproduk("poQtyProduk")%>"> 
                            </td>

                            <td class="text-center">
                                <input class=" qtyditerima text-center"required onblur="qty<%=dproduk("pdID")%>()"type="number" onkeyup="subtotal<%=dproduk("pdID")%>()" name="qtyditerima" id="qtyditerima<%=dproduk("pdID")%>" value="0" style="background-color:#df9375;width:3rem">
                            </td>

                            <td  class="text-center"><%=dproduk("poHargaSatuan")%>
                                <input  type="hidden" name="harga" id="harga<%=dproduk("pdID")%>" value="<%=dproduk("poHargaSatuan")%>">
                                <input  type="hidden" name="pajak" id="pajak<%=dproduk("pdID")%>" value="<%=dproduk("poPajak")%>">
                            </td>

                            <td><input class="text-center" readonly type="text" name="subtotal" id="subtotal<%=dproduk("pdID")%>" value="<%=dproduk("poTotal")%>" style="border:none;background-color:#df9375; width:5rem"> </td>

                            <td>
                            <input class="text-center" readonly type="hidden" name="statuspo" id="statuspo<%=dproduk("pdID")%>" value="" style="border:none; width:2rem">
                            <input class="text-center" readonly type="text" name="statuspoo" id="statuspoo<%=dproduk("pdID")%>" value="" style="border:none;background-color:#df9375;width:7rem">
                            </td>
                            <td>
                                <button name="btn-send" id="btn-send<%=dproduk("pdID")%>"class="cont-btn"onclick="sendmm<%=dproduk("pdID")%>()" style="width:4rem"> SEND </button>
                                <button name="btn-done" id="btn-done<%=dproduk("pdID")%>"class="cont-btn" style="display:none"> <i class="fas fa-check"></i> </button> 
                            </td>
                        </tr>
                    <%end if%>
                    <%end if%>
                <% dproduk.movenext
                loop%>
                </tbody>
            </table>
        </div>
    </div>
</div>

