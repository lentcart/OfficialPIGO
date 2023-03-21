<!--#include file="../connections/pigoConn.asp"--> 
<% 
    if Session("Username")= "" then 
        response.redirect("../Register/")
    else
        response.redirect("index.asp")
    end if

    e= Request.queryString("e")

%> 
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> PIGO | Daftar </title>
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
            function regis(){
                let email = document.getElementById("email").value;
                let pass1 = document.getElementById("pass1").value;
                let pass2 = document.getElementById("pass2").value;
                let phone1 = document.getElementById("phone1").value;
                let cek     = document.getElementById("cek-setuju");

                if (pass2 != pass1){
                    Swal.fire({
                        icon: 'warning',
                        title: 'Oops...',
                        text: 'Password Tidak Valid ! Ulangi Password'
                    });
                    return false;
                }

                if (phone1.length >= 13 ){
                    Swal.fire({
                        icon: 'warning',
                        title: 'Oops...',
                        text: 'Nomor Telepon Tidak Valid !'
                    });
                    
                    return false;
                }

                if (!cek.checked){
                    Swal.fire({
                        icon: 'warning',
                        title: 'Oops...',
                        text: 'Penuhi Syarat berikut : Saya Menyetujui Syarat & Ketentuan yang Berlaku'
                    });
                    return false;
                }
            }
            function daftar(){
            location.reload();
                AmagiLoader.show();
                setTimeout(() => {
                    AmagiLoader.hide();
                }, 50000000000000000);
            }
        </script>
        <style>
            .form-login{
                margin:0 auto;
            }
            .f-inputtt {
                padding: 8px;
                width: 7.2rem;
                font-size: 15px;
                font-family: "Poppins", sans-serif;
                border: 1px solid #c4c4c4;
                border-radius: 10px;
                margin-bottom: 20px;
                margin-left: 25px;
                }
            .f-input {
                padding: 8px 10px;
                width: 88%;
                font-size: 15px;
                margin-left: 25px;
                font-family: "Poppins", sans-serif;
                border: 1px solid #c4c4c4;
                border-radius: 50px;
                margin-bottom: 10px;
            }
        </style>
    <body>
        <!--#include file="../header.asp"--> 
        <div class="container" style="margin-top:8rem">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-6 text-center">
                            <img src="../assets/logo/maskotnew.png" class="figure-img img-fluid " width="480" height="480" alt="">
                        </div>
                        <div class="col-6">
                            <form class="form-login" method="post" action="P-regis.asp" onsubmit="return regis()" style="height:28rem" >
                                <p class="text-center text-judul mt-2 "><b> DAFTAR </b></p>
                                <div class="f-login">
                                    <div class="row">
                                        <div class="col-12">
                                            <input Required class="f-input mt-4" type="text" placeholder="Masukan Alamat Email" name="email" id="email">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="input-group">
                                                <input  Required class="f-input-border me-1" type="password" placeholder="Masukan Password" name="pass1" id="pass1">
                                                <span class="input-group-text  " id="basic-addon1"><i class="far fa-eye" aria-hidden="true" id="eye" onclick="toggle()"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="input-group">
                                                <input  Required class="f-input-border me-1" type="password" placeholder="Masukan Ulang Password" name="pass2" id="pass2">
                                                <span class="input-group-text  " id="basic-addon1"><i class="far fa-eye" aria-hidden="true" id="eyes" onclick="toggle1()"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <input class="f-input" type="text" placeholder="Masukan Nomor Telepon" name="phone1" id="phone1" >
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-check mb-2" style="margin-left: 25px" >
                                                <input name="cek-setuju" type="checkbox" class="form-check-input" id="cek-setuju" value="Y">
                                                <label class="form-check-label"style="font-size:12px; color:#0077a2" for="cek-setuju"><b>Saya Menyetujui Syarat & Ketentuan yang Berlaku*</b></label>
                                            </div>
                                        </div>
                                    </div>
                                    <button onclick="daftar()" type="submit" class="btn btn-outline-secondary btn-login textLogin" style="width:23rem"> Buat Akun </button>
                                    <div class="row">
                                        <div class="col-12">
                                            <a href="../Login/" class="txt-daftar text-hoverlog">Sudah memiliki akun - <span style="color:#0077a2"><b> Log In </b></span></a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <%if e <> "" then  %> 
                            <div aria-label="Close" data-bs-dismiss="alert" class="alert text-center alert-warning alert-dismissible fade show" role="alert" style="position:absolute; background-color:#0077a2; border:none; color: white; margin-left:65px; bottom:24.5rem; border-radius:20px; width:26rem; font-size:12px; padding:4px 4px">
                                <strong>Maaf</strong> Email Atau Nomor Telepon Sudah Terdaftar,<br>
                                <span> Silahkan Masukan Data Baru ! </span>   
                            </div>
                            <% else %>
                            <% end if %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        var state= false;
        function toggle(){
            if(state){
                document.getElementById("pass1"). setAttribute("type","password"); state = false;
                document.getElementById("eye").style.color='#7a797e';
            }
            else{
                document.getElementById("pass1"). setAttribute("type","text"); state = true;
                document.getElementById("eye").style.color='#0dcaf0';
            }
        }
        function toggle1(){
            if(state){
                document.getElementById("pass2"). setAttribute("type","password"); state = false;
                document.getElementById("eyes").style.color='#7a797e';
            }
            else{
                document.getElementById("pass2"). setAttribute("type","text"); state = true;
                document.getElementById("eyes").style.color='#0dcaf0';
            }
        }
    </script>
</html>