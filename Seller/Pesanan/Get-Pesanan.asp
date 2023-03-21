<!--#include file="../../connections/pigoConn.asp"-->
<%

    if request.Cookies("custEmail")="" then 
    response.redirect("../")
    end if

    statuspesanan = request.queryString("statusps")

    set Seller_cmd =  server.createObject("ADODB.COMMAND")
    Seller_cmd.activeConnection = MM_PIGO_String

    Seller_cmd.commandText = "SELECT  top 10 MKT_M_Customer.custPhoto, MKT_M_Seller.slName FROM MKT_M_Customer LEFT OUTER JOIN  MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID  where sl_custID = '"& request.Cookies("custID") &"'  group by MKT_M_Customer.custPhoto, MKT_M_Seller.slName "
    set Seller = Seller_CMD.execute

    set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    if statuspesanan = "y" then
        Transaksi_cmd.commandText = "SELECT top 5  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi,trUpdateTime, MKT_M_Customer.custNama, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName,MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_H.tr_custID,MKT_T_Transaksi_H.trTotalPembayaran,MKT_T_Transaksi_D1.tr_slID, CONVERT(VARCHAR(5), trUpdateTime,108) AS Waktu, MKT_T_Transaksi_D1.tr_IDBooking,MKT_T_StatusTransaksi.strID FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Customer.custID = MKT_T_Transaksi_H.tr_custID ON left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' GROUP BY  MKT_T_Transaksi_H.trID,trUpdateTime,MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_H.trTglTransaksi, MKT_M_Customer.custNama, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName,MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_H.tr_custID,MKT_T_Transaksi_D1.trPengiriman,MKT_T_Transaksi_D1.tr_IDBooking, MKT_T_StatusTransaksi.strIDORDER BY trUpdateTime DESC"
        'response.write Transaksi_cmd.commandText
        set Transaksi = Transaksi_CMD.execute 
    else
        Transaksi_cmd.commandText = "SELECT top 5  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi,trUpdateTime, MKT_M_Customer.custNama, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName,MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_H.tr_custID,MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_D1.tr_slID, CONVERT(VARCHAR(5), trUpdateTime,108) AS Waktu, MKT_T_Transaksi_D1.tr_IDBooking,MKT_T_StatusTransaksi.strID FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Customer.custID = MKT_T_Transaksi_H.tr_custID ON left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND MKT_T_Transaksi_D1.tr_strID = '"& statuspesanan &"' GROUP BY  MKT_T_Transaksi_H.trID,trUpdateTime, MKT_T_Transaksi_H.trTglTransaksi, MKT_M_Customer.custNama, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName,MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_H.tr_custID,MKT_T_Transaksi_D1.trPengiriman,MKT_T_Transaksi_D1.tr_IDBooking,MKT_T_StatusTransaksi.strID ORDER BY trUpdateTime DESC"
        'response.write Transaksi_cmd.commandText
        set Transaksi = Transaksi_CMD.execute 
    end if 

    Transaksi_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdID),0) AS SemuaTransaksi FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_D1.tr_slID ='"& request.Cookies("custID") &"' AND (MKT_T_Transaksi_D1.tr_strID = '"& statuspesanan &"')"
    'response.write Transaksi_cmd.commandText
    set SemuaTransaksi = Transaksi_CMD.execute

