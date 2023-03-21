<!--#include file="../../../connections/pigoConn.asp"-->
<%
    if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if
			
	set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_T_Transaksi_H.tr_custID, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_H.trID, 12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID  where MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND MKT_T_Transaksi_D1.tr_strID = '03' GROUP BY MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_T_Transaksi_H.tr_custID, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName"
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute 
    
    set pdtr_cmd =  server.createObject("ADODB.COMMAND")
    pdtr_cmd.activeConnection = MM_PIGO_String

%>
<span class="txt-Judul" > Pesanan  Selesai </span>
    <table class="table table-bordered table-condensed" style="font-size:11px">
        <thead class="align-items-center">
            <tr>
            <th class=" text-center">Produk</th>
            <th class=" text-center" >Qty </th>
            <th class=" text-center" >Sub Total</th>
            <th class=" text-center" scope="col">Status</th>
            <th class=" text-center" scope="col">Jasa Kirim</th>
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
            <th colspan="12"> Customer : <%=Transaksi("custNama")%></th>
        </tr>
        <%
            pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty,  MKT_T_StatusTransaksi.strName, MKT_M_Produk.pdID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID AND LEFT(MKT_T_Transaksi_D1A.trD1A, 12)  = LEFT(MKT_T_Transaksi_D1.trD1, 12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID  where MKT_T_Transaksi_H.tr_custID = '"& Transaksi("tr_custID") &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' GROUP BY MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty,  MKT_T_StatusTransaksi.strName, MKT_M_Produk.pdID, MKT_M_Produk.pd_custID,MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trJenisPembayaran "
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
            <td class=" text-center" >
                <input class=" text-center" type="text" name="" id="" value="<%=pdtr("tr_pdQty")%>" style="align-items:center; width:2rem">
            </td>
            <%  total = pdtr("tr_pdQty") * pdtr("tr_pdHarga") %>
            <td class=" text-center" >
                <input class=" text-center" type="text" name="" id="" value="<%=Replace(FormatCurrency(total),"$"," Rp. ")%>" style="align-items:center; width:9rem;">
            </td>
            <td class=" text-center" ><span class="stpesanan03"><%=pdtr("strName")%></span></td>

            <td class=" text-center" ><%=pdtr("trPengiriman")%></td>
        </tr>
        <%pdtr.movenext
        loop%>
        <%Transaksi.movenext
        loop%>
        <% END IF %>
        </tbody>
    </table>