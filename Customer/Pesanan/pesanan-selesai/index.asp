<!--#include file="../../../connections/pigoConn.asp"-->
<%
    if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if
	
    set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_H.trID, 12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID FULL OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) AND MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID where MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND MKT_T_Transaksi_D1.tr_strID = '03'  GROUP BY MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID "
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute 
    
    set pdtr_cmd =  server.createObject("ADODB.COMMAND")
    pdtr_cmd.activeConnection = MM_PIGO_String

	set review_cmd =  server.createObject("ADODB.COMMAND")
    review_cmd.activeConnection = MM_PIGO_String

    

%>
<span><b> Pesanan Selesai</b></span>
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
        <tr>
            <th colspan="12"> Seller : <%=Transaksi("slName")%></th>
        </tr>
        <%
                pdtr_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.trPengiriman, MKT_M_Produk.pdID, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga,   MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_StatusTransaksi.strName, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran,  pd.pdImage1 AS gambar FROM MKT_T_Transaksi_D1A LEFT OUTER JOIN MKT_M_Produk INNER JOIN MKT_M_Produk AS pd ON MKT_M_Produk.pdID = pd.pdID ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID AND LEFT(MKT_T_Transaksi_D1A.trD1A, 12)  = LEFT(MKT_T_Transaksi_D1.trD1, 12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' and MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran,MKT_T_Transaksi_D1A.tr_pdID,MKT_T_Transaksi_H.trID,pd.pdImage1 "
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
                        <input type="hidden" name="" id="" value=" <%=pdtr("pdID")%>">
                        <input type="text" name="" id="" value=" <%=Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp.")%>">
                    </div>
                </div>
            </td>
            <td class=" text-center" ><input type="text" name="" id="" value="<%=pdtr("tr_pdQty")%>" style="align-items:center; width:3rem"></td>
            <%
                total = pdtr("tr_pdHarga") * pdtr("tr_pdQty")
            %>
            <td class=" text-center" ><input type="text" name="" id="" value="<%=Replace(FormatCurrency(total),"$","Rp.")%>"></td>
            <td class=" text-center" ><%=pdtr("strName")%></td>
            <td class=" text-center" ><%=pdtr("trPengiriman")%></td>
            <% 
                review_cmd.commandText = "SELECT MKT_T_Reviews.trID, MKT_T_Reviews.tr_pdID, MKT_T_Reviews.tr_pdHarga, MKT_T_Reviews.tr_custID, MKT_T_Reviews.tr_slID, MKT_T_Reviews.ReviewTanggal, MKT_T_Reviews.ReviewProduk,  MKT_T_Reviews.RUpdateTime, MKT_T_Reviews.RAktifYN FROM MKT_T_Reviews LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Reviews.tr_pdID = MKT_M_Produk.pdID LEFT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Reviews.trID = MKT_T_Transaksi_H.trID WHERE  (MKT_T_Reviews.tr_custID = '"& request.Cookies("custID") &"' )"
                'response.write review_cmd.commandText
                set review = review_CMD.execute
            %>
            <% if review.eof = true then%>
            <td class=" text-center" >
                <button  class="btn-review"  ><a href="pesanan-selesai/detail.asp?trID=<%=Transaksi("trID")%>" style="font-size:11px"> Detail Pesanan </a></button>
                <br><br>
                <button  class="btn-review" data-bs-toggle="modal" data-bs-target="#exampleModal<%=pdtr("tr_pdID")%>" >Berikan Ulasan</button>
            <%else%>
            <td class=" text-center" >
                <button  class="btn-review"  ><a href="pesanan-selesai/detail.asp?trID=<%=Transaksi("trID")%>" style="font-size:11px"> Detail Pesanan </a></button>
            </td>
            <%end if%>
        
        </tr>
        <!-- Modal -->
                <div class="modal fade" id="exampleModal<%=pdtr("tr_pdID")%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel"> Berikan Ulasan </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-2">
                                        <img src="data:image/png;base64,<%=pdtr("gambar")%>" style="height:60px;width: 80px;" alt=""/>
                                    </div>
                                    <div class="col-10">
                                        <input type="hidden" name="idtransaksi" id="idtransaksi<%=pdtr("tr_pdID")%>" value="<%=Transaksi("trID")%>">
                                        <input type="hidden" name="idproduk" id="idproduk<%=pdtr("tr_pdID")%>" value="<%=pdtr("tr_pdID")%>">
                                        <input type="hidden" name="idcustomer" id="idcustomer<%=pdtr("tr_pdID")%>" value="<%=Transaksi("custID")%>">
                                        <input type="hidden" name="idseller" id="idseller<%=pdtr("tr_pdID")%>" value="<%=Transaksi("tr_slID")%>">
                                        <input type="text" name="pdNama" id="pdNama" value="<%=pdtr("pdNama")%>">
                                        <input type="hidden" name="hargaproduk" id="hargaproduk<%=pdtr("tr_pdID")%>" value="<%=pdtr("tr_pdharga")%>">
                                        <input type="text" name="pdHarga" id="pdHarga" value="<%=Replace(FormatCurrency(pdtr("tr_pdharga")),"$","Rp. ")%>">
                                        <Strong><input type="text" name="strName" id="strName" value="<%=pdtr("strName")%>"></strong>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <span> Tuliskan Ulasan </span><br>
                                        <textarea id="review<%=pdtr("tr_pdID")%>" name="review" rows="4" cols="62" value=""></textarea>
                                        <button class="btn-review" onclick="return sendajax()"> Kirim Ulasan </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>
                        function sendajax(){
                            var trID=$('#idtransaksi<%=pdtr("tr_pdID")%>').val(); 
                            var pdID=$('#idproduk<%=pdtr("tr_pdID")%>').val();
                            var harga=$('#hargaproduk<%=pdtr("tr_pdID")%>').val();
                            var custID=$('#idcustomer<%=pdtr("tr_pdID")%>').val();
                            var slID=$('#idseller<%=pdtr("tr_pdID")%>').val();
                            var ulasan=$('#review<%=pdtr("tr_pdID")%>').val();
                            $.ajax({
                                method: 'GET',
                                    data:{
                                            trID:trID, 
                                            pdID:pdID, 
                                            harga:harga, 
                                            custID:custID,
                                            slID:slID, 
                                            ulasan:ulasan
                                        },
                                        url: 'Review/P-Reviews.asp',
                                    traditional: true,
                                    success: function (data) {
                                        // console.log(data);
                                        
                                        Swal.fire({
                                        text: 'Ulasan Berhasil Dikirim'
                                    });
                                    }
                                });
                            }
                    </script>
                </div>

        <!-- Modal -->
        <%pdtr.movenext
        loop%> 
        <%Transaksi.movenext
        loop%>
        <%end if%>
        </tbody>
    </table>


