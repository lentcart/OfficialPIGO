<!--#include file="../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
    response.redirect("../../admin/")
    end if
    if session("H4A") = false then 
        Response.redirect "../../Admin/home.asp"
    end if 

    set Bank_cmd =  server.createObject("ADODB.COMMAND")
    Bank_cmd.activeConnection = MM_PIGO_String

    Bank_cmd.commandText = "select * from GLB_M_Bank "
    set Bank = Bank_CMD.execute

    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String

        BussinesPartner_cmd.commandText = "SELECT MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almLengkap, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, GLB_M_Bank.BankName,  MKT_M_Customer.custNama, MKT_M_Customer.custID, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custPaymentTerm FROM MKT_M_Rekening RIGHT OUTER JOIN GLB_M_Bank ON MKT_M_Rekening.rkBankID = GLB_M_Bank.BankID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Rekening.rk_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID WHERE (MKT_M_Customer.custPartnerGroup = 'V')  AND (rkJenis = 'Rekening Customer') AND (MKT_M_Alamat.almJenis = 'Alamat Pribadi')  OR (MKT_M_Alamat.almJenis = 'Alamat BS') GROUP BY MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almLengkap, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, GLB_M_Bank.BankName,  MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custID "
        'response.write BussinesPartner_cmd.commandText

    set BussinesPartner = BussinesPartner_cmd.execute
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
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    </head>
    <script>
        function tambah(){
            let pem= document.getElementsByClassName("tmb");

            document.getElementById("tmb").style.display = "none";
            document.getElementById("formsupplier").style.display = "block";
            document.getElementById("formsupplierr").style.display = "block";
            document.getElementById("tsupplier").style.display = "none";
            }
        var array = [];

        function cust(){
            let pem= document.getElementsByClassName("custID");

            document.getElementById("cust").style.display = "block";
        }

        var id = [];
        // console.log(id);
    
        function loaddata(){
            var no = document.getElementById('no').value;
            var custID = id;
            var pdidall = "";
            for ( i=1; i<=no; i++){
                id.push($(`#custID${i}`).val());
            }
            if ( pdidall.length<1 ){
                pdidall = pdidall+id;
            }else{
                    pdidall  = pdidall+","+id; 
                }
            document.getElementById("custall").value = pdidall;
            return id;

            
        }
        $('#periode').on("change",function(){
            let pr = $('#periode').val();
            console.log(pr);
            if (ongkir == "tahun" ){
                $("#cont-tahun").show();
            
            }else{
                $("#cont-tanggal").show();

            }
        });
        
        function tgla(){
            $.ajax({
                type: "get",
                url: "get-data.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                $('.datatr').html(url);
                    
                }
            });
        }

        
        function tgle(){
            $.ajax({
                type: "get",
                url: "get-data.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                $('.datatr').html(url);
                    
                }
            });
        }
        function Refresh(){
            document.getElementById("loader-page").style.display = "block";
                setTimeout(() => {
                    window.location.reload();
                    document.getElementById("loader-page").style.display = "none";
                }, 1000);
            
        }
        function getbussinespart(){
            var Bussines = $('input[name=custNama]').val();            
            $.ajax({
                type: "get",
                url: "get-bussinespartner.asp?custNama="+Bussines,
                success: function (url) {
                // console.log(url);
                $('.cont-bussinespart').html(url);
                }
            });
        }
        
    </script>
