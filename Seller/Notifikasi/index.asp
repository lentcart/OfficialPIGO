<!--#include file="../../connections/pigoConn.asp"-->
<%

    if request.Cookies("custEmail")="" then 
 
    response.redirect("../")
    
    end if

    set Notifikasi_CMD =  server.createObject("ADODB.COMMAND")
    Notifikasi_CMD.activeConnection = MM_PIGO_String

    Notifikasi_CMD.commandText = "SELECT COUNT(NotifIDD) AS SemuaNotif FROM MKT_M_Notifikasi_D WHERE NotifReadYN = 'N'"
    set Notif = Notifikasi_CMD.execute

    Notifikasi_CMD.commandText = "SELECT [NotifID],[NotifName],[NotifAktifYN] FROM [pigo].[dbo].[MKT_M_Notifikasi_H]"
    set NotifHeader = Notifikasi_CMD.execute

    Notifikasi_CMD.commandText = "SELECT MKT_M_Notifikasi_D.NotifIDD, MKT_M_Notifikasi_D.NotifType, MKT_M_Notifikasi_D.NotifDesc, MKT_M_Notifikasi_D.NotifReadYN, MKT_M_Notifikasi_D.NotifUserID, CAST(MKT_M_Notifikasi_D.NotifUpdateTime AS date) AS Tanggal,CONVERT(VARCHAR(5), MKT_M_Notifikasi_D.NotifUpdateTime,108) AS Waktu ,MKT_M_Notifikasi_H.NotifID FROM MKT_M_Notifikasi_D LEFT OUTER JOIN MKT_M_Notifikasi_H ON Left(MKT_M_Notifikasi_D.NotifIDD,2) = MKT_M_Notifikasi_H.NotifID WHERE NotifUserID = '"& request.cookies("custID") &"' ORDER BY NotifUpdateTime DESC "
    set NotifDetail = Notifikasi_CMD.execute

