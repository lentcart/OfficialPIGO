<!--#include file="../../../../connections/pigoConn.asp"-->
<%
    newpo = request.queryString("newpo")
    poID = request.queryString("poID")
    po_spID = request.queryString("po_spID")

    set PurchaseOrder_R_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_R_CMD.activeConnection = MM_pigo_STRING
    PurchaseOrder_R_CMD.commandText = " INSERT INTO [dbo].[MKT_T_PurchaseOrder_R]([poID],[po_Ket],[po_custID],[poUpdateID],[poUpdateTime],[poAktifYN])VALUES('"& newpo &"','01','"& po_spID &"','','"& now() &"','Y') "
    'response.write PurchaseOrder_R_CMD.commandText & "<br><br>"
    set PurchaseOrder_R = PurchaseOrder_R_CMD.execute

    PurchaseOrder_R_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set poID_H = '"& newpo &"' WHERE poID_H = '"& poID &"' "
    'response.write PurchaseOrder_R_CMD.commandText & "<br><br>"
    set UpdateD = PurchaseOrder_R_CMD.execute

    set produk_CMD = server.CreateObject("ADODB.command")
    produk_CMD.activeConnection = MM_pigo_STRING
    produk_CMD.commandText = "SELECT MKT_T_PurchaseOrder_D.po_pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak,  MKT_T_PurchaseOrder_D.poSubTotal FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE MKT_T_PurchaseOrder_H.poID = '"& newpo &"' and MKT_T_PurchaseOrder_H.po_custID = '"& po_spID &"' "
    'response.write Produk_cmd.commandText
    set produk = produk_CMD.execute

    set PoDraft_CMD = server.createObject("ADODB.COMMAND")
	PoDraft_CMD.activeConnection = MM_PIGO_String

        PoDraft_CMD.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal,  MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.poTglOrder,  MKT_T_PurchaseOrder_H.poTglDiterima, MKT_T_PurchaseOrder_H.poStatusKredit,  MKT_M_Customer.custID,  MKT_M_Customer.custNama, MKT_M_Alamat.almLengkap, MKT_M_Customer.custNamaCP, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custPhone1, MKT_M_Customer.custEmail, MKT_M_Customer.custNpwp  FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE almJenis <> 'Alamat Toko' AND poID = '"& newpo &"'  GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal,  MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.poTglOrder,  MKT_T_PurchaseOrder_H.poTglDiterima, MKT_T_PurchaseOrder_H.poStatusKredit,  MKT_T_PurchaseOrder_H.poStatus, MKT_M_Customer.custID,  MKT_M_Customer.custNama, MKT_M_Alamat.almLengkap, MKT_M_Customer.custNamaCP, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custPhone1, MKT_M_Customer.custEmail, MKT_M_Customer.custNpwp "
        'response.write PoDraft_CMD.commandText

    set DraftPO = PoDraft_CMD.execute

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String

        BussinesPartner_cmd.commandText = "SELECT * FROM MKT_M_CUSTOMER WHERE custAktifYN = 'Y' "
        'response.write BussinesPartner_cmd.commandText

    set BussinesPartner = BussinesPartner_cmd.execute

    set KeyProduk_cmd = server.createObject("ADODB.COMMAND")
	KeyProduk_cmd.activeConnection = MM_PIGO_String

        KeyProduk_cmd.commandText = "SELECT pdKey FROM MKT_M_PIGO_Produk WHERE pdAktifYN = 'Y'"
        'response.write KeyProduk_cmd.commandText

    set KeyProduk = KeyProduk_cmd.execute
