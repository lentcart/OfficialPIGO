<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

        set GL_M_GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
        GL_M_GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount WHERE CA_Type = 'H'"
        set CID = GL_M_GL_M_ChartAccount_cmd.execute

        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount "
        set ChartAccount = GL_M_GL_M_ChartAccount_cmd.execute

        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT MAX(CA_ID) AS AccountID  FROM GL_M_ChartAccount WHERE CA_Type = 'H'  "
        set LastCAID = GL_M_GL_M_ChartAccount_cmd.execute
        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT GL_M_Kelompok.KCA_Name, GL_M_ChartAccount.CA_Name FROM GL_M_ChartAccount LEFT OUTER JOIN GL_M_Kelompok ON GL_M_ChartAccount.CA_Kelompok = GL_M_Kelompok.KCA_ID WHERE (GL_M_ChartAccount.CA_Type = 'H') AND CA_ID = '"& LastCAID("AccountID") &"' "
        set LastAccount = GL_M_GL_M_ChartAccount_cmd.execute

        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM [PIGO].[dbo].[GL_M_Kelompok] "
        set CAKelompok = GL_M_GL_M_ChartAccount_cmd.execute


%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>OFFICIAL PIGO</title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    </head>
    <!--#include file="../../loaderpage.asp"-->
    <style>
        .update-account{
            background-color:#eee; 
            padding: 10px 20px; 
            border-radius:10px; 
            margin-top:10px; 
            margin-bottom:10px
        }
        .update-header{
            padding: 10px 20px; 
        }
        .header-account{
            background-color:#eee; 
            padding: 10px 20px; 
            border-radius:10px; 
            margin-top:10px; 
            margin-bottom:10px
        }
        .header-account{
            display:none;
        }
        .old-account{
            display:none;
        }
        #TambahBaru-ACC{
            display:none;
        }
        .modal {
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
            .modal-content {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 70%;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
            -webkit-animation-name: animatetop;
            -webkit-animation-duration: 0.4s;
            animation-name: animatetop;
            animation-duration: 0.4s;
            border-radius:20px
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
            color: white;
            float: right;
            font-size: 28px;
            font-weight: bold;
            }

            .close:hover,
            .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
            }

    </style>
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <div class="row">
                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <span class="cont-text"> DAFTAR KODE PERKIRAAN  </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button class="cont-btn"name="btn-refresh" id="btn-refresh" onclick="return Refresh()" type="button" style="display:block" >  <i class="fas fa-sync"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12">
                        <button class="tambah-list cont-btn" name="btn-add" id="btn-add" type="button" style="display:block"> Tambah  </button>
                        <button class="tambah-list cont-btn" name="btn-cancle" id="btn-cancle" type="button" style="display:none"> Batal  </button>
                    </div>
                </div>
            </div>
            <div class="cont-background mt-2" id="TambahBaru-ACC">
                <div class="row text-center">
                    <div class="col-12">
                        <span class="cont-text"> TAMBAH KODE ACCOUNT KAS </span>
                    </div>
                </div>
                <div class="new-account">
                    <div class="row mt-2 text-center">
                        <div class="col-6">
                            <select class="cont-form" aria-label="Default select example" name="acction" id="acction">
                                <option value="">Pilih</option>
                                <option value="A">Tambah Account Baru ( As Header )</option>
                                <option value="B">Tambah Account Yang Sudah Ada ( As Detail )</option>
                            </select>
                        </div>
                        <div class="col-2">
                            <button  onclick="return Refresh()" class="cont-btn"> Batal </button>
                        </div>
                    </div>
                </div>
                <!-- NEW ACCOUNT AS Header-->
                <div class="header-account">
                    <form class="" action="P-NewAccount.asp" method="POST">
                        <div class="row ">
                            <div class="col-3">
                                <span class="cont-text"> Last Account ID (Header)  </span>
                                <input class="text-center cont-form" readonly type="text" value="<%=LastCAID("AccountID")%>">
                            </div>
                            <div class="col-6">
                                <span class="cont-text"> Last Account Name </span>
                                <input class="cont-form" readonly type="text" value="<%=LastAccount("CA_Name")%>">
                            </div>
                            <div class="col-3">
                                <span class="cont-text"> Last Account Kelompok </span>
                                <input class="cont-form" readonly type="text" value="<%=LastAccount("KCA_Name")%>">
                            </div>
                        </div>
                        <div class="row mt-2 ">
                            <div class="col-3">
                                <span class="cont-text"> Kode Account </span><br>
                                <input type="text" required class="cont-form" name="CA_IDDetail" id="CA_IDDetail" value="">
                            </div>
                            <div class="col-6">
                                <span class="cont-text"> Nama Account </span><br>
                                <input type="text" required class="cont-form" name="CA_Name" id="CA_Name" value="">
                            </div>
                            <div class="col-3">
                                <span class="cont-text"> UP Account </span><br>
                                <input type="text" class="cont-form" name="CA_UpIDNew" id="CA_UpIDNew" value="">
                            </div>
                            
                        </div>
                        <div class="row mt-2">
                            <div class="col-4">
                                <span class="cont-text"> Kelompok Account </span><br>
                                <select class="cont-form" required aria-label="Default select example" name="CA_Kelompok" id="CA_Kelompok">
                                    <option value="">Pilih Kelompok Account</option>
                                    <% do while not CAKelompok.eof %>
                                        <option value="<%=CAKelompok("KCA_ID")%>"><%=CAKelompok("KCA_ID")%> - <%=CAKelompok("KCA_Name")%></option>
                                    <% CAKelompok.movenext
                                    loop %>
                                </select>
                            </div>
                            <div class="col-2">
                                <span class="cont-text"> Jenis Account </span><br>
                                <select class="cont-form" required aria-label="Default select example" name="CA_Jenis" id="CA_Jenis">
                                    <option value="">Pilih</option>
                                    <option value="D">Debet</option>
                                    <option value="K">Kredit</option>
                                </select>
                            </div>
                            <div class="col-2">
                                <span class="cont-text"> Type Account </span><br>
                                <select class="cont-form" required aria-label="Default select example" name="CA_Type" id="CA_Type">
                                    <option value="">Pilih</option>
                                    <option value="H">Header</option>
                                    <option value="D">Detail</option>
                                </select>
                            </div>
                            <div class="col-2">
                                <span class="cont-text"> Golongan Acc </span><br>
                                <select class="cont-form" required aria-label="Default select example" name="CA_Golongan" id="CA_Golongan">
                                    <option value="">Pilih</option>
                                    <option value="N">Neraca</option>
                                    <option value="L/R">Laba Rugi</option>
                                </select>
                            </div>
                            <div class="col-2">
                                <span class="cont-text"> Tipe Item Acc </span><br>
                                <select class="cont-form" required aria-label="Default select example" name="CA_ItemTipe" id="CA_ItemTipe">
                                    <option value="">Pilih</option>
                                    <option value="C">Cash</option>
                                    <option value="B">Bank</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-2 text-center">
                            <div class="col-12">
                                <input type="submit" class="cont-btn" name="up-account" id="up-account" value="TAMBAH">
                            </div>
                        </div>
                    </form>
                </div>
                <!-- NEW ACCOUNT AS Header-->

                <!-- OLD ACCOUNT AS Detail-->
                <div class="old-account">
                    <div class="row mt-2 text-center">
                        <div class="col-4">
                            <span class="cont-text"> Account ID </span><br>
                            <input onkeyup="loadAccount()" type="text" class="cont-form" name="account" id="account" value="">
                        </div>
                        <div class="col-8">
                            <span class="cont-text"> Nama Account  </span><br>
                            <input onkeyup="loadAccount()" type="text" class="cont-form" name="nameaccount" id="nameaccount" value="">
                        </div>
                    </div>
                    <div class="row mt-2 mb-3"  style="height:10rem; overflow-y:scroll">
                        <div class="col-12">
                            <table class="table cont-tb">
                                <thead>
                                <tr class="text-center" style="background-color:#0077a2; color:white">
                                    <th> ACCOUNT ID </th>
                                    <th> NAMA ACCOUNT </th>
                                    <th> TYPE </th>
                                    <th> AKSI </th>
                                </tr>
                                </thead>
                                <tbody id="table-account">
                                    <% do while not CID.eof %>
                                    <tr>
                                        <td class="text-center"> <%=CID("CA_ID")%> </td>
                                        <td> <%=CID("CA_Name")%> </td>
                                        <td class="text-center"> <%=CID("CA_Type")%> </td>
                                        <td class="text-center"> 
                                            <button type="button" class="cont-btn" onclick="addaccount(this)" id="<%=CID("CA_ID")%>"> Add Detail Acc
                                        </td>
                                    </tr>
                                    <% CID.movenext
                                    loop %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- OLD ACCOUNT AS Detail-->
                
                <div class="new-account" id="new-account">
                    
                </div>
            </div>
            <div class="cont-background mt-2">
                <div class="row align-items-center p-2">
                    <div class="col-2">
                        <span class="cont-text"> Type Account </span><br>
                        <select onchange="searchAccount()" class="cont-form" aria-label="Default select example" name="accounttype" id="accounttype">
                            <option value="">Pilih</option>
                            <option value="H">Header</option>
                            <option value="D">Detail</option>
                        </select>
                    </div>
                    <div class="col-2">
                        <span class="cont-text"> Account ID </span><br>
                        <input onkeyup="searchAccount()" type="text" class="cont-form" name="accountidd" id="accountidd" value="">
                    </div>
                    <div class="col-4">
                        <span class="cont-text"> Nama Account </span><br>
                        <input onkeyup="searchAccount()"type="text" class="cont-form" name="accountname" id="accountname" value="">
                    </div>
                    <div class="col-2">
                    <br>
                        <button class="cont-btn" onclick="window.open('Export-Exc.asp')"> Export Excel </button>
                    </div>
                    <div class="col-2">
                    <br>
                        <button class="cont-btn"onclick="window.open('Export-Pdf.asp')"> Export PDF </button>
                    </div>
                </div>
            </div>
            <div class="CA-Table" style="height:20rem; overflow-y:scroll;overflow-x:hidden">
                <div class="row align-items-center p-2">
                    <div class="col-12">
                        <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:13px; border: 1px solid black">
                            <thead>
                                <tr class="text-center">
                                    <th>KODE AKUN</th>
                                    <th>KETERANGAN</th>
                                    <th>KODE UP AKUN</th>
                                    <th>JENIS</th>
                                    <th>TYPE</th>
                                    <th>AKTIF</th>
                                </tr>
                            </thead>
                            <tbody class="DataListItem" id="DataListItem">
                                <% 
                                    no = 0 
                                    do while not ChartAccount.eof 
                                    no = no + 1
                                %>
                                <tr>
                                    <td class="text-center"><button class="cont-btn"  id="myBtn<%=no%>" > <%=ChartAccount("CA_ID")%> </button> </td>
                                    <td><%=ChartAccount("CA_Name")%></td>
                                    <td class="text-center"><%=ChartAccount("CA_UpID")%></td>
                                    <td class="text-center"><%=ChartAccount("CA_Type")%></td>
                                    <td class="text-center"><%=ChartAccount("CA_Jenis")%></td>
                                    <% if ChartAccount("CA_AktifYN") = "Y" then %>
                                    <td class="text-center"> Aktif </td>
                                    <% else %>
                                    <td class="text-center"> Tidak Aktif </td>
                                    <% end if %>
                                                    
                                </tr>
                                <% 
                                    GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT GL_M_ChartAccount.CA_ID, GL_M_ChartAccount.CA_Name, GL_M_ChartAccount.CA_UpID, GL_M_ChartAccount.CA_Jenis, GL_M_ChartAccount.CA_Type, GL_M_ChartAccount.CA_Golongan, GL_M_ChartAccount.CA_Kelompok,  GL_M_ChartAccount.CA_ItemTipe, GL_M_ChartAccount.CA_AktifYN, GL_M_ChartAccount.CA_UpdateID, GL_M_ChartAccount.CA_UpdateTime, GL_M_ChartAccount.CA_Group, GL_M_Kelompok.KCA_ID,GL_M_Kelompok.KCA_Name FROM GL_M_ChartAccount LEFT OUTER JOIN GL_M_Kelompok ON GL_M_ChartAccount.CA_Kelompok = GL_M_Kelompok.KCA_ID WHERE GL_M_ChartAccount.CA_ID ='"& ChartAccount("CA_ID") &"' "
                                    set UpdateChart = GL_M_GL_M_ChartAccount_cmd.execute

                                    GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM [PIGO].[dbo].[GL_M_Kelompok] WHERE KCA_ID <> '"& UpdateChart("CA_Kelompok") &"'"
                                    set CAKel = GL_M_GL_M_ChartAccount_cmd.execute
                                %>
                                <div id="myModal<%=no%>" class="modal">
                                    <div class="modal-content">
                                        <div class="row update-header">
                                            <div class="col-11">
                                                <span class="cont-text"> Update Account Kas <%=ChartAccount("CA_ID")%> </span>
                                            </div>
                                            <div class=" text-end col-1">
                                                <span class="cont-text close<%=no%>">&times;</span>
                                            </div>
                                        </div>
                                        <div class="update-account">
                                            <div class="row mt-3 ">
                                                <div class="col-2">
                                                    <span class="cont-text"> Kode Account  </span><br>
                                                    <input type="text" required class="text-center cont-form" name="newaccid" id="newaccid<%=no%>" value="<%=UpdateChart("CA_ID")%>">
                                                    <input type="hidden" required class="text-center cont-form" name="oldaccid" id="oldaccid<%=no%>" value="<%=UpdateChart("CA_ID")%>">
                                                </div>
                                                <div class="col-2">
                                                    <span class="cont-text"> UP Account </span><br>
                                                    <input type="text" readonly class="text-center cont-form" name="accup" id="accup<%=no%>" value="<%=UpdateChart("CA_UpID")%>">
                                                </div>
                                                <div class="col-6">
                                                    <span class="cont-text"> Nama Account </span><br>
                                                    <input type="text" required class="cont-form" name="accname" id="accname<%=no%>" value="<%=UpdateChart("CA_Name")%>">
                                                </div>
                                                <div class="col-2">
                                                    <span class="cont-text"> Status Account </span><br>
                                                    <select class="cont-form" required aria-label="Default select example" name="aktifyn" id="aktifyn<%=no%>">
                                                        <option value="Y"> Aktif </option>
                                                        <option value="N"> Non-Aktif </option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-4">
                                                    <span class="cont-text"> Kelompok Account </span><br>
                                                    <select class="cont-form" required aria-label="Default select example" name="acckel" id="acckel<%=no%>">
                                                        <option value="<%=UpdateChart("KCA_ID")%>"><%=UpdateChart("KCA_ID")%> - <%=UpdateChart("KCA_Name")%></option>
                                                        <% do while not CAKel.eof %>
                                                            <option value="<%=CAKel("KCA_ID")%>"><%=CAKel("KCA_ID")%> - <%=CAKel("KCA_Name")%></option>
                                                        <% CAKel.movenext
                                                        loop %>
                                                    </select>
                                                </div>
                                                <div class="col-2">
                                                    <span class="cont-text"> Jenis Account </span><br>
                                                    <select class="cont-form" required aria-label="Default select example" name="accjenis" id="accjenis<%=no%>">
                                                    <% if UpdateChart("CA_Jenis") = "D" then %>
                                                        <option value="D">Debet</option>
                                                    <% else %>
                                                        <option value="K">Kredit</option>
                                                    <% end if  %>
                                                        <option value="D">Debet</option>
                                                        <option value="K">Kredit</option>
                                                    </select>
                                                </div>
                                                <div class="col-2">
                                                    <span class="cont-text"> Type Account </span><br>
                                                    <select class="cont-form" required aria-label="Default select example" name="acctype" id="acctype<%=no%>">
                                                    <% if UpdateChart("CA_Type") = "H" then %>
                                                        <option value="H">Header</option>
                                                    <% else %>
                                                        <option value="D">Detail</option>
                                                    <% end if  %>
                                                        <option value="H">Header</option>
                                                        <option value="D">Detail</option>
                                                    </select>
                                                </div>
                                                <div class="col-2">
                                                    <span class="cont-text"> Golongan Acc </span><br>
                                                    <select class="cont-form" required aria-label="Default select example" name="accgol" id="accgol<%=no%>">
                                                    <% if UpdateChart("CA_Golongan") = "N" then %>
                                                        <option value="N">Neraca</option>
                                                    <% else %>
                                                        <option value="L/R">Laba Rugi</option>
                                                    <% end if  %>
                                                        <option value="N">Neraca</option>
                                                        <option value="L/R">Laba Rugi</option>
                                                    </select>
                                                </div>
                                                <div class="col-2">
                                                    <span class="cont-text"> Tipe Item Acc </span><br>
                                                    <select class="cont-form" required aria-label="Default select example" name="acctipeitem" id="acctipeitem<%=no%>">
                                                    <% if UpdateChart("CA_ItemTipe") = "C" then %>
                                                        <option value="C">Cash</option>
                                                    <% else %>
                                                        <option value="B">Bank</option>
                                                    <% end if  %>
                                                        <option value="C">Cash</option>
                                                        <option value="B">Bank</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row mt-3 text-center">
                                                <div class="col-12">
                                                    <button class="cont-btn" onclick="updateAccount<%=no%>()" id=""> Simpan Perubahan </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    var modal<%=no%> = document.getElementById("myModal<%=no%>");
                                    var btn<%=no%> = document.getElementById("myBtn<%=no%>");
                                    var span<%=no%> = document.getElementsByClassName("close<%=no%>")[0];
                                    btn<%=no%>.onclick = function() {
                                    modal<%=no%>.style.display = "block";
                                    }
                                    span<%=no%>.onclick = function() {
                                    modal<%=no%>.style.display = "none";
                                    document.getElementById("loader-page").style.display = "block";
                                    window.location.reload();
                                    setTimeout(() => {
                                        document.getElementById("loader-page").style.display = "none";
                                    }, 8000);
                                    }
                                    
                                    window.onclick = function(event) {
                                    if (event.target == modal<%=no%>) {
                                        modal<%=no%>.style.display = "none";
                                    }
                                    }
                                    function updateAccount<%=no%>(){
                                        var newaccid    = $('#newaccid<%=no%>').val();
                                        var oldaccid    = $('#oldaccid<%=no%>').val();
                                        var accname     = $('#accname<%=no%>').val();
                                        var accup       = $('#accup<%=no%>').val();
                                        var accjenis    = $('#accjenis<%=no%>').val();
                                        var acctype     = $('#acctype<%=no%>').val();
                                        var accgol      = $('#accgol<%=no%>').val();
                                        var acckel      = $('#acckel<%=no%>').val();
                                        var acctipeitem = $('#acctipeitem<%=no%>').val();
                                        var aktifyn     = $('#aktifyn<%=no%>').val();
                                        Swal.fire({
                                            title: 'Anda Yakin Akan Mengubah Data Tersebut ?',
                                            showDenyButton: true,
                                            showCancelButton: true,
                                            confirmButtonText: 'Iya',
                                            denyButtonText: `Tidak`,
                                            }).then((result) => {
                                            if (result.isConfirmed) {
                                                $.ajax({
                                                    type: "GET",
                                                    url: "Update-Account.asp",
                                                    data:{
                                                        newaccid,
                                                        oldaccid,     
                                                        accname,     
                                                        accup,    
                                                        accjenis,    
                                                        acctype,     
                                                        accgol,      
                                                        acckel,      
                                                        acctipeitem,
                                                        aktifyn 
                                                    },
                                                    success: function (data) {
                                                        console.log(data);
                                                        Swal.fire('Data Berhasil Diubah', '', 'success')
                                                        var modal<%=no%> = document.getElementById("myModal<%=no%>");
                                                        modal<%=no%>.style.display = "none";
                                                    }
                                                });
                                            } else if (result.isDenied) {
                                                Swal.fire('Perubahan Dibatalkan')
                                            }
                                        })
                                        
                                    }
                                </script>
                                <% ChartAccount.movenext
                                loop
                                nomor = no  %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
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
        function openmodal(id){
            console.log(id.id);

        }
        // var modal = document.getElementById("myModal");
        // var btn = document.getElementById("myBtn");
        // var span = document.getElementsByClassName("closee")[0];
        // btn.onclick = function() {
        // modal.style.display = "block";
        // }
        // span.onclick = function() {
        // modal.style.display = "none";
        // }
        // window.onclick = function(event) {
        // if (event.target == modal) {
        //     modal.style.display = "none";
        // }
        // }
        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })
        function addaccount(caid){
            var accountid = caid.id
            console.log(accountid);
            $.ajax({
                type: "get",
                url: "Get-Account.asp?accountid="+accountid,
                success: function (url) {
                $('#new-account').html(url);
                $('.old-account').hide();
                }

            });
        }
        function loadAccount(){
            let caid = document.getElementById("account").value;
            console.log(caid);
            let caidname = document.getElementById("nameaccount").value;
            console.log(caidname);
            $.ajax({
                type: "get",
                url: "Load-Account.asp?",
                data:{
                    caid,
                    caidname
                },
                success: function (data) {
                    console.log(data);
                $('#table-account').html(data);
                }

            });
        }
        function searchAccount(){
            var CA_Type         = document.getElementById("accounttype").value;
            var CA_ID           = document.getElementById("accountidd").value;
            var CA_Name         = document.getElementById("accountname").value;
            $.ajax({
                type: "get",
                url: "Add-Account.asp",
                data:{
                    CA_Type,
                    CA_ID,
                    CA_Name
                },
                success: function (data) {
                    console.log(data);
                $('#DataListItem').html(data);
                }

            });
        }
        $('#acction').on('change', function() {
            if( this.value == "B" ){
                $('.old-account').show();
                $('.header-account').hide();
            }else{
                $('.header-account').show();
                $('.old-account').hide();
            }
        });
        $('#btn-add').click(function(){
            $('#TambahBaru-ACC').show();
        })
    </script>
</html>