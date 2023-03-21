<!--#include file="../../../connections/pigoConn.asp"-->
<%

    if request.Cookies("custEmail")="" then 
 
    response.redirect("../")
    
    end if

    set Seller_cmd =  server.createObject("ADODB.COMMAND")
    Seller_cmd.activeConnection = MM_PIGO_String

    Seller_cmd.commandText = "SELECT  top 10 MKT_M_Customer.custPhoto, MKT_M_Seller.slName FROM MKT_M_Customer LEFT OUTER JOIN  MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID  where sl_custID = '"& request.Cookies("custID") &"'  group by MKT_M_Customer.custPhoto, MKT_M_Seller.slName "
    set Seller = Seller_CMD.execute

    set Wallet_CMD =  server.createObject("ADODB.COMMAND")
    Wallet_CMD.activeConnection = MM_PIGO_String

    Wallet_CMD.commandText = "SELECT SUM(MKT_T_SaldoSeller.Wall_Amount) AS Saldo FROM MKT_T_SaldoSeller  WHERE Wall_SellerID = '"& request.Cookies("custID") &"'"
    'response.write Wallet_CMD.commandText
    set Saldo = Wallet_CMD.execute 

    Wallet_CMD.commandText = "SELECT MKT_M_Rekening.rkNomorRk, GLB_M_Bank.BankName FROM MKT_M_Rekening LEFT OUTER JOIN GLB_M_Bank ON MKT_M_Rekening.rkBankID = GLB_M_Bank.BankID WHERE rk_custID = '"& request.Cookies("custID") &"'"
    'response.write Wallet_CMD.commandText
    set Rekening = Wallet_CMD.execute 

    'response.write Wallet_CMD.commandText
    Wallet_CMD.commandText = "SELECT MKT_T_SaldoSeller.Wall_ID, MKT_T_SaldoSeller.Wall_DateAcc, MKT_T_SaldoSeller.Wall_CustID, MKT_T_SaldoSeller.Wall_TrID, MKT_T_SaldoSeller.Wall_Amount, MKT_T_SaldoSeller.Wall_Status,  MKT_T_SaldoSeller.Wall_KonfYN, MKT_T_SaldoSeller.Wall_WithDYN, MKT_T_SaldoSeller.Wall_UpdateTime, MKT_M_Customer.custNama, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_SaldoSeller.Wall_Jenis,  MKT_T_SaldoSeller.Wall_BankID, MKT_T_SaldoSeller.Wall_Rek FROM MKT_T_SaldoSeller LEFT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_SaldoSeller.Wall_TrID = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_M_Customer ON MKT_T_SaldoSeller.Wall_CustID = MKT_M_Customer.custID WHERE Wall_SellerID = '"& request.Cookies("custID") &"' GROUP BY MKT_T_SaldoSeller.Wall_ID, MKT_T_SaldoSeller.Wall_DateAcc, MKT_T_SaldoSeller.Wall_CustID, MKT_T_SaldoSeller.Wall_TrID, MKT_T_SaldoSeller.Wall_Amount, MKT_T_SaldoSeller.Wall_Status, MKT_T_SaldoSeller.Wall_KonfYN, MKT_T_SaldoSeller.Wall_WithDYN, MKT_T_SaldoSeller.Wall_UpdateTime, MKT_M_Customer.custNama, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_SaldoSeller.Wall_Jenis, MKT_T_SaldoSeller.Wall_BankID, MKT_T_SaldoSeller.Wall_Rek" 
    set Wallet = Wallet_CMD.execute 

    Wallet_CMD.commandText = "SELECT ISNULL(COUNT(Rep_ID),0) AS Report FROM MKT_T_ReportSeller WHERE Rep_SellerID = '"& request.Cookies("custID") &"'  " 
    set TotalReport = Wallet_CMD.execute 
    
