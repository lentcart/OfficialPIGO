<!--#include file="../../Connections/pigoConn.asp" -->

<%
    kondisi = request.queryString("kondisi")


    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String
			
	produk_cmd.commandText = "SELECT * FROM [PIGO].[dbo].[MKT_M_Produk] where pdBaruYN = '"& kondisi &"' and pd_custID = '"& request.Cookies("custID") &"' " 
	set produk = produk_cmd.execute

    set StokAkhir_cmd = server.createObject("ADODB.COMMAND")
	StokAkhir_cmd.activeConnection = MM_PIGO_String
			
    set pd_cmd = server.createObject("ADODB.COMMAND")
	pd_cmd.activeConnection = MM_PIGO_String
%>
<div class="row">
    <% if produk.eof = true then %>
        <span class="txt-judul-produk"> Tidak Ada Produk </span>
    <% else %>
    <%do while not produk.eof%>
    <div class="col-2">
        <div class="card mt-3 mb-2 me-2">
            <img src="data:image/png;base64,<%=produk("pdImage1")%>" class="card-img-top rounded" alt="...">
            <div class="card-body">
                <input readonly class="tx-card" type="text" name="pdNama" id="pdNama" value="<%=produk("pdNama")%>"><br>
                    <div class="row mt-1" style="color:black; font-weight:bold; font-size:9px">
                        <div class="col-9">
                            <input class="hg-card" type="text" name="pdHarga" id="pdHarga" value="<%=Replace(FormatCurrency(produk("pdHargaJual")),"$","Rp.  ")%>"><br>
                        </div>
                        <div class="col-3">
                            <div class="dropdown">
                                <button class="btn-dp" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style=" font-size:10px;border:none; color:white; background-color:#0dcaf0"><i class="fas fa-list-ul"></i></button>
                                <ul class="dropdown-menu text-center" aria-labelledby="dropdownMenuButton1">
                                    <li>
                                        <a class="dropdown-item" href="#"><input class="btn-cetak-po" type="button" value="Tambah Stok"  onClick="window.open('../Tambah-Stok/?produkid=<%=produk("pdID")%>','_self')"></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#"><input class="btn-cetak-po" type="button" value="Edit"  onClick="window.open('../Update-Produk/?pdid=<%=produk("pdID")%>','_self')"></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" ><input class="btn-cetak-po" type="button" value="Hapus"  onClick="window.open('../Update-Produk/P-deleteproduk.asp?pdid=<%=produk("pdID")%>','_self')"></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-2 " style="color:black; font-weight:bold; font-size:9px">
                        <div class="col-9">
                            <span> Stok </span><br>
                            <span> Penjualan  </span><br>
                            <span> Stok Akhir </span>
                        </div>
                        <div class="col-3 text-center">
                            <span> <%=produk("pdStok")%> </span><br>
                            <%
                                pd_cmd.commandText = "SELECT COUNT(MKT_T_Transaksi_D1A.tr_pdQty) AS total FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  produk("pdID") &"') AND (MKT_M_Produk.pd_custID = '"&  produk("pd_custID") &"') GROUP BY  MKT_T_Transaksi_D1A.tr_pdID, MKT_M_Produk.pd_custID "
                                'response.write pd_cmd.commandText
                                set pd = pd_cmd.execute
                            %>
                            <%if pd.eof = true then %>
                                <span>  0  </span><br>
                            <%else%>
                            <%do while not pd.eof%>
                                <span> <%=pd("total")%>  </span><br>
                            <%pd.movenext
                            loop%>
                            <%
                                StokAkhir_cmd.commandText = "SELECT MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdID, MKT_M_Produk.pdStok, SUM(MKT_M_Produk.pdStok - MKT_T_Transaksi_D1A.tr_pdQty) AS total FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D2 ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D2.trD2 FULL OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_D1A.trD1A WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  produk("pdID") &"') AND (MKT_M_Produk.pd_custID = '"&  produk("pd_custID") &"') GROUP BY MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdID, MKT_M_Produk.pdStok"
                                'response.write StokAkhir_cmd.commandText
                                set StokAkhir = StokAkhir_cmd.execute
                            %>
                            <%end if%>
                            <%if StokAkhir.eof = true then %>
                            <span> <%=produk("pdStok")%> </span>
                            <%else%>
                            <%do while not StokAkhir.eof%>
                            <span> <%=StokAkhir("total")%> </span>
                            <%StokAkhir.movenext
                            loop%>
                            <%end if%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <%produk.movenext
        loop%>
        <% end if%>
        </div>
                    