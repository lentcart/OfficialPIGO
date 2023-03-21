<%
    
    set Notifikasi_CMD =  server.createObject("ADODB.COMMAND")
    Notifikasi_CMD.activeConnection = MM_PIGO_String

    Notifikasi_CMD.commandText = "SELECT COUNT(NotifIDD) AS SemuaNotif FROM MKT_M_Notifikasi_D WHERE NotifReadYN = 'N'"
    set Notif = Notifikasi_CMD.execute

    set menjadiseller_cmd =  server.createObject("ADODB.COMMAND")
    menjadiseller_cmd.activeConnection = MM_PIGO_String

    menjadiseller_cmd.commandText = "SELECT MKT_M_Seller.slName FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID Where  MKT_M_Customer.custID = '"& request.cookies("custID") &"'  AND  MKT_M_Alamat.almJenis = 'Alamat Toko' "
    set menjadiseller = menjadiseller_CMD.execute

    set Seller_cmd =  server.createObject("ADODB.COMMAND")
    Seller_cmd.activeConnection = MM_PIGO_String

    Seller_cmd.commandText = "SELECT MKT_M_Customer.custPhoto, MKT_M_Seller.slName FROM MKT_M_Customer LEFT OUTER JOIN  MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID  where sl_custID = '"& request.Cookies("custID") &"'  group by MKT_M_Customer.custPhoto, MKT_M_Seller.slName "
    set Seller = Seller_CMD.execute

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
    .notify-badgee {
    position: absolute;
    right: -4px;
    top: -6px;
    height: max-content;
    width: max-content;
    background: #f1020a;
    text-align: center;
    border-radius: 50px;
    color: #ffffff;
    font-weight: 600;
    font-size: 11px;
    padding: 0px 6px;
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
            <div class="header-search" style="padding:20px 10px">
                <div class="row align-items-center">
                    <div class=" col-lg-0 col-md-0 col-sm-0 col-2">
                        <a href="<%=base_url%>/Seller/" class="header-font weight" style="font-size:25px"> Seller Center </a>
                    </div>
                    <div class="col-7">
                        <input type="search" onclick="return searchh()"  class="form-search-header" name="src" id="src" value="" placeholder=" Cari Informasi Terkini Mengenai Seller"><button class="btn-search-header"><i class="fas fa-search"></i></button>
                    </div>
                    <div class="col-1">
                        <div class="button mt-1 me-4 ms-4" >
                            <div class="itemm">
                                <a href="<%=base_url%>/Seller/Notifikasi/">
                                    <span class="notify-badgee"><%=Notif("SemuaNotif")%></span>
                                    <img src="<%=base_url%>/assets/logo/notification.png"  alt="" width="25" height="25"/>
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
                            <li><a class="dropdown-item"  style="width:12rem" href="<%=base_url%>/Customer/Profile/"> <i class="fas fa-user"></i> &nbsp;&nbsp; Profile Seller</a></li>                            
                            <li><a class="dropdown-item"  style="width:12rem" href="<%=base_url%>/Customer/Profile/"> <i class="fas fa-user"></i> &nbsp;&nbsp; Log Out</a></li>                            
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
                                                <span class="notify-badgee"><%'=cart("total")%></span>
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
