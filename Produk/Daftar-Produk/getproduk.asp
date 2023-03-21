<!--#include file="../../Connections/pigoConn.asp" -->
<%

    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    id= request.queryString("x")

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String
			
	produk_cmd.commandText = "select top 3 * from MKT_M_Produk where pdID > '"& id &"'  Order BY pdID, pdUpdateTime ASC" 
	set produk = produk_cmd.execute

    set kategori_cmd = server.createObject("ADODB.COMMAND")
	kategori_cmd.activeConnection = MM_PIGO_String
			
	kategori_cmd.commandText = "SELECT * FROM MKT_M_Kategori Where catAktifYN = 'Y'  " 
	set kategori = kategori_cmd.execute

    set Total_cmd = server.createObject("ADODB.COMMAND")
	Total_cmd.activeConnection = MM_PIGO_String
			
	Total_cmd.commandText = "SELECT COUNT(pdID) as total From MKT_M_Produk where pd_custID = '"& request.Cookies("custID") &"'  " 
	set Total = Total_cmd.execute

    set StokAkhir_cmd = server.createObject("ADODB.COMMAND")
	StokAkhir_cmd.activeConnection = MM_PIGO_String
			
    set pd_cmd = server.createObject("ADODB.COMMAND")
	pd_cmd.activeConnection = MM_PIGO_String
    

%>
<% if produk.eof = true then %>
    <div class="col-lg-12 col-md-12 col-sm-12 col-12 mt-2 text-center ">
        <span style="color:#0077a2; font-size:13px; font-weight:550"> Tidak Ada Produk Lainnya </span>
    </div>
    <script>
        $('.btn-produk-rekom').hide();
    </script>
<% else %>
    <%
        do while not produk.eof
    %>
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
                                pd_cmd.commandText = "SELECT ISNULL(SUM(MKT_T_Transaksi_D1A.tr_pdQty),0) AS total FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  produk("pdID") &"') AND (MKT_M_Produk.pd_custID = '"&  produk("pd_custID") &"')"
                                'response.write pd_cmd.commandText
                                set pd = pd_cmd.execute
                            %>
                            <span> <%=pd("total")%>  </span><br>
                            <%
                                StokAkhir_cmd.commandText = "SELECT ISNULL(SUM(MKT_T_Transaksi_D1A.tr_pdQty),0) AS Penjualan, MKT_M_Produk.pdID, MKT_M_Produk.pdStok, ISNULL(SUM(MKT_M_Produk.pdStok - MKT_T_Transaksi_D1A.tr_pdQty),0) AS total FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D2 ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D2.trD2 FULL OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_D1A.trD1A WHERE (MKT_T_Transaksi_D1A.tr_pdID = '"&  produk("pdID") &"') AND (MKT_M_Produk.pd_custID = '"&  produk("pd_custID") &"') GROUP BY  MKT_M_Produk.pdID, MKT_M_Produk.pdStok"
                                'response.write StokAkhir_cmd.commandText
                                set StokAkhir = StokAkhir_cmd.execute
                            %>

                            <%if StokAkhir.eof = true then %>
                                <span> <%=produk("pdStok")%> </span>
                            <%else%>
                                <span> <%=StokAkhir("total")%> </span>
                            <%end if%>
                        </div>
                    </div>
                </div>
            </div>
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
    function getproduk(){
        var produkid = `<%=LpdID%>`;
        console.log(produkid);
        // console.log(produkid);
        $.get(`getproduk.asp?x=${produkid}`,function(data){
            // console.log(data);
            console.log(data);
            $('#<%=LpdID%>').html(data);
        })
    }
</script>
