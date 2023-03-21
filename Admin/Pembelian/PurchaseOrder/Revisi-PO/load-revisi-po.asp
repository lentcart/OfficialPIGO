<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    poID = request.queryString("poID")

    set BussinesPartner = server.createObject("ADODB.COMMAND")
	BussinesPartner.activeConnection = MM_PIGO_String

        BussinesPartner.commandText = "SELECT MKT_T_PurchaseOrder_H.poID ,  MKT_T_PurchaseOrder_H.poAktifYN, MKT_T_PurchaseOrder_H.po_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custFax, MKT_M_Customer.custNpwp,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Customer.custPhoneCP, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almLengkap,  GLB_M_Bank.BankName, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.poTglOrder, MKT_T_PurchaseOrder_H.poTglDiterima, MKT_T_PurchaseOrder_H.poStatusKredit FROM GLB_M_Bank RIGHT OUTER JOIN MKT_M_Rekening ON GLB_M_Bank.BankID = MKT_M_Rekening.rkBankID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Rekening.rk_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE MKT_T_PurchaseOrder_H.poID = '"& poID &"' AND  MKT_M_Alamat.almJenis <> 'Alamat Toko' AND MKT_M_Rekening.rkJenis = 'Rekening Customer' GROUP BY MKT_T_PurchaseOrder_H.po_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custFax, MKT_M_Customer.custNpwp,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Customer.custPhoneCP, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almLengkap,  GLB_M_Bank.BankName, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik,MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.poTglOrder, MKT_T_PurchaseOrder_H.poTglDiterima, MKT_T_PurchaseOrder_H.poStatusKredit,MKT_T_PurchaseOrder_H.poID,MKT_T_PurchaseOrder_H.poAktifYN "
        'response.write Produk_cmd.commandText

    set BussinesPartner = BussinesPartner.execute

    set produk = server.createObject("ADODB.COMMAND")
	produk.activeConnection = MM_PIGO_String


