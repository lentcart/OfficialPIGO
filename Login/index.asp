<!--#include file="../connections/pigoConn.asp"--> 
<% 
    
    password = Request.queryString("err")
    jumlahsalah = Request.queryString("a")
    e = Request.queryString("e")

%> 
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> PIGO | Log In </title>
    <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    

    </head>
        <script>
            var code;
                function createCaptcha() {
                document.getElementById('captcha').innerHTML = "";
                    var charsArray = "0123456789abcdefghijklmnoDDpqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@!#$%&*";
                    var lengthOtp = 6;
                    var captcha = [];
                    for (var i = 0; i < lengthOtp; i++) {
                        var index = Math.floor(Math.random() * charsArray.length + 1); 
                        if (captcha.indexOf(charsArray[index]) == -1)
                        captcha.push(charsArray[index]);
                        else i--;
                    }
                    var canv = document.createElement("canvas");
                        canv.id = "captcha";
                        canv.width = 500;
                        canv.height = 26;
                    var ctx = canv.getContext("2d");
                        ctx.font = "28px Arial Black";
                        ctx.fillText(captcha.join(" "), 95, 20);
                        code = captcha.join("");
                        document.getElementById("captcha").appendChild(canv); 
                    }        
        </script>
        <style>
            .form-login{
                margin:0 auto;
            }
        </style>
    <body onload="createCaptcha(),rubah()">
    <!--#include file="../header.asp"--> 
    <div class="container" style="margin-top:8rem">
        <div class="row">
            <div class="col-lg-12">
                <div class="row">
                    <div class="col-6 text-center">
                        <img src="../assets/logo/maskotnew.png" class="figure-img img-fluid " width="480" height="480" alt="">
                    </div>
                    <div class="col-6">
                        <form class="form-login" method="post" action="P-login.asp" style="height:28rem" >
                            <p class="text-center text-judul mt-2 "><b> LOGIN </b></p>
                                <div class="f-login">
                                    <div class="row">
                                        <div class="col-12">
                                            <input Required class="f-input mt-4" type="text" placeholder="Masukan Alamat Email" name="email" id="email">
                                                <div class="input-group">
                                                    <input  Required class="f-input-border me-1" type="password" placeholder="Password" name="password" id="password">
                                                    <span class="input-group-text  " id="basic-addon1"><i class="far fa-eye" aria-hidden="true" id="eye" onclick="toggle()"></i></span>
                                                </div>
                                                <% if password <> "" then  %> 
                                                    <input type="hidden" name="jumlahsalah" id="jumlahsalah" value="<%=jumlahsalah%>">
                                                    
                                                    <% if jumlahsalah >= 3 then %>
                                                    
                                                        <div data-bs-dismiss="alert" class=" alert text-center alert-warning alert-dismissible fade show" role="alert" style="position:absolute; background-color:#0dcaf07c; border:none; color: #0b3f49; font-size:11px; font-weight:bold; margin-left:0px; margin-top:5rem; bottom:25rem; border-radius:20px; width:26rem; padding:5px 5px">
                                                            Anda Mengulang Lebih Dari 2 Kali Silahkan Masukan Kode Dibawah
                                                        </div>
                                                        <div class="cont-captcha" >
                                                            <div class="valid-captcha cont-login" id="captcha" style="width:23rem">
                                                            </div>
                                                            <div class="row cont-login">
                                                                <div class="col-12">
                                                                    <input Required class="inp-login" type="text" placeholder="Masukan Kode Diatas" id="cpatchaTextBox" style="font-weight:bold">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <button type="button" onclick="return kirimdata()" class="btn btn-outline-secondary btn-login textLogin" style="width:23rem"><b>Login</b></button>
                                                        <script>
                                                            function rubah(){
                                                                var y = document.getElementById("tombolsubmit");
                                                                y.type= "hidden";
                                                                var x = document.getElementById("fb");
                                                                x.style.display = "none";
                                                            }
                                                        </script>
                                                    <%else %>
                                                        <div data-bs-dismiss="alert" class=" alert text-center alert-warning alert-dismissible fade show" role="alert" style="position:absolute; background-color:#0dcaf07c; border:none;  color: #0b3f49; font-size:13px; font-weight:bold; margin-left:0px; margin-top:5rem; bottom:25rem; border-radius:20px; width:26rem; padding:5px 5px">
                                                            - <strong>  Maaf  - </strong> Email Atau Password Tidak Sesuai !    
                                                        </div>
                                                    <%end if%>
                                                <% else  %> 
                                                    <input type="hidden" name="jumlahsalah" id="jumlahsalah" value="0">
                                                <% end if%>
                                            <input  type="submit" id="tombolsubmit" class="btn btn-outline-secondary btn-login textLogin" style="width:23rem" value="Login">
                                            <a href="#" class="txt-lppass text-hoverlog">Lupa Password ? </a><br>
                                            <a href="../Register/" class="txt-daftar text-hoverlog">Belum memiliki akun ?<span style="color:#0077a2"><b> Daftar </b></span></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" id="fb">
                                    <div class="col-12">
                                        <button type="button" class=" btn-facebook textLogin"><img src="<%=base_url%>/assets/logo/facebook.png" class="figure-img img-fluid mt-1 " width="35" height="35" alt="">Facebook</button>
                                        <button type="button" class=" btn-google textLogin"><img src="<%=base_url%>/assets/logo/google.png" class="figure-img img-fluid mt-1 " width="35" height="35" alt="">Google</button>
                                    </div>
                                </div>
                            <!-- <button type="button" class=" btn-facebook textLogin"><img src="../assets/logo/facebook.png" class="figure-img img-fluid mt-1 " width="35" height="35" alt="">Facebook</button>
                            <button type="button" class=" btn-google textLogin"><img src="../assets/logo/google.png" class="figure-img img-fluid mt-1 " width="35" height="35" alt="">Google</button> -->
                        </form>
                        <% if e <> "" then  %> 
                            <div data-bs-dismiss="alert" class=" alert text-center alert-warning alert-dismissible fade show" role="alert" style="position:absolute; background-color:#0dcaf07c; border:none; color: #0b3f49; font-size:13px; font-weight:bold; margin-left:85px; margin-top:5rem; bottom:25rem; border-radius:20px; width:26rem; padding:5px 5px">
                                - <strong> Maaf </strong> - Email Belum Terdaftar !
                            </div>
                        <% else  %> 
                    </div>
                    <%end if%>
                </div>
            </div>
        </div>
    
    </div>

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
        function kirimdata(){
            var alamatemail = document.getElementById("email").value;
            var pass = document.getElementById("password").value;
                // console.log(alamatemail);
                // console.log(pass);
            $.ajax({
                    type: "POST",
                    url: "P-Login.asp",
                    data : { email : alamatemail, password : pass },
                    success: function (data) {
                    console.log(data);
                    }
                });
        }
        function validateCaptcha() {
            if (document.getElementById("cpatchaTextBox").value == code) {
                kirimdata();
            }else{
                Swal.fire('Kode Yang Anda Masukan Salah , Coba Lagi !')
                document.getElementById("cpatchaTextBox").value = "";
                createCaptcha();
            }
        }
    </script>


    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    

    
    

    </body>
</html>