<!--#include file="../../connections/pigoConn.asp"-->
<%
    if request.Cookies("custEmail")="" then 
    response.redirect("../")
    end if

	statuspesanan = request.queryString("statusps")

    set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String
    if statuspesanan = "y" then
        Transaksi_cmd.commandText = "SELECT top 10 MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID,MKT_T_Transaksi_D1.tr_IDBooking,trUpdateTime,tr_LinkPayment FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_H.trID, 12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID where MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' GROUP BY MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman,MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID,MKT_T_Transaksi_D1.tr_IDBooking,trUpdateTime,tr_LinkPayment ORDER BY trUpdateTime DESC"
        'response.write Transaksi_cmd.commandText
        set Transaksi = Transaksi_CMD.execute 
    else 
        Transaksi_cmd.commandText = "SELECT top 10 MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID,MKT_T_Transaksi_D1.tr_IDBooking,trUpdateTime,tr_LinkPayment FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_H.trID, 12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID where MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND MKT_T_Transaksi_D1.tr_strID = '"& statuspesanan &"'  GROUP BY MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID,MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID,MKT_T_Transaksi_D1.tr_IDBooking ,trUpdateTime, tr_LinkPayment ORDER BY trUpdateTime DESC"
        'response.write Transaksi_cmd.commandText
        set Transaksi = Transaksi_CMD.execute 
    end if 
    set pdtr_cmd =  server.createObject("ADODB.COMMAND")
    pdtr_cmd.activeConnection = MM_PIGO_String
%>


<% if Transaksi.eof = true then %>
    <div class="cont-pesanan" style="background-color:white;padding:100px 100px">
        <div class="row text-center align-items-center">
            <div class="col-12">
                <img src="<%=base_url%>/assets/logo/empty.jpg" style="height:20vh;width:20vh;" alt=""/>
            </div>
        </div>
        <div class="row text-center align-items-center">
            <div class="col-12">
                <span class="cont-text" class="text2-ps-cust"> Belum Ada Pesanan </span>
            </div>
        </div>
    </div>
<% else %>


<!-- Status Pesanan Menunggu Pembayaran -->
<% if statuspesanan = "00" then %>

    <% do while not Transaksi.eof %>
        <div class="cont-pesanan mb-3">
            <div class="row align-items-center"> 
                <div class = "col-5">
                    <span class="text1-ps-cust" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> &nbsp;&nbsp; <button class="btn1-ps-cust"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> &nbsp;&nbsp;
                    <button class="btn2-ps-cust" onclick="window.open('<%=base_url%>/Seller/Profile/','_Self')"> Kunjungi Seller </button>
                </div>
                <div class = " text-end col-7">
                    <span onclick="detailpesanan('<%=Transaksi("trID")%>')" class="text2-ps-cust"> <%=Transaksi("strName")%></span> &nbsp; | &nbsp; 
                    <span class="text2-ps-cust" >No Transaksi :  <%=Transaksi("trID")%></span> &nbsp; 
                    <button class="btn1-ps-cust"> <i class="fas fa-clipboard-list"></i> </button>
                </div>
            </div>
            <hr style="color:#0077a2">
            <%
                pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
                'response.write pdtr_cmd.commandText
                set pdtr = pdtr_CMD.execute 
            %>
            <% do while not pdtr.eof %>
                <div class="row align-items-center"> 
                    <div class="col-1">
                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                    </div>
                    <div class="col-9">
                        <span class="text3-ps-cust"> <%=pdtr("pdNama")%> </span> <br>
                        <span class="text4-ps-cust"> <%=pdtr("pdSku")%> </span> <br>
                        <span class="text4-ps-cust"> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                    </div>
                    <div class="text-end col-2">
                        <span class="text5-ps-cust"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                    </div>
                </div>
            <hr style="color:#0077a2">
            <%
                pdtr.movenext
                loop
            %>
            <div class="row"> 
                <div class="text-start col-7">
                    <span class="text5-ps-cust"> Bayar Sebelum : </span> &nbsp;&nbsp;
                    <button class="btn1-ps-cust" onclick="window.open('<%=Transaksi("tr_LinkPayment")%>')"> Bayar Sekarang </button> &nbsp; &nbsp;
                    <button class="btn2-ps-cust"> Hubungi Penjual </button>

                </div>
                <div class="text-end col-5">
                    <span class="text2-ps-cust"> Jumlah Yang Harus Dibayar : </span> &nbsp; 
                    <span class="text5-ps-cust" style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                </div>
            </div>
        </div>
    <% Transaksi.movenext
    loop %>


