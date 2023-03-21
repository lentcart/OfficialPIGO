<!--#include file="../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
        response.redirect("../../admin/")
    end if
    if session("H2A") = false then 
        Response.redirect "../../Admin/home.asp"
    end if

    set Customer_cmd = server.createObject("ADODB.COMMAND")
	Customer_cmd.activeConnection = MM_PIGO_String

        Customer_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custPhone3, MKT_M_Customer.custJk,  MKT_M_Customer.custTglLahir, MKT_M_Customer.custRekening, MKT_M_Customer.custPhoto, MKT_M_Seller.slName, MKT_M_Customer.custDakotaGYN, MKT_M_Customer.custLastLogin FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custPhone3, MKT_M_Customer.custJk,  MKT_M_Customer.custTglLahir, MKT_M_Customer.custRekening, MKT_M_Customer.custPhoto, MKT_M_Seller.slName, MKT_M_Customer.custDakotaGYN, MKT_M_Customer.custLastLogin "
        'response.write Customer_cmd.commandText

    set Customer = Customer_cmd.execute

    set sp_cmd = server.createObject("ADODB.COMMAND")
	sp_cmd.activeConnection = MM_PIGO_String

        sp_cmd.commandText = "SELECT COUNT(custID) AS total FROM MKT_M_Customer  "
        'response.write sp_cmd.commandText

    set sp = sp_cmd.execute

    set Member_cmd = server.createObject("ADODB.COMMAND")
	Member_cmd.activeConnection = MM_PIGO_String

        Member_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custDakotaGYN, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPassword, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custPhone3, MKT_M_Customer.custJk, MKT_M_Customer.custTglLahir, MKT_M_Customer.custRekening, MKT_M_Customer.custStatus, MKT_M_Customer.custRating, MKT_M_Customer.custPoinReward, MKT_M_Customer.custLastLogin, MKT_M_Customer.custVerified, MKT_M_Customer.custPhoto, MKT_M_Customer.custAktifYN, MKT_M_Seller.sl_custID, MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_T_Member.mb_custID, MKT_T_Member.mbDiskon, MKT_T_Member.mb_DakotaGYN FROM MKT_T_Member RIGHT OUTER JOIN MKT_M_Seller ON MKT_T_Member.mb_slID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID where mb_DakotaGYN = 'Y' "
        'response.write Member_cmd.commandText

    set Member = Member_cmd.execute

%>
<!doctype html>
<html lang="en"><!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
        function tambah(){
            let pem= document.getElementsByClassName("tmb");

            document.getElementById("formsupplier").style.display = "block";
            document.getElementById("tsupplier").style.display = "none";
            }
        var array = [];

        function cust(){
            let pem= document.getElementsByClassName("custID");

            document.getElementById("cust").style.display = "block";
        }

        var id = [];
        // console.log(id);
    
        function loaddata(){
            var no = document.getElementById('no').value;
            var custID = id;
            var pdidall = "";
            for ( i=1; i<=no; i++){
                id.push($(`#custID${i}`).val());
            }
            if ( pdidall.length<1 ){
                pdidall = pdidall+id;
            }else{
                    pdidall  = pdidall+","+id; 
                }
            document.getElementById("custall").value = pdidall;
            return id;

            
        }
        $('#periode').on("change",function(){
            let pr = $('#periode').val();
            console.log(pr);
            if (ongkir == "tahun" ){
                $("#cont-tahun").show();
            
            }else{
                $("#cont-tanggal").show();

            }
        });
        
        function tgla(){
            $.ajax({
                type: "get",
                url: "get-data.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                   $('.datatr').html(url);
                    
                }
            });
        }
        function tgle(){
            $.ajax({
                type: "get",
                url: "get-data.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                    
                    
                   $('.datatr').html(url);
                    
                }
            });
        }
    </script>
    </head>
<body>
<!--#include file="../loaderpage.asp"-->
    <div class="wrapper">
        <!--#include file="../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-11 col-md-11 col-sm-8">
                        <span class="cont-judul"> COSTUMER OFFICIAL PIGO </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-2">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="row d-flex flex-row-reverse">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <table class="align-items-center cont-text table tb-transaksi table-bordered">
                                    <thead>
                                        <tr class="text-center">
                                            <th>NO</th>
                                            <th>ID CUSTOMER</th>
                                            <th>NAME CUSTOMER</th>
                                            <th>EMAIL</th>
                                            <th>PHONE</th>
                                            <th>LAST LOGIN </th>
                                        </tr>
                                    </thead>
                                    <tbody class="dataRekap">
                                        <% 
                                            no = 0 
                                            do while not Customer.eof 
                                            no = no + 1
                                        %>
                                            <tr>
                                                <td class="text-center"><%=no%></td>
                                                <td class="text-center"><%=Customer("custID")%></td>
                                                <td ><%=Customer("CustNama")%></td>
                                                <td><%=Customer("CustEmail")%></td>
                                                <td><%=Customer("CustPhone1")%></td>
                                                <td class="text-center"><%=Customer("custLastLogin")%></td>
                                            </tr>
                                        <% 
                                            Customer.movenext
                                            loop 
                                        %>
                                    </tbody>
                                </table>
                            </div>
                    </div>
                </div>
            </div>
            <div class="row mt-3 mb-3">
            <div class="col-12 text-end">
                <button class="cont-btn" style="width:15rem"> List Produk Yang Di Non Aktifkan </button>
            </div>
        </div>
        </div>
    </div>
    <!--#include file="../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
    <script>
        var dropdown = document.getElementsByClassName("dropdown-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
        } else {
        dropdownContent.style.display = "block";
        }
        });
        }
        var dropdown = document.getElementsByClassName("cont-dp-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
        } else {
        dropdownContent.style.display = "block";
        }
        });
        }
        var modal = document.getElementById("myModal");
        var btn = document.getElementById("myBtn");
        var span = document.getElementsByClassName("closee")[0];
        btn.onclick = function() {
        modal.style.display = "block";
        }
        span.onclick = function() {
        modal.style.display = "none";
        }
        window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        }
        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })
    </script>
</html>