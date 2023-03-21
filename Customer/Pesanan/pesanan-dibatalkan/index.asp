<!--#include file="../../../connections/pigoConn.asp"-->
<%
    if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if
    
	
    set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_H.trID, 12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID where MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND MKT_T_Transaksi_D1.tr_strID = '02'  GROUP BY MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_Transaksi_H.trID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID, MKT_M_Customer.custID "
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute 

    
    set pdtr_cmd =  server.createObject("ADODB.COMMAND")
    pdtr_cmd.activeConnection = MM_PIGO_String
%>
<span><b> Pesanan Di Batalkan </b></span>
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
        <% do while not Transaksi.eof %>
            <tr>
                <th colspan="12"> Seller : <%=Transaksi("slName")%></th>
            </tr>
            <%
                pdtr_cmd.commandText = "SELECT MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D2.trSubTotal,  MKT_T_Transaksi_D2.trJenisPembayaran, MKT_T_StatusTransaksi.strName, MKT_M_Produk.pdID,  MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID FROM MKT_T_Transaksi_D2 RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_H.tr_strID = MKT_T_StatusTransaksi.strID ON MKT_T_Transaksi_D2.trD2 = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID AND LEFT(MKT_T_Transaksi_D1A.trD1A, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) ON  MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' and MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D2.trSubTotal,  MKT_T_Transaksi_D2.trJenisPembayaran, MKT_T_StatusTransaksi.strName, MKT_M_Produk.pdID, MKT_M_Produk.pdNama, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID "
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
                            <input type="text" name="" id="" value=" <%=pdtr("tr_pdHarga")%>">
                        </div>
                    </div>
                </td>
                <td class=" text-center" ><input type="text" name="" id="" value="<%=pdtr("tr_pdQty")%>" style="align-items:center; width:3rem"></td>
                <% subtotal = pdtr("tr_pdHarga") * pdtr("tr_pdQty")%>
                <td class=" text-center" ><input type="text" name="" id="" value="<%=subtotal%>"></td>
                <td class=" text-center" ><%=pdtr("strName")%></td>
                <!--<td class=" text-center" ><a href="pesanan-diproses/detail.asp?trID=<%'=pdtr("trID")%>" style="font-size:11px"> Detail Pesanan </a></td>-->
            <%pdtr.movenext
                    loop%> 
                <td class=" text-center" ><%=Transaksi("trPengiriman")%></td>
            </tr>
        <% Transaksi.movenext
        loop %>
        <% end if %>
            </tbody>
        </table>
