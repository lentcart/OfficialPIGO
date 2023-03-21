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
        
    </script>
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
                    <span class="breadcrumb-item cont-text"> Periode Laporan </span><br>
                </div>
            </div>

            <div class="row align-items-center mt-2">
                <div class="col-2">
                    <input onchange="getdata()"  class="text-center cont-form" type="date" name="tgla" id="tgla" value="">
                </div>
                <div class="col-2">
                    <input onchange="getdata()"  class="text-center cont-form" type="date" name="tgle" id="tgle" value="">
                </div>
                
                <div class="col-1 me-4">
                    <div class="dropdown">
                        <button class="btn-download-lap cont-btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false"  style="width:8rem">
                        Kartu Stok
                        </button>
                        <ul class="dropdown-menu p-2 mt-1 breadcrumb-item" aria-labelledby="dropdownMenuButton1">
                            <li>
                                <button class="cont-btn" onclick="window.open('Kartu-Stok.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&typeproduk='+document.getElementById('typeproduk').value+'+&typepart='+document.getElementById('typepart').value,'_Self')">PDF</button>
                            </li>
                            <li class="mt-2">
                                <button class="cont-btn" onclick="window.open('KartuStokExp.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value+'&typeproduk='+document.getElementById('typeproduk').value+'+&typepart='+document.getElementById('typepart').value,'_Self')">Excel</button>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-1 me-4">
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
                    <tbody>
                        <% 
                            no = 0
                            do while not Pembelian.eof 
                            no = no + 1
                        %>
                        <tr>
                            <td class="text-center"> <%=no%> </td>
                            <td class="text-center"> <%=Pembelian("mmID")%> </td>
                            <td class="text-center"> <%=Pembelian("mmTanggal")%> </td>
                            <td class="text-center"> 
                                <%=Pembelian("custNama")%> 
                                <input type="hidden" id="custID" name="custID" value="<%=Pembelian("mm_custID")%>">
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