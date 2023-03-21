<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_PIGO_Produk.pdStokAwal, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdQty, 0) AS Pembelian, ISNULL(MKT_T_Transaksi_D1A.tr_pdQty, 0) AS Penjualan, MKT_M_PIGO_Produk.pdLokasi,ISNULL(MKT_T_MaterialReceipt_D2.mm_pdHarga, 0) AS Harga FROM MKT_M_PIGO_Produk LEFT OUTER JOIN   MKT_T_Transaksi_H LEFT OUTER JOIN  MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) LEFT OUTER JOIN  MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.tr_slID, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) LEFT OUTER JOIN  MKT_T_Transaksi_D2 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D2.trD2, 12) ON MKT_M_PIGO_Produk.pdID = LEFT(MKT_T_Transaksi_D1A.tr_pdID, 12) FULL OUTER JOIN  MKT_T_MaterialReceipt_H LEFT OUTER JOIN  MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN  MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON MKT_M_PIGO_Produk.pdID = MKT_T_MaterialReceipt_D2.mm_pdID WHERE MKT_M_PIGO_Produk.pd_custID = '"& request.Cookies("custID") &"' GROUP BY MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_PIGO_Produk.pdStokAwal, MKT_M_PIGO_Produk.pdLokasi,MKT_T_MaterialReceipt_D2.mm_pdHarga "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set Pembelian_cmd = server.createObject("ADODB.COMMAND")
	Pembelian_cmd.activeConnection = MM_PIGO_String

    set Penjualan_cmd = server.createObject("ADODB.COMMAND")
	Penjualan_cmd.activeConnection = MM_PIGO_String

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Official PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/DataTables/datatables.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script>
        
    </script>
    </head>
<body>
<!-- side -->
    <!--#include file="../../side.asp"-->
<!-- side -->
    <div class="main-body" style="overflow-y:scroll">
        <div class="row">
            <div class="col-12">
                <div class="judul-PO">
                    <div class="row">
                        <div class="col-10">
                            <span class="txt-po-judul"> <span class="txt-po-judul"> Produk Official PIGO [ eco ] </span> </span>
                        </div>
                        <div class="col-2">
                            <button  name="tambah" id="tambah" class="btn-cetak-po" style="width:9rem" > <i class="fas fa-info-circle"></i> Official PIGO (eco) </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="purchase-order">
            <div class="row">
                <div class="col-12">
                    <div class="data-po">
                        <div class="row align-items-center">
                            

                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-12">
                <div class="Produk-Pigo">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
            <thead>
                <tr  class="text-center">
                    <th>Nama Produk</th>
                    <th>SKU/Part Number</th>
                    <th>Stok Awal</th>
                    <th>Pembelian</th>
                    <th>Penjualan</th>
                    <th>Ketersediaan Stok</th>
                    <th>Lokasi Rak</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
            <% do while not Produk.eof %>
            
                <tr>
                    <td><%=Produk("pdNama")%><input type="hidden" name="pdID" id="pdID<%=Produk("pdID")%>" value="<%=Produk("pdID")%>"><input type="hidden" name="pdStok" id="pdStok<%=Produk("pdID")%>" value="<%=Produk("pembelian")%>"><input type="hidden" name="pdHargaJual" id="pdHargaJual<%=Produk("pdID")%>" value="<%=Produk("harga")%>"></td>
                    <td><%=Produk("pdPartNumber")%></td>
                    <td class="text-center"><%=Produk("pdStokAwal")%></td>
                    <td class="text-center"><%=Produk("Pembelian")%></td>
                    <td class="text-center"><%=Produk("penjualan")%></td>
                    <% sisastok = Produk("pdStokAwal")+Produk("Pembelian")-Produk("penjualan")%>
                    <td class="text-center"><%=sisastok%></td>
                    <td class="text-center"><%=Produk("pdLokasi")%></td>
                    <td class="text-center"><button class="btn-sp" onclick="window.open('P-upproduk.asp?produkid='+document.getElementById('pdID<%=Produk("pdID")%>').value+'&stokproduk='+document.getElementById('pdStok<%=Produk("pdID")%>').value+'&harga='+document.getElementById('pdHargaJual<%=Produk("pdID")%>').value,'_Self')"> Send </button></td>
                </tr>
                <script>
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
                </script>
            <% Produk.movenext
            loop%>
            </tbody>
        </table>
                </div>
            </div>
        </div>
        
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>