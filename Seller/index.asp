<!--#include file="../connections/pigoConn.asp"-->
<%

    if request.Cookies("custEmail")="" then 
 
    response.redirect("../")
    
    end if

    set Seller_cmd =  server.createObject("ADODB.COMMAND")
    Seller_cmd.activeConnection = MM_PIGO_String

    Seller_cmd.commandText = "SELECT MKT_M_Customer.custPhoto, MKT_M_Seller.slName,MKT_M_Seller.sl_custID FROM MKT_M_Customer LEFT OUTER JOIN  MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID  where sl_custID = '"& request.Cookies("custID") &"'  group by MKT_M_Customer.custPhoto, MKT_M_Seller.slName,MKT_M_Seller.sl_custID "
    set Seller = Seller_CMD.execute

    set pdSeller_cmd =  server.createObject("ADODB.COMMAND")
    pdSeller_cmd.activeConnection = MM_PIGO_String
    pdSeller_cmd.commandText = "SELECT count(cart_pdID) as totalpd FROM MKT_T_Keranjang where cart_slID = '"& Seller("sl_custID") &"' "
    set pdSeller =pdSeller_CMD.execute

    set Transaksi_CMD =  server.createObject("ADODB.COMMAND")
    Transaksi_CMD.activeConnection = MM_PIGO_String

    Transaksi_CMD.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_H.trID),0) AS trBaru FROM MKT_T_Transaksi_D1 RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_D1A.trD1A WHERE (MKT_T_Transaksi_D1.tr_strID = '00') AND (MKT_T_Transaksi_D1.tr_slID = '"& Seller("sl_custID") &"')  GROUP BY MKT_T_Transaksi_H.trID  "
    set TransaksiBaru = Transaksi_CMD.execute
    
    Transaksi_CMD.commandText = "SELECT COUNT(MKT_T_Transaksi_H.trID) AS PerluDikemas FROM MKT_T_Transaksi_D1 RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_D1A.trD1A WHERE (MKT_T_Transaksi_D1.tr_strID = '01') AND (MKT_T_Transaksi_D1.tr_slID = '"& Seller("sl_custID") &"') GROUP BY MKT_T_Transaksi_H.trID  "
    set PerluDikemas = Transaksi_CMD.execute

    Transaksi_CMD.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdID),0) AS total FROM MKT_T_Transaksi_D1A FULL OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID AND  MKT_T_Transaksi_D1A.trD1A = LEFT(MKT_T_Transaksi_D1.trD1, 12) WHERE MKT_T_Transaksi_D1.tr_slID = '"& Seller("sl_custID") &"' "
    set trSelesai = Transaksi_CMD.execute

    set Listcust_cmd =  server.createObject("ADODB.COMMAND")
    Listcust_cmd.activeConnection = MM_PIGO_String

    Listcust_cmd.commandText = "SELECT MKT_M_Customer.custNama, MKT_T_ChatLive.chat_Penerima, COUNT(MKT_T_ChatLive.chatReadYN) as pesan, MKT_M_Customer.custID, MKT_M_Customer.custEmail FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_ChatLive ON MKT_M_Customer.custID = MKT_T_ChatLive.chat_Pengirim WHERE MKT_T_ChatLive.chat_Penerima = '"& Seller("sl_custID")  &"'  GROUP BY MKT_M_Customer.custNama, MKT_T_ChatLive.chat_Penerima, MKT_M_Customer.custID, MKT_M_Customer.custEmail "
    'response.write Listcust_CMD.commandText & "<br>"
    set Listcust = Listcust_cmd.execute

    set chat_cmd =  server.createObject("ADODB.COMMAND")
    chat_cmd.activeConnection = MM_PIGO_String

