<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
        response.redirect("../../../admin/")
    end if

    set PermintaanBarang_cmd = server.createObject("ADODB.COMMAND")
	PermintaanBarang_cmd.activeConnection = MM_PIGO_String

        PermintaanBarang_cmd.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermNo, MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_H.PermTujuan, MKT_T_Permintaan_Barang_H.PermJenis,  MKT_T_Permintaan_Barang_H.Perm_PSCBYN, MKT_T_Permintaan_Barang_H.Perm_custID, MKT_T_Permintaan_Barang_H.Perm_trYN, MKT_T_Permintaan_Barang_H.Perm_UpdateTime,  MKT_T_Permintaan_Barang_H.Perm_AktifYN, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Alamat.almKota FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_M_Customer.custID = MKT_T_Permintaan_Barang_H.Perm_custID WHERE (MKT_M_Alamat.almJenis <> 'Alamat Toko') and Perm_AktifYN = 'Y' ORDER BY MKT_T_Permintaan_Barang_H.Perm_UpdateTime DESC "
        'response.write PermintaanBarang_cmd.commandText 

    set PermintaanBarang = PermintaanBarang_cmd.execute

    set IDPerm_cmd = server.createObject("ADODB.COMMAND")
	IDPerm_cmd.activeConnection = MM_PIGO_String

        IDPerm_cmd.commandText = "SELECT PermID, PermTanggal FROM MKT_T_Permintaan_Barang_H WHERE (Perm_PSCBYN = 'N')"
        'response.write IDPerm_cmd.commandText 

    set IDPerm = IDPerm_cmd.execute