%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
        function contcall(){
            document.getElementById("cont-calculator").style.display = "block"
        }
        function getBussinesPartner(){
            var Bussines = $('input[name=keysearch]').val();            
            $.ajax({
                type: "get",
                url: "get-bussinespart.asp?keysearch="+Bussines,
                success: function (url) {
                // console.log(url);
                $('.cont-BussinesPart').html(url);
                }
            });
        }
        
        function getsupplier(){
            $.ajax({
                type: "get",
                url: "loadsupplier.asp?keysupplier="+document.getElementById("keysupplier").value,
                success: function (url) {
                // console.log(url);
                $('.datasp').html(url);
                                    
                }
            });
        }
        function tampilproduk(){
            let pem= document.getElementsByClassName("simpan");

            document.getElementById("poproduk").style.display = "block";
        }

        function getKeyProduk(){
            $.ajax({
                type: "get",
                url: "../../PurchaseOrder/get-Produk.asp?katakunci="+document.getElementById("katakunci").value,
                success: function (url) {
                // console.log(url);
                $('.keypd').html(url);
                                    
                }
            });
        }
        
        // function subtotal(){
        //     var qty = parseInt(document.getElementById("qtyproduk").value);
        //     var harga = parseInt(document.getElementById("harga").value);
        //     var total = Number(qty*harga);
        //     document.getElementById("subtotalpo").value = total;
            
        // };
        // document.addEventListener("DOMContentLoaded", function(event) {
        //     subtotal();
        // });
        function Batal() {
            Swal.fire({
            title: 'Anda Yakin Akan Membatalkan Proses Ini Tanpa Menyimpan ?',
            showCancelButton: true,
            confirmButtonText: 'Yakin',
            }).then((result) => {
            if (result.isConfirmed) {
                window.open('../PurchaseOrderDetail/', '_Self');
            } 
            })
        }
    </script>
    <style>

        #clear{
            width: 14.3rem;
            color:black;
            font-weight:bold;
            font-size:12px;
            border: 1px solid #d4d4d4;
            border-radius: 3px;
            padding: 2px;
            box-shadow: 0 2px 3px 0 rgba(10, 10, 10, 0.2),0 6px 20px 0 rgba(175, 175, 175, 0.19);
            background-color: #eee;
        }

        .formstyle{
            width:15rem;
            height:15.3rem;
            margin: auto;
            background:#aaa;
            border-radius: 10px;
            padding: 5px;
        }

        .inp-cal{
            width: 44px;
            background-color: green;
            color: black;
            font-weight:bold;
            border: 1px solid #d4d4d4;
            border-radius: 0px;
            padding: 5px 5px;
            margin: 5px;
            box-shadow: 0 2px 3px 0 rgba(10, 10, 10, 0.2),0 6px 20px 0 rgba(175, 175, 175, 0.19);
            font-size: 12px;
        }
        #kalkulator{
            display:none;
            margin-left:-20px;
        }

        #calc{
            width: 14.4rem;
            font-size:12px;
            color: blue;
            font-weight:bold;
            padding: 6px 10px;
            background:#aaa;
            border: 1px solid #d4d4d4;
            border-radius: 5px;
            margin: auto;
        }
    </style>
    </head>
    <!--#include file="../../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-10 col-md-10 col-sm-12">
                        <span class="cont-text">REVISI PURCHASE ORDER </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button class="cont-btn" onclick="return Batal()"> Batal </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <span class="cont-text"> Tanggal PO  </span><br>
                        <input readonly type="text" class=" text-center cont-form" name="tanggalpo" id="cont" value="<%=CDate(DraftPO("poTanggal"))%>"><br>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <span class="cont-text"> Jenis Order </span><br>
                        <% if DraftPO("poJenisOrder") = "1" then  %>
                        <input readonly type="hidden" class=" text-center cont-form" name="tanggalpo" id="cont" value="<%=DraftPO("poJenisOrder")%>">
                        <input readonly type="text" class=" text-center cont-form"  value="Slow Moving">
                        <% else %>
                        <input readonly type="hidden" class=" text-center cont-form" name="tanggalpo" id="cont" value="<%=DraftPO("poJenisOrder")%>">
                        <input readonly type="text" class=" text-center cont-form"  value="Fast Moving">
                        <% end if  %>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                    <span class="cont-text"> Status Credit </span><br>
                        <% if DraftPO("poStatusKredit") = "01" then%>
                        <input readonly type="hidden" class=" text-center cont-form" name="tanggalpo" id="cont" value="<%=DraftPO("poStatusKredit")%>">
                        <input readonly type="text" class=" text-center cont-form" value="Kredit">
                        <% else %>
                        <input readonly type="hidden" class=" text-center cont-form" name="tanggalpo" id="cont" value="<%=DraftPO("poStatusKredit")%>">
                        <input readonly type="text" class=" text-center cont-form"  value="Cash">
                        <% end if %>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <span class="cont-text"> Tanggal Order  </span><br>
                        <input readonly type="text" class=" text-center cont-form" name="tanggalorder" id="cont" value="<%=CDate(DraftPO("poTglOrder"))%>"><br>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <span class="cont-text"> Tanggal Penerimaan </span><br>
                        <input readonly type="text" class=" text-center cont-form" name="tanggalditerima" id="cont" value="<%=CDate(DraftPO("poTglDiterima"))%>"><br>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12 cont-kredit" id="cont-kredit">
                    <br>
                        <button class="cont-btn form-check-label" for="flexCheckDefault"> Bussines Partner </button>
                    </div>
                </div>

                <div class="row mt-2 mb-2 text-center ">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="cont-label-text">
                            <span class=" cont-text"> Bussines Partner </span>
                        </div>
                    </div>
                </div>
                
                <div class="cont-Bussines">
                    <div class="row">
                        <div class="col-lg-2 col-md-6 col-sm-12">
                            <span class="cont-text">  BussinesPartner ID </span><br>
                            <input readonly type="text" class="  cont-form" name="supplierid" id="cont" value="<%=DraftPO("custID")%>"><br>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <span class="cont-text"> Nama BussinesPartner </span><br>
                            <input readonly type="text" class="  cont-form" name="namasupplier" id="cont" value="<%=DraftPO("custNama")%>" ><br>
                        </div>
                        <div class="col-lg-1 col-md-2 col-sm-12">
                            <span class="cont-text"> PayTerm</span><br>
                            <input readonly type="text" class="  cont-form" name="poterm" id="cont" value="<%=DraftPO("custPaymentTerm")%>" ><br>
                        </div>
                        <div class="col-lg-5 col-md-10 col-sm-12">
                            <span class="cont-text"> Nama CP BussinesPartner </span><br>
                            <input readonly type="text" class="  cont-form" name="namacp" id="cont" value="<%=DraftPO("custNamaCP")%>" ><br>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <span class="cont-text"> Lokasi BussinesPartner </span><br>
                            <input readonly type="text" class="  cont-form" name="lokasi" id="cont" value="<%=DraftPO("almLengkap")%>" ><br>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-12">
                            <span class="cont-text"> Phone </span><br>
                            <input readonly  type="text" class="  cont-form" name="Phone" id="cont" value="<%=DraftPO("custPhone1")%>" ><br>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-12">
                            <span class="cont-text"> Email </span><br>
                            <input readonly  type="text" class="  cont-form" name="Email" id="cont" value="<%=DraftPO("custEmail")%>" ><br>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-12">
                            <span class="cont-text"> NPWP </span><br>
                            <input readonly  type="text" class="  cont-form" name="NPWP" id="cont" value="<%=DraftPO("custNpwp")%>" ><br>
                        </div>
                    </div>
                </div>

                <div class="row mt-3  text-center ">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="cont-label-text">
                            <span class=" cont-text"> Tambah Produk </span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <input type="hidden" name="poID" id="poID" value="<%=newpo%>"><input type="hidden" name="poTanggal" id="poTanggal" value="<%=DraftPO("poTanggal")%>">
                    </div>
                </div>
                <div class="cont-Produk-PO mt-2" id="cont-Produk-PO" style="display:block">
                    <div class="row">
                        <div class="col-lg-2 col-md-3 col-sm-12">
                            <span class="cont-text"> Kata Kunci </span><br>
                            <input required onkeyup="getKeyProduk()" type="text" class="  cont-form" name="katakunci" id="katakunci" value=""><br>
                        </div>
                        <div class="col-lg-4 col-md-3 col-sm-12 keypd">
                            <span class="cont-text"> </span><br>
                            <select   class=" cont-form" name="s" id="s" aria-label="Default select example" required>
                                <option value="">Pilih Produk</option>
                                <option value=""></option>
                            </select>
                        </div>
                    </div>
                    <div class="row datapd">
                        <input type="hidden" class=" cont-form" name="produkid" id="produkid" value="" ><br>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <span class="cont-text"> Nama Produk </span><br>
                                <input readonly type="text" class="  cont-form" name="namaproduk" id="namaproduk" value="" ><br>
                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-12">
                                        <div class="row">
                                            <div class="col-lg-10 col-md-6 col-sm-12">
                                                <span class="cont-text"> Harga </span><br>
                                                <input readonly type="number" class=" text-center  cont-form" name="harga" id="harga" value="0" style="width:100%">
                                            </div>
                                            <div class="col-lg-2 col-md-6 col-sm-12"   style="margin-top:26px;margin-left:-8px">
                                                <input  type="checkbox" id="kalkulator">
                                                <label class="side-toggle" for="kalkulator"> <span class="fas fa-calculator" style="font-size:17px"> </span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-12">
                                        <span class="cont-text"> Diskon </span><br>
                                        <input  readonly type="number" class=" cont-form" name="diskon" id="diskon" value="0"><br>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-12">
                                        <span class="cont-text"> QTY Produk </span><br>
                                        <input  readonly type="number" class="  text-center  cont-form" name="qtyproduk" id="qtyproduk" value="0"><br>
                                    </div>
                                </div>
                            </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-6 col-sm-12">
                                                <span class="cont-text"> SKU/Part Number</span><br>
                                                <input readonly type="text" class=" text-center  cont-form" name="skuproduk" id="skuproduk" value="" ><br>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-sm-12">
                                                <span class="cont-text"> Lokasi Rak </span><br>
                                                <input readonly type="text" class="  cont-form" name="lokasirak" id="lokasirak" value="" ><br>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-12">
                                                <span class="cont-text"> Unit </span><br>
                                                <input readonly type="text" class="  text-center  cont-form" name="unitproduk" id="unitproduk" value="" ><br>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-4 col-md-4 col-sm-12">
                                                <span class="cont-text"> Sub Total </span><br>
                                                <input readonly type="number" class=" text-center  cont-form" name="subtotalpo" id="subtotalpo" value="0"><br>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-sm-12">
                                                <span class="cont-text"> TAX (PPN) </span><br>
                                                <select disabled="true" class=" cont-form" name="ppn" id="ppn" aria-label="Default select example" >
                                                    <option value="">Pilih Produk</option>
                                                </select>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-sm-12">
                                                <span class="cont-text">  </span><br>
                                                <input readonly type="number" class=" text-center  cont-form" name="totalpo" id="totalpo" value="0"><br>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-3 mb-3">
                                    <div class="col-lg-8 col-md-8 col-sm-8 ">
                                    <span class="cont-text"> </span><br>
                                        <button onclick="sendproduk()"class=" btn-addpo cont-btn"> Tambah Produk </button>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-4">
                                        <span class="cont-text"> Status Purchase Order </span><br>
                                        <select class="statuspo cont-form" name="statuspo" id="statuspo" aria-label="Default select example" required>
                                            <option value=""> Pilih Status </option>
                                            <option value="1">Draft</option>
                                            <option value="2">Complete</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="cont-tb" style="padding:2px 5px; height:15rem">
                                
                                
                                <div class="row">
                                    <div class="col-12">
                                        <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                                            <thead>
                                                <tr class="text-center">
                                                    <th>No</th>
                                                    <th>ID Produk</th>
                                                    <th>Nama Produk</th>
                                                    <th>QTY</th>
                                                    <th>Harga</th>
                                                    <th>PPN</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <%
                                                set PurchaseOrder_D_CMD = server.CreateObject("ADODB.command")
                                                PurchaseOrder_D_CMD.activeConnection = MM_pigo_STRING
                                                PurchaseOrder_D_CMD.commandText = "SELECT MKT_T_PurchaseOrder_D.po_pdID, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poPdUnit, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak,MKT_T_PurchaseOrder_D.poSubTotal,  MKT_M_PIGO_Produk.pdNama FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID Where MKT_T_PurchaseOrder_D.poID_H = '"& newpo &"' "
                                                'response.write PurchaseOrder_D_CMD.commandText
                                                set produkpo = PurchaseOrder_D_CMD.execute
                                            %>
                                            <tbody class="data-produk">
                                                <% 
                                                    no = 0
                                                    do while not produkpo.eof 
                                                    no = no + 1 
                                                %>
                                                <tr>
                                                    <td> <%=no%></td>
                                                    <td> <%=produkpo("po_pdID")%></td>
                                                    <td> <%=produkpo("pdNama")%></td>
                                                    <td> <%=produkpo("poQtyProduk")%></td>
                                                    <td> <%=produkpo("poHargaSatuan")%></td>
                                                    <td> <%=produkpo("poPajak")%></td>
                                                    <td> <%=produkpo("poSubTotal")%></td>
                                                </tr>
                                                <% produkpo.movenext
                                                loop %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                </div>
                                <div class="row  mt-1">
                                    <div class="col-3 text-start">
                                        <button onclick="statuspo()" name="btn-selesai" id="btn-selesai" class="cont-btn"> Selesai </button>
                                        <button onclick="window.open('../../PurchaseOrderDetail/buktipo.asp?poID='+document.getElementById('poID').value+'&poTanggal='+document.getElementById('poTanggal').value,'_Self')" class="cont-btn" name="btn-cetakpo" id="btn-cetakpo" style="display:none"> Cetak Bukti PO </button>
                                    </div>
                                    <div class="col-3 text-start">
                                        <button onclick="window.open('../../PurchaseOrderDetail/','_Self')" class="cont-btn" name="btn-listpo" id="btn-listpo" style="display:none"> List PO </button>
                                    </div>
                                    <!--<div class="col-6 text-end">
                                        <button onclick="window.open('../PurchaseOrderDetail/buktipo.asp?poID='+document.getElementById('poID').value+'&poTanggal='+document.getElementById('poTanggal').value,'_Self')" class="cont-btn" style="width:13rem"> Selesai ( Cetak Bukti PO ) </button>
                                    </div>-->
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
    </div>
    <!--#include file="../../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
    <script>
    function statuspo(){
        var status = document.getElementById("statuspo").value;
        var poID = $('#poID').val();
        if (status == ""){
            $('.statuspo').focus();
        }else {
            $.ajax({
                type: "POST",
                url: "../../PurchaseOrder/update-purchaseorder.asp",
                data:{
                    poID,
                    status
                },
                success: function (data) {
                    document.getElementById("btn-listpo").style.display = "block";
                    document.getElementById("btn-cetakpo").style.display = "block";
                    document.getElementById("btn-selesai").style.display = "none";
                }
            });
        }
    }
        function tax(){
            var tax = document.getElementById("ppn").value;
            var qty = parseInt(document.getElementById("qtyproduk").value);
            var harga = parseInt(document.getElementById("harga").value);
            //console.log(tax);
            
            if( tax == "0" ){
                var total = Number(qty*harga);
                document.getElementById("subtotalpo").value = total;
                document.getElementById("totalpo").value = total;
                // console.log(total);
                
            }else{
                tax = 11;
                var total = Number(qty*harga);
                pajak = tax/100*total;
                subtotal = total+pajak;
                var grandtotal = Math.round(subtotal);
                document.getElementById("subtotalpo").value = total;
                document.getElementById("totalpo").value = grandtotal;
                // console.log(subtotal);
                
            }

        }
        function totalline(){
            var qty = parseInt(document.getElementById("qtyproduk").value);
            var harga = parseInt(document.getElementById("harga").value);
            var total = Number(qty*harga);
            document.getElementById("subtotalpo").value = total;
            // console.log(qty, harga, total);
        };
        document.addEventListener("DOMContentLoaded", function(event) {
            totalline();
        });
        function getproduk(){
            var pdID = document.getElementById("pdID").value;
            
            $.ajax({
                type: "get",
                url: "../../PurchaseOrder/loadproduk.asp?pdID="+document.getElementById("pdID").value,
                success: function (url) {
                // console.log(url);
                $('.datapd').html(url);
                                    
                }
            });
        }

        function sendproduk(){
            var poID = $('#poID').val();
            var poTanggal = $('input[name=tanggalpo]').val();
            var po_pdID = $('#produkid').val();
            var poQtyProduk = $('#qtyproduk').val();
            var poPdUnit = $('#unitproduk').val();
            var poHarga = $('#hargabulat').val();
            var poPajak = $('#ppn').val();
            var poDiskon = $('#diskon').val();
            var poSubTotal = $('#subtotalpo').val();
            var poTotal = $('#totalpo').val();
            $.ajax({
                type: "get",
                url: "../../PurchaseOrder/add-produkpo.asp",
                    data:{
                        poID,
                        poTanggal,
                        po_pdID,
                        poQtyProduk,
                        poPdUnit,
                        poHarga,
                        poPajak,
                        poDiskon,
                        poSubTotal,
                        poTotal
                    },
                success: function (data) {
                    document.getElementById("loader-page").style.display = "block";
                    setTimeout(() => {
                    document.getElementById("loader-page").style.display = "none";
                    
                        // Swal.fire({
                        //     title: 'Ingin Menambah Produk Lagi ?',
                        //     showDenyButton: true,
                        //     showCancelButton: true,
                        //     confirmButtonText: 'Iya',
                        //     denyButtonText: `Tidak`,
                        //     }).then((result) => {
                        //     if (result.isConfirmed) {
                        //         location.reload();
                        //     } else if (result.isDenied) {
                        //         window.open(`../PurchaseOrderDetail/buktipo.asp?poID=${poID}&tanggalpo=${poTanggal}`,`_Self`)
                        //     }
                        // })
                    }, 1000);
                    document.getElementById("katakunci").value = "";
                    document.getElementById("namaproduk").value = "";
                    document.getElementById("skuproduk").value = "";
                    document.getElementById("lokasirak").value = "";
                    document.getElementById("unitproduk").value = 0;
                    document.getElementById("hargabulat").value = 0;
                    document.getElementById("qtyproduk").value = 0;
                    document.getElementById("ppn").value = "";
                    document.getElementById("subtotalpo").value = 0;
                    document.getElementById("totalpo").value = 0;
                    document.getElementById("diskon").value = "0";
                    document.getElementById("pdID").value = "";

                    $('.data-produk').html(data);
                }
            });
        }
        function aaa(){
            var bb = document.getElementById("calc").value;
            var c = Math.round(eval(bb));
                document.getElementById("harga").value = eval(c);
                document.getElementById("hargabulat").value = eval(c);
        }
        function openkalkulator(){
            var btnkal = document.getElementById("kalkulator");
            if(btnkal.checked == true){
                document.getElementById("cont-calculator-PO").style.display = "block";
            }else{
                document.getElementById("cont-calculator-PO").style.display = "none";
                document.getElementById("qtyproduk").value = 0;
                document.getElementById("subtotalpo").value = 0;
                document.getElementById("totalpo").value = 0;
            }
        }
        var dropdown = document.getElementsByClassName("dropdown-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
        } else {
        dropdownContent.style.display = "block";
        }
        });
        }
        var dropdown = document.getElementsByClassName("cont-dp-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
        } else {
        dropdownContent.style.display = "block";
        }
        });
        }
        var modal = document.getElementById("myModal");
        var btn = document.getElementById("myBtn");
        var span = document.getElementsByClassName("closee")[0];
        btn.onclick = function() {
        modal.style.display = "block";
        }
        span.onclick = function() {
        modal.style.display = "none";
        }
        window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        }
        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })
    </script>
</html>