<!-- Status Pesanan Sedang Dikemas -->
<% else if statuspesanan = "01" then %>

    <% do while not Transaksi.eof %>
        <div class="cont-pesanan mb-3">
            <div class="row align-items-center"> 
                <div class = "col-6">
                    <span class="text1-ps-cust" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> &nbsp;&nbsp; <button class="btn1-ps-cust"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> &nbsp;&nbsp;
                    <button class="btn2-ps-cust" onclick="window.open('<%=base_url%>/Seller/Profile/','_Self')"> Kunjungi Seller </button>
                </div>
                <div class = " text-end col-4" style="border-right:2px solid #c70505">
                    <% if Transaksi("tr_IDBooking") = "" then %>
                        <span class="text5-ps-cust"><i class="fas fa-box"></i>&nbsp;Seller sedang menyiapkan pesanan anda</span>
                    <% else %>
                        <span class="text5-ps-cust"><i class="fas fa-truck"></i>&nbsp;Menunggu paket diserahkan ke pihak jasa kirim</span>
                    <% end if %>
                </div>
                <div class = " text-end col-2">
                    <span onclick="detailpesanan('<%=Transaksi("trID")%>')" class="text2-ps-cust"> <%=Transaksi("strName")%></span>
                </div>
            </div>
            <hr style="color:#0077a2">
            <%
                pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
                'response.write pdtr_cmd.commandText
                set pdtr = pdtr_CMD.execute 
            %>
            <% do while not pdtr.eof %>
                <div class="row align-items-center"> 
                    <div class="col-1">
                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                    </div>
                    <div class="col-9">
                        <span class="text3-ps-cust"> <%=pdtr("pdNama")%> </span> <br>
                        <span class="text4-ps-cust"> <%=pdtr("pdSku")%> </span> <br>
                        <span class="text4-ps-cust"> <i class="fas fa-box"></i> &nbsp; x <%=pdtr("tr_pdQty")%> </span> <br>
                    </div>
                    <div class="text-end col-2">
                        <span class="text5-ps-cust"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                    </div>
                </div>
            <hr style="color:#0077a2">
            <%
                pdtr.movenext
                loop
            %>
            <div class="row"> 
                <div class="text-start col-8">
                    <span class="text5-ps-cust"> Produk akan dikirim paling lambat pada : </span> &nbsp;&nbsp;
                    <button class="btn1-ps-cust"> Hubungi Penjual </button> &nbsp; &nbsp;
                    <button class="btn2-ps-cust"> Batalkan Pesanan </button>

                </div>
                <div class="text-end col-4">
                    <span class="text2-ps-cust"> Total Pesanan </span> &nbsp; 
                    <span class="text5-ps-cust" style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                </div>
            </div>
        </div>
    <% Transaksi.movenext
    loop %>


