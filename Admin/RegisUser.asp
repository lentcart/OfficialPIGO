<!--#include file="../Connections/pigoConn.asp" -->
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
    <link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" type="text/css" href="../css/stylehome.css">
    <script src="../js/sw/sweetalert2.all.min.js"></script>
    

    </head>
    <body>

    <div class="container" style="margin-top:5rem">
        <div class="row">
            <div class="col-lg-3">
            </div>
            <div class="col-6">
                <form class="form-login" method="post" action="P-User.asp">
                <div class="row">
                    <div class="col-3 ms-4 P0">
                        <img src="../assets/logo/maskot.png" class="figure-img img-fluid " width="90" height="90" alt="">

                    </div>
                    <div class="col-8">
                            <p class="mt-2 text "><b> DAFTAR USER</b></p>
                    </div>
                </div>
                        <div class="f-login mt-4">
                            <input class="f-input mt-4" type="text" placeholder="Username" name="UserName" id="UserName">
                                <div class="input-group">
                                    <input class="f-inputtt me-1" type="password" placeholder="Password" name="password" id="password">
                                    <span class="input-group-text  " id="basic-addon1"><i class="far fa-eye" aria-hidden="true" id="eye" onclick="toggle()"></i></span>
                                </div>
                                <select class="form-select f-input" name="userBagian" id="userBagian">
                                    <option selected>Pilih Bagian</option>
                                    <option  value="ADM">Admin</option>
                                    <option class="f-input" value="IT">IT</option>
                                    <option class="f-input" value="KEU">Keuangan</option>
                                    <option class="f-input" value="KEP">Kepala</option>
                                </select>
                                    <button type="submit" id="akunuser" class="btn btn-outline-secondary btn-login textLogin"><b>Buat Akun</b></button>
                                </div>
                        </form>
                    </div>
                    <div class="col-lg-3">
                        </div>
                    </div>
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
    </script>


    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    

    
    

    </body>
</html>