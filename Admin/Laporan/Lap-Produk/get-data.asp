<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")


    id = Split(request.queryString("customerid"),",")

    for each x in id
            if len(x) > 0 then

                    filtercust = filtercust & addOR & " MKT_T_Transaksi_H.tr_custID = '"& x &"' "

                addOR = " or " 

            end if
        next

        if filtercust <> "" then
            FilterFix = "and  ( " & filtercust & " )" 
        end if
        
    set Ps_cmd = server.createObject("ADODB.COMMAND")
	Ps_cmd.activeConnection = MM_PIGO_String
			
	Ps_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_H.tr_strID, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_H.tr_custID, buyer.custNama, buyer.custEmail, buyer.custPhone1, buyer.custPhone2, MKT_T_Transaksi_H.tr_almID, almbuyer.almNamaPenerima, almbuyer.almPhonePenerima, almbuyer.almLengkap, almbuyer.almLabel, almbuyer.almProvinsi, almbuyer.almLatt, almbuyer.almLong, almbuyer.almKota, almbuyer.almKel, almbuyer.almKec, almbuyer.almKdpos, MKT_T_Transaksi_H.tr_strID, MKT_T_Transaksi_H.trTglTransaksi AS tanggaltr, MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_T_Transaksi_D1A.tr_pdID, MKT_M_Produk.pdNama, MKT_M_Produk.pdLayanan, MKT_M_Produk.pdHargaBeli,MKT_M_Produk.pdHargaJual, MKT_M_Produk.pdBerat, MKT_M_Produk.pdPanjang, MKT_M_Produk.pdLebar, MKT_M_Produk.pdTinggi, MKT_M_Produk.pdVolume, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty AS trQty, MKT_M_Produk.pd_almID, almseller.almNamaPenerima AS NamaPengirim, almseller.almKota AS sellerkota, almseller.almKec AS sellerkec, almseller.almKec AS sellerkel, almseller.almProvinsi AS sellerprov, almseller.almKdpos AS sellerkdpos, almseller.almLengkap AS selleralm, almseller.almLatt AS sellerlatt, almseller.almLong AS sellerlong, almseller.almPhonePenerima AS sellerphone, MKT_M_Customer.custID, MKT_M_Customer.custNama AS namaseller, MKT_M_Customer.custEmail AS emailseller, MKT_M_Customer.custPhone1 AS phoneseller, MKT_T_Transaksi_D2.trD2, MKT_T_Transaksi_D2.trSubTotal, MKT_T_Transaksi_D2.trJenisPembayaran, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName FROM MKT_M_Alamat AS almbuyer RIGHT OUTER JOIN MKT_T_Transaksi_D2 RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_H.tr_strID ON LEFT(MKT_T_Transaksi_D2.trD2, 12) = MKT_T_Transaksi_H.trID ON almbuyer.almID = MKT_T_Transaksi_H.tr_almID LEFT OUTER JOIN MKT_M_Customer AS buyer ON MKT_T_Transaksi_H.tr_custID = buyer.custID LEFT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Customer.custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A LEFT OUTER JOIN MKT_M_Alamat AS almseller RIGHT OUTER JOIN MKT_M_Produk ON almseller.almID = MKT_M_Produk.pd_almID ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID ON MKT_T_Transaksi_D1.trD1 = LEFT(MKT_T_Transaksi_D1A.trD1A, 16) ON  MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) where  MKT_T_Transaksi_D1.tr_slID  = '"& request.Cookies("custID") &"' "& FilterFix & "and trTglTransaksi between '"  & tgla & "' and '"  & tgle & "' order by trTgltransaksi"

    'response.write Ps_cmd.commandText

	set Ps = Ps_cmd.execute
%>

<%
    do while not Ps.eof
%>
                            
<input type="hidden" name="custID" id="custID<%=no%>" value="<%=ps("tr_custID")%>" >
<tr>
    <td><%=Ps("trID")%></td>
    <td><%=Ps("trTgltransaksi")%></td>
    <td><%=Ps("custNama")%></td>
    <td><%=Ps("custEmail")%></td>
    <td><%=Ps("pdNama")%></td>
    <td><%=Replace(FormatCurrency(Ps("pdHargaBeli")),"$","Rp.  ")%></td>
    <td><%=Replace(FormatCurrency(Ps("pdHargaJual")),"$","Rp.  ")%></td>
    <td><%=Ps("tr_pdQty")%></td>
    <td><%=Replace(FormatCurrency(Ps("trSubTotal")),"$","Rp.  ")%></td>
    <td><%=Ps("strName")%></td>
</tr>
<%
    Ps.movenext
    loop
%>
