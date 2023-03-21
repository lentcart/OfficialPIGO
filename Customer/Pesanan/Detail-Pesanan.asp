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

    Transaksi_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trTotalPembayaran,  MKT_T_Transaksi_H.trID, MKT_M_Customer.custID, MKT_T_Transaksi_D1.tr_IDBooking, MKT_T_Transaksi_H.trUpdateTime, MKT_M_Alamat.alm_custID, MKT_T_Transaksi_H.tr_almID, MKT_M_Alamat.almNamaPenerima,  MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos,  MKT_M_Alamat.almLengkap,MKT_T_Transaksi_H.tr_PaidAt FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Alamat.almID = MKT_T_Transaksi_H.tr_almID RIGHT OUTER JOIN MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID ON LEFT(MKT_T_Transaksi_H.trID, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID WHERE (MKT_T_Transaksi_H.trID = 'TR0802230002') GROUP BY MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID,  MKT_M_Customer.custID, MKT_T_Transaksi_D1.tr_IDBooking, MKT_T_Transaksi_H.trUpdateTime, MKT_M_Alamat.alm_custID, MKT_T_Transaksi_H.tr_almID, MKT_M_Alamat.almNamaPenerima,  MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos,  MKT_M_Alamat.almLengkap,MKT_T_Transaksi_H.tr_PaidAt "
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
            .progressbar-wrapper {
      background: #eee;
      width: 100%;
      padding-top: 5px;
      padding-bottom: 5px;
}

.progressbar li {
      list-style-type: none;
      width: 20%;
      float: left;
      font-size: 20px;
      left: -15px;
      position: relative;
      text-align: center;
      text-transform: uppercase;
      color: #0077a2;
}
.progressbar li:before {
    width: 60px;
    height: 60px;
    content: counter(list);
    line-height: 60px;
    border: 2px solid #0077a2;
    display: block;
    text-align: center;
    margin: 0 auto 3px auto;
    border-radius: 50%;
    position: relative;
    z-index: 2;
    background-color: #fff;
}
.progressbar li:after {
     width: 100%;
     height: 2px;
     content: counter(list);
     position: absolute;
     background-color: #0077a2;
     top: 30px;
     left: -50%;
     z-index: 0;
}
.progressbar li:first-child:after {
     content: none;
}.progressbar li:before {
    width: 60px;
    height: 60px;
    content: "";
    line-height: 60px;
    border: 2px solid #0077a2;
    display: block;
    text-align: center;
    margin: 0 auto 3px auto;
    border-radius: 50%;
    position: relative;
    z-index: 2;
    background-color: #fff;
}
.progressbar li:after {
     width: 100%;
     height: 2px;
     content: '';
     position: absolute;
     background-color: #0077a2;
     top: 30px;
     left: -50%;
     z-index: 0;
}
.progressbar li:first-child:after {
     content: none;
}
.progressbar li:before {
    width: 60px;
    height: 60px;
    content: "";
    line-height: 60px;
    border: 2px solid #0077a2;
    display: block;
    text-align: center;
    margin: 0 auto 3px auto;
    border-radius: 50%;
    position: relative;
    z-index: 2;
    background-color: #fff;
}
.progressbar li:after {
     width: 100%;
     height: 2px;
     content: '';
     position: absolute;
     background-color: #0077a2;
     top: 30px;
     left: -50%;
     z-index: 0;
}
.progressbar li:first-child:after {
     content: none;
}
.progressbar li.active:before {
    background: #0077a2 ;
    content: '\2713';
    color:white;
    font-size:content 20px; 
  font: var(--fa-font-regular);
    background-size: 60%;
}
.progressbar a {
    color:white;
    font-size:11px; 
    top:90px !important
}
.progressbar li::before {
    background: #fff;
    background-size: 60%;
    content: '\f057';
    color:#0077a2;
    padding: 15px;
    font-size:content 20px; 
  font: var(--fa-font-brands);
}
.icon{
    font-size:14px;
    bottom:-50px
}
.desc{
    font-size:11px;
    color
}
p {
    margin-top: 0;
    margin-bottom: 0rem;
}
.wrapper {
  width: 330px;
  font-family: 'Helvetica';
  font-size: 14px;
  border: 1px solid #CCC;
}

.StepProgress {
  position: relative;
  padding-left: 45px;
  list-style: none;
  
}
.StepProgress::before {
    display: inline-block;
    content: '';
    position: absolute;
    top: 0;
    left: 15px;
    width: 10px;
    height: 100%;
    border-left: 2px solid #CCC;
  }
  
 .StepProgress-item {
    position: relative;
    counter-increment: list;
    
}.StepProgress:not(:last-child) {
      padding-bottom: 20px;
    }
    
    .StepProgress::before {
      display: inline-block;
      content: '';
      position: absolute;
      left: -30px;
      height: 100%;
      width: 10px;
    }
    
    .StepProgress::after {
      content: '';
      display: inline-block;
      position: absolute;
      top: 0;
      left: -37px;
      width: 12px;
      height: 12px;
      border: 2px solid #CCC;
      border-radius: 50%;
      background-color: #FFF;
    }
    
 
      .StepProgress.is-done::before {
        border-left: 2px solid green;
      }
     .StepProgress.is-done::after {
        content: counter(list);
        font-size: 10px;
        color: #FFF;
        text-align: center;
        border: 2px solid green;
        background-color: green;
      }
    
    
      .StepProgress::before {
        border-left: 2px solid green;
      }
      
      .StepProgress::after {
        content: counter(list);
        padding-top: 1px;
        width: 19px;
        height: 18px;
        top: -4px;
        left: -40px;
        font-size: 14px;
        text-align: center;
        color: green;
        border: 2px solid green;
        background-color: white;
      }
  
  strong {
    display: block;
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
                <div class="row mt-2"> 
                    <div class = "col-12">
                        <div class="cont-pesanan mb-3">
                            <div class="row align-items-center"> 
                                <div class = "col-6">
                                    <span style="font-weight:bold;color:#c70505" > No Transaksi : <%=Transaksi("trID")%> </span>
                                </div>
                                <div class = " text-end col-6">
                                    <% if Transaksi("tr_IDBooking") = "" then %>
                                        <span style="color:#c70505;"><i class="fas fa-box"></i> &nbsp; Seller sedang menyiapkan pesanan anda</span>
                                    <% else %>
                                        <script>
                                        $.get( "Get-StatusPengiriman.asp?SuratJalan=<%=Transaksi("trID")%>&StatusSend=", function( data ) {
                                            var jsonData = JSON.parse(data);
                                            console.log(jsonData.Keterangan);
                                            $("#statusdev<%=Transaksi("trID")%>").text(jsonData.Keterangan);
                                        });
                                            </script>
                                        <span style="color:#c70505; font-size:12px"><i class="fas fa-truck"></i> &nbsp; <span style="color:#c70505; font-size:12px"  id="statusdev<%=Transaksi("trID")%>"></span></span>
                                    <% end if %>
                                </div>
                            </div>
                            <hr>
                            <div class="row mb-3 "> 
                                <div class = "col-12">
                                    <div class="progressbar-wrapper">
                                        <ul class="progressbar">
                                        <%  if  Transaksi("strID") = "00" then %>
                                            <li class="active"> 
                                                <span class="icon">Pesanan Dibuat</span>
                                                <p class="desc"><%=Transaksi("trUpdatetime")%></p>
                                            </li>
                                            <li class="nonactive">  <span class="icon">Pesanan Dibayarkan</span> </li>
                                            <li class="nonactive">  <span class="icon">Sedang Dikemas</span> </li>
                                            <li class="nonactive">  <span class="icon">Dikirim</span></li>
                                            <li class="nonactive">  <span class="icon">Dinilai</span></li>
                                        <% end if %>
                                        <%  if  Transaksi("strID") = "01" then %>
                                            <li class="active"> 
                                                <span class="icon">Pesanan Dibuat</span>
                                                <p class="desc"><%=Transaksi("trUpdatetime")%></p>
                                            </li>
                                            <li class="active">  
                                                <span class="icon">Pesanan Dibayarkan</span> 
                                                <%  if  Transaksi("tr_PaidAt") <> "" then %>
                                                    <p class="desc">(<%=Transaksi("trTotalPembayaran")%>)</p>
                                                    <p class="desc"><%=Transaksi("tr_PaidAt")%></p>
                                                <% end if %>
                                            </li>
                                            <li class="active">  
                                                <span class="icon">Sedang Dikemas</span> 
                                            </li>
                                            <li class="nonactive">  <span class="icon">Dikirim</span></li>
                                            <li class="nonactive">  <span class="icon">Dinilai</span></li>
                                        <% end if %>
                                        <%  if  Transaksi("strID") = "02" then %>
                                            <li class="active"> 
                                                <span class="icon">Pesanan Dibuat</span>
                                                <p class="desc"><%=Transaksi("trUpdatetime")%></p>
                                            </li>
                                            <li class="active">  
                                                <span class="icon">Pesanan Dibayarkan</span> 
                                                <%  if  Transaksi("tr_PaidAt") <> "" then %>
                                                    <p class="desc">(<%=Transaksi("trTotalPembayaran")%>)</p>
                                                    <p class="desc"><%=Transaksi("tr_PaidAt")%></p>
                                                <% end if %>
                                            </li>
                                            <li class="active"> 
                                                <script>
                                                    $.get( "Get-StatusBooking.asp?BookingID=<%=Transaksi("tr_IDBooking")%>", function( data ) {
                                                        var jsonData = JSON.parse(data);
                                                        var jsonData = JSON.parse(data);
                                                        var a        = jsonData.detail
                                                        var last = Object.keys(a).pop();
                                                        $("#statusdev").text(a[last].tanggal);
                                                        
                                                    });
                                                    
                                                    </script>
                                                <span class="icon">Pesanan Dikirimkan</span> 
                                                <p class="desc" id="statusdev"></p>
                                            </li>
                                            <li class="active">  
                                                <span class="icon">Dikirim</span>
                                            </li>
                                            <li class="nonactive">  <span class="icon">Dinilai</span></li>
                                        <% end if %>
                                        <%  if  Transaksi("strID") = "03" then %>
                                            <li class="active"> 
                                                <span class="icon">Pesanan Dibuat</span>
                                                <p class="desc"><%=Transaksi("trUpdatetime")%></p>
                                            </li>
                                            <li class="active">  
                                                <span class="icon">Pesanan Dibayarkan</span> 
                                                <%  if  Transaksi("tr_PaidAt") <> "" then %>
                                                    <p class="desc">(<%=Transaksi("trTotalPembayaran")%>)</p>
                                                    <p class="desc"><%=Transaksi("tr_PaidAt")%></p>
                                                <% end if %>
                                            </li>
                                            <li class="active"> 
                                                <script>
                                                    $.get( "Get-StatusBooking.asp?BookingID=<%=Transaksi("tr_IDBooking")%>", function( data ) {
                                                        var jsonData = JSON.parse(data);
                                                        var jsonData = JSON.parse(data);
                                                        var a        = jsonData.detail
                                                        var last = Object.keys(a).pop();
                                                        $("#statusdev").text(a[last].tanggal);
                                                    });
                                                    </script>
                                                <span class="icon">Pesanan Dikirimkan</span> 
                                                <p class="desc" id="statusdev"></p>
                                            </li>
                                            <li class="active">  
                                                <span class="icon">Pesanan Diterima</span>
                                            </li>
                                            <li class="nonactive">  <span class="icon">Belum Dinilai</span></li>
                                        <% end if %>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <hr style="color:#0077a2">
                            <div class="row "> 
                                <div class="col-8">
                                    <span style="font-weight:bold;color:#c70505" > Alamat Pengiriman </span>
                                </div>
                            </div>
                            <div class="row mt-3"> 
                                <div class="col-4" style="border-right:2px solid #aaa">
                                    <span style="color:#0077a2; font-size:15px"> <%=Transaksi("almNamaPenerima")%></span><br>
                                    <span style="font-size:12px"> ( <%=Transaksi("almPhonePenerima")%> ) </span><br>
                                    <span style=" font-size:12px"><%=Transaksi("almLengkap")%></span><br>
                                    <span style=" font-size:12px"><%=Transaksi("almKota")%>, <%=Transaksi("almKec")%>, <%=Transaksi("almKel")%>, <%=Transaksi("almProvinsi")%>, <%=Transaksi("almKdPos")%></span><br>

                                </div>
                                <div class="col-8">
                                    <div class="wrapper">
                                            <ul class="StepProgress">
                                            <li class="StepProgress-item is-done"><strong>Pesanan Dibuat</strong>
                                                01-02-20223 4.25 pm
                                            </li>
                                            <li class="StepProgress-item is-done"><strong>Pesanan Sedang Dikemas</strong>
                                                Telah Dibuatkan BTT oleh PT Dakota 
                                                01-02-20223 4.25 pm
                                            </li>
                                            <li class="StepProgress-item current"><strong>Post a contest</strong></li>
                                            <li class="StepProgress-item"><strong>Handover</strong></li>
                                            <li class="StepProgress-item"><strong>Provide feedback</strong></li>
                                            </ul>
                                            </div>
                                </div>
                            </div>
                            <hr style="color:#0077a2">
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
                                pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, SUM(MKT_T_Transaksi_D1A.tr_pdHarga*MKT_T_Transaksi_D1A.tr_pdQty) AS SubtotalProduk, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
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
                                TotalProduk = pdtr("SubtotalProduk")
                            %>
                            <%
                                pdtr.movenext
                                loop
                            %>
                            <%
                                SubtotalProduk = SubtotalProduk + TotalProduk
                            %>
                            <div class="row"> 
                                <div class = "col-12">
                                    <table class="table">
                                        <tr>
                                            <td class="text-end">Sub Total Produk </td>
                                            <td class="text-end"><%=SubtotalProduk%> </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end">Total Proteksi Produk </td>
                                            <td class="text-end">c </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end">Sub Total Pengiriman </td>
                                            <td class="text-end">c </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end">Total Pesanan </td>
                                            <td class="text-end">c </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end">Total Pesanan </td>
                                            <td class="text-end">c </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end"> Metode Pembayaran </td>
                                            <td class="text-end">c </td>
                                        </tr>
                                    </table>
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
        $(document).ready(function(){
            var BookingID = <%=Transaksi("tr_IDBooking")%>
            $.get( `Get-StatusBooking.asp?BookingID=${BookingID}`, function( data ) {
                var jsonData        = JSON.parse(data);
                var contDetail      = jsonData.detail
                const firstValue    = Object.values(contDetail)[0];
                var tglbooking      = firstValue.tanggal
                function convertDate(tglbooking) {
                function pad(s) { return (s < 10) ? '0' + s : s; }
                var d = new Date(tglbooking)
                return [pad(d.getDate()), pad(d.getMonth()+1), d.getFullYear()].join('/')
                }
                var Tanggal = convertDate(tglbooking)
                const [dateComponents, timeComponents] = tglbooking.split(' ');
                var convertedTime = moment(timeComponents+" PM", 'hh:mm A').format('HH:mm')
                var Waktu = convertedTime;
                $("#tgl").text(Tanggal);
                $("#wkt").text(Waktu);
            });
        });
    </script> 
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script> 
    <% Server.execute ("../getTransaksiUpdateCust.asp") %>
</html>