%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../../../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="pesanan.css">
        <link rel="stylesheet" type="text/css" href="../../../fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../../../css/stylehome.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/moment.min.js"></script>  
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        <title>Official PIGO</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    </head>
    <script>
        
    </script>
    <style>
        .main {
            margin-left: 200px; 
            font-size: 20px; 
            padding: 0px 10px;
            font-family: "Poppins";
            padding-top: 20px;
            width:85%;
        }
        .cont-waiting{
            padding: 2px 15px;
            background-color:#940005;
            color:white;
            font-weight:400;
            border-radius:10px;
        }
        .cont-complete{
            padding: 2px 15px;
            background-color:#00940f;
            color:white;
            border-radius:10px;
        }
        .text1-wal-seller{
            font-size:13px;
            font-weight:bold;
            color:black;
        }
        .text2-wal-seller{
            font-size:12px;
            font-weight:450;
            color:#767676;
        }
        .btn-wall-seller{
            padding: 2px 10px;
            background-color:#940005;
            color:white;
            font-size:12px;
            border-radius:5px;
            border:none;
        }
        .btn-wall-seller:hover{
            padding: 2px 10px;
            background-color:#0077a2;
            color:white;
            font-size:12px;
            border-radius:5px;
            border:none;
        }
        .cont-rekening{
            padding:5px 10px;
            background:#eee;
        }
        .text1-wall-rek{
            font-size:15px;
            color:#767676;
            font-family: "Century Gothic",Verdana,sans-serif;
            font-weight:bold
        }
        .text2-wall-rek{
            font-size:15px;
            color:#767676;
            font-family: "Century Gothic",Verdana,sans-serif;
        }
        .cont-wallet{
            margin-top:4rem;
            padding:10px 10px; 
            background-color:none; 
            width:100%;
            height:max-content;
        }
        .txt-waiting{
            color:#940005;
        }
        .txt-waiting{
            color:#940005;
        }
        .txt-complete{
            color:#00940f;
        }
        .navigasi{
            font-size:13px;
        }
        .text-judul-wallet{
            font-size:13px !important;
            color:black !important;
            font-weight:550;
        }
        .cont-inf-wallet{
            padding:10px 15px;
            border-radius:10px;
            box-shadow: 0 2px 4px 0 rgba(170, 170, 170, 0.2), 0 1px 8px 0 rgba(180, 180, 180, 0.19);
        }
        .loader1 {
            display:none;
            font-size:0px;
            padding:0px;
            }
            .loader1 span {
            vertical-align:middle;
            border-radius:100%;
            
            display:inline-block;
            width:10px;
            height:10px;
            margin:3px 2px;
            -webkit-animation:loader1 0.8s linear infinite alternate;
            animation:loader1 0.8s linear infinite alternate;
            }
            .loader1 span:nth-child(1) {
            -webkit-animation-delay:-1s;
            animation-delay:-1s;
            background:#0b89b7;
            }
            .loader1 span:nth-child(2) {
            -webkit-animation-delay:-0.8s;
            animation-delay:-0.8s;
            background:#0077a2;
            }
            .loader1 span:nth-child(3) {
            -webkit-animation-delay:-0.26666s;
            animation-delay:-0.26666s;
            background:#3fbbe8;
            }
            .loader1 span:nth-child(4) {
            -webkit-animation-delay:-0.8s;
            animation-delay:-0.8s;
            background:#0077a2;
            
            }
            .loader1 span:nth-child(5) {
            -webkit-animation-delay:-1s;
            animation-delay:-1s;
            background:#3fbbe8;
            }

            @keyframes loader1 {
            from {transform: scale(0, 0);}
            to {transform: scale(1, 1);}
            }
            @-webkit-keyframes loader1 {
            from {-webkit-transform: scale(0, 0);}
            to {-webkit-transform: scale(1, 1);}
            }

        /* Style tab links */
            .tablink {
            background-color: #0077a2;
            color: white;
            float: left;
            border: 1px solid white;
            outline: none;
            cursor: pointer;
            border-bottom:2px solid #0077a2;
            padding:10px 5px;
            height:max-content;
            font-size: 12px;
            font-weight:450;
            width: 16.6%;
            }

            .tablink:hover {
            background-color: white;
            color: #0077a2;
            border-bottom:2px solid #940005;
            }
            .tablink.active {
            background-color: white;
            color: #0077a2;
            border-bottom:2px solid #940005;
            }

            /* Style the tab content (and add height:100% for full page content) */
            .tabcontent {
            color: white;
            display: none;
            padding: 100px 20px;
            height: 100%;
            }
            .cont-table{
            font-weight: bold;
            font-size: 12px;
            }
             thead{
                background-color: #eee;
                color: #0077a2;
            }
    </style>

<body>
<!--Loader Page-->
    <div id="loader-page" style="display:none">
        <div class="container"id="loader" style="margin-left:50%;position:right; margin-top:18rem"></div>
    </div>
<!--Loader Page-->

<!--Header Seller-->
    <!--#include file="../../headerseller.asp"-->
<!--Header Seller-->

