<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    set Penawaran_CMD = server.createObject("ADODB.COMMAND")
	Penawaran_CMD.activeConnection = MM_PIGO_String

    Penawaran_CMD.commandText = "SELECT PenwID, PenwTanggal, PenwNoPermintaan, PenwTglPermintaan, PenwNamaCust, PenwPhone, PenwEmail, PenwAlamat, PenwKota, PenwNamaCP, PenwStatus, PenwKet, PenwUpdateID, PenwUpdateTime, PenwAktifYN FROM MKT_T_Penawaran_H "
    'Response.Write Penawaran_CMD.commandText & "<br>"

    set Penawaran = Penawaran_CMD.execute

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
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
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
                    <div class="col-lg-8 col-md-8 col-sm-12">
                        <span class="cont-text"> LIST PENAWARAN PRODUKK </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn" > <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-12">
                        <button onclick="window.open('Index.asp','_Self')" class="cont-btn" > TAMBAH PENAWARAN BARU </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-12">
                        <span class="cont-text"> Status Penawaran : <span> Submission </span> | <span> Aproved </span>
                    </div>
                </div>
            </div>

            <div class="row p-1 d-flex flex-row-reverse">
                <div class="col-12">
                    <div class="cont-tb" style="overflow:scroll; height:20rem">
                        <table class="tb-dashboard cont-text align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="width:120rem">
                            <thead>
                                <tr class="text-center">
                                    <th>NO</th>
                                    <th>ID PENAWARAN</th>
                                    <th colspan="2">BUSSINES PARTNER</th>
                                    <th colspan="2">STATUS PENAWARAN </th>
                                    <th>AKSI</th>
                                </tr>
                                </thead>
                            <tbody class="dataRekap">
                                <% 
                                    no = 0 
                                    do while not Penawaran.eof 
                                    no = no + 1
                                %>
                                    <tr>
                                        <td class="text-center"> 
                                            <%=no%> 
                                            <input type="hidden" name="PenwID" id="PenwID<%=Penawaran("PenwID")%>" value="<%=Penawaran("PenwID")%>">
                                        </td>
                                        <td> 
                                            <button onclick="window.open('cetak-suratpenawaran.asp?pshID='+document.getElementById('PenwID<%=Penawaran("PenwID")%>').value,'_Self')"class="cont-btn"> <%=Penawaran("PenwID")%> - <%=CDate(Penawaran("PenwTanggal"))%> </button>
                                        </td>
                                        <td> <%=Penawaran("PenwNamaCust")%> - [<%=Penawaran("PenwPhone")%>/<%=Penawaran("PenwEmail")%>] </td>
                                        <td> <%=Penawaran("PenwAlamat")%>-<%=Penawaran("PenwKota")%> </td>
                                        <% if Penawaran("PenwStatus") = "1" then %>
                                        <td class="text-center"> <span class="cont-text" style="background-color:#4de611; padding:0px 6px; color:white;"> <i class="fas fa-arrow-up"></i> &nbsp; Submission </span> </td>
                                        <td class="text-center"> <button class="cont-btn"> Update Penawaran </button> </td>
                                        <% else %>
                                        <td class="text-center"> <span class="cont-text" style="background-color:#4de611; padding:2px 2px; color:white;"> Aproved </span> </td>
                                        <td class="text-center"> <button class="cont-btn"> Update Penawaran </button> </td>
                                        <% end If %>
                                    </tr>
                                <% 
                                    Penawaran.movenext
                                    loop 
                                %>
                            </tbody>
                        </table>
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
        
    </script>
</html>