<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../../admin/")
    
    end if

    set RUP_CMD = server.createObject("ADODB.COMMAND")
	RUP_CMD.activeConnection = MM_PIGO_String

        RUP_CMD.commandText = "SELECT GL_T_RekapUmurPiutang.RUP_Tahun, GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_custID, MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_UpdateTime FROM GL_T_RekapUmurPiutang LEFT OUTER JOIN MKT_M_Customer ON GL_T_RekapUmurPiutang.RUP_custID = MKT_M_Customer.custID GROUP BY GL_T_RekapUmurPiutang.RUP_Tahun, GL_T_RekapUmurPiutang.RUP_Jenis, GL_T_RekapUmurPiutang.RUP_custID, MKT_M_Customer.custNama, GL_T_RekapUmurPiutang.RUP_UpdateTime"
        'response.write RUP_CMD.commandText 

    set RUP = RUP_CMD.execute

    set Penjualan_CMD = server.createObject("ADODB.COMMAND")
	Penjualan_CMD.activeConnection = MM_PIGO_String

    Penjualan_CMD.commandText = "SELECT MKT_M_Customer.custNama, MKT_M_Customer.custID FROM GL_T_RekapUmurPiutang LEFT OUTER JOIN MKT_M_Customer ON GL_T_RekapUmurPiutang.RUP_custID = MKT_M_Customer.custID GROUP BY MKT_M_Customer.custNama, MKT_M_Customer.custID ORDER BY custNama ASC"
    'response.write Penjualan_CMD.commandText

    set bussinespartner = Penjualan_CMD.execute

    Penjualan_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.Perm_custID,MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_spID, MKT_T_Permintaan_Barang_H.Perm_stID, MKT_T_StatusTransaksi.strName, MKT_T_StatusPembayaran.spName,  MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almProvinsi, MKT_T_Permintaan_Barang_H.Perm_trYN FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Permintaan_Barang_H.Perm_stID = MKT_T_StatusTransaksi.strID LEFT OUTER JOIN MKT_T_StatusPembayaran ON MKT_T_Permintaan_Barang_H.Perm_spID = MKT_T_StatusPembayaran.spID ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko')"
    'response.write Penjualan_CMD.commandText

    set Penjualan = Penjualan_CMD.execute