%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="pesanan.css">
        <link rel="stylesheet" type="text/css" href="../../fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../../css/stylehome.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>

        <title>Official PIGO</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
        <script>
        function UpNotif(){
            $.get("update-notif.asp",function(data){
                location.reload();
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

        function semua(){
            var a = document.getElementById('semuaproduk').value;
                location.reload();
            }
        function psbaru(){
            var a = document.getElementById('psbaru').value;
                $.get("pesanan-baru/index.asp",function(data){
                    $('#pesanan-baru').show();
                    $('#diproses').hide();
                    $('#dikirim').hide();
                    $('#semua').hide();
                    $('#selesai').hide();
                    $('#dibatalkan').hide();
                    $('.cont-pesananbaru').html(data);
                });
            }
        function psdiproses(){
            var a = document.getElementById('psdiproses').value;
                $.get("pesanan-diproses/index.asp",function(data){
                    $('#diproses').show();
                    $('#dikirim').hide();
                    $('#pesanan-baru').hide();
                    $('#semua').hide();
                    $('#selesai').hide();
                    $('#dibatalkan').hide();
                    $('.cont-pesanandiproses').html(data);
                });
            }

        function psdikirim(){
            var a = document.getElementById('psdikirim').value;
                $.get("pesanan-dikirim/index.asp",function(data){
                    $('#dikirim').show();
                    $('#diproses').hide();
                    $('#pesanan-baru').hide();
                    $('#semua').hide();
                    $('#selesai').hide();
                    $('#dibatalkan').hide();
                    $('.cont-pesanandikirim').html(data);
                });
            }

        function psselesai(){
            var a = document.getElementById('psselesai').value;
                $.get("pesanan-selesai/index.asp",function(data){
                    $('#selesai').show();
                    $('#diproses').hide();
                    $('#pesanan-baru').hide();
                    $('#semua').hide();
                    $('#dikirim').hide();
                    $('#dibatalkan').hide();
                    $('.cont-pesananselesai').html(data);
                });
            }
        function psdibatalkan(){
            var a = document.getElementById('psdibatalkan').value;
                $.get("pesanan-dibatalkan/index.asp",function(data){
                    $('#dibatalkan').show();
                    $('#selesai').hide();
                    $('#diproses').hide();
                    $('#pesanan-baru').hide();
                    $('#semua').hide();
                    $('#dikirim').hide();
                    $('.cont-pesanandibatalkan').html(data);
                });
            }
        function getPesanan(status){
            var statuspesanan = status.id
            var classactive = statuspesanan;
            console.log(statuspesanan);
            
            document.getElementById("loader-page").style.display = "block";
            $.get(`Get-Pesanan.asp?statusps=${statuspesanan}`,function(data){
                $('#cont-load-pesanan').html(data);
            });
            setTimeout(() => {
                document.getElementById("loader-page").style.display = "none";
                if (statuspesanan == statuspesanan ){
                    $(`#${statuspesanan}`).addClass("active"); 
                }else{
                    $(`#${statuspesanan}`).removeClass("active");
                }
            }, 3000);
        }
            
        
        </script>

    </head>

    <style>
        .cont-list-order-seller{
            margin-top:2.2rem; 
            padding:48px 50px; 
            background-color:none; 
            width:100%;
        }
        .cont-menu-dikemas{
            background-color:#eee;
            padding:7px;
            border-radius:10px;
            color: #0077a2;
            font-weight: 600;
            font-size: 13px;
            border-bottom:5px solid #0077a2;
            border-bottom-left-radius:5px solid #0077a2 ;
        }
        .cont-menu-dikemas:hover{
            background-color:#eee;
            padding:7px;
            border-radius:10px;
            color: #0077a2;
            font-weight: 600;
            font-size: 13px;
            border-bottom:5px solid #940005;
            border-bottom-left-radius:5px solid #940005 ;
        }
        /* Style tab links */
            .tablink {
            background-color: #0077a2;
            color: white;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            border-bottom:2px solid #0077a2;
            padding: 15px 10px;
            font-size: 13px;
            font-weight:450;
            width: 12.5%;
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
        .sidenav {
            height: 85%;
            width: 200px;
            position: fixed;
            z-index: 1;
            top: 3rem;
            left: 0;
            font-family: "Poppins";
            background-color: white;
            overflow-x: auto;
            padding-top: 20px;
            margin:20px
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
            width:85%;
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
        /* Style the tab */
            .tab {
            overflow: hidden;
            background-color: none;
            border:none;
            border-radius:10px;
            
            }
            .tabs {
            background-color: #0077a2;
            color:white;
            border-radius:20px;
            padding:10px 10px;
            
            }

            /* Style the buttons inside the tab */
            .tab button {
            background-color: #0077a2;
            color:white;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            transition: 0.3s;
            font-size: 17px;
            padding:2px 15px;
            }

            /* Change background color of buttons on hover */
            .tab button:hover {
            background-color:#26d8fc86;
            border-radius:20px;
            color:white;
            }
            

            /* Create an active/current tablink class */
            .tab button.active {
            background-color: #0dcaf0;
            color: white;
            border-radius:10px;
            }

            /* Style the tab content */
            .tabcontent {
            display: none;
            padding: 20px 15px;

            }
            .cont-form{
    padding:2px 5px;
    color: #2d2d2d;
    font-size: 13px;
    font-weight: 550;
    border: 1px solid #aaa;
    width: 100%;
    }
    .cont-text{
    color: #0077a2;
    font-weight: 600;
    font-size: 13px;
    }
    .cont-btn{
    border:none;
    background-color: #940005;
    color:#f0f0f0;
    font-size: 13px;
    color:white;
    font-weight: bold;
    border-radius: 5px;
    width:100%;
    }
    .cont-btn:hover{
    border:none;
    background-color: #0077a2;
    color:#f0f0f0;
    color:white;
    font-size: 13px;
    font-weight: bold;
    border-radius: 5px;
    width:100%;
    }

    .cont-notif-detailN{
        background-color:#caecf9;
        border-radius:10px;
        box-shadow:0 3px 5px 0 rgba(0, 0, 0, 0.37), 0 2px 8px 0 rgba(0, 0, 0, 0.19);
        padding:15px 10px;
        font-size:13px;
        font-weight:550;
    }
    .cont-notif-detailN:hover{
        background-color:#52849633;
        padding:15px 10px;
        font-size:13px;
        box-shadow:0 3px 5px 0 rgba(0, 0, 0, 0.37), 0 2px 8px 0 rgba(0, 0, 0, 0.19);
        font-weight:550;
    }
    .cont-notif-detailY{
        background-color:white;
        border-radius:10px;
        box-shadow:0 3px 5px 0 rgba(0, 0, 0, 0.37), 0 2px 8px 0 rgba(0, 0, 0, 0.19);
        padding:15px 10px;
        font-size:13px;
        font-weight:550;
    }
    .cont-notif-detailY:hover{
        background-color:#52849633;
        padding:15px 10px;
        font-size:13px;
        box-shadow:0 3px 5px 0 rgba(0, 0, 0, 0.37), 0 2px 8px 0 rgba(0, 0, 0, 0.19);
        font-weight:550;
    }
    .cont-pesanan{
                background-color:#eee;
                padding:15px 10px;
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
                border:1px solid #0077a2;
            }
            .cont-chat:hover{
                padding:2px 5px;
                width:max-content;
                background-color:#eee;
                font-size:12px;
                font-weight:550;
                color:#0077a2;
                border-radius:4px;
                border:1px solid #0077a2;
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
                border-right: 5px solid #0077a2;
                border-left: 5px solid rgba(150, 169, 169, 0.32);
                border-top: 5px solid #0077a2;
                border-bottom: 5px solid rgba(169, 169, 169, 0.32);
                border-radius: 50%;
                opacity: .6;
                animation: spin 1s linear infinite;
            }
            .cont-loader{
                background-color:#0077a2;
                width:15%;
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
        .menu-notifikasi{
            padding:1vh 2vh;
            background-color:#eee;
            margin-left:10px;
            width:100%
        }
        .sidenav {
            height: max-content;
            width: 200px;
            position: fixed;
            z-index: 1;
            top: 4rem;
            left: 0;
            font-family: "Poppins";
            background-color: white;
            overflow-x: hidden;
            padding-top: 20px;
        }
        ul {
            list-style:none;
            padding:0;
            margin:0;
        }
        li {
            list-style:none;
            padding:8px 0px;
            margin:0;
            color: #0077a2;
            font-weight: 600;
            font-size: 13px;
        }
        li:hover{
            list-style:none;
            padding:8px 0px;
            margin:0;
            font-weight: 600;
            font-size: 13px;
            color:#940005;
        }
        .cont-icon{
            font-weight:bold;
            color:#c70505;
        }
    </style>

<body>
<!--Loader Page-->
    <div id="loader-page" style="display:none">
        <div class="container"id="loader" style="margin-left:50%;position:right; margin-top:18rem"></div>
    </div>
<!--Loader Page-->

<!--Header Seller-->
    <!--#include file="../headerseller.asp"-->
<!--Header Seller-->

<!--Body Seller-->
<div class="sidenav">
    <div class="menu-notifikasi">
        <div class="row">
            <div class="col-12">
                <span class="cont-text"> Semua Notifikasi </span>
            </div>
        </div>
        <div class="row mt-2 mb-2 text-center" style="border-bottom:2px solid #aaa">
        </div>
        <div class="row">
            <div class="col-12">
                <ul>
                    <% do while not NotifHeader.eof %>
                    <li id="<%=NotifHeader("NotifID")%>"> <%=NotifHeader("NotifName")%> </li>
                    <% NotifHeader.movenext
                    loop%>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="main">
    <div class="cont-list-order-seller">
        <div class="row">
            <div class="col-12">
                <div class="row">
                    <div class="col-9">
                        <span class="cont-text"style="font-weight:bold;font-size:15px" > Semua Notifikasi (<%=Notif("SemuaNotif")%>) </span>
                    </div>
                    <div class="col-3">
                        <button onclick="UpNotif()"class="cont-btn"> Tandai Telah Dibaca Semua </button>
                    </div>
                </div>
            <hr>
            <% do while not NotifDetail.eof %>
                <% if NotifDetail("NotifReadYN") = "N" then
                    backgroundNotif = "cont-notif-detailN"
                    else
                    backgroundNotif = "cont-notif-detailY"
                    end if
                %>
                    
                <div class="<%=backgroundNotif%> mb-3">
                    <div class="row align-items-center"> 
                        <div class = "col-1  text-center ">
                            <% if NotifDetail("NotifID") = "02" then%>
                            <span class="cont-icon" style="font-size:25px;" > <i class="fas fa-folder-open"></i>  </span>
                            <% end if %>
                        </div>
                        <div class = "col-11">
                            <span class="cont-text"style="font-weight:bold;font-size:15px" > <%=NotifDetail("NotifType")%>  </span>
                            <div class="row mt-1 align-items-center">
                                <div class = "col-12">
                                    <span class="cont-text" style="color:#2a2a2a; font-size:12px"> <%=NotifDetail("NotifDesc")%>  </span>
                                </div>
                            </div>
                            <div class="row align-items-center">
                                <div class = "col-12">
                                    <span class="cont-text" style="color:#aaa; font-size:11px" > <%=NotifDetail("Tanggal")%> &nbsp; <%=NotifDetail("Waktu")%> </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <% NotifDetail.movenext
            loop %>
            </div>
        </div>
    </div>
</div>


</body>
    <script>

    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>