<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
     
    payID   = request.queryString("payID")

    set Pembayaran_CMD = server.createObject("ADODB.COMMAND")
	Pembayaran_CMD.activeConnection = MM_PIGO_String

    Pembayaran_CMD.commandText = "SELECT payBukti FROM MKT_T_Payment_H Where payID = '"& payID &"'"
    'response.write Pembayaran_CMD.commandText

    set paybukti = Pembayaran_CMD.execute

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <style>
        #imageid{
            margin-top:5rem;
            width:5rem;
            height:5rem;
        }
        .container{
            position:center
        }
    </style>
<body>
    <div class="container">
        <div class="cont-image">
            <div class="row text-center">
                <div class="col-12">
                    <img id="imageid" src="data:image/png;base64,<%=paybukti("payBukti")%>" class="card-img-top rounded" alt="...">
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>  
    <script>
        function getBase64Image(img) {
        var canvas = document.createElement("canvas");
        canvas.width = img.width;
        canvas.height = img.height;
        var ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0);
        var dataURL = canvas.toDataURL("image/png");
        return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
        }

        var base64 = getBase64Image(document.getElementById("imageid"));
    </script>
</html>