%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>OFFICIAL PIGO</title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        <script>
    
        function getlist(){
            let cek = document.getElementById("flexCheckDefault");
            
            if (!cek.checked){
                document.getElementById("cont-list-bussinespartner").style.display = "none";
                Refresh();
                document.getElementById("custNama").value=""
            }else{
                document.getElementById("cont-list-bussinespartner").style.display = "block";
                document.getElementById("custNama").value=""
            }
        }
        function gettanggal(){
            var custID = document.getElementById("custID").value;
            var tgla   = document.getElementById("tgla").value;
            var tgle   = document.getElementById("tgle").value;
            $.ajax({
                type: "get",
                url: "load-penjualan.asp",
                data : {
                    custID,
                    tgla,
                    tgle
                },
                success: function (data) {
                    $('.datapenjualan').html(data);
                }
            });
        }
        function prosesRUP(){
            let PRUP = document.getElementById("BtnProsesRekap");
            
            if (!PRUP.checked){
                document.getElementById("Cont-Proses-Rekap").style.display = "none";
            }else{
                document.getElementById("Cont-Proses-Rekap").style.display = "block";
            }
        }
    </script>
    <style>
    #BtnCetakHeader{
        display:none;
    }
    #BtnCetakDetail{
        display:none;
    }
        .cont-list-bussinespartner{
            background:white;
            height:8rem;
            overflow:scroll;
        }
        .cont-form{
            width:8rem;
        }
        .cont-tb-penjualan{
            overflow-x:scroll;
            overflow-y:scroll;
            height:20rem;
            width:100%
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
                    <div class="col-lg-11 col-md-11 col-sm-12">
                        <span class="cont-text" style="font-size:15px"> REKAP UMUR PIUTANG </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2 p-3" id="Cont-Proses-Rekap" style="display:none">
                <form action="proses.asp" method="POST">
                    <div class="row align-items-center">
                        <div class="col-lg-2 col-md-2 col-sm-12">
                            <span for="flexCheckDefault" class="breadcrumb-item cont-text" style="padding:4px 25px; border-radius:5px"> Periode Proses </span> 
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12">
                            <input class="cont-form" type="date" name="RUP_Tanggala" id="RUP_Tanggala" value="">&nbsp; 
                            <span for="flexCheckDefault" class="breadcrumb-item cont-text" style="padding:4px 6px 5px 10px; border-radius:5px"> s.d </span>&nbsp; 
                            <input class="cont-form" type="date" name="RUP_Tanggale" id="RUP_Tanggale" value="">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-12">
                            <span for="flexCheckDefault" class="breadcrumb-item cont-text" style="padding:4px 25px; border-radius:5px"> Jenis </span> 
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12">
                            <select  class="cont-form" name="RUP_Jenis" id="RUP_Jenis" aria-label="Default select example" required style="width:100%">
                                <option value="">Pilih Jenis Rekap Piutang</option>
                                <option value="AR">Invoice AR</option>
                                <option value="AP">Invoice AP</option>
                            </select>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-12">
                            <input class="cont-btn" type="submit" value="Proses Rekap">
                        </div>
                    </div>
                </form>
            </div>
            <div class="cont-background mt-2" id="Cont-Print-Rekap">
                <div class="row align-items-center">
                    <div class="col-lg-4 col-md-4 col-sm-12">
                        <span class="cont-text"> Cetak Rekap Umur Piutang Berdasarkan : </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="TypeRUP" id="TypeRUP" value="H">
                            <label class="cont-text " for="TypeRUP">Header</label>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="TypeRUP" id="TypeRUP" value="D">
                            <label class="cont-text " for="TypeRUP">Detail</label>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-12">
                        
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <div class="form-check">
                            <input onchange="prosesRUP()" class="form-check-input" type="checkbox" value="" id="BtnProsesRekap">
                            <span for="BtnProsesRekap" class="breadcrumb-item cont-text" style="padding:1px 25px; border-radius:5px"> Proses Rekap </span><br>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-4">
                        <div class="form-check">
                            <input  onchange="getlist()" class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                            <span for="flexCheckDefault" class="breadcrumb-item cont-text" style="padding:1px 15px; border-radius:5px"> Bussines Partner </span><br>
                        </div>
                    </div>
                    <div class="col-4">
                        <span for="flexCheckDefault" class="breadcrumb-item text-start cont-text" style="padding:1px 15px; border-radius:5px"> Periode Tanggal </span><br>
                    </div>
                    <div class="col-4">
                        <span for="flexCheckDefault" class="breadcrumb-item cont-text" style="padding:1px 42px; border-radius:5px"> Jenis Rekap </span><br>
                    </div>
                </div>
                <div class="row align-items-center mt-2">
                    <div class=" lisnama col-4">
                        <style>
                            .form-check-label{
                                background:White;
                                padding:5px 10px;
                                border:1px solid black;
                                height:2.3rem;
                            }
                        </style>
                        <div class="form-check-label" for="flexCheckDefault">
                        </div>
                    </div>
                    <div class="col-4">
                        <input onchange="gettanggal()" class="tgla text-center  cont-form" type="date" name="tgla" id="tgla" value="" >&nbsp; 
                        <span for="flexCheckDefault" class="breadcrumb-item cont-text" style="padding:1px 5px; border-radius:5px"> s.d </span> &nbsp; 
                        <input onchange="gettanggal()" class=" text-center  cont-form" type="date" name="tgle" id="tgle" value="" >
                    </div>
                    <div class="col-2">
                        <select  class="cont-form" name="RUP_Jeniss" id="RUP_Jeniss" aria-label="Default select example" required style="width:100%">
                            <option value=""> Jenis Rekap Piutang</option>
                            <option value="AR">Invoice AR</option>
                            <option value="AP">Invoice AP</option>
                        </select>
                    </div>
                    <div class="col-2">
                        <input class="text-center" type="hidden" name="TypeRUPPrint" id="TypeRUPPrint" value="">
                        <button class="cont-btn text-center" id="BtnCetakHeader"onclick="window.open('RUP-Print-Header.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&custID='+document.getElementById('custID').value+'&jenis='+document.getElementById('RUP_Jeniss').value,'_Self')">Cetak Rekap</button>

                        <button class="cont-btn text-center" id="BtnCetakDetail"onclick="window.open('RUP-Print-Detail.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&custID='+document.getElementById('custID').value+'&jenis='+document.getElementById('RUP_Jeniss').value,'_Self')">Cetak Rekap</button>

                        <button class="cont-btn text-center" id="BtnCetak">Cetak </button>
                    </div>
                </div>
                <div class="row mt-2" id="cont-list-bussinespartner" style="display:none">
                    <input class="text-center" type="hidden" name="custID" id="custID" value="">
                    <div class="col-4">
                        <div class="cont-list-bussinespartner">
                            <table class="align-items-center cont-text cont-tb-bs table tb-transaksi table-bordered">
                                <tr>
                                    <td colspan="2">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class=" cont-text input-group-text" id="basic-addon1"><i class="fas fa-search"></i></span>
                                            </div>
                                            <input onkeyup="getbussines()" type="text" name="custNama" id="custNama" class="cont-form form-control" placeholder="Masukan Nama Bussines Partner" aria-label="Username" aria-describedby="basic-addon1">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center" style="width:5px">
                                        <input type="checkbox" name="" id="" value="">
                                    </td>
                                    <td>Pilih Semua</td>
                                </tr>
                                <tbody class="list-bussines">
                                <%
                                    do while not bussinespartner.eof
                                %>
                                <tr>
                                    <td class="text-center" style="width:5px">
                                        <input type="checkbox" onchange="checkbarang(this)" name="<%=bussinespartner("custNama")%>" id="<%=bussinespartner("custID")%>" value="<%=bussinespartner("custID")%>">
                                    </td>
                                    <td><%=bussinespartner("custNama")%></td>
                                </tr>
                                <script>
                                    function getbussines(){
                                        $.ajax({
                                            type: "get",
                                            url: "get-bussines.asp?custNama="+document.getElementById("custNama").value,
                                            success: function (url) {
                                                $('.list-bussines').html(url);
                                            }
                                        });
                                    }
                                    

                                    var array = [];
                                    function checkbarang(ck){
                                        var id = ck.value+",";
                                        var nama = ck.name+",";
                                        if (ck.checked){
                                            var obj = {
                                                id,
                                                nama,
                                            }
                                            array.push(obj);
                                                array.map((key)=> {
                                            });
                                            document.getElementById("custID").value = document.getElementById("custID").value +id;
                                            // document.getElementById("bsID").value = document.getElementById("bsID").value +nama;
                                            $.ajax({
                                                type: "get",
                                                url: "get-bussinespartner.asp?custID="+document.getElementById("custID").value,
                                                success: function (url) {
                                                    $('.lisnama').html(url);
                                                    $('.tgla').focus();
                                                    document.getElementById("tgla").value = "";
                                                    document.getElementById("tgle").value = "";
                                                }
                                            });
                                            $.ajax({
                                                type: "get",
                                                url: "load-penjualan.asp?custID="+document.getElementById("custID").value,
                                                success: function (url) {
                                                    $('.datapenjualan').html(url);
                                                    $('.tgla').focus();
                                                    document.getElementById("tgla").value = "";
                                                    document.getElementById("tgle").value = "";
                                                }
                                            });
                                        }else{
                                            const result = array.filter(s => s.id != id);
                                            console.log(result);
                                            array = result
                                            array.map((s)=> {
                                                id = s.id
                                            });
                                            console.log(array);
                                            if(array==0){
                                                document.getElementById("custID").value = "";
                                            }else{
                                                document.getElementById("custID").value = id;
                                            }
                                            $.ajax({
                                                type: "get",
                                                url: "load-penjualan.asp?custID="+document.getElementById("custID").value,
                                                success: function (url) {
                                                    $('.datapenjualan').html(url);
                                                    $('.tgla').focus();
                                                    document.getElementById("tgla").value = "";
                                                    document.getElementById("tgle").value = "";
                                                }
                                            });
                                            $.ajax({
                                                type: "get",
                                                url: "get-bussinespartner.asp?custID="+document.getElementById("custID").value,
                                                success: function (url) {
                                                    $('.lisnama').html(url);
                                                    $('.tgla').focus();
                                                    document.getElementById("tgla").value = "";
                                                    document.getElementById("tgle").value = "";
                                                }
                                            });
                                        }
                                    }
                                </script>
                                <%
                                    bussinespartner.movenext
                                    loop
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row p-1">
                <div class="col-12">
                    <div class="cont-tb" style="overflow:scroll;height:26.5rem">
                        <table class="tb-dashboard cont-tb align-items-center table tb-transaksi table-bordered table-condensed mt-1">
                            <thead class="tb-dashboard">
                                <tr class="text-center">
                                    <th>NO</th>
                                    <th>TAHUN</th>
                                    <th>JENIS</th>
                                    <th>BUSSINES PARTNER</th>
                                    <th>TANGGAL UPDATE</th>
                                </tr>
                            </thead>
                            <tbody class="datapenjualan">
                            <%  
                                no = 0 
                                do while not RUP.eof
                                no = no + 1
                            %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td class="text-center"> <%=RUP("RUP_Tahun")%> </td>
                                    <td class="text-center"> <%=RUP("RUP_Jenis")%> </td>
                                    <td class="text-start">  <%=RUP("custNama")%> </td>
                                    <td class="text-center"> <%=RUP("RUP_UpdateTime")%> </td>
                                </tr>
                            <%
                                RUP.movenext
                                loop
                            %>
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../../ModalHome.asp"-->
</body>
    <script>
        function updatebtn(){
                document.getElementById("caripo").disabled = false
                document.getElementById("jenispo").disabled = false
                document.getElementById("namapd").disabled = false
            }

        

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
        function CheckSession() {
                var session = '<%=Session("username") <> null%>';
                //session = '<%=Session("username")%>';
                alert(session);
                if (session == false) {
                    alert("Your Session has expired");
                    window.location = "login.aspx";
                }
                else {
                    alert(session);
                     }
            }

        const radioButtons = document.querySelectorAll('input[name="TypeRUP"]');
        for(const radioButton of radioButtons){
            radioButton.addEventListener('change', showSelected);
        }        
        
        function showSelected(e) {
            console.log(e);
            if (this.checked) {
                document.getElementById("TypeRUPPrint").value = `${this.value}`;
                if (this.value == "H"){
                    document.getElementById("BtnCetakHeader").style.display = "block"
                    document.getElementById("BtnCetakDetail").style.display = "none"
                    document.getElementById("BtnCetak").style.display = "none"
                }else{
                    document.getElementById("BtnCetakHeader").style.display = "none"
                    document.getElementById("BtnCetakDetail").style.display = "block"
                    document.getElementById("BtnCetak").style.display = "none"

                }
            }
        }

    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>