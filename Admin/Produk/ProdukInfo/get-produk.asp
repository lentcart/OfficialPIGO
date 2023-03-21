<!--#include file="../../../connections/pigoConn.asp"--> 

<% 
    if Session("Username")="" then 
        response.redirect("../../admin/")
    end if
    if session("H3B") = false then 
        Response.redirect "../../Admin/home.asp"
    end if
    
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

    produk = request.queryString("produk")
    kategori = request.queryString("kategori")
    merk = request.queryString("merk")

    if produk = "" then 
        if kategori = "" then 
            Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdHarga as HargaAwal, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal,  MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND (MKT_M_PIGO_Produk.pd_catID =  '"& kategori &"') and (MKT_M_PIGO_Produk.pd_mrID = '"& merk &"')   GROUP BY MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty,  MKT_M_Stok.st_pdHarga, MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo,MKT_M_PIGO_Produk.pdHarga "
            'response.write Produk_cmd.commandText
            set Produk = Produk_cmd.execute
            
        else
            Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdHarga as HargaAwal, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal,  MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND (MKT_M_PIGO_Produk.pd_catID =  '"& kategori &"') and (MKT_M_PIGO_Produk.pd_mrID = '"& merk &"')   GROUP BY MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty,  MKT_M_Stok.st_pdHarga, MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo,MKT_M_PIGO_Produk.pdHarga  "
            'response.write Produk_cmd.commandText
            set Produk = Produk_cmd.execute
        end if
    else
    
        Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdHarga as HargaAwal, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal,  MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND (MKT_M_PIGO_Produk.pdNama LIKE '%"& produk &"%' ) OR (MKT_M_PIGO_Produk.pdPartNumber LIKE '%"& produk &"%')  GROUP BY MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty,  MKT_M_Stok.st_pdHarga, MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo,MKT_M_PIGO_Produk.pdHarga "
        'response.write Produk_cmd.commandText
        set Produk = Produk_cmd.execute
    
    set Pembelian_cmd = server.createObject("ADODB.COMMAND")
	Pembelian_cmd.activeConnection = MM_PIGO_String

    set Penjualan_cmd = server.createObject("ADODB.COMMAND")
	Penjualan_cmd.activeConnection = MM_PIGO_String

    end if