<body>
    <!--#include file="../loaderpage.asp"-->
    <div class="wrapper">
        <!--#include file="../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="maegin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row" id="tmb">
                    <div class="col-lg-9 col-md-4 col-sm-8">
                        <span class="cont-judul"> BUSSINES PARTNER </span>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-2">
                        <button onclick="return tambah()"  name="tambah" id="tambah" class="cont-btn" > <i class="fas fa-add"></i> TAMBAH BARU</button>
                        </div>
                    <div class="col-lg-1 col-md-4 col-sm-2">
                        <button onclick="Refresh()" class="cont-btn" style="width:1.8rem"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>

                <div class="cont-bussinespartner"  style="display:none" id="formsupplierr">
                    <div class="row">
                        <div class="col-lg-10 col-md-10 col-sm-12">
                            <span class="cont-text"> Bussines Partner Baru </span>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-12">
                            <button class="cont-btn" onclick="return Refresh()" > BATAL </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2" style="display:none" id="formsupplier">
                <div class="form-bussinespart mt-1" >
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <form class="" action="add-bussinespartner.asp" method="POST">
                                <div class="supplier-baru">
                                    <div class="row text-center">
                                        <div class="col-12">
                                            <div class="cont-label-text">
                                                <span class=" cont-text"> BUSSINES PARTNER </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-md-6 col-sm-12">
                                            <span class="cont-text"> Nama </span><br>
                                            <input onkeyup="getbussinespart()" required type="text" class="  cont-form" name="custNama" id="custNama" value="" placeholder="Masukan Nama Lengkap PT/CV/TOKO DLL"><br>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-12 cont-bussinespart">
                                            <span class="cont-text">  </span><br>
                                            <select   class="  cont-form" name="" id="" aria-label="Default select example">
                                                <option selected>Pilih</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="cont-bussines">
                                        <div class="row align-items-center mt-2">
                                            <div class="col-lg-2 col-md-6 col-sm-12">
                                                <span class="cont-text"> Status Kredit </span><br>
                                                <select required  class="  cont-form" name="statuskredit" id="statuskredit" aria-label="Default select example" >
                                                    <option selected>Pilih</option>
                                                    <option value="1">Kredit</option>
                                                    <option value="2">Cash</option>
                                                </select><br>
                                            </div>
                                            <div class="col-lg-2 col-md-6 col-sm-12">
                                                <span class="cont-text"> Pembayaran </span><br>
                                                <select required  class="  cont-form" name="jpembayaran" id="jpembayaran" aria-label="Default select example" >
                                                    <option selected>Pilih</option>
                                                    <option value="1">Transfer</option>
                                                    <option value="2">Cash</option>
                                                    <option value="3">On Credit</option>
                                                    <option value="4">Direct Deposit</option>
                                                    <option value="5">Direct Debit</option>
                                                </select><br>
                                            </div>
                                            <div class="col-lg-2 col-md-3 col-sm-12">
                                                <input checked  type="checkbox" class=" mt-4" name="statustax" id="statustax" value="PO">
                                                <label required for="statustax" class="cont-text"> PO Tax Exempt </label>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12">
                                                <span class="cont-text"> Deskripsi </span><br>
                                                <input required type="text" class="  cont-form" name="deskripsi" id="deskripsi" value="" placeholder="Masukan Keterangan dari PT/CV/TOKO DLL "><br>
                                            </div>
                                            <div class="col-lg-2 col-md-3 col-sm-12">
                                                <span class="cont-text"> PO Payment Term </span><br>
                                                <input required type="number" class="text-center  cont-form" name="jangkawaktu" id="jangkawaktu" value="30"><br>
                                            </div>
                                        </div>
                                        <div class="row mt-2 align-items-center">
                                            <div class="col-lg-2 col-md-4 col-sm-12">
                                                <span class="cont-text">  </span><br>
                                                <input checked  type="checkbox" class="" name="group" id="group" value="V">
                                                <label required for="group" class="cont-text"> Vendor </label>
                                            </div>
                                            <div class="col-lg-2 col-md-4 col-sm-12">
                                                <span class="cont-text">  </span><br>
                                                <input checked  type="checkbox" class="" name="jtransaksi" id="jtransaksi" value="2">
                                                <label required for="jtransaksi" class="cont-text"> Pembelian </label>
                                            </div>
                                            <div class="col-lg-2 col-md-4 col-sm-12">
                                                <span class="cont-text"> NPWP </span><br>
                                                <input onkeyup="validasiform()" required type="text" class=" text-center cont-form" name="npwp" id="npwp" value="" maxlength="15" style="font-size:12px"><br>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-12">
                                                <input onchange="alamatnpwpp()"  type="checkbox" class="" name="cekbox" id="cekbox" value="">
                                                <label required for="cekbox" class="cont-text"> Sesuai Alamat Perusahaan </label>
                                                <input required type="text" class="cont-form" name="alamatnpwp" id="alamatnpwp" value="" placeholder="Masukan Alamat NPWP "><br>
                                            </div>
                                        </div>
                                        <div class="row mt-2 text-center">
                                            <div class="col-12">
                                                <div class="cont-label-text">
                                                    <span class=" cont-text"> Lokasi </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <div class="col-lg-6 col-md-12 col-sm-12">
                                                <span class="cont-text"> Alamat Lengkap Perusahaan </span><br>
                                                <input required type="text" class=" AlamatPerusahaan cont-form" name="alamatlengkap" id="alamatlengkap" value="" placeholder="Co: Nama Jalan/RT/No/Blok/Kel/Kec"><br>
                                            </div>
                                            <div class="col-lg-2 col-md-4 col-sm-12">
                                                <span class="cont-text"> No Telp 1 </span><br>
                                                <input  onkeyup="validasiform()" required type="text" class="text-center cont-form" name="phone1" id="phone1" value="" maxlength="13" placeholder="No Telepon Perusahaan"><br>
                                            </div>
                                            <div class="col-lg-2 col-md-4 col-sm-12">
                                                <span class="cont-text"> No Telp 2 </span>&nbsp;<span style="color:red; font-size:11px"><b><i>( opsional )</b></i></span><br>
                                                <input required type="text" class="text-center cont-form" name="phone2" id="phone2" value="0"  maxlength="13" placeholder="No Telepon Perusahaan"><br>
                                            </div>
                                            <div class="col-lg-2 col-md-4 col-sm-12">
                                                <span class="cont-text"> Fax (021)</span><br>
                                                <input onkeyup="validasiform()" required type="text" class="text-center  cont-form" name="fax" id="fax" value="" maxlength="10" placeholder="Masukan No Fax"><br>
                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <div class="col-lg-3 col-md-3 col-sm-12">
                                                <span class="cont-text"> Provinsi </span><br>
                                                <select required class="cont-text cont-form "  required name="provinsi" id="provinsi" >
                                                    <Option> Pilih Provinsi </option>
                                                </select><br>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-12">
                                                <span class="cont-text"> Kota </span><br>
                                                <input  required type="text" class="cont-form" name="kab" id="kab" value="" placeholder="Masukan Kota/Kab" ><br>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-12">
                                                <span class="cont-text"> Email Perusahaan </span><br>
                                                <input onblur="validasiEmail()" required type="text" class="cont-form" name="emailpr" id="emailpr" value="" placeholder="Masukan Alamat Email Perusahaan"><br>
                                            </div>
                                            <div class="col-lg-2 col-md-3 col-sm-12">
                                            <span class="cont-text">  </span><br>
                                                <input checked  type="checkbox" class="" name="wpenjualan" id="wpenjualan" value="Standard">
                                                <label required for="wpenjualan" class="cont-text"> Sales Region </label>
                                            </div>
                                        </div>
                                        <div class="row mt-2 text-center">
                                            <div class="col-12">
                                                <div class="cont-label-text">
                                                    <span class=" cont-text"> Akun BANK </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <div class="col-lg-6 col-md-6 col-sm-12">
                                                <span class="cont-text"> Nama Bank  </span><br>
                                                <select  class=" cont-form" name="idBank" id="idBank" required>
                                                    <option value="">Pilih Jenis Bank</option>
                                                    <% do while not Bank.eof %>
                                                    <option value="<%=Bank("BankID")%>"><%=Bank("BankName")%></option>
                                                    <% Bank.movenext
                                                    loop %>
                                                </select>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-12">
                                                <span class="cont-text"> No Rekening </span><br>
                                                <input required type="number" class="  cont-form" name="norekening" id="norekening" value="" placeholder="Nomor Rekening Perusahaan"><br>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-12">
                                                <span class="cont-text"> Nama Pemilik Rekening </span><br>
                                                <input required type="text" class="cont-form" name="pemilikrek" id="pemilikrek" value="a.n "><br>
                                            </div>
                                        </div>
                                        <div class="row mt-2 text-center">
                                            <div class="col-12">
                                                <div class="cont-label-text">
                                                    <span class=" cont-text"> Orang Yang Dapat Dihubungi </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <div class="col-lg-6 col-md-6 col-sm-12">
                                                <span class="cont-text"> Nama </span><br>
                                                <input required type="text" class="  cont-form" name="namacp" id="namacp" value="" placeholder="Masukan Nama Lengkap Orang Yang Dapat Dihubungi (CP)"><br>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-12">
                                                <span class="cont-text"> No Telp/HandPhone </span><br>
                                                <input onkeyup="validasiform()" required type="text" class=" cont-form" name="phonecp" id="phonecp" value="" maxlength="13" placeholder="Masukan No Handphone CP"><br>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-12">
                                                <span class="cont-text"> Email  CP</span>&nbsp;<span style="color:red; font-size:11px"><b><i>Jika Tidak Ada Masukan (-)</b></i></span><br>
                                                <input onblur="validasiEmailcp()" required type="text" class="  cont-form" name="emailcp" id="emailcp" value="" placeholder="Masukan Alamat Email CP" ><br>
                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <div class="col-lg-6 col-md-6 col-sm-12">
                                                <input onchange="alamatnpwpp()"  type="checkbox" class="" name="cekboxcp" id="cekboxcp" value="">
                                                <label required for="cekbox" class="cont-text"> Sesuai Alamat Perusahaan </label>
                                                <input required type="text" class="  cont-form" name="alamatcp" id="alamatcp" value="" placeholder="Masukan Alamat Contact Person"><br>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-12">
                                                <span class="cont-text"> Jabatan </span><br>
                                                <input required type="text" class="  cont-form" name="jabatancp" id="jabatancp" value="" placeholder="Masukan Jabatan CP"><br>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row align-items-center text-center mt-3">
                                        <div class="col-12">
                                            <input class="cont-btn" type="submit" name="simpan" id="simpan" value="simpan">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div id="tsupplier">
                <div class="row mt-3">
                    <div class="col-12">
                        <div class="cont-table-bussinespart" style="overflow-x:scroll; padding:5px 5px ">
                            <table class="align-items-center table cont-text table-bordered">
                                <thead class="text-center">
                                    <tr>
                                        <th> NO </th>
                                        <th> BUSSINES PARTNER </th>
                                        <th> EMAIL </th>
                                        <th> ALAMAT </th>
                                        <th> AKSI </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        no = 0 
                                        do while not BussinesPartner.eof
                                        no = no + 1 
                                    %>
                                    <tr> 
                                        <td class="text-center"><%=no%>
                                            <input type="hidden" name="custID" id="custID<%=no%>" value="<%=BussinesPartner("custID")%>"></td>
                                        <td><%=BussinesPartner("custNama")%></td>
                                        <td><%=BussinesPartner("custEmail")%></td>
                                        <td><%=BussinesPartner("almLengkap")%>, <%=BussinesPartner("almProvinsi")%></td>
                                        <td class="text-center">
                                            <button class="cont-btn" onclick="window.open('detail-bussinespartner.asp?custID='+document.getElementById('custID<%=no%>').value,'_Self')"  style="width:5rem"> <i class="fas fa-edit"></i>&nbsp; EDIT </button>
                                        </td>
                                    </tr>
                                    <% 
                                        BussinesPartner.movenext
                                        loop 
                                    %>
                                </tbody>
                            </table>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    <!--#include file="../ModalHome.asp"-->
