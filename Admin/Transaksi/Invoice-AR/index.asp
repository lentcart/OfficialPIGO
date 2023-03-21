<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    set FakturPenjualan_cmd = server.createObject("ADODB.COMMAND")
	FakturPenjualan_cmd.activeConnection = MM_PIGO_String
        FakturPenjualan_cmd.commandText = "SELECT MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvAR_KWYN,MKT_T_Faktur_Penjualan.InvARTanggal,MKT_T_Faktur_Penjualan.InvAR_PayYN, MKT_T_Faktur_Penjualan.InvARTotalLine, MKT_M_Customer.custNama, MKT_M_Customer.custID,MKT_T_Faktur_Penjualan.InvAR_Status,MKT_T_Faktur_Penjualan.InvAR_Bukti,MKT_T_Faktur_Penjualan.InvAR_PostingYN, MKT_T_Faktur_Penjualan.InvAR_JR_ID FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_M_Customer.custID = MKT_T_PengeluaranSC_H.psc_custID LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D.pscIDH RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_PengeluaranSC_H.pscID = MKT_T_Faktur_Penjualan.InvAR_pscID WHERE MKT_T_Faktur_Penjualan.InvARAKtifYN = 'Y'  GROUP BY MKT_T_Faktur_Penjualan.InvARID, MKT_T_Faktur_Penjualan.InvAR_KWYN,MKT_T_Faktur_Penjualan.InvARTanggal,MKT_T_Faktur_Penjualan.InvAR_Status,MKT_T_Faktur_Penjualan.InvAR_Bukti, MKT_T_Faktur_Penjualan.InvAR_PayYN, MKT_T_Faktur_Penjualan.InvARTotalLine, MKT_M_Customer.custNama, MKT_M_Customer.custID,MKT_T_Faktur_Penjualan.InvAR_PostingYN, MKT_T_Faktur_Penjualan.InvAR_JR_ID  "
        'response.write FakturPenjualan_cmd.commandText 
        set FakturPenjualan = FakturPenjualan_cmd.execute
    
        FakturPenjualan_cmd.commandText = "SELECT InvARID , InvARTanggal FROM MKT_T_Faktur_Penjualan WHERE InvARAktifYN = 'Y' "
        'response.write FakturPenjualan_cmd.commandText 
        set Faktur = FakturPenjualan_cmd.execute

        FakturPenjualan_cmd.commandText = "SELECT MKT_M_Customer.custNama, MKT_M_Customer.custID FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_M_Customer.custID = MKT_T_Faktur_Penjualan.InvAR_custID WHERE InvARAktifYN = 'Y' "
        'response.write FakturPenjualan_cmd.commandText 
        set RekapCust = FakturPenjualan_cmd.execute

        FakturPenjualan_cmd.commandText = "SELECT MONTH(InvARTanggal) AS Bulan,YEAR(InvARTanggal) AS Tahun, InvARID FROM MKT_T_Faktur_Penjualan WHERE InvARAktifYN = 'Y' "
        'response.write FakturPenjualan_cmd.commandText 
        set RekapBulan = FakturPenjualan_cmd.execute

        FakturPenjualan_cmd.commandText = "SELECT MKT_T_Faktur_Penjualan.InvAR_custID, MKT_M_Customer.custNama FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_M_Customer.custID = MKT_T_Faktur_Penjualan.InvAR_custID GROUP BY MKT_T_Faktur_Penjualan.InvAR_custID, MKT_M_Customer.custNama"
        'response.write FakturPenjualan_cmd.commandText 
        set Customer = FakturPenjualan_cmd.execute
    
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
        function rekap(){
            var rekap = document.getElementById("RekapFaktur").value;
            if( rekap == "RekapBulan" ){
                document.getElementById("rekapBulan").style.display = "block";
                document.getElementById("rekapcust").style.display = "block";
                document.getElementById("rekapMinggu1").style.display = "none";
                document.getElementById("rekapMinggu2").style.display = "none";
                document.getElementById("rekap-btn").style.display = "block";
            }else{
                document.getElementById("rekapMinggu1").style.display = "block";
                document.getElementById("rekap-btn").style.display = "block";
                document.getElementById("rekapMinggu2").style.display = "block";
                document.getElementById("rekapcust").style.display = "block";
                document.getElementById("rekapBulan").style.display = "none";
                
            }
        }
        function Bulan(){
            $.ajax({
                type: "get",
                url: "get-data.asp?InvARBulan="+document.getElementById("InvARBulan").value+"&InvARTanggla="+document.getElementById("InvARTanggla").value+"&InvARTanggle="+document.getElementById("InvARTanggle").value,
                success: function (url) {
                    $('.datatr').html(url);
                }
            });
        }
        function ListKwitansi(){
            document.getElementById("cont-listinvoice").style.display = "none";
            $.ajax({
                type: "GET",
                url: "list-kwitansi.asp",
                success: function (url) {
                    $('.cont-listkwitansi').html(url);
                }
            });
        }
        function tgla(){
            $.ajax({
                type: "get",
                url: "getdata.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                    success: function (url) {
                        $('.dataRekap').html(url);
                    }
                });
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
        .modal-upload-bukti {
        display: none; 
        position: fixed; 
        z-index: 1; 
        padding-top: 100px; 
        left: 0;
        top: 0;
        width: 100%; 
        height: 100%; 
        overflow: auto; 
        background-color: rgb(0,0,0); 
        background-color: rgba(0,0,0,0.4);
        }

        /* Modal Content */
        .modal-content-upload-bukti {
        background-color: #fefefe;
        margin: auto;
        padding: 20px;
        border-radius : 10px;
        border: 1px solid #888;
        width: 30%;
        }

        /* The Close Button */
        .close-upload-bukti {
        color: #0077a2;
        float: right;
        font-size: 18px;
        font-weight: bold;
        }
        .cont-upload-butki{
            background-color:#aaa;
            padding:10px 10px;
            margin:10px;
            border-radius:10px;
        }
        .label-img{
            width: 13rem;
            padding: 10px 10px;
            border: 3px solid #f5f5f5;
            border-radius: 10px;
            background-color: white;
        }
        
        .close-upload-bukti:hover,
        .close-upload-bukti:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
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
                        <span class="cont-text"> INVOICE AR </span>
                    </div>
                    <div class="col-1">
                        <button onclick="Refresh()" class="cont-btn cont-text"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row align-items-center">
                    <div class="col-2">
                        <span class="cont-text"> REKAP INVOICE AR</span><br>
                    </div>
                </div>
                <div class="row align-items-center">
                    <div class="col-2">
                        <input type="date" class="cont-form" name="tgla" id="tgla" value="">
                    </div>
                    <div class="col-2">
                        <input type="date" class="cont-form" name="tgle" id="tgle" value="">
                    </div>
                    <div class="col-4">
                        <select class="cont-form" name="custID" id="custID" arial-label="Default select example">
                            <option value=""> PILIH BUSSINES PARTNER </option>
                            <% do while not Customer.eof %>
                                <option value="<%=Customer("InvAR_custID")%>"> <%=Customer("custNama")%> </option>
                            <% Customer.movenext
                            loop %>
                        </select>
                    </div>
                    <div class="col-2">
                        <button class="cont-btn" onclick="window.open('Bukti-TandaTerima.asp?InvAR_tgla='+document.getElementById('tgla').value+'&InvAR_tgle='+document.getElementById('tgle').value+'&InvAR_custID='+document.getElementById('custID').value,'_Self')">RKP-TANDATERIMA </button>
                    </div>
                    <div class="col-2">
                        <button class="cont-btn" onclick="window.open('Bukti-Kwitansi.asp?InvAR_tgla='+document.getElementById('tgla').value+'&InvAR_tgle='+document.getElementById('tgle').value+'&InvAR_custID='+document.getElementById('custID').value,'_Self')">RKP-KWITANSI </button>
                    </div>
                </div>
                <div class="row align-items-center ">
                    <div class="col-4" id="rekapBulan" style="display:none">
                        <select onchange="Bulan()"  class="cont-form" name="InvARBulan" id="InvARBulan" aria-label="Default select example">
                            <option value="">Pilih Bulan</option>
                            <% 
                                no = 0
                                do while not RekapBulan.eof 
                                no = no + 1
                            %>
                            <option value="<%=RekapBulan("Bulan")%>"><%=MONTHNAME(RekapBulan("Bulan"))%>-<%=RekapBulan("Tahun")%></option>
                            <% 
                                RekapBulan.movenext
                                loop 
                            %>
                        </select>
                    </div>
                    <div class="col-2 rekapMinggu" name="rekapMinggu" id="rekapMinggu1" style="display:none">
                        <input  class="cont-form" type="date" name="InvARTanggla" id="InvARTanggla" value="" >
                    </div>
                    <div class="col-2 rekapMinggu" name="rekapMinggu" id="rekapMinggu2" style="display:none">
                        <input  class="cont-form" type="date" name="InvARTanggle" id="InvARTanggle" value="" >
                    </div>
                    <div class="col-8" id="rekapcust" style="display:none">
                        <select onchange="Bulan()"  class="cont-form" name="InvARBulan" id="InvARBulan" aria-label="Default select example">
                            <option value=""> Pilih Bussines Partner </option>
                            <% 
                                no = 0
                                do while not RekapCust.eof 
                                no = no + 1
                            %>
                            <option value="<%=RekapCust("custID")%>"><%=RekapCust("custNama")%></option>
                            <% 
                                RekapCust.movenext
                                loop 
                            %>
                        </select>
                    </div>
                </div>
                <div class="mt-2" id="rekap-btn" style="display:none">
                <div class="row" >
                    <div class="col-2">
                        <button onclick="window.open('TandaTerima.asp?InvARBulan='+document.getElementById('InvARBulan').value+'&InvARTanggla='+document.getElementById('InvARTanggla').value+'&InvARTanggle='+document.getElementById('InvARTanggle').value,'_Self')"  class="cont-btn"> <i class="fas fa-download"></i> &nbsp; Download Rekap </button>
                    </div>
                    <div class="col-3">
                        <button onclick="window.open('add-kwitansi.asp?InvARBulan='+document.getElementById('InvARBulan').value+'&InvARTanggla='+document.getElementById('InvARTanggla').value+'&InvARTanggle='+document.getElementById('InvARTanggle').value,'_Self')"  class=" cont-btn" > <i class="fas fa-folder-plus"></i>  &nbsp; Create Tanda Terima </button>
                    </div>
                </div>
                </div>
            </div>

            <div class="cont-listinvoice mt-2" id="cont-listinvoice" style="display:block">
                <div class="row p-1">
                    <div class="col-12">
                    <div class="cont-tb"  style="overflow:scroll; height:25rem">                    
                        <table class="tb-dashboard align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="width:100rem">
                            <thead>
                                <tr class="text-center">
                                    <th>NO</th>
                                    <th>NO FAKTUR PENJUALAN</th>
                                    <th>TANGGAL </th>
                                    <th>CUSTOMER</th>
                                    <th>TOTAL LINE</th>
                                    <th colspan="2">AKSI</th>
                                    <th colspan="3">TUKAR FAKTUR</th>
                                    <th>JURNAL POST</th>
                                </tr>
                            </thead>
                            <tbody class="dataRekap">
                                <% 
                                    no = 0
                                    do while not FakturPenjualan.eof 
                                    no = no+1
                                %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                        <input type="hidden" name="InvARID" id="InvARID<%=FakturPenjualan("InvARID")%>" value="<%=FakturPenjualan("InvARID")%>">
                                    <td> <button class="cont-btn" onclick="window.open('Bukti-FakturPenjualan.asp?InvARID='+document.getElementById('InvARID<%=FakturPenjualan("InvARID")%>').value,'_Self')"> <%=FakturPenjualan("InvARID")%> </button> </td>
                                    <td class="text-center"> <%=CDate(FakturPenjualan("InvARTanggal"))%> </td>
                                    <td> <%=FakturPenjualan("custNama")%> </td>
                                    <td class="text-center"> <%=Replace(Replace(FormatCurrency(FakturPenjualan("InvARTotalLine")),"$","Rp. "),".00","")%> </td>
                                    <td class="text-center"> 
                                        <button class="cont-btn" onclick="window.open('Bukti-TandaTerima.asp?InvARID='+document.getElementById('InvARID<%=FakturPenjualan("InvARID")%>').value,'_Self')"><i class="fas fa-print"></i> TANDATERIMA </button> 
                                    </td>
                                    <% if FakturPenjualan("InvAR_KWYN") = "N" then %>
                                    <td class="text-center"> 
                                        <button class="cont-btn" onclick="window.open('add-kwitansi.asp?InvARID='+document.getElementById('InvARID<%=FakturPenjualan("InvARID")%>').value,'_Self')"> <i class="fas fa-folder-plus"></i> ADD KWITANSI </button> 
                                    </td>
                                    <% else %>
                                    <td class="text-center"> 
                                        <button class="cont-btn" onclick="window.open('Bukti-Kwitansi.asp?InvARID='+document.getElementById('InvARID<%=FakturPenjualan("InvARID")%>').value,'_Self')"> <i class="fas fa-print"></i> KWITANSI </button> 
                                    </td>
                                    <% end if %>
                                        <% if FakturPenjualan("InvAR_Status") = "N" then %>
                                        <td class="text-center"> <span class="cont-text" style="color:red"> BELUM TF </span> </td>
                                        <td class="text-center" colspan="2"> <button class="cont-btn" style="background-color:red; color:white" id="btn-upload-buktiInvARID<%=FakturPenjualan("InvARID")%>"> <i class="fas fa-upload"></i> VERF-FAKTUR </button> </td>
                                        <% else %>
                                        <td class="text-center"> <span class="cont-text" style="color:green"> SUDAH TF </span> </td>
                                        <td class="text-center"> <button class="cont-btn" style="background-color:green; color:white"> <i class="fas fa-images"></i> BUKTI-TF </button> </td>
                                            <% if FakturPenjualan("InvAR_PayYN") = "N" then %>
                                            <td class="text-center"> <button class="cont-btn" style="background-color:red; color:white"> <i class="fas fa-external-link-alt"></i> VERF-BAYAR </button> </td>
                                            <% else %>
                                                <% 
                                                    FakturPenjualan_cmd.commandText = "SELECT MKT_T_Payment_D.pay_Total, MKT_T_Payment_D.pay_Dibayar, MKT_T_Payment_D.pay_Sisa, MKT_T_Faktur_Penjualan.InvARTotalLine, MKT_T_Payment_H.payID FROM MKT_T_Faktur_Penjualan RIGHT OUTER JOIN MKT_T_Payment_D ON MKT_T_Faktur_Penjualan.InvARID = MKT_T_Payment_D.pay_Ref RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID WHERE MKT_T_Faktur_Penjualan.InvARID = '"& FakturPenjualan("InvARID") &"' AND MKT_T_Payment_D.pay_Ref = '"& FakturPenjualan("InvARID") &"'"
                                                    'response.write FakturPenjualan_cmd.commandText
                                                    set TotalAkhir = FakturPenjualan_cmd.execute
                                                %>
                                                <% if TotalAkhir("pay_Sisa") = "0" then %>
                                                <td class="text-center"> <button class="cont-btn"  style="background-color:green; color:white"> <i class="fas fa-print"></i> <%=TotalAkhir("payID")%> </button> </td>
                                                <% else %>
                                                <td class="text-center"> <span class="cont-text" style="color:red">- <%=Replace(Replace(FormatCurrency(TotalAkhir("pay_Sisa")),"$","Rp. "),".00","")%> </button> </td>
                                                <% end if %>
                                            <% end If %>
                                        <% end if %>
                                    <% if FakturPenjualan("InvAR_PostingYN") = "N" then %>
                                    <td class="text-center"> <button class="cont-btn" style="background-color:red; color:white"><i class="fas fa-sort-up"></i> POST-JURNAL </button> </td>
                                    <% else %>
                                    <td class="text-center"> <button class="cont-btn"> <i class="fas fa-print"></i> <%=FakturPenjualan("InvAR_JR_ID")%> </button> </td>
                                    <% end If %>
                                </tr>
                                <!-- The Modal -->
                                <div id="UploadBuktiInvARID<%=FakturPenjualan("InvARID")%>" class="modal-upload-bukti">

                                <!-- Modal content -->
                                <div class="modal-content-upload-bukti">
                                    <div class="row align-items-center">
                                        <div class="col-11">
                                            <span>UPLOAD BUKTI PEMBAYARAN</span>
                                        </div>
                                        <div class="col-1">
                                            <span style="font-size:18px"class="close-upload-bukti<%=no%>">&times;</span>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="cont-upload-butki mt-2">
                                        <div class="row align-items-center text-center">
                                            <div class="col-12">
                                                <div class="text-center potoproduk">
                                                    <label for="firstimg2InvARID<%=FakturPenjualan("InvARID")%>" class="label-img">
                                                    <img src="<%=base_url%>/assets/logo/up.png" id="output2InvARID<%=FakturPenjualan("InvARID")%>" width="150" height="150" ><br>
                                                    <span class="text-center" style="font-size:10px;"> Bukti Transfer </span>
                                                    </label>
                                                    <input type="file" name="firstimg2" id="firstimg2InvARID<%=FakturPenjualan("InvARID")%>" style="display:none" onchange="loadFile2<%=no%>(event)"><br>
                                                    <textarea name="image2" id="base64_2<%=no%>" rows="1" style="display:none"   ></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3 text-center">
                                        <div class="col-12">
                                            <button class="cont-btn" onclick="uploadbukti<%=no%>()" style="width:10rem"> UPLOAD </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% if FakturPenjualan("InvAR_Status") = "N" then %>
                            <script>
                                var modaluploadbukti = document.getElementById("UploadBuktiInvARID<%=FakturPenjualan("InvARID")%>");
                                var btnuploadbukti = document.getElementById("btn-upload-buktiInvARID<%=FakturPenjualan("InvARID")%>");
                                var spanuploadbukti = document.getElementsByClassName("close-upload-bukti<%=no%>")[0];
                                btnuploadbukti.onclick = function() {
                                    modaluploadbukti.style.display = "block";
                                }
                                spanuploadbukti.onclick = function() {
                                    modaluploadbukti.style.display = "none";
                                }
                                window.onclick = function(event) {
                                    if (event.target == modaluploadbukti) {
                                        modaluploadbukti.style.display = "none";
                                    }
                                }
                                // Check for the File API support.
                                if (window.File && window.FileReader && window.FileList && window.Blob) {
                                document.getElementById('firstimg2InvARID<%=FakturPenjualan("InvARID")%>').addEventListener('change', SKUFileSelect2, false);
                                } else {
                                alert('The File APIs are not fully supported in this browser.');
                                }

                                function SKUFileSelect2(evt) {
                                var f2 = evt.target.files[0]; // FileList object
                                var reader2 = new FileReader();
                                // Closure to capture the file information.
                                reader2.onload = (function(theFile2) {
                                    return function(e2) {
                                    var binaryData2 = e2.target.result;
                                    //Converting Binary Data to base 64
                                    var base64String2 = window.btoa(binaryData2);
                                    //showing file converted to base64
                                    document.getElementById('base64_2<%=no%>').value = base64String2;
                                    };
                                })(f2);
                                // Read in the image file as a data URL.
                                reader2.readAsBinaryString(f2);
                                }
                                const loadFile2<%=no%> = function(event) {
                                    const output2<%=no%> = document.getElementById('output2InvARID<%=FakturPenjualan("InvARID")%>');
                                        output2<%=no%>.src = URL.createObjectURL(event.target.files[0]);
                                        output2<%=no%>.onload = function() {
                                        URL.revokeObjectURL(output2<%=no%>.src)
                                    }
                                };
                                function uploadbukti<%=no%>(){
                                    var InvARID = document.getElementById("InvARID<%=FakturPenjualan("InvARID")%>").value;
                                    var InvARBukti = document.getElementById("base64_2<%=no%>").value;
                                    $.ajax({
                                        type: "post",
                                        data: { 
                                            InvARID, 
                                            InvARBukti 
                                            },
                                            url: "posting-jurnal.asp",
                                            success: function (data) {
                                                console.log(data);
                                            }
                                        });
                                    }
                            </script>
                            <% end if %>
                            <% 
                                FakturPenjualan.movenext
                                loop 
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="cont-listkwitansi mt-2">
            
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

        function tandaterima(){
            $.ajax({
                type: "get",
                url: "Bukti-TandaTerima.asp?InvAR_tgla="+document.getElementById("tgla").value+"&InvAR_tgle="+document.getElementById("tgle").value+"&InvAR_custID="+document.getElementById("custID").value,
                success: function (url) {
                }
            });
        }
    </script>
</html>