%>
<div class="row">
    <div class="col-12">
        <div class="header-cont-list-order">
            <div class="row mt-2">
                <div class="col-2">
                    <span class="cont-text"> Waktu Pemesanan </span>
                </div>
                <div class="col-2">
                    <input type="date" class="cont-form" name="searchtime" id="searchtime" value="">
                </div>
                <div class="col-2">
                    <input type="date" class="cont-form" name="searchtime" id="searchtime" value="">
                </div>
                <div class="col-2">
                    <button class="cont-btn"> Download </button>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-2">
                    <select class="cont-form" aria-label="Default select example">
                        <option value="">Cari Berdasarkan</option>
                        <option value="1">One</option>
                        <option value="2">Two</option>
                        <option value="3">Three</option>
                    </select>
                </div>
                <div class="col-8">
                    <input type="search" class="cont-form" name="search" id="search" value="">
                </div>
                <div class="col-1">
                    <button class="cont-btn"> Cari </button>
                </div>
                <div class="col-1">
                    <button class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                </div>
            </div>
        </div>
        <hr>
        <div class="body-cont-list-order">
            <div class="row mb-3">
                <div class="col-2">
                    <span class="cont-text"> (<%=SemuaTransaksi("SemuaTransaksi")%>) Pesanan </span>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                <% if Transaksi.eof = true then %>
                    <div class="cont-pesanan" style="background-color:white;padding:100px 100px">
                        <div class="row text-center align-items-center">
                            <div class="col-12">
                                <img src="<%=base_url%>/assets/logo/empty.jpg" style="height:20vh;width:20vh;" alt=""/>
                            </div>
                        </div>
                        <div class="row text-center align-items-center">
                            <div class="col-12">
                                <span class="cont-text" style="color:#0077a2"> Belum Ada Pesanan </span>
                            </div>
                        </div>
                    </div>
                <% else %>
                    <% if statuspesanan = "00" then %>
                        <!-- Status Pesanan Menunggu Pembayaran -->
                        <% 
                            do while not Transaksi.eof 
                        %>
                            <div class="cont-pesanan mb-3">
                                <div class="row align-items-center"> 
                                    <div class="col-8">
                                        <span class="text1-ps-seller"> <i class="fas fa-user"></i> &nbsp; <%=Transaksi("custNama")%> </span> &nbsp;&nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-envelope"></i> &nbsp; Chat </button>
                                    </div>
                                    <div class="text-end col-4">
                                        <span class="text2-ps-seller">No Transaksi :  <%=Transaksi("trID")%></span> &nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-clipboard-list"></i> </button>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    Transaksi_CMD.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama,  pdSku,   MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where  MKT_T_Transaksi_H.tr_custID= '"& Transaksi("tr_custID") &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran "
                                    'response.write Transaksi_CMD.commandText
                                    set pdtr = Transaksi_CMD.execute 
                                %>
                                <% 
                                    do while not pdtr.eof 
                                %>
                                <div class="row align-items-center"> 
                                    <div class="col-1">
                                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                                    </div>
                                    <div class="col-9">
                                        <span class="text3-ps-seller"> <%=pdtr("pdNama")%> </span> <br>
                                        <span class="text4-ps-seller"> <%=pdtr("pdSku")%> </span> <br>
                                        <span class="text4-ps-seller"> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                                    </div>
                                    <div class="text-end col-2">
                                        <span class="text5-ps-seller"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    pdtr.movenext
                                    loop
                                %>
                                <div class="row"> 
                                    <div class="text-start col-9">
                                        <span class="text5-ps-seller"> Dibuat : <%=Day(CDate(Transaksi("trUpdateTime")))%>-<%=Month(Transaksi("trUpdateTime"))%>-<%=Year(CDate(Transaksi("trUpdateTime")))%>&nbsp;<%=Transaksi("Waktu")%></span> &nbsp;&nbsp;
                                        <button class="btn2-ps-seller"><i class="fas fa-info-circle"></i> &nbsp; <%=Transaksi("strName")%> </button> &nbsp;&nbsp; 
                                        <button class="btn1-ps-seller" onclick="detailpesanan('<%=Transaksi("trID")%>','<%=Transaksi("strID")%>')"><i class="fas fa-file-alt"></i> &nbsp; Detail Pesanan </button>
                                    </div>
                                    <div class="text-end col-3">
                                        <span class="text2-ps-seller"> Total Pesanan </span> &nbsp; 
                                        <span class="text5-ps-seller"style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                                    </div>
                                </div>
                            </div>
                        <% 
                            Transaksi.movenext
                            loop 
                        %>
                        <!-- Status Pesanan Menunggu Pembayaran -->
                    <% else if statuspesanan = "01" then %>
                        <% 
                            no = 0 
                            do while not Transaksi.eof 
                            no = no + 1
                        %>
                        <!-- Status Pesanan Perlu Dikemas -->
                            <div class="cont-pesanan mb-3">
                                <div class="row align-items-center"> 
                                    <div class="col-8">
                                        <span class="text1-ps-seller"> <i class="fas fa-user"></i> &nbsp; <%=Transaksi("custNama")%> </span> &nbsp;&nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-envelope"></i> &nbsp; Chat </button>
                                    </div>
                                    <div class="text-end col-4">
                                        <span class="text2-ps-seller">No Transaksi :  <%=Transaksi("trID")%></span> &nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-clipboard-list"></i> </button>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    Transaksi_CMD.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama,  pdSku,   MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where  MKT_T_Transaksi_H.tr_custID= '"& Transaksi("tr_custID") &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran "
                                    'response.write Transaksi_CMD.commandText
                                    set pdtr = Transaksi_CMD.execute 
                                %>
                                <% 
                                    do while not pdtr.eof 
                                %>
                                <div class="row align-items-center"> 
                                    <div class="col-1">
                                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                                    </div>
                                    <div class="col-9">
                                        <span class="text3-ps-seller"> <%=pdtr("pdNama")%> </span> <br>
                                        <span class="text4-ps-seller"> <%=pdtr("pdSku")%> </span> <br>
                                        <span class="text4-ps-seller"> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                                    </div>
                                    <div class="text-end col-2">
                                        <span class="text5-ps-seller"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    pdtr.movenext
                                    loop
                                %>
                                <div class="row"> 
                                    <div class="text-start col-9">
                                        <span class="text5-ps-seller"> Pesanan Dibuat : <%=Day(CDate(Transaksi("trUpdateTime")))%>-<%=Month(Transaksi("trUpdateTime"))%>-<%=Year(CDate(Transaksi("trUpdateTime")))%>&nbsp;<%=Transaksi("Waktu")%></span> &nbsp;&nbsp;
                                        
                                    </div>
                                    <div class="text-end col-3">
                                        <span class="text2-ps-seller"> Total Pesanan </span> &nbsp; 
                                        <span class="text5-ps-seller"style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                                    </div>
                                </div>
                                <div class="row mt-2"> 
                                    <div class = "text-start col-10">
                                        <button class="btn2-ps-seller"> <i class="fas fa-truck"></i> &nbsp; <%=Transaksi("trPengiriman")%> </button> &nbsp;&nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-print"></i> &nbsp; Invoice </button> &nbsp;&nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-file-alt"></i> &nbsp; Detail Pesanan </button>
                                    </div>
                                    <div class = "text-end col-2">
                                        <% if Transaksi("tr_IDBooking") = "" then %>
                                            <button class="btn1-ps-seller" onclick="GetBooking('<%=Transaksi("trID")%>','<%=Transaksi("tr_custID")%>','<%=Transaksi("tr_slID")%>')"style="display:none">  Kemas Pesanan </button> 
                                            <button class="btn1-ps-seller" id="myBtn<%=no%>"> <i class="fas fa-box"></i> &nbsp; Kemas Pesanan </button> 
                                        <% else %>
                                            <button class="btn2-ps-seller" id="myBtn<%=no%>"><i class="fas fa-box-up"></i> &nbsp;  Menunggu Pickup </button> 
                                        <% end if %>
                                    </div>
                                </div>
                                <!-- Modal Kemas Pesanan -->
                                <div id="myModal<%=no%>" class="modal">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <div class="row mt-3 text-center">
                                                <div class="col-12">
                                                    <span style="color:#0077a2"> Konfirmasi Pesanan : <%=Transaksi("trID")%> </span><br>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row ">
                                                <div class="col-8">
                                                    <span style="color:#0077a2" id="text-jmlunit<%=Transaksi("trID")%>"> Packing Pesanan Dijadikan 1 </span>
                                                </div>
                                                <div class="col-4">
                                                    <div class="row ">
                                                        <div class="col-12">
                                                            <input type="checkbox" id="JumlahUnit<%=Transaksi("trID")%>" name="JumlahUnit<%=Transaksi("trID")%>" value="Y">
                                                            <label for="JumlahUnit<%=Transaksi("trID")%>"> Ya </label>
                                                        </div>
                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-12">
                                                            <input type="checkbox" id="JumlahUnit<%=Transaksi("trID")%>" name="JumlahUnit<%=Transaksi("trID")%>" value="N">
                                                            <label for="JumlahUnit<%=Transaksi("trID")%>"> Tidak </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mt-3 text-center mb-2">
                                                <div class="col-12">
                                                    <button class="cont-chat"onclick="GetBooking('<%=Transaksi("trID")%>','<%=Transaksi("tr_custID")%>','<%=Transaksi("tr_slID")%>')"> Proses Pesanan </button> &nbsp;&nbsp;
                                                    <button class="cont-chat"id="batal<%=no%>"> Batal </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal Kemas Pesanan -->
                                <script>
                                    var modal<%=no%>       = document.getElementById("myModal<%=no%>");
                                    var btn<%=no%>         = document.getElementById("myBtn<%=no%>");
                                    var span<%=no%>         = document.getElementById("batal<%=no%>");

                                    btn<%=no%>.onclick = function() {
                                        modal<%=no%>.style.display = "block";
                                    }
                                    span<%=no%> .onclick = function() {
                                        modal<%=no%> .style.display = "none";
                                    }
                                    window.onclick = function(event) {
                                        if (event.target == modal<%=no%>) {
                                            modal<%=no%>.style.display = "none";
                                        }
                                    }
                                </script>
                            </div>
                        <!-- Status Pesanan Perlu Dikemas -->
                        <% 
                            Transaksi.movenext
                            loop 
                        %>
                    <% else if statuspesanan = "02" then %>
                        <% 
                            no = 0 
                            do while not Transaksi.eof 
                            no = no + 1
                        %>
                        <div class="cont-pesanan mb-3">
                            <div class="row align-items-center"> 
                                <div class="col-5">
                                    <span class="text1-ps-seller"> <i class="fas fa-user"></i> &nbsp; <%=Transaksi("custNama")%> </span> &nbsp;&nbsp; 
                                    <button class="btn1-ps-seller"> <i class="fas fa-envelope"></i> &nbsp; Chat </button>
                                </div>
                                <div class="text-end col-7">
                                    <span class="text2-ps-seller"> <i class="fas fa-info-circle"></i> </span>  
                                    <span class="text2-ps-seller" id="statuss<%=no%>"></span> &nbsp;&nbsp; | &nbsp;&nbsp;
                                    <span class="text5-ps-seller">No Transaksi :  <%=Transaksi("trID")%></span> &nbsp; <button class="cont-chat"> <i class="fas fa-clipboard-list"></i> </button>
                                </div>
                            </div>
                            <hr style="color:#0077a2">
                            <%
                                Transaksi_CMD.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama,  pdSku,   MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where  MKT_T_Transaksi_H.tr_custID= '"& Transaksi("tr_custID") &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran "
                                'response.write Transaksi_CMD.commandText
                                set pdtr = Transaksi_CMD.execute 
                            %>
                            <% 
                                do while not pdtr.eof 
                            %>
                            <div class="row align-items-center"> 
                                <div class="col-1">
                                    <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                                </div>
                                <div class="col-9">
                                    <span class="text3-ps-seller"> <%=pdtr("pdNama")%> </span> <br>
                                    <span class="text4-ps-seller"> <%=pdtr("pdSku")%> </span> <br>
                                    <span class="text4-ps-seller"> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                                </div>
                                <div class="text-end col-2">
                                    <span class="text5-ps-seller"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                                </div>
                            </div>
                            <hr style="color:#0077a2">
                            <%
                                pdtr.movenext
                                loop
                            %>
                            <div class="row"> 
                                <div class="text-start col-9">
                                    <span class="text5-ps-seller"> Dibuat : <%=Day(CDate(Transaksi("trUpdateTime")))%>-<%=Month(Transaksi("trUpdateTime"))%>-<%=Year(CDate(Transaksi("trUpdateTime")))%>&nbsp;<%=Transaksi("Waktu")%></span> &nbsp;&nbsp;
                                    <button class="btn2-ps-seller"><i class="fas fa-info-circle"></i> &nbsp; <%=Transaksi("strName")%> </button> &nbsp;&nbsp; 
                                    <button class="btn1-ps-seller" onclick="detailpesanan('<%=Transaksi("trID")%>','<%=Transaksi("strID")%>')"><i class="fas fa-file-alt"></i> &nbsp; Detail Pesanan </button>
                                </div>
                                <div class="text-end col-3">
                                    <span class="text2-ps-seller"> Total Pesanan </span> &nbsp; 
                                    <span class="text5-ps-seller"style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                                </div>
                            </div>
                        </div>
                        <script>
                            $.get( "random.asp?BookingID=<%=Transaksi("tr_IDBooking")%>&status=&tr=<%=Transaksi("trID")%>", function( data ) {
                                var jsonData = JSON.parse(data);
                                var a        = jsonData.detail
                                var last = Object.keys(a).pop();
                                if ( a[last].keterangan == "PICKUP BERHASIL"){
                                    var status = a[last].keterangan;
                                    $.get( `random.asp?status=${status}&tr=<%=Transaksi("trID")%>`, function( data ) {
                                        var jsonDatas = JSON.parse(data);   
                                        $("#statuss<%=no%>").text(jsonDatas.Keterangan);
                                    });
                                }else{
                                    $('#statuss<%=no%>').text(a[last].keterangan);
                                }
                            });
                        </script>
                        <% Transaksi.movenext
                        loop %>
                    <% else if statuspesanan = "03" then %>
                        <% 
                            do while not Transaksi.eof
                        %>

                            <div class="cont-pesanan mb-3">
                                <div class="row align-items-center"> 
                                    <div class="col-8">
                                        <span class="text1-ps-seller"> <i class="fas fa-user"></i> &nbsp; <%=Transaksi("custNama")%> </span> &nbsp;&nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-envelope"></i> &nbsp; Chat </button>
                                    </div>
                                    <div class="text-end col-4">
                                        <span class="text2-ps-seller">No Transaksi :  <%=Transaksi("trID")%></span> &nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-clipboard-list"></i> </button>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    Transaksi_CMD.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama,  pdSku,   MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where  MKT_T_Transaksi_H.tr_custID= '"& Transaksi("tr_custID") &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran "
                                    'response.write Transaksi_CMD.commandText
                                    set pdtr = Transaksi_CMD.execute 
                                %>
                                <% 
                                    do while not pdtr.eof 
                                %>
                                <div class="row align-items-center"> 
                                    <div class="col-1">
                                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                                    </div>
                                    <div class="col-9">
                                        <span class="text3-ps-seller"> <%=pdtr("pdNama")%> </span> <br>
                                        <span class="text4-ps-seller"> <%=pdtr("pdSku")%> </span> <br>
                                        <span class="text4-ps-seller"> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                                    </div>
                                    <div class="text-end col-2">
                                        <span class="text5-ps-seller"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    pdtr.movenext
                                    loop
                                %>
                                <div class="row"> 
                                    <div class="text-start col-9">
                                        <span class="text5-ps-seller"> Dibuat : <%=Day(CDate(Transaksi("trUpdateTime")))%>-<%=Month(Transaksi("trUpdateTime"))%>-<%=Year(CDate(Transaksi("trUpdateTime")))%>&nbsp;<%=Transaksi("Waktu")%></span> &nbsp;&nbsp;
                                        <button class="btn2-ps-seller"><i class="fas fa-info-circle"></i> &nbsp; <%=Transaksi("strName")%> </button> &nbsp;&nbsp; 
                                        <button class="btn1-ps-seller" onclick="detailpesanan('<%=Transaksi("trID")%>','<%=Transaksi("strID")%>')"><i class="fas fa-file-alt"></i> &nbsp; Detail Pesanan </button>
                                    </div>
                                    <div class="text-end col-3">
                                        <span class="text2-ps-seller"> Total Pesanan </span> &nbsp; 
                                        <span class="text5-ps-seller"style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                                    </div>
                                </div>
                            </div>
                        <%
                            Transaksi.movenext
                            loop
                        %>
                    <% else if statuspesanan = "04" then %>
                        <% 
                            do while not Transaksi.eof
                        %>

                            <div class="cont-pesanan mb-3">
                                <div class="row align-items-center"> 
                                    <div class="col-8">
                                        <span class="text1-ps-seller"> <i class="fas fa-user"></i> &nbsp; <%=Transaksi("custNama")%> </span> &nbsp;&nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-envelope"></i> &nbsp; Chat </button>
                                    </div>
                                    <div class="text-end col-4">
                                        <span class="text2-ps-seller">No Transaksi :  <%=Transaksi("trID")%></span> &nbsp; 
                                        <button class="btn1-ps-seller"> <i class="fas fa-clipboard-list"></i> </button>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    Transaksi_CMD.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama,  pdSku,   MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where  MKT_T_Transaksi_H.tr_custID= '"& Transaksi("tr_custID") &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran "
                                    'response.write Transaksi_CMD.commandText
                                    set pdtr = Transaksi_CMD.execute 
                                %>
                                <% 
                                    do while not pdtr.eof 
                                %>
                                <div class="row align-items-center"> 
                                    <div class="col-1">
                                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                                    </div>
                                    <div class="col-9">
                                        <span class="text3-ps-seller"> <%=pdtr("pdNama")%> </span> <br>
                                        <span class="text4-ps-seller"> <%=pdtr("pdSku")%> </span> <br>
                                        <span class="text4-ps-seller"> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                                    </div>
                                    <div class="text-end col-2">
                                        <span class="text5-ps-seller"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    pdtr.movenext
                                    loop
                                %>
                                <div class="row"> 
                                    <div class="text-start col-9">
                                        <span class="text5-ps-seller"> Dibuat : <%=Day(CDate(Transaksi("trUpdateTime")))%>-<%=Month(Transaksi("trUpdateTime"))%>-<%=Year(CDate(Transaksi("trUpdateTime")))%>&nbsp;<%=Transaksi("Waktu")%></span> &nbsp;&nbsp;
                                        <button class="btn2-ps-seller"><i class="fas fa-info-circle"></i> &nbsp; <%=Transaksi("strName")%> </button> &nbsp;&nbsp; 
                                        <button class="btn1-ps-seller" onclick="detailpesanan('<%=Transaksi("trID")%>','<%=Transaksi("strID")%>')"><i class="fas fa-file-alt"></i> &nbsp; Detail Pesanan </button>
                                    </div>
                                    <div class="text-end col-3">
                                        <span class="text2-ps-seller"> Total Pesanan </span> &nbsp; 
                                        <span class="text5-ps-seller"style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                                    </div>
                                </div>
                            </div>
                        <%
                            Transaksi.movenext
                            loop
                        %>
                    <% end if %><% end if %><% end if %><% end if %><% end if %>
                <% end if %>
                </div>
            </div>
        </div>
    </div>
</div>