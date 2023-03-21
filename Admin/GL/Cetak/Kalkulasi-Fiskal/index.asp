<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../../admin/")
    
    end if

    set KalkulasiFiskal_CMD = server.createObject("ADODB.COMMAND")
	KalkulasiFiskal_CMD.activeConnection = MM_PIGO_String
    KalkulasiFiskal_CMD.commandText = "SELECT * FROM GL_T_Fiskal_H  "
    set KalkulasiFiskal = KalkulasiFiskal_CMD.execute

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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"> </script>
    <script>
        function getListData(){
                $.ajax({
                    type: "get",
                    url: "load-list-jurnal.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value+"&JR_Type="+document.getElementById("typejr").value+"&JR_ID="+document.getElementById("jrid").value,
                    success: function (url) {
                        console.log(url);
                    $('.DataListJurnal').html(url);
                    }
                });
            }
        function newjurnal(){
            document.getElementById("add-jurnal").style.display = "block";
            document.getElementById("list-jurnal").style.display = "none";
            document.getElementById("btn-batal").style.display = "block";
            document.getElementById("btn-add").style.display = "none";
        }
        function canclejurnal(){
            document.getElementById("list-jurnal").style.display = "block";
            document.getElementById("add-jurnal").style.display = "none";
            document.getElementById("btn-batal").style.display = "none";
            document.getElementById("btn-add").style.display = "block";
        }
        function getAccountID(){
            document.getElementById("cont-account-id").style.display = "block"
        }
        function getAccountName(){
            $.ajax({
                type: "get",
                url: "get-ACName.asp?CA_Name="+document.getElementById("AccountID").value,
                success: function (url) {
                $('.cont-account-kas').html(url);
                }
            });
        }
        function getAccountKas(){
            $.ajax({
                type: "get",
                url: "get-ACID.asp?CA_ID="+document.getElementById("AccountID").value,
                success: function (url) {
                $('.cont-account-kas').html(url);
                }
            });
        }
    </script>
    <style>
        .cont-rincian-data-jurnal{
            background-color:white;
            height:13rem;
            overflow:scroll;
            overflow-x:hidden;
        }
        .cont-account-id{
            background-color:white;
            height:6rem;
            overflow:scroll;
            overflow-x:hidden;
        }
        .tb-account-id{
            border:1px solid black;
        }
    </style>
    </head>
    <!--#include file="../../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-10 col-md-10 col-sm-12">
                        <span class="cont-judul">  KALKULASI FISKAL  </span>
                    </div>
                </div>
            </div>
            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-2">
                        <span class="cont-text"> TAHUN </span> <br>
                        <input type="text" name="tahun" id="tahun" class="cont-form" value="" placeholder="Masukan Periode Tahun">
                    </div>
                    <div class="col-2">
                        <span class="cont-text"> BULAN </span> <br>
                        <input type="text" name="bulan" id="bulan" class="cont-form" value="" placeholder="Masukan Periode Bulan">
                    </div>
                    <div class="col-2">
                        <br>
                        <button class="cont-btn"> REFRESH </button>
                    </div>
                    <div class="col-2">
                        <br>
                        <button onclick="window.open('detail.asp','_Self')" class="cont-btn"> TAMBAH </button>
                    </div>
                </div>
            </div>

            <div class="Table-Kalkulasi-Fiskal">
                <div class="row mt-2 p-1">
                    <div class="col-12">
                        <div class="cont-tb" style="overflow:scroll; height:25rem;">
                        <table class=" align-items-center cont-tb table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px;">
                            <thead>
                                <tr class="text-center">
                                    <th> KODE </th>
                                    <th> TAHUN </th>
                                    <th> BULAN </th>
                                    <th> NILAI HU  </th>
                                    <th> PAJAK (%) </th>
                                    <th> PAJAK TERHUTANG </th>
                                    <th> KOMPENSASI LOSS </th>
                                </tr>
                            </thead>
                            <tbody class="DataListJurnal">
                                <% 
                                    no = 0 
                                    do while not KalkulasiFiskal.eof 
                                    no = no + 1
                                %>
                                <tr>
                                    <td class="text-center">
                                        <input type="hidden" name="FTID" id="FTID<%=KalkulasiFiskal("FT_ID")%>" Value="<%=KalkulasiFiskal("FT_ID")%>">
                                        <button class="cont-btn" onclick="window.open('print.asp?FTID='+document.getElementById('FTID<%=KalkulasiFiskal("FT_ID")%>').value,'_Self')" > <%=KalkulasiFiskal("FT_ID")%> </button>
                                    </td>
                                    <td class="text-center"> <%=KalkulasiFiskal("FT_Tahun")%> </td>
                                    <td class="text-center"> <%=KalkulasiFiskal("FT_Bulan")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(KalkulasiFiskal("FT_NilaiHasilUsaha")),"$","Rp. "),".00","")%> </td>
                                    <td class="text-center"> <%=KalkulasiFiskal("FT_TarifPajak")%> %</td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(KalkulasiFiskal("FT_PajakTerutang")),"$","Rp. "),".00","")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(KalkulasiFiskal("FT_Kompensasi")),"$","Rp. "),".00","")%> </td>
                                </tr>
                                <%
                                    KalkulasiFiskal.movenext
                                    loop
                                %>
                            </tbody>
                        </table>
                    </div>
                    </div>
                <div>
            <div>
        </div>
    </div>
    <!--#include file="../../../ModalHome.asp"-->
</body>
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
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>