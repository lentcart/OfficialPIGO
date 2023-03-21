<!--#include file="../../../connections/pigoConn.asp"--> 

<%
	if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if

    set notifikasi_cmd =  server.createObject("ADODB.COMMAND")
    notifikasi_cmd.activeConnection = MM_PIGO_String

    notifikasi_cmd.commandText = "SELECT  MKT_T_Pesanan_H.psID, MKT_T_Transaksi_H.trID, CAST(MIN(MKT_T_Notifikasi.notif_UpdateTime) AS DATE) AS Tanggal, CONVERT(varchar, CAST(MIN(MKT_T_Notifikasi.notif_UpdateTime) AS TIME), 8) AS Waktu,   MKT_T_Notifikasi.notif_UpdateTime, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdID, MKT_M_Produk.pdImage1,  MKT_M_Produk.pdNama, MKT_T_Notifikasi.notif_ID, MKT_T_Notifikasi.notif_ReadYN, MKT_T_StatusTransaksi.strID, produk.pdImage1 AS Gambar, MKT_T_StatusTransaksi.strName, MKT_T_StatusTransaksi.strNameL  FROM MKT_M_Produk AS produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON produk.pdID = MKT_T_Transaksi_D1A.tr_pdID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID ON  MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID RIGHT OUTER JOIN MKT_T_Transaksi_H RIGHT OUTER JOIN MKT_T_Notifikasi LEFT OUTER JOIN MKT_T_Pesanan_H ON MKT_T_Notifikasi.notif_ID = MKT_T_Pesanan_H.psID LEFT OUTER JOIN MKT_T_Pesanan_D ON MKT_T_Pesanan_H.psID = MKT_T_Pesanan_D.psD ON MKT_T_Transaksi_H.trID = MKT_T_Pesanan_H.ps_trID ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID AND  LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Notifikasi.notif_To = '"& request.Cookies("custID") &"'  GROUP BY MKT_T_Pesanan_H.psID, MKT_T_Transaksi_H.trID, MKT_T_Notifikasi.notif_UpdateTime,  MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdID,  MKT_M_Produk.pdNama, MKT_M_Produk.pdImage1,MKT_T_Notifikasi.notif_ID, MKT_T_Notifikasi.notif_ReadYN, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_StatusTransaksi.strNameL,produk.pdImage1 "
    set notifikasi = notifikasi_CMD.execute
    
    
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Required meta tags -->

        <!-- Bootstrap CSS -->
            <link href="<%=base_url%>/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" type="text/css" href="<%=base_url%>/Customer/Profile/profile.css">
            <link rel="stylesheet" type="text/css" href="<%=base_url%>/Customer/customer.css">
            <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
            <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
            <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
            <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <!-- Bootstrap CSS -->

        <title> Official PIGO</title>
            
            <script>
                    var loadFile = function(event) {
                    var output = document.getElementById('output1');
                    output.src = URL.createObjectURL(event.target.files[0]);
                    output.onload = function() {
                    URL.revokeObjectURL(output.src)
                    }
                };

                var loadFilee = function(event) {
                    var outputt = document.getElementById('outputt');
                    outputt.src = URL.createObjectURL(event.target.files[0]);
                    outputt.onload = function() {
                    URL.revokeObjectURL(outputt.src)
                    }
                };

                function updatefoto(){
                    var id = document.getElementById('base64_1').value;
                    // console.log(poto);
                    $.ajax({
                        method: "post",
                        url: "update-foto.asp",
                        data: { id : id },
                        success: function (data) {
                            Swal.fire({
                            icon: 'success',
                            title: 'Data Berhasil Di Simpan',
                            text: 'Klik Pada Gambar Untuk Resfresh'
                        });
                        }
                    });
                }
                function rf(){
                    location.reload();
                }
                function loadmodal(){
                    $.ajax({
                        url: 'updatedata.asp',
                        data: { id : id },
                        method: 'post',
                        success: function (data) {
                        console.log(data);
                        }
                    });
                    }

                function simpan(){
                    let sim= document.getElementsByClassName("sim");

                    document.getElementById("lanjut").style.display = "block";
            }
            </script>

    </head>
    <body>
        <!-- Header -->
            <!--#include file="../../../header.asp"-->
        <!-- Header -->

        <!--Body-->
            <div class="hd-cust">
                <div class="row" >
                    <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                        <button class="dropdown-btn mt-3" >Akun Saya<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct text-dr">
                                <a class="text-dr" href="<%=base_url%>/Customer/Profile/">Profile</a>
                                <a class="text-dr" href="<%=base_url%>/Customer/Alamat/">Alamat Saya </a>
                                <a class="text-dr" href="<%=base_url%>/Customer/Rekening/">Rekening</a>
                            </div>
                        <button class="dropdown-btn" >Pesanan<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct text-dr">
                                <a class="text-dr" href="<%=base_url%>/Customer/Pesanan/">Pesanan Saya</a>
                                <a class="text-dr" href="">Pengiriman</a>
                                <a class="text-dr" href="">Pengembalian</a>
                            </div>
                        <button class="dropdown-btn" >Notifikasi<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct text-dr">
                                <a class="text-dr" href="">Notifikasi Pesanan</a>
                                <a class="text-dr" href="">Notifikasi Chat</a>
                                <a class="text-dr" href="">Promo Official PIGO</a>
                                <a class="text-dr" href="">Penilaian</a>
                                <a class="text-dr" href="">Info Offical PIGO</a>
                            </div>
                        <button class="dropdown-btn" >Poin Reward<i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct">
                                <a class="text-dr" href="">Poin Reward</a>
                            </div>
                    </div>
                    <div class=" mt-3 col-lg-0 col-md-0 col-sm-0 col-10">
                        <div class="bd-cust">
                            <div class="row">
                                <div class="col-12">
                                    <span class="text-judul-pr" >Notifikasi Pesanan </span><br>
                                </div>
                            </div>
                        <hr>
                        <div class="row mb-2    ">
                            <div class="col-12">
                                <span class="txt-notif-pesanan"> Tandai Pesan Sudah Dibaca </span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                            
                            <% 
                                no = 0
                                for k = asc("A") to asc("Z")
                                    do while not notifikasi.eof 
                                    car = k
                                    no = no + 1
                            %>
                                <% if notifikasi("notif_ReadYN") = "N" Then %>
                                <div class="cont-notif-pesanan mb-3" style="background-color:#b5e9f3">
                                    <div class="row align-items-center">
                                        <div class="col-1 text-center">
                                            <img src="data:image/png;base64,<%=notifikasi("Gambar")%>" style="height:60px;width: 80px;" alt=""/>
                                        </div>
                                        <div class="col-8">
                                            <span> <%=notifikasi("strName")%> - No Pesanan [ <%=notifikasi("psID")%><%=car%> ] Dari Transaksi [<%=notifikasi("trID")%>/<%=no%>] </span> <br>
                                            <span> <%=CDate(notifikasi("Tanggal"))%> - <%=notifikasi("Waktu")%> </span>
                                        </div>
                                        <div class="col-3">
                                            <span> lihat Rincian Pensanan </span>
                                        </div>
                                    </div>
                                </div>
                                <% else %>
                                <%end if %>
                            <% 
                                notifikasi.movenext
                                loop 
                                nomor = no
                                next
                            %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    
        <!--Body-->
    </body>
    <script>


        // Dropdown Button
            var dropdown = document.getElementsByClassName("dropdown-btn");
                var i;
                    for (i = 0; i < dropdown.length; i++) {
                    dropdown[i].addEventListener("click", function() {
                    this.classList.toggle("active");
                    var dropdownContent = this.nextElementSibling;
                        if (dropdownContent.style.display === "block") {
                            dropdownContent.style.display = "none";
                        }else {
                            dropdownContent.style.display = "block";
                        }
                    });
                }
        // Dropdown Button
    
    </script>  
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js">
    </script>
</html>