<!-- Status Pesanan Sedang Dalam Pengiriman -->
<% else if statuspesanan = "02" then %>

    <% do while not Transaksi.eof %>
        <div class="cont-pesanan mb-3">
            <div class="row align-items-center"> 
                <div class = "col-6">
                    <span class="text1-ps-cust" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> &nbsp;&nbsp; <button class="btn1-ps-cust"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> &nbsp;&nbsp;
                    <button class="btn2-ps-cust" onclick="window.open('<%=base_url%>/Seller/Profile/','_Self')"> Kunjungi Seller </button>
                </div>
                <div class = " text-end col-4" style="border-right:2px solid #c70505">
                <% if Transaksi("tr_IDBooking") = "" then %>
                    <span onclick="detailpesanan('<%=Transaksi("trID")%>')" style="color:#c70505; font-size:12px"><i class="fas fa-box"></i>&nbsp;Seller sedang menyiapkan pesanan anda</span>
                <% else %>
                <script>
                    $.get( "Get-StatusPengiriman.asp?SuratJalan=<%=Transaksi("trID")%>", function( data ) {
                        var jsonData = JSON.parse(data);
                        $("#statusdev<%=Transaksi("trID")%>").text(jsonData.Keterangan);
                        var status = jsonData.Status;
                        if ( status == "Delivered"){
                            $('#nonDeliv<%=Transaksi("trID")%>').hide()
                            $('#Deliv<%=Transaksi("trID")%>').show();
                            $('#cancleps<%=Transaksi("trID")%>').hide();
                        }else{
                            $('#nonDeliv<%=Transaksi("trID")%>').show();
                            $('#cancleps<%=Transaksi("trID")%>').show();
                            $('#Deliv<%=Transaksi("trID")%>').hide()
                        }
                    });
                        </script>
                    <span onclick="detailpesanan('<%=Transaksi("trID")%>')" style="color:#c70505; font-size:12px"  id="statusdev<%=Transaksi("trID")%>"><i class="fas fa-truck"></i></span>
                <% end if %>
                </div>
                <div class = " text-end col-2">
                    <span  onclick="detailpesanan('<%=Transaksi("trID")%>')"class="text2-ps-cust"> <%=Transaksi("strName")%></span>
                </div>
            </div>
            <hr style="color:#0077a2">
            <%
                pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
                'response.write pdtr_cmd.commandText
                set pdtr = pdtr_CMD.execute 
            %>
            <% do while not pdtr.eof %>
                <div class="row align-items-center"> 
                    <div class="col-1">
                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                    </div>
                    <div class="col-9">
                        <span class="text3-ps-cust"> <%=pdtr("pdNama")%> </span> <br>
                        <span class="text4-ps-cust"> <%=pdtr("pdSku")%> </span> <br>
                        <span class="text4-ps-cust"> <i class="fas fa-box"></i> &nbsp; x <%=pdtr("tr_pdQty")%> </span> <br>
                    </div>
                    <div class="text-end col-2">
                        <span class="text5-ps-cust"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                    </div>
                </div>
            <hr style="color:#0077a2">
            <%
                pdtr.movenext
                loop
            %>
            <div class="row"> 
                <div class="text-start col-8">
                    <span class="text5-ps-cust"> Silahkan konfirmasi setelah menerima dan mengecek pesanan </span> &nbsp;
                    <button class="btn1-ps-cust" id="Deliv<%=Transaksi("trID")%>"  style="display:none" onclick="pesananditerima('<%=Transaksi("trID")%>','<%=Transaksi("tr_slID")%>','<%=Transaksi("custID")%>','<%=Transaksi("trTotalPembayaran")%>')"> Pesanan Diterima</button>
                    &nbsp; &nbsp; <button class="btn2-ps-cust"> Hubungi Penjual </button>
                    &nbsp; &nbsp; <button class="btn2-ps-cust"id="cancleps<%=Transaksi("trID")%>"style="display:block" > Batalkan Pesanan </button>

                </div>
                <div class="text-end col-4">
                    <span class="text2-ps-cust"> Total Pesanan </span> &nbsp; 
                    <span class="text5-ps-cust" style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                </div>
            </div>
        </div>
    <% Transaksi.movenext
    loop %>


<!-- Status Pesanan Selesai -->
<% else if statuspesanan = "03" then %>

    <% do while not Transaksi.eof %>
        <div class="cont-pesanan mb-3">
            <div class="row align-items-center"> 
                <div class = "col-6">
                    <span class="text1-ps-cust" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> &nbsp;&nbsp; <button class="btn1-ps-cust"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> &nbsp;&nbsp;
                    <button class="btn2-ps-cust" onclick="window.open('<%=base_url%>/Seller/Profile/','_Self')"> Kunjungi Seller </button>
                </div>
                <div class = " text-end col-4" style="border-right:2px solid #c70505">
                <% if Transaksi("tr_IDBooking") = "" then %>
                    <span onclick="detailpesanan('<%=Transaksi("trID")%>')" style="color:#c70505; font-size:12px"><i class="fas fa-box"></i>&nbsp;Seller sedang menyiapkan pesanan anda</span>
                <% else %>
                <script>
                    $.get( "Get-StatusPengiriman.asp?SuratJalan=<%=Transaksi("trID")%>", function( data ) {
                        var jsonData = JSON.parse(data);
                        $("#statusdev<%=Transaksi("trID")%>").text(jsonData.Keterangan);
                        var status = jsonData.Status;
                        if ( status == "Delivered"){
                            $('#nonDeliv<%=Transaksi("trID")%>').hide()
                            $('#cancleps<%=Transaksi("trID")%>').hide();
                            $('#Deliv<%=Transaksi("trID")%>').show();
                            
                        }else{
                            $('#cancleps<%=Transaksi("trID")%>').show();
                            $('#nonDeliv<%=Transaksi("trID")%>').show();
                            $('#Deliv<%=Transaksi("trID")%>').hide()
                        }
                    });
                        </script>
                    <span onclick="detailpesanan('<%=Transaksi("trID")%>')" style="color:#c70505; font-size:12px"  id="statusdev<%=Transaksi("trID")%>"><i class="fas fa-truck"></i></span>
                <% end if %>
                </div>
                <div class = " text-end col-2">
                    <span  onclick="detailpesanan('<%=Transaksi("trID")%>')"class="text2-ps-cust"> <%=Transaksi("strName")%></span>
                </div>
            </div>
            <hr style="color:#0077a2">
            <%
                pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
                'response.write pdtr_cmd.commandText
                set pdtr = pdtr_CMD.execute 
            %>
            <% 
                do while not pdtr.eof 
            %>
                <div class="row align-items-center"> 
                    <div class="col-1">
                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                    </div>
                    <div class="col-9">
                        <span class="text3-ps-cust"> <%=pdtr("pdNama")%> </span> <br>
                        <span class="text4-ps-cust"> <%=pdtr("pdSku")%> </span> <br>
                        <span class="text4-ps-cust"> <i class="fas fa-box"></i> &nbsp; x <%=pdtr("tr_pdQty")%> </span> <br>
                    </div>
                    <div class="text-end col-2">
                        <span class="text5-ps-cust"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                    </div>
                </div>
            <hr style="color:#0077a2">
            <%
                pdtr.movenext
                loop
            %>
            <div class="row"> 
                <div class="text-start col-8">
                    <span class="text5-ps-cust"> Tidak ada penilaian diterima </span> &nbsp;
                    <button class="btn1-ps-cust" id="Deliv<%=Transaksi("trID")%>"  onclick="nilaiproduk('<%=Transaksi("trID")%>','<%=Transaksi("tr_slID")%>','<%=Transaksi("custID")%>','<%=Transaksi("trTotalPembayaran")%>','<%=img%>','<%=NamaProduk%>')"> Nilai Produk </button>
                    &nbsp;&nbsp; <button class="btn2-ps-cust"> Hubungi Penjual </button>
                    &nbsp;&nbsp; <button class="btn1-ps-cust"> Beli Lagi </button>

                </div>
                <div class="text-end col-4">
                    <span class="text2-ps-cust"> Total Pesanan : </span> &nbsp; 
                    <span class="text5-ps-cust" style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                </div>
            </div>
        </div>
    <% Transaksi.movenext
    loop %>


