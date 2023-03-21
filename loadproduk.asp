<!--#include file="Connections/pigoConn.asp" -->
<%
    id= request.queryString("x")

    set ProdukTerjual_cmd = server.CreateObject("ADODB.command")
    ProdukTerjual_cmd.activeConnection = MM_pigo_STRING

    set loadproduk_CMD = server.CreateObject("ADODB.command")
    loadproduk_CMD.activeConnection = MM_pigo_STRING

    loadproduk_CMD.commandText = "select top 3 * from MKT_M_Produk where pdID > '"& id &"'  Order BY pdID, pdUpdateTime ASC"
    'response.write loadproduk_CMD.commandText
    set produk = loadproduk_CMD.execute

%>

    <%
                        if produk.eof = true then 
                    %>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-12 mt-2 text-center ">
                        <span style="color:#0077a2; font-size:13px; font-weight:550"> Tidak Ada Produk Lainnya </span>
                    </div>
                    <script>
                        $('.btn-produk-rekom').hide();
                    </script>
                    <%
                        else
                    %>
                    <% do while not produk.eof %>
                    <div class="col-lg-2 col-md-2 col-sm-1 col-6 mt-2 ">
                        <form action="singleproduk.asp" method="post" id="pdID<%=produk("pdID")%>">
                            <button type="submit" style="border:none; background:none">
                                <div class="card mt-3 mb-2 me-2">
                                <img src="data:image/png;base64,<%=produk("pdImage1")%>" class="card-img-top rounded" alt="...">
                                <!--<input class="terlaris" type="text" name="promo" id="promo" value="Promo" style="border:none" readonly>-->
                                <div class="card-body">
                                    <input readonly class="tx-card" onclick="return produk()" type="text" name="pdNama" id="pdNama" value="<%=produk("pdNama")%>"><br>
                                    <input readonly class="tx-card" type="hidden" name="pdID" id="pdID<%=produk("pdID")%>" value="<%=produk("pdID")%>">
                                    <input class="hg-card" type="text" name="pdHarga" id="pdHarga" value="<%=Replace(Replace(FormatCurrency(produk("pdHargaJual")),"$","Rp. "),".00","")%>"><br>
                                    <!--<span class="terjual" style="background-color:red; color:white">50%</span>
                                    <span class="terjual"><del>Rp 100.000</del></span>-->
                                    <div class="row mt-2">
                                        <div class="col-6">
                                            <img src="assets/produk/icon-star.png" width="11px" class="terjual">
                                            <span class="label-card"> 4.9 </span>
                                        </div>
                                        <%
                                            ProdukTerjual_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdQty),0) AS total FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  produk("pdID") &"') AND (MKT_M_Produk.pd_custID = '"&  produk("pd_custID") &"') GROUP BY  MKT_T_Transaksi_D1A.tr_pdID, MKT_M_Produk.pd_custID" 
                                            set ProdukTerjual = ProdukTerjual_cmd.execute
                                        %>
                                        <% if ProdukTerjual.eof = true then %>
                                        <div class="col-6">
                                            <span class="label-card"> 0 Terjual </span>
                                        </div>
                                        <% else %>
                                        <div class="col-6">
                                            <span class="label-card"> <%=ProdukTerjual("total")%> Terjual </span>
                                        </div>
                                        <% end if %>
                                    </div>
                                </div>
                            </div>
                            </button>
                        </form>
                    </div>
                    <% 
                    LpdID = produk("pdID") 
                    produk.movenext
                    loop
                    response.Cookies("lpd")=LpdID 
                    %>
                    <% end if %>
                    <div class="row" id="<%=LpdID%>">
                    </div>
                    <script>
                        function loadproduk(){
                            var produkid = `<%=LpdID%>`;
                            console.log(produkid);
                            // console.log(produkid);
                            $.get(`loadproduk.asp?x=${produkid}`,function(data){
                                // console.log(data);
                                $('#<%=LpdID%>').html(data);
                            })
                            // $.ajax({
                            //     type: "GET",
                            //     url: "loadproduk.asp",
                            //     data:{
                            //             produkid
                            //         },
                            //     success: function (data) {
                            //         $('#load-produk-rekomendasi').html(data);
                            //     }
                            // });
                        }
                    </script>