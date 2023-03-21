

<%
    set notif_cmd =  server.createObject("ADODB.COMMAND")
    notif_cmd.activeConnection = MM_PIGO_String

    notif_cmd.commandText = "SELECT  MKT_T_Pesanan_H.psID, MKT_T_Transaksi_H.trID, CAST(MIN(MKT_T_Notifikasi.notif_UpdateTime) AS DATE) AS Tanggal, CONVERT(varchar, CAST(MIN(MKT_T_Notifikasi.notif_UpdateTime) AS TIME), 8) AS Waktu,   MKT_T_Notifikasi.notif_UpdateTime, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdID, MKT_M_Produk.pdImage1,  MKT_M_Produk.pdNama, MKT_T_Notifikasi.notif_ID, MKT_T_Notifikasi.notif_ReadYN, MKT_T_StatusTransaksi.strID, produk.pdImage1 AS Gambar, MKT_T_StatusTransaksi.strName, MKT_T_StatusTransaksi.strNameL  FROM MKT_M_Produk AS produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON produk.pdID = MKT_T_Transaksi_D1A.tr_pdID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID ON  MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID RIGHT OUTER JOIN MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Notifikasi LEFT OUTER JOIN MKT_T_Pesanan_H ON MKT_T_Notifikasi.notif_ID = MKT_T_Pesanan_H.psID LEFT OUTER JOIN MKT_T_Pesanan_D ON MKT_T_Pesanan_H.psID = MKT_T_Pesanan_D.psD ON MKT_T_Transaksi_H.trID = MKT_T_Pesanan_H.ps_trID ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND  LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Notifikasi.notif_To = '"& request.Cookies("custID") &"'  GROUP BY MKT_T_Pesanan_H.psID, MKT_T_Transaksi_H.trID, MKT_T_Notifikasi.notif_UpdateTime,  MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdID,  MKT_M_Produk.pdNama, MKT_M_Produk.pdImage1,MKT_T_Notifikasi.notif_ID, MKT_T_Notifikasi.notif_ReadYN, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_StatusTransaksi.strNameL,produk.pdImage1 "
    set notif = notif_CMD.execute
    'response.write "<br><br><br><br><br><br><br><br><br><br>"& notif_cmd.commandText

    set cart_cmd =  server.createObject("ADODB.COMMAND")
    cart_cmd.activeConnection = MM_PIGO_String

    cart_cmd.commandText = "SELECT ISNULL(COUNT(cart_pdID),0) AS total FROM MKT_T_Keranjang where cart_custID = '"& request.cookies("custID") &"' "
    set cart = cart_CMD.execute

    set menjadiseller_cmd =  server.createObject("ADODB.COMMAND")
    menjadiseller_cmd.activeConnection = MM_PIGO_String

    menjadiseller_cmd.commandText = "SELECT MKT_M_Seller.slName FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID Where  MKT_M_Customer.custID = '"& request.cookies("custID") &"'  AND  MKT_M_Alamat.almJenis = 'Alamat Toko' "
    set menjadiseller = menjadiseller_CMD.execute

%>
<script>
    function searchh(){
        var a = document.getElementById('src').value;
        
        if (a == ""){
            $.get("ajax/get-kategori.asp",function(data){
                $('#cont').show();
                $('#cont-search').show();
                $('.modal-src').html(data);

            })        
        }else if ( a !== "" ){
            $.get(`ajax/get-produk.asp?a=${a}`,function(data){
                $('.modal-src').html(data);
            })
        }
    }
    
</script>
<style>
    .itemm {
    position:relative;
    display:inline-block;
    }
    .notify-badgee{
    position: absolute;
    right:-10px;
    height:20px;
    font-weight:bold;
    background:red;
    text-align: center;
    border-radius: 100%;
    color:white;
    font-size:10px;
    padding:2px 5px;
    }
    a {
  text-decoration: none;
}

    .popover__title {
        font-size: 24px;
        line-height: 100px;
        text-decoration: none;
        color: red;
        text-align: center;
        padding: 15px 0;
        background-color:red;
    }

