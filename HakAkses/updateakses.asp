<!--#include file="../Connections/pigoConn.asp" -->
<%
    if session("username") <> "administrator" then 

    response.redirect("../Admin/")
    
    end if
    set WebRights_CMD = server.createObject("ADODB.COMMAND")
	WebRights_CMD.activeConnection = MM_PIGO_String
    WebRights_CMD.commandText = "SELECT * FROM WebLogin Where UserAktifYN = 'Y' "
    set WebLogin = WebRights_CMD.execute

    username        = Request.QueryString("username")
    usersection     = Request.QueryString("usersection")

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Official PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
    </script>
    <style>
        .cont-text{
            text-transform: uppercase;
        }
        .container{
            background-color:white;
        }
        input[type="checkbox"]:checked {
            background-color:red;
            border: 1px solid red;
            font-size:16px;
        }
        input[type="checkbox"]  {
            background-color:white;
            font-size:16px;
        }
        input[type="checkbox"] {
            background-color:white;
            font-size:16px;
        }
        ul li {
            list-style: none;
            margin-left:-5px;
        }
        .collapsible {
            background-color: #0077a2;
            color: white;
            cursor: pointer;
            padding: 18px;
            width: 100%;
            border: none;
            font-weight:bold;
            text-align: left;
            outline: none;
            font-size: 15px;
            }

            .active, .collapsible:hover {
            background-color: white;
            color:#0077a2;
            }

            .collapsible:after {
            content: '\002B';
            color: white;
            font-weight: bold;
            float: right;
            margin-left: 5px;
            }

            .active:after {
            content: "\2212";
            }

            .content {
            padding:0 18px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.2s ease-out;
            background-color: #f1f1f1;
            }
        .cont-row{
            padding:2px 5px;
        }
        .cont-text{
            font-size:15px;
        }
    </style>
    </head>
