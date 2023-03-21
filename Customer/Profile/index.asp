<!--#include file="../../connections/pigoConn.asp"--> 

<%
	if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if

    set customer_cmd =  server.createObject("ADODB.COMMAND")
    customer_cmd.activeConnection = MM_PIGO_String

    customer_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPassword, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custPhone3, MKT_M_Customer.custJk, MKT_M_Customer.custTglLahir, MKT_M_Customer.custRekening, MKT_M_Customer.custStatus, MKT_M_Customer.custRating, MKT_M_Customer.custPoinReward, MKT_M_Customer.custLastLogin, MKT_M_Customer.custVerified,  MKT_M_Customer.custDakotaGYN, MKT_M_Customer.custAktifYN, MKT_M_Seller.sl_almID, MKT_M_Seller.slName,MKT_M_Customer.custPhoto, MKT_M_Seller.sl_custID FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID  where MKT_M_Customer.custID = '"& request.Cookies("custID") &"'"
    set customer = customer_CMD.execute

    set cust_cmd =  server.createObject("ADODB.COMMAND")
    cust_cmd.activeConnection = MM_PIGO_String

    cust_cmd.commandText = "select * from MKT_M_Customer where custID = '"& request.Cookies("custID") &"'"
    set cust = cust_CMD.execute
    
	set Seller_cmd =  server.createObject("ADODB.COMMAND")
    Seller_cmd.activeConnection = MM_PIGO_String

    Seller_cmd.commandText = "select * from MKT_M_Seller where sl_custID = '"& request.Cookies("custID") &"'"
    set Seller = Seller_CMD.execute
    
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
            <link rel="stylesheet" type="text/css" href="profile.css">
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
            <!--#include file="../../header.asp"-->
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
                                <a class="text-dr" href="<%=base_url%>/Customer/Notifikasi/Pesanan/">Notifikasi Pesanan</a>
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
                    <div class="col-lg-0 col-md-0 col-sm-0 col-10">
                        <div class="bd-cust">
                            <div class="row">
                                <div class="col-8">
                                    <h5 class="text-judul-pr" >Data Diri</h5>
                                    <span class="text-desc-pr"> Kelola informasi profil Anda untuk mengontrol, melindungi dan mengamankan akun</span>
                                </div>
                                <div class="col-4">
                                    <button class="ubah-btn mt-4"  name="sim" id="sim" type="button" style="margin-left:4.5rem">Menjadi Seller</button>
                                </div>
                            </div>
                        <hr>
                        <div class="row">
                            <div class="col-8">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="row ">
                                            <div class="col-3">
                                                <span class="text-sub-judul-pr mt-4 mb-3">Nama Lengkap </span>
                                            </div>
                                            <div class="col-1">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> :</span>
                                            </div>
                                            <div class="col-8">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> <%= customer("custNama") %></span>
                                            </div>
                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-3">
                                                <span class="text-sub-judul-pr mt-4 mb-3">Alamat Email </span>
                                            </div>
                                            <div class="col-1">
                                                <span class="text-sub-judul-pr mt-4 mb-3">:</span>
                                            </div>
                                            <div class="col-8">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> <%= customer("custEmail") %></span>
                                            </div>
                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-3">
                                                <span class="text-sub-judul-pr mt-4 mb-3">Nomor Telepon 1 </span>
                                            </div>
                                            <div class="col-1">
                                                <span class="text-sub-judul-pr mt-4 mb-3">:</span>
                                            </div>
                                            <div class="col-8">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> <%= customer("custPhone1") %></span>
                                            </div>
                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-3">
                                                <span class="text-sub-judul-pr mt-4 mb-3">Nomor Telepon 2 </span>
                                            </div>
                                            <div class="col-1">
                                                <span class="text-sub-judul-pr mt-4 mb-3">:</span>
                                            </div>
                                            <div class="col-8">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> <%= customer("custPhone2") %></span>
                                            </div>
                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-3">
                                                <span class="text-sub-judul-pr mt-4 mb-3">Nomor Telepon 3 </span>
                                            </div>
                                            <div class="col-1">
                                                <span class="text-sub-judul-pr mt-4 mb-3">:</span>
                                            </div>
                                            <div class="col-8">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> <%= customer("custPhone3") %></span>
                                            </div>
                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-3">
                                                <span class="text-sub-judul-pr mt-4 mb-3">Jenis Kelamin </span>
                                            </div>
                                            <div class="col-1">
                                                <span class="text-sub-judul-pr mt-4 mb-3">:</span>
                                            </div>
                                            <div class="col-8">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> <%= customer("custJk") %></span>
                                            </div>
                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-3">
                                                <span class="text-sub-judul-pr mt-4 mb-3">Tanggal Lahir </span>
                                            </div>
                                            <div class="col-1">
                                                <span class="text-sub-judul-pr mt-4 mb-3">:</span>
                                            </div>
                                            <div class="col-8">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> <%= customer("custTgllahir") %></span>
                                            </div>
                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-3">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> Nama Seller </span>
                                            </div>
                                            <div class="col-1">
                                                <span class="text-sub-judul-pr mt-4 mb-3">:</span>
                                            </div>
                                            <div class="col-8">
                                                <span class="text-sub-judul-pr mt-4 mb-3"> <%= customer("slName") %></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="ubah-btn mt-3"  name="sim"id="myBtnud" onclick="loadmodal()">Ubah Data Diri</button>
                            </div>
                            <div class="col-4">
                                <div class="mb-0">
                                    <div class="cardd">
                                        <div class="">
                                            <label for="">
                                                <img src="data:image/png;base64,<%=customer("custPhoto") %>" id="output" width="250" height="250" style="margin-left:19px;margin-top:10px" onclick="rf()">
                                            </label>
                                            <input type="file" name="firstimg1" id="firstimg1" style="display:none" onchange="loadFile(event)"><br>
                                            <textarea name="image" id="base64" rows="1" style="display:none"></textarea>
                                        </div>
                                        <button type="button" class="ubah-btn mt-3" name="sim" id="sim"  data-bs-toggle="modal" data-bs-target="#exampleModal" style="margin-left:5rem">Ubah Foto</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    
        <!--Body-->

        <!-- Update Data -->
            <div id="myModalud" class="modalud">
                <div class="modalud-content">
                    <div class="modalud-header">
                        <span class="close">&times;</span>
                        <h5 class="text-updatedata">Ubah Data Diri</h5>
                    </div>
                    <div class="modalud-body" style="margin-left:20px">
                        <form method="post" action="updatedata.asp" >
                            <div class="row">
                                <div class="col-12">
                                <input class="form-updatedata" type="hidden" name="custID" id="custID=" value="<%=cust("custID") %>">
                                <div class="row">
                                    <div class="col-4">
                                        <span class="text-updatedata"> Nama Lengkap </span>
                                    </div>
                                    <div class="col-8">
                                        <input class="form-updatedata" type="text" name="namalengkap" id="namalengkap=" value="<%=cust("custNama") %>">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <span class="text-updatedata"> Alamat Email </span>
                                    </div>
                                    <div class="col-8">
                                        <input class="form-updatedata"type="text" name="email" id="email=" value="<%=cust("custEmail") %>">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <span class="text-updatedata"> Nomor Telepon 1 </span>
                                    </div>
                                    <div class="col-8">
                                        <input class="form-updatedata" type="text" name="phone1" id="phone1=" value="<%=cust("custPhone1") %>">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <span class="text-updatedata"> Nomor Telepon 2 </span>
                                    </div>
                                    <div class="col-8">
                                        <input class="form-updatedata" type="text" name="phone2" id="phone2=" value="<%=cust("custPhone2") %>">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <span class="text-updatedata"> Nomor Telepon 3 </span>
                                    </div>
                                    <div class="col-8">
                                        <input class="form-updatedata" type="text" name="phone3" id="phone3=" value="<%=cust("custPhone3") %>">
                                    </div>
                                </div>
                                    <div class="row">
                                        <div class="col-4">
                                            <span class="text-updatedata"> Jenis Kelamin </span>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="jk" id="jk" value="P" checked>
                                                <label  class="text-updatedata form-check-label" for="gridRadios1">
                                                Perempuan
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="jk" id="jk" value="L">
                                                <label class="text-updatedata form-check-label" for="gridRadios2">
                                                Laki-Laki
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-4">
                                            <span class="text-updatedata"> Tanggal Lahir </span>
                                        </div>
                                        <div class="col-7">
                                            <input class="form-updatedata" type="date" name="tgllahir" id="tgllahir=" value="">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-4">
                                            <span class="text-updatedata"> Nama Seller </span>
                                        </div>
                                        <div class="col-7">
                                            <input class="form-updatedata" type="text" name="namaseller" id="namaseller=" value="<%=customer("slName") %>">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modalud-footer">
                            <input class="btn-sim text-updatedata" type="submit" value="Simpan Perubahan">
                        </div>
                    </form>
                </div>
            </div>
        <!-- Update Data -->

        <!-- Update Foto -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Ubah Foto Profil</h5>
                        </div>
                        <div class="modal-body">
                            <label for="firstimg1">
                                <img src="../../assets/logo/upload.png" id="output1" width="200" height="200" style="border:3px solid #f5f5f5;margin-left:7rem; border-radius:20px">
                            </label>
                            <input type="file" name="firstimg1" id="firstimg1" style="display:none" onchange="loadFile1(event)"><br>
                            <textarea name="image1" id="base64_1" rows="1" style="display:none" ></textarea>
                        </div>
                        <div class="modal-footer">
                            <button onclick="updatefoto()" type="button"  name="ubahfoto" id="ubahfoto" class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">Simpan Perubahan</button>
                        </div>
                    </div>
                </div>
            </div>
        <!-- Update Foto -->
        <br><br>
        <!--#include file="../../footer.asp"-->
    </body>
    <script>

        // Load Foto Profile
            if (window.File && window.FileReader && window.FileList && window.Blob) {
                document.getElementById('firstimg1').addEventListener('change', SKUFileSelect1, false);
                } else {
                alert('The File APIs are not fully supported in this browser.');
                }

                function SKUFileSelect1(evt) {
                var f1 = evt.target.files[0]; 
                var reader1 = new FileReader();
                reader1.onload = (function(theFile1) {
                    return function(e1) {
                    var binaryData1 = e1.target.result;
                    var base64String1 = window.btoa(binaryData1);
                    document.getElementById('base64_1').value = base64String1;
                    };
                })(f1);
                reader1.readAsBinaryString(f1);
            }
        // Load Foto Profile

        // Get the modal Update Data Profile
            var modal = document.getElementById("myModalud");
                var btn = document.getElementById("myBtnud");
                var span = document.getElementsByClassName("close")[0];
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
        // Get the modal Update Data Profile

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
    <% Server.execute ("../getTransaksiUpdateCust.asp") %>
</html>