%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="seller.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        ' <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>

        <title>PIGO</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

    </head>
    <script>
        $(document).ready(function(){
            setInterval(GetNotifikasi, 5000);
        });

        function GetNotifikasi(){
            $.ajax({
                type: "get",
                url: "Notifikasi/get-notifikasi.asp",
                success: function (url) {
                    var DetailNotif = JSON.parse(url);
                    var status = DetailNotif.statusnotif;
                    console.log(status);

                    if(status == "NULL"){
                        $('.alert-notifikasi').hide();
                    }else{
                        var NotifIDD        = DetailNotif.NotifIDD;
                        var NotifType       = DetailNotif.NotifType;
                        var NotifDesc       = DetailNotif.NotifDesc;
                        var NotifReadYN     = DetailNotif.NotifReadYN;
                        var NotifUserID     = DetailNotif.NotifUserID;
                        var Tanggal         = DetailNotif.Tanggal;
                        var Waktu           = DetailNotif.Waktu;
                        var NotifID         = DetailNotif.NotifID;
                        var ContDetail      = "";
                        ContDetail         +=   `
                                            <input type="hidden" name="StatusNotif" id="StatusNotif" value="Y">
                                            <div class="cont-notif-detail">
                                                <div class="row align-items-center"> 
                                                    <div class = "col-1  text-center ">
                                                        <span class="cont-icon" style="font-size:25px;" > <i class="fas fa-info"></i>  </span>
                                                    </div>
                                                    <div class = "col-11">
                                                        <span class="cont-text"style="font-weight:bold;font-size:15px" > ${NotifType}  </span>
                                                        <div class="row mt-1 align-items-center">
                                                            <div class = "col-12">
                                                                <span class="cont-text" style="color:#2a2a2a; font-size:12px"> ${NotifDesc}  </span>
                                                            </div>
                                                        </div>
                                                        <div class="row align-items-center">
                                                            <div class = "col-12">
                                                                <span class="cont-text" style="color:#aaa; font-size:11px" > ${Tanggal} &nbsp; ${Waktu} </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="hidden" name="NotifID" id="NotifID" value="${NotifIDD}">
                                `
                                document.getElementById("alert-notifikasi").innerHTML = ContDetail ;
                                $('.alert-notifikasi').show();
                    }
                }
            });
        };
        

        function tutupNotif(){
            var NotifID = $('#NotifID').val();
            console.log(NotifID);
            $.ajax({
                type: "get",
                url: "Notifikasi/update-notif.asp",
                data:{
                    NotifID
                },
                success: function (data) {
                    $('.alert-notifikasi').hide();
                }
            });
            
        }
    </script>

    <style>
        .alert-notifikasi{
            display:none;
        }
        .cont-notif-detail{
            background-color:white;
            border-radius:10px;
            box-shadow:0 3px 5px 0 rgba(0, 0, 0, 0.37), 0 2px 8px 0 rgba(0, 0, 0, 0.19);
            padding:2px 2px;
            font-size:13px;
            font-weight:550;
        }
        .cont-notif-detail:hover{
            background-color:#eee;
        }
        .sidenav {
            height: 85%;
            width: 200px;
            position: fixed;
            z-index: 1;
            top: 4.5rem;
            left: 0;
            font-family: "Poppins";
            background-color: white;
            overflow-x: auto;
            padding-top: 20px;
        }
        .itemm {
        position:relative;
        display:inline-block;
        }

        .text-dr{
            padding: 6px 8px 6px 16px;
            text-decoration: none;
            font-size: 12px;
            color: #818181;
            display: block;
            border: none;
            border-radius:20px;
            background: none;
            font-family: "Poppins";
            width: 100%;
            text-align: left;
            cursor: pointer;
            outline: none;
        }

        .main {
            margin-left: 200px; 
            font-size: 20px; 
            padding: 0px 10px;
            font-family: "Poppins";
            padding-top: 20px;
        }


        .dropdown-ct {
            display: none;
            background-color: white;
            padding-left: 8px;
            font-family: "Poppins";
            margin:0;
        }

        .fa-caret-down {
            float: right;
            padding-right: 8px;
        }

        @media screen and (max-height: 450px) {
            .sidenav {padding-top: 15px;}
            .sidenav a {font-size: 18px;}
        }

        .ct {
            max-width: 100%;
            padding: 10px;
        }
        .notify-badgee2{
            position: absolute;
            right:-9px;
            top:-8px;
            max-height:22px;
            max-width:2rem;
            background:red;
            text-align: center;
            border-radius: 100%;
            color:white;
            font-weight:bold;
            font-size:10px;
            padding:3px 5px;

            }
            .end {
            color: #940005;
            float: right;
            font-size: 12px;
            font-weight: bold;
            }

