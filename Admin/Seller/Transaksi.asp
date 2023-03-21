<!--#include file="../../Connections/pigoConn.asp" -->
<%
    set Transaksi_CMD = server.createObject("ADODB.COMMAND")
	Transaksi_CMD.activeConnection = MM_PIGO_String

        Transaksi_CMD.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_M_Seller.sl_custID,MKT_M_Seller.slName, SUM(MKT_T_Transaksi_D1A.tr_pdHarga*MKT_T_Transaksi_D1A.tr_pdQty) AS Amount, MKT_T_StatusTransaksi.strName FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A ON left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID  WHERE tr_strID = '03' GROUP BY MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_M_Seller.sl_custID, MKT_M_Seller.slName, MKT_T_StatusTransaksi.strName"
        'response.writeSeller_cmd.commandText

    set OrderSeller = Transaksi_CMD.execute

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
    <style>
        .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        padding-top: 100px; /* Location of the box */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        .modal-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        border: 1px solid #888;
        width: 40%;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animatetop;
        -webkit-animation-duration: 0.4s;
        animation-name: animatetop;
        animation-duration: 0.4s
        }

        @-webkit-keyframes animatetop {
        from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
        }

        @keyframes animatetop {
        from {top:-300px; opacity:0}
        to {top:0; opacity:1}
        }

        /* The Close Button */
        .close {
        color: white;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .close:hover,
        .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
        }

        .modal-body {
            padding: 15px;
            color: black;
            font-size: 12px;
            font-weight: 550;
        }
    </style>
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
                        <span class="cont-judul"> Transaksi Seller </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-2">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>
            <div class="cont-tr-seller" style="padding:0px 10px">
                <div class="row mt-3 ">
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <span class="cont-text"> Peride Transaksi </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <input type="date" name="" id="" value="" class="cont-form">
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <input type="date" name="" id="" value="" class="cont-form">
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <select class="cont-form" name="" id="">
                            <option selected>Pilih Seller</option>
                            <option value="1">One</option>
                            <option value="2">Two</option>
                            <option value="3">Three</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="row d-flex flex-row-reverse mt-3 ">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <table class="align-items-center cont-text table tb-transaksi table-bordered">
                        <thead>
                            <tr class="text-center">
                                <th>NO</th>
                                <th colspan="2">ORDER</th>
                                <th>SELLER</th>
                                <th>AMOUNT</th>
                                <th>STATUS</th>
                                <th>AKSI</th>
                            </tr>
                        </thead>
                        <tbody class="dataRekap">
                            <% 
                                no = 0 
                                do while not OrderSeller.eof 
                                no = no + 1
                            %>
                            <tr>
                                <td class="text-center"><%=no%></td>
                                <td class="text-center"><%=OrderSeller("trTglTransaksi")%></td>
                                <td class="text-center"><%=OrderSeller("trID")%></td>
                                <td class="text-center"><%=OrderSeller("slName")%></td>
                                <td class="text-end"><%=Replace(Replace(FormatCurrency(OrderSeller("Amount")),"$","Rp.  "),".00","")%></td>
                                <td class="text-center"><%=OrderSeller("strName")%></td>
                                <td class="text-center">
                                    <button class="cont-btn" id="myBtn<%=no%>"> Konfirmasi </button>
                                </td>
                            </tr>
                            <div id="myModal<%=no%>" class="modal">
                                <div class="modal-content">
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-11">
                                                <span> Konfirmasi Saldo Seller <%=OrderSeller("slName")%> </span>
                                            </div>
                                            <div class="col-1">
                                                <span> X </span>
                                            </div>
                                        </div>
                                        <hr>
                                        <%
                                            Transaksi_CMD.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_M_Seller.slName,MKT_M_Seller.sl_custID, MKT_T_Transaksi_D1.tr_rkNomorRK, MKT_T_Transaksi_D1.tr_BankID, GLB_M_Bank.BankName, SUM(MKT_T_Transaksi_D1A.tr_pdHarga*MKT_T_Transaksi_D1A.tr_pdQty) AS Amount FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN GLB_M_Bank ON MKT_T_Transaksi_D1.tr_BankID = GLB_M_Bank.BankID LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID WHERE (MKT_T_Transaksi_D1.tr_strID = '03') AND tr_slID = '"& OrderSeller("sl_custID") &"' AND MKT_T_Transaksi_H.trID = '"& OrderSeller("trID") &"'GROUP BY MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_M_Seller.sl_custID, MKT_M_Seller.slName, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.tr_rkNomorRK, MKT_T_Transaksi_D1.tr_BankID,  GLB_M_Bank.BankName"
                                            'response.writeSeller_cmd.commandText
                                            set Transaksi = Transaksi_CMD.execute
                                        %>
                                        <div class="row">
                                            <div class="col-6">
                                                <span> No Transaksi </span><br>
                                                <span> Jumlah Yang Harus Dikirim </span><br>
                                                <span> Bank </span><br>
                                                <span> No Rekening  </span><br>
                                            </div>
                                            <div class="col-6">
                                                <span>: <%=Transaksi("trID")%> </span><br>
                                                <span>: <%=Transaksi("Amount")%> </span><br>
                                                <span>: <%=Transaksi("BankName")%> </span><br>
                                                <span>: <%=Transaksi("tr_rkNomorRK")%> </span><br>
                                            </div>
                                        </div>
                                        <div class="row mt-3 ">
                                            <div class="col-12 text-center">
                                                <button class="cont-btn" onclick="konfirmasi('<%=Transaksi("trID")%>','<%=Transaksi("sl_custID")%>','<%=Transaksi("Amount")%>')" style="width:max-content"> Konfirmasi </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script>
                            var modal<%=no%> = document.getElementById("myModal<%=no%>");
                            var btn<%=no%> = document.getElementById("myBtn<%=no%>");
                            btn<%=no%>.onclick = function() {
                                modal<%=no%>.style.display = "block";
                            }
                            window.onclick = function(event) {
                                if (event.target == modal<%=no%>) {
                                    modal<%=no%>.style.display = "none";
                                }
                            }

                            </script>
                            <% 
                                OrderSeller.movenext
                                loop 
                            %>
                        </tbody>
                    </table>
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
        function konfirmasi(TrID, SlID, Amount){
            console.log(TrID);
            console.log(SlID);
            console.log(Amount);
        }
    </script>
</html>