<!--Body Seller-->
    <div class="sidenav">
        <!--#include file="../../Sidebar.asp"-->
    </div>

    <div class="main">
        <div class="cont-wallet">
            <!--Breadcrumb-->
                <div class="row align-items-center">
                    <div class="col-12">
                        <div class="navigasi">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="text-judul-wallet breadcrumb-item"><a href="<%=base_url%>/Seller/" >Seller Home</a></li>
                                    <li class="text-judul-wallet breadcrumb-item"><a href="<%=base_url%>/Daftar-Produk/">Keuangan</a></li>
                                    <li class="text-judul-wallet breadcrumb-item"><a href="index.asp">Saldo <%=request.cookies("custEmail")%></a></li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            <!--Breadcrumb-->

            <div class="cont-inf-saldo">
                <div class="row">
                    <div class="col-12">
                        <span class="text-judul-wallet"> Informasi Saldo </span>
                    </div>
                </div>
                <div class="cont-inf-wallet mt-2">
                    <div class="row align-items-center">
                        <div class="col-9" style="border-right: 1px solid #0077a2">
                            <span class="text-judul-wallet"> Saldo </span>  &nbsp; <button class="btn-wall-seller"> Tarik Dana </button><br>
                            <span class="text1-wall-rek" style="font-size:30px"> <%=Replace(Replace(FormatCurrency(Saldo("Saldo")),"$","Rp.  "),".00","")%> </span>
                        </div>
                        <div class="col-3">
                            <span class="text-judul-wallet"> Info Rekening </span> &nbsp; <button class="btn-wall-seller"> Lainnya </button><br>
                            <div class="cont-rekening mt-1">
                                <span class="text1-wall-rek"> <%=Rekening("BankName")%> : </span> &nbsp; 
                                <span class="text2-wall-rek"> ***** <%=LEFT(Rekening("rkNomorRk"),4)%> </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <span class="text-judul-wallet"> Detail Transaksi </span>
                    </div>
                </div>
                <hr>
                <div class="row ">
                    <div class="col-7">
                        <span class="text-judul-wallet"> Periode &nbsp; :  </span> &nbsp; 
                        <input type="date" class="cont-form" name="TanggalAwal" id="TanggalAwal" value="" style="width:max-content"> 
                        <span class="text-judul-wallet"> s.d </span>
                        <input type="date" class="cont-form" name="TanggalAkhir" id="TanggalAkhir" value="" style="width:max-content"> &nbsp;
                        <select class="cont-form" aria-label="Default select example" style="width:max-content">
                            <option value="">Status</option>
                            <option value="C">Complete</option>
                            <option value="W">Waiting</option>
                        </select>
                    </div>
                    <div class="col-5 text-end ">
                        <button class="btn-wall-seller" onclick="expreport()"> Export  </button> &nbsp;
                        <input type="hidden" name="Wall_Jenis" id="Wall_Jenis" value="" >
                        <input type="hidden" name="Wall_JenisDesc" id="Wall_JenisDesc" value="" >
                        <button class="btn-wall-seller"> <b>( <%=TotalReport("Report")%> )</b> List Laporan  </button>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <button class="tablink" onclick="GetWallet(this)" id="00"> Semua</button>
                        <button class="tablink" onclick="GetWallet(this)" id="01"> Penghasilan Dari Pesanan</button>
                        <button class="tablink" onclick="GetWallet(this)" id="02"> Penarikan Dana</button>
                        <button class="tablink" onclick="GetWallet(this)" id="03"> Pengembalian Dana</button>
                        <button class="tablink" onclick="GetWallet(this)" id="04"> Pembayaran Oleh Penjual</button>
                        <button class="tablink" onclick="GetWallet(this)" id="05"> Penyesuaian</button>
                    </div>
                </div>
                <div class="row text-center mt-3">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="loader1"  id="loader1" style="height:100vh">
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </div>
                </div>
                <div id="loaddata">
                    <div class="row">
                        <div class="col-12">
                            <table class=" align-items-center cont-table table tb-transaksi table-bordered table-condensed "> 
                                <thead class="text-center">
                                    <tr>
                                        <th> NO </th>
                                        <th> TANGGAL </th>
                                        <th> DESKRIPSI </th>
                                        <th> JUMLAH </th>
                                        <th> STATUS </th>
                                    </tr>
                                </thead>
                                <tbody >
                                    <%
                                        no = 0
                                        do while not Wallet.eof
                                        no = no + 1
                                    %>
                                    <tr>
                                        <td class="text-center"> <%=no%> </td>
                                        <td class="text-center"> <%=CDate(Wallet("Wall_DateAcc"))%> </td>

                                        <% if Wallet("Wall_Jenis") = "01" then %>

                                            <%
                                                Wallet_CMD.commandText = "SELECT MKT_M_Produk.pdID, MKT_M_Produk.pdNama FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A LEFT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1,12) ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID WHERE tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Wallet("Wall_TrID") &"' AND tr_custID = '"& Wallet("Wall_CustID") &"'"
                                                'response.write Wallet_CMD.commandText
                                                set WalletPR = Wallet_CMD.execute 
                                            %>
                                            <td> 
                                                <span class="text1-wal-seller"> Penghasilan Dari Transaksi #<%=Wallet("Wall_TrID")%> (<%=CDate(Wallet("trTglTransaksi"))%>) </span><br>

                                                <span class="text2-wal-seller"> <%=Wallet("custNama")%> &nbsp; : &nbsp; 
                                                <% do while not WalletPR.eof %>
                                                <span class="text2-wal-seller"> <%=WalletPR("pdNama")%> </span> &nbsp; | &nbsp; <br>
                                                <% WalletPR.movenext
                                                loop %>
                                                </span>
                                            </td>

                                        <% else if Wallet("Wall_Jenis") = "02" then %>

                                            <td> 
                                                <span class="text1-wal-seller"> Penarikan Saldo #</span><br>
                                                <span class="text2-wal-seller"> Rekening : <%=Wallet("Wall_Rek")%> </span>
                                            </td>

                                        <% end if %> <% end if %>

                                        <% if Wallet("Wall_Status") = "C" then %>
                                            <td class="text-end txt-complete"> <%=Replace(Replace(FormatCurrency(Wallet("Wall_Amount")),"$","Rp.  "),".00","")%> </td>
                                            <td class="text-center"> <span class="cont-complete"> Complete </span> </td>
                                        <% else %>
                                            <td class="text-end txt-waiting"> <%=Replace(Replace(FormatCurrency(Wallet("Wall_Amount")),"$","Rp.  "),".00","")%> </td>
                                            <td class="text-center"> <span class="cont-waiting"> Waiting </span> </td>
                                        <% end if %>
                                        </td>
                                    </tr>
                                    <%
                                        Wallet.movenext
                                        loop
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



