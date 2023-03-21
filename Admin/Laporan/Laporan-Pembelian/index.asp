<!--#include file="../../../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    set Pembelian_cmd = server.createObject("ADODB.COMMAND")
	Pembelian_cmd.activeConnection = MM_PIGO_String

        Pembelian_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Alamat.almKota,  MKT_M_Alamat.almProvinsi FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE almJenis <> 'Alamat Toko' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Alamat.almKota,  MKT_M_Alamat.almProvinsi"
        'response.write Pembelian_cmd.commandText

    set Pembelian = Pembelian_cmd.execute

        Pembelian_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID GROUP BY MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama"
        'response.write Pembelian_cmd.commandText

    set bussinespartner = Pembelian_cmd.execute

    
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>

        <title>Oficial PIGO</title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">
    </head>
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
                url: "load-pembelian.asp",
                data : {
                    custID,
                    tgla,
                    tgle
                },
                success: function (data) {
                    $('.datapembelian').html(data);
                }
            });
        }
    </script>
    <style>
        .cont-list-bussinespartner{
            background:white;
            height:8rem;
            overflow:scroll;
        }
        .cont-form{
            width:8rem;
        }
    </style>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="navigasi" style="margin:20px;">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb ">
                <li class="breadcrumb-item me-1">
                <a href="<%=base_url%>/Admin/home.asp"style="color:white" >DASHBOARD</a></li>
                <li class="breadcrumb-item me-1"><a href="index.asp" style="color:white">LAPORAN PEMBELIAN</a></li>
            </ol>
        </nav>
    </div>
    <div class="cont-laporan">
        <div class="cont-laporan-detail">
            <div class="row">
                <div class="col-4">
                    <div class="form-check">
                        <input  onchange="getlist()" class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                        <span for="flexCheckDefault" class="breadcrumb-item cont-text"> Bussines Partner </span><br>
                    </div>
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
                <div class="col-1 me-4">
                    <input onchange="gettanggal()" class="tgla text-center  cont-form" type="date" name="tgla" id="tgla" value="" >
                </div>
                <div class="col-1 me-4">
                    <input onchange="gettanggal()" class=" text-center  cont-form" type="date" name="tgle" id="tgle" value="" >
                </div>
                <div class="col-1">
                    <div class="dropdown">
                        <button class="btn-download-lap cont-btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="width:10rem">
                        Download laporan  
                        </button>
                        <ul class="dropdown-menu breadcrumb-item" aria-labelledby="dropdownMenuButton1">
                            <li>
                                <button class="cont-btn text-start" onclick="window.open('lap-pembelian-pdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&custID='+document.getElementById('custID').value,'_Self')"><i class="fas fa-file"></i>&nbsp;&nbsp;Laporan PDF</button>
                            </li>
                            <li class="mt-2">
                                <button class="cont-btn text-start" onclick="window.open('lap-pembelian-exc.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&custID='+document.getElementById('custID').value,'_Self')"><i class="fas fa-file"></i>&nbsp;&nbsp;Laporan Excel </button>
                            </li>
                            <li class="mt-2">
                                <button class="cont-btn text-start" onclick="window.open('laporan-bulanan.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&custID='+document.getElementById('custID').value,'_Self')"><i class="fas fa-file"></i>&nbsp;&nbsp;Lap Bulanan </button>
                            </li>
                            <li class="mt-2">
                                <button class="cont-btn text-start" onclick="window.open('laporan-mutasi.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&custID='+document.getElementById('custID').value,'_Self')"><i class="fas fa-file"></i>&nbsp;&nbsp;Laporan Mutasi </button>
                            </li>
                        </ul>
                    </div>
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
                                    <input type="checkbox" onchange="checkbarang(this)" name="<%=bussinespartner("custNama")%>" id="<%=bussinespartner("mm_custID")%>" value="<%=bussinespartner("mm_custID")%>">
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
                                            url: "load-pembelian.asp?custID="+document.getElementById("custID").value,
                                            success: function (url) {
                                                $('.datapembelian').html(url);
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
                                            url: "load-pembelian.asp?custID="+document.getElementById("custID").value,
                                            success: function (url) {
                                                $('.datapembelian').html(url);
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
        
        <div class="row mt-3">
            <div class="col-12">
                <table class="align-items-center cont-tb table tb-transaksi table-bordered">
                    <thead >
                        <tr  class="text-center">
                            <th>NO</th>
                            <th>ID PEMBELIAN</th>
                            <th>TANGGAL</th>
                            <th colspan="4">BUSSINES PARTNER</th>
                        </tr>
                    </thead>
                    <tbody class="datapembelian">
                        <% 
                            no = 0
                            do while not Pembelian.eof 
                            no = no + 1
                        %>
                        <tr>
                            <td class="text-center"> <%=no%> </td>
                            <td class="text-center"> <%=Pembelian("mmID")%> </td>
                            <td class="text-center"> <%=Cdate(Pembelian("mmTanggal"))%> </td>
                            <td> 
                                <%=Pembelian("custNama")%> 
                                <input type="hidden" id="ID" name="ID" value="<%=Pembelian("mm_custID")%>">
                            </td>
                            <td class="text-center"> <%=Pembelian("custEmail")%> </td>
                            <td class="text-center"> <%=Pembelian("almKota")%> </td>
                            <td class="text-center"> <%=Pembelian("almProvinsi")%> </td>
                        </tr>
                        <% 
                            Pembelian.movenext
                            loop
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>
        function getdata(){
            var tgla = document.getElementById("tgla").value;
            var tgle = document.getElementById("tgle").value;
            var typeproduk = document.getElementById("typeproduk").value;
            var typepart   = document.getElementById("typepart").value;
            var kategori   = document.getElementById("kategori").value;
            var namapd     = document.getElementById("namaproduk").value;
            $.ajax({
                type: "get",
                url: "get-tanggal.asp",
                data : 
                {
                    tgla,
                    tgle,
                    typeproduk,
                    typepart,
                    namapd
                },
                success: function (data) {
                    $('.list-stok-produk').html(data);
                    // document.getElementById("loader-page").style.display = "block";
                    //     setTimeout(() => {
                    //     // window.location.reload();
                    //     document.getElementById("loader-page").style.display = "none";
                    // }, 10000);
                }
            });
        }
    </script>
</html>