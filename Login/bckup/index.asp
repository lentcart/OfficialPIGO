<!--#include file="../connections/pigoConn.asp"--> 
<% 

e= Request.queryString("e")

%> 
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="login.css">
    

    </head>
    <body>

    <div class="container">
    
        <form class="form-container"  method="post" action="P-Login.asp" >
        <a href="index.asp"><button type="button" class="btn-close" ></button></a>
            <h3 class="judul-login">LOGIN</h3>
            <% if e <> "" then  %> 
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            LOGIN GAGAL    
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% end if  %> 
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label textLogin">Email</label>
                <div class="input-group mb-3">
                    <span class="input-group-text addon-login" id="basic-addon1"><i class="fas fa-envelope"></i></span>
                    <input name="email" type="email" class="btn-login" id="email" aria-describedby="emailHelp" placeholder="Email">
                </div>
            </div>
            <div class="mb-3">
                
                <label for="password" class="form-label textLogin">Password</label>
                <div class="input-group mb-3">
                    <span class="input-group-text addon-login" id="basic-addon1"><i class="fas fa-lock"></i></span>
                    <span class="eye-login" ><i class="far fa-eye" aria-hidden="true" id="eye" onclick="toggle()"></i></span>
                    <input name="pass1" type="password" class="btn-login" id="pass1" placeholder="Password">
                    
                </div>
                
            </div>
            <div class="pass">
                <a href="" class="textLogin text-hoverlog">Forgot Password?</a>
            </div>
            <div class="boxLogin d-grid">
                <button type="submit" class="btn btn-outline-secondary btn-lgn textLogin">Login</button>
            </div>

            <div class="regis">
                <span class="textLogin">Dont have an account?
                <a href="register.asp" class="textLogin text-hoverlog" >Register</a></span>
            </div>
        </form>


    </div>



    <!-- Hide Pass -->
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
    </script>


    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../js/bootstrap.js"></script>
    <script src="../js/popper.min.js"></script>

    
    

    </body>
</html>