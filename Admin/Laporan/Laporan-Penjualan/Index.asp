<!--#include file="../../../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    set Penjualan_CMD = server.createObject("ADODB.COMMAND")
	Penjualan_CMD.activeConnection = MM_PIGO_String

    Penjualan_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama ORDER BY custNama ASC"
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
        .cont-tb{
            width:100rem;
        }
        .cont-tb-penjualan{
            overflow-x:scroll;
            overflow-y:scroll;
            height:20rem;
            width:100%
        }
    </style>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="navigasi" style="margin:20px;">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb ">
                <li class="breadcrumb-item me-1">
                <a href="<%=base_url%>/Admin/home.asp"style="color:white" >DASHBOARD</a></li>
                <li class="breadcrumb-item me-1"><a href="index.asp" style="color:white">LAPORAN PENJUALAN</a></li>
            </ol>
        </nav>
    </div>
    <div class="cont-laporan">
        <div class="cont-laporan-detail">
            <div class="row">
                <div class="col-4">
                    <div class="form-check">
                        <input  onchange="getlist()" class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                        <span for="flexCheckDefault" class="breadcrumb-item cont-text"> CUSTOMER </span><br>
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
                                <button class="cont-btn text-start" onclick="window.open('lap-Penjualan-pdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&custID='+document.getElementById('custID').value,'_Self')"><i class="fas fa-file"></i>&nbsp;&nbsp;Laporan PDF</button>
                            </li>
                            <li class="mt-2">
                                <button class="cont-btn text-start" onclick="window.open('lap-Penjualan-exc.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&custID='+document.getElementById('custID').value,'_Self')"><i class="fas fa-file"></i>&nbsp;&nbsp;Laporan Excel </button>
                            </li>
                            <li class="mt-2">
                                <button class="cont-btn text-start" onclick="window.open('lap-penjualan-bulanan.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"><i class="fas fa-file"></i>&nbsp;&nbsp;Lap Bulanan </button>
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
        <div class="cont-tb-penjualan">
        <div class="row mt-3">
            <div class="col-12">
                <table class="align-items-center cont-tb table tb-transaksi table-bordered">
                    <thead >
                        <tr class="text-center">
                            <th>NO</th>
                            <th>TGL</th>
                            <th>ID-REF</th>
                            <th>REF (TR/PO)</th>
                            <th colspan="2">CUSTOMER</th>
                            <th>PEMBAYARAN</th>
                            <th>PENGIRIMAN</th>
                            <th colspan="2">STATUS-TRANS</th>
                            <th colspan="2">AKSI</th>
                        </tr>
                    </thead>
                    <tbody class="datapenjualan">
                        <% 
                            no = 0 
                            do while not Penjualan.eof 
                            no = no + 1
                        %>
                            <tr>
                                <td class="text-center"> <%=no%> </td>
                                <td class="text-center"> 
                                    <%=Day(Penjualan("PermTanggal"))%>/<%=Month(Penjualan("PermTanggal"))%>/<%=Year(Penjualan("PermTanggal"))%> 
                                </td>
                                <td> <%=Penjualan("PermNo")%> </td>
                                <% if Penjualan("Perm_trYN") = "N" then %>
                                <td class="text-center"> PNJ-PURCORDER </td>
                                <% else %>
                                <td class="text-center"> PNJ-TRANSWEB </td>
                                <% end if %>
                                <td> <%=Penjualan("custNama")%> </td>
                                <td class="text-center"> <%=Penjualan("almProvinsi")%> </td>
                                <% if Penjualan("Perm_trYN") = "N" then %>
                                    <td class="text-center"> KREDIT </td>
                                    <td class="text-center"> PICK-UP </td>
                                <% else %>
                                    <%
                                        Penjualan_CMD.commandText = "SELECT MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.tr_rkNomorRk, MKT_T_Transaksi_H.tr_rkBankID, MKT_T_Transaksi_D1.trPengiriman FROM MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1,12) WHERE MKT_T_Transaksi_H.tr_custID = '"& Penjualan("Perm_custID") &"' and MKT_T_Transaksi_H.trID = '"& Penjualan("PermNo") &"' GROUP BY MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.tr_rkNomorRk, MKT_T_Transaksi_H.tr_rkBankID, MKT_T_Transaksi_D1.trPengiriman "
                                        'response.write Penjualan_CMD.commandText
                                        set Pembayaran = Penjualan_CMD.execute
                                    %>
                                    <td class="text-center"> <%=Pembayaran("trJenisPembayaran")%> </td>
                                    <td class="text-center"> <%=Pembayaran("trPengiriman")%> </td>
                                <% end if %>
                                
                                <td class="text-center"> <%=Penjualan("strName")%> </td>
                                <td class="text-center"> <%=Penjualan("spName")%> </td>
                                <% if Penjualan("Perm_trYN") = "N" then %>
                                <td class="text-center"> <button class="cont-btn"> DETAIL-TRANS </button></td>
                                <% else %>
                                <td class="text-center"> <button class="cont-btn"> INVOICE-TRANS </button></td>
                                <% end if %>
                            </tr>
                        <% Penjualan.movenext
                        loop %>
                    </tbody>
                </table>
            </div>
        </div>
        </div>
    </div>

</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>