<body>

    <div class="container mt-4">
        <div class="row text-center">
            <div class="col-10">
                <h4 style="font-size:18px"><b> DAFTAR HAK AKSES </b></h4><br>
            </div>
            <div class="col-2">
                <a href="<%=base_url%>/hakakses/" class="button cont-btn" type="button" style="font-size:16px"> KEMBALI </a>
            </div>
        </div>
        <form action="checkakses_add.asp" method="post">
        <input type='hidden' name='uname' id='uname' value="<%=username%>">
        <input type='hidden' name='usersection' id='usersection' value="<%=usersection%>">
        <div class="row">
            <div class="col-12">
                <button type="button" class="collapsible cont-akses">DASHBOARD</button>
                <div class="content">
                    
                </div>
                <button type="button" class="collapsible cont-akses">DATA</button>
                <div class="content">
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H2A'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H2A" id="H2A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H2A');" >
                                <label class="cont-text form-check-label" for="H2A"> Customer PIGO </label>
                            </div>
                            <ul>
                                <li>
                                    
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="form-check ">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H2B'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H2B" id="H2B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H2B');">
                                <label class="cont-text form-check-label" for="H2B"> Seller </label>
                            </div><br>
                        </div>
                    </div>
                </div>
                <button type="button" class="collapsible">PRODUK</button>
                <div class="content">
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3A'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3A" id="H3A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3A');">
                                <label class="cont-text form-check-label" for="H3A"> Produk Baru </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3A1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3A1" id="H3A1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3A1');">
                                        <label class="cont-text form-check-label" for="H3A1"> Batal </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3A2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3A2" id="H3A2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3A2');">
                                        <label class="cont-text form-check-label" for="H3A2"> Cost </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3A3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3A3" id="H3A3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3A3');">
                                        <label class="cont-text form-check-label" for="H3A3"> simpan </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3B'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3B" id="H3B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3B');">
                                <label class="cont-text form-check-label" for="H3B"> Produk Info </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3B1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3B1" id="H3B1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3B1');">
                                        <label class="cont-text form-check-label" for="H3B1"> Tambah </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3B2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3B2" id="H3B2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3B2');">
                                        <label class="cont-text form-check-label" for="H3B2"> Web </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3B3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3B3" id="H3B3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3B3');">
                                        <label class="cont-text form-check-label" for="H3B3"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3B4'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3B4" id="H3B4" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3B4');">
                                        <label class="cont-text form-check-label" for="H3B4"> Generate List Harga </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3B5'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3B5" id="H3B5" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3B5');">
                                        <label class="cont-text form-check-label" for="H3B5"> Edit </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3B6'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3B6" id="H3B6" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3B6');">
                                        <label class="cont-text form-check-label" for="H3B6"> Hapus </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3B7'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3B7" id="H3B7" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3B7');">
                                        <label class="cont-text form-check-label" for="H3B7"> Up Web </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3C'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3C" id="H3C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3C');">
                                <label class="cont-text form-check-label" for="H3C"> Produk Cost </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H3C1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H3C1" id="H3C1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H3C1');">
                                        <label class="cont-text form-check-label" for="H3C1"> Batal </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <button type="button" class="collapsible">BUSSINES PARTNER</button>
                <div class="content">
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H4A'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H4A" id="H4A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H4A');">
                                <label class="cont-text form-check-label" for="H4A"> Bussines Partner </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H4A1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H4A1" id="H4A1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H4A1');">
                                        <label class="cont-text form-check-label" for="H4A1"> Tambah </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H4A2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H4A2" id="H4A2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H4A2');">
                                        <label class="cont-text form-check-label" for="H4A2"> Edit </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <button type="button" class="collapsible">PPN MASUKAN</button>
                <div class="content">
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H5A'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H5A" id="H5A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H5A');">
                                <label class="cont-text form-check-label" for="H5A"> PPN Masukan </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H5A1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H5A1" id="H5A1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H5A1');">
                                        <label class="cont-text form-check-label" for="H5A1"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H5A2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H5A2" id="H5A2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H5A2');">
                                        <label class="cont-text form-check-label" for="H5A2"> Tambah </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H5A3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H5A3" id="H5A3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H5A3');">
                                        <label class="cont-text form-check-label" for="H5A3"> Edit </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H5A4'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H5A4" id="H5A4" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H5A4');">
                                        <label class="cont-text form-check-label" for="H5A4"> Hapus </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <button type="button" class="collapsible">GENERAL LEADGER</button>
                <div class="content">
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="form-check mb-2">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A" id="H6A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A');">
                                <label class="cont-text form-check-label" for="H6A"> Cetak </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A1" id="H6A1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A1');">
                                        <label class="cont-text form-check-label" for="H6A1"> Cetak Pembukuan </label>
                                    </div>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A2" id="H6A2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A2');">
                                        <label class="cont-text form-check-label" for="H6A2"> Cetak Buku Besar </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A2A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A2A" id="H6A2A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A2A');">
                                                <label class="cont-text form-check-label" for="H6A2A">Cetak </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A2B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A2B" id="H6A2B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A2B');">
                                                <label class="cont-text form-check-label" for="H6A2B"> Batal </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A3" id="H6A3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A3');">
                                        <label class="cont-text form-check-label" for="H6A3"> Cetak Neraca Saldo </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A3A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A3A" id="H6A3A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A3A');">
                                                <label class="cont-text form-check-label" for="H6A3A">Cetak </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A3B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A3B" id="H6A3B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A3B');">
                                                <label class="cont-text form-check-label" for="H6A3B"> Batal </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A4'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A4" id="H6A4" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A4');">
                                        <label class="cont-text form-check-label" for="H6A4"> Cetak Neraca </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A4A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A4A" id="H6A4A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A4A');">
                                                <label class="cont-text form-check-label" for="H6A4A"> Cetak</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A4B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A4B" id="H6A4B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A4B');">
                                                <label class="cont-text form-check-label" for="H6A4B"> Batal </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A5'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A5" id="H6A5" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A5');">
                                        <label class="cont-text form-check-label" for="H6A5"> Cetak Laba Rugi </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A4A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A4A" id="H6A4A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A4A');">
                                                <label class="cont-text form-check-label" for="H6A4A"> Cetak  </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A4B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A4B" id="H6A4B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A4B');">
                                                <label class="cont-text form-check-label" for="H6A4B"> Batal  </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A6'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A6" id="H6A6" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A6');">
                                        <label class="cont-text form-check-label" for="H6A6"> Laporan Arus Kas </label>
                                    </div>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A7'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A7" id="H6A7" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A7');">
                                        <label class="cont-text form-check-label" for="H6A7"> Kalkulasi Fiskal </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A7A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A7A" id="H6A7A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A7A');">
                                                <label class="cont-text form-check-label" for="H6A7A"> Refresh </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A7B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A7B" id="H6A7B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A7B');">
                                                <label class="cont-text form-check-label" for="H6A7B"> Tambah </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A7C'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A7C" id="H6A7C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A7C');">
                                                <label class="cont-text form-check-label" for="H6A7C"> Print </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A7D'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A7D" id="H6A7D" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A7D');">
                                                <label class="cont-text form-check-label" for="H6A7D"> Edit </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A7E'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A7E" id="H6A7E" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A7E');">
                                                <label class="cont-text form-check-label" for="H6A7E"> Hapus </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A8'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A8" id="H6A8" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A8');">
                                        <label class="cont-text form-check-label" for="H6A8"> Laporan Perubahan Ekuitas </label>
                                    </div>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A9'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A9" id="H6A9" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A9');">
                                        <label class="cont-text form-check-label" for="H6A9"> Rekap Umur Piutang </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A9A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A9A" id="H6A9A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A9A');">
                                                <label class="cont-text form-check-label" for="H6A9A"> Detail </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A9B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A9B" id="H6A9B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A9B');">
                                                <label class="cont-text form-check-label" for="H6A9B"> Proses </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6A9C'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6A9C" id="H6A9C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6A9C');">
                                                <label class="cont-text form-check-label" for="H6A9C"> Cetak </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check mb-2">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B" id="H6B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B');">
                                <label class="cont-text form-check-label" for="H6B"> Daftar </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B1" id="H6B1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B1');">
                                        <label class="cont-text form-check-label" for="H6B1"> Daftar Kas Masuk/Keluar </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B1A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B1A" id="H6B1A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B1A');">
                                                <label class="cont-text form-check-label" for="H6B1A"> Refresh </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B1B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B1B" id="H6B1B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B1B');">
                                                <label class="cont-text form-check-label" for="H6B1B"> Tambah </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B1C'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B1C" id="H6B1C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B1C');">
                                                <label class="cont-text form-check-label" for="H6B1C"> Edit </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B1D'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B1D" id="H6B1D" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B1D');">
                                                <label class="cont-text form-check-label" for="H6B1D"> Aktif/Non Aktif </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B2" id="H6B2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B2');">
                                        <label class="cont-text form-check-label" for="H6B2"> Daftar Kelompok Perkiraan </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B2A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B2A" id="H6B2A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B2A');">
                                                <label class="cont-text form-check-label" for="H6B2A"> Refresh </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B2B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B2B" id="H6B2B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B2B');">
                                                <label class="cont-text form-check-label" for="H6B2B"> Tambah </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B3" id="H6B3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B3');">
                                        <label class="cont-text form-check-label" for="H6B3"> Daftar Kode Perkiraan </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B3A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B3A" id="H6B3A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B3A');">
                                                <label class="cont-text form-check-label" for="H6B3A"> Refresh </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B3B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B3B" id="H6B3B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B3B');">
                                                <label class="cont-text form-check-label" for="H6B3B"> Tambah </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B4'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B4" id="H6B4" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B4');">
                                        <label class="cont-text form-check-label" for="H6B4"> Daftar Saldo Awal Perkiraan </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B4A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B4A" id="H6B4A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B4A');">
                                                <label class="cont-text form-check-label" for="H6B4A"> Refresh </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B4B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B4B" id="H6B4B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B4B');">
                                                <label class="cont-text form-check-label" for="H6B4B"> Tambah  </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B4C'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B4C" id="H6B4C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B4C');">
                                                <label class="cont-text form-check-label" for="H6B4C"> Simpan </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6B4D'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6B4D" id="H6B4D" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6B4D');">
                                                <label class="cont-text form-check-label" for="H6B4D"> Batal </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check mb-2">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6C'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6C" id="H6C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6C');">
                                <label class="cont-text form-check-label" for="H6C"> Jurnal </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check mb-2">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6C1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6C1" id="H6C1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6C1');">
                                        <label class="cont-text form-check-label" for="H6C1"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check mb-2">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6C2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6C2" id="H6C2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6C2');">
                                        <label class="cont-text form-check-label" for="H6C2"> Tambah </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check mb-2">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6C3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6C3" id="H6C3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6C3');">
                                        <label class="cont-text form-check-label" for="H6C3"> Cetak </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check mb-2">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6C4'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6C4" id="H6C4" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6C4');">
                                        <label class="cont-text form-check-label" for="H6C4"> Export </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check mb-2">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6C5'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6C5" id="H6C5" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6C5');">
                                        <label class="cont-text form-check-label" for="H6C5"> Edit </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6D'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6D" id="H6D" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6D');">
                                <label class="cont-text form-check-label" for="H6D"> Kas Masuk/Keluar </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6D1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6D1" id="H6D1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6D1');">
                                        <label class="cont-text form-check-label" for="H6D1"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6D2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6D2" id="H6D2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6D2');">
                                        <label class="cont-text form-check-label" for="H6D2"> Tambah </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6D3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6D3" id="H6D3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6D3');">
                                        <label class="cont-text form-check-label" for="H6D3"> Laporan </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6E'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6E" id="H6E" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6E');">
                                <label class="cont-text form-check-label" for="H6E"> Posting Pembukuan Akhir Bulan </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6E1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6E1" id="H6E1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6E1');">
                                        <label class="cont-text form-check-label" for="H6E1"> Proses </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H6E2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H6E2" id="H6E2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H6E2');">
                                        <label class="cont-text form-check-label" for="H6E2"> Batal </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <button type="button" class="collapsible">PURCHASE MANAGEMENT</button>
                <div class="content">
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7A'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7A" id="H7A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7A');">
                                <label class="cont-text form-check-label" for="H7A"> Purchase Order </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7A1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7A1" id="H7A1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7A1');">
                                        <label class="cont-text form-check-label" for="H7A1"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7A2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7A2" id="H7A2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7A2');">
                                        <label class="cont-text form-check-label" for="H7A2"> Tambah </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7A3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7A3" id="H7A3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7A3');">
                                        <label class="cont-text form-check-label" for="H7A3"> Cetak </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7A4'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7A4" id="H7A4" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7A4');">
                                        <label class="cont-text form-check-label" for="H7A4"> Download </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7A5'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7A5" id="H7A5" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7A5');">
                                        <label class="cont-text form-check-label" for="H7A5"> Draft </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7A6'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7A6" id="H7A6" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7A6');">
                                        <label class="cont-text form-check-label" for="H7A6"> Rincian </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7A7'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7A7" id="H7A7" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7A7');">
                                        <label class="cont-text form-check-label" for="H7A7"> Pembatalan </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7A8'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7A8" id="H7A8" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7A8');">
                                        <label class="cont-text form-check-label" for="H7A8"> Revisi </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7B'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7B" id="H7B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7B');">
                                <label class="cont-text form-check-label" for="H7B"> Material Receipt </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7B1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7B1" id="H7B1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7B1');">
                                        <label class="cont-text form-check-label" for="H7B1"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7B2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7B2" id="H7B2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7B2');">
                                        <label class="cont-text form-check-label" for="H7B2"> Tambah </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7B3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7B3" id="H7B3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7B3');">
                                        <label class="cont-text form-check-label" for="H7B3"> Download </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7B4'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7B4" id="H7B4" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7B4');">
                                        <label class="cont-text form-check-label" for="H7B4"> Cetak </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7C'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7C" id="H7C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7C');">
                                <label class="cont-text form-check-label" for="H7C"> Tukar Faktur </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7C1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7C1" id="H7C1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7C1');">
                                        <label class="cont-text form-check-label" for="H7C1"> List </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7C2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7C2" id="H7C2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7C2');">
                                        <label class="cont-text form-check-label" for="H7C2"> Cetak </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H7C3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H7C3" id="H7C3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H7C3');">
                                        <label class="cont-text form-check-label" for="H7C3"> Add Pay-Request </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <button type="button" class="collapsible">TRANSAKSI</button>
                <div class="content">
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="form-check mb-2">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A" id="H8A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A');">
                                <label class="cont-text form-check-label" for="H8A"> Invoice AR </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A1" id="H8A1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A1');">
                                        <label class="cont-text form-check-label" for="H8A1"> Faktur Penjualan </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A1A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A1A" id="H8A1A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A1A');">
                                                <label class="cont-text form-check-label" for="H8A1A"> Refresh </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A1B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A1B" id="H8A1B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A1B');">
                                                <label class="cont-text form-check-label" for="H8A1B"> Rekap Tanda Terima </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A1C'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A1C" id="H8A1C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A1C');">
                                                <label class="cont-text form-check-label" for="H8A1C"> Rekap Kwitansi </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A1D'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A1D" id="H8A1D" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A1D');">
                                                <label class="cont-text form-check-label" for="H8A1D"> Cetak </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A1E'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A1E" id="H8A1E" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A1E');">
                                                <label class="cont-text form-check-label" for="H8A1E"> Tanda Terima </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A1F'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A1F" id="H8A1F" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A1F');">
                                                <label class="cont-text form-check-label" for="H8A1F"> Kwitansi </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A1G'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A1G" id="H8A1G" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A1G');">
                                                <label class="cont-text form-check-label" for="H8A1G"> Bukti </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8A2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8A2" id="H8A2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8A2');">
                                        <label class="cont-text form-check-label" for="H8A2"> Invoice </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check mb-2">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8B'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8B" id="H8B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8B');">
                                <label class="cont-text form-check-label" for="H8B"> Invoice AP </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8B1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8B1" id="H8B1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8B1');">
                                        <label class="cont-text form-check-label" for="H8B1"> Invoice (Vendor) </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8B1A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8B1A" id="H8B1A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8B1A');">
                                                <label class="cont-text form-check-label" for="H8B1A"> Refresh </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8B1B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8B1B" id="H8B1B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8B1B');">
                                                <label class="cont-text form-check-label" for="H8B1B"> List Invoice </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8B1C'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8B1C" id="H8B1C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8B1C');">
                                                <label class="cont-text form-check-label" for="H8B1C"> Tambah </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check mb-2">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8C'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8C" id="H8C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8C');">
                                <label class="cont-text form-check-label" for="H8C"> Payment </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8C1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8C1" id="H8C1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8C1');">
                                        <label class="cont-text form-check-label" for="H8C1"> Payment BANK </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8C1A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8C1A" id="H8C1A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8C1A');">
                                                <label class="cont-text form-check-label" for="H8C1A"> Tambah </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8C1B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8C1B" id="H8C1B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8C1B');">
                                                <label class="cont-text form-check-label" for="H8C1B"> Laporan </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8C1C'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8C1C" id="H8C1C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8C1C');">
                                                <label class="cont-text form-check-label" for="H8C1C"> Cetak </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8D'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8D" id="H8D" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8D');">
                                <label class="cont-text form-check-label" for="H8D"> Form Penawaran </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8D1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8D1" id="H8D1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8D1');">
                                        <label class="cont-text form-check-label" for="H8D1"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8D2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8D2" id="H8D2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8D2');">
                                        <label class="cont-text form-check-label" for="H8D2"> List Penawaran </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8D3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8D3" id="H8D3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8D3');">
                                        <label class="cont-text form-check-label" for="H8D3"> Tambah </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8E'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8E" id="H8E" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8E');">
                                <label class="cont-text form-check-label" for="H8E"> Permintaan Barang </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8E1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8E1" id="H8E1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8E1');">
                                        <label class="cont-text form-check-label" for="H8E1"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8E2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8E2" id="H8E2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8E2');">
                                        <label class="cont-text form-check-label" for="H8E2"> List Permintaan </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8E2A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8E2A" id="H8E2A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8E2A');">
                                                <label class="cont-text form-check-label" for="H8E2A"> Refresh </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8E2B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8E2B" id="H8E2B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8E2B');">
                                                <label class="cont-text form-check-label" for="H8E2B"> Tambah </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8E2C'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8E2C" id="H8E2C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8E2C');">
                                                <label class="cont-text form-check-label" for="H8E2C"> Cetak </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8E2D'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8E2D" id="H8E2D" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8E2D');">
                                                <label class="cont-text form-check-label" for="H8E2D"> Add Pengeluaran Suku Cadang </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8E3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8E3" id="H8E3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8E3');">
                                        <label class="cont-text form-check-label" for="H8E3"> Generate </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8F'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8F" id="H8F" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8F');">
                                <label class="cont-text form-check-label" for="H8F"> Pengeluaran SCB </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8F1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8F1" id="H8F1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8F1');">
                                        <label class="cont-text form-check-label" for="H8F1"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8F2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8F2" id="H8F2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8F2');">
                                        <label class="cont-text form-check-label" for="H8F2"> List </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8F3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8F3" id="H8F3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8F3');">
                                        <label class="cont-text form-check-label" for="H8F3"> Cetak </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8F4'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8F4" id="H8F4" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8F4');">
                                        <label class="cont-text form-check-label" for="H8F4"> Add Surat Jalan </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8G'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8G" id="H8G" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8G');">
                                <label class="cont-text form-check-label" for="H8G"> Surat Jalan </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8G1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8G1" id="H8G1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8G1');">
                                        <label class="cont-text form-check-label" for="H8G1"> Refresh </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8G2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8G2" id="H8G2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8G2');">
                                        <label class="cont-text form-check-label" for="H8G2"> Cetak </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H8G3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H8G3" id="H8G3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H8G3');">
                                        <label class="cont-text form-check-label" for="H8G3"> Cetak Faktur </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <button type="button" class="collapsible">LAPORAN</button>
                <div class="content">
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9A'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9A" id="H9A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9A');">
                                <label class="cont-text form-check-label" for="H9A"> Laporan Pembelian </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9A1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9A1" id="H9A1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9A1');">
                                        <label class="cont-text form-check-label" for="H9A1"> Download </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9B'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9B" id="H9B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9B');">
                                <label class="cont-text form-check-label" for="H9B"> Laporan Penjualan </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9B1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9B1" id="H9B1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9B1');">
                                        <label class="cont-text form-check-label" for="H9B1"> Download </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <div class="form-check">
                                <%
                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9C'"
                                    set WebRights = WebRights_CMD.execute
                                %>
                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9C" id="H9C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9C');">
                                <label class="cont-text form-check-label" for="H9C">  STOK </label>
                            </div>
                            <ul>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9C1'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9C1" id="H9C1" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9C1');">
                                        <label class="cont-text form-check-label" for="H9C1">  Laporan Stok </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9C2'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9C2" id="H9C2" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9C2');">
                                        <label class="cont-text form-check-label" for="H9C2">  Kartu Stok </label>
                                    </div>
                                    <ul>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9C2A'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9C2A" id="H9C2A" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9C2A');">
                                                <label class="cont-text form-check-label" for="H9C2A"> Cetak Kartu Stok Keseluruhan </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9C2B'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9C2B" id="H9C2B" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9C2B');">
                                                <label class="cont-text form-check-label" for="H9C2B"> Proses </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="form-check">
                                                <%
                                                    WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9C2C'"
                                                    set WebRights = WebRights_CMD.execute
                                                %>
                                                <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9C2C" id="H9C2C" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9C2C');">
                                                <label class="cont-text form-check-label" for="H9C2C"> Cetak Kartu Stok /Produk </label>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9C3'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9C3" id="H9C3" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9C3');">
                                        <label class="cont-text form-check-label" for="H9C3">  Cetak </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-check">
                                        <%
                                            WebRights_CMD.commandText = "SELECT AppRights FROM WebRights WHERE (Username = '"& username &"') AND (Usersection = '"& usersection &"') and AppRights = 'H9C4'"
                                            set WebRights = WebRights_CMD.execute
                                        %>
                                        <input class="mt-1 cont-text form-check-input" type="checkbox" value="" name="H9C4" id="H9C4" <%if WebRights.eof = false then%> checked <%end if%> onClick="addrights(document.getElementById('uname').value,document.getElementById('usersection').value,'H9C4');">
                                        <label class="cont-text form-check-label" for="H9C4">  Refresh </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <button type="button" class="collapsible mb-4">USER</button>
                <div class="content">
                </div>
            </div>
        </div>
        </form>
    </div>
            
</body>
<script>
        var coll = document.getElementsByClassName("collapsible");
        var i;

        for (i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var content = this.nextElementSibling;
            if (content.style.maxHeight){
            content.style.maxHeight = null;
            } else {
            content.style.maxHeight = content.scrollHeight + "px";
            } 
        });
        }
        function addrights(uname,usersection,apprights)
	{
	var xmlhttp;    
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange=function()
        {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
            {
                document.getElementById("txtHint").style.padding = "35px";
            document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET","add-WebRights.asp?username="+uname+"&usersection="+usersection+"&apprights="+apprights,true);
        alert("add-WebRights.asp?uname="+uname+"&usersection="+usersection+"&apprights="+apprights);
        xmlhttp.send();
	}
    function addrights(username,usersection,apprights){
        $.ajax({
            type: "GET",
            url: "add-WebRights.asp?username="+username+"&usersection="+usersection+"&apprights="+apprights,
            success: function (url) {
            }
        });
    }
</script>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>  
</html>