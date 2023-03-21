<!--#include file="../../../connections/pigoConn.asp"-->
<%
    if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if
	
    set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_H.trID, 12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID where MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND MKT_T_Transaksi_D1.tr_strID = '00'  GROUP BY MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID "
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute 
    
    set pdtr_cmd =  server.createObject("ADODB.COMMAND")
    pdtr_cmd.activeConnection = MM_PIGO_String
%>
<% do while not Transaksi.eof %>
                            <div class="cont-pesanan mb-3">
                                <div class="row align-items-center"> 
                                    <div class = "col-10">
                                        <span style="font-weight:bold;color:#c70505" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> &nbsp;&nbsp; <button class="cont-chat"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> &nbsp;&nbsp;
                                        <button class="cont-action"> Kunjungi Seller </button>
                                    </div>
                                    <div class = " text-end col-2">
                                        <span style="color:#0077a2"> <%=Transaksi("strName")%></span>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran "
                                    'response.write pdtr_cmd.commandText
                                    set pdtr = pdtr_CMD.execute 
                                %>
                                <% do while not pdtr.eof %>
                                <div class="row"> 
                                    <div class = "col-1">
                                        <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                                    </div>
                                    <div class = "col-9">
                                        <span> <%=pdtr("pdNama")%> </span> <br>
                                        <span class="cont-desc"> <%=pdtr("pdSku")%> </span> <br>
                                        <span> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                                    </div>
                                    <div class = " text-end col-2">
                                        <span style="color:#c70505"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                                    </div>
                                </div>
                                <hr style="color:#0077a2">
                                <%
                                    response.flush()
                                    pdtr.movenext
                                    loop
                                %>
                                <div class="row"> 
                                    <div class = " text-end col-10">
                                        <span style="color:#0077a2"> Total Pesanan </span>
                                    </div>
                                    <div class = " text-end col-2">
                                        <span style="color:#c70505"> Nama Produk </span>
                                    </div>
                                </div>
                                <div class="row"> 
                                    <div class = " col-12">
                                        <button class="cont-chat"> Hubungi Penjual </button> &nbsp; &nbsp;
                                        <button class="cont-action"> Batalkan Pesanan </button>
                                    </div>
                                </div>
                            </div>
                        <% Transaksi.movenext
                            loop %>