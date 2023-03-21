<!--#include file="../../connections/pigoConn.asp"--> 

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="pesanan.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>

        <title>PIGO</title>
        <style>
.progressbar-wrapper {
      background: #fff;
      width: 100%;
      padding-top: 10px;
      padding-bottom: 5px;
}

.progressbar li {
      list-style-type: none;
      width: 20%;
      float: left;
      font-size: 20px;
      position: relative;
      text-align: center;
      text-transform: uppercase;
      color: #0077a2;
}
.progressbar li:before {
    width: 60px;
    height: 60px;
    content: "";
    line-height: 60px;
    border: 2px solid #0077a2;
    display: block;
    text-align: center;
    margin: 0 auto 3px auto;
    border-radius: 50%;
    position: relative;
    z-index: 2;
    background-color: #fff;
}
.progressbar li:after {
     width: 100%;
     height: 2px;
     content: '';
     position: absolute;
     background-color: #0077a2;
     top: 30px;
     left: -50%;
     z-index: 0;
}
.progressbar li:first-child:after {
     content: none;
}.progressbar li:before {
    width: 60px;
    height: 60px;
    content: "";
    line-height: 60px;
    border: 2px solid #0077a2;
    display: block;
    text-align: center;
    margin: 0 auto 3px auto;
    border-radius: 50%;
    position: relative;
    z-index: 2;
    background-color: #fff;
}
.progressbar li:after {
     width: 100%;
     height: 2px;
     content: '';
     position: absolute;
     background-color: #0077a2;
     top: 30px;
     left: -50%;
     z-index: 0;
}
.progressbar li:first-child:after {
     content: none;
}
.progressbar li:before {
    width: 60px;
    height: 60px;
    content: "";
    line-height: 60px;
    border: 2px solid #0077a2;
    display: block;
    text-align: center;
    margin: 0 auto 3px auto;
    border-radius: 50%;
    position: relative;
    z-index: 2;
    background-color: #fff;
}
.progressbar li:after {
     width: 100%;
     height: 2px;
     content: '';
     position: absolute;
     background-color: #0077a2;
     top: 30px;
     left: -50%;
     z-index: 0;
}
.progressbar li:first-child:after {
     content: none;
}
.progressbar li.active:before {
    background: #0077a2 ;
    content: '\2713';
    color:white;
    font-size:content 20px; 
  font: var(--fa-font-regular);
    background-size: 60%;
}
.progressbar li::before {
    background: #fff;
    background-size: 60%;
    content: '\f057';
    color:#0077a2;
    padding: 15px;
    font-size:content 20px; 
  font: var(--fa-font-brands);
}
.icon{
    font-size:12px
}
        </style>
    </head>
<body>
    <div class="progressbar-wrapper">
      <ul class="progressbar">
          <li class="active"> <span class="icon">Pesanan Dibuat</span></li>
          <li class="p02"> <span class="icon">Pesanan Dibayarkan</span> </li>
          <li class="p03"> <span class="icon">Sedang Dikemas</span> </li>
          <li class="p04"> <span class="icon">Dikirim</span></li>
          <li class="p05"> <span class="icon">Dinilai</span></li>
      </ul>
</div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script> 
</html>