<!-- Popup Chat -->
        <button class="open-button-seller" onclick="openForm()"><img src="<%=base_url%>/assets/logo/bantuan.png" class="me-1" alt="..." id="chat" style="width:max-content"> </button>
        <div class="chat-popup" id="myForm">
            <form action="" class="form-container">
                <label for="msg"><b>Pesan</b></label>
                <textarea placeholder="Silahkan tulis keluhan anda" name="msg" required></textarea>
                <button type="submit" class="btn">Kirim</button>
                <button type="button" class="btn cancel" onclick="closeForm()">Tutup</button>
            </form>
        </div>
<!-- Popup Chat -->
</body>
    <script>
    // Open Chat
            function openForm() {
            document.getElementById("myForm").style.display = "block";
            }
            function closeForm() {
            document.getElementById("myForm").style.display = "none";
            }
        // Open Chat
        

        function openCity(evt, cityName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.className += " active";
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
        $('#Wall_JenisDesc').val("Saldo-Semua");
        $('#Wall_Jenis').val("00");
        function GetWallet(jenis){
            var JenisWallet     = jenis.id;
            var TanggalAwal     = $('#TanggalAwal').val();
            var TanggalAkhir    = $('#TanggalAkhir').val();
            document.getElementById("loader1").style.display = "block";
            document.getElementById("loaddata").style.display = "none";
            $('#Wall_Jenis').val(JenisWallet);
            if (JenisWallet == "01"){
                $('#Wall_JenisDesc').val("Saldo-PenghasilanDariPesanan");
            }else if (JenisWallet == "02"){
                $('#Wall_JenisDesc').val("Saldo-PenarikanDana");
            }else if (JenisWallet == "03"){
                $('#Wall_JenisDesc').val("Saldo-PengembalianDana");
            }else if (JenisWallet == "04"){
                $('#Wall_JenisDesc').val("Saldo-PembayaranOlehPenjual");
            }else if (JenisWallet == "05"){
                $('#Wall_JenisDesc').val("Saldo-Penyesuaian");
            }else{
                $('#Wall_JenisDesc').val("Saldo-Semua");
                $('#Wall_Jenis').val("00");
            }
            $.ajax({
                type: "GET",
                url: "Get-Wallet.asp",
                data:{
                    JenisWallet,
                    TanggalAwal,
                    TanggalAkhir
                },
                success: function (data) {
                    $('#loaddata').html(data);
                }
            });
            setTimeout(() => {
                document.getElementById("loader1").style.display = "none";
                document.getElementById("loaddata").style.display = "block";
            }, 5000);
        }
        function expreport(){
            var TanggalAwal         = $('#TanggalAwal').val();
            var TanggalAkhir        = $('#TanggalAkhir').val();
            var WallJenis           = $('#Wall_Jenis').val();
            var WallJenisDesc       = $('#Wall_JenisDesc').val();
            var ReportTipe          = "03"
            var CetakYN             = "N"
            $.ajax({
                type: "GET",
                url: "export-report.asp",
                data: {
                    TanggalAwal,
                    TanggalAkhir,
                    WallJenis,
                    WallJenisDesc,
                    ReportTipe,
                    CetakYN
                },
                success: function (data) {
                    // location.reload();
                }
            });
        }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>