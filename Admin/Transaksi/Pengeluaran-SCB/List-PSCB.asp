<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

        set Pengeluaran_cmd = server.createObject("ADODB.COMMAND")
        Pengeluaran_cmd.activeConnection = MM_PIGO_String

        Pengeluaran_cmd.commandText = " SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_Permintaan_Barang_H.PermID, MKT_T_Permintaan_Barang_H.PermTanggal,  MKT_T_PengeluaranSC_H.psc_InvARYN,MKT_T_PengeluaranSC_H.psc_SJYN FROM MKT_T_Permintaan_Barang_H RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_PengeluaranSC_H.psc_permID ORDER BY pscUpdateTime Desc"
        'response.write Pengeluaran_cmd.commandText 
        set Pengeluaran = Pengeluaran_cmd.execute
        Pengeluaran_cmd.commandText = " SELECT pscID, pscTanggal  FROM MKT_T_PengeluaranSC_H WHERE psc_InvARYN = 'N' "
        'response.write Pengeluaran_cmd.commandText 
        set pscID = Pengeluaran_cmd.execute


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

        function getListData(){
            $.ajax({
                type: "get",
                url: "Load-PSCB.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value+"&PSCB_Type="+document.getElementById("PSCB_Type").value+"&PSCBID="+document.getElementById("PSCBID").value,
                success: function (url) {
                $('.DataListPengeluaran').html(url);
                }
            });
        }
    </script>
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
                        <span class="cont-text"> PENGELUARAN SUKU CADANG BARU </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button onclick="window.open('../Permintaan-Barang/List-Permintaan.asp','_Self')" name="btn-add" id="btn-add" class="cont-btn" style="display:block"><i class="fas fa-clipboard-list"></i>&nbsp;&nbsp; LIST PERMINTAAN</button> 
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-2">
                        <span class="cont-text">Periode Pengeluaran </span> <br>
                        <input onchange="getListData()" class="text-center cont-form" type="Date" name="tgla" id="tgla" value="">
                    </div>
                    <div class="col-2">
                        <br>
                        <input onchange="getListData()" class="text-center cont-form" type="Date" name="tgle" id="tgle" value="">
                    </div>
                    <div class="col-2">
                        <span class="cont-text"> Type </span> <br>
                        <select onchange="getListData()" class="cont-form" name="PSCB_Type" id="PSCB_Type" aria-label="Default select example" required>
                                <option value=""> Pilih </option>
                                <option value="1">Slow moving</option>
                                <option value="2">Fast moving</option>
                            </select>
                    </div>
                    
                    <div class="col-6">
                        <span class="cont-text"> ID PSCB </span><span class="cont-text" style="font-size:11px; color: #aaa">(<i>Pengeluaran Suku Cadang Baru</i>)</span> <br>
                        <input onkeyup="getListData()" type="text" class="cont-form" name="PSCBID" id="PSCBID" aria-label="Default select example" value="">
                    </div>
                </div>
            </div>

            <div class="row p-2">
                <div class="col-12">
                    <table class=" align-items-center cont-tb table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                        <thead class="text-center">
                            <tr>
                                <th> NO         </th>
                                <th> ID PSCB    </th>
                                <th> TANGGAL    </th>
                                <th> TYPE       </th>
                                <th> PERMINTAAN </th>
                                <th> AKSI </th>
                            </tr>
                        </thead>
                        <tbody class="DataListPengeluaran">
                        <%
                            no = 0
                            do while not Pengeluaran.eof
                            no = no + 1
                        %>
                            <tr>
                                <td class="text-center"> <%=no%> </td>
                                <td class="text-center"> 
                                    <input type="hidden" name="pscID" id="pscID<%=Pengeluaran("pscID")%>" value="<%=Pengeluaran("pscID")%>">
                                    <button class="cont-btn" onclick="window.open('bukti-PSCB.asp?pscID='+document.getElementById('pscID<%=Pengeluaran("pscID")%>').value)"> <%=Pengeluaran("pscID")%> </button>
                                </td>
                                <td class="text-center"> 
                                    <%=Day(CDate(Pengeluaran("pscTanggal")))%>/<%=Month(CDate(Pengeluaran("pscTanggal")))%>/<%=Year(CDate(Pengeluaran("pscTanggal")))%> 
                                </td>
                                <td class="text-center"> <%=Pengeluaran("pscType")%> </td>
                                <td class="text-center"> <%=Pengeluaran("permID")%>/<%=Pengeluaran("permTanggal")%> </td>
                                
                                <% if Pengeluaran("psc_SJYN") = "Y" then %>
                                    <%
                                        Pengeluaran_cmd.commandText = "SELECT MKT_T_SuratJalan_H.SJID FROM MKT_T_SuratJalan_H RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_SuratJalan_H.SJ_pscID = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D.pscIDH WHERE MKT_T_PengeluaranSC_H.pscID = '"& pengeluaran("pscID") &"'"
                                        'response.write Pengeluaran_cmd.commandText 
                                        set SuratJalan = Pengeluaran_cmd.execute
                                    %>
                                <td class="text-center"> 
                                    <input type="hidden" name="sjid" id="sjid<%=no%>" value="<%=SuratJalan("SJID")%>">
                                    <button class="cont-btn" onclick="window.open('../../SuratJalan/bukti-suratjalan.asp?SJID='+document.getElementById('sjid<%=no%>').value)"> BUKTI SURAT JALAN</button> 
                                </td>
                                <% else %>
                                <td class="text-center"> <button class="cont-btn" onclick="window.open('../../SuratJalan/Det-SuratJalan.asp?pscID='+document.getElementById('pscID<%=Pengeluaran("pscID")%>').value,'_Self')"> SURAT JALAN </button> </td>
                                <% end if %>
                            </tr>
                        <%
                            Pengeluaran.movenext
                            loop
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
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
        /* Dengan Rupiah */
        /* Fungsi */
        function formatRupiah(angka, prefix)
        {
            var number_string = angka.replace(/[^,\d]/g, '').toString(),
                split	= number_string.split(','),
                sisa 	= split[0].length % 3,
                rupiah 	= split[0].substr(0, sisa),
                ribuan 	= split[0].substr(sisa).match(/\d{3}/gi);
                
            if (ribuan) {
                separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');
            }
            
            rupiah = split[1] != undefined ? rupiah + ',' + split[1] : rupiah;
            return prefix == undefined ? rupiah : (rupiah ? 'Rp. ' + rupiah : '');
        }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>