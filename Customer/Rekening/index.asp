<!--#include file="../../connections/pigoConn.asp"--> 

<%
	if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if

    
	set Rekening_cmd =  server.createObject("ADODB.COMMAND")
    Rekening_cmd.activeConnection = MM_PIGO_String

    Rekening_cmd.commandText = "SELECT MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, MKT_M_Rekening.rkJenis, GLB_M_Bank.BankID, GLB_M_Bank.BankName, MKT_M_Customer.custID,  MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Seller.sl_custID, MKT_M_Seller.slName FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_M_Rekening ON MKT_M_Customer.custID = MKT_M_Rekening.rk_custID LEFT OUTER JOIN GLB_M_Bank ON MKT_M_Rekening.rkBankID = GLB_M_Bank.BankID Where MKT_M_Rekening.rk_custID = '"& request.Cookies("custID") &"' GROUP BY MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, MKT_M_Rekening.rkJenis, GLB_M_Bank.BankID, GLB_M_Bank.BankName, MKT_M_Customer.custID,  MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Seller.sl_custID, MKT_M_Seller.slName"
    set Rekening = Rekening_CMD.execute

	set Bank_cmd =  server.createObject("ADODB.COMMAND")
    Bank_cmd.activeConnection = MM_PIGO_String

    Bank_cmd.commandText = "select * from GLB_M_Bank "
    set Bank = Bank_CMD.execute
    
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
            <style>
            .jenisbank{
                font-size: 14px;
                width: 23rem;
                border: 2px solid white;
                border-radius: 5px;
                height: 28px;
                justify-items: left;
                font-family: "Poppins", sans-serif;
                margin-bottom: 10px;
                color: #2d2d2d;
                box-shadow: 0 4px 8px 0 rgba(34, 34, 34, 0.2), 0 2px 5px 0 rgba(100, 100, 100, 0.19);
            }
            </style>
    </head>
    <body>
        <!-- Header -->
            <!--#include file="../../header.asp"-->
        <!-- Header -->

        <!--Body-->
            <div class="hd-rek">
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
                        <div class="bd-rek">
                            <div class="row">
                                <div class="col-8">
                                    <h5 class="text-judul-rk" > Rekening Bank </h5>
                                </div>
                            </div>
                        <div class="row">
                            <div class="col-12">
                                <div id="myBtnud" class="card-rek" style="width:18rem">
                                    <div class="card-body">
                                        <h5 class="card-title"></h5>
                                        <h6 class=" text-center card-subtitle mb-2 text-muted"><i class="fas fa-plus"></i></h6>
                                        <p class=" text-center card-text">Tambah Rekening Baru</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-12">
                                <div class="div-rk">
                                    <div class="row">
                                    <%if rekening.eof = true then %>

                                        <div class="row text-center mt-4 mb-4">
                                            <div class="col-12">
                                            <img src="<%=base_url%>/assets/logo/maskotnew.png" alt="" width="250" height="250"><br>
                                                <span class="text-desc-rk"><b> Belum Ada Rekening Bank Tersimpan </b></span><br>
                                                <span class="text-desc-rk"><b> Silahkan tambah rekening bank kamu biar lebih mudah saat tarik Saldo Official PIGO!</b></span><br>
                                            </div>
                                        </div>

                                    <%else%>
                                        <% do while not rekening.eof%>
                                        <div class="col-4">
                                            <div class="card-rek" style="width: 18rem;">
                                                <div class="row align-items-center" style="padding:2px 5px">
                                                    <div class="col-2">
                                                        <img src="<%=base_url%>/assets/logo/rek.png" class="logo-rek">
                                                    </div>
                                                    <div class="col-10">
                                                        <div class="card-body">
                                                        <span style="font-size:12px; font-weight:bold"> <%=rekening("rkJenis")%> </span>
                                                            <h5 class=" mt-2 card-title"><%=rekening("BankName")%></h5>
                                                            <h6 class="card-subtitle mb-2 text-muted"><%=rekening("rkNomorRk")%></h6>
                                                            <p class="card-text"><%=rekening("rkNamaPemilik")%></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        
                                        </div>
                                        <% rekening.movenext
                                        loop%>
                                        <%end if%>
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
                        <h5 class="text-updatedata"> Tambah Rekeninng Baru </h5>
                    </div>
                    <div class="modalud-body" style="margin-left:20px">
                        <form method="post" action="P-Rekening.asp" >
                            <div class="row">
                                <div class="col-12">
                                <div class="row">
                                    <div class="col-4">
                                        <span class="text-updatedata"> Jenis Rekening </span>
                                    </div>
                                    <div class="col-8">
                                        <select class=" mb-2 jenisbank" name="jenisrekening" id="jenisrekening" required>
                                        <option selected>Pilih</option>
                                        <option value="Rekening Seller"> Rekening As Seller </option>
                                        <option value="Rekening Customer"> Rekening As Customer </option>
                                    </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <span class="text-updatedata"> Nama Bank </span>
                                    </div>
                                    <div class="col-8">
                                        <select  class=" mb-2 jenisbank" name="idBank" id="idBank" required>
                                        <option selected>Pilih </option>
                                        <% do while not Bank.eof %>
                                        <option value="<%=Bank("BankID")%>"><%=Bank("BankName")%></option>
                                        <% Bank.movenext
                                        loop %>
                                    </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <span class="text-updatedata"> No Rekening </span>
                                    </div>
                                    <div class="col-8">
                                        <input class="form-updatedata"type="text" name="norekening" id="norekening=" value="" placeholder="Masukan No Rekening">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <span class="text-updatedata"> Nama </span><br> <span class="text-updatedata" style="font-size:10px">( Pastikan Nama Sesuai Dengan Rekening Bank ) </span>
                                    </div>
                                    <div class="col-8">
                                        <input class="form-updatedata" type="text" name="nama" id="nama=" value="" placeholder="Masukan Nama Pemilik Rekening">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modalud-footer">
                            <input class="btn-sim text-updatedata" type="submit" value="Simpan">
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