%>
<div class="row d-flex flex-row-reverse">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <table class="align-items-center table tb-transaksi table-bordered" style="font-size:12px; border:1px solid black;width:100rem">
            <thead >
                <tr  class="text-center">
                    <th>NO</th>
                    <th>ID PRODUK</th>
                    <th>NAMA</th>
                    <th>SKU/PART NUMBER</th>
                    <th>HARGA BELI </th>
                    <th>UpTo</th>
                    <th>HARGA JUAL (/PPN)</th>
                    <th>HARGA JUAL (+PPN)</th>
                    <th>STOK</th>
                    <th>PEMBELIAN</th>
                    <th>PENJUALAN</th>
                    <th> SISA</th>
                    <th>RAK</th>
                </tr>
            </thead>
            <tbody>
            <% 
                no = 0
                do while not Produk.eof 
                no = no + 1
            %>
                <tr>
                    <td class="text-center"> <%=no%> </td>
                    <td class="text-center"> <button id="myBtn<%=Produk("pdID")%>" class="cont-btn"> <%=Produk("pdID")%> </td>
                    <td>
                    <%=Produk("pdNama")%>
                        <input type="hidden" name="pdID" id="pdID<%=Produk("pdID")%>" value="<%=Produk("pdID")%>">
                    </td>
                    <td><%=Produk("pdPartNumber")%></td>
                    <td class="text-center"><%=Replace(Replace(FormatCurrency(Produk("HargaAwal")),"$","Rp. "),".00","")%></td>
                    <td class="text-center"> <%=Produk("pdUpTo")%> % </td>
                    <%

                        Harga = produk("HargaAwal")
                        UpTo  = Harga+(Harga*produk("pdUpTo")/100)
                        Tax   = UpTo*produk("TaxRate")/100
                        SebelumPPN = round(UpTo)
                        SetelahPPN = round(UpTo+Tax)

                    %>
                    <td class="text-center"> <%=Replace(Replace(FormatCurrency(SebelumPPN),"$","Rp. "),".00","")%> </td>
                    <td class="text-center"> <%=Replace(Replace(FormatCurrency(SetelahPPN),"$","Rp. "),".00","")%> </td>
                    <td class="text-center"><%=Produk("StokAwal")%></td>
                    <%
                        Produk_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian, ISNULL(MKT_M_PIGO_Produk.pdHarga, 0) AS HargaPembelian FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND pdID = '"& Produk("pdID") &"' GROUP BY MKT_M_PIGO_Produk.pdHarga"
                        'response.write Produk_CMD.commandText &"<br>"
                        set SaldoMasuk = Produk_CMD.execute
                    %>
                    <td class="text-center"> <%=SaldoMasuk("Pembelian")%> </td>
                    <input type="hidden" name="pdStok" id="pdStok<%=Produk("pdID")%>" value="<%=SaldoMasuk("Pembelian")%>">
                    <input type="hidden" name="pdHargaJual" id="pdHargaJual<%=Produk("pdID")%>" value="<%=SaldoMasuk("HargaPembelian")%>">
                    <%
                        Produk_CMD.commandText = "SELECT ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, 0) AS HargaPenjualan, ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdQty, 0) AS Penjualan FROM MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_Permintaan_Barang_D.Perm_IDH FULL OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y')AND pdID = '"& Produk("pdID") &"' "
                        'response.write Produk_CMD.commandText &"<br>"
                        set SaldoKeluar = Produk_CMD.execute
                    %>
                    <td class="text-center"> <%=SaldoKeluar("Penjualan")%> </td>
                    <%
                        Sisa = Produk("StokAwal")+SaldoMasuk("Pembelian")-SaldoKeluar("Penjualan")
                    %>
                    <td class="text-center"> <%=Sisa%></td>

                    <td class="text-center"><%=Produk("pdLokasi")%></td>
                </tr>
                <!-- Modal -->
                    <!-- The Modal -->
                    <div id="myModal<%=Produk("pdID")%>" class="modal-PD">

                    <!-- Modal content -->
                        <div class="modal-content-PD">
                            <div class="modal-body-PD">
                                <div class="row mt-3 p-1">
                                    <div class="col-11">
                                        <span class="cont-judul"> Produk ID : <%=Produk("pdID")%> <input class=" txt-modal-desc  mb-2 text-center"type="text" name="ItemID" id="ItemID" Value="" style="border:none"> </span>
                                        </div>
                                        <div class="col-1">
                                            <span><i class="fas fa-times closee<%=Produk("pdID")%>" id="closee"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="body" style="padding:5px 20px">
                                    <div class="row  mb-2 text-center">
                                        <div class="col-12">
                                        </div>
                                    </div>
                                    <div class="row  mb-2 text-center">
                                        <div class="col-4" >
                                            <div class="cont-a" style="background-color:#eee; border-radius:10px; padding:10px 10px;">
                                                <span class="txt-modal-desc" style="font-size:25px"> <i class="fas fa-edit"></i> </span><br>
                                                <button onclick="window.open('update-produk.asp?pdID='+document.getElementById('pdID<%=Produk("pdID")%>').value,'_Self')" class="cont-btn"> Edit Produk </button>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="cont-a" style="background-color:#eee; border-radius:10px; padding:10px 10px;">
                                                <span class="txt-modal-desc" style="font-size:25px"> <i class="fas fa-trash"></i> </span><br>
                                            <button onclick="deleteproduk<%=Produk("pdID")%>()" class="cont-btn"> Hapus Produk </button>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="cont-a" style="background-color:#eee; border-radius:10px; padding:10px 10px;">
                                                <span class="txt-modal-desc" style="font-size:25px"> <i class="fas fa-upload"></i> </span><br>
                                                <button onclick="window.open('P-upproduk.asp?produkid='+document.getElementById('pdID<%=Produk("pdID")%>').value+'&stokproduk='+document.getElementById('pdStok<%=Produk("pdID")%>').value+'&harga='+document.getElementById('pdHargaJual<%=Produk("pdID")%>').value,'_Self')" class="cont-btn"> Up Produk </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <!-- Modal content -->
                    <script>
                        var modal<%=Produk("pdID")%> = document.getElementById("myModal<%=Produk("pdID")%>");
                        var btn<%=Produk("pdID")%> = document.getElementById("myBtn<%=Produk("pdID")%>");
                        var span<%=Produk("pdID")%> = document.getElementsByClassName("closee<%=Produk("pdID")%>")[0];
                        btn<%=Produk("pdID")%>.onclick = function() {
                        modal<%=Produk("pdID")%>.style.display = "block";
                        }
                        span<%=Produk("pdID")%>.onclick = function() {
                        modal<%=Produk("pdID")%>.style.display = "none";
                        }
                        window.onclick = function(event) {
                        if (event.target == modal<%=Produk("pdID")%>) {
                            modal<%=Produk("pdID")%>.style.display = "none";
                        }
                        }
                        function upproduk<%=Produk("pdID")%>(){
                            var pdID = document.getElementById("pdID<%=Produk("pdID")%>").value;

                            var pdStok = document.getElementById("pdStok<%=Produk("pdID")%>").value;
                            var pdHargaJual = document.getElementById("pdHargaJual<%=Produk("pdID")%>").value;
                            $.ajax({
                                type: "get",
                                url: "P-upproduk.asp",
                                data: { produkid : pdID, stokproduk : pdStok, harga : pdHargaJual },
                                success: function (data) {
                                    console.log(data);  
                                }

                            });
                        }
                        function deleteproduk<%=Produk("pdID")%>(){
                            var pdID = document.getElementById("pdID<%=Produk("pdID")%>").value;
                            Swal.fire({
                                title: 'Apakah Anda Yakin Akan Menghapus Produk Ini ?',
                                showDenyButton: true,
                                showCancelButton: true,
                                confirmButtonText: 'Iya',
                                denyButtonText: `Tidak`,
                                }).then((result) => {
                                if (result.isConfirmed) {
                                    $.ajax({
                                        type: "POST",
                                        url: "delete-produk.asp",
                                        data: { 
                                            pdID
                                        },
                                        success: function (data) {
                                            Swal.fire({
                                                icon: 'success',
                                                title: 'Data Berhasil Dinonaktifkan'
                                                }).then((result) => {
                                                    window.open(`index.asp`,`_Self`)
                                            })
                                        }

                                    });
                                } else if (result.isDenied) {
                                    window.open(`index.asp`,`_Self`)
                                }
                            })

                        }
                    </script>
                <!-- Modal -->
            <% 
                Produk.movenext
                loop
            %>
            </tbody>
        </table>
    </div>
</div>