<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
        response.redirect("../../admin/")
    end if
    if session("H3C") = false then 
        Response.redirect "../../Admin/home.asp"
    end if
    
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_Produk WHERE pd_custID = '"& request.Cookies("custID") &"' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set kategori_cmd = server.createObject("ADODB.COMMAND")
    kategori_cmd.activeConnection = MM_PIGO_String

        kategori_cmd.commandText = "SELECT * FROM MKT_M_Kategori WHERE catAktifYN = 'Y' "
    
    set kategori = kategori_cmd.execute

    set Merk_cmd = server.createObject("ADODB.COMMAND")
    Merk_cmd.activeConnection = MM_PIGO_String

        Merk_cmd.commandText = "SELECT * FROM MKT_M_Merk WHERE mrAktifYN = 'Y' "
    
    set Merk = Merk_cmd.execute

    set Tax_CMD = server.createObject("ADODB.COMMAND")
	Tax_CMD.activeConnection = MM_PIGO_String

    Tax_CMD.commandText = "SELECT * FROM MKT_M_Tax Where TaxAktifYN = 'Y' "
    'Response.Write Tax_CMD.commandText & "<br>"

    set Tax = Tax_CMD.execute


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
    <link rel="stylesheet" type="text/css" href="../../dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
        const loadFile2 = function(event) {
            const output2 = document.getElementById('output2');
                output2.src = URL.createObjectURL(event.target.files[0]);
                output2.onload = function() {
                URL.revokeObjectURL(output2.src)
            }
        };
        function nilaivolume(){
            var panjang = parseInt(document.getElementById("panjangproduk").value);
            var lebar = parseInt(document.getElementById("lebarproduk").value);
            var tinggi = parseInt(document.getElementById("tinggiproduk").value);
            var nilaivolume = Number(panjang*lebar*tinggi);
            var volume = nilaivolume;
            document.getElementById("volumeproduk").value = volume;
            
        };
        document.addEventListener("DOMContentLoaded", function(event) {
            nilaivolume();
        });
    </script>
    <style>
        #clear{
            width: 14.3rem;
            color:black;
            font-weight:bold;
            border: 1px solid #d4d4d4;
            border-radius: 3px;
            padding: 2px;
            box-shadow: 0 2px 3px 0 rgba(10, 10, 10, 0.2),0 6px 20px 0 rgba(175, 175, 175, 0.19);
            background-color: #eee;
        }

        .formstyle{
            width:15rem;
            height:15rem;
            margin: auto;
            border-radius: 10px;
            padding: 5px;
        }

        .inp-cal{
            width: 44px;
            background-color: green;
            color: black;
            font-weight:bold;
            border: 1px solid #d4d4d4;
            border-radius: 0px;
            padding: 5px 5px;
            margin: 5px;
            box-shadow: 0 2px 3px 0 rgba(10, 10, 10, 0.2),0 6px 20px 0 rgba(175, 175, 175, 0.19);
            font-size: 12px;
        }
        #kalkulator{
            display:none;
            margin-left:-20px;
        }

        #calc{
            width: 14.4rem;
            font-size:12px;
            color: blue;
            font-weight:bold;
            padding: 6px 10px;
            background:#aaa;
            border: 1px solid #d4d4d4;
            border-radius: 5px;
            margin: auto;
        }
    </style>
    </head>
<body>
<!--#include file="../../loaderpage.asp"-->
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-10 col-md-4 col-sm-10">
                        <span class="cont-judul"> NILAI KEUNTUNGAN PENJUALAN PRODUK </span>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-2">
                        <button onclick="window.open('../ProdukInfo/index.asp','_Self')" class="cont-btn"> Batal </button>
                    </div>
                </div>
            </div>
            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-4">
                        <span class="cont-text"> Nilai Presentase Keuntungan (%) </span>
                    </div>
                    <div class="col-2">
                        <input class="cont-form" type="number" name="" id="" value="">  
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-4">
                        <span class="cont-text"> PPN Masukan </span>
                    </div>
                    <div class="col-2">
                        <select onchange="tax()" class=" cont-form" name="ppn" id="ppn" aria-label="Default select example" required>
                <option value="">Tax (PPN)</option>
                <% do while not Tax.eof %>
                <option value="<%=Tax("TaxRate")%>"><%=Tax("TaxNama")%></option>
                <% Tax.movenext
                loop %>
            </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
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