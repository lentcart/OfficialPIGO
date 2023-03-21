<!--#include file="../Connections/pigoConn.asp" -->
<%
    if session("username") <> "administrator" then 
        Response.redirect "../Admin/"
    end if 
    set WebLogin_cmd = server.createObject("ADODB.COMMAND")
	WebLogin_cmd.activeConnection = MM_PIGO_String
        WebLogin_cmd.commandText = "SELECT * FROM WebLogin Where UserAktifYN = 'Y' "
    set WebLogin = WebLogin_cmd.execute
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
        .container{
            background-color:white;
        }
        .loader{
    margin: 0 0 2em;
    height: 100px;
    width: 20%;
    text-align: center;
    padding: 1em;
    margin: 0 auto 1em;
    display: inline-block;
    vertical-align: top;
    }

    /*
    Set the color of the icon
    */
    svg path,
    svg rect{
    fill: #FF6700;
    }
    </style>
    </head>
<body>

    <div class="container mt-4">
        <div class="row text-center">
            <div class="col-12">
                <h4> HAK AKSES USER WEB OFFICIAL PIGO </h4><br>
            </div>
            <div class="row">
                <div class="col-12">
                <div class="cont-hakakses">
                    <div class="row align-items-center mb-2">
                        <div class="col-1">
                            <button class="btn-hakakses"> SEARCH </button>
                        </div>
                        <div class="col-6">
                            <input class="inp-hakakses" type="search" name="username" id="username" value="" placeholder="ENTER USERNAME"> 
                        </div>
                        <div class="col-5">
                            <div class="row">
                                <div class="col-5">
                                    <button id="btn-add" class="btn-hakakses"> ADD NEW USER </button> 
                                </div>
                                <div class="col-4">
                                    <div class="row text-center" id="loader-up" style="display:none">
                                    <!-- 6 -->
                                        <div class="loader loader--style6" title="5">
                                        <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                            width="24px" height="30px" viewBox="0 0 24 30" style="enable-background:new 0 0 50 50;" xml:space="preserve">
                                            <rect x="0" y="13" width="4" height="5" fill="#333">
                                            <animate attributeName="height" attributeType="XML"
                                                values="5;21;5" 
                                                begin="0s" dur="0.6s" repeatCount="indefinite" />
                                            <animate attributeName="y" attributeType="XML"
                                                values="13; 5; 13"
                                                begin="0s" dur="0.6s" repeatCount="indefinite" />
                                            </rect>
                                            <rect x="10" y="13" width="4" height="5" fill="#333">
                                            <animate attributeName="height" attributeType="XML"
                                                values="5;21;5" 
                                                begin="0.15s" dur="0.6s" repeatCount="indefinite" />
                                            <animate attributeName="y" attributeType="XML"
                                                values="13; 5; 13"
                                                begin="0.15s" dur="0.6s" repeatCount="indefinite" />
                                            </rect>
                                            <rect x="20" y="13" width="4" height="5" fill="#333">
                                            <animate attributeName="height" attributeType="XML"
                                                values="5;21;5" 
                                                begin="0.3s" dur="0.6s" repeatCount="indefinite" />
                                            <animate attributeName="y" attributeType="XML"
                                                values="13; 5; 13"
                                                begin="0.3s" dur="0.6s" repeatCount="indefinite" />
                                            </rect>
                                        </svg>
                                        </div>
                                        <!--<div class="col-12">
                                            <div class="loader1">
                                                <span></span>
                                                <span></span>
                                                <span></span>
                                                <span></span>
                                                <span></span>
                                            </div>
                                        </div>-->
                                    </div>
                                </div>
                                <div class="col-2 mt-2">
                                    <a href="Logout.asp"  class="btn-hakakses"> LOGOUT </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row ">
                    <div class="col-12">
                        <table class=" align-items-center table tb-userlogin table-bordered table-condensed mt-1" style="font-size:13px; background:#07abdd; border: 3px solid black">
                            <thead>
                                <tr class="text-center">
                                    <th>NO</th>
                                    <th>SURENAME</th>
                                    <th>USERNAME</th>
                                    <th>AS</th>
                                    <th>AKSES LOGIN</th>
                                    <th>LAST LOGIN</th>
                                    <th colspan="2" >AKSI</th>
                                </tr>
                            </thead>

                            <tbody style="font-size:13px; background:#eee; border: 3px solid black">
                                <% 
                                    no = 0
                                    do while not WebLogin.eof
                                    no = no + 1
                                %>
                                <tr class="tb-userlogin">
                                    <td class="text-center"><%=no%> </td>
                                    <td class="text-start"> 
                                        <%=WebLogin("Surename")%> 
                                        <input type="hidden" name="userid" id="userid<%=no%>" value="<%=WebLogin("UserID")%>">
                                        <input type="hidden" name="usersection" id="usersection<%=no%>" value="<%=WebLogin("Usersection")%>">
                                    </td>
                                    <td class="text-start">
                                        <input type="hidden" name="username" id="username<%=no%>" value="<%=WebLogin("Username")%>"><%=WebLogin("Username")%> 
                                    </td>
                                    <% if WebLogin("Usersection") = "01" then %>
                                    <td class="text-center"> HEAD OFFICE </td>
                                    <% else if WebLogin("Usersection") = "02" then %>
                                    <td class="text-center"> ADMINISTRATIVE STAFF </td>
                                    <% else if WebLogin("Usersection") = "03" then %>
                                    <td class="text-center"> FINANCIAL STAFF </td>
                                    <% else  %>
                                    <td class="text-center"> STAFF IT </td>
                                    <% end if %> <% end if %> <% end if %> 
                                    <td class="text-start"><%=WebLogin("UserserverID")%> </td>
                                    <td class="text-center"><%=WebLogin("Userlastlogin")%> </td>
                                    <td class="text-center">
                                        <button class="cont-btn" style="background-color:green; color:white"> <%=WebLogin("UserAktifYN")%> </button>
                                    </td>
                                    <td class="text-center">
                                        <button onclick="window.open('updateakses.asp?userid='+document.getElementById('userid<%=no%>').value+'&username='+document.getElementById('username<%=no%>').value+'&usersection='+document.getElementById('usersection<%=no%>').value,'_Self')" class="cont-btn" style="background-color:#0077a2; color:white"> UPDATE </button> 
                                    </td>
                                </tr>
                                <% WebLogin.movenext
                                loop %>
                            <tbody>
                        </table>
                    </div>
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
                            <span class="txt-modal-judul"> REGISTER NEW USER OFFICIAL PIGO </span>
                        </div>
                        <div class="col-1">
                            <span><i class="fas fa-times closee"></i></span>
                        </div>
                    </div>
                    <hr>
                    <form class="" action="add-newuser.asp" method="post">
                        <div class="modal-cont-hakakses">
                            <div class="row align-items-center mb-2 ">
                                <div class="col-1">
                                    <span class="txt-hakakses"><i class="fas fa-user-plus"></i></span>
                                </div>
                                <div class="col-4">
                                    <span class="txt-hakakses"> FULL NAME OF USER </span><span id="notif-sure"></span>
                                </div>
                                <div class="col-7">
                                    <input onblur="cekSurename()" class="inp-hakakses" type="text" name="surename" id="surename" maxlength="100" value="" placeholder="ENTER FULL NAME OF USER">
                                    <span id="notif-surename"><i> </i></span>
                                </div>
                            </div>
                            <div class="row align-items-center mt-2 ">
                                <div class="col-1">
                                    <span class="txt-hakakses"><i class="fas fa-user"></i> </span>
                                </div>
                                <div class="col-4">
                                    <span class="txt-hakakses">USERNAME </span><span id="notif-berhasil"></span>
                                </div>
                                <div class="col-7">
                                    <input onblur="cekUsername()" class="inp-hakakses" type="text" name="username" id="username" value=""  placeholder="ENTER USERNAME"> 
                                    <span id="notif"><i> </i></span>
                                </div>
                            </div>
                            <div class="row align-items-center mt-2 ">
                                <div class="col-1">
                                    <span class="txt-hakakses"> <i class="fas fa-lock"></i></span>
                                </div>
                                <div class="col-4">
                                    <span class="txt-hakakses"> PASSWORD </span><span id="notif-password-p"></span>
                                </div>
                                <div class="col-7">
                                    <input class="inp-hakakses" type="password" name="password" id="password" value="" placeholder="ENTER PASSWORD"> 
                                </div>
                            </div>
                            <div class="row align-items-center mt-2 ">
                                <div class="col-1">
                                    <span class="txt-hakakses"> <i class="fas fa-lock"></i> </span>
                                </div>
                                <div class="col-4">
                                    <span class="txt-hakakses"> REPEAT PASSWORD </span><span id="notif-password"></span>
                                </div>
                                <div class="col-7">
                                    <input onblur="cekPassword()"class="inp-hakakses" type="password" name="repeatpassword" id="repeatpassword" value="" placeholder="REPEAT PASSWORD">
                                    <span id="notif-pass"><i> </i></span>
                                </div>
                            </div>
                            <div class="row align-items-center mt-2 ">
                                <div class="col-1">
                                    <span class="txt-hakakses"> <i class="fas fa-portrait"></i> </span>
                                </div>
                                <div class="col-4">
                                    <span class="txt-hakakses"> SECTION STAFF </span>
                                </div>
                                <div class="col-7">
                                    <select class="inp-hakakses" name="usersection" id="usersection">
                                        <option value="01">HEAD OFFICE</option>
                                        <option value="02">ADMINISTRATIVE STAFF</option>
                                        <option value="03">FINANCIAL STAFF</option>
                                        <option value="04">STAFF IT</option>
                                    </select> 
                                </div>
                            </div>
                            <div class="row align-items-center mt-4 ">
                                <div class="col-2">
                                    <input class="btn-hakakses"type="submit" name="save" id="save" value="SAVE">
                                </div>
                                <div class="col-2">
                                    <button class="btn-hakakses"> CANCLE </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        <!-- Modal content -->
