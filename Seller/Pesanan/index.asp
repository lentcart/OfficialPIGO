<!--#include file="../../connections/pigoConn.asp"-->
<%

    if request.Cookies("custEmail")="" then 
 
    response.redirect("../")
    
    end if

    set Seller_cmd =  server.createObject("ADODB.COMMAND")
    Seller_cmd.activeConnection = MM_PIGO_String

    Seller_cmd.commandText = "SELECT  top 10 MKT_M_Customer.custPhoto, MKT_M_Seller.slName FROM MKT_M_Customer LEFT OUTER JOIN  MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID  where sl_custID = '"& request.Cookies("custID") &"'  group by MKT_M_Customer.custPhoto, MKT_M_Seller.slName "
    set Seller = Seller_CMD.execute

    set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT top 10  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi,trUpdateTime, MKT_M_Customer.custNama, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName,MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_H.tr_custID,MKT_T_Transaksi_H.trTotalPembayaran,MKT_T_Transaksi_D1.tr_slID, CONVERT(VARCHAR(5), trUpdateTime,108) AS Waktu, MKT_T_Transaksi_D1.tr_IDBooking,MKT_T_StatusTransaksi.strID FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Customer.custID = MKT_T_Transaksi_H.tr_custID ON left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' GROUP BY  MKT_T_Transaksi_H.trID,trUpdateTime,MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_H.trTglTransaksi, MKT_M_Customer.custNama, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName,MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_H.tr_custID,MKT_T_Transaksi_D1.trPengiriman,MKT_T_Transaksi_D1.tr_IDBooking, MKT_T_StatusTransaksi.strID ORDER BY trUpdateTime DESC"
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute 

    Transaksi_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Transaksi_D1A.tr_pdID),0) AS SemuaTransaksi FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_D1.tr_slID ='"& request.Cookies("custID") &"'"
    'response.write Transaksi_cmd.commandText
    set SemuaTransaksi = Transaksi_CMD.execute
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
        <script src="<%=base_url%>/js/moment.min.js"></script>  
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>

        <title>Official PIGO</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
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

            function semua(){
                var a = document.getElementById('semuaproduk').value;
                    location.reload();
                }
            
            function getPesanan(status){
                var statuspesanan   = status.id
                var classactive     = statuspesanan;
                $.ajax({
                    type:'GET',
                    url: 'Get-Pesanan.asp',
                    data: { 
                        statusps:statuspesanan
                    },
                    success: function (data){
                        document.getElementById("loader2").style.display = "block";
                        document.getElementById("cont-load-pesanan").style.display = "none";
                        $('#cont-load-pesanan').html(data);
                        setTimeout(() => {
                            document.getElementById("loader2").style.display = "none";
                        document.getElementById("cont-load-pesanan").style.display = "block";
                        }, 5000);
                    }
                })
            }
            
            function GetBooking(trID,custID,slID){
                var ckjmlunit    =document.getElementById("JumlahUnit"+trID).checked;
                if(ckjmlunit == true ){
                    var jmlunit = $('#JumlahUnit'+trID).val();
                    Swal.fire({
                        title: 'Do you want to save the changes?',
                        showDenyButton: true,
                        showCancelButton: true,
                        confirmButtonText: 'Save',
                        denyButtonText: `Don't save`,
                        }).then((result) => {
                        /* Read more about isConfirmed, isDenied below */
                        if (result.isConfirmed) {
                            $.ajax({
                                type: 'GET',
                                contentType: "application/json",
                                url: 'Get-BookingID.asp',
                                data:{
                                    jmlunit,
                                    trID,
                                    custID,
                                    slID
                                },
                                traditional: true,
                                success: function (data) {
                                    Swal.fire('Saved!', '', 'success')
                                }
                            })
                        } else if (result.isDenied) {
                            Swal.fire('Changes are not saved', '', 'info')
                        }
                    })
                }else{
                    document.getElementById("text-jmlunit"+trID).textContent="*Packing Pesanan Dijadikan 1";
                    document.getElementById("text-jmlunit"+trID).style.color  = "#7e0909";
                }
                
            }
            
            function detailpesanan(id,status){
                console.log(id);
                console.log(status);
                var trID = id;
                $.ajax({
                    type:'GET',
                    url: 'Detail-Pesanan.asp',
                    data: { 
                        trID
                    },
                    success: function (data){
                        document.getElementById("loader1").style.display = "block";
                        document.getElementById("detailpesanan").style.display = "none";
                        $('#detailpesanan').html(data);
                        setTimeout(() => {
                            document.getElementById("loader1").style.display = "none";
                            document.getElementById("detailpesanan").style.display = "block";
                        }, 5000);
                    }
                })
            }
            
            function back(){
                location.reload();
            }
        </script>

    </head>

    <style>
        .collapsible {
            background-color:white;
            color: black;
            cursor: pointer;
            width: 100%;
            border: none;
            text-align: left;
            outline: none;
            font-size: 12px;
        }

        .active, .collapsible:hover {
            background-color: none;
        }

        li {
            list-style: none;
            padding: 2px;
        }
        .collapsible:after {
            content: 'Lihat Rincian >';
            color: #c70505;
            font-size:13px;
            font-weight: bold;
            float: right;
            margin-left: 5px;
        }
        .wrapper-cont{
            height:max-content;
        }

    .active:after {
    content: "\2212";
    }

    .content {
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.2s ease-out;
    background-color: white;
    }
        .cont-list-order-seller{
            margin-top:2rem; 
            padding:30px 20px; 
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
            top: 4rem;
            left: 0;
            font-family: "Poppins";
            background-color: white;
            overflow-x: auto;
            padding-top: 20px;
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
    font-weight: 450;
    border-radius: 5px;
    width:100%;
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
                width:max-content;
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
        /* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 999; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

.modal-content {
  position: relative;
  background-color: #fefefe;
  margin: auto;
  border-radius:10px;
  padding: 0;
  top:5rem;
  border: 1px solid #888;
  width: 30%;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
  -webkit-animation-name: animatetop;
  -webkit-animation-duration: 0.4s;
  animation-name: animatetop;
  animation-duration: 0.4s
}

/* Add Animation */
@-webkit-keyframes animatetop {
  from {top:-300px; opacity:0} 
  to {top:0; opacity:1}
}

@keyframes animatetop {
  from {top:-300px; opacity:0}
  to {top:0; opacity:1}
}
.modal-body {
	padding: 15px 15px;
}

.modal-footer {
  padding: 10px 15px;
  background-color: #0077a2;
  border-bottom-right-radius:10px;
  border-bottom-left-radius:10px;
}
.statuss{
    text-transform: capitalize;
    }
    .statuspengiriman{
        text-transform: capitalize;
    }
    /* CSS Pesanan Seller */
        .cont-pesanan{
            background-color: #ffffff;
            padding: 20px 20px;
            font-size: 13px;
            font-weight: 550;
            box-shadow: 0 2px 5px 0 rgb(29 29 29 / 20%), 0 6px 10px 0 rgb(14 14 14 / 19%);
            border-radius: 10px;
        }
        .text1-ps-seller{
            font-weight:bold;
            color:#c70505;
            font-size: 13px;
        }
        .text2-ps-seller{
            color:#0077a2;
            font-size: 12px;
        }
        .text3-ps-seller{
            color:#2d2d2d;
            font-size: 12px;
        }
        .text4-ps-seller{
            color:#aaaaaa;
            font-size: 11px;
        }
        .text5-ps-seller{
            color:#c70505;
            font-size: 12px;
        }
        .btn2-ps-seller{
            padding:2px 5px;
            background-color:#eee;
            font-size:12px;
            font-weight:550;
            width:max-content;
            color:#0077a2;
            border-radius:4px;
            border:1px solid #0077a2;
        }
        .btn1-ps-seller{
            padding:2px 5px;
            width:max-content;
            background-color:#0077a2;
            font-size:12px;
            font-weight:550;
            color:white;
            border-radius:4px;
            border:1px solid #0077a2;
        }
        .btn1-ps-seller:hover{
            padding:2px 5px;
            width:max-content;
            background-color:#eee;
            font-size:12px;
            font-weight:550;
            color:#0077a2;
            border-radius:4px;
            border:1px solid #0077a2;
        }
        .loader1 {
            display:none;
            font-size:0px;
            padding:0px;
            margin-top:2rem;
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
    .stepper-wrapper {
            margin-top: 0px;
            display: flex;
            justify-content: space-between;
            margin-bottom: 0px;
            margin-left: -40px;
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
            border-bottom: 2px solid #0077a2;
            width: 100%;
            top: 25px;
            left: -50%;
            z-index: 2;
            }

            .stepper-item::after {
            position: absolute;
            content: "";
            border-bottom: 2px solid #0077a2;
            width: 100%;
            top: 25px;
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
    /* CSS Pesanan Seller */
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
    <!--#include file="../Sidebar.asp"-->
</div>
<div id="x">
    <div class="main">
        <div class="cont-list-order-seller">
            <div class="row text-center">
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
            <div id="detailpesanan">
            <div class="row">
                <div class="col-12">
                    <button onclick="getPesanan(this)" class="tablink" id="y"> Semua</button>
                    <button onclick="getPesanan(this)" class="tablink" id="00"> Belum Bayar</button>
                    <button onclick="getPesanan(this)" class="tablink" id="01"> Perlu Dikirim</button>
                    <button onclick="getPesanan(this)" class="tablink" id="02"> Dikirim</button>
                    <button onclick="getPesanan(this)" class="tablink" id="03"> Selesai</button>
                    <button onclick="getPesanan(this)" class="tablink" id="04"> Pembatalan</button>
                    <button onclick="getPesanan(this)" class="tablink" id="05"> Pengembalian</button>
                    <button onclick="getPesanan(this)" class="tablink" id="06"> Dikomplain</button>
                </div>
            </div>
            <div class="row text-center">
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
            <div class="cont-load-pesanan" id="cont-load-pesanan">
                <div class="row">
                    <div class="col-12">
                        <div class="header-cont-list-order">
                            <div class="row mt-2">
                                <div class="col-7">
                                    <span class="cont-text"> Periode &nbsp; :  </span> &nbsp; 
                                    <input type="date" class="cont-form" name="TanggalAwal" id="TanggalAwal" value="" style="width:max-content"> 
                                    <span class="cont-text"> s.d </span>
                                    <input type="date" class="cont-form" name="TanggalAkhir" id="TanggalAkhir" value="" style="width:max-content"> &nbsp;
                                </div>
                                <div class="col-5 text-end ">
                                    <button class="cont-btn" style="width:max-content" > Export  </button> &nbsp;
                                    <input type="hidden" name="Wall_Jenis" id="Wall_Jenis" value="" >
                                    <input type="hidden" name="Wall_JenisDesc" id="Wall_JenisDesc" value="" >
                                    <button class="cont-btn" style="width:max-content">() List Laporan  </button>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    <select class="cont-form" aria-label="Default select example">
                                        <option value="">Cari Berdasarkan</option>
                                        <option value="1">One</option>
                                        <option value="2">Two</option>
                                        <option value="3">Three</option>
                                    </select>
                                </div>
                                <div class="col-8">
                                    <input type="search" class="cont-form" name="search" id="search" value="">
                                </div>
                                <div class="col-1">
                                    <button class="cont-btn"> Cari </button>
                                </div>
                                <div class="col-1">
                                    <button class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="body-cont-list-order">
                            <div class="row mb-3">
                                <div class="col-2">
                                    <span class="cont-text"> (<%=SemuaTransaksi("SemuaTransaksi")%>) Pesanan </span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                <% if Transaksi.eof = true then %>
                                    <div class="cont-pesanan" style="background-color:white;padding:100px 100px">
                                        <div class="row text-center align-items-center">
                                            <div class="col-12">
                                                <img src="<%=base_url%>/assets/logo/empty.jpg" style="height:20vh;width:20vh;" alt=""/>
                                            </div>
                                        </div>
                                        <div class="row text-center align-items-center">
                                            <div class="col-12">
                                                <span class="text2-ps-seller"> Belum Ada Pesanan </span>
                                            </div>
                                        </div>
                                    </div>
                                <% else %>
                                    <% 
                                        do while not Transaksi.eof 
                                    %>
                                        <div class="cont-pesanan mb-3">
                                            <div class="row align-items-center"> 
                                                <div class="col-8">
                                                    <span class="text1-ps-seller"> <i class="fas fa-user"></i> &nbsp; <%=Transaksi("custNama")%> </span> &nbsp;&nbsp; 
                                                    <button class="btn1-ps-seller"> <i class="fas fa-envelope"></i> &nbsp; Chat </button>
                                                </div>
                                                <div class="text-end col-4">
                                                    <span class="text2-ps-seller">No Transaksi :  <%=Transaksi("trID")%></span> &nbsp; 
                                                    <button class="btn1-ps-seller"> <i class="fas fa-clipboard-list"></i> </button>
                                                </div>
                                            </div>
                                            <hr style="color:#0077a2">
                                            <%
                                                Transaksi_CMD.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama,  pdSku,   MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where  MKT_T_Transaksi_H.tr_custID= '"& Transaksi("tr_custID") &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran "
                                                'response.write Transaksi_CMD.commandText
                                                set pdtr = Transaksi_CMD.execute 
                                            %>
                                            <% 
                                                do while not pdtr.eof 
                                            %>
                                            <div class="row align-items-center"> 
                                                <div class="col-1">
                                                    <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                                                </div>
                                                <div class="col-9">
                                                    <span class="text3-ps-seller"> <%=pdtr("pdNama")%> </span> <br>
                                                    <span class="text4-ps-seller"> <%=pdtr("pdSku")%> </span> <br>
                                                    <span class="text4-ps-seller"> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                                                </div>
                                                <div class="text-end col-2">
                                                    <span class="text5-ps-seller"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                                                </div>
                                            </div>
                                            <hr style="color:#0077a2">
                                            <%
                                                pdtr.movenext
                                                loop
                                            %>
                                            <div class="row"> 
                                                <div class="text-start col-9">
                                                    <span class="text5-ps-seller"> Dibuat : <%=Day(CDate(Transaksi("trUpdateTime")))%>-<%=Month(Transaksi("trUpdateTime"))%>-<%=Year(CDate(Transaksi("trUpdateTime")))%>&nbsp;<%=Transaksi("Waktu")%></span> &nbsp;&nbsp;
                                                    <button class="btn2-ps-seller"><i class="fas fa-info-circle"></i> &nbsp; <%=Transaksi("strName")%> </button> &nbsp;&nbsp; 
                                                    <button class="btn1-ps-seller" onclick="detailpesanan('<%=Transaksi("trID")%>','<%=Transaksi("strID")%>')"><i class="fas fa-file-alt"></i> &nbsp; Detail Pesanan </button>
                                                </div>
                                                <div class="text-end col-3">
                                                    <span class="text2-ps-seller"> Total Pesanan </span> &nbsp; 
                                                    <span class="text5-ps-seller"style="font-size:18px" ><%=Replace(Replace(FormatCurrency(Transaksi("trTotalPembayaran")),"$","Rp. "),".00","")%> </span>
                                                </div>
                                            </div>
                                        </div>
                                
                                    <% 
                                        Transaksi.movenext
                                        loop 
                                    %>
                                <% end if %>
                                </div>
                            </div>
                        </div>
                    </div>
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
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>