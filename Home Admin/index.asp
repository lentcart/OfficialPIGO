<!--#include file="../Connections/pigoConn.asp" -->

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>PIGO</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../css/stylehome.css">
        <link rel="stylesheet" type="text/css" href="admin.css">
        <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
        <script src="js/jquery-3.6.0.min.js"></script>
        <style>

        .sidenav {
        height: 100%;
        width: 17rem;
        position: fixed;
        z-index: 1;
        top: 0;
        left: 0;
        background-color:#0dcaf0;
        overflow-x: auto;
        padding:10px 10px;
        }

        .sidenav a {
        padding: 6px 8px 6px 16px;
        text-decoration: none;
        font-size: 25px;
        color: #818181;
        display: block;
        }

        .sidenav a:hover {
        color: #f1f1f1;
        }

        .main {
        margin-left: 17rem; /* Same as the width of the sidenav */
        font-size: 28px; /* Increased text to enable scrolling */
        padding: 0px 10px;
        }

        @media screen and (max-height: 450px) {
        .sidenav {padding-top: 15px;}
        .sidenav a {font-size: 18px;}
        }
        </style>
    </head>
<body>
    <div class="sidenav">
        <h5>PIGO</h5>
        <div class="accordion accordion-flush" id="accordionFlushExample">
            <div class="accordion-item-admin">
                <h2 class="accordion" id="flush-heading1"><button class="accordion-button-admin collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse1" aria-expanded="false" aria-controls="flush-collapse1"> HOME</button></h2>
                <div id="flush-collapse1" class="accordion-collapse collapse" aria-labelledby="flush-heading1" data-bs-parent="#accordionFlushExample">
                    <div class="accordion-body">
                        HAI
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="main">
  <h5>DashBoard</h5>
</div>



</body>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../js/bootstrap.js"></script>
    <script src="../js/popper.min.js"></script>
</html>