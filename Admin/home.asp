<!--#include file="../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../admin/")
    
    end if

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

    Produk_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_PurchaseOrder_H.poID), 0) AS Total FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE (MKT_T_PurchaseOrder_D.po_spoID = '0')"
    'response.write Produk_cmd.commandText
    set PembelianBaru = Produk_cmd.execute

    Produk_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_PurchaseOrder_H.poID), 0) AS Total FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE (MKT_T_PurchaseOrder_D.po_spoID = '1')"
    'response.write Produk_cmd.commandText
    set TotalPembelian = Produk_cmd.execute

    Produk_cmd.commandText = "SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty),0) AS Total FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID where Perm_PSCBYN = 'N'"
    'response.write Produk_cmd.commandText
    set PermintaanBaru = Produk_cmd.execute

    Produk_cmd.commandText = "SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty),0) AS Total FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID where Perm_PSCBYN = 'Y'"
    'response.write Produk_cmd.commandText
    set TotalPermintaan = Produk_cmd.execute
    d_mydate=Now()

    'Response.Write WeekDayName(WeekDay(d_mydate))
%>

<!doctype html>
<html lang="en"><!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <script src = "<%=base_url%>/js/d3.v4.min.js"></script>
    <script>

        function display_ct5() {
            var x = new Date()
            var ampm = x.getHours( ) >= 12 ? ' PM' : ' AM';
            if ( ampm == "AM"){
                document.getElementById("day").style.display = "none";
                document.getElementById("night").style.display = "block";
            }else{
                document.getElementById("night").style.display = "none";
                document.getElementById("day").style.display = "block";
            }
            var x1=x.getMonth() + 1+ "/" + x.getDate() + "/" + x.getFullYear(); 
            x1 =    x.getHours( )+ ":" +  x.getMinutes() + ":" +  x.getSeconds()  + ampm;
            document.getElementById('ct5').innerHTML = x1;
            document.getElementById('ct6').innerHTML = x1;
            display_c5();
            }
            function display_c5(){
            var refresh=0; // Refresh rate in milli seconds
            mytime=setTimeout('display_ct5()',refresh)
        }
        display_c5()
    </script>
    <style>
        .home-search{
            width:100%;
            border:2px solid #eee;
            border-radius:7px;
            padding:3px 10px;
        }
        .progress {
        width: 60px;
        height: 60px !important;
        float: left; 
        line-height: 150px;
        background: none;
        box-shadow: none;
        position: relative;
        }
        .progress:after {
        content: "";
        width: 100%;
        height: 100%;
        border-radius: 50%;
        border: 8px solid #0077a2;
        position: absolute;
        top: 0;
        left: 0;
        }
        .progress>span {
        width: 50%;
        height: 100%;
        overflow: hidden;
        position: absolute;
        top: 0;
        z-index: 1;
        }
        .progress .progress-left {
        left: 0;
        }
        .progress .progress-bar {
        width: 100%;
        height: 100%;
        background: none;
        border-width: 12px;
        border-style: solid;
        border: 8px solid #fff;
        position: absolute;
        top: 0;
        }
        .progress .progress-left .progress-bar {
            left: 100%;
            border-top-right-radius: 80px;
            border-bottom-right-radius: 80px;
            border-left: 0;
            -webkit-transform-origin: center left;
            transform-origin: center left;
        }
        .progress .progress-right {
            right: 0;
        }
        .progress .progress-right .progress-bar {
            left: -100%;
            border-top-left-radius: 80px;
            border-bottom-left-radius: 80px;
            border-right: 0;
            -webkit-transform-origin: center right;
            transform-origin: center right;
            animation: loading-1 1.8s linear forwards;
        }
        .progress .progress-value {
            width: 75%;
            height: 75%;
            border-radius: 50%;
            background: #eee;
            font-size: 20px;
            color: #0077a2;
            line-height: 50px;
            text-align: center;
            color: white;
            position: absolute;
            top: 9%;
            left: 12%;
        }
        .progress.blue .progress-bar {
        border-color: red;
        }
        .progress.blue .progress-left .progress-bar {
        animation: loading-2 1.5s linear forwards 1.8s;
        }
        .progress.yellow .progress-bar {
        border-color: #fdba04;
        }
        .progress.yellow .progress-right .progress-bar {
        animation: loading-3 1.8s linear forwards;
        }
        .progress.yellow .progress-left .progress-bar {
        animation: none;
        }
        @keyframes loading-1 {
        0% {
            -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
        }
        100% {
            -webkit-transform: rotate(180deg);
            transform: rotate(180deg);
        }
        }
        @keyframes loading-2 {
        0% {
            -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
        }
        100% {
            -webkit-transform: rotate(<%=TotalPembelian("total")%>deg);
            transform: rotate(<%=TotalPembelian("total")%>deg);
        }
        }
        @keyframes loading-3 {
        0% {
            -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
        }
        100% {
            -webkit-transform: rotate(<%=TotalPermintaan("total")%>deg);
            transform: rotate(<%=TotalPermintaan("total")%>deg);
        }
        }
    </style>
