<!--#include file="../../connections/pigoConn.asp"--> 

<%
	if request.Cookies("custEmail")="" then 

    response.redirect("../../")
    
    end if



	set customer_cmd =  server.createObject("ADODB.COMMAND")
    customer_cmd.activeConnection = MM_PIGO_String
    customer_cmd.commandText = "select * from MKT_M_Customer where custID = '"& request.Cookies("custID") &"'"
    set customer = customer_CMD.execute

	set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT TOP (10) MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trTotalPembayaran,  MKT_T_Transaksi_H.trID, MKT_M_Customer.custID, MKT_T_Transaksi_D1.tr_IDBooking,trUpdateTime FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_H.trID, 12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A, 12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID LEFT OUTER JOIN MKT_M_Produk ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID WHERE (MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"') GROUP BY MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID,  MKT_M_Customer.custID, MKT_T_Transaksi_D1.tr_IDBooking,trUpdateTime ORDER BY trUpdateTime DESC  "
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute   

    set pdtr_cmd =  server.createObject("ADODB.COMMAND")
    pdtr_cmd.activeConnection = MM_PIGO_String

    set Semuatr_cmd =  server.createObject("ADODB.COMMAND")
    Semuatr_cmd.activeConnection = MM_PIGO_String

    Semuatr_cmd.commandText ="SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdID),0) AS semuatr FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE  MKT_T_Transaksi_H.tr_custID ='"& request.Cookies("custID") &"' "
    'response.write Semuatr_cmd.commandText
    set Semuatr = Semuatr_CMD.execute   

	set pesananbaru_cmd =  server.createObject("ADODB.COMMAND")
    pesananbaru_cmd.activeConnection = MM_PIGO_String
    pesananbaru_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdID),0) AS pesananbaru FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE (MKT_T_Transaksi_D1.tr_strID = '00')  AND MKT_T_Transaksi_H.tr_custID ='"& request.Cookies("custID") &"' "
    'response.write pesananbaru_cmd.commandText
    set pesananbaru = pesananbaru_CMD.execute   

	set diproses_cmd =  server.createObject("ADODB.COMMAND")
    diproses_cmd.activeConnection = MM_PIGO_String
    diproses_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdID),0) AS diproses FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_H.tr_custID ='"& request.Cookies("custID") &"' AND (MKT_T_Transaksi_D1.tr_strID = '01') OR (MKT_T_Transaksi_D1.tr_strID = '05') "
    'response.write diproses_cmd.commandText
    set diproses = diproses_CMD.execute   

	set dikirim_cmd =  server.createObject("ADODB.COMMAND")
    dikirim_cmd.activeConnection = MM_PIGO_String
    dikirim_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdID),0) AS dikirim FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_H.tr_custID ='"& request.Cookies("custID") &"' AND (MKT_T_Transaksi_D1.tr_strID = '02') "
    'response.write dikirim_cmd.commandText
    set dikirim = dikirim_CMD.execute 
    
	set selesai_cmd =  server.createObject("ADODB.COMMAND")
    selesai_cmd.activeConnection = MM_PIGO_String
    selesai_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdID),0) AS selesai FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_H.tr_custID ='"& request.Cookies("custID") &"' AND (MKT_T_Transaksi_D1.tr_strID = '03')"
    'response.write selesai_cmd.commandText
    set selesai = selesai_CMD.execute  

	set dibatalkan_cmd =  server.createObject("ADODB.COMMAND")
    dibatalkan_cmd.activeConnection = MM_PIGO_String
    dibatalkan_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdID),0) AS dibatalkan FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_H.tr_custID ='"& request.Cookies("custID") &"' AND (MKT_T_Transaksi_D1.tr_strID = '04') "
    'response.write dibatalkan_cmd.commandText
    set dibatalkan = dibatalkan_CMD.execute 

    
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="pesanan.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>

        <title>PIGO</title>
        
        <script>
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

            function getPesanan(status){
                var statuspesanan = status.id
                console.log(statuspesanan);
                    $.get(`Get-Pesanan.asp?statusps=${statuspesanan}`,function(data){
                        $('#semuapesanan').html(data);
                    });
                }
        </script>
        <style>
            /* Style tab links */
            .tablink {
            background-color: #0077a2;
            color: white;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 15px 10px;
            font-size: 13px;
            font-weight:450;
            width: 14.2%;
            }

            .tablink:hover {
            background-color: #777;
            }

            /* Style the tab content (and add height:100% for full page content) */
            .tabcontent {
            color: white;
            display: none;
            padding: 100px 20px;
            height: 100%;
            }
            .cont-pesanan{
                background-color:#f1f1f1;
                padding:10px 20px;
                font-size:13px;
                font-weight:550;

            }
            .cont-chat{
                padding:2px 5px;
                width:max-content;
                background-color:#0077a2;
                font-size:12px;
                font-weight:550;
                color:white;
                border-radius:4px;
                border:none;
            }
            .cont-more{
                padding:2px 5px;
                background-color:#0077a2;
                font-size:12px;
                font-weight:550;
                color:white;
                border-radius:4px;
                border:1px solid #0077a2;
            }
            .cont-more:hover{
                padding:2px 5px;
                background-color:white;
                font-size:12px;
                font-weight:550;
                color:#0077a2;
                border-radius:4px;
                border:1px solid #0077a2;
            }
            
            .cont-action{
                padding:2px 5px;
                background-color:#eee;
                font-size:12px;
                font-weight:550;
                color:#0077a2;
                border-radius:4px;
                border:2px solid white;
            }
            .cont-desc{
                color:#aaa;
            }
        </style>
    </head>
