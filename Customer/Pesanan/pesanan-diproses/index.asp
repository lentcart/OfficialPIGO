<!--#include file="../../../connections/pigoConn.asp"-->
<%
    if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if
	
    set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_strID, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID,  MKT_M_Customer.custID, MKT_T_Pesanan_H.psID, MKT_T_Transaksi_D1.trD1catatan FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Customer.custID = MKT_T_Transaksi_H.tr_custID FULL OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Pesanan_H RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Pesanan_H.ps_tr_slID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Pesanan_D ON MKT_T_Pesanan_H.psID = MKT_T_Pesanan_D.psD ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON LEFT(MKT_T_Transaksi_D1A.trD1A, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12)  LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_H.trID = MKT_T_Pesanan_H.ps_trID AND  LEFT(MKT_T_Transaksi_H.trID, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) where MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND MKT_T_Transaksi_D1.tr_strID = '01' OR MKT_T_Transaksi_D1.tr_strID = '05' GROUP BY MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_strID, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID,  MKT_M_Customer.custID, MKT_T_Pesanan_H.psID, MKT_T_Transaksi_D1.trD1catatan "
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute 
    
    set pdtr_cmd =  server.createObject("ADODB.COMMAND")
    pdtr_cmd.activeConnection = MM_PIGO_String
%>