<!-- Status Pesanan Dibatalkan -->
<% else if statuspesanan = "04" then %>

    <% do while not Transaksi.eof %>
        <div class="cont-pesanan mb-3">
            <div class="row align-items-center"> 
                <div class = "col-6">
                    <span class="text1-ps-cust" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> &nbsp;&nbsp; <button class="btn1-ps-cust"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> &nbsp;&nbsp;
                    <button class="btn2-ps-cust" onclick="window.open('<%=base_url%>/Seller/Profile/','_Self')"> Kunjungi Seller </button>
                </div>
                <div class = " text-end col-6">
                    <span  onclick="detailpesanan('<%=Transaksi("trID")%>')"class="text2-ps-cust"> <%=Transaksi("strName")%></span>
                </div>
            </div>
            <hr style="color:#0077a2">
            <%
                pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
                'response.write pdtr_cmd.commandText
                set pdtr = pdtr_CMD.execute 
            %>
            <% 
                do while not pdtr.eof 
            %>
                <div class="row align-items-center"> 
                    <div class="col-1">
                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                    </div>
                    <div class="col-9">
                        <span class="text3-ps-cust"> <%=pdtr("pdNama")%> </span> <br>
                        <span class="text4-ps-cust"> <%=pdtr("pdSku")%> </span> <br>
                        <span class="text4-ps-cust"> <i class="fas fa-box"></i> &nbsp; x <%=pdtr("tr_pdQty")%> </span> <br>
                    </div>
                    <div class="text-end col-2">
                        <span class="text5-ps-cust"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                    </div>
                </div>
                <hr style="color:#0077a2">
            <%
                pdtr.movenext
                loop
            %>
            <div class="row"> 
                <div class="text-start col-8">
                    <span class="text5-ps-cust"> Dibatalkan secara otomatis oleh sistem Official PIGO </span> &nbsp;
                    <button class="btn2-ps-cust"> Beli Lagi </button> &nbsp; 
                    <button class="btn1-ps-cust"> Hubungi Penjual </button> &nbsp; 
                    <button class="btn1-ps-cust"> Rincian Pembatalan </button> &nbsp; 

                </div>
                <div class="text-end col-4">
                    <span class="text2-ps-cust"> Total Pesanan : </span> &nbsp; 
                    <span class="text5-ps-cust" style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                </div>
            </div>
        </div>
    <% Transaksi.movenext
    loop %>
<% end if %> <% end if %> <% end if %> <% end if %> <% end if %>
<% end if %>