</body>
<script>

    var modal = document.getElementById("myModal");
    var btn = document.getElementById("btn-add");
    var span = document.getElementsByClassName("closee")[0];
        btn.onclick = function() {
            document.getElementById("loader-up").style.display = "block";
                setTimeout(() => {
                document.getElementById("loader-up").style.display = "none";
                modal.style.display = "block";
            }, 10000);
        }
    span.onclick = function() {
        modal.style.display = "none";
            setTimeout(() => {
            document.getElementById("loader-up").style.display = "none";
            window.location.reload();
        }, 10000);
    }
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    function cekSurename(){
        var sure = document.getElementById("surename");
        if (sure.value.length > 100){
            document.getElementById("notif-surename").innerHTML ="Masukan Maksimal 100 Karakter"
        } else {
            document.getElementById("notif-sure").innerHTML =`<i" class="fas fa-check-circle"> </i>`
        }
    }

    function cekUsername(){
        var user = document.getElementById("username");
        if (user.value.length > 10){
            document.getElementById("notif").innerHTML ="Masukan Maksimal 10 Karakter"
        }else{
            document.getElementById("notif-berhasil").innerHTML =`<i" class="fas fa-check-circle"> </i>`
        }
    }
    function cekPassword(){
        
        var pass1 = document.getElementById("password").value;
        var pass2 = document.getElementById("repeatpassword").value;
        
        
        if (pass2 != pass1){
            document.getElementById("notif-pass").innerHTML ="Password Tidak Sesuai Silahkan Ulangi Password !"
        }else if (pass2 = pass1) {
            document.getElementById("notif-password").innerHTML =`<i" class="fas fa-check-circle"> </i>`
            document.getElementById("notif-password-p").innerHTML =`<i" class="fas fa-check-circle"> </i>`
        }
    }
</script>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>  
</html>