.end:hover,
.end:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
.alert-notifikasi{
    background-color:none;
    padding: 2px 5px;
    border-radius: 10px;
    margin-bottom:1rem;
}
.cont-text{
    color: #0077a2;
    font-weight: 600;
    font-size: 13px;
    }
    .cont-icon{
            font-weight:bold;
            color:#c70505;
        }
    </style>

<body style="background-color:#eee">
<!--Header Seller-->
    <!--#include file="headerseller.asp"-->
<!--Header Seller-->

<!--Body Seller-->
<div class="sidenav">
    <!--#include file="Sidebar.asp"-->
</div>
<div class="main">
    <div style="margin-top:2rem; padding:20px 20px; background-color:#eee">
        <div class="alert-notifikasi">
            <div class="row align-items-center">
                <div class="col-11"  id="alert-notifikasi">
                <input type="hidden" name="NotifID" id="NotifID" value="">
            </div>
            <div class="col-1">
                <button onclick="tutupNotif()" class="end" style="font-size:30px;"><i class="fas fa-times-circle"></i></button>
                
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-9">
            <!--Kategori Transaksi Toko-->
                <div class="row row-kategori div-tab" style="margin:0" >
                    <span class="txt-Judul">Transaksi Toko</span>
                    <div class="col-lg-12 col-md-12 col-sm-12"style="overflow-y:auto;" >
                        <table class="mt-3">
                            <tr>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko"> Pesanan Belum Dibayar </span>
                                            <div class="card-footer">
                                            <% if TransaksiBaru.eof = false then %>
                                                <span class="text-center txt-tr-toko"> <%=TransaksiBaru("trBaru")%> </span>
                                            <% else %>
                                                <span class="text-center txt-tr-toko"> <%=0%> </span>
                                            <% end if %>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko"> Pesanan Baru </span>
                                            <div class="card-footer">
                                                <span class="text-center txt-tr-toko"> 0 </span>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko"> Pesanan Perlu Dikirim </span>
                                            <div class="card-footer">
                                                <span class="text-center txt-tr-toko"> 0 </span>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko">  Dalam Pengiriman</span>
                                            <div class="card-footer">
                                                <span class="text-center txt-tr-toko"> 0 </span>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko"> Pembatalan </span>
                                            <div class="card-footer">
                                                <span class="text-center txt-tr-toko"> 0 </span>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko"> Pengambilan Pesanan </span>
                                            <div class="card-footer">
                                                <span class="text-center txt-tr-toko"> 0 </span>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko"> Pesanan Komplit </span>
                                            <div class="card-footer">
                                                <span class="text-center txt-tr-toko"> 0 </span>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko"> Pesanan Selesai </span>
                                            <div class="card-footer">
                                                <span class="text-center txt-tr-toko"> <%=trSelesai("total")%> </span>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko">Pengiriman Gagal</span>
                                            <div class="card-footer">
                                                <span class="text-center txt-tr-toko"> 0 </span>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                                <td>
                                    <a href="">
                                        <div class="cardd mb-3 me-2">
                                                <span class="text-center txt-tr-toko"> Pesanan Rusak </span>
                                            <div class="card-footer">
                                                <span class="text-center txt-tr-toko"> 0 </span>
                                            </div>
                                        </div>
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div> 
            <!--Kategori Transaksi Toko-->

            <!--Statistik Seller-->
                <div class="row row-kategori div-tab mt-4">
                    <div class="col-12">
                        <span class="txt-Judul mb-4"> Statistik Seller </span>
                        <div class="row mt-3">
                            <div class="col-3">
                                <a href="">
                                    <div class="card-statistik mb-2 me-2">
                                    <span class="text-center txt-statistik txt-tr-toko"> Total Pengunjung </span>
                                        <div class="card-footer">
                                            <span class="text-center txt-dsc"> 0 </span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-3">
                                <a href="">
                                    <div class="card-statistik mb-2 me-2">
                                    <span class="text-center txt-statistik txt-tr-toko"> Produk Dilihat </span>
                                        <div class="card-footer">
                                            <span class="text-center txt-dsc"> 0% </span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-3">
                                <a href="">
                                    <div class="card-statistik mb-2 me-2">
                                    <span class="text-center txt-statistik txt-tr-toko"> Pesanan </span>
                                        <div class="card-footer">
                                            <span class="text-center txt-dsc"> 0 </span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-3">
                                <a href="">
                                    <div class="card-statistik mb-2 me-2">
                                    <span class="text-center txt-statistik txt-tr-toko"> Produk DiKeranjang </span>
                                        <div class="card-footer">
                                            <span class="text-center txt-dsc"> <%=pdseller("totalpd")%> </span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            <!--Statistik Seller-->

            <!--Bisnis Seller-->
                <div class="row row-kategori div-tab mt-4">
                    <div class="col-12">
                        <span class="txt-Judul"> Bisnis Seller </span>
                        <div class="row">
                            <div class="col-12">
                                <div class="row mb-2">
                                    <div class="col-4">
                                        <span class="txt-Judul "> Pendapatan Hari Ini Dan Kemarin </span>
                                    </div>
                                    <div class="col-5">
                                        <a href="">
                                            <div class="card-statistik mb-3 me-2" style="width:100%">
                                            <span class="text-center txt-Judul"> Update Terakhir : <%=now()%> </span>
                                                <div class="card-footer">
                                                    <span class="text-center txt-dsc"> 0% </span>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <canvas id="myChart" style="width:100%;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            <!--Bisnis Seller-->

            <!--Promo Seller-->
                <div class="row row-kategori div-tab mt-4">
                    <div class="col-12">
                        <span class="txt-Judul"> Promosi </span>
                        <div class="row">
                            <div class="col-12">
                                <span class="txt-Judul"> Promo </span>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <span class="txt-Judul"> Fitur Populer </span>
                                <div class="row">
                                    <div class="col-3">
                                        <a href="">
                                            <div class="card-fitur mb-3 me-3" style="width:80%">
                                                <span> Voucher Seller </span>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-3">
                                        <a href="">
                                            <div class="card-fitur mb-3 me-3" style="width:80%">
                                                <span> Promo Seller </span>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-3">
                                        <a href="">
                                            <div class="card-fitur mb-3 me-3" style="width:80%">
                                                <span> Paket Diskon </span>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-3">
                                        <a href="">
                                            <div class="card-fitur mb-3 me-3" style="width:80%">
                                                <span> FlashSale </span>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <!--Promo Seller-->

            <!--Performa Seller-->
                <div class="row row-kategori div-tab mt-4">
                    <div class="col-12">
                        <span class="txt-Judul"> Performa Seller </span>
                        <div class="row">
                            <div class="col-12">

                            </div>
                        </div>
                    </div>
                </div>
            <!--Performa Seller-->
        </div>
        <!--Informasi-->
            <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                <div class="row row-kategori div-tab">
                    <div class="col-12">
                        <span class="txt-Judul"> Informasi Seller </span>
                        <div class="row">
                            <div class="col-12">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <!--Informasi-->
    </div>
