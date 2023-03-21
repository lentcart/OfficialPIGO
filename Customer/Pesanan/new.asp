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
        <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.7.0/moment.min.js"></script>
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/moment.min.js"></script>  
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>

        <title>Official PIGO</title>
        
        <script>
        
        </script>
        <style>
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
            .modal-ps03 {
                display: none; 
                position: fixed;
                z-index: 999; 
                padding-top: 100px; 
                left: 0;
                top: 0;
                width: 100%;
                height: 100%; 
                overflow: auto;
                background-color: rgb(0,0,0);
                background-color: rgba(0,0,0,0.4);
                }

                .modal-content-ps03 {
                position: relative;
                background-color: #fefefe;
                margin: auto;
                padding: 0;
                border: 1px solid #888;
                width: 35%;
                top:5rem;
                border-radius:20px;
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
                -webkit-animation-name: animatetop;
                -webkit-animation-duration: 0.4s;
                animation-name: animatetop;
                animation-duration: 0.4s
                }

                @-webkit-keyframes animatetop {
                from {top:-300px; opacity:0} 
                to {top:0; opacity:1}
                }

                @keyframes animatetop {
                from {top:-300px; opacity:0}
                to {top:0; opacity:1}
                }


                .close-ps03 {
                color: white;
                float: right;
                font-size: 28px;
                font-weight: bold;
                }

                .close-ps03:hover,
                .close-ps03:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
                }
                .modal-body-ps03 {
                    padding: 20px 15px;
                    }
            .modal-ps02 {
                display: none; 
                position: fixed;
                z-index: 999; 
                padding-top: 100px; 
                left: 0;
                top: 0;
                width: 100%;
                height: 100%; 
                overflow: auto;
                background-color: rgb(0,0,0);
                background-color: rgba(0,0,0,0.4);
                }

                .modal-content-ps02 {
                position: relative;
                background-color: #fefefe;
                margin: auto;
                padding: 0;
                border: 1px solid #888;
                width: 30%;
                top:5rem;
                border-radius:20px;
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
                -webkit-animation-name: animatetop;
                -webkit-animation-duration: 0.4s;
                animation-name: animatetop;
                animation-duration: 0.4s
                }

                @-webkit-keyframes animatetop {
                from {top:-300px; opacity:0} 
                to {top:0; opacity:1}
                }

                @keyframes animatetop {
                from {top:-300px; opacity:0}
                to {top:0; opacity:1}
                }


                .close-ps02 {
                color: white;
                float: right;
                font-size: 28px;
                font-weight: bold;
                }

                .close-ps02:hover,
                .close-ps02:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
                }
                .modal-body-ps02 {
                    padding: 20px 15px;
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
            /*
            * Basic button style
            */
            .btn-star {
            position: relative;
            font-size: 30px;
            text-decoration: none;
            top: -15px;
            }

            .btn-star-counter:after,
            .btn-star-counter:hover:after { text-shadow: none; }

            /*
            * Custom styles
            */
            .btn-star {
            background-color: none;
            color: #666;
            top: -15px;
            }
            .btn-star:hover,
            .btn-star.active {
            border-color: #0077a2;
            }
            .btn-star span { color: #aaa; }
            .btn-star:hover, .btn-star:hover span,
            .btn-star.active, .btn-star.active span { color: #0077a2; }
            p {
                margin-top: 0;
                margin-bottom: 0px !important;
            }
            .text-judul-track{
                font-size:12px;
                font-weight:bold;
                text-transform: uppercase;
            }
            .step-name{
                font-size:12px;
                font-weight:bold;
                text-transform: uppercase;
            }
            .text-desc-track{
                font-size:11px;
            }

        .StepProgress {
        position: relative;
        padding-left: 45px;
        list-style: none;
        }
            .StepProgress::before {
            display: inline-block;
            content: "";
            position: absolute;
            top: 0;
            left: 15px;
            width: 10px;
            height: 100%;
            border-left: 2px solid #0077a2;
            }
            .StepProgress-item {
            position: relative;
            counter-increment: list;
            }
            .StepProgress-item:not(:last-child) {
            padding-bottom: 10px;
            }
            .StepProgress-item::before {
            display: inline-block;
            content: "";
            position: absolute;
            left: -30px;
            height: 100%;
            width: 25px;
            }
            .StepProgress-item::after {
            content: "";
            display: inline-block;
            position: absolute;
            top: 0;
            left: -39px;
            width: 20px;
            height: 20px;
            border: 2px solid #ccc;
            border-radius: 50%;
            background-color: #fff;
            }
            .StepProgress-item.is-done::before {
            border-left: 2px solid #0077a2;
            }
            .StepProgress-item.is-done::after {
            content: "✔";
            font-size: 12px;
            color: #fff;
            text-align: center;
            border: 2px solid #0077a2;
            background-color: #0077a2;
            }
            .StepProgress-item.done::before {
            border-left: 2px solid #eee;
            }
            .StepProgress-item.done::after {
            content: "✔";
            font-size: 12px;
            color: #fff;
            text-align: center;
            border: 2px solid #0077a2;
            background-color: #0077a2;
            }
            .StepProgress-item.current::before {
            border-left: 2px solid #0077a2;
            }
            .StepProgress-item.current::after {
            content: "";
            padding-top: 1px;
            width: 20px;
            height: 20px;
            left: -39px;
            font-size: 14px;
            text-align: center;
            color: #0077a2;
            border: 2px solid #0077a2;
            background-color: white;
            }
            .StepProgress strong {
            display: block;
            }
            .stepper-wrapper {
            margin-top: 50px;
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            }
            .wrapper-cont {
            height:15rem;
            overflow-y:scroll;
            background:none;
            }
            .stepper-item {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            flex: 1;

            }

            .stepper-item::before {
            position: absolute;
            content: "";
            border-bottom: 2px solid #ccc;
            width: 100%;
            top: 25px;
            left: -50%;
            z-index: 2;
            }

            .stepper-item::after {
            position: absolute;
            content: "";
            border-bottom: 2px solid #ccc;
            width: 100%;
            top: 20px;
            left: 50%;
            z-index: 2;
            }

            .stepper-item .step-counter {
            position: relative;
            z-index: 5;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 50px;
                height: 50px;
            border-radius: 50%;
            background: #0077a2;
            color:white;
            margin-bottom: 6px;
            }
            .step-counter {
            color:white;
            font-size:20px;
            }

            .stepper-item.active {
            font-weight: bold;
            }

            .stepper-item.completed .step-counter {
                border: 2px solid #0077A2;
                color: #0077a2;
                background-color: #f1f1f1;
                font-size: 20px;
            }

            .stepper-item.completed::after {
                position: absolute;
                content: "";
                border-bottom: 2px solid #0077a2;
                width: 100%;
                top: 25px;
                left: 50%;
                z-index: 3;
            }

            .stepper-item:first-child::before {
            content: none;
            }
            .stepper-item:last-child::after {
            content: none;
            }
        </style>
    </head>
<body>
<!--Loader Page-->
    <div id="loader-page" style="display:none">
        <div class="container"id="loader" style="margin-left:50%;position:right; margin-top:18rem"></div>
    </div>
<!--Loader Page-->

<!-- Header -->
    <!--#include file="../../header.asp"-->
<!-- Header -->

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
                <div class="row text-center" >
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="loader1"  id="loader1" style="height:800vh">
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </div>
                </div>
                <div class="semua" id="cont-detail">
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
                            <div class="row text-center" >
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <div class="loader1"  id="loader2" style="height:800vh">
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                    </div>
                                </div>
                            </div>
                            
                                <% 
                                    do while not Transaksi.eof
                                %>
                                     <div class="cont-pesanan mb-3">
                                            <div class="row align-items-center"> 
                                                <div class = "col-10">
                                                    <span style="font-weight:bold;color:#c70505" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> 
                                                    &nbsp;&nbsp; <button class="cont-chat"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> 
                                                    &nbsp;&nbsp; <button class="cont-action" onclick="window.open('<%=base_url%>/Seller/Profile/','_Self')"> Kunjungi Seller </button>
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
                                            <% 
                                                do while not pdtr.eof
                                            %>
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
                                                    <span style="color:#0077a2"> Jumlah Yang Harus Dibayar </span> &nbsp; : &nbsp; <span style="color:#c70505;font-size:19px"> <%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                                                </div>
                                            </div>
                                            <div class="row mt-3"> 
                                                <div class = "col-6">
                                                    <span style="color:#c70505; font-size:11px">Bayar Sebelum ()</span>
                                                </div>
                                                <div class = "text-end col-6">
                                                    <button class="cont-action"> Bayar Sekarang </button> &nbsp; &nbsp;
                                                    <button class="cont-chat"> Hubungi Penjual </button> &nbsp; &nbsp;
                                                </div>
                                            </div>
                                        </div>
                                <%
                                    Transaksi.movenext
                                    loop
                                %>
                            </div>
                        </div>
                    </div>
                    <div class="row text-center ">
                        <div class="col-12">
                            <button  class="cont-more"> Lihat Lainnya </button>
                        </div>
                    </div>
                </div> 
            </div> 
        </div>
    </div>



<!-- Footer -->
<!--#include file="../../footer.asp"-->
<!-- Footer -->
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
        function pesananditerima(trID,slID,custID,total){
            $("#totalpesanan").text(total);
            document.getElementById("myModal-ps02").style.display = "block";
            var span = document.getElementById("close-ps02");
            $("#konfrm-berhasil").hide();
            span.onclick = function() {
                document.getElementById("myModal-ps02").style.display = "none";
            }
            var konfrm = document.getElementById("btn-konfrm");
            konfrm.onclick = function() {
                $.ajax({
                    type:'GET',
                    url: 'Update-Pesanan.asp',
                    data: { 
                        TransaksiID:trID,
                        SellerID:slID,
                        custID:custID
                        
                    },
                    success: function (data){
                        console.log(data);
                        $("#konfrm-berhasil").show();
                        document.getElementById("konfirmasi-pesanan").style.display = "none";
                        $("#konfirmasi-pesanan").hide();
                        $("#btn-back").show();
                        $("#konfrm-berhasil").text("Berhasil Dikonfrimasi");
                        var back = document.getElementById("btn-back");
                        back.onclick = function() {
                            location.reload();
                        }
                    }
                });
                
            }
        }

        function nilaiproduk(trID,slID,custID,total,gambar,nama){
            $("#totalpesanan").text(total);
            $("#NamaProduk").text(nama);
            document.getElementById("myModal-ps03").style.display = "block";
            var span = document.getElementById("close-ps03");
            $("#konfrm-berhasil").hide();
            span.onclick = function() {
                document.getElementById("myModal-ps03").style.display = "none";
            }
            var konfrm = document.getElementById("btn-konfrm");
            konfrm.onclick = function() {
            }
        }
        $('.btn-counter').on('click', function(event, count) {
        event.preventDefault();
        
        var $this = $(this),
            count = $this.attr('data-count'),
            active = $this.hasClass('active'),
            multiple = $this.hasClass('multiple-count');
        $.fn.noop = $.noop;
        $this.attr('data-count', ! active || multiple ? ++count : --count  )[multiple ? 'noop' : 'toggleClass']('active');
        
        });
           
    </script> 
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script> 
</html>