<body>
    <div class="header-home">
        <div class="cont-hd" style="margin-left:10px; margin-right:10px">
            <div class="header-search" style="padding:5px 10px">
                <div class="row align-items-center">
                    <div class="col-lg-1 col-md-1 col-sm-12 logo">
                        <img src="<%=base_url%>/assets/logo/1.png"  class="logo" alt="" width="50" height="50" >
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12 name-logo" >
                        <span style="font-size:35px; font-weight:600; margin-left:-20px"> PIGO  </span>
                    </div>
                    <div class="col-lg-5 col-md-5 col-sm-12 search">
                        <input type="search" class="home-search cont-form" placeholder="search">
                    </div>
                    <div class="col-1">
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-12 text-end"  id="night" style="display:none">

                        <span style="font-size:15px; margin-left:-20px"><b> <i class="fas fa-moon"></i> &nbsp;  <%=WeekDayName(WeekDay(d_mydate))%>,</b>
                        <%=Day(d_mydate)%>&nbsp;<%=MonthName(Month(d_mydate))%>&nbsp;<%=Year(d_mydate)%> &nbsp; <span id='ct6'></span> </span>
                        
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-12 text-end" id="day" style="display:none">

                        <span style="font-size:15px; margin-left:-20px"><b> <i class="fas fa-sun"></i> &nbsp;  <%=WeekDayName(WeekDay(d_mydate))%>,</b>
                        <%=Day(d_mydate)%>&nbsp;<%=MonthName(Month(d_mydate))%>&nbsp;<%=Year(d_mydate)%> &nbsp; <span id='ct5'></span> </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="wrapper">
        <!--#include file="sidebar.asp"-->
        <div id="content" style="margin-top:4.5rem">
            <div class="row">
                <div class="col-9">
                    <div class="row">
                        <div class="col-lg-3 col-md-6 col-sm-12 mb-2">
                            <div class="home-card">
                                <div class="row align-items-center">
                                    <div class="col-9">
                                        <span class="text-center text-home-card-judul "> Pembelian Baru </span><br>
                                    </div>
                                    <div class="col-3 text-center">
                                        <span style="font-size:14px; color:#0077a2" > <i class="fas fa-ellipsis-h"></i></span>
                                    </div>
                                </div>
                                <div class="row mt-2 align-items-center">
                                    <div class="col-6">
                                        <div class="progress blue">
                                            <span class="progress-left">
                                            <span class="progress-bar"></span>
                                            </span>
                                            <span class="progress-right">
                                            <span class="progress-bar"> </span>
                                            </span>
                                            <div class="progress-value"><i class="fas fa-shopping-cart" style="color:#0077a2"></i> </div>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <span style="color: #0077a2;" ><%=PembelianBaru("Total")%></span><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-12 mb-2">
                            <div class="home-card">
                                <div class="row align-items-center">
                                    <div class="col-9">
                                        <span class="text-center text-home-card-judul "> Total Pembelian </span><br>
                                    </div>
                                    <div class="col-3 text-center">
                                        <span style="font-size:14px; color:#0077a2" > <i class="fas fa-ellipsis-h"></i></span>
                                    </div>
                                </div>
                                <div class="row mt-2 align-items-center">
                                    <div class="col-6">
                                        <div class="progress blue">
                                            <span class="progress-left">
                                            <span class="progress-bar"></span>
                                            </span>
                                            <span class="progress-right">
                                            <span class="progress-bar"> </span>
                                            </span>
                                            <div class="progress-value"><i class="fab fa-shopify" style="color: #0077a2;"></i> </div>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <span style="color: #0077a2;" ><%=TotalPembelian("Total")%></span><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-12 mb-2">
                            <div class="home-card">
                                <div class="row align-items-center">
                                    <div class="col-9">
                                        <span class="text-center text-home-card-judul "> Penjualan Baru </span><br>
                                    </div>
                                    <div class="col-3 text-center">
                                        <span style="font-size:14px; color:#0077a2" > <i class="fas fa-ellipsis-h"></i></span>
                                    </div>
                                </div>
                                <div class="row mt-2 align-items-center">
                                    <div class="col-6">
                                        <div class="progress blue">
                                            <span class="progress-left">
                                            <span class="progress-bar"></span>
                                            </span>
                                            <span class="progress-right">
                                            <span class="progress-bar"> </span>
                                            </span>
                                            <div class="progress-value"><i class="fas fa-shopping-basket" style="color: #0077a2;"></i> </div>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <span style="color: #0077a2;" ><%=permintaanbaru("Total")%></span><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-12 mb-2">
                            <div class="home-card">
                                <div class="row align-items-center">
                                    <div class="col-9">
                                        <span class="text-center text-home-card-judul "> Total Penjualan </span><br>
                                    </div>
                                    <div class="col-3 text-center">
                                        <span style="font-size:14px; color:#0077a2" > <i class="fas fa-ellipsis-h"></i></span>
                                    </div>
                                </div>
                                <div class="row mt-2 align-items-center">
                                    <div class="col-6">
                                        <div class="progress blue">
                                            <span class="progress-left">
                                            <span class="progress-bar"></span>
                                            </span>
                                            <span class="progress-right">
                                            <span class="progress-bar"> </span>
                                            </span>
                                            <div class="progress-value"><i class="fab fa-shopify" style="color: #0077a2;"></i> </div>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <span style="color: #0077a2;" ><%=TotalPermintaan("Total")%></span><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-6">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 mb-2">
                                    <div class="home-card">
                                        <div class="row align-items-center">
                                            <div class="col-9">
                                                <span class="text-center text-home-card-judul ">  </span><br>
                                            </div>
                                            <div class="col-3 text-center">
                                                <span style="font-size:14px; color:#0077a2" > <i class="fas fa-ellipsis-h"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 mb-2">
                                    <div class="home-card">
                                        <div class="row align-items-center">
                                            <div class="col-9">
                                                <span class="text-center text-home-card-judul ">  </span><br>
                                            </div>
                                            <div class="col-3 text-center">
                                                <span style="font-size:14px; color:#0077a2" > <i class="fas fa-ellipsis-h"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="home-card">
                                <div class="row align-items-center">
                                    <div class="col-8">
                                        <span class="text-center text-home-card-judul "> Top Produk </span><br>
                                    </div>
                                    <div class="col-3 text-center">
                                        <input type="text" class="cont-form home-search" value="" placeholder="Search">
                                    </div>
                                    <div class="col-1 text-center">
                                        <button class="cont-btn"> <i class="fas fa-search"></i> </button>
                                    </div>
                                </div>
                                <div class="row mt-3 align-items-center">
                                    <div class="col-12">
                                    <%
                                        Produk_cmd.commandText = "SELECT TOP 5 MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_D.Perm_pdQty, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual,  MKT_T_Permintaan_Barang_D.Perm_pdUpTo, MKT_T_Permintaan_Barang_D.Perm_pdTax FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_M_PIGO_Produk.pdID = MKT_T_Permintaan_Barang_D.Perm_pdID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID ORDER BY Perm_pdQty DESC"
                                        'response.write Produk_cmd.commandText
                                        set Produk = Produk_cmd.execute
                                        
                                    %>
                                        <table class="table cont-tb">
                                            <thead class="text-center">
                                                <tr>
                                                    <th> Nama Produk </th>
                                                    <th> ID Transaksi </th>
                                                    <th> Quantity </th>
                                                    <th> Harga </th>
                                                    <th> Total Penjualan </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% 
                                                    do while not produk.eof
                                                    'response.write SuratJalan("SJID_pdID") & " Produk <br><br>"
                                                    HargaJual   = produk("Perm_pdHargaJual")
                                                    Upto        = produk("Perm_pdUpTo")
                                                    PPN         = produk("Perm_pdTax")

                                                    resultup    = HargaJual+(HargaJual*Upto/100)
                                                    resultppn   = resultup*PPN/100
                                                    result      = resultup+resultppn
                                                    total       = round(result)
                                                    subtotal        = subtotal + produk("Perm_pdHargaJual") 
                                                %>
                                                <tr>
                                                    <td> <%=produk("pdNama")%> </td>
                                                    <td class="text-center"> <%=produk("PermID")%> </td>
                                                    <td class="text-center"> <%=produk("Perm_pdQty")%> </td>
                                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(total),"$","Rp.  "),".00"," ")%> </td>
                                                    <%  subtotal = produk("Perm_pdQty")*total%>
                                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(subtotal),"$","Rp.  "),".00"," ")%> </td>
                                                </tr>
                                                <% produk.movenext
                                                loop  %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="card-content"  style="background-color:white; color:black; border-radius:20px; ">
                        <div class="row text-center align-items-center">
                            <div class="col-12">
                                <div class="dropdown dot" style="background-color:#0077a2; color:white; ">
                                    <span class="dropdown-btn">
                                        <% if session("usersection") = "04" then %>
                                        <i class="fas fa-user-cog" style="font-size:22px;"></i>
                                        <% else if session("usersection") = "02" then %>
                                        <i class="fas fa-user-tie" style="font-size:22px;"></i>
                                        <% else %>
                                        <% end if %><% end if %>

                                    </span>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="background-color:#eee; margin-left:-175px; margin-top:-40px;width:10rem">
                                        <li><a class="dashboard-dropdown-menu dropdown-item" href="Data/Akun/"> <%=session("username")%> </a></li>
                                        <li><a class="dashboard-dropdown-menu dropdown-item" href="../admin/LogoutUser.asp"><i class="fas fa-sign-out-alt"></i> &nbsp; Log Out</a></li>
                                    </ul>
                                </div>
                                <div class="row text-center align-items-center mt-2">
                                    <div class="col-12">
                                        <span class="cont-text" style="color:#0077a2"> Welcome - <b> <%=session("username")%> </b> </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cont-card-device mt-4 p-3">
                        <span class="cont-text"> Device </span>
                        <div class="row">
                            <div class="col-6">
                                <div class="device-card">
                                    <span style="color:white"><i class="fas fa-map-pin"></i></span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="device-card">
                                    <span style="color:white"><i class="fas fa-cloud"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="maskot-pigo mt-4 align-text-center text-center">
                        <img src="<%=base_url%>/assets/logo/maskotnew.png" width="200px" height="200px">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <!-- The Modal -->
    <div id="myModal" class="modal-GL">

    <!-- Modal content -->
        <div class="modal-content-GL">
            <div class="modal-body-GL">
                <div class="row mt-3">
                    <div class="col-11">
                        <button class="btn-dashboard"> DASHBOARD MENU   </button>
                        </div>
                        <div class="col-1">
                            <span><i class="fas fa-times closee" id="closee"></i></span>
                        </div>
                    </div>
                </div>
                <div class="body" style="padding:5px 20px">
                    <div class="row  mb-2 text-center">
                        <div class="col-12">
                            <button class=" mt-2" >Data<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct" style="top:-50px">
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Customer/">Customer PIGO</a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Seller/">Seller</a>
                            </div>

                        <button class="dashboard-dropdown dropdown-btn mt-2  " > Produk <i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct">
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukBaru/">Produk Baru</a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukInfo/">Produk Info</a>
                                <a class="text-dropdown" href="">Stok Produk</a>
                            </div>

                            <button class="dashboard-dropdown dropdown-btn mt-2 " > Bussines Partner <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/BussinesPartner/"> Bussines Partner </a>
                                </div>
                                
                            <button class="dashboard-dropdown dropdown-btn mt-2 " > PPN Masukan <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/PPN/"> PPh </a>
                                </div>

                            <button class="dashboard-dropdown dropdown-btn mt-2 " > General Ledger <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct">
                                <button class="dashboard-dropdown cont-dropdown-btn mt-2 " style="background-color:#0688af;font-size:12px; margin-left:-2px; width:13.9rem"> Cetak <i class="fa fa-caret-down"></i></button>
                                    <div class="dropdown-ct" style="margin-left:-2px; width:13.9rem">
                                        <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Cetak Pembukuan </a>
                                    </div>

                                <button class="dashboard-dropdown dropdown-btn mt-2 " style="background-color:#0688af;font-size:12px; margin-left:-2px; width:13.9rem"> Daftar <i class="fa fa-caret-down"></i></button>
                                    <div class="dropdown-ct" style="margin-left:-2px; width:13.9rem">
                                        <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Daftar Kas Masuk/Keluar </a>
                                        <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-KelompokPerkiraan/"> Daftar Kelompok Perkiraan </a>
                                        <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Daftar Kode Perkiraan </a>
                                    </div>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Kas-Masuk-Keluar/"> Kas Masuk/Keluar </a>
                            </div>

                        <button class="dashboard-dropdown dropdown-btn mt-2 " > Operasional <i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct">
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/PurchaseOrderDetail/"> Purchase Order </a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/MaterialReceiptDetail/"> Material Receipt </a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Pembayaran/PaymentRequestDetail/"> Payment Request </a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Pembayaran/PaymentDetail/"> Payment </a>
                            </div>

                        <button class="dashboard-dropdown dropdown-btn mt-2 " > Transaksi <i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct">
                            <button class="dashboard-dropdown dropdown-btn mt-2 " style="background-color:#0688af;font-size:12px; margin-left:-2px; width:13.9rem"> Invoice AR <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct" style="margin-left:-2px; width:13.9rem">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Invoice-AR/"> Faktur Penjualan </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/"> Invoice  </a>
                                </div>

                            <button class="dashboard-dropdown dropdown-btn mt-2 " style="background-color:#0688af;font-size:12px; margin-left:-2px; width:13.9rem"> Invoice AP <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct" style="margin-left:-2px; width:13.9rem">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Invoice-AP/Invoice(Vendor).asp"> Invoice (Vendor) </a>
                                </div>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/"> Penjualan-WEB </a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Penawaran/"> Form Penawaran </a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Permintaan-Barang/"> Permintaan Barang </a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Pengeluaran-SCB/detail.asp"> Pengeluaran SCB </a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/SuratJalan/"> Surat Jalan </a>
                            </div>
                        <button class="dashboard-dropdown dropdown-btn mt-2 " >Laporan<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct">
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Lap-Penjualan/">Laporan Penjualan</a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Lap-Pembelian/">Laporan Pembelian</a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/Daftar-Produk/">Laporan Barang</a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Lap-Stok/">Laporan Stok</a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Kartu-Stok/index.asp">Kartu Stok</a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/">Laporan Laba Rugi</a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/Produk-supplier/">Laporan Pemasukan</a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/Produk-supplier/">Laporan Pengeluaran</a>
                            </div>

                        <button class="dashboard-dropdown dropdown-btn mt-2 " >User<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct">
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/Tambah-Produk">User PIGO</a>
                            </div>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    <!-- Modal content -->
</body>
    <script src="../js/bootstrap.bundle.min.js"></script>    
    <script>
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
        var dropdown = document.getElementsByClassName("cont-dp-btn");
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
        
        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })

    </script>
</html>