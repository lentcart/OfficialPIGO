<!--#include file="../../../connections/pigoConn.asp"-->
<%

    if request.Cookies("custEmail")="" then 
 
    response.redirect("../")
    
    end if

    set Wallet_CMD =  server.createObject("ADODB.COMMAND")
    Wallet_CMD.activeConnection = MM_PIGO_String

    Wallet_CMD.commandText = "SELECT MKT_T_ReportSeller.Rep_ID, MKT_T_ReportSeller.Rep_TglAwal, MKT_T_ReportSeller.Rep_TglAkhir, MKT_T_ReportSeller.Rep_Nama, MKT_T_ReportSeller.Rep_Tipe, MKT_T_ReportSeller.Rep_Jenis,  MKT_T_ReportSeller.Rep_SellerID, MKT_T_ReportSeller.Rep_CetakYN, MKT_T_ReportSeller.Rep_CetakDate, MKT_T_ReportSeller.Rep_AktifYN, MKT_T_ReportSeller.Rep_UpdateTime, CONVERT(varchar(10),  MKT_T_ReportSeller.Rep_UpdateTime, 103) AS Date, CONVERT(VARCHAR(5), MKT_T_ReportSeller.Rep_UpdateTime, 8) AS Time, MKT_M_Seller.sl_custID, MKT_M_Seller.slName FROM MKT_T_ReportSeller LEFT OUTER JOIN MKT_M_Seller ON MKT_T_ReportSeller.Rep_SellerID = MKT_M_Seller.sl_custID  WHERE Rep_SellerID = '"& request.Cookies("custID") &"'"
    'response.write Wallet_CMD.commandText
    set Report = Wallet_CMD.execute 
    
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
                                    <li class="text-judul-wallet breadcrumb-item"><a href="index.asp">Laporan <%=request.cookies("custEmail")%></a></li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            <!--Breadcrumb-->

            <div class="cont-inf-saldo">
                <div class="row ">
                    <div class="col-12">
                        <span class="text-judul-wallet"> Laporan </span>
                    </div>
                </div>
                <hr>
                <div class="row ">
                    <div class="col-12">
                        <span class="text-judul-wallet"> Periode laporan Dibuat &nbsp; :  </span> &nbsp; 
                        <input type="date" class="cont-form"name="" id="" value="" style="width:max-content"> 
                        <span class="text-judul-wallet"> s.d </span>
                        <input type="date" class="cont-form"name="" id="" value="" style="width:max-content"> &nbsp;
                        <select class="cont-form" aria-label="Default select example" style="width:max-content">
                            <option value="">Jenis Laporan</option>
                            <option value="01">Laporan Penjualan</option>
                            <option value="02">Dokumen Pengiriman</option>
                            <option value="03">Laporan Saldo Seller</option>
                            <option value="04">Laporan Penghasilan</option>
                            <option value="05">Laporan Promosi</option>
                            <option value="06">Laporan Bisnin</option>
                        </select>

                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <table class=" align-items-center cont-table table tb-transaksi table-bordered table-condensed mt-2"> 
                            <thead class="text-center">
                                <tr>
                                    <th> NO </th>
                                    <th> LAPORAN DIBUAT </th>
                                    <th> JENIS </th>
                                    <th> SELLER </th>
                                    <th> NAMA LAPORAN </th>
                                    <th> AKSI </th>
                                </tr>
                            </thead>
                            <tbody>
                            <% 
                                no = 0
                                do while not Report.eof
                                no = no + 1
                            %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td class="text-center"> <%=Report("Date")%> &nbsp; <%=Report("Time")%> </td>
                                    <td class="text-center"> <%=Report("Rep_Jenis")%> </td>
                                    <td class="text-center"> <%=Report("slName")%> </td>
                                    <td class="text-center"> <%=Report("Rep_Nama")%> </td>

                                    <% if Report("Rep_CetakYN") = "N" then %>
                                    <td class="text-center"> 
                                        <button class="btn-wall-seller" onclick="cetak('Y','<%=Report("Rep_ID")%>','<%=Report("Rep_Jenis")%>','<%=Report("Rep_TglAwal")%>','<%=Report("Rep_TglAkhir")%>','<%=Report("Rep_Nama")%>')"> Downcload </button> 
                                    </td>
                                    <% else %>
                                    <td class="text-center"> <span class="text-judul-wallet"> Telah di Download </span> </td>
                                    <% end if  %>
                                    
                                </tr>
                            <%
                                Report.movenext
                                loop
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>



<!-- Popup Chat -->
        <button class="open-button-seller" onclick="openForm()"><img src="<%=base_url%>/assets/logo/bantuan.png" class="me-1" alt="..." id="chat" > Live Chat</button>
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
        function cetak(a,b,c,d,e,f){
            var CetakYN       = a;
            var Rep_ID        = b;
            var Rep_Jenis     = c;
            var Rep_TglAwal   = d;
            var Rep_TglAkhir  = e;
            var Rep_Nama      = f;
            console.log(Rep_Nama);
            $.ajax({
                type: "GET",
                url: "../export-report.asp",
                data: {
                    CetakYN,
                    Rep_ID,
                    Rep_Jenis,
                    Rep_TglAwal,
                    Rep_TglAkhir,
                    Rep_Nama
                },
                success: function (data) {
                    console.log(data);
                    // location.reload();
                }
            });
        }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>