</body>
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

        $('#provinsi').click(function(){     
                
            $.getJSON(`https://dev.farizdotid.com/api/daerahindonesia/provinsi`,function(data){ 
                for(let i = 0; i < data.provinsi.length; i++){
                    $('#provinsi').append(new Option(`${data.provinsi[i].nama}`, `${data.provinsi[i].nama}`));
                    
                }

            });
        });
        // $('#provinsi').change(function(){
        //     let prov = $('#provinsi').val();
        //     $.getJSON(`https://www.dakotacargo.co.id/api/api_glb_M_kodepos.asp?key=15f6a51696a8b034f9ce366a6dc22138&id=11022019000001&aProp=${prov}`,function(data){ 
        //         const ids = data.map(o => o.KotaKabupaten);
        //         const newData = data.filter(({KotaKabupaten}, index) => !ids.includes(KotaKabupaten, index + 1));
        //         for(var i=0; i<newData.length; i++){
        //                 document.getElementById("loader-page").style.display = "block";
        //                 setTimeout(() => {
        //                     document.getElementById("loader-page").style.display = "none";
        //                 }, 1000);
        //                 $('#kab').append(new Option(`${newData[i].KotaKabupaten}`, `${newData[i].KotaKabupaten}`));
        //         }
        //     });
        // });

        function getbussines(){
            var id = document.getElementById("custID").value;            
                console.log(id);
            $.ajax({
                type: "get",
                url: "load-bussinespartner.asp?custID="+id,
                success: function (url) {
                    
                $('.cont-bussines').html(url);
                }
            });
        }

        function validasiform(){
            let nonpwp = document.getElementById("npwp").value;
            let formatnonpwp = nonpwp.replace(/(\d{2})(\d{3})(\d{3})(\d{1})(\d{3})(\d{3})/g, "$1.$2.$3.$4-$5.$6");
            console.log(formatnonpwp);
            document.getElementById("npwp").value = formatnonpwp;

            let nofax = document.getElementById("fax").value;
            let formatfax = nofax.replace(/(\d{3})(\d{7})/g, "($1)-$2");
            document.getElementById("fax").value = formatfax;

            let nophone = document.getElementById("phonecp").value;
            let formatphone1 = nophone.replace(/(\d{4})(\d{4})(\d{4})/g, "$1-$2-$3");
            document.getElementById("phonecp").value = formatphone1;
        };
        
        function alamatnpwpp(){
            var almperusahaan = document.getElementById("alamatlengkap");
            var cknpwp = document.getElementById("cekbox");
            var ckcp = document.getElementById("cekboxcp");
            if(cknpwp.checked == true){
                if(almperusahaan.value === "" ){
                    Swal.fire({
                        text: 'Silahkan Isi Alamat Perusahan Terlebih Dahulu !'
                    });
                    $('.AlamatPerusahaan').focus();
                    cknpwp.checked = false;
                }else{
                    document.getElementById("alamatnpwp").value = almperusahaan.value;
                }
            }else{
                document.getElementById("alamatnpwp").value = "";
            }


            if(ckcp.checked == true){
                if(almperusahaan.value === "" ){
                    alert("Alamat Perusahaan Kosong");
                    ckcp.checked = false;
                }else{
                    document.getElementById("alamatcp").value = almperusahaan.value;
                }
            }else{
                document.getElementById("alamatcp").value = "";
            }
        }

        function validasiEmail() {
            var pr = document.getElementById("emailpr").value;
            if ( pr == "-" ){
                document.getElementById("emailpr").value = "-";
            }else{
                var atps=pr.indexOf("@");
                var dots=pr.lastIndexOf(".");
                
                if (atps<1 || dots<atps+2 || dots+2>=pr.length) {
                    Swal.fire({
                        text: 'Alamat Email Tidak Valid !'
                    });
                    document.getElementById("emailpr").value = "";
                    return false;
                } 
            }
        }
        
        function validasiEmailcp() {
            var cp = document.getElementById("emailcp").value;
            if ( cp == "-" ){
                document.getElementById("emailcp").value = "-";
            }else{
                var atpss=cp.indexOf("@");
                var dotss=cp.lastIndexOf(".");
                if (atpss<1 || dotss<atpss+2 || dotss+2>=cp.length) {
                    Swal.fire({
                        text: 'Alamat Email Tidak Valid !'
                    });
                    document.getElementById("emailcp").value = "";
                    return false;
                } 
            }
        }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>  
</html>