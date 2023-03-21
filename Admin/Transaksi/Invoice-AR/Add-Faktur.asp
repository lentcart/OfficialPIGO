<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    SJID = request.queryString("SJID")

    set PSCB_cmd =  server.createObject("ADODB.COMMAND")
    PSCB_cmd.activeConnection = MM_PIGO_String

    PSCB_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi,  MKT_M_Alamat.almLengkap, MKT_M_Alamat.almKota, MKT_T_PengeluaranSC_H.pscSubtotal, MKT_T_PengeluaranSC_H.pscType FROM MKT_T_SuratJalan_H LEFT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID ON MKT_T_PengeluaranSC_H.psc_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D.pscIDH WHERE MKT_T_SuratJalan_H.SJID = '"& SJID &"' GROUP BY MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1,  MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almProvinsi,  MKT_M_Alamat.almKota, MKT_T_PengeluaranSC_H.pscSubtotal, MKT_T_PengeluaranSC_H.pscType"
    'response.write PSCB_cmd.commandText
    set PSCB = PSCB_CMD.execute
    
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
    <script>
        function tax(){
            var tax = document.getElementById("ppn").value;
            var totaline = parseInt(document.getElementById("totalline").value);
            var grandtotal = parseInt(document.getElementById("grandtotal").value);
            // console.log(tax);
            
            if( tax == "0" ){
                document.getElementById("grandtotal").value = totaline
                // console.log(grandtotal);
                
            }else{
                tax = 11;
                var pajak = tax/100*totaline;
                subtotal = totaline+pajak;
                document.getElementById("grandtotal").value = subtotal;
                // console.log(subtotal);
                
            }
        }

    </script>
    <style>
        #loader-page {
        width: 100%;
        height:  100%;
        position: fixed;
        background-color:rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        z-index: 9999;
        top:0px;
        }

        #loader {
            width: 42px;
            height: 42px;
            border-right: 5px solid #10a5d3;
            border-left: 5px solid rgba(150, 169, 169, 0.32);
            border-top: 5px solid rgba(169, 169, 169, 0.32);
            border-bottom: 5px solid rgba(169, 169, 169, 0.32);
            border-radius: 50%;
            opacity: .6;
            animation: spin 1s linear infinite;
        }
        .cont-loader{
            background-color:#10a5d3;
            width:10%;
            border-radius:20px;
            color:white;
            font-size:15px;
            font-weight:bold;
            margin-top : 10px;

        }

        @keyframes spin {
        
            0% {
                transform: rotate(0deg);
            }
            
            100% {
                transform: rotate(360deg);
            }
            
        }
    </style>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row align-items-center">
                    <div class="col-11">
                        <span class="cont-text"> FAKTUR PENJUALAN </span>
                    </div>
                    <div class="col-1">
                        <button onclick="Refresh()" class="cont-btn cont-text"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <form class="" action="P-FakturPenjualan.asp" method="POST">
                <div class="row">
                    <div class="col-lg-2 col-md-3 col-sm-12">
                        <span class="cont-text"> Tangal Invoice </span><br>
                        <input required type="date" class="cont-form" name="InvARTanggal" id="InvARTanggal" value=""><br>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12">
                        <span class="cont-text"> Payment Term </span><br>
                        <input required type="number" class="text-center cont-form" name="InvARPayTerm" id="InvARPayTerm" value=""><br>
                    </div>
                    <div class="col-lg-8 col-md-6 col-sm-12">
                        <span class="cont-text"> Deskripsi </span><br>
                        <input required type="text" class="cont-form" name="InvARDesc" id="InvARDesc" value=""><br>
                    </div>
                </div>
                <div class="row mt-3 mb-3 text-center">
                    <div class="col-12">
                        <div class="cont-label-text">
                        <span class="label-sp cont-text"> No Order <i>( Pengeluaran Suku Cadang Baru / Permintaan Barang )</i> </span>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-lg-2 col-md-3 col-sm-1 col-3">
                        <span class="cont-text"> Tanggal Order </span><br>
                        <input readonly type="text" class="text-center cont-form" name="pscTanggal" id="pscTanggal" value="<%=Day(CDate(PSCB("pscTanggal")))%>/<%=Month(CDate(PSCB("pscTanggal")))%>/<%=Year(CDate(PSCB("pscTanggal")))%>"><br>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-1 col-6">
                        <span class="cont-text"> No PSCB </span><br>
                        <input readonly type="text" class="text-center cont-form" name="InvAR_pscID" id="InvAR_pscID" value="<%=PSCB("pscID")%>"><br>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-1 col-6">
                        <span class="cont-text"> No Surat Jalan </span><br>
                        <input readonly type="text" class="text-center cont-form" name="InvAR_SJID" id="InvAR_SJID" value="<%=SJID%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-2 col-md-3 col-sm-1 col-4">
                        <span class="cont-text"> Nama Customer  </span><br>
                        <input readonly type="text" class="cont-form" name="custNama" id="custNama" value="<%=PSCB("custNama")%>">
                        <input readonly type="hidden" class="cont-form" name="InvAR_custID" id="InvAR_custID" value="<%=PSCB("custID")%>"><br>
                    </div>
                    <div class="col-lg-8 col-md-3 col-sm-1 col-4">
                        <span class="cont-text"> Alamat  </span><br>
                        <input readonly type="text" class="cont-form" name="custAlamat" id="custAlamat" value="<%=PSCB("almLengkap")%> - <%=PSCB("almProvinsi")%>"><br>
                    </div>
                    <%
                        PSCB_cmd.commandText = "SELECT MKT_T_SuratJalan_D.SJID_pdID, MKT_T_SuratJalan_D.SJIDD_pdHargaJual, MKT_T_SuratJalan_D.SJID_pdQty, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax FROM MKT_T_SuratJalan_H LEFT OUTER JOIN MKT_T_SuratJalan_D ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH,18) LEFT OUTER JOIN MKT_T_PengeluaranSC_D RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D.pscIDH = MKT_T_PengeluaranSC_H.pscID ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID WHERE MKT_T_SuratJalan_H.SJID = '"& SJID &"'"
                        'response.write PSCB_cmd.commandText
                        set Produk = PSCB_CMD.execute
                    %>
                    <%  do while not Produk.eof %>
                        <%
                            Qty         = Produk("SJID_pdQty")
                            Harga       = Produk("SJIDD_pdHargaJual")
                            PPN         = Produk("SJID_pdTax")
                            UPTO        = Produk("SJID_pdUpto")

                            Total       = Qty*Harga
                            ReturnPPN   = Total+(Total*PPN/100)
                            ReturnUPTO  = ReturnPPN*UPTO/100
                            SubTotal    = ReturnPPN+ReturnUPTO

                            GrandTotal = GrandTotal + SubTotal 
                            SubTotal = 0
                        %>
                    <%  Produk.movenext
                        loop %>
                    <div class="col-lg-2 col-md-3 col-sm-1 col-4">
                        <span class="cont-text"> Total Line </span><br>
                        <input readonly type="hidden" class="cont-form" name="InvARTotalLine" id="InvARTotalLine" value="<%=GrandTotal%>">
                        <input readonly type="text" class="text-center cont-form" name="total" id="total" value="<%=Replace(Replace(FormatCurrency(GrandTotal),"$","Rp. "),".00","")%>"><br>
                    </div>
                </div>
                <div class="cont-simpan mt-3">
                    <div class="row">
                        <div class="col-12">
                            <input type="submit" class="cont-btn" name="simpan" id="simpan" value="Simpan" style="background-color:#ddd;color:black">
                        </div>
                    </div>
                </div>
                </form>
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
            var flag                = $('input[name=flag]').val();
            
            $.ajax({
                type: "GET",
                url: "add-InvoiceH.asp",
                data:{
                    InvAP_Tanggal,
                    InvAP_Faktur,
                    InvAP_TglFaktur,
                    InvAP_Desc,
                    InvAP_custID,
                    InvAP_LineFrom,
                    flag
                },
                success: function (data) {
                    $('.cont-InvoiceHeader').html(data);
                }
            });
            document.getElementById("add").style.display = "none"
            document.getElementById("batal").style.display = "block"
            $('#bussinespartner').attr('disabled',true);
            $('#bussinespartner').attr('disabled',true);
            var invoice = document.querySelectorAll("[id^=cont]");
            for (let i = 0; i < invoice.length; i++) {
                invoice[i].setAttribute("readonly", true);
                invoice[i].setAttribute("disabled", true);
            }
        }

        function batal() {
        var InvAPID = $('input[name=InvAPID]').val();
        $.ajax({
            type: "POST",
            url: "delete-InvoiceH.asp",
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
    function getPO() {
        var InvAP_poID           = $('select[name=listpo]').val();
        // var InvAP_Keterangan    = $('input[name=InvAP_Keterangan]').val();
        $.ajax({
            type: "GET",
            url: "get-purchaseorder.asp",
            data:{
                InvAP_poID
            },
            success: function (data) {
                $('.cont-Lines').html(data);
            }
        });
    }
    function getMM() {
        var InvAP_mmID           = $('select[name=listmm]').val();
        // var InvAP_Keterangan    = $('input[name=InvAP_Keterangan]').val();
        $.ajax({
            type: "GET",
            url: "get-materialreceipt.asp",
            data:{
                InvAP_mmID
            },
            success: function (data) {
                $('.cont-Lines').html(data);
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