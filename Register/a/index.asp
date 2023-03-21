<!--#include file="../../connections/pigoConn.asp"--> 
<% 
eror = request.queryString("e")
 %> 

<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register</title>

    </head>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/register.css">
    <script src="../../js/sw/sweetalert2.all.min.js"></script>
    

    
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
                text: 'Password Tidak Valid'
            });
            return false;
        }

        if (phone1.length >= 13 ){
            Swal.fire({
                icon: 'warning',
                title: 'Oops...',
                text: 'KEbanyakan'
            });
            
            return false;
        }

        if (!cek.checked){
            alert ("Harus Di Ceklis");
            return false;
        }

    
        // if (cek.checked){
        //     let ceklis =  document.getElementById("cek-setuju").value;
        //     console.log(ceklis);

        //     return false;

        // }else{
        //     console.log("N");
        //     return false;
        // }
         
    }
    </script>
    <body>

    <div class="container">
    <% if eror <> "" then  %> 
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <strong>Maaf</strong> Email sudah terdaftar, coba lagi !    
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% else  %> 
        <form class="form-container" method="post" action="" onsubmit="return regis()">
        <a href="index.asp"><button type="button" class="btn-close" ></button></a>
        <h3 class="judul-regis">DAFTAR</h3>
        <div class="row">
            <div class=" col" style="width:500px">
                <div class="mb-4">
                    <label for="exampleInputEmail1" class="form-label">Email</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-envelope"></i></span>
                        <input name="email" type="email" class=" box-regis" id="email" aria-describedby="emailHelp" placeholder="Email" autocomplete="off">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class=" col" style="width:500px">
                <div class="">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <div class="input-group">
                    <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-key"></i></span>
                    <span class="eye-regis" ><i class="far fa-eye" aria-hidden="true" id="eye" onclick="icon()"></i></span>
                    <input name="pass1"type="password" class=" box-regis" id="pass1" placeholder="Password">
                </div>
            </div>
        <div class="row">
            <div class="col" style="width:510px">
                <div class="">
                <label for="exampleInputPassword2" class="form-label">Ulangi Password</label>
                <div class="input-group">
                    <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-lock"></i></span>
                    <span class="eye-regis" ><i class="far fa-eye" aria-hidden="true" id="eyes" onclick="toggle()"></i></span>
                    <input name="pass2"type="password" class=" box-regis" id="pass2" placeholder="Ulangi password">
                </div>
            </div>
        <div class="row">
            <div class=" col" style="width:500px" >
                <div class="mb-4">
                    <label for="exampleInput" class="form-label">No Handphone 1</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-mobile-alt"></i></span>
                        <input name="phone1" type="number" class=" box-regis" id="phone1" aria-describedby="" placeholder="No Handphone">
                    </div>
                </div>
            </div>
        </div>
            <div class="form-check" style="font-size:10px">
                <input name="cek-setuju" type="checkbox" class="form-check-input" id="cek-setuju" value="Y">
                <label class="form-check-label" for="cek-setuju" style="font-size:10px">Saya Menyetujui Syarat & Ketentuan yang Berlaku*</label>
            </div>

            <div class=" row justify-content-center">
            <button type="submit" class="btn btn-outline-secondary btn-regis " >Daftar</button>
            </div>

            <div class="mt-3">
            <label>Sudah Punya Akun Pigo?<a href="login.asp" class="link-login"> Login</a></label>
            </div>
        </form>

    <% end if %> 
    </div>







    <!-- Hide Pass -->
    <script>
        var state= false;
        function icon(){
            if(state){
                document.getElementById("password"). setAttribute("type","password"); state = false;
                document.getElementById("eye").style.color='#7a797e';
            }
            else{
                document.getElementById("password"). setAttribute("type","text"); state = true;
                document.getElementById("eye").style.color='#0dcaf0';
            }
        }
    </script>
    <script>
        var state= false;
        function toggle(){
            if(state){
                document.getElementById("password2"). setAttribute("type","password"); state = false;
                document.getElementById("eyes").style.color='#7a797e';
            }
            else{
                document.getElementById("password2"). setAttribute("type","text"); state = true;
                document.getElementById("eyes").style.color='#0dcaf0';
            }
        }
    </script>
    


    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../../js/bootstrap.js"></script>
    <script src="../../js/popper.min.js"></script>

    
    

    </body>
</html>