</div>

<!-- Popup Chat -->
    <button class="open-button-seller" onclick="openForm()"><img src="<%=base_url%>/assets/logo/bantuan.png" class="me-1" alt="..." id="chat" > <span class="notify-badgee2">99+</span>Live Chat</button>
        
        <div class="chat-popup" id="myForm">
            <div class="form-container">
                <div class="row">
                    <div class="col-9 me-4">
                        <span class="txt-ChatLive"> ChatLive () </span>
                    </div>
                    <div class="col-2">
                        <span class=""  style="font-size:15px"><i onclick="closeForm()" class="fas fa-times-circle me-4"></i><i class="fas fa-list-ul"></i></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-7">
                        <div class="row mt-2 mb-1">
                            <div class="col-12">
                                <div class="roomChat chatseller" id="chatseller">
                                    <div class="row text-center">
                                        <div class="col-12">
                                            <img src="<%=base_url%>/assets/logo/Maskotnew.png"  class="logo" alt="" width="70" height="75" ><br>
                                            <span class="txt-ChatLive"> Selamat Datang Di Fitur Chat  </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-8 me-3">
                                <input Required class="chatStart" type="text" value="" name="isipesan" id="isipesan" placeholder="Masukan Pesan Anda">
                            </div>
                            <div class="col-2">
                                <button onclick="return sendChat()" class="sendChat"> Kirim </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-5">
                        <div class="row ">
                            <div class="col-12">
                                    <div class="s" style="overflow-y:scroll; overflow-x:hidden; height:16.8rem">
                                    <% do while not Listcust.eof %>
                                        <button onclick="return selectsl<%=Listcust("custID")%>()" class="listt mt-2">
                                        <div class="row align-items-center">
                                            <div class="col-2">
                                            <span id="notif" class="notify-badgeee"><%=Listcust("pesan")%></span>
                                                <span class="" style="font-size:22px"> <i class="fas fa-user-circle"></i>  </span>
                                            </div>
                                            <div class="col-8 ">
                                                <input style="border:none; background-color:#cbf6ff" readonly class="txt-ChatDesc" type="text" value="<%=Listcust("custNama")%>" name="A" id="A" style="width:8rem" ><br>
                                                <input style="border:none; background-color:#cbf6ff" readonly class="txt-ChatDesc" type="hidden" value="<%=Listcust("custID")%>" name="customer" id="customer<%=Listcust("custID")%>" style="width:8rem" >
                                            </div>
                                        </div>
                                        </button>
                                        <script>
                                            function selectsl<%=Listcust("custID")%>(){
                                                $.ajax({
                                                    type: "get",
                                                    url: "../Ajax/get-cust.asp?customer="+document.getElementById("customer<%=Listcust("custID")%>").value,
                                                    success: function (url) {
                                                    $('.chatseller').html(url);
                                                    
                                                    }
                                                });
                                            }
                                        </script>
                                    <% Listcust.movenext
                                    loop %>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
                
            </div>
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
        var xValues = ["Januari","Februari","Maret","April","Mei","Juni","Juli","Agustus","September","Oktober","November","Desember"];
        var yValues = [7,8,8,9,9,9,10,11,14,14,60];

        new Chart("myChart", {
        type: "line",
        data: {
            labels: xValues,
            datasets: [{
            fill: false,
            lineTension: 0,
            backgroundColor: "rgba(0,0,255,1.0)",
            borderColor: "rgba(0,0,255,0.1)",
            data: yValues
            }]
        },
        options: {
            legend: {display: false},
            scales: {
            yAxes: [{ticks: {min: 0, max:100}}],
            }
        }
        });

        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var panell = this.nextElementSibling;
            if (panell.style.display === "block") {
            panell.style.display = "none";
            } else {
            panell.style.display = "block";
            }
        });
        }

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

        /* When the user clicks on the button, 
        toggle between hiding and showing the dropdown content */
        function promo() {
        document.getElementById("promo").classList.toggle("show");
        }

        // Close the dropdown if the user clicks outside of it
        window.onclick = function(event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("promo-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
            }
        }
        }
        function kupon() {
        document.getElementById("kupon").classList.toggle("show");
        }

        // Close the dropdown if the user clicks outside of it
        window.onclick = function(event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("promo-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
            }
        }
        }
        function poinreward() {
        document.getElementById("poinreward").classList.toggle("show");
        }

        // Close the dropdown if the user clicks outside of it
        window.onclick = function(event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("promo-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
            }
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
        function sendChat(){
            $.ajax({
                type: "get",
                url: "../ChatLive/chatseller.asp?isipesan="+document.getElementById("isipesan").value+"&customer="+document.getElementById("customer").value,
                success: function (url) {
                // console.log(url);
                $('.chatseller').html(url);
                // console.log(url);
                }
            });
        }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>