<span><b> Pesanan Sedang Diproses Seller </b></span>
    <table class="table table-bordered table-condensed mt-2" style="font-size:11px">
        <thead class="align-items-center">
            <tr>
            <th class=" text-center">Produk</th>
            <th class=" text-center" >Qty </th>
            <th class=" text-center" >Sub Total</th>
            <th class=" text-center" scope="col">Status</th>
            <th class=" text-center" scope="col">Jasa Kirim</th>
            <th class=" text-center" scope="col">Aksi</th>
            </tr>
        </thead>
        <tbody>
        <% if Transaksi.eof = true then %>
            <tr>
                <th colspan="12" class="text-center"> <span> Belum Ada Pesanan </span></th>
            </tr>
        <% else %>
        <%do while not Transaksi.eof%>
        <% if Transaksi("tr_strID") = "1" then %>
        <tr>
            <th colspan="12"> Seller : <%=Transaksi("slName")%></th>
        </tr>
        <%
            pdtr_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_H.trID,MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran "
            'response.write pdtr_cmd.commandText
            set pdtr = pdtr_CMD.execute 
        %>
        <% do while not pdtr.eof %>
        <tr>
            <td>
                <div class="row">
                    <div class="col-3">
                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 80px;" alt=""/>
                    </div>
                    <div class="col-6">
                        <input type="text" name="" id="" value=" <%=pdtr("pdNama")%>">
                        <input type="text" name="" id="" value=" <%=Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp.")%>">
                    </div>
                </div>
            </td>
            <td class=" text-center" ><input type="text" name="" id="" value="<%=pdtr("tr_pdQty")%>" style="align-items:center; width:3rem"></td>
            <% subtotal = pdtr("tr_pdHarga") * pdtr("tr_pdQty")%>
                <td class=" text-center" ><input type="text" name="" id="" value="<%=subtotal%>"></td>
            <td class=" text-center" ><%=pdtr("strName")%></td>
            <td class=" text-center" ><%=pdtr("trPengiriman")%></td>
            <td class=" text-center" ><a href="pesanan-diproses/detail.asp?trID=<%=pdtr("trID")%>" style="font-size:11px"> Kirim Barang</a></td>
        <%pdtr.movenext
        loop%> 
        </tr>
        <% else %>
        <tr>
            <th colspan="12"> Seller : <%=Transaksi("slName")%></th>
            <input type="hidden" name="transaksiid" id="transaksiid" value="<%=Transaksi("trID")%>">
            <input type="hidden" name="pesananid" id="pesananid" value="<%=Transaksi("psID")%>">
            <input type="hidden" name="custid" id="custid" value="<%=Transaksi("custID")%>">
            <input type="hidden" name="catatan" id="catatan" value="<%=Transaksi("trD1catatan")%>">
            <input type="hidden" name="statustransaksi" id="statustransaksi" value="03">
            <input type="hidden" name="konfirmasi" id="konfirmasi" value="0">
            <input type="hidden" name="sellerid" id="sellerid" value="<%=Transaksi("tr_slID")%>">
        </tr>
        <%
            pdtr_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty,  MKT_T_StatusTransaksi.strName, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran, pd.pdImage1 AS gambar, pd.pdNama AS nama, pd.pdSku FROM MKT_T_Transaksi_D1A LEFT OUTER JOIN MKT_M_Produk LEFT OUTER JOIN MKT_M_Produk AS pd ON MKT_M_Produk.pdID = pd.pdID ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID AND LEFT(MKT_T_Transaksi_D1A.trD1A, 12)  = LEFT(MKT_T_Transaksi_D1.trD1, 12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' and MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' GROUP BY MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty,  MKT_T_StatusTransaksi.strName, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran, pd.pdImage1 , pd.pdNama, pd.pdSku "
            'response.write pdtr_cmd.commandText
            set pdtr = pdtr_CMD.execute 
        %>
        <% do while not pdtr.eof %>
        <tr>
            <td>
                <div class="row">
                    <div class="col-3">
                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 80px;" alt=""/>
                    </div>
                    <div class="col-6">
                        <input type="text" name="" id="" value=" <%=pdtr("pdNama")%>">
                        <input type="text" name="" id="" value=" <%=Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp.")%>">
                    </div>
                </div>
            </td>
            <td class=" text-center" ><input class="text-center" type="text" name="" id="" value="<%=pdtr("tr_pdQty")%>" style="align-items:center; width:3rem"></td>
            <% subtotal = pdtr("tr_pdHarga") * pdtr("tr_pdQty")%>
            <td class=" text-center" ><input class="text-center" type="text" name="" id="" value="<%=Replace(FormatCurrency(subtotal),"$","Rp. ")%>"></td>
            <td class=" text-center" ><%=pdtr("strName")%></td>
            <td class=" text-center" ><%=pdtr("trPengiriman")%></td>
            <td class=" text-center" ><button class="btn-konfirmasi" id="myBtn<%=pdtr("pdID")%>"> Konfirmasi Pesanan </button></td>
        </tr>
        <!-- Modal -->
            <!-- The Modal -->
            <div id="myModal<%=pdtr("pdID")%>" class="modall">

        <!-- Modal content -->
            <div class="modall-content">
                <div class="modal-body">
                    <div class="row mt-3">
                        <div class="col-11">
                            <span class="txt-modal-judul">Konfirmasi Pesanan</span>
                        </div>
                        <div class="col-1">
                            <span><i class="fas fa-times close<%=pdtr("pdID")%>"></i></span>
                        </div>
                    </div>
                    <hr>
                    <div class="body mt-3 mb-3" style="padding:5px 20px">
                        <div class="row align-items-center">
                            <div class="col-12">
                                <div class="row text-center">
                                    <div class="col-12">
                                        <span class="txt-modal-desc"> Konfirmasi Pesanan Untuk Produk Berikut : </span> <br>
                                    </div>
                                </div>
                                <div class="row mt-2 mb-2">
                                    <div class="col-2 me-2">
                                        <img src="data:image/png;base64,<%=pdtr("gambar")%>" style="height:60px;width: 80px;" alt=""/>
                                    </div>
                                    <div class="col-9">
                                        <span class="txt-modal-desc"> <%=pdtr("nama")%> </span><br>
                                        <% subtotal = pdtr("tr_pdHarga") * pdtr("tr_pdQty")%>
                                        <span class="txt-modal-desc"> [ <%=Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp.")%> ] x [ <%=pdtr("tr_pdQty")%> ] = <%=Replace(FormatCurrency(subtotal),"$","Rp. ")%> </span><br>
                                        <span class="txt-modal-desc"> </span><br>
                                        
                                    </div>
                                </div>
                                <div class="row mt-2 mb-2 text-center">
                                    <div class="col-12">
                                        <button onclick="return konfirmasi<%=pdtr("pdID")%>()" class="btn-konfirmasi"> Pesanan Telah Di Ambil </button><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
            <!-- Modal content -->

            </div>
            <script>
                function konfirmasi<%=pdtr("pdID")%>(){
                    var trID = document.getElementById("transaksiid").value;
                    var psID = document.getElementById("pesananid").value;
                    var tr_custID = document.getElementById("custid").value;
                    var psKonfirmasi = document.getElementById("konfirmasi").value;
                    var psCatatan = document.getElementById("catatan").value;
                    var psStatusTransaksi = document.getElementById("statustransaksi").value;
                    var tr_slID = document.getElementById("sellerid").value;
                    
                    $.ajax({
                        type: "POST",
                        url: "Pesanan-diproses/P-pesanandiproses.asp",
                        data: { 
                            trID:trID,
                            psID:psID,
                            tr_custID:tr_custID,
                            psKonfirmasi:psKonfirmasi,
                            psCatatan:psCatatan,
                            psStatusTransaksi:psStatusTransaksi,
                            tr_slID:tr_slID,
                        },
                        success: function (data) {
                            // console.log(data);
                            alert("Pesanan Telah Diterima");
                            
                        }
                    });
                }
                var modal<%=pdtr("pdID")%> = document.getElementById("myModal<%=pdtr("pdID")%>");
                var btn<%=pdtr("pdID")%> = document.getElementById("myBtn<%=pdtr("pdID")%>");
                var span<%=pdtr("pdID")%> = document.getElementsByClassName("close<%=pdtr("pdID")%>")[0];
                btn<%=pdtr("pdID")%>.onclick = function() {
                modal<%=pdtr("pdID")%>.style.display = "block";
                }
                span<%=pdtr("pdID")%>.onclick = function() {
                modal<%=pdtr("pdID")%>.style.display = "none";
                }
                window.onclick = function(event) {
                if (event.target == modal<%=pdtr("pdID")%>) {
                    modal<%=pdtr("pdID")%>.style.display = "none";
                }
                }
            </script>
        <!-- Modal -->
        <%pdtr.movenext
        loop%> 
        <% end if %>
        <%Transaksi.movenext
        loop%>
        <%end if%>
        </tbody>
    </table>