<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    set Payment_cmd = server.createObject("ADODB.COMMAND")
	Payment_cmd.activeConnection = MM_PIGO_String

        Payment_cmd.commandText = "SELECT MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payDesc, MKT_T_Payment_H.paypostingYN,  MKT_T_Payment_H.pay_custID, MKT_M_Customer.custNama, MKT_T_Payment_D.pay_Ref, MKT_T_Payment_H.pay_JR_ID, MKT_T_Payment_D.pay_Total,  MKT_T_Payment_D.pay_Dibayar, MKT_T_Payment_D.pay_Sisa,MKT_T_Payment_H.payBukti,MKT_T_Payment_D.pay_Subtotal,  MKT_T_Payment_D.pay_Tipe FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_M_Customer.custID = MKT_T_Payment_H.pay_custID LEFT OUTER JOIN MKT_T_Payment_D ON MKT_T_Payment_H.payID = MKT_T_Payment_D.payID_H WHERE (MKT_T_Payment_H.payAktifYN = 'Y')"
        'response.write Payment_cmd.commandText 

    set Payment = Payment_cmd.execute

    set DataPAY_cmd = server.createObject("ADODB.COMMAND")
	DataPAY_cmd.activeConnection = MM_PIGO_String

        DataPAY_cmd.commandText = "SELECT MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal FROM MKT_T_Payment_D RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID   group by MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal"
        'response.write  DataPAY_cmd.commandText

    set DataPAY = DataPAY_cmd.execute

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
       
        function cetakpay(){
            $.ajax({
                type: "get",
                url: "getdata.asp?payID="+document.getElementById("payID").value,
                success: function (url) {
                    $('.datatr').html(url);
                    console.log(url);
                }
            });
        }
        function caripay(){
            $.ajax({
                type: "get",
                url: "loaddatapay.asp?caripay="+document.getElementById("caripay").value,
                success: function (url) {
                    $('.datatr').html(url);
                    // console.log(url);
                }
            });
        }
    </script>
    <style>
        .modalbukti {
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
            background-color: rgba(0,0,0,0.9);
        }
        .modal-content-bukti {
            margin: auto;
            display: block;
            height:60%;
            width: 40%;
        }

        .modal-content {  
            -webkit-animation-name: zoom;
            -webkit-animation-duration: 0.6s;
            animation-name: zoom;
            animation-duration: 0.6s;
        }

        @-webkit-keyframes zoom {
        from {-webkit-transform:scale(0)} 
        to {-webkit-transform:scale(1)}
        }

        @keyframes zoom {
        from {transform:scale(0)} 
        to {transform:scale(1)}
        }

        .cl-bukti {
        position: absolute;
        top: 15px;
        right: 35px;
        color: white;
        font-size: 40px;
        font-weight: bold;
        transition: 0.3s;
        }
        .img-bukti{
            border-radius:20px;
        }

        @media only screen and (max-width: 700px){
        .modal-content-bukti {
            width: 100%;
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

        .modal-content-upload-bukti {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border-radius : 10px;
            border: 1px solid #888;
            width: 30%;
        }

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
        .content-table{
            height:25rem;
            overflow-x:scroll;
            overflow-y:scroll;
        }
        .cont-tb{
            width:90rem;
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
                        <span class="cont-text"> PAYMENT OUT </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button class="cont-btn" onclick="window.open('../Payment/','_Self')" style="font-size:12px"> TAMBAH PAYMENT </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row align-items-center">
                    
                </div>
                <div class="row mt-1 mb-1">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <span class="cont-text me-4"> Cari </span><span class="cont-text" style="font-size:10px; color:red"><i>( Silahkan Masukan No Payment ID ) </i></span><br>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <span class="cont-text me-4"> Periode Payment Request </span><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <input onkeyup="caripay()" class=" cont-form" type="search" name="caripay" id="caripay" value="PIGO/PAY/">
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <input onchange="tgla()" class=" mb-2 cont-form" type="date" name="tgla" id="tgla" value="" >
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <input onchange="tgla()" class=" mb-2 cont-form" type="date" name="tgle" id="tgle" value="" >
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-12">
                        <div class="dropdown">
                            <button class="cont-btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                Download Laporan 
                            </button>
                            <ul class="dropdown-menu text-center cont-btn" aria-labelledby="dropdownMenuButton1">
                                <li>
                                    <button class="cont-btn" onclick="window.open('lapprpdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')">Laporan PDF</button>
                                </li>
                                <li>
                                    <button class=" mt-2 cont-btn" onclick="window.open('lappoexc.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Excel </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row p-1 mt-2">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="content-table">
                        <table class=" align-items-center cont-tb cont-text table tb-transaksi table-bordered table-condensed mt-1">
                            <thead class="text-center">
                                <tr>
                                    <th> NO </th>
                                    <th colspan="2"> ID PEMBAYARAN </th>
                                    <th> TANGGAL </th>
                                    <th> BUSSINES PARTNER </th>
                                    <th> PEMBAYARAN </th>
                                    <th> DIBAYARKAN </th>
                                    <th> SISA PEMBAYARAN</th>
                                    <th> BUKTI </th>
                                    <th colspan="2"> JURNAL </th>
                                </tr>
                            </thead>
                            <tbody class="datatr">
                            <% 
                                no = 0 
                                do while not Payment.eof 
                                bukti = Payment("payBukti")
                                no = no + 1
                            %>

                                <tr>
                                    <td class="text-center"><%=no%></td>
                                    <td class="text-center"> 
                                        <%=Payment("pay_Tipe")%> 
                                        <input type="hidden" name="payID" id="payID<%=Payment("payID")%>" value="<%=Payment("payID")%>">
                                    </td>
                                    <% if Payment("pay_Tipe") = "AR" then %>
                                        <td class="text-center">
                                            <button class="cont-btn" onclick="window.open('../Payment/bukti-kasmasuk.asp?payID='+document.getElementById('payID<%=Payment("payID")%>').value,'_Self')"> <i class="fas fa-print"></i> <%=Payment("payID")%> </button>
                                        </td>
                                    <% else %>
                                        <td class="text-center">
                                            <button class="cont-btn" onclick="window.open('../Payment/bukti-kaskeluar.asp?payID='+document.getElementById('payID<%=Payment("payID")%>').value,'_Self')"> <i class="fas fa-print"></i> <%=Payment("payID")%> </button>
                                        </td>
                                    <% end if %>
                                    <td class="text-center">
                                        <%=Day(CDate(Payment("payTanggal")))%>/<%=Month(Payment("payTanggal"))%>/<%=Year(CDate(Payment("payTanggal")))%>
                                    </td>
                                    <td><%=Payment("custNama")%><%=Payment("payBukti")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Payment("pay_Total")),"$","Rp. "),".00","")%>   </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Payment("pay_Dibayar")),"$","Rp. "),".00","")%> </td>
                                    <% if Payment("pay_sisa") = 0 then %>
                                        <td class="text-center" style="color:#35cf0e">
                                            <i class="fas fa-check"></i>
                                        </td>
                                    <% else %>
                                        <td class="text-end" style="color:red">
                                            <%=Replace(Replace(FormatCurrency(Payment("pay_sisa")),"$","Rp. "),".00","")%>
                                        </td>
                                    <% end if %>
                                    <% if Payment("payBukti") <> " " then %>
                                        <td class="text-center"> 
                                            <button class="cont-btn" style="background-color:green;color:white"> <img class="img-bukti" id="myImg-bukti<%=no%>" src="data:image/png;base64,<%=bukti%>" width="15" height="15" > &nbsp; LIHAT BUKTI </button> 
                                        </td>
                                        <!-- The Modal Load Bukti -->
                                            <div id="myModal-bukti<%=no%>" class="modalbukti">
                                                <span class="cl-bukti cl-bukti<%=no%>">&times;</span>
                                                <img class="modal-content-bukti" id="img01-bukti<%=no%>" width="55" height="55">
                                            </div>
                                            <script>
                                                var modalbukti = document.getElementById("myModal-bukti<%=no%>");
                                                var imgbukti = document.getElementById("myImg-bukti<%=no%>");
                                                var modalImg = document.getElementById("img01-bukti<%=no%>");
                                                imgbukti.onclick = function(){
                                                modalbukti.style.display = "block";
                                                modalImg.src = this.src;
                                                }
                                                var spanbukti = document.getElementsByClassName("cl-bukti<%=no%>")[0];
                                                spanbukti.onclick = function() { 
                                                    modalbukti.style.display = "none";
                                                }
                                            </script>
                                        <!-- The Modal Load Bukti -->
                                    <% else %>
                                        <td class="text-center"> 
                                            <button class="cont-btn" id="btn-upload-bukti<%=no%>" style="background-color:red;color:white"> UPLOAD BUKTI </button> 
                                        </td>
                                        <!-- The Modal Upload Bukti -->
                                            <div id="UploadBukti<%=no%>" class="modal-upload-bukti">
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
                                                                    <label for="firstimg2<%=no%>" class="label-img">
                                                                    <img src="<%=base_url%>/assets/logo/up.png" id="output2<%=no%>" width="150" height="150" ><br>
                                                                    <span class="text-center" style="font-size:10px;"> Bukti Transfer </span>
                                                                    </label>
                                                                    <input type="file" name="firstimg2" id="firstimg2<%=no%>" style="display:none" onchange="loadFile2<%=no%>(event)"><br>
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
                                            <script>
                                                var modaluploadbukti = document.getElementById("UploadBukti<%=no%>");
                                                var btnuploadbukti = document.getElementById("btn-upload-bukti<%=no%>");
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

                                                if (window.File && window.FileReader && window.FileList && window.Blob) {
                                                    document.getElementById('firstimg2<%=no%>').addEventListener('change', SKUFileSelect2, false);
                                                } else {
                                                    alert('The File APIs are not fully supported in this browser.');
                                                }

                                                function SKUFileSelect2(evt) {
                                                var f2 = evt.target.files[0];
                                                var reader2 = new FileReader();
                                                reader2.onload = (function(theFile2) {
                                                    return function(e2) {
                                                    var binaryData2 = e2.target.result;
                                                    var base64String2 = window.btoa(binaryData2);
                                                    document.getElementById('base64_2<%=no%>').value = base64String2;
                                                    };
                                                })(f2);
                                                reader2.readAsBinaryString(f2);
                                                }
                                                const loadFile2<%=no%> = function(event) {
                                                    const output2<%=no%> = document.getElementById('output2<%=no%>');
                                                        output2<%=no%>.src = URL.createObjectURL(event.target.files[0]);
                                                        output2<%=no%>.onload = function() {
                                                        URL.revokeObjectURL(output2<%=no%>.src)
                                                    }
                                                };
                                                function uploadbukti<%=no%>(){
                                                    var payID = document.getElementById("payID<%=Payment("payID")%>").value;
                                                    var payBukti = document.getElementById("base64_2<%=no%>").value;
                                                    console.log(payID);
                                                    console.log(payBukti);
                                                    $.ajax({
                                                        type: "POST",
                                                        data: { 
                                                                payID, 
                                                                payBukti 
                                                            },
                                                            url: "../Payment/posting-jurnal.asp",
                                                            success: function (data) {
                                                                location.reload();
                                                            }
                                                        });
                                                    }
                                            </script>
                                        <!-- The Modal Upload Bukti -->
                                    <% end if %>
                                    <% if Payment("paypostingYN") <> "N" then %>
                                    <td class="text-center"> 
                                        <input type="hidden" name="JRD_ID" id="JRD_ID<%=no%>" value="<%=Payment("pay_JR_ID")%>">
                                        <button class="cont-btn" onclick="window.open('../../GL/GL-Jurnal/jurnal-voucher.asp?JR_ID='+document.getElementById('JRD_ID<%=no%>').value,'_Self')"> <i class="fas fa-print"></i> <%=Payment("pay_JR_ID")%> </button> 
                                    </td>
                                    <% else %>
                                    <td class="text-center"> 
                                        <button class="cont-btn" onclick="window.open('posting-jurnal.asp?payID='+document.getElementById('payID<%=Payment("payID")%>').value,'_Self')"> POST-JURNAL </button> 
                                    </td>
                                    <% end if %>
                                    
                                </tr>
                            <% Payment.movenext
                            loop%>
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