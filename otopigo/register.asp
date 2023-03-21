<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/register.css">
    

    </head>
    <body>

    <div class="container">
        <form class="form-container">
        <h3 class="judul-regis">REGISTER</h3>
        <div class="row">
            <div class=" col-md-6 col-sm-6">
                <div class="mb-4">
                    <label for="exampleInput" class="form-label">Fullname</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-user"></i></span>
                        <input type="text" class=" box-regis" id="exampleInput" aria-describedby="" placeholder="Fullname">
                    </div>
                </div>
            </div>
            <div class=" col-md-6 col-sm-6">
                <div class="mb-4">
                    <label for="exampleInputEmail1" class="form-label">Email</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-envelope"></i></span>
                        <input type="email" class=" box-regis" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Email">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class=" col-md-6 col-sm-6">
                <div class="mb-4">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <div class="input-group mb-3">
                    <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-key"></i></span>
                    <span class="eye-regis" ><i class="far fa-eye" aria-hidden="true" id="eye" onclick="icon()"></i></span>
                    <input type="password" class=" box-regis" id="password" placeholder="Password">
                </div>
            </div>
            </div>
            <div class=" col-md-6 col-sm-6">
                <div class="mb-4">
                <label for="exampleInputPassword2" class="form-label">Re-Password</label>
                <div class="input-group mb-3">
                    <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-lock"></i></span>
                    <span class="eye-regis" ><i class="far fa-eye" aria-hidden="true" id="eyes" onclick="toggle()"></i></span>
                    <input type="password" class=" box-regis" id="password2" placeholder="Re-password">
                </div>
            </div>
            </div>
        </div>
        <div class="row">
            <div class=" col-md-6 col-sm-6">
                <div class="mb-4">
                    <label for="exampleInput" class="form-label">Phone</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-mobile-alt"></i></span>
                        <input type="number" class=" box-regis" id="exampleInput" aria-describedby="" placeholder="Phone">
                    </div>
                </div>
            </div>
            <div class=" col-md-6 col-sm-6">
                <div class="mb-4">
                    <label for="exampleInput" class="form-label">Address</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text addon-regis" id="basic-addon1"><i class="fas fa-address-book"></i></span>
                        <input type="text" class=" box-regis" id="exampleInput" aria-describedby="" placeholder="Address">
                    </div>
                </div>
            </div>
        </div>
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                <label class="form-check-label" for="exampleCheck1">I Agree to the Terms & Conditions Applicable*</label>
            </div>

            <div class="">
            <button type="submit" class="btn btn-outline-secondary btn-regis" >Register</button>
            </div>

            <div class="mt-3">
            <label>Already have an account?<a href="login.asp" class="link-login"> Login here</a></label>
            </div>
        </form>
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
    <script src="js/bootstrap.js"></script>
    <script src="js/popper.min.js"></script>

    
    

    </body>
</html>