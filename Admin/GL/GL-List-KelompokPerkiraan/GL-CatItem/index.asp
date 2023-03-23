<!--#include file="../../../../Connections/pigoConn.asp" -->

<%
    if Session("Username")="" then 

    response.redirect("../../../../admin/")
    
    end if

        dim MaxID

        set GL_M_CategoryItem_CMD = server.createObject("ADODB.COMMAND")
        GL_M_CategoryItem_CMD.activeConnection = MM_PIGO_String
        GL_M_CategoryItem_CMD.commandText = "SELECT * FROM GL_M_CategoryItem_PIGO WHERE Cat_AktifYN = 'Y'"
        set CatItem = GL_M_CategoryItem_CMD.execute

        GL_M_CategoryItem_CMD.commandText = "SELECT MAX(Cat_ID) AS Cat_ID , MAX(LEFT(Cat_ID,3)) AS MaxID FROM GL_M_CategoryItem_PIGO WHERE Cat_AktifYN = 'Y'"
        set LastCAID = GL_M_CategoryItem_CMD.execute

        GL_M_CategoryItem_CMD.commandText = "SELECT '"& LastCAID("MaxID") &"' + Right('0000000000' + Convert(VarChar, COnvert(int, Right(IsNull(MAX(Cat_ID),'0000000000'),10))+1),10) AS MaxID FROM GL_M_CategoryItem_PIGO WHERE LEFT(Cat_ID,3) = '"& LastCAID("MaxID") &"' "
        set Max = GL_M_CategoryItem_CMD.execute

        GL_M_CategoryItem_CMD.commandText = "SELECT Cat_ID , Cat_Name, Cat_Tipe FROM GL_M_CategoryItem_PIGO WHERE Cat_ID = '"& LastCAID("Cat_ID") &"' "
        set LastAccount = GL_M_CategoryItem_CMD.execute

        NextID      = Max("MaxID")
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
    <!--#include file="../../../loaderpage.asp"-->
    <script>
        function searchAccount(){
            var Cat_ID         = document.getElementById("idcat").value;
            var Cat_Name       = document.getElementById("namecat").value;
            var Cat_Tipe       = document.getElementById("tipecat").value;
            $.ajax({
                type: "GET",
                url: "Load-CatItem.asp",
                data:{
                    Cat_ID,
                    Cat_Name,
                    Cat_Tipe
                },
                success: function (data) {
                    console.log(data);
                    $('#DataListItem').html(data);
                }

            });
        }
    </script>

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
            display:block;
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
        <!--#include file="../../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <div class="row">
                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <span class="cont-text"> DAFTAR KATEGORI ITEM (HEADER KAS MASUK/KELUAR)</span>
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
                        <span class="cont-text"> TAMBAH KATEGORI ITEM </span>
                    </div>
                </div>
                <!-- NEW ACCOUNT AS Header-->
                <div class="header-account">
                    <form class="" action="P-NewCatItem.asp" method="POST">
                        <div class="row ">
                            <div class="col-3">
                                <span class="cont-text"> Last ID Kategori  </span>
                                <input class="text-center cont-form" readonly type="text" value="<%=LastAccount("Cat_ID")%>">
                            </div>
                            <div class="col-6">
                                <span class="cont-text"> Last Nama Kategori Item </span>
                                <input class="cont-form" readonly type="text" value="<%=LastAccount("Cat_Name")%>">
                            </div>
                            <div class="col-3">
                                <span class="cont-text"> Tipe Kategori </span>
                                <% if LastAccount("Cat_Tipe") = "T" then %>
                                <input class="cont-form" readonly type="text" value="Masuk">
                                <% else %>
                                <input class="cont-form" readonly type="text" value="Keluar">
                                <% end if %>
                            </div>
                        </div>
                        <hr>
                        <div class="row text-center mt-2 ">
                            <div class="col-12">
                                <span class="cont-text" style="font-size:15px; font-weight:600">DAFTAR KATEGORI ITEM (HEADER KAS MASUK/KELUAR) BARU </span>
                            </div>
                        </div>
                        <div class="row mt-3 ">
                            <div class="col-3">
                                <span class="cont-text"> ID Kategori Item </span><br>
                                <input type="text" readonly class="text-center cont-form" name="Cat_ID" id="Cat_ID" value="<%=NextID%>">
                            </div>
                            <div class="col-6">
                                <span class="cont-text"> Nama Kategori Item </span><br>
                                <input type="text" required class="cont-form" name="Cat_Name" id="Cat_Name" value="">
                            </div>
                            <div class="col-3">
                                <span class="cont-text"> Tipe Kategori Item </span><br>
                                <select class="cont-form" required aria-label="Default select example" name="Cat_Tipe" id="Cat_Tipe">
                                    <option value="">Pilih Tipe Kategori</option>
                                    <option value="T"> Masuk </option>
                                    <option value="K"> Keluar </option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3 text-center">
                            <div class="col-12">
                                <input type="submit" class="cont-btn" name="up-account" id="up-account" value="TAMBAH">
                            </div>
                        </div>
                    </form>
                </div>
                <!-- NEW ACCOUNT AS Header-->

                <div class="new-account" id="new-account">
                    
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row align-items-center p-2">
                    <div class="col-2">
                        <span class="cont-text"> Type Kategori </span><br>
                        <select onchange="searchAccount()" class="cont-form" aria-label="Default select example" name="tipecat" id="tipecat">
                            <option value="">Pilih</option>
                            <option value="T">Masuk</option>
                            <option value="K">Keluar</option>
                        </select>
                    </div>
                    <div class="col-2">
                        <span class="cont-text"> ID Kategori </span><br>
                        <input onkeyup="searchAccount()" type="text" class="cont-form" name="idcat" id="idcat" value="">
                    </div>
                    <div class="col-4">
                        <span class="cont-text"> Nama Kategori Item </span><br>
                        <input onkeyup="searchAccount()"type="text" class="cont-form" name="namecat" id="namecat" value="">
                    </div>
                    <div class="col-2">
                    <br>
                        <button class="cont-btn"> Export Excel </button>
                    </div>
                    <div class="col-2">
                    <br>
                        <button class="cont-btn"> Export PDF </button>
                    </div>
                </div>
            </div>

            <div class="CA-Table">
                <div class="row align-items-center p-2">
                    <div class="col-12">
                        <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:13px; border: 1px solid black">
                            <thead>
                                <tr class="text-center">
                                    <th>NO</th>
                                    <th>ID KATEGORI</th>
                                    <th>NAMA KATEGORI ITEM</th>
                                    <th>TIPE KATEGORI ITEM</th>
                                    <th>AKTIF</th>
                                    <th>UPDATE TIME</th>
                                    <th>AKSI</th>
                                </tr>
                            </thead>
                            <tbody class="DataListItem" id="DataListItem">
                                <% 
                                    no = 0 
                                    do while not CatItem.eof 
                                    no = no + 1
                                %>
                                <tr>
                                    <td class="text-center"><%=no%></td>
                                    <td class="text-center"><button class="cont-btn" style="width:max-content"> <%=CatItem("Cat_ID")%> </button> </td>
                                    <td><%=CatItem("Cat_Name")%></td>
                                    <% if CatItem("Cat_Tipe") = "T" then %>
                                    <td class="text-center"> Masuk </td>
                                    <% else %>
                                    <td class="text-center"> Keluar </td>
                                    <% end if %>
                                    <td class="text-center" ><%=CatItem("Cat_AktifYN")%></td>
                                    <td class="text-center" ><%=CatItem("Cat_UpdateTime")%></td>
                                    <td class="text-center" >
                                        <button class="cont-btn" onclick="hapus('<%=CatItem("Cat_ID")%>')"> DELLETE </button>
                                    </td>
                                                    
                                </tr>
                                <% CatItem.movenext
                                loop
                                nomor = no  %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!--#include file="../../../ModalHome.asp"-->
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

        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })
        
        
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

        function hapus(id){
            const Cat_ID = id;
            $.ajax({
                type: "GET",
                url: "UP-CatItem.asp?Cat_ID="+Cat_ID,
                success: function (url) {
                    location.reload();
                }

            });
        }
    </script>
</html>