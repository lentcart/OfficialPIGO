<!--#include file="../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../admin/")
    
    end if

        PermID = request.queryString("PermID")
        set SuratJalan_cmd = server.createObject("ADODB.COMMAND") 
        SuratJalan_cmd.activeConnection = MM_PIGO_String

        SuratJalan_cmd.commandText = "SELECT MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_H.SJ_pscID, MKT_T_SuratJalan_H.SJ_Tanggal, MKT_T_SuratJalan_H.SJ_custID, MKT_M_Customer.custNama, MKT_T_SuratJalan_H.SJ_TerimaYN,  MKT_T_SuratJalan_H.SJ_PostingYN, MKT_T_SuratJalan_H.SJ_JR_ID , MKT_T_SuratJalan_H.SJ_InvARYN, MKT_T_SuratJalan_H.SJ_InvARID  FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_M_Customer.custID = MKT_T_SuratJalan_H.SJ_custID where SJ_AktifYN = 'Y' "
        'response.write SuratJalan_cmd.commandText 
        set SuratJalan = SuratJalan_cmd.execute

        SuratJalan_cmd.commandText = " SELECT MKT_T_SuratJalan_H.SJID,MKT_T_SuratJalan_H.SJ_Tanggal FROM MKT_T_SuratJalan_H "
        'response.write SuratJalan_cmd.commandText 

        set SJID = SuratJalan_cmd.execute


%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!--#include file="../IconPIGO.asp"-->

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
                url: "Load-SuratJalan.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value+"&SJID="+document.getElementById("SJID").value,
                success: function (url) {
                $('.DataListSuratJalan').html(url);
                }
            });
        }
    </script>
    <style>

</style>
    </head>
    <!--#include file="../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-11 col-md-11 col-sm-12">
                        <span class="cont-text"> SURAT JALAN </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>
            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-2">
                        <span class="cont-text"> Tanggal Surat Jalan </span> <br>
                        <input onchange="getListData()" class="text-center cont-form" type="Date" name="tgla" id="tgla" value="">
                    </div>
                    <div class="col-2">
                        <br>
                        <input onchange="getListData()" class="text-center cont-form" type="Date" name="tgle" id="tgle" value="">
                    </div>
                    <div class="col-2">
                    </div>
                    <div class="col-6">
                        <span class="cont-text"> ID Surat Jalan </span> <br>
                        <input onkeyup="getListData()" type="text" class="cont-form" name="SJID" id="SJID" value="">
                    </div> 
                </div>
                <div class="row text-start mt-3">
                    <div class="col-12">
                        <button class="cont-btn" style="background-color:green; color:white; width:max-content"> <i class="fas fa-check"></i> </button> &nbsp; : &nbsp; <span class="cont-text"> Surat Jalan Sudah Diverifikasi </span>
                    </div> 
                </div>
            </div>
            <div class="cont-tb-suratjalan">
                <div class="row p-2  d-flex flex-row-reverse">
                    <div class="col-12">
                        <table class="tb-dashboard cont-tb cont-text table tb-transaksi table-bordered table-condensed mt-1">
                            <thead>
                                <tr class="text-center">
                                    <th>NO</th>
                                    <th>ID SURAT JALAN</th>
                                    <th>TANGGAL</th>
                                    <th>ID PSCB</th>
                                    <th>BUSSINES PARTNER</th>
                                    <th>STATUS</th>
                                    <th>FAKTUR</th>
                                    <th colspan="2" >POST-JURNAL</th>
                                </tr>
                            </thead>
                            <tbody class="DataListSuratJalan">
                                <%
                                    no = 0 
                                    do while not SuratJalan.eof
                                    no = no + 1
                                %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td class="text-center"> 
                                        <input type="hidden" name="SJID" id="SJID<%=SuratJalan("SJID")%>" value="<%=SuratJalan("SJID")%>">
                                        <button  onclick="window.open('bukti-suratjalan.asp?SJID='+document.getElementById('SJID<%=SuratJalan("SJID")%>').value)" class="cont-btn"><%=SuratJalan("SJID")%> </button>
                                    </td>
                                    <td class="text-center"> <%=Day(CDate(SuratJalan("SJ_Tanggal")))%>/<%=Month(SuratJalan("SJ_Tanggal"))%>/<%=Year(CDate(SuratJalan("SJ_Tanggal")))%></td>
                                    <td class="text-center"> <%=SuratJalan("SJ_pscID")%> </td>
                                    <td> <%=SuratJalan("custNama")%> </td>

                                        <% if SuratJalan("SJ_TerimaYN") = "N" then %>
                                        <td class="text-center" colspan="2"> <button class="cont-btn" onclick="window.open('verifikasi-suratjalan.asp?SJID='+document.getElementById('SJID<%=SuratJalan("SJID")%>').value,'_Self')"> VERIFIKASI SURAT JALAN </button> </td>
                                        <% else %>
                                        <td class="text-center"> <button class="cont-btn" style="background-color:green; color:white"> <i class="fas fa-check"></i> </button>  </td>
                                            <% if SuratJalan("SJ_InvARYN") = "N" then %>
                                                <td class="text-center"> <button  onclick="window.open('../Transaksi/Invoice-AR/Add-Faktur.asp?SJID='+document.getElementById('SJID<%=SuratJalan("SJID")%>').value,'_Self')" class="cont-btn"> <i class="fas fa-folder-plus"></i> ADD FAKTUR/INV </button> </td>
                                            <% else %>
                                                <td class="text-center"> 
                                                    <input type="hidden" name="InvARID" id="InvARID<%=no%>" value="<%=SuratJalan("SJ_InvARID")%>">
                                                    <button class="cont-btn" onclick="window.open('../Transaksi/Invoice-AR/Bukti-FakturPenjualan.asp?InvARID='+document.getElementById('InvARID<%=no%>').value)"> <i class="fas fa-print"></i> <%=SuratJalan("SJ_InvARID")%> </button>
                                                </td>
                                            <% end if %>
                                        <% end if %>

                                        <% if SuratJalan("SJ_PostingYN") = "N" then %>
                                        <td class="text-center"> <%=SuratJalan("SJ_PostingYN")%> </td>
                                        <td class="text-center"> <button onclick="window.open('posting-jurnal.asp?SJID='+document.getElementById('SJID<%=SuratJalan("SJID")%>').value,'_Self')"  class="cont-btn"> POSTING JURNAL </button> </td>
                                        <% else %>
                                        <td class="text-center"> 
                                            <input type="hidden" name="JR_ID" id="JR_ID<%=no%>" value="<%=SuratJalan("SJ_JR_ID")%>">
                                            <%=SuratJalan("SJ_PostingYN")%>
                                        </td>
                                        <td class="text-center"> <button class="cont-btn" onclick="window.open('../GL/GL-Jurnal/jurnal-voucher.asp?JR_ID='+document.getElementById('JR_ID<%=no%>').value)"> <i class="fas fa-print"></i> <%=SuratJalan("SJ_JR_ID")%></button> </td>
                                        <% end if %>
                                </tr>
                                <%
                                    SuratJalan.movenext
                                    loop
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--#include file="../ModalHome.asp"-->
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