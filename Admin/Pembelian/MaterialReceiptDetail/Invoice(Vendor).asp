<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../admin/")
    
    end if
    
    mmID = request.queryString("mmID")

    set MaterialReceipt_cmd = server.createObject("ADODB.COMMAND")
	MaterialReceipt_cmd.activeConnection = MM_PIGO_String

        MaterialReceipt_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, GLB_M_Bank.BankName, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1,  MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Rekening LEFT OUTER JOIN GLB_M_Bank ON MKT_M_Rekening.rkBankID = GLB_M_Bank.BankID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Rekening.rk_custID = MKT_M_Customer.custID ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID ON MKT_T_MaterialReceipt_H.mm_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 WHERE MKT_T_MaterialReceipt_H.mmID = '"& mmID &"' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, GLB_M_Bank.BankName, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1,  MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik,MKT_M_Customer.custNpwp"
        'response.Write MaterialReceipt_cmd.commandText 
    set MaterialReceipt = MaterialReceipt_cmd.execute
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
    
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-7 col-md-10 col-sm-12">
                        <span class="cont-text"> Invoice (Vendor) </span>
                    </div>
                    <div class="col-lg-1 col-md-2 col-sm-12 text-end">
                        <button onclick="Refresh()" class="cont-btn" style="width:2rem"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12 text-end">
                        <button onclick="window.open('index.asp','_Self')" class="cont-btn" > Kembali </button>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12 text-end">
                        <button onclick="window.open('../../Transaksi/Invoice-AP/Invoice(Vendor).asp','_Self')" class="cont-btn" > List Invoice </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="cont-addinvoice" id="cont-addinvoice" style="display:block">
                        <div class="data-po mt-2">
                            <div class="cont-InvoiceVendor">
                                <div class="row">
                                    <div class="col-lg-2 col-md-3 col-sm-12">
                                        <span class="cont-text"> Tanggal Invoice </span><br>
                                        <input required type="date" class=" text-center cont-form" name="InvAP_Tanggal" id="cont" value="">
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <span class="cont-text"> No Surat Jalan / Faktur Vendor </span><br>
                                        <input required type="text" class=" text-center cont-form" name="InvAP_Faktur" id="cont" value="">
                                    </div>
                                    <div class="col-lg-2 col-md-3 col-sm-12">
                                        <span class="cont-text"> Tanggal Faktur </span><br>
                                        <input required type="Date" class=" text-center cont-form" name="InvAP_TglFaktur" id="cont" value="">
                                    </div>
                                </div>
                                <div class="row align-items-center mt-2">
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <span class="cont-text"> Deksripsi </span>
                                    </div>
                                    <div class="col-lg-10 col-md-10 col-sm-10">
                                        <input required type="text" class="cont-form" name="InvAP_Desc" id="cont" value="" style="height:3rem">
                                    </div>
                                </div>
                                <div class="row mt-1">
                                    <div class="col-lg-2 col-md-6 col-sm-6">
                                        <span class="cont-text"> Kata Kunci </span><br>
                                        <input readonly required type="text" class="cont-form" name="keysearch" id="cont" value=""><br>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-6 cont-bussinespart">
                                    <span class="cont-text">  </span><br>
                                        <select disabled="true" class=" cont-form" name="bussines" id="bussines" aria-label="Default select example" required>
                                        </select>
                                    </div>
                                </div>
                                <div class="cont-bussines">
                                    <div class="row mt-1">
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <span class=" text-center cont-text">  Supplier ID </span><br>
                                            <input readonly type="text" class="cont-form" name="InvAP_custID" id="cont" value="<%=MaterialReceipt("custID")%>" ><br>
                                        </div>
                                        <div class="col-lg-4 col-md-8 col-sm-8">
                                            <span class="cont-text"> Nama Supplier </span><br>
                                            <input readonly type="text" class="cont-form" name="namasupplier" id="namasupplier" value="<%=MaterialReceipt("custNama")%>" ><br>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <span class="cont-text"> Pay-Term </span><br>
                                            <input readonly type="text" class="cont-form" name="poterm" id="poterm" value="<%=MaterialReceipt("custPaymentTerm")%>" ><br>
                                        </div>
                                        <div class="col-lg-4 col-md-8 col-sm-8">
                                            <span class="cont-text"> Nama CP Supplier </span><br>
                                            <input readonly type="text" class="cont-form" name="namacp" id="namacp" value="<%=MaterialReceipt("custNamaCP")%>"><br>
                                        </div>
                                    </div>
                                    <div class="row mt-1">
                                        <div class="col-lg-6 col-md-6 col-sm-12">
                                            <span class="cont-text"> Lokasi Supplier </span><br>
                                            <input readonly type="text" class="cont-form" name="lokasi" id="lokasi" value="<%=MaterialReceipt("almLengkap")%>" ><br>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-4">
                                            <span class="cont-text"> Phone </span><br>
                                            <input readonly type="text" class="cont-form" name="phone" id="phone" value="<%=MaterialReceipt("custPhone1")%>" ><br>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-4">
                                            <span class="cont-text"> Email </span><br>
                                            <input readonly type="text" class="cont-form" name="email" id="email" value="<%=MaterialReceipt("custEmail")%>" ><br>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-4">
                                            <span class="cont-text"> NPWP </span><br>
                                            <input readonly type="text" class="cont-form" name="npwp" id="npwp" value="<%=MaterialReceipt("custNpwp")%>" ><br>
                                        </div>
                                    </div>
                                    <div class="row align-items-center">
                                        <div class="col-lg-2 col-md-2 col-sm-12">
                                            <span class="cont-text"></span><br>
                                            <input type="checkbox" id="kalkulator">
                                            <label class="side-toggle" for="kalkulator"> <span class="cont-text"> Line From </span></label>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-6">
                                            <span class="cont-text">  </span><br>
                                            <input readonly class="cont-form"type="" value="">
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-6">
                                            <span class="cont-text">  </span><br>
                                            <input readonly class="cont-form"type="" value="<%=MaterialReceipt("mmID")%>/<%=CDate(MaterialReceipt("mmTanggal"))%>">
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-12 text-end">
                                            <span class="cont-text">  </span><br>
                                            <button onclick="addInvoiceH()" name="add" id="add"class="cont-btn" style=" display:block"> <i class="fas fa-plus"></i> &nbsp; Add Invoice Line</button>
                                            <button onclick="batal()" name="batal" id="batal" class="cont-btn" style=" display:none"> <i class="fas fa-ban"></i> &nbsp; Batalkan Proses </button>
                                        </div>
                                    </div>
                                    <div class="row" style="display:none">
                                        <div class="col-lg-2 col-md-2 col-sm-6">
                                            <span> Line From </span>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6 cont-Lines">
                                            <input readonly class="cont-form" type="text" name="InvAP_LineFrom" id="InvAP_LineFrom" value="<%=MaterialReceipt("mmID")%>" style="width:42.5rem">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="cont-InvoiceHeader" id="cont-InvoiceHeader">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>
        function addInvoiceH() {
            var InvAP_Tanggal       = $('input[name=InvAP_Tanggal]').val();
            var InvAP_Faktur        = $('input[name=InvAP_Faktur]').val();
            var InvAP_TglFaktur     = $('input[name=InvAP_TglFaktur]').val();
            var InvAP_Desc          = $('input[name=InvAP_Desc]').val();
            var InvAP_custID        = $('input[name=InvAP_custID]').val();
            var InvAP_LineFrom      = $('input[name=InvAP_LineFrom]').val();
            if (InvAP_Tanggal == "" , InvAP_Faktur == "", InvAP_TglFaktur == "" , InvAP_Desc == "" ) {
                Swal.fire({
                    icon: 'error',
                    text: 'Ada Field Yang Masih Kosong !',
                    })
            }else{
                $.ajax({
                    type: "GET",
                    url: "add-InvoiceH.asp",
                    data:{
                        InvAP_Tanggal,
                        InvAP_Faktur,
                        InvAP_TglFaktur,
                        InvAP_Desc,
                        InvAP_custID,
                        InvAP_LineFrom
                    },
                    success: function (data) {
                        $('.cont-InvoiceHeader').html(data);
                    }
                });
            document.getElementById("add").style.display = "none"
            document.getElementById("batal").style.display = "block"
            }
        }
        function batal() {
        var InvAPID = $('input[name=InvAPID]').val();
        $.ajax({
            type: "POST",
            url: "../../Transaksi/Invoice-AP/delete-InvoiceH.asp",
                data:{
                    InvAPID
                },
            success: function (data) {
                Swal.fire('Data Berhasil Di Hapus !', data.message, 'success').then(() => {
                    location.reload();
                });
            }
        });
    }
    function addInvoiceD() {
        var InvAP_IDH           = $('input[name=InvAPID]').val();
        var InvAP_LineFrom      = $('input[name=InvAP_Line]').val();
        var InvAP_poID           = $('select[name=listpo]').val();
        var InvAP_Keterangan    = $('input[name=InvAP_Keterangan]').val();
        var InvAP_Jumlah        = $('input[name=InvAP_Jumlah]').val();
        var InvAP_Tax           = $('input[name=InvAP_Tax]').val();
        var InvAP_TotalLine     = $('input[name=InvAP_TotalLine]').val();
        
        $.ajax({
            type: "GET",
            url: "add-InvoiceD.asp",
            data:{
                InvAP_IDH,
                InvAP_LineFrom,
                InvAP_poID,
                InvAP_Keterangan,
                InvAP_Jumlah,
                InvAP_Tax,
                InvAP_TotalLine
            },
            success: function (data) {
                $('.cont-InvoiceDetail').html(data);
            }
        });

        document.getElementById("Jumlah").value = "";
        document.getElementById("total").value = "";
        document.getElementById("ppn").value = "";
        document.getElementById("add").style.display = "none"
        document.getElementById("batal").style.display = "none"
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
    </script>
</html>