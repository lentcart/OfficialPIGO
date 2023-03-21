<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../admin/")
    
    end if
    
    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING
    InvoiceVendor_CMD.commandText = "SELECT MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Desc, MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_T_InvoiceVendor_H.InvAP_Faktur, MKT_T_InvoiceVendor_H.InvAP_TglFaktur,  MKT_T_InvoiceVendor_H.InvAP_GrandTotal, MKT_T_InvoiceVendor_H.InvAP_prYN FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_M_Customer.custID = MKT_T_InvoiceVendor_H.InvAP_custID ORDER BY InvAP_UpdateTime DESC"
    set InvoiceVendor = InvoiceVendor_CMD.execute
%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--#include file="../../IconPIGO.asp"-->

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        
    </head>
    <script>
        function getbussinespart(){
            var Bussines = $('input[name=keysearch]').val();            
            $.ajax({
                type: "get",
                url: "get-bussinespart.asp?keysearch="+Bussines,
                success: function (url) {
                // console.log(url);
                $('.cont-bussinespart').html(url);
                }
            });
        }

        function gettanggal(){
            $.ajax({
                type:"GET",
                url: "get-ListInvoice.asp?InvAP_TanggalAwal="+document.getElementById("tgla").value+"&InvAP_TanggalAkhir="+document.getElementById("tgle").value+"&InvAPID="+document.getElementById("InvAPID").value,
                success: function (url) {
                    $('.datatr').html(url);
                    console.log(url);
                }
            });
        }
        function hapus(id){
            console.log(id);
            $.ajax({
                type:"GET",
                url: "delete-Invoice.asp",
                data:{
                    InvAPID : id
                },
                success: function (data) {
                    Swal.fire('Data Berhasil Dihapus !', data.message, 'success').then(() => {
                        location.reload();
                    });
                }
            });
        }
    </script>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <span class="cont-text"> INVOICE (VENDOR) </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12 text-end">
                        <button onclick="Refresh()" class="cont-btn" > <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12 text-end">
                        <button onclick="window.open('../Invoice-AP/','_Self')" class="cont-btn" > INVOICE BARU </button>
                    </div>
                </div>
            </div>
            <div class="cont-background mt-2">
                <div class="row align-items-center">
                    <div class="col-lg-5 col-md-5 col-sm-12">
                        <span class="cont-text me-4"> Cari Berdasarkan No Tukar Faktur / Surat Jalan</span><br>
                        <input onkeyup="gettanggal()" class=" mb-2 cont-form" type="search" name="InvAPID" id="InvAPID" value="PIGO/APINV/"> 
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button class="cont-btn mt-3"> Cari</button>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <span class="cont-text me-4"> Periode </span><br>
                        <input onchange="gettanggal()" class="text-center mb-2 cont-form" type="date" name="tgla" id="tgla" value="" >
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <br>
                        <input onchange="gettanggal()" class="text-center mb-2 cont-form" type="date" name="tgle" id="tgle" value="" >
                    </div>
                </div>
            </div>
            <div class="row mt-1 p-1">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="cont-tb" style="overflow:scroll;">
                        <table class="tb-dashboard cont-tb align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="width:100%">
                            <thead>
                                <tr class="text-center">
                                    <th> NO </th>
                                    <th> TANGGAL </th>
                                    <th> INVOCE ID </th>
                                    <th> NO SURAT JALAN </th>
                                    <th> BUSSINES PARTNER </th>
                                    <th> KETERANGAN </th>
                                    <th> TOTAL </th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                                <% 
                                    no = 0 
                                    do while not InvoiceVendor.eof 
                                    no = no + 1
                                %>
                                <%
                                
                                    InvoiceVendor_CMD.commandText = "SELECT ISNULL(COUNT(MKT_T_InvoiceVendor_D1.InvAP_DLine),0) AS Line FROM MKT_T_InvoiceVendor_D1 RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_InvoiceVendor_D1.InvAP_DLine = MKT_T_InvoiceVendor_D.InvAP_Line RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID WHERE MKT_T_InvoiceVendor_H.InvAPID = '"& InvoiceVendor("InvAPID") &"' "
                                    set LineINVAP = InvoiceVendor_CMD.execute

                                %>
                                <% If LineINVAP("Line") = "0" then %>
                                    <tr style="background-color:#d9d5d5; color:#940005">    
                                        <td class="text-center"><%=no%></td>
                                        <td class="text-center">
                                            <%=day(CDate(InvoiceVendor("InvAP_Tanggal")))%>-<%=Month(CDate(InvoiceVendor("InvAP_Tanggal")))%>-<%=Year(CDate(InvoiceVendor("InvAP_Tanggal")))%>
                                        </td>
                                        <td class="text-center">
                                            <button class="cont-btn" style="background-color:#eee; color:#940005" > <%=InvoiceVendor("InvAPID")%> </button>
                                            <input type="hidden" name="InvAPID" id="InvAPID<%=no%>" value="<%=InvoiceVendor("InvAPID")%>" >
                                            <input type="hidden" name="InvAPID_Tanggal" id="InvAPID_Tanggal<%=no%>" value="<%=InvoiceVendor("InvAP_Tanggal")%>">
                                        </td>
                                        <td class="text-center" colspan="4">
                                            <button class="cont-btn"  style="width:max-content;background-color:#eee; color:#940005"> TIDAK LENGKAP </button> &nbsp;
                                            <button class="cont-btn" onclick="hapus('<%=InvoiceVendor("InvAPID")%>')" style="width:max-content;background-color:#eee; color:#940005"> DELETE </button>
                                        </td>
                                    </tr>
                                <% else %>
                                    <tr>    
                                        <td class="text-center"><%=no%></td>
                                        <td class="text-center">
                                            <%=day(CDate(InvoiceVendor("InvAP_Tanggal")))%>-<%=Month(CDate(InvoiceVendor("InvAP_Tanggal")))%>-<%=Year(CDate(InvoiceVendor("InvAP_Tanggal")))%>
                                        </td>
                                        <td class="text-center">
                                            <button class="cont-btn" onclick="window.open('PaymentRequest.asp?InvAPID='+document.getElementById('InvAPID<%=no%>').value+'&InvAP_Tanggal='+document.getElementById('InvAPID_Tanggal<%=no%>').value)"> <%=InvoiceVendor("InvAPID")%> </button>

                                            <input type="hidden" name="InvAPID" id="InvAPID<%=no%>" value="<%=InvoiceVendor("InvAPID")%>" >
                                            <input type="hidden" name="InvAPID_Tanggal" id="InvAPID_Tanggal<%=no%>" value="<%=InvoiceVendor("InvAP_Tanggal")%>">
                                        </td>
                                        <td class="text-center"><%=InvoiceVendor("InvAP_Faktur")%></td>
                                        <td><%=InvoiceVendor("custNama")%></td>
                                        <td><%=InvoiceVendor("InvAP_Desc")%></td>
                                        <td class="text-end">
                                            <%=Replace(Replace(Replace(FormatCurrency(InvoiceVendor("InvAP_GrandTotal")),"$","Rp. "),".00",""),",",".")%>
                                        </td>
                                    </tr>
                                <% end if %>
                                <% 
                                    InvoiceVendor.movenext
                                    loop 
                                %>
                            </tbody>
                        </table>
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
            var flag                = $('input[name=flag]').val();
            if (InvAP_Tanggal == "" ){
                $('.InvAP_Tanggal').focus();
            }else if (InvAP_Faktur == ""){
                $('.InvAP_Faktur').focus();
            }else if ( InvAP_TglFaktur == "" ){
                $('.InvAP_TglFaktur').focus();
            }else if (InvAP_Desc == ""){
                $('.InvAP_Desc').focus();
            }else if (InvAP_custID == "" ){
                $('.InvAP_custID').focus();
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
        }

        function batal() {
        var InvAPID = $('input[name=InvAPID]').val();
        $.ajax({
            type: "GET",
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