<!--#include file="../../../connections/pigoConn.asp"--> 
<% 
    if request.cookies("custEmail") = "" then
    response.redirect("../../../")
    end if

	dim KategoriProduk, MerkProduk, AlamatPengiriman
			
	set Kategori_CMD = server.createObject("ADODB.COMMAND")
	Kategori_CMD.activeConnection = MM_PIGO_String
	Kategori_CMD.commandText = "SELECT [catID] ,[catName] ,[catAktifYN] FROM [PIGO].[dbo].[MKT_M_Kategori] where catAktifYN = 'Y'" 
	set KategoriProduk = Kategori_CMD.execute

    set Merk_CMD = server.createObject("ADODB.COMMAND")
	Merk_CMD.activeConnection = MM_PIGO_String
	Merk_CMD.commandText = "SELECT [mrID] ,[mrNama] ,[mrAktifYN] FROM [PIGO].[dbo].[MKT_M_Merk] where mrAktifYN = 'Y'" 
	set MerkProduk = Merk_CMD.execute

    set Alamat_cmd = server.createObject("ADODB.COMMAND")
	Alamat_cmd.activeConnection = MM_PIGO_String
	Alamat_cmd.commandText = "SELECT * From MKT_M_Alamat where alm_custID = '"& request.cookies("custID") &"' and almJenis = 'Alamat Toko' " 
	set AlamatPengiriman = Alamat_cmd.execute
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="ProdukBaru.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <title> Seller - Produk Baru </title>
        <script>
        </script>
        <style>
                .cont-list-order-seller{ 
                    padding:10px 20px; 
                    background-color:none; 
                    width:100%;
                    box-shadow:0 3px 5px 0 rgba(0, 0, 0, 0.37), 0 2px 8px 0 rgba(0, 0, 0, 0.19);
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
        .cont-icon{
            font-weight:bold;
            color:#c70505;
        }
        </style>
    </head>
<body>
    <!--Breadcrumb-->
    <div class="Header-Action-Seller">
        <div class="row align-items-center ">
            <div class="col-12">
                <div class="navigasi" >
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb ">
                            <li class=" cont-text breadcrumb-item"><a href="<%=base_url%>/Seller/" >Seller Home</a></li>
                            <li class=" cont-text breadcrumb-item"><a href="<%=base_url%>/Daftar-Produk/">Daftar Produk</a></li>
                            <li class=" cont-text breadcrumb-item"><a href="index.asp">Tambah Produk</a></li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!--Breadcrumb-->

    <div class="container" style="margin-top:5.5rem">
        <div class="row">
            <div class="col-3">
                <div class="menu-notifikasi">
                    <ul>
                        <li class="list-ProdukBaru" id=""> Informasi Produk </li>
                        <li class="list-ProdukBaru" id=""> Spesifikasi </li>
                        <li class="list-ProdukBaru" id=""> Informasi Penjualan </li>
                        <li class="list-ProdukBaru" id=""> Pengiriman </li>
                        <li class="list-ProdukBaru" id=""> Lainnya </li>
                    </ul>
                </div>
            </div>
            <div class="col-9">
                <div class="cont-list-order-seller" id="informasi-produk">
                    <div class="row">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                            <span class="cont-judul" >Informasi Produk </span><br>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <div class="text-center potoproduk" >
                                <label for="firstimg1" class="gambar">
                                <img src="<%=base_url%>/assets/logo/upload.png" id="output1"   width="60" height="60" >
                                <span class="cont-text" style="font-size:10px;"> Gambar Utama </span>
                                </label>
                                <input type="file" name="firstimg1" id="firstimg1" style="display:none" onchange="loadFile1(event)"><br>
                                <textarea name="image1" id="base64_1" rows="1" style="display:none" ></textarea>
                            </div>
                        </div>

                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <div class="text-center potoproduk">
                                <label for="firstimg2" class="gambar">
                                <img src="<%=base_url%>/assets/logo/upload.png" id="output2" width="60" height="60" >
                                <span class="cont-text text-center" style="font-size:10px;"> Depan </span>
                                </label>
                                <input type="file" name="firstimg2" id="firstimg2" style="display:none" onchange="loadFile2(event)"><br>
                                <textarea name="image2" id="base64_2" rows="1"style="display:none"   ></textarea>
                            </div>
                        </div>

                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <div class="text-center potoproduk">
                                <label for="firstimg3" class="gambar">
                                <img src="<%=base_url%>/assets/logo/upload.png" id="output3" width="60" height="60">
                                <span class="cont-text text-center" style="font-size:10px;"> Belakang </span>
                                </label>
                                <input type="file" name="firstimg3" id="firstimg3" style="display:none" onchange="loadFile3(event)"><br>
                                <textarea name="image3" id="base64_3" rows="1"style="display:none"></textarea>
                            </div>
                        </div>

                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <div class="text-center potoproduk">
                                <label for="firstimg4" class="gambar">
                                <img src="<%=base_url%>/assets/logo/upload.png" id="output4" width="60" height="60">
                                <span class="cont-text text-center" style="font-size:10px;"> Bawah </span>
                                </label>
                                <input type="file" name="firstimg4" id="firstimg4" style="display:none" onchange="loadFile4(event)"><br>
                                <textarea name="image4" id="base64_4" rows="1"style="display:none"></textarea>
                            </div>
                        </div>

                        <!--<div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <div class=" potoproduk">
                                <label for="firstimg5">
                                <img src="<%=base_url%>/assets/logo/upload.png" id="output5" width="60" height="60" ">
                                </label>
                                <input type="file" name="firstimg5" id="firstimg5" style="display:none" onchange="loadFile5(event)"><br>
                                <textarea name="image5" id="base64_5" rows="1"  ></textarea>
                            </div>
                        </div>-->

                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                            <div class="text-center potoproduk">
                                <label for="firstimg6"  class="gambar">
                                    <img src="<%=base_url%>/assets/logo/upload.png" id="output6" width="60" height="60"><br>
                                    <span class="cont-text text-center" style="font-size:10px;"> Atas </span>
                                </label>
                                <input type="file" name="firstimg6" id="firstimg6" style="display:none" onchange="loadFile6(event)"><br>
                                <textarea name="image6" id="base64_6" rows="1" style="display:none"></textarea>
                            </div>
                        </div>
                                </div>
                </div>
            </div>

        </div>
    </div>
        
    </div>

    <div class="main">
        
    </div>
</body>

    <script>
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>