%>
<!doctype html>
<html lang="en"><!doctype html>
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
    </head>
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
    <!--#include file="../../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../../sidebar.asp"-->
        <form action="add-revisi.asp" method="post">
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-10 col-md-10 col-sm-12">
                        <span class="cont-text"> REVISI PURCHASE ORDER </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button class="cont-btn" onclick="window.open('../../PurchaseOrderDetail/','_Self')"> Kembali </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <span class="cont-text" style="font-size:15px"><b> <%=BussinesPartner("custNama")%> </b></span><br>
                        <span class="cont-text"> <%=BussinesPartner("custEmail")%> </span>/<span class="cont-text"> <%=BussinesPartner("custPhone1")%></span><br>
                        <span class="cont-text"> <%=BussinesPartner("almLengkap")%> </span>,<span class="cont-text"> <%=BussinesPartner("almKota")%> -  <%=BussinesPartner("almProvinsi")%>  </span><br>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <span class="cont-text"> Detail PurchaseOrder </span>
                        <input type="hidden" class="text-center" name="poID" id="poID" value="<%=BussinesPartner("poID")%>">
                        <input type="hidden" class="text-center" name="po_spID" id="po_spID" value="<%=BussinesPartner("po_custID")%>">
                        <div class="cont-tb " style="overflow:scroll">
                            <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px; width:65.5rem">
                                <tr class="text-center">
                                    <th>Purchase Order ID</th>
                                    <th>Tanggal</th>
                                    <th>Jenis Order</th>
                                    <th>Status Kredit</th>
                                    <th>Tanggal Order</th>
                                    <th>Tanggal Perkiraan</th>
                                </tr>
                                <tr class="text-center">
                                    <td><%=BussinesPartner("poID")%></td>
                                    <td>
                                        <input class="text-center cont-form" name="poTanggal" id="poTanggal" type="date" value="<%=BussinesPartner("poTanggal")%>" style="width:8rem">
                                    </td>

                                    <% if BussinesPartner("poJenisOrder") = "1" then %>
                                    <td> Slow Moving 
                                        <input class="text-center cont-form" name="poJenisOrder" id="poJenisOrder" type="hidden" value="<%=BussinesPartner("poJenisOrder")%>" style="width:8rem">
                                    </td>
                                    <% else %>
                                    <td> Fast Moving 
                                        <input class="text-center cont-form" name="poJenisOrder" id="poJenisOrder" type="hidden" value="<%=BussinesPartner("poJenisOrder")%>" style="width:8rem">
                                        </td>
                                    <% end if %>

                                    <% if BussinesPartner("poStatusKredit") = "01" then %>
                                    <td> Kredit 
                                        <input class="text-center cont-form" name="poStatusKredit" id="poStatusKredit" type="hidden" value="<%=BussinesPartner("poStatusKredit")%>" style="width:8rem">
                                    </td>
                                    <% else %>
                                    <td> Cash 
                                        <input class="text-center cont-form" name="poStatusKredit" id="poStatusKredit" type="hidden" value="<%=BussinesPartner("poStatusKredit")%>" style="width:8rem">
                                    </td>
                                    <% end if %>

                                    <td>
                                        <input class="text-center cont-form" name="poTglOrder" id="poTglOrder" type="date" value="<%=BussinesPartner("poTglOrder")%>" style="width:8rem">
                                    </td>

                                    <td>
                                        <input class="text-center cont-form" name="poTglDiterima" id="poTglDiterima" type="date" value="<%=BussinesPartner("poTglDiterima")%>" style="width:8rem">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col-2">
                        <span class="cont-text"> Keterangan Revisi PO : </span>
                    </div>
                    <div class="col-4">
                        <select  class=" opsivendor cont-form" name="po_keterangan" id="po_keterangan" aria-label="Default select example" required>
                            <option value="">Pilih</option>
                            <option value="EMPST">Stok Produk Tidak Tersedia</option>
                            <option value="ADDPR">Penambahan Produk Baru</option>
                            <option value="REDPR">Pengurangan Produk Baru</option>
                            <option value="CHQTY">Perubahan QTY Produk</option>
                            <option value="CHPRI">Perubahan Harga Produk</option>
                            <option value="ETC">Lainnya</option>
                        </select>
                    </div>
                </div>
                <div class="cont-terbaru" id="cont-terbaru">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6">
                        <% if BussinesPartner("poAktifYN") = "Y" then %>
                            <input type="submit" value="Revisi Purchase Order" class="cont-btn">
                        <% else %>
                            <span> PO Sudah Di Revisi </span>
                        <% end if %>
                        </div>
                    </div>
                </div>

                <div class="row mt-2" id="cont-revisipo">

                </div>
                <div class="btn-simpanperubahan mt-3" id="btn-simpanperubahan" style="display:none">
                    <div class="row mt-2">
                        <div class="col-6 text-start" >
                            
                        </div>
                        <div class="col-6 text-end" >
                            <button onclick="Refresh()" class="cont-btn" style="width:10rem"> Batal </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>
    <!--#include file="../../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script> 
    <script>
        function addrevisi(){
            poID                = document.getElementById("poID").value;
            poTanggal           = document.getElementById("poTanggal").value;
            poJenisOrder        = document.getElementById("poJenisOrder").value;
            poTglOrder          = document.getElementById("poTglOrder").value;
            poTglDiterima       = document.getElementById("poTglDiterima").value;
            poStatusKredit      = document.getElementById("poStatusKredit").value;
            po_spID             = document.getElementById("po_spID").value;
            po_keterangan       = document.getElementById("po_keterangan").value;
            
            $.ajax({
                type: "POST",
                url: "add-revisi.asp",
                data : {
                    poID,
                    poTanggal,
                    poJenisOrder,
                    poTglOrder,
                    poTglDiterima,
                    poStatusKredit,
                    po_spID,
                    po_keterangan
                },
                success: function (url) {
                    // document.getElementById("cont-detailpo").style.display = "block" ;
                }
            });
        }

        function canclerevisi(){
            poIDLama = document.getElementById("poID").value;
            poIDBaru = document.getElementById("idterbaru").value;
            $.ajax({
                type: "GET",
                url: "cancle-revisi.asp",
                data : {
                    poIDLama,
                    poIDBaru
                },
                success: function (data) {
                    location.reload();
                }
            });
        }

        function updateproduk(){
            var poID = document.getElementById("idterbaru").value;
            var pdID = document.getElementById("produkid").value;
            var poQtyProduk = document.getElementById("qtyproduk").value;
            var poHargaSatuan = document.getElementById("harga").value;
            var poPajak = document.getElementById("ppn").value;
            var poSubTotal = document.getElementById("subtotalpo").value;
            var poTotal = document.getElementById("totalpo").value;
            $.ajax({
                type: "GET",
                url: "update-produk.asp",
                data : {
                    poID,
                    pdID,
                    poQtyProduk,
                    poHargaSatuan,
                    poPajak,
                    poSubTotal,
                    poTotal
                },
                success: function (url) {
                    $('#cont-revisipo').html(url);
                    document.getElementById("btn-simpanperubahan").style.display = "none";
                    document.getElementById("btn-cancle").style.display = "none";
                }
            });
        }
    </script>   
</html>