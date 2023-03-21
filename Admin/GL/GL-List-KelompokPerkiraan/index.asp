<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

    set GL_M_Kelompok_cmd = server.createObject("ADODB.COMMAND")
	GL_M_Kelompok_cmd.activeConnection = MM_PIGO_String
        GL_M_Kelompok_cmd.commandText = "SELECT * FROM GL_M_Kelompok "
    set ItemList = GL_M_Kelompok_cmd.execute


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
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <span class="cont-text"> DAFTAR KELOMPOK PERKIRAAN  </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button class="cont-btn"name="btn-refresh" id="btn-refresh" onclick="return Refresh()" type="button" style="display:block" >  <i class="fas fa-sync"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12">
                        <button class="tambah-list cont-btn" name="btn-add" id="btn-add"  type="button" style="display:block"> Tambah  </button>
                        <button class="tambah-list cont-btn" name="btn-cancle" id="btn-cancle" type="button" style="display:none"> Batal  </button>
                    </div>
                </div>
            </div>
            <div class="row align-items-center p-2">
                <div class="col-12">
                    <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:13px; border: 1px solid black">
                        <thead>
                            <tr class="text-center">
                                <th>KODE</th>
                                <th>NAMA KELOMPOK PERKIRAAN</th>
                                <th>AKTIF YN</th>
                                <th>UPDATE ID</th>
                                <th>UPDATE TIME</th>
                            </tr>
                        </thead>
                        <tbody class="DataListItem" id="DataListItem">
                            <% do while not ItemList.eof %>
                            <tr>
                                <td class="text-center"><input class="text-center inp-purchase-order" readonly type="text" name="kodeitem" id="kodeitem" value="<%=ItemList("KCA_ID")%>" style="border:none;width:2rem"></td>
                                <td><%=ItemList("KCA_Name")%></td>
                                <% if ItemList("KCA_AktifYN") = "Y" then %>
                                <td class="text-center"> Aktif </td>
                                <% else %>
                                <td class="text-center"> Tidak Aktif </td>
                                <% end if %>
                                <td class="text-center"><%=ItemList("KCA_UpdateID")%></td>
                                <td class="text-center"><%=ItemList("KCA_UpdateTime")%></td>
                                                
                            </tr>
                            <% ItemList.movenext
                            loop %>
                        </tbody>
                    </table>
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
        var modal = document.getElementById("myModal");
        var btn = document.getElementById("myBtn");
        var span = document.getElementsByClassName("closee")[0];
        btn.onclick = function() {
        modal.style.display = "block";
        }
        span.onclick = function() {
        modal.style.display = "none";
        }
        window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        }
        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })
    </script>
</html>