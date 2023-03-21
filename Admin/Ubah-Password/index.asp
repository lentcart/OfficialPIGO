<!--#include file="../../Connections/pigoConn.asp" -->
<%
    set WebLogin_cmd = server.createObject("ADODB.COMMAND")
	WebLogin_cmd.activeConnection = MM_PIGO_String
        WebLogin_cmd.commandText = "SELECT * FROM WebLogin Where Username = '"& session("username") &"' and UserSection = '"& session("UserSection") &"' "
    set WebLogin = WebLogin_cmd.execute

    UserID    = WebLogin("UserID")
    Password  = WebLogin("Password")

    success = Request.QueryString("success") 
    if success = "x" then
        x = "PASSWORD BERHASIL DI UBAH !!"
    else 
        x = ""
    end if
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
        <script type="text/javascript" src="<%=base_url%>/js/md5.min.js"></script>
        <script>
            function cekPassword(){
                var pass1 = document.getElementById("newpassword").value;
                var pass2 = document.getElementById("repeatnewpassword").value;
                
                if (pass2 != pass1){
                    document.getElementById("notif-pass").innerHTML ="Password Tidak Sesuai Silahkan Ulangi Password !"
                }else if (pass2 = pass1) {
                    document.getElementById("notif-password").innerHTML =`<i" class="fas fa-check-circle"> </i>`
                    document.getElementById("notif-password-p").innerHTML =`<i" class="fas fa-check-circle"> </i>`
                    document.getElementById("notif-pass").innerHTML ="Password Sesuai !"
                }
            }

            function cekOldPassword(){
                var pass    = document.getElementById("password").value;
                var oldpass = md5(document.getElementById("oldpassword").value);
                
                if (oldpass != pass){
                    document.getElementById("notif").innerHTML ="Password Salah !"
                }else if (oldpass = pass) {
                    document.getElementById("notif-berhasil").innerHTML =`<i" class="fas fa-check-circle"> </i>`
                    document.getElementById("notif").innerHTML ="Password Sesuai !"
                }
            }
        </script>
        <style>
            .cont-ubah-password{
                background: linear-gradient(225deg, rgba(6, 173, 224, 0.568), #ffffff 70%), linear-gradient(135deg, #ffffff, transparent 70%), linear-gradient(315deg, rgb(71, 195, 204), transparent 70%);
                margin:20px;
                padding:50px 190px;
                border-radius:20px
            }
            .cont-form{
                background:transparent;
                padding:20px 50px;
                border:none;
                border-radius:20px
            }
            .container{
                background-color:white;
            }
            .txt-judul{
                font-size:30px;
                color:#0077a2;
                font-weight:bold;
            }
            .succses{
                background-color:white;
                padding:20px;
                border-radius:20px;
            }
            .txt-succses{
                color:#0077a2;
                font-size:15px;
                font-weight:bold;
            }
            .btn-succses{
                background-color:#0077a2;
                color:white;
                border:none;
                font-size:15px;
                font-weight:550;
                padding:5px 50px;
                border-radius:20px
            }
            .btn-succses:hover{
                background: linear-gradient(225deg, rgba(6, 173, 224, 0.568), red 99%), linear-gradient(135deg, #ffffff, transparent 70%), linear-gradient(315deg, rgb(71, 195, 204), transparent 70%);
                color:white;
                border:none;
                font-size:15px;
                font-weight:bold;
                padding:5px 50px;
                border-radius:20px
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <div class="cont-ubah-password">
                <div class="row text-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <p class="txt-judul"> UBAH PASSWORD </p>
                    </div>
                </div>
                <div class="cont-form">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">

                        <% if success <> "" then %>
                            <div class="succses" style="justify-content:center;align-items:center;">
                                <div class="row text-center" style="justify-content:center;align-items:center;">
                                    <div class="col-12">
                                        <span class="txt-succses"> <%=x%> </span><br>
                                        <img src="<%=base_url%>/assets/logo/maskot.png" width="150"><br><br>
                                        <a href ="<%=base_url%>/admin/home.asp" class="btn-succses"> KEMBALI </a>
                                    </div>
                                </div>
                            </div>
                        <% else %>
                            <form class="" action="update-password.asp" method="post">
                                <div class="modal-cont-hakakses">

                                    <input readonly type="hidden" name="userid" id="userid" value="<%=UserID%>" >
                                    <input readonly type="hidden" name="password" id="password" value="<%=Password%>" >
                                    <input readonly type="hidden" name="username" id="username" value="<%=session("Username")%>" >
                                    <input readonly type="hidden" name="UserSection" id="UserSection" value="<%=session("UserSection")%>" >

                                    <div class="row align-items-center ">
                                        <div class="col-1">
                                            <span class="txt-hakakses"> <i class="fas fa-lock"></i></span>
                                        </div>
                                        <div class="col-4">
                                            <span class="txt-hakakses">OLD PASSWORD </span><span id="notif-berhasil"></span>
                                        </div>
                                        <div class="col-7">
                                            <input onblur="cekOldPassword()" class="inp-hakakses" type="text" name="oldpassword" id="oldpassword" value=""  placeholder="ENTER OLD PASSWORD"> 
                                            <span id="notif"><i> </i></span>
                                        </div>
                                    </div>
                                    <div class="row align-items-center mt-2 ">
                                        <div class="col-1">
                                            <span class="txt-hakakses"> <i class="fas fa-lock"></i></span>
                                        </div>
                                        <div class="col-4">
                                            <span class="txt-hakakses"> NEW PASSWORD </span><span id="notif-password-p"></span>
                                        </div>
                                        <div class="col-7">
                                            <input class="inp-hakakses" type="password" name="newpassword" id="newpassword" value="" placeholder="ENTER NEW PASSWORD"> 
                                        </div>
                                    </div>
                                    <div class="row align-items-center mt-2 ">
                                        <div class="col-1">
                                            <span class="txt-hakakses"> <i class="fas fa-lock"></i> </span>
                                        </div>
                                        <div class="col-4">
                                            <span class="txt-hakakses"> REPEAT NEW PASSWORD </span><span id="notif-password"></span>
                                        </div>
                                        <div class="col-7">
                                            <input onblur="cekPassword()"class="inp-hakakses" type="password" name="repeatnewpassword" id="repeatnewpassword" value="" placeholder="REPEAT NEW PASSWORD">
                                            <span id="notif-pass"><i> </i></span>
                                        </div>
                                    </div>
                                    <div class="row align-items-center mt-4 ">
                                        <div class="col-2">
                                            <button type="submit"  class="btn-hakakses"  id="submit1">UPDATE</button>
                                        </div>
                                        <div class="col-2">
                                            <button type="button" class="btn-hakakses" id="submit2" onclick="window.location.href='<%=base_url%>/admin/home.asp'">CANCLE</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        <% end if  %>

                    </div>
                </div>
                </div>
            </div>
        </div>
    </body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>  
    <script>
        
    <script>
</html>