<body>
<!-- Header -->
<!--#include file="../../header.asp"-->
<!-- Header -->

<!--Body Seller-->
    <div class="pesanan-cust" style="padding:20px 50px; margin-top:7rem;">
        <div class="row" >
            <div class="col-lg-2 col-md-0 col-sm-0 col-2">
                <button class="dropdown-btn mt-3" >Akun Saya<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct text-dr">
                        <a class="text-dr" href="<%=base_url%>/Customer/Profile/">Profile</a>
                        <a class="text-dr" href="<%=base_url%>/Customer/Alamat/">Alamat Saya </a>
                        <a class="text-dr" href="<%=base_url%>/Customer/Rekening/">Rekening</a>
                    </div>
                <button class="dropdown-btn" >Pesanan<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct text-dr">
                        <a class="text-dr" href="<%=base_url%>/Customer/Pesanan/">Pesanan Saya</a>
                        <a class="text-dr" href="">Pengiriman</a>
                        <a class="text-dr" href="">Pengembalian</a>
                    </div>
                <button class="dropdown-btn" >Notifikasi<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct text-dr">
                        <a class="text-dr" href="<%=base_url%>/Customer/Notifikasi/Pesanan/">Notifikasi Pesanan</a>
                        <a class="text-dr" href="">Notifikasi Chat</a>
                        <a class="text-dr" href="">Promo Official PIGO</a>
                        <a class="text-dr" href="">Penilaian</a>
                        <a class="text-dr" href="">Info Offical PIGO</a>
                    </div>
                <button class="dropdown-btn" >Poin Reward<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct">
                        <a class="text-dr" href="">Poin Reward</a>
                    </div>
            </div>
            <!--Sub Body-->
            <div class="col-10">
                <div class="row">
                    <div class="col-12">
                        <button class="tablink" onclick="getPesanan(this)" id="y">Semua  (<%=Semuatr("Semuatr")%>) </button>
                        <button class="tablink" onclick="getPesanan(this)" id="00">Belum Bayar (<%=pesananbaru("pesananbaru")%>) </button>
                        <button class="tablink" onclick="getPesanan(this)" id="01">Dikemas (<%=diproses("diproses")%>) </button>
                        <button class="tablink" onclick="getPesanan(this)" id="02">Dikirim  (<%=dikirim("dikirim")%>) </button>
                        <button class="tablink" onclick="getPesanan(this)" id="03">Selesai (<%=selesai("selesai")%>) </button>
                        <button class="tablink" onclick="getPesanan(this)" id="04">Dibatalkan (<%=dibatalkan("dibatalkan")%>) </button>
                        <button class="tablink" onclick="getPesanan(this)" id="05">Pengembalian (0) </button>
                    </div>
                </div>
                <div class="row mt-2"> 
                    <div class = "col-12">
                        <div class="semua" id="semuapesanan">
                        <% if Transaksi.eof = true then %>
                            <div class="cont-pesanan" style="background-color:white;padding:100px 100px">
                                <div class="row text-center align-items-center">
                                    <div class="col-12">
                                        <img src="<%=base_url%>/assets/logo/empty.jpg" style="height:20vh;width:20vh;" alt=""/>
                                    </div>
                                </div>
                                <div class="row text-center align-items-center">
                                    <div class="col-12">
                                        <span class="cont-text" style="color:#0077a2"> Belum Ada Pesanan </span>
                                    </div>
                                </div>
                            </div>
                        <% else %>
                            <% 
                                do while not Transaksi.eof
                            %>
                                <% if Transaksi("strID") = "00" then %>
                                    <div class="cont-pesanan mb-3">
                                        <div class="row align-items-center"> 
                                            <div class = "col-10">
                                                <span style="font-weight:bold;color:#c70505" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> &nbsp;&nbsp; <button class="cont-chat"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> &nbsp;&nbsp;
                                                <button class="cont-action"> Kunjungi Seller </button>
                                            </div>
                                            <div class = " text-end col-2">
                                                <span style="color:#0077a2"> <%=Transaksi("strName")%></span>
                                            </div>
                                        </div>
                                        <hr style="color:#0077a2">
                                        <%
                                            pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
                                            'response.write pdtr_cmd.commandText
                                            set pdtr = pdtr_CMD.execute 
                                        %>
                                        <% do while not pdtr.eof %>
                                        <div class="row"> 
                                            <div class = "col-1">
                                                <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                                            </div>
                                            <div class = "col-9">
                                                <span> <%=pdtr("pdNama")%> </span> <br>
                                                <span class="cont-desc"> <%=pdtr("pdSku")%> </span> <br>
                                                <span> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                                            </div>
                                            <div class = " text-end col-2">
                                                <span style="color:#c70505"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                                            </div>
                                        </div>
                                        <hr style="color:#0077a2">
                                        <%
                                            pdtr.movenext
                                            loop
                                        %>
                                        <div class="row"> 
                                            <div class = " text-end col-10">
                                                <span style="color:#0077a2"> Jumlah Yang Harus Dibayar </span>
                                            </div>
                                            <div class = " text-end col-2">
                                                <span style="color:#c70505"> <%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                                            </div>
                                        </div>
                                        <div class="row mt-3"> 
                                            <div class = "col-6">
                                                <span style="color:#c70505">Bayar Sebelum ()</span>
                                            </div>
                                            <div class = "text-end col-6">
                                                <button class="cont-action"> Bayar Sekarang </button> &nbsp; &nbsp;
                                                <button class="cont-chat"> Hubungi Penjual </button> &nbsp; &nbsp;
                                                <div class="dropdown">
                                                        <button class="cont-chat txt-desc dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                                        Lainnya
                                                        </button>
                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                                            <li>
                                                                <button class="btn-sp txt-desc" onclick="window.open('lappdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&spID='+document.getElementById('customer').value,'_Self')">Laporan PDF</button>
                                                            </li>
                                                            <li>
                                                                <button class="btn-sp txt-desc" onclick="window.open('lapexc.asp?spID='+document.getElementById('customer').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Excel </button>
                                                            </li>
                                                        </ul>
                                                    </div>
                                            </div>
                                        </div>
                                    </div>
                                <% else if Transaksi("strID") = "01" then %>
                                    <div class="cont-pesanan mb-3">
                                        <div class="row align-items-center"> 
                                            <div class = "col-6">
                                                <span style="font-weight:bold;color:#c70505" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> &nbsp;&nbsp; <button class="cont-chat"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> &nbsp;&nbsp;
                                                <button class="cont-action"> Kunjungi Seller </button>
                                            </div>
                                            <div class = " text-end col-4" style="border-right:2px solid #c70505">
                                            <% if Transaksi("tr_IDBooking") = "" then %>
                                                <span style="color:#c70505; font-size:12px"><i class="fas fa-box"></i>&nbsp;Seller sedang menyiapkan pesanan anda</span>
                                            <% else %>
                                                <span style="color:#c70505; font-size:12px"><i class="fas fa-truck"></i>&nbsp;Menunggu paket diserahkan ke pihak jasa kirim</span>
                                            <% end if %>
                                            </div>
                                            <div class = " text-end col-2">
                                                <span style="color:#0077a2"> <%=Transaksi("strName")%></span>
                                            </div>
                                        </div>
                                        <hr style="color:#0077a2">
                                        <%
                                            pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
                                            'response.write pdtr_cmd.commandText
                                            set pdtr = pdtr_CMD.execute 
                                        %>
                                        <% do while not pdtr.eof %>
                                        <div class="row"> 
                                            <div class = "col-1">
                                                <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                                            </div>
                                            <div class = "col-9">
                                                <span> <%=pdtr("pdNama")%> </span> <br>
                                                <span class="cont-desc"> <%=pdtr("pdSku")%> </span> <br>
                                                <span> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                                            </div>
                                            <div class = " text-end col-2">
                                                <span style="color:#c70505"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                                            </div>
                                        </div>
                                        <hr style="color:#0077a2">
                                        <%
                                            pdtr.movenext
                                            loop
                                        %>
                                        <div class="row"> 
                                            <div class = " text-end col-12">
                                                <span style="color:#0077a2"> Total Pesanan </span> &nbsp; : &nbsp; <span style="color:#c70505;font-size:19px"> <%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                                            </div>
                                        </div>
                                        <div class="row mt-3"> 
                                            <div class = "col-8">
                                                <span style="color:#c70505">Produk akan dikirim paling lambat pada : </span>
                                            </div>
                                            <div class = "text-end col-4">
                                                <button class="cont-action"> Hubungi Penjual </button> &nbsp; &nbsp;
                                                <button class="cont-chat"> Batalkan Pesanan </button>
                                            </div>
                                        </div>
                                    </div>
                                <% else if Transaksi("strID") = "02" then %>

                                <% else if Transaksi("strID") = "03" then %>

                                <% else if Transaksi("strID") = "04" then %>

                                <% else if Transaksi("strID") = "05" then %>

                                <% end if %><% end if %><% end if %><% end if %><% end if %><% end if %>
                            <%
                                Transaksi.movenext
                                loop
                            %>
                        <% end if %>
                        </div>
                    </div>
                </div>
                <div class="row text-center ">
                    <div class="col-12">
                        <button  class="cont-more"> Lihat Lainnya </button>
                    </div>
                </div>
                        <div id="pesanan-baru" class="ps-cust mt-2" style="display:block">
                            <div class="row" id="row-pesananbaru">
                                <div class="col-12 cont-pesananbaru">
                                    
                                </div>
                            </div>
                        </div>
                        <div id="diproses" class="ps-cust mt-2" style="display:none">
                            <div class="row" id="row-pesanandiproses">
                                <div class="col-12 cont-pesanandiproses">
                                    
                                </div>
                            </div>
                        </div>

                        <div id="dikirim" class="ps-cust mt-2" style="display:none">
                            <div class="row" id="row-pesanandikirim">
                                <div class="col-12 cont-pesanandikirim">
                                    
                                </div>
                            </div>
                        </div>

                        <div id="selesai" class="ps-cust mt-2" style="display:none">
                            <div class="row" id="row-pesananselesai">
                                <div class="col-12 cont-pesananselesai">
                                    
                                </div>
                            </div>
                        </div>
                        <div id="dibatalkan" class="ps-cust mt-2" style="display:none">
                            <div class="row" id="row-pesanandibatalkan">
                                <div class="col-12 cont-pesanandibatalkan">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>
</div>
</div>
<!--#include file="../../footer.asp"-->
</body>
    <script>
        // Dropdown Button
            var dropdown = document.getElementsByClassName("dropdown-btn");
                var i;
                    for (i = 0; i < dropdown.length; i++) {
                    dropdown[i].addEventListener("click", function() {
                    this.classList.toggle("active");
                    var dropdownContent = this.nextElementSibling;
                        if (dropdownContent.style.display === "block") {
                            dropdownContent.style.display = "none";
                        }else {
                            dropdownContent.style.display = "block";
                        }
                    });
                }
        // Dropdown Button
    </script> 
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script> 
    <% Server.execute ("../getTransaksiUpdateCust.asp") %>
</html>