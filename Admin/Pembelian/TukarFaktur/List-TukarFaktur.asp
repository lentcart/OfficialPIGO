<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../")
    
    end if
    
    set TukarFaktur_cmd = server.createObject("ADODB.COMMAND")
	TukarFaktur_cmd.activeConnection = MM_PIGO_String

        TukarFaktur_cmd.commandText = "SELECT MKT_T_TukarFaktur_H.TF_ID, MKT_T_TukarFaktur_H.TF_Tanggal, MKT_T_TukarFaktur_H.TF_FakturPajak, MKT_T_TukarFaktur_H.TF_Invoice,MKT_T_TukarFaktur_H.TF_SuratJalan, MKT_T_TukarFaktur_H.TF_custID, MKT_T_TukarFaktur_H.TF_prYN,  MKT_T_TukarFaktur_H.TF_JR_ID, MKT_T_TukarFaktur_H.TF_postingYN, MKT_M_Customer.custNama FROM MKT_T_TukarFaktur_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_TukarFaktur_H.TF_custID = MKT_M_Customer.custID WHERE TF_AktifYN = 'Y' ORDER BY MKT_T_TukarFaktur_H.TF_Tanggal DESC "
        'response.write TukarFaktur_cmd.commandText 

    set TukarFaktur = TukarFaktur_cmd.execute

    set DataMM_cmd = server.createObject("ADODB.COMMAND")
	DataMM_cmd.activeConnection = MM_PIGO_String

        DataMM_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN  MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN  MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE  MKT_T_MaterialReceipt_H.mm_tfYN= 'N' GROUP BY  MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID "
        'response.write  DataMM_cmd.commandText

    set DataMM = DataMM_cmd.execute

    set StatusPO_cmd = server.createObject("ADODB.COMMAND")
	StatusPO_cmd.activeConnection = MM_PIGO_String

	StatusPO_cmd.commandText = "SELECT MKT_T_PurchaseOrder_D.po_spoID FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN  MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID where MKT_T_PurchaseOrder_D.po_spoID = '1'"
    'response.write StatusPO_cmd.commandText
    set StatusPO = StatusPO_cmd.execute
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
        <script>
            function cetakmm(){
                $.ajax({
                    type: "get",
                    url: "get-datamm.asp?mmiD="+document.getElementById("mmID").value,
                    success: function (url) {
                        $('.datatr').html(url);
                    }
                });
            }
            function carimm(){
                $.ajax({
                    type: "get",
                    url: "load-datamm.asp?carimm="+document.getElementById("carimm").value,
                    success: function (url) {
                        $('.datatr').html(url);
                    }
                });
            }
            function gettanggal(){
                $.ajax({
                    type: "get",
                    url: "get-ListFaktur.asp?TF_TanggalAwal="+document.getElementById("tgla").value+"&TF_TanggalAkhir="+document.getElementById("tgle").value+"&TFID="+document.getElementById("TFID").value,
                    success: function (url) {
                        $('.datatr').html(url);
                        
                    }
                });
            }
            function Refresh(){
                document.getElementById("loader-page").style.display = "block";
                    setTimeout(() => {
                        window.location.reload();
                        document.getElementById("loader-page").style.display = "none";
                    }, 1000);
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
                margin-top : ;

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
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-10 col-md-10 col-sm-12">
                        <span class="cont-text"> LIST TUKAR FAKTUR </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn" style="width:1.5rem"> <i class="fas fa-sync-alt"></i> </button>
                        <button class="cont-btn" onclick="window.open('index.asp','_Self')" style="width:7rem"> TAMBAH BARU </button>
                    </div>
                </div>
            </div>
            <div class="cont-background mt-2">
                <div class="row align-items-center">
                    <div class="col-lg-5 col-md-5 col-sm-12">
                        <span class="cont-text me-4"> Cari Berdasarkan No Tukar Faktur / Tanda Terima</span><br>
                        <input onkeyup="gettanggal()" class=" mb-2 cont-form" type="search" name="TFID" id="TFID" value="PIGO/TF/"> 
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

            <div class="row p-1">
                <div class="col-12">
                    <div class="cont-tb" style="overflow:scroll;">
                        <table class="tb-dashboard cont-tb align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="width:100rem">
                                <thead class="tb-dashboard">
                                    <tr class="text-center">
                                        <th>NO</th>
                                        <th>TANDA TERIMA</th>
                                        <th>INVOICE </th>
                                        <th>FAKTUR PAJAK </th>
                                        <th>SURAT JALAN </th>
                                        <th>TANGGAL</th>
                                        <th>SUPPLIER</th>
                                        <th colspan="2">PAY-REQUEST</th>
                                        <th colspan="2">POST-JURNAL</th>
                                    </tr>
                                </thead>
                                <tbody class="datatr">
                                    <%
                                        no = 0 
                                        do while not TukarFaktur.eof
                                        no = no + 1
                                    %>
                                    <tr>
                                        <td class="text-center"> 
                                            <%=no%> 
                                            <input type="hidden" name="TF_ID" id="TF_ID<%=no%>" value="<%=TukarFaktur("TF_ID")%>">
                                        </td>
                                        <td class="text-center">
                                            <button class="cont-btn" onclick="window.open('Bukti-TandaTerima.asp?TF_ID='+document.getElementById('TF_ID<%=no%>').value)" > <i class="fas fa-print"></i> TD-<%=TukarFaktur("TF_ID")%> </button>
                                        </td>
                                        <td class="text-center"> <%=TukarFaktur("TF_Invoice")%> </td>
                                        <td class="text-center"> <%=TukarFaktur("TF_FakturPajak")%> </td>
                                        <td class="text-center"> <%=TukarFaktur("TF_SuratJalan")%> </td>
                                        <td class="text-center"> <%=CDate(TukarFaktur("TF_Tanggal"))%> </td>
                                        <td> <%=TukarFaktur("custNama")%> </td>
                                        <td class="text-center"> <%=TukarFaktur("TF_prYn")%> </td>
                                            <% if TukarFaktur("TF_prYn") = "N" then %>
                                                <td class="text-center"> 
                                                    <button class="cont-btn" onclick="window.open('Invoice(Vendor).asp?TF_ID='+document.getElementById('TF_ID<%=no%>').value) "style="background-color:red; color:white"> ADD PAY-REQUEST</button> 
                                                </td>
                                            <% else %>
                                                <%
                                                    TukarFaktur_cmd.commandText = "SELECT MKT_T_InvoiceVendor_H.InvAPID, MKT_T_InvoiceVendor_H.InvAP_Tanggal FROM MKT_T_InvoiceVendor_H INNER JOIN MKT_T_TukarFaktur_H ON MKT_T_InvoiceVendor_H.InvAP_Faktur = MKT_T_TukarFaktur_H.TF_SuratJalan Where InvAP_Faktur = '"& TukarFaktur("TF_SuratJalan") &"'  "
                                                    'response.write TukarFaktur_cmd.commandText 
                                                    set PayRequest = TukarFaktur_cmd.execute
                                                %>
                                            <td class="text-center"> 
                                                <input type="hidden" name="InvAPID" id="InvAPID<%=no%>" value="<%=PayRequest("InvAPID")%>">
                                                <input type="hidden" name="InvAP_Tanggal" id="InvAP_Tanggal<%=no%>" value="<%=PayRequest("InvAP_Tanggal")%>">
                                                <button class="cont-btn" style="background-color:green; color:white" onclick="window.open('../../Transaksi/Invoice-AP/PaymentRequest.asp?InvAPID='+document.getElementById('InvAPID<%=no%>').value+'&InvAP_Tanggal='+document.getElementById('InvAP_Tanggal<%=no%>').value)"> <i class="fas fa-print"></i> <%=PayRequest("InvAPID")%> </button> 
                                            </td>
                                            <% end if %>
                                        <td class="text-center"> <%=TukarFaktur("TF_postingYN")%> </td>
                                        <% if TukarFaktur("TF_postingYN") = "N" then%>
                                        <td class="text-center"> 
                                            <button class="cont-btn" onclick="window.open('posting-jurnal.asp?TF_ID='+document.getElementById('TF_ID<%=no%>').value)"> POSTING JURNAL </button> 
                                        </td>
                                        <% else %>
                                        <td class="text-center"> 
                                            <input type="hidden" name="JRD_ID" id="JR_ID<%=no%>" value="<%=TukarFaktur("TF_JR_ID")%>">
                                            <button class="cont-btn" onclick="window.open('../../GL/GL-Jurnal/jurnal-voucher.asp?JR_ID='+document.getElementById('JR_ID<%=no%>').value)"> <i class="fas fa-print"></i> &nbsp; <%=TukarFaktur("TF_JR_ID")%> </button> 
                                        </td>
                                        <% end if%>
                                    </tr>
                                    <%
                                        TukarFaktur.movenext
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