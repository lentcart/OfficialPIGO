<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    set MaterialReceipt_cmd = server.createObject("ADODB.COMMAND")
	MaterialReceipt_cmd.activeConnection = MM_PIGO_String

        MaterialReceipt_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_T_MaterialReceipt_H.mm_tfYN, MKT_T_MaterialReceipt_H.mm_JR_ID,  MKT_T_MaterialReceipt_H.mm_postingYN FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE (MKT_T_MaterialReceipt_H.mmAktifYN = 'Y') GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_T_MaterialReceipt_H.mm_tfYN, MKT_T_MaterialReceipt_H.mm_JR_ID,  MKT_T_MaterialReceipt_H.mm_postingYN,mmUpdateTime    ORDER BY mmUpdateTime DESC "
        'response.write MaterialReceipt_cmd.commandText 

    set MaterialReceipt = MaterialReceipt_cmd.execute

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
                url: "getdata.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
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
                        <span class="cont-text"> MATERIAL RECEIPT </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn" style="width:1.5rem"> <i class="fas fa-sync-alt"></i> </button>
                        <button class="cont-btn" onclick="window.open('../MaterialReceipt/','_Self')" style="width:7rem"> Tambah Baru </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row align-items-center">
                    <div class="col-lg-8 col-md-5 col-sm-12">
                        <span class="cont-text me-4"> Cari </span><span class="cont-text" style="font-size:10px; color:red"><i>( Silahkan Masukan No Material Receipt ) </i></span><br>
                        <input onkeyup="carimm()" class=" cont-form" type="search" name="carimm" id="carimm" value="PIGO/MM/">
                    </div>
                    <div class="col-lg-3 col-md-5 col-sm-12">
                        <span class="cont-text"> Cetak Receipt</span><br>
                        <select onchange="cetakmm()" name="mmID" id="mmID" class=" cont-form" aria-label="Default select example" >
                            <option value="">Pilih Material Receipt </option>
                            <% if DataMM.eof = true then %>
                            <option value=""> Belum Ada Material Receipt Baru </option>
                            <% else %>
                            <% do while not DataMM.eof %>
                            <option value="<%=DataMM("mmID")%>"><%=DataMM("mmID")%>,<%=DataMM("mmTanggal")%></option>
                            <% DataMM.movenext
                            loop%>
                            <% end if %>
                        </select>
                    </div>
                    <div class="col-lg-1 col-md-2 col-sm-12">
                        <span class="cont-text"></span><br>
                        <button class="cont-btn"   >Cetak </button>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <span class="cont-text me-4"> Periode Material Receipt </span><br>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <input onchange="gettanggal()" class="text-center mb-2 cont-form" type="date" name="tgla" id="tgla" value="" >
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <input onchange="gettanggal()" class="text-center mb-2 cont-form" type="date" name="tgle" id="tgle" value="" >
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <div class="dropdown">
                            <button class="cont-btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                Download Laporan 
                            </button>
                            <ul class="dropdown-menu text-center cont-btn" aria-labelledby="dropdownMenuButton1">
                                <li>
                                    <button class="cont-btn" onclick="window.open('lapmmpdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value)">Laporan PDF</button>
                                </li>
                                <li>
                                    <button class=" mt-2 cont-btn" onclick="window.open('lapmm-exc.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value)"> Laporan Excel </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8 col-md-6 col-sm-6 text-end">
                        <span class="cont-text">  </span>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-3 text-end">
                        <span class="cont-text" style="font-size:11px"><b><i> Sudah Tukar Faktur : <i class="fas fa-check-circle" style="color:#24cf24"></i> </i></b></span>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-3 text-end">
                        <span class="cont-text" style="font-size:11px"><b><i> Belum Tukar Faktur :  <i class="fas fa-ban" style="color:red"></i> </i> </i></b></span>
                    </div>
                </div>
            </div>
            
            <div class="row p-1">
                <div class="col-12">
                    <div class="cont-tb" style="overflow:scroll;height:26.5rem">
                            <table class="tb-dashboard cont-tb align-items-center table tb-transaksi table-bordered table-condensed mt-1">
                                <thead class="tb-dashboard">
                                    <tr class="text-center">
                                        <th>NO</th>
                                        <th>MATERIAL RECEIPT ID </th>
                                        <th>TANGGAL</th>
                                        <th>SUPPLIER</th>
                                        <th>STATUS (TF)</th>
                                        <th colspan="2">POST-JURNAL</th>
                                    </tr>
                                </thead>
                                <tbody class="datatr">
                                <% 
                                    no = 0
                                    do while not MaterialReceipt.eof 
                                    no = no + 1
                                %>
                                    <tr>
                                        <td class="text-center"><%=no%></td>
                                        <%
                                            DataMM_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, ISNULL(MKT_T_MaterialReceipt_D1.mm_poID,0) AS PO, ISNULL(MKT_T_MaterialReceipt_D2.mm_pdID,0) AS PD FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 Where mmID = '"& MaterialReceipt("mmID") &"' "                    
                                            'response.write  DataMM_cmd.commandText
                                            set MR = DataMM_cmd.execute
                                        
                                        %>
                                        <% If MR("PO") = "0" then %>
                                            <td class="text-center" style="color:red"><%=MaterialReceipt("mmID")%></td>
                                                <input type="hidden" name="tanggalmm" id="tanggalmm" value="<%=MaterialReceipt("mmTanggal")%>">
                                                <input type="hidden" name="mmid" id="mmid<%=no%>" value="<%=MaterialReceipt("mmID")%>">
                                            <td class="text-center"style="color:red">
                                                <%=day(Cdate(MaterialReceipt("mmTanggal")))%>/<%=Month(MaterialReceipt("mmTanggal"))%>/<%=Year(MaterialReceipt("mmTanggal"))%>
                                            </td>
                                            <td style="color:red"><%=MaterialReceipt("custNama")%></td>
                                            <td class="text-center" style="color:red"> - </td>
                                            <td class="text-center"><button class="cont-btn" onclick="hapus<%=no%>()"><i class="fas fa-trash"></i> DELETE </button> </td>
                                        <% else %>
                                            <td class="text-center">
                                                <input type="hidden" name="mmid" id="mmid<%=no%>" value="<%=MaterialReceipt("mmID")%>">
                                                <input type="hidden" name="tanggalmm" id="tanggalmm<%=no%>" value="<%=MaterialReceipt("mmTanggal")%>">
                                                <button class="cont-btn" onclick="window.open('buktimm.asp?mmID='+document.getElementById('mmid<%=no%>').value)" > <i class="fas fa-print"></i> <%=MaterialReceipt("mmID")%> </button>
                                            </td>
                                            <td class="text-center">
                                                <%=day(Cdate(MaterialReceipt("mmTanggal")))%>/<%=Month(MaterialReceipt("mmTanggal"))%>/<%=Year(MaterialReceipt("mmTanggal"))%>
                                            </td>
                                            <td><%=MaterialReceipt("custNama")%></td>
                                            <% if MaterialReceipt("mm_tfYN") = "N" then%>
                                                <td class="text-center" style="color:red"> <i class="fas fa-ban"></i> </td>
                                            <% else %>
                                                <td class="text-center" style="color:green"> <i class="fas fa-check"></i> </td>
                                            <% end if %>
                                            <td class="text-center"> 
                                                <%=MaterialReceipt("mm_postingYN")%>
                                                <input type="hidden" name="JRD_ID" id="JRD_ID<%=no%>" value="<%=MaterialReceipt("mm_JR_ID")%>">
                                            </td>
                                            <% if MaterialReceipt("mm_postingYN") = "N" then %>
                                            <td class="text-center"> 
                                                <button class="cont-btn" onclick="window.open('posting-jurnal.asp?mmID='+document.getElementById('mmid<%=no%>').value)"> POSTING JURNAL </button> 
                                            </td>
                                            <% else %>
                                            <td class="text-center"> 
                                                <button class="cont-btn" onclick="window.open('../../GL/GL-Jurnal/jurnal-voucher.asp?JR_ID='+document.getElementById('JRD_ID<%=no%>').value)"> <i class="fas fa-print"></i> <%=MaterialReceipt("mm_JR_ID")%> </button> 
                                            </td>
                                            <% end if %>
                                        <% end if %>
                                        <script>
                                            function hapus<%=no%>() {
                                                var mmID = document.getElementById("mmid<%=no%>").value;
                                                console.log(mmID);
                                                $.ajax({
                                                    type: "GET",
                                                    url: "../MaterialReceipt/delete-materialreceipt.asp",
                                                        data:{
                                                            mmID
                                                        },
                                                    success: function (data) {
                                                        console.log(data);
                                                        // Swal.fire('Deleted !!', data.message, 'success').then(() => {
                                                        // location.reload();
                                                        // });
                                                    }
                                                });
                                            }
                                        </script>
                                    <tr>
                                <%  
                                    MaterialReceipt.movenext
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