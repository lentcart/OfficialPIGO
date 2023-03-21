<!--#include file="../../../connections/pigoConn.asp"-->
<%
    Wall_Jenis          = Request.QueryString("JenisWallet")
    TanggalAwal         = Request.QueryString("TanggalAwal")
    TanggalAkhir        = Request.QueryString("TanggalAkhir")

    if TanggalAwal="" or TanggalAkhir = "" then
        FillterTanggal = ""
    else
        FillterTanggal = "AND  Wall_DateAcc between '"& TanggalAwal &"' and '"& TanggalAkhir &"' "
    end if

    set Wallet_CMD =  server.createObject("ADODB.COMMAND")
    Wallet_CMD.activeConnection = MM_PIGO_String
    Wallet_CMD.commandText = "SELECT MKT_T_SaldoSeller.Wall_ID, MKT_T_SaldoSeller.Wall_DateAcc, MKT_T_SaldoSeller.Wall_CustID, MKT_T_SaldoSeller.Wall_TrID, MKT_T_SaldoSeller.Wall_Amount, MKT_T_SaldoSeller.Wall_Status,  MKT_T_SaldoSeller.Wall_KonfYN, MKT_T_SaldoSeller.Wall_WithDYN, MKT_T_SaldoSeller.Wall_UpdateTime, MKT_M_Customer.custNama, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_SaldoSeller.Wall_Jenis,  MKT_T_SaldoSeller.Wall_BankID, MKT_T_SaldoSeller.Wall_Rek FROM MKT_T_SaldoSeller LEFT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_SaldoSeller.Wall_TrID = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_M_Customer ON MKT_T_SaldoSeller.Wall_CustID = MKT_M_Customer.custID WHERE Wall_SellerID = '"& request.Cookies("custID") &"' AND Wall_Jenis = '"& Wall_Jenis &"'   "& FillterTanggal &" GROUP BY MKT_T_SaldoSeller.Wall_ID, MKT_T_SaldoSeller.Wall_DateAcc, MKT_T_SaldoSeller.Wall_CustID, MKT_T_SaldoSeller.Wall_TrID, MKT_T_SaldoSeller.Wall_Amount, MKT_T_SaldoSeller.Wall_Status, MKT_T_SaldoSeller.Wall_KonfYN, MKT_T_SaldoSeller.Wall_WithDYN, MKT_T_SaldoSeller.Wall_UpdateTime, MKT_M_Customer.custNama, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_SaldoSeller.Wall_Jenis, MKT_T_SaldoSeller.Wall_BankID, MKT_T_SaldoSeller.Wall_Rek" 
    'response.write Wallet_CMD.commandText
    set Wallet = Wallet_CMD.execute 
    
%>
    <% if Wallet.eof = true then %>

    <div class="row text-center">
        <div class="col-12">
            <div class="cont-none" style="padding:20px">
                <span style="font-size:30px; color:#aaa"> <i class="fas fa-file-alt"></i> </span><br>
                <span class="text-judul-wallet" style="color:#aaa">  Belum Ada Riwayat Transaksi </span>
            </div>
        </div>
    </div>

    <% else %>
    <div class="row">
        <div class="col-12">
            <table class=" align-items-center cont-table table tb-transaksi table-bordered table-condensed"> 
                <thead class="text-center">
                    <tr>
                        <th> NO </th>
                        <th> TANGGAL </th>
                        <th> DESKRIPSI </th>
                        <th> JUMLAH </th>
                        <th> STATUS </th>
                    </tr>
                </thead>
                <tbody >
                    <%
                        no = 0
                        do while not Wallet.eof
                        no = no + 1
                    %>
                    <tr>
                        <td class="text-center"> <%=no%> </td>
                        <td class="text-center"> <%=CDate(Wallet("Wall_DateAcc"))%> </td>

                        <% if Wallet("Wall_Jenis") = "01" then %>

                            <%
                                Wallet_CMD.commandText = "SELECT MKT_M_Produk.pdID, MKT_M_Produk.pdNama FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A LEFT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1,12) ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID WHERE tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Wallet("Wall_TrID") &"' AND tr_custID = '"& Wallet("Wall_CustID") &"'"
                                'response.write Wallet_CMD.commandText
                                set WalletPR = Wallet_CMD.execute 
                            %>

                            <td> 
                                <span class="text1-wal-seller"> Penghasilan Dari Transaksi #<%=Wallet("Wall_TrID")%> (<%=CDate(Wallet("trTglTransaksi"))%>) </span><br>

                                <span class="text2-wal-seller"> <%=Wallet("custNama")%> &nbsp; : &nbsp; 
                                <% do while not WalletPR.eof %>
                                <span class="text2-wal-seller"> <%=WalletPR("pdNama")%> </span> &nbsp; | &nbsp; <br>
                                <% WalletPR.movenext
                                loop %>
                                </span>
                            </td>

                        <% else if Wallet("Wall_Jenis") = "02" then %>

                            <td> 
                                <span class="text1-wal-seller"> Penarikan Saldo #</span><br>
                                <span class="text2-wal-seller"> Rekening : <%=Wallet("Wall_Rek")%> </span>
                            </td>

                        <% end if %> <% end if %>

                        <% if Wallet("Wall_Status") = "C" then %>
                            <td class="text-end txt-complete"> <%=Replace(Replace(FormatCurrency(Wallet("Wall_Amount")),"$","Rp.  "),".00","")%> </td>
                            <td class="text-center"> <span class="cont-complete"> Complete </span> </td>
                        <% else %>
                            <td class="text-end txt-waiting"> <%=Replace(Replace(FormatCurrency(Wallet("Wall_Amount")),"$","Rp.  "),".00","")%> </td>
                            <td class="text-center"> <span class="cont-waiting"> Waiting </span> </td>
                        <% end if %>
                        </td>
                    </tr>
                    <%
                        Wallet.movenext
                        loop
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <% end if %>