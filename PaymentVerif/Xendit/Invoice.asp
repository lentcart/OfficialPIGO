<!--#include file="../../connections/pigoConn.asp"--> 
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>

        <title> OFFICIAL PIGO </title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

        <script>
            function getInvoice(){
                var external_id = "ORDERID-00098900";
                var amount      = 9000;
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: 'P-Invoice.asp',
                        data:{
                                external_id:external_id,
                                amount: amount,
                            },
                        traditional: true,
                        success: function (data) {
                            const obj = JSON.parse(data);
                            var c
                            c =
                            obj.invoice_url
                            window.location.href = c
                        }
                    });
            }
        </script>
    </head>
    <body onload="getInvoice()">
    <p id="demo"></p>
    </body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>  
</html>