<!--#include file="../connections/pigoConn.asp"--> 
<% 

    set Customer_cmd = server.createObject("ADODB.COMMAND")
	Customer_cmd.activeConnection = MM_PIGO_String
			
	Customer_cmd.commandText = " SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone2, MKT_M_Customer.custPhone3, MKT_M_Customer.custJk, MKT_M_Customer.custTglLahir,  MKT_M_Customer.custRekening, MKT_M_Customer.custStatus, MKT_M_Customer.custRating, MKT_M_Customer.custPoinReward, MKT_M_Customer.custLastLogin, MKT_M_Customer.custVerified,   MKT_M_Customer.custPhoto, MKT_M_Customer.custDakotaGYN, MKT_M_Customer.custAktifYN, MKT_M_Customer.custPhone1, MKT_M_Customer.custPassword, GLB_T_Verifikasi.verifCode FROM MKT_M_Customer LEFT OUTER JOIN GLB_T_Verifikasi ON MKT_M_Customer.custID = GLB_T_Verifikasi.custID_H where MKT_M_Customer.custEmail = '"& request.cookies("custEmail") &"' " 
    'response.write Customer_cmd.commandText
	set Customer = Customer_cmd.execute
%> 

<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Verifikasi</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" type="text/css" href="../css/stylehome.css">
    
    </head>
    <body>
    <!--Header-->
        <!--#include file="../header.asp"-->
    <!--Header-->
    <div class="container"  style="margin-top:0px;padding:0px 200px">
        <form action="P-Verifikasi.asp" method="post">
        <%do while not Customer.eof%>
            <div class="row verifcust align-items-center text-center">
                <div class="col-12">
                <img src="../assets/logo/maskotnew.png" class="figure-img img-fluid " width="200" height="200" alt=""><br>
                    <span class="text-center" style="font-size:25px; color:#0dcaf0"><b> VERIFIKASI </b></span><br>
                    <span class="text-center" style="font-size:15px; color:#8a8a8a"><b style="font-size:15px; color:#0dcaf0"><%=customer("custEmail")%></b> <b> Belum Melakukan Verifikasi</b></span><br>
                    <input type="hidden" name="email" id="email" value="<%=customer("custEmail")%>">
                    <input type="hidden" name="custID" id="custID" value="<%=customer("custID")%>">
                    <input type="hidden" name="phone1" id="phone1" value="<%=customer("custPhone1")%>">
                    <input type="hidden" name="password" id="password" value="<%=customer("custPassword")%>">
                    <input type="hidden" name="VerifCode" id="VerifCode" value="<%=customer("verifCode")%>">
                    <span class="text-center" style="font-size:15px; color:#8a8a8a"><b> Silhakan Klik Link Dibawah Untuk Melakukan Verifikasi Email </b></span><br>
                    <div class="row  mb-3">
                        <div class="col-12">
                        <input class="weight" type="submit" name ="formregis" id="formregis" value="Verifikasi Email" style="border:none; font-size:15px; border-radius:10px;color:#0dcaf0; background-color:#eee; padding:5px 20px; margin-top:20px">
                        </div>
                    </div>
                </div>
            </div>
        <%customer.movenext
        loop%>
        </form>
    </div>



    
    

    </body>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>     
</html>