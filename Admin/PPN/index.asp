<!--#include file="../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
        response.redirect("../../admin/")
    end if
    if session("H5A") = false then 
        Response.redirect "../../Admin/home.asp"
    end if
    
    set Tax_CMD = server.CreateObject("ADODB.command")
    Tax_CMD.activeConnection = MM_pigo_STRING
    Tax_CMD.commandText = "SELECT * FROM MKT_M_Tax Where TaxAktifYN = 'Y' "
    set Tax = Tax_CMD.execute

    
%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title> OFFICIAL PIGO </title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        <script>
        </script>
    </head>
<body>
    <!--#include file="../loaderpage.asp"-->
    <div class="wrapper">
        <!--#include file="../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-10 col-md-10 col-sm-12">
                        <span class="cont-judul"> MENU PPN </span>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <form class="" method="POST" action="add-ppn.asp">
                    <div class="cont-PPnMasukan">
                        <div class="row">
                            <div class="col-lg-2 col-md-6 col-sm-12">
                                <span class=" cont-text"> Tanggal Update  </span><br>
                                <input type="date" class=" text-center cont-form" name="TaxTanggal" id="TaxTanggal" value="" >
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <span class="cont-text"> Update ID </span><br>
                                <input type="text" readonly class=" cont-form" name="TaxUpdateName" id="TaxUpdateName" value="<%=Session("Username")%>">
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <span class="cont-text"> Nama PPN  </span><br>
                            <input type="text" class=" cont-form" name="TaxNama" id="TaxNama" value="">
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <span class="cont-text"> Deskripsi  </span><br>
                            <input type="text" class=" cont-form" name="TaxDesc" id="TaxDesc" value="">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-lg-2 col-md-6 col-sm-12">
                            <span class="cont-text"> Tanggal Validasi </span><br>
                            <input type="Date" class=" text-center cont-form" name="TaxTglValidasi" id="TaxTglValidasi" value="">
                        </div>
                        <div class="col-lg-2 col-md-6 col-sm-12">
                            <span class="cont-text"> Kategori Tax </span><br>
                            <input type="text" class=" text-center cont-form" name="TaxKategori" id="TaxKategori" value="S">
                        </div>
                        <div class="col-lg-2 col-md-6 col-sm-12">
                            <span class="cont-text"> Tax (%)</span><br>
                            <input type="text" class=" cont-form" name="TaxRate" id="TaxRate" value="">
                        </div>
                        <div class="col-lg-2 col-md-6 col-sm-12">
                            <span class="cont-text"> Tahun </span><br>
                            <input type="text" class=" text-center cont-form" name="TaxTahun" id="TaxTahun" value="<%=year(now())%>">
                        </div>
                        <div class="col-lg-2 col-md-6 col-sm-12">
                            <span class="cont-text"></span><br>
                            <input type="radio" id="Aktif" name="Aktif" value="Y" checked>
                            <label for="Aktif" class="cont-text">Aktif</label>
                        </div>
                        <div class="col-lg-2 col-md-6 col-sm-12">
                            <span class="cont-text"></span><br>
                            <input type="submit" class="cont-btn" value="Tambah PPN">
                        </div>
                    </div>
                </form>
            </div>

            <div class="row mt-3">
                <div class="col-12">
                    <div class="cont-table-PPN"  style="overflow-x:scroll; padding:5px 5px">
                        <table class=" align-items-center table cont-tb cont-table table-bordered table-condensed mt-1">
                            <thead>
                                <tr class="text-center">
                                    <th>No</th>
                                    <th>ID TAX </th>
                                    <th>TAX TANGGAL</th>
                                    <th>NAMA</th>
                                    <th>DEKSRIPSI</th>
                                    <th>TAX (%)</th>
                                    <th>TAHUN</th>
                                    <th>KET</th>
                                    <th>AKSI</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    no = 0 
                                    do while not Tax.eof
                                    no = no + 1
                                %>
                                    <tr>
                                        <td class="text-center"><%=no%></td>
                                        <td class="text-center">
                                            <%=Tax("TaxID")%>
                                            <input type="hidden" name="TaxID" id="TaxID<%=Tax("TaxID")%>" value="<%=Tax("TaxID")%>">
                                        </td>
                                        <td class="text-center"><%=day(CDate(Tax("TaxTanggal")))%>&nbsp;<%=MonthName(Month(Tax("TaxTanggal")))%>&nbsp;<%=Year(Tax("TaxTanggal"))%>&nbsp;</td>
                                        <td><%=Tax("TaxNama")%></td>
                                        <td><%=Tax("TaxDesc")%></td>
                                        <td class="text-center"><%=Tax("TaxRate")%></td>
                                        <td class="text-center"><%=Tax("TaxTahun")%></td>
                                        <% if Tax("TaxAktifYN") = "Y" then %>
                                        <td class="text-center">Aktif</td>
                                        <% else %>
                                        <td class="text-center">Tidak Aktif</td>
                                        <% end if %>
                                        <td class="text-center">
                                            <button class="cont-btn"> Edit </button> <br>
                                            <button class="cont-btn mt-2" onclick="deletetax<%=Tax("TaxID")%>()"> Hapus </button> <br>
                                        </td>
                                    </tr>
                                    <script>
                                        function deletetax<%=Tax("TaxID")%>(){
                                            var TaxID = document.getElementById("TaxID<%=Tax("TaxID")%>").value;
                                            Swal.fire({
                                                title: 'Apakah Anda Yakin Akan Menghapus PPN Ini ?',
                                                showDenyButton: true,
                                                showCancelButton: true,
                                                confirmButtonText: 'Iya',
                                                denyButtonText: `Tidak`,
                                                }).then((result) => {
                                                if (result.isConfirmed) {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "delete-ppn.asp",
                                                        data: { 
                                                            TaxID
                                                        },
                                                        success: function (data) {
                                                            Swal.fire({
                                                                icon: 'success',
                                                                title: 'Data Berhasil Dihapus'
                                                                }).then((result) => {
                                                                    window.open(`index.asp`,`_Self`)
                                                            })
                                                        }

                                                    });
                                                } else if (result.isDenied) {
                                                    window.open(`index.asp`,`_Self`)
                                                }
                                            })

                                        }
                                    </script>
                                <% 
                                    Tax.movenext
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