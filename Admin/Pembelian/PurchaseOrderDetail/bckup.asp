<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText = "SELECT MKT_M_Supplier.spNama1, MKT_M_Supplier.spKey, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_D.po_spoID, MKT_T_PurchaseOrder_H.poJenisOrder,  MKT_M_StatusPurchaseOrder.spoName, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.po_pdID,  MKT_T_PurchaseOrder_D.pdPartNumber AS Expr1, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poPdUnit, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID LEFT OUTER JOIN MKT_M_StatusPurchaseOrder ON MKT_T_PurchaseOrder_D.po_spoID = MKT_M_StatusPurchaseOrder.spoID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_PurchaseOrder_H.po_spID = MKT_M_Supplier.spID ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE po_custID = '"& request.Cookies("custID") &"' ORDER BY MKT_T_PurchaseOrder_H.poTanggal DESC "
        'response.write PurchaseOrder_cmd.commandText 

    set PurchaseOrder = PurchaseOrder_cmd.execute

    set DataPO_cmd = server.createObject("ADODB.COMMAND")
	DataPO_cmd.activeConnection = MM_PIGO_String

        DataPO_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.po_spID FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN   MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H where MKT_T_PurchaseOrder_H.po_custID = '"& request.Cookies("custID") &"'AND MKT_T_PurchaseOrder_D.po_spoID = '0'  GROUP BY MKT_T_PurchaseOrder_H.poID,MKT_T_PurchaseOrder_H.poTanggal,MKT_T_PurchaseOrder_H.po_spID"
        'response.write  DataPO_cmd.commandText

    set DataPO = DataPO_cmd.execute

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE MKT_T_PurchaseOrder_H.po_custID = '"& request.Cookies("custID") &"'  GROUP BY MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama "
        'response.write  Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set jatuhtempo_cmd = server.createObject("ADODB.COMMAND")
	jatuhtempo_cmd.activeConnection = MM_PIGO_String

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
        <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
        <script src="<%=base_url%>/DataTables/datatables.js"></script>
        <script>
            // $(document).ready(function() {
            //     $('#example').DataTable( {
            //     });
            // });
            function cetakpo(){
                $.ajax({
                    type: "get",
                    url: "get-datapo.asp?poID="+document.getElementById("poID").value,
                    success: function (url) {
                        $('.datatr').html(url);
                        // console.log(url);
                    }
                });
            }
            function caripo(){
                $.ajax({
                    type: "get",
                    url: "load-datapo.asp?caripo="+document.getElementById("caripo").value+"&jenispo="+document.getElementById("jenispo").value,
                    success: function (url) {
                        $('.datatr').html(url);
                        // console.log(url);
                    }
                });
            }
            function cetaklist(){
                $.ajax({
                    type: "get",
                    url: "listprodukpo.asp?namapd="+document.getElementById("namapd").value,
                    success: function (url) {
                        $('.datatr').html(url);
                        // console.log(url);
                    }
                });
            }
            function tgla(){
                $.ajax({
                    type: "get",
                    url: "getdata.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                    success: function (url) {
                        $('.datatr').html(url);
                        console.log(url);
                        
                    }
                });
            }
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
                    <div class="row align-items-center">
                        <div class="col-9">
                            <span class="txt-po-judul"> Purchase Order </span>
                        </div>
                        <div class="col-3">
                            <button class=" btn-tambah-po txt-po-judul" onclick="window.open('../PurchaseOrder/','_Self')"> Tambah Purchase Order Baru </button>
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
                            <div class="col-6">
                                <span class="txt-purchase-order me-4"> Cari </span><span class="txt-purchase-order" style="font-size:10px; color:red"><i>( Silahkan Pilih Jenis Order PO Terlebih Dahulu Lalu Masukan No PO Dibawah ) </i></span><br>
                                <input onkeyup="return caripo()" class=" mb-2 inp-purchase-order" type="search" name="caripo" id="caripo" value="PIGO/PO/">
                            </div>
                            <div class="col-2">
                                <span class="txt-purchase-order"> Jenis Order PO </span><br>
                                <select onchange="return caripo()" style="width:10rem" class=" mb-2 inp-purchase-order" name="jenispo" id="jenispo" aria-label="Default select example" required>
                                    <option selected>Pilih Jenis PO</option>
                                    <option value="SlowMoving">Slow Moving</option>
                                    <option value="FastMoving">Fast Moving</option>
                                </select>
                            </div>
                            <div class="col-4">
                                <span class="txt-purchase-order"> Cetak PO </span><br>
                                <select  onchange="return cetakpo()" name="poID" id="poID" style="width:15rem" class=" mb-2 inp-purchase-order" name="jenispo" id="jenispo" aria-label="Default select example" >
                                <option selected>Pilih PO </option>
                                <% if DataPO.eof = true then %>
                                <option value="0"> Belum Ada PO Terbaru </option>
                                <% else %>
                                <% do while not DataPO.eof %>
                                <option value="<%=DataPO("poID")%>"><%=DataPO("poID")%>,<%=DataPO("poTanggal")%></option>
                                <% DataPO.movenext
                                loop%>
                                <% end if %>
                            </select>
                            <button class="btn-cetak-po" style="width:4rem;height:1.6rem; border-radius:5px"onclick="window.open('buktipo.asp?poID='+document.getElementById('poID').value+'&tanggalpo='+document.getElementById('tanggalpo').value,'_Self')" >Cetak </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="purchase-order">
            <div class="row">
                <div class="col-12">
                    <span class="txt-purchase-order me-4"> Periode PO </span><br>
                </div>
            </div>
            <div class="row">
                <div class="col-2">
                    <input onchange="tgla()" class=" mb-2 inp-purchase-order" type="date" name="tgla" id="tgla" value="" style="width:10rem">
                </div>
                <div class="col-2">
                    <input onchange="tgla()" class=" mb-2 inp-purchase-order" type="date" name="tgle" id="tgle" value="" style="width:10rem">
                </div>
                <div class="col-4">
                    <div class="dropdown">
                        <button style="width:11rem;height:1.6rem; border-radius:5px"class="btn-cetak-po dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                            Download Laporan 
                        </button>
                        <ul class="dropdown-menu text-center btn-cetak-po" aria-labelledby="dropdownMenuButton1">
                            <li>
                                <button class="btn-cetak-po" onclick="window.open('lappopdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')">Laporan PDF</button>
                            </li>
                            <li>
                                <button class=" mt-2 btn-cetak-po" onclick="window.open('lappoexc.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Excel </button>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="col-4">
                    <select onchange="window.open('listprodukpo.asp?namapd='+document.getElementById('namapd').value,'_Self')" name="namapd" id="namapd" style="width:20rem" class=" mb-2 inp-purchase-order" name="jenispo" id="jenispo" aria-label="Default select example" >
                        <option selected> Nama Produk </option>
                        <% do while not Produk.eof %>
                        <option value="<%=Produk("pdNama")%>"> <%=Produk("pdNama")%> </option>
                        <% Produk.movenext
                        loop %>
                    </select>
                </div>
            </div>
        </div>
        <div class="row ">
            <div class="col-12">
                <div class="purchase-order">
                    <div class="row  align-items-center">
                        <div class="col-12">
                        <span class="txt-purchase-order "style="font-size:10px; color:red"> Jatuh Tempo Purchase Order Terhitung Mulai Dari Tanggal Penerimaan Invoice Dari Supplier </span>
                            <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                                <thead>
                                    <tr class="text-center">
                                        <th>No</th>
                                        <th>PO ID</th>
                                        <th>Tanggal</th>
                                        <th>Supplier</th>
                                        <th>Nama Produk</th>
                                        <th>Jenis Order</th>
                                        <th>Status PO</th>
                                        <th>Jatuh Tempo</th>
                                        <th> Aksi </th>
                                    </tr>
                                </thead>
                                <tbody class="datatr">
                                <% 
                                    no = 0
                                    do while not PurchaseOrder.eof 
                                    no = no + 1
                                %>
                                    <tr>
                                        <td class="text-center"><%=no%></td>
                                        <td class="text-center"><%=PurchaseOrder("poID")%></td>
                                        <input type="hidden" name="tanggalpo" id="tanggalpo" value="<%=PurchaseOrder("poTanggal")%>">
                                        <td class="text-center"><%=Cdate(PurchaseOrder("poTanggal"))%></td>
                                        <td><%=PurchaseOrder("spNama1")%></td>
                                        <td class="text-center"><%=PurchaseOrder("poJenisOrder")%></td>

                                        <% if PurchaseOrder("po_spoID") = "0" then %>
                                        <td class="text-center"><span class="label-stpo0"><%=PurchaseOrder("spoName")%></span></td>
                                        <%else if PurchaseOrder("po_spoID") = "1" then %>
                                        <td class="text-center"><span class="label-stpo1"><%=PurchaseOrder("spoName")%></span></td>
                                        <%else if PurchaseOrder("po_spoID") = "2" then %>
                                        <td class="text-center"><span class="label-stpo2"><%=PurchaseOrder("spoName")%></span></td>
                                        <%else if PurchaseOrder("po_spoID") = "3" then %>
                                        <td class="text-center"><span class="label-stpo3"><%=PurchaseOrder("spoName")%></span></td>
                                        <%else %>
                                        <td class="text-center"><span class="label-stpo4"><%=PurchaseOrder("spoName")%></span></td>
                                        <% end if %><% end if %><% end if %><% end if %>
                                        <%
                                            jatuhtempo_cmd.commandText = "SELECT DATEADD(day, MKT_M_Supplier.spPaymentTerm, MKT_T_MaterialReceipt_H.mmTanggal) AS DateAdd FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_M_Supplier RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Supplier.spID = MKT_T_MaterialReceipt_H.mm_spID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON  MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE MKT_T_PurchaseOrder_H.poID = '"& PurchaseOrder("poID") &"' AND MKT_T_PurchaseOrder_D.po_pdID = '"& PurchaseOrder("pdID") &"' AND MKT_T_PurchaseOrder_D.po_spoID = 1 AND (MKT_T_MaterialReceipt_H.mmTanggal)IS NOT NULL "
                                            'response.write  jatuhtempo_cmd.commandText

                                            set jatuhtempo = jatuhtempo_cmd.execute
                                        %>
                                        <% if jatuhtempo.eof = true then %>
                                        <td class="text-center "style="color:red">Pending</td>
                                        <%else%>
                                        <td class="text-center"><%=CDate(jatuhtempo("DateAdd"))%></td>
                                        <%end if%>
                                        <% if PurchaseOrder("po_spoID") = "1" then %>
                                        <td class="text-center"> - </td>
                                        <% else %>
                                        <td class="text-center">
                                            <div class="dropdown">
                                                <button style="width:3rem;height:1.4rem; border-radius:5px"class="btn-cetak-po dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="fas fa-list-ul"></i>
                                                </button>
                                                <ul class="dropdown-menu text-center btn-cetak-po" aria-labelledby="dropdownMenuButton1">
                                                    <li>
                                                        <button class="btn-cetak-po" onclick="window.open('lappopdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')">Revisi PO</button>
                                                    </li>
                                                    <li>
                                                        <button class=" mt-2 btn-cetak-po" id="myBtn<%=no%>"> Pembatalan PO </button>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                        <% end if %>
                                    </tr>
                                    <!-- Modal -->
                                        <!-- The Modal -->
                                        <div id="myModal<%=no%>" class="modal">
                                            <!-- Modal content -->
                                                <div class="modall-content">
                                                    <div class="modal-body">
                                                        <div class="row mt-3">
                                                            <div class="col-11">
                                                                <span class="txt-modal-judul"> Konfirmasi Pembatalan Purchase Order </span>
                                                            </div>
                                                            <div class="col-1">
                                                                <span><i class="fas fa-times close<%=no%>"></i></span>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div class="body mt-3 mb-3" style="padding:2px 5px">
                                                            <div class="row align-items-center">
                                                                <div class="col-12">
                                                                    <span class="txt-modal-desc"> Tanggal Pembatalan : <input class="txt-modal-desc" type="text" name="" id="" Value="<%=CDate(now())%>" style="width:65%; border:none"></span>
                                                                    </div>
                                                            </div>
                                                            <div class="row align-items-center mt-2 mb-2">
                                                                <div class="col-3">
                                                                    <span class="txt-modal-desc"> Kode PO </span><br>
                                                                    <span class="txt-modal-desc"> Supplier </span><br>
                                                                </div>
                                                                <div class="col-9">
                                                                    <span class="txt-modal-desc"> <%=PurchaseOrder("poID")%> - [<%=CDate(PurchaseOrder("poTanggal"))%>] </span><br>
                                                                    <span class="txt-modal-desc"> <%=PurchaseOrder("spNama1")%></span><br>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-2 text-center">
                                                                <div class="col-12">
                                                                    <span class="txt-modal-desc"> Pembelian PO </span><br>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-2 ">
                                                                <div class="col-3">
                                                                    <span class="txt-modal-desc"> ID Produk </span><br>
                                                                    <span class="txt-modal-desc"> Nama Produk </span><br>
                                                                    <span class="txt-modal-desc"> QTY </span><br>
                                                                    <span class="txt-modal-desc"> Harga </span><br>
                                                                    <span class="txt-modal-desc"> Total </span>
                                                                </div>
                                                                <div class="col-9">
                                                                    <span class="txt-modal-desc"> <%=PurchaseOrder("pdID")%> </span><br>
                                                                    <span class="txt-modal-desc"> <%=PurchaseOrder("pdNama")%> </span><br>
                                                                    <span class="txt-modal-desc"> <%=PurchaseOrder("poQtyProduk")%> [ <%=PurchaseOrder("poPdUnit")%> ]</span><br>
                                                                    <span class="txt-modal-desc"> <%=Replace(FormatCurrency(PurchaseOrder("poHargaSatuan")),"$","Rp. ")%> </span><br>
                                                                    <% total = PurchaseOrder("poQtyProduk")* PurchaseOrder("poHargaSatuan")%>
                                                                    <span class="txt-modal-desc"> <%=Replace(FormatCurrency(total),"$","Rp. ")%> </span>
                                                                </div>
                                                                <input type="hidden" name="poid" id="poid" value="<%=PurchaseOrder("poID")%>">
                                                                <input type="hidden" name="potanggal" id="potanggal" value="<%=PurchaseOrder("poTanggal")%>">
                                                                <input type="hidden" name="pdid" id="pdid" value="<%=PurchaseOrder("pdID")%>">
                                                                <input type="hidden" name="poqty" id="poqty" value="<%=PurchaseOrder("poQtyProduk")%>">
                                                                <input type="hidden" name="harga" id="harga" value="<%=PurchaseOrder("poHargaSatuan")%>">
                                                            </div>
                                                            <div class="row mb-1 mt-2 text-center">
                                                                <div class="col-12">
                                                                <span class="txt-modal-desc"> Alasan Pembatalan  </span><br>
                                                                <input required  name="alasan" id="alasan" type="text" value="" style="width:20rem">
                                                                </div>
                                                            </div>
                                                            <div class="row mb-1 mt-3 text-center">
                                                                <div class="col-12">
                                                                <button onclick="return pembatalan<%=no%>()" class="btn-konfirmasi"> Batalkan Purchase Order </button><br>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                            <!-- Modal content -->
                                        </div>
                                        <script>
                                                function pembatalan<%=no%>(){
                                                    var poid	    = document.getElementById("poid").value;
                                                    var potanggal	= document.getElementById("potanggal").value;
                                                    var pdid	    = document.getElementById("pdid").value;
                                                    var poqty	    = document.getElementById("poqty").value;
                                                    var harga	    = document.getElementById("harga").value;
                                                    var alasan	    = document.getElementById("alasan").value;
                                                    console.log(pdid);
                                                    
                                                    $.ajax({
                                                        type: "GET",
                                                        url: "batalpo.asp",
                                                        data: { 
                                                            poid:poid,
                                                            potanggal:potanggal,
                                                            pdid:pdid,
                                                            poqty:poqty,
                                                            harga:harga,
                                                            alasan:alasan,
                                                        },
                                                        success: function (data) {
                                                            console.log(data);
                                                            // alert("Purchase Order [ "+poid+" ] Tanggal [ "+potanggal+" ] Berhasil Dibatalkan Dengan Alasan [ "+alasan+" ]");
                                                            
                                                        }
                                                    });
                                                }
                                                var modal<%=no%> = document.getElementById("myModal<%=no%>");
                                                var btn<%=no%> = document.getElementById("myBtn<%=no%>");
                                                var span<%=no%> = document.getElementsByClassName("close<%=no%>")[0];
                                                btn<%=no%>.onclick = function() {
                                                modal<%=no%>.style.display = "block";
                                                }
                                                span<%=no%>.onclick = function() {
                                                modal<%=no%>.style.display = "none";
                                                }
                                                window.onclick = function(event) {
                                                if (event.target == modal<%=no%>) {
                                                    modal<%=no%>.style.display = "none";
                                                }
                                                }
                                        </script>
                                    <!-- Modal -->
                                <% PurchaseOrder.movenext
                                loop
                                nomor = no %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12">
                
            </div>
        </div>
    </div>
</body>
    <script>
       
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>