.popover__wrapper {
  position: relative;
  margin-top: 0px;
  display: inline-block;
  

}
.popover__content {
  opacity: 0;
  height:25rem; 
  visibility: hidden;
  position: absolute;
  margin-top:2rem;
  left: -17.5rem;
  transform: translate(0, 10px);
  background-color: white;
  padding: 20px 15px ;
  box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.26);
  width: 22rem;
}
.popover-cont-body{
    height:21.5rem;
    border:2px solid #f0f0f0;
    overflow-y:scroll;
    overflow-x:hidden;
}
.popover__content:before {
  position: absolute;
  z-index: 999;
  width:4.5rem;
  content: "";
  right: calc(4% - 14px);
  top: -10px;
  border-style: solid;
  border-width: 0 0px 10px 0px;
  border-color: transparent transparent white transparent;
  transition-duration: 0.10s;
}
.popover__wrapper:hover .popover__content {
  z-index: 10;
  opacity: 1;
  visibility: visible;
  transform: translate(0, -20px);
  transition: all 0.5s cubic-bezier(0.75, -0.02, 0.2, 0.97);
}
.popover__message {
  text-align: center;
  font-size:12px;
  font-weight:bold;
}
.cont-notif{
  background-color: white;
  font-size: 13px;
  color: #2d2d2d;
  
}
    .notify-badgee1{
    position: absolute;
    right:58px;
    height:6px;
    width:7px;
    top:2px;
    font-weight:bold;
    background:red;
    text-align: center;
    border-radius: 100%;
    color:white;
    font-size:10px;
    }
    .modalud {
    display: none;
    position: fixed;
    z-index: 999;
    font-size: 14px;
    left: 0;
    top: 7rem;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(49, 49, 49);
    background-color: rgba(0, 0, 0, 0.4);
    font-family: "Poppins", sans-serif;
    }
    .closess {
    color:#2d2d2d;
    float: right;
    font-size: 15px;
    font-weight: bold;
    }

    .close:hover,
    .close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
    }
    /* The Modal (background) */
    .modal-seller {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content */
    .modal-content-seller {
    position: relative;
    top:2.5rem;
    border-radius:10px;
    background-color: #fefefe;
    margin: auto;
    padding: 0;
    border: 1px solid #888;
    width: 35%;
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
    -webkit-animation-name: animatetop;
    -webkit-animation-duration: 0.4s;
    animation-name: animatetop;
    animation-duration: 0.4s
    }
    .txt-modal-judul{
    font-size: 13px;
    color: #2d2d2d;
    font-weight: bold;
    }
    .txt-modal-desc{
    font-size: 12px;
    color: #2d2d2d;
    font-weight: bold;
    }
    .btn-konfirmasi{
    border:none;
    background-color: rgb(206, 206, 206);
    border-radius:10px;
    font-size: 11px;
    color:#2d2d2d;
    font-weight: bold;
    }
    .btn-konfirmasi:hover{
    border:none;
    background-color: #9debfb;
    border-radius:10px;
    font-size: 11px;
    color:#2d2d2d;
    font-weight: bold;
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

    /* The Close Button */
    .close {
    color: #eee;
    float: right;
    font-size: 28px;
    font-weight: bold;
    }

    .close:hover,
    .close:focus {
    color: #eee;
    text-decoration: none;
    cursor: pointer;
    }

    .modal-header {
    padding: 10px 15px;
    font-size: 12px;
    background-color: white;
    color: black;
    border-radius:10px;
    }

    .modal-body {padding:5px 15px;}

    .modal-footer {
    padding: 10px 15px;
    background-color: white;
    font-size:12px;
    color: black;
    border-radius:10px;
    }
    .form-namaseller{
        border:1px solid #2d2d2d;
        width:16rem;
        color:#2d2d2d;
        font-size:12px;
        font-weight:bold;
        border-radius:5px;
        padding:2px 10px;
    }
    .btn-namaseller{
        border:none;
        width:2rem;
        background-color:#0dcaf0;
        color:white;
        font-size:12px;
        font-weight:bold;
        border-radius:5px;
        padding:3px 5px;
    }
</style>
<!--Header-->
    <div class="header">
        <div class="cont-hd" style="margin-left:10px; margin-right:10px">
            <div class="navbar d-flex justify-content-between align-items-center navbar-dark head-navbar">
                <div class="d-flex align-items-center me-4" class="icon">
                    <!--<%' if request.cookies("custEmail")<>"" then %> 
                        <a class="nav-link active" href="<%'=base_url%>/Seller/">
                            <img class="icon-media mr-2 ml-2" src="<%'=base_url%>/assets/logo/shop.png" alt=""/><span class="header-font">Seller</span></a>
                    <%' end if %> -->
                    <a class="nav-link active" href="#">
                        <img class="icon-media  ml-2" src="<%=base_url%>/assets/logo/bantuan.png" alt=""/><span class="header-font weight">Halo PIGO</span></a>
                    <span class="header-font weight">Temukan PIGO di</span>
                    <a href="#" >
                        <img class="icon-media ms-2 mr-2 ml-2" src="<%=base_url%>/sosialmedia/fb.png"alt=""/>
                    </a>
                    <a href="#" >
                        <img class="icon-media mr-2" src="<%=base_url%>/assets/logo/instagram.png" alt="" />
                    </a>
                    <a href="#" >
                        <img class="icon-media mr-2" src="<%=base_url%>/sosialmedia/yt.png" alt="" />
                    </a>
                    <a href="#" >
                        <img class="icon-media mr-2" src="<%=base_url%>/assets/logo/tiktok.png" alt="" />
                    </a>
                </div>
                <div class="d-flex align-items-center">
                    <a class="nav-link active" href=""><img class="icon-media" src="<%=base_url%>/assets/logo/info.png" alt=""/><span class="header-font weight">Tentang PIGO</span></a> 
                    <a class="nav-link active" href=""><img class="icon-media" src="<%=base_url%>/assets/logo/promo.png" alt=""/><span class="header-font weight">Promo</span></a> 
                    <div class="popover__wrapper">
                        <div class="itemm">
                            <a href="#">
                                <span class="notify-badgee1"></span>
                                <img src="<%=base_url%>/assets/logo/notification.png"  alt="" width="15" height="15"/>
                                <span class="header-font weight">Notifikasi</span>
                            </a>
                        </div>
                        <div class="popover__content">
                            <div class="popover-cont-body">
                                <div class="row">
                            <div class="col-12">
                                <% if notif.eof = true then %>
                                    <p class=" mt-2 popover__message" style="color:black"> Belum Ada Notifikasi </p>
                                <% else %>
                                <% do while not notif.eof %>
                                    <div class="cont-notif mb-1" style="background-color:#b5e9f3">
                                        <div class="row align-items-center">
                                            <div class="col-2 text-center">
                                                <img src="data:image/png;base64,<%=notif("pdImage1")%>" style="height:50px;width: 50px;" alt=""/>
                                            </div>
                                            <div class="col-10">
                                                <span style="color:black; font-size:10px">Pesanan <b><%=notif("psID")%></b> Transaksi <b><%=notif("trID")%>/</b>  -  <%=notif("strNameL")%></span> <br>
                                                <span style="color:black; font-size:10px"> <%=CDate(notif("Tanggal"))%> - <%=notif("Waktu")%> </span>
                                            </div>
                                        </div>
                                        <%=notif("pdImage1")%>
                                    </div>
                                <% 
                                    notif.movenext
                                    loop 
                                    nomor = no
                                    ' next
                                %>
                                <% end if %>
                            </div>
                        </div>
                            </div>
                            <a href="Customer/Notifikasi/Pesanan/"><p class=" mt-2 popover__message" style="color:black">Tampilkan Semua Notifikasi</p></a>
                        </div>
                    </div>
                    <!--<div class="button mt-1 me-4 ms-4" >
                        <div class="itemm">
                            <a href="#">
                                <span class="notify-badgee1"></span>
                                <img src="<%'=base_url%>/assets/logo/notification.png"  alt="" width="15" height="15"/>
                                <span class="header-font weight">Notifikasi</span>
                            </a>
                        </div>
                    </div>-->
                    <a class="nav-link active" href="<%=base_url%>/Bantuan/"><img class="icon-media" src="<%=base_url%>/sosialmedia/help.png"alt=""/><span class="header-font weight">Bantuan</span></a>
                </div>
            </div>
            <div class="header-search" style="padding:5px 10px">
                <div class="row align-items-center">
                    <div class="col-1">
                        <a class="logo" href="<%=base_url%>/../pigo">
                            <img src="<%=base_url%>/assets/logo/PIGO.png"  class="logo" alt="" width="65" height="70" >
                        </a>
                    </div>
                    <div class=" col-lg-0 col-md-0 col-sm-0 col-1">
                        <a href="<%=base_url%>/../pigo" class="header-font weight" style="font-size:34px"> PIGO </a>
                    </div>
                    <div class="col-7">
                        <input type="search" onclick="return searchh()"  class="form-search-header" name="src" id="src" value="" placeholder=" Cari Barang Terkini"><button class="btn-search-header"><i class="fas fa-search"></i></button>
                    </div>
                    <div class="col-1">
                        <div class="button mt-1 me-4 ms-4" >
                            <div class="itemm">
                                <a href="<%=base_url%>/Cart/">
                                    <span class="notify-badgee"><%=cart("total")%></span>
                                    <img src="<%=base_url%>/assets/logo/cart.png"  alt="" width="30" height="35"/>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-2">
                        <% 
                        if request.cookies("custEmail")="" then 
                        %>
                        <button class="btn-lg" onclick="window.open('<%=base_url%>/Login/','_Self')" > LOGIN </button>
                        <button class="btn-lg" onclick="window.open('<%=base_url%>/Register/','_Self')" > DAFTAR </button>
                    <% 
                    else %>
                        <button class="btn-lgg flex-start" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                            <img class="icon-media" src="<%=base_url%>/assets/logo/cust.png" alt=""/><input class="btn-cust" readonly type="text" name="namacust" id="namacust" value="<%=request.cookies("custNama")%>" style="width:10rem">
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <li><a class="dropdown-item"  style="width:12rem" href="<%=base_url%>/Customer/Profile/"> <i class="fas fa-user"></i> Akun Saya</a></li>
                            <li><a class="dropdown-item" href="<%=base_url%>/Customer/Pesanan/"><i class="fab fa-shopify"></i> Pesanan Saya</a></li>
                            <% if menjadiseller.eof = true then %>
                            <li><button class="dropdown-item" id="myBtn"><i class="fas fa-store"></i> Seller Center </button></li>
                            <% else %>
                            <li><a class="dropdown-item" href="<%=base_url%>/Seller/"><i class="fas fa-shopping-bag"></i> <%=menjadiseller("slName")%> </a></li>
                            <% end if %>
                            
                            <hr>
                            <li><a class="dropdown-item" href="<%=base_url%>/Logout.asp"> <i class=" fa-sign-out"></i> Log Out</a></li>
                        </ul>
                        </div>
                    <% end if %> 
                    </div>
                </div>
            </div>
            <div class="modalud" id="cont">
                <div class="row" id="cont-search"style="display:none; position:absolute; background-color:white; color:grey; width:47.5rem; margin-left:15.3rem; align-items:left; overflow-y:auto; height:15rem; font-size:14px;">
                <div class="col-12 modal-src" >
                </div>
            </div>
            <!--<div class="mb-2">
                    <div class="">
                        <div class="row align-items-center">
                            <div class="logo col-lg-0 col-md-0 col-sm-0 col-1 me-4 ">
                                <a class="logo" href="<%'=base_url%>/../pigo">
                                    <img src="<%'=base_url%>/assets/logo/PIGO.png"  class="logo" alt="" width="65" height="65" >
                                </a>
                            </div>
                            <div class=" col-lg-0 col-md-0 col-sm-0 col-1 ">
                                <a href="<%'=base_url%>/../pigo" class="header-font weight" style="font-size:34px"> PIGO </a>
                            </div>-->

                            <!--<div class="bar col-lg-0 col-md-0 col-sm-0 col-9 ">
                                <form class="d-flex ms-auto my-2 me-4">
                                    <input  onclick="return searchh()" class="me-1" name="src" id="src" type="search" placeholder="Cari Barang Terkini" aria-label="Search" style="width:40rem;heigth:2rem; border-radius:5px; border:1px solid #ececec">
                                    <div class="button">
                                        <button class="btn btn-light" type="submit"><i class="fas fa-search"></i></button>
                                    </div>
                                    <div class="button mt-1 me-4 ms-4" >
                                        <div class="itemm">
                                            <a href="<%'=base_url%>/Keranjang/">
                                                <span class="notify-badgee"><%=cart("total")%></span>
                                                <img src="<%'=base_url%>/assets/logo/cart.png"  alt="" width="30" height="35"/>
                                            </a>
                                        </div>
                                    </div>
                                    <%'if request.cookies("custEmail")="" then 
                                    %>
                                    <div class="button  ms-3 me-1">
                                        <a class="nav-link active" href=""><span class="btn-lg"> LOGIN </span></a>
                                    </div>
                                    <div class="button  me-2">
                                        <a class="nav-link active" href=""><span class="btn-lg"> DAFTAR </span></a>
                                    </div>
                                    <% 'else %>
                                    <div class="button ms-4 me-2">
                                        <button class="btn-lgg flex-start" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                            <img class="icon-media" src="<%'=base_url%>/assets/logo/cust.png" alt=""/><input class="btn-cust" readonly type="text" name="namacust" id="namacust" value="<%'=request.cookies("custNama")%>" style="width:10rem">
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                            <li><a class="dropdown-item"  style="width:12rem" href="<%'=base_url%>/Customer/Profile/">Akun Saya</a></li>
                                            <li><a class="dropdown-item" href="<%'=base_url%>/Customer/Pesanan/">Pesanan Saya</a></li>
                                            <hr>
                                            <li><a class="dropdown-item" href="<%'=base_url%>/Logout.asp">Log Out</a></li>
                                        </ul>
                                        </div>
                                    </div> 
                                    <%' end if %> 
                                </form>
                            </div>
                        </div>-->
        </div>
    </div>
</div>