%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!--#include file="../../IconPIGO.asp"-->

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
        function getListData(){
            $.ajax({
                type: "get",
                url: "load-listpermintaan.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value+"&PermJenis="+document.getElementById("PermJenis").value+"&PermID="+document.getElementById("PermID").value,
                success: function (url) {
                $('.DataListPermintaan').html(url);
                }
            });
        }
        function getKeySupplier(){
            $.ajax({
                type: "get",
                url: "get-bussinespartner.asp?keysearch="+document.getElementById("keysearch").value,
                success: function (url) {
                // console.log(url);
                $('.keysp').html(url);
                
                }
            });
        }
        function getsupplier(){
            $.ajax({
                type: "get",
                url: "load-bussinespartner.asp?keysupplier="+document.getElementById("keysupplier").value,
                success: function (url) {
                // console.log(url);
                $('.datasp').html(url);
                                    
                }
            });
        }
        function tambah(){
            document.getElementById("cont-addpermintaan").style.display = "block"
            document.getElementById("cont-data").style.display = "none"
            document.getElementById("btn-add").style.display = "none"
        }
        function buktipermintaan(){
            $.ajax({
                type: "get",
                url: "bukti-permintaan.asp?PermID="+document.getElementById("PermID").value,
                success: function (url) {
                }
            });
        }
    </script>
    <style>
        .cont-tb-permintaan{
            overflow:scroll;
            height:30rem;
            margin-top:0.5rem;
        }
    </style>
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-9 col-md-9 col-sm-12">
                        <span class="cont-text"> LIST PERMINTAAN BARANG KELUAR </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button onclick="window.open('index.asp','_Self')"  name="btn-add" id="btn-add" class="cont-btn" style="display:block"><i class="fas fa-plus"></i>&nbsp;&nbsp;PERMINTAAN BARU</button> 
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-2">
                        <span class="cont-text"> Tanggal Permintaan </span> <br>
                        <input onchange="getListData()" class="text-center cont-form" type="Date" name="tgla" id="tgla" value="">
                    </div>
                    <div class="col-2">
                        <br>
                        <input onchange="getListData()" class="text-center cont-form" type="Date" name="tgle" id="tgle" value="">
                    </div>
                    <div class="col-2">
                        <span class="cont-text"> Jenis </span> <br>
                        <select onchange="getListData()" class="cont-form" name="PermJenis" id="PermJenis" aria-label="Default select example" required>
                                <option value=""> Pilih </option>
                                <option value="1">Slow moving</option>
                                <option value="2">Fast moving</option>
                            </select>
                    </div>
                    
                    <div class="col-6">
                        <span class="cont-text"> ID Permintaan </span> <br>
                        <input onkeyup="getListData()" type="text" class="cont-form" name="PermID" id="PermID" aria-label="Default select example" value="">
                    </div>
                </div>
            </div>

            <div class="row d-flex flex-row-reverse p-2">
                <div class="col-12">
                    <table class="tb-dashboard cont-tb cont-text table tb-transaksi table-bordered table-condensed mt-1">
                        <thead>
                            <tr class="text-center">
                                <th>NO</th>
                                <th>ID PERMINTAAN</th>
                                <th>NO REF</th>
                                <th>TANGGAL</th>
                                <th colspan="2">BUSSINES PARTNER</th>
                                <th>TUJUAN</th>
                                <th>AKSI</th>
                            </tr>
                        </thead>
                        <tbody class="DataListPermintaan">
                        <% If PermintaanBarang.eof = true then %>
                            <tr>
                                <td class="text-center" colspan="8"> Data Tidak Ditemukan  </td>
                            </tr>
                        <% else %>
                            <% 
                                no = 0 
                                do while not PermintaanBarang.eof 
                                no = no + 1
                            %>
                                <%
                                    PermintaanBarang_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_Permintaan_Barang_D.Perm_pdID),0) AS PDID FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_H.PermID = '"& PermintaanBarang("PermID") &"'"
                                    'response.write PermintaanBarang_cmd.commandText 
                                    set Perm = PermintaanBarang_cmd.execute
                                %>
                                <%  if Perm("PDID") = 0 then  %>
                                    <tr style=" background-color:red">
                                        <td class="text-center"> <%=no%> </td>
                                        <td class="text-center">
                                            <button class="cont-btn"> <%=PermintaanBarang("PermID")%> </button> 
                                        </td>
                                        <td class="text-center" colspan="6">  </td>
                                        <td class="text-center">  <button class="cont-btn"> DELETE </button></td>
                                    </tr>
                                <%  else %>
                                    <tr>
                                        <td class="text-center"> <%=no%> </td>
                                        <td class="text-center"> 
                                            <input type="hidden" name="PermID" id="PermID<%=no%>" value="<%=PermintaanBarang("PermID")%>">
                                            <button class="cont-btn" onclick="window.open('bukti-permintaan.asp?PermID='+document.getElementById('PermID<%=no%>').value)"> <%=PermintaanBarang("PermID")%> </button> 
                                        </td>
                                        <td class="text-center"> <%=PermintaanBarang("PermNo")%> </td>
                                        <td class="text-center"> 
                                            <%=Day(CDATE(PermintaanBarang("PermTanggal")))%>/<%=Month(CDATE(PermintaanBarang("PermTanggal")))%>/<%=Year(CDATE(PermintaanBarang("PermTanggal")))%> 
                                        </td>
                                        <td> <%=PermintaanBarang("custNama")%> </td>
                                        <td class="text-center"> <%=PermintaanBarang("almKota")%> </td>

                                        <% If PermintaanBarang("PermTujuan") = "1" then %>
                                        <td class="text-center"> Penjualan </td>
                                        <% else %>
                                        <td class="text-center"> Pemakaian Sendiri </td>
                                        <% end if %>
                                        
                                        <% if PermintaanBarang("Perm_PSCBYN") = "N" then %>
                                        <td class="text-center"> <button onclick="window.open('../Pengeluaran-SCB/?PermID='+document.getElementById('PermID<%=no%>').value,'_Self')" class="cont-btn"> GENERATE PSC </td>
                                        <% else %>
                                        <td class="text-center"> <button class="cont-btn" style="background-color:#27c021; color:white"> <i class="fas fa-check"></i> </td>
                                        <% end if  %>
                                    </tr>
                                <%  end if %>
                            <% 
                                PermintaanBarang.movenext
                                loop 
                            %>
                        <% end if %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>
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
    </script>
</html>