<!--#include file="../connections/pigoConn.asp"--> 
<%

    dim user

    user = Session("Username")

    if user = true then 
        response.redirect("../../admin/home.asp")

    end if

    UserSection = Request.queryString("e")
    Password    = Request.queryString("x")
    Error       = Request.queryString("b")
%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>OFFICIAL PIGO</title>
    <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/trial.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <style>
        .alert{
            width:100%; 
            font-size:12px; 
            border:1px solid white; 
            padding:2px 10px; 
            background-color:#940005;
            color:white;"
        }
    </style>
<body>
    <div class="container" style="background-color:white">
        <form class="" action="P-LoginUser.asp" method="POST">
        <div class="cont-login-user">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12 maskot-cont">
                    <div class="login-user-maskot">
                        <span class="login-user-judul"> OFFICIAL PIGO <%=user%></span><br>
                        <span class="login-user-judul" style="font-size:17px;"> PT INDAH GEMILANG OETAMA </span><br>
                        <img src="../assets/logo/maskotnew.png" class="figure-img img-fluid img-maskot " width="200" height="200" alt="">
                    </div>
                </div>
                <div class="col-lg-6 col-md-12 col-sm-12">
                    <div class="row cont-maskot-2 align-items-center text-center">
                        <div class="col-2">
                            <img src="../assets/logo/maskotnew.png" class="figure-img maskot-img" alt="">
                        </div>
                        <div class="col-10">
                            <span class="login-user-judul"> PT. INDAH GEMILANG OETAMA </span>
                        </div>
                    </div>

                    <div class="login-user-form">
                    <% if UserSection <> "" then  %> 
                        <div class="row">
                            <div class="col-12 text-center">
                                <div data-bs-dismiss="alert" class=" alert text-center alert-warning alert-dismissible fade show" role="alert">- <strong>  Maaf  - </strong> User Section Tidak Sesuai !    
                                </div>
                            </div>
                        </div>
                    <% end if %>
                    <% if Password <> "" then  %> 
                        <div class="row">
                            <div class="col-12 text-center">
                                <div data-bs-dismiss="alert" class=" alert text-center alert-warning alert-dismissible fade show" role="alert">- <strong>  Maaf  - </strong> Password Tidak Sesuai !    
                                </div>
                            </div>
                        </div>
                    <% end if %>
                    <% if Error <> "" then  %> 
                        <div class="row">
                            <div class="col-12 text-center">
                                <div data-bs-dismiss="alert" class=" alert text-center alert-warning alert-dismissible fade show" role="alert">- <strong>  Maaf  - </strong> User Tidak Ditemukan !    
                                </div>
                            </div>
                        </div>
                    <% end if %>
                        <div class="row">
                            <div class="col-12 text-center">
                                <span class=""> <i class="login-user-logo fas fa-user-circle"></i></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <input class="inp-login-user-form mt-4" type="text" placeholder="Username" name="UserName" id="UserName">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="input-group">
                                    <input class="inp-login-user-form-pw  mt-3" type="password" placeholder="Password" name="Password" id="password" >
                                    <span class=" pw-cont inp-login-user-form-tg " id="basic-addon1"><i class="far fa-eye pw-eye" aria-hidden="true" id="eye" onclick="toggle()"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <select class=" mt-3 inp-login-user-form" name="usersection" id="usersection">
                                    <option value="">SELECT</option>
                                    <option value="01">HEAD OFFICE</option>
                                    <option value="02">ADMINISTRATIVE STAFF</option>
                                    <option value="03">FINANCIAL STAFF</option>
                                    <option value="04">STAFF IT</option>
                                </select> 
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <input type="submit" class="login-user-login" value="Log In">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>
        var state= false;
        function toggle(){
            if(state){
                document.getElementById("password"). setAttribute("type","password"); state = false;
                document.getElementById("eye").style.color='#7a797e';
            }
            else{
                document.getElementById("password"). setAttribute("type","text"); state = true;
                document.getElementById("eye").style.color='#0dcaf0';
            }
        }
        function loginuser(){
            var user = document.getElementById("UserName").value;
            var pw = document.getElementById("password").value;
            var section = document.getElementById("usersection").value;
            $.ajax({
                type: "GET",
                url: "P-LoginUser.asp",
                data:{
                    user,
                    pw,
                    section
                },
                success: function (data) {
                    console.log(data);
                    
                }
            });
        }
    </script>
</html>