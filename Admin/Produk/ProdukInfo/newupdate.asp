<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../admin/")
    
    end if
    
    pdID = request.queryString("pdID")
    
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT MKT_M_Kategori.catName, MKT_M_Merk.mrNama, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdKey, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber,  MKT_M_PIGO_Produk.pdKondisi, MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdStokAwal, MKT_M_PIGO_Produk.pdTypePart, MKT_M_PIGO_Produk.pdDesc, MKT_M_PIGO_Produk.pdHarga,  MKT_M_PIGO_Produk.pdBerat, MKT_M_PIGO_Produk.pdJenisBerat, MKT_M_PIGO_Produk.pdPanjang, MKT_M_PIGO_Produk.pdLebar, MKT_M_PIGO_Produk.pdTinggi, MKT_M_PIGO_Produk.pdVolume,  MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdStatus,MKT_M_PIGO_Produk.pd_catID,MKT_M_PIGO_Produk.pd_mrID FROM MKT_M_Kategori RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_M_Kategori.catID = MKT_M_PIGO_Produk.pd_catID LEFT OUTER JOIN MKT_M_Merk ON MKT_M_PIGO_Produk.pd_mrID = MKT_M_Merk.mrID WHERE MKT_M_PIGO_Produk.pdID = '"& pdID &"'  "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set kategori_cmd = server.createObject("ADODB.COMMAND")
    kategori_cmd.activeConnection = MM_PIGO_String

        kategori_cmd.commandText = "SELECT * FROM MKT_M_Kategori WHERE catAktifYN = 'Y' "
    
    set kategori = kategori_cmd.execute

    set Merk_cmd = server.createObject("ADODB.COMMAND")
    Merk_cmd.activeConnection = MM_PIGO_String

        Merk_cmd.commandText = "SELECT * FROM MKT_M_Merk WHERE mrAktifYN = 'Y' "
    
    set Merk = Merk_cmd.execute


%>
<!doctype html>
<html lang="en"><!doctype html>
<html lang="en">
    <head>
    <!-- required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
        const loadFile2 = function(event) {
            const output2 = document.getElementById('output2');
                output2.src = URL.createObjectURL(event.target.files[0]);
                output2.onload = function() {
                URL.revokeObjectURL(output2.src)
            }
        };
        function nilaivolume(){
            var panjang = parseInt(document.getElementById("panjangproduk").value);
            var lebar = parseInt(document.getElementById("lebarproduk").value);
            var tinggi = parseInt(document.getElementById("tinggiproduk").value);
            var nilaivolume = Number(panjang*lebar*tinggi);
            var volume = nilaivolume;
            document.getElementById("volumeproduk").value = volume;
            
        };
        document.addEventListener("DOMContentLoaded", function(event) {
            nilaivolume();
        });
    </script>
    <style>
        #clear{
            width: 14.3rem;
            color:black;
            font-weight:bold;
            border: 1px solid #d4d4d4;
            border-radius: 3px;
            padding: 2px;
            box-shadow: 0 2px 3px 0 rgba(10, 10, 10, 0.2),0 6px 20px 0 rgba(175, 175, 175, 0.19);
            background-color: #eee;
        }

        .formstyle{
            width:15rem;
            height:15rem;
            margin: auto;
            border-radius: 10px;
            padding: 5px;
        }

        .inp-cal{
            width: 44px;
            background-color: green;
            color: black;
            font-weight:bold;
            border: 1px solid #d4d4d4;
            border-radius: 0px;
            padding: 5px 5px;
            margin: 5px;
            box-shadow: 0 2px 3px 0 rgba(10, 10, 10, 0.2),0 6px 20px 0 rgba(175, 175, 175, 0.19);
            font-size: 12px;
        }
        #kalkulator{
            display:none;
            margin-left:-20px;
        }

        #calc{
            width: 14.4rem;
            font-size:12px;
            color: blue;
            font-weight:bold;
            padding: 6px 10px;
            background:#aaa;
            border: 1px solid #d4d4d4;
            border-radius: 5px;
            margin: auto;
        }
    </style>
    </head>
<body>
<!--#include file="../../loaderpage.asp"-->
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                        <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-10 col-md-4 col-sm-10">
                        <span class="cont-judul"> Update Produk : <%=pdID%> </span>
                        <input type="hidden" name="pdID" id="pdID" value="<%=pdID%>">
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-2">
                        <button onclick="window.open('index.asp','_Self')" class="cont-btn"> Batal </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row">
                    <div class="col-6">
                        <span class="cont-text"> Kata Kunci Pencarian  </span><br>
                        <input required type="text" class=" cont-form" name="katakunci" id="katakunci" value="<%=Produk("pdKey")%>" ><br>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <span class="cont-text"> Nama Produk  </span><br>
                        <input required type="text" class=" cont-form" name="namaproduk" id="namaproduk" value="<%=Produk("pdNama")%>" placeholder="Masukan Nama Produk">
                    </div>
                    <div class="col-6">
                        <span class="cont-text"> Kategori Produk </span><br>
                        <select required  class=" cont-form" name="kategori" id="kategori" aria-label="Default select example">
                            <option value="<%=Produk("pd_CatID")%>"><%=Produk("catName")%></option>
                            <%do while not kategori.eof%>
                            <option value="<%=kategori("catID")%>"><%=kategori("catName")%></option>
                            <% kategori.movenext
                            loop%>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-2">
                        <span class="cont-text"> Unit  </span><br>
                        <select required  class=" cont-form" name="unitproduk" id="unitproduk" aria-label="Default select example">
                            <option value="<%=Produk("pdUnit")%>"><%=Produk("pdUnit")%></option>
                            <option value="Pc">Pc</option>
                            <option value="Kg">Kg</option>
                            <option value="Pieces">Pieces</option>
                            <option value="Mm">Mm</option>
                            <option value="Ml">Ml</option>
                            <option value="Pack">Pack</option>
                            <option value="Dus">Dus</option>
                            <option value="Botol">Botol</option>
                            <option value="Tabung">Tabung</option>
                            <option value="Batang">Batang</option>
                        </select>
                    </div>
                    <div class="col-4">
                        <span class="cont-text"> SKU/Part Number  </span><br>
                        <input type="text" class=" cont-form" name="partnumber" id="partnumber" value="<%=Produk("pdPartNumber")%>"><br>
                    </div>
                    <div class="col-6">
                        <span class="cont-text"> Merk Produk </span><br>
                        <select required  class=" cont-form" name="merk" id="merk" aria-label="Default select example">
                            <option value="<%=Produk("pd_mrID")%>"><%=Produk("mrNama")%></option>
                            <%do while not merk.eof%>
                            <option value="<%=merk("mrID")%>"><%=merk("mrNama")%></option>
                            <% merk.movenext
                            loop%>
                        </select>
                    </div>
                </div>

                <div class="row mt-2">
                    <div class="col-2">
                        <span class="cont-text"> Kondisi Produk  </span><br>
                        <select  class=" cont-form" name="kondisiproduk" id="kondisiproduk" aria-label="Default select example">
                            <option value="<%=Produk("pdKondisi")%>"><%=Produk("pdKondisi")%></option>
                            <option value="Baru">Baru</option>
                            <option value="Bekas">Bekas</option>
                        </select>
                    </div>
                    <div class="col-4">
                        <span class="cont-text"> Type Produk  </span><br>
                        <select required class=" cont-form" name="typeproduk" id="typeproduk" aria-label="Default select example">
                            <option value="<%=Produk("pdTypeProduk")%>"><%=Produk("pdTypeProduk")%></option>
                            <option value="SPARE PART">SPARE PART</option>
                            <option value="ATK">ATK</option>
                        </select>
                    </div>
                    <div class="col-6">
                        <span class="cont-text"> Deskripsi Produk </span><br>
                        <input type="text" required class="cont-form" name="deskripsi" id="deskripsi" value="<%=Produk("pdDesc")%>" placeholder="Masukan Deskripsi Dari Produk">
                    </div>
                </div>

                <div class="row mt-2">
                    <div class="col-2">
                        <span class="cont-text"> Stok Awal </span><br>
                        <input required class="cont-form" type="number" name="stokawal" id="stokawal" value="<%=Produk("pdStokAwal")%>" >
                    </div>
                    <div class="col-4">
                        <span class="cont-text"> Type Part  </span><br>
                        <input required type="text" class=" cont-form" name="typepart" id="typepart" value="<%=Produk("pdTypePart")%>" placeholder="Masukan Part Dari Type Produk">
                    </div>
                    <div class="col-2">
                        <span class="cont-text"> Harga (Rp) </span><br>
                        <input required class=" text-center cont-form" type="number" name="pdharga" id="pdharga" value="<%=Produk("pdHarga")%>" >
                    </div>
                    <div class="col-2 text-start"  style="margin-top:26px;margin-left:-20px">
                        <input  onchange="openkalkulator()" type="checkbox" id="kalkulator">
                        <label class="side-toggle" for="kalkulator"> <span class="fas fa-calculator" style="font-size:17px"> </span></label>
                    </div>
                    <div class="col-2">
                            
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="cont-calculator-PD" id="cont-calculator-PD" >
                            <div class="row">
                                <div class="col-12">
                                    <div class= "formstyle">
                                        <form name = "form1">
                                            <!-- This input box shows the button pressed by the user in calculator. -->
                                            <input id = "calc" type ="text" name = "answer"> <br>
                                            <!-- Display the calculator button on the screen. -->
                                            <!-- onclick() function display the number prsses by the user. -->
                                            <input class="inp-cal mt-3" type = "button" value = "1" onclick = "form1.answer.value += '1' ">
                                            <input class="inp-cal mt-3" type = "button" value = "2" onclick = "form1.answer.value += '2' ">
                                            <input class="inp-cal mt-3" type = "button" value = "3" onclick = "form1.answer.value += '3' ">
                                            <input class="inp-cal mt-3" type = "button" value = "+" onclick = "form1.answer.value += '+' ">
                                            <br>
                                            
                                            <input class="inp-cal" type = "button" value = "4" onclick = "form1.answer.value += '4' ">
                                            <input class="inp-cal" type = "button" value = "5" onclick = "form1.answer.value += '5' ">
                                            <input class="inp-cal" type = "button" value = "6" onclick = "form1.answer.value += '6' ">
                                            <input class="inp-cal" type = "button" value = "-" onclick = "form1.answer.value += '-' ">
                                            <br> 
                                            
                                            <input class="inp-cal" type = "button" value = "7" onclick = "form1.answer.value += '7' ">
                                            <input class="inp-cal" type = "button" value = "8" onclick = "form1.answer.value += '8' ">
                                            <input class="inp-cal" type = "button" value = "9" onclick = "form1.answer.value += '9' ">
                                            <input class="inp-cal" type = "button" value = "*" onclick = "form1.answer.value += '*' ">
                                            <br>
                                            
                                            
                                            <input class="inp-cal" type = "button" value = "/" onclick = "form1.answer.value += '/' ">
                                            <input class="inp-cal" type = "button" value = "0" onclick = "form1.answer.value += '0' ">
                                            <input class="inp-cal" type = "button" value = "." onclick = "form1.answer.value += '.' ">
                                            <!-- When we click on the '=' button, the onclick() shows the sum results on the calculator screen. -->
                                            <input class="inp-cal" type = "button" value = "=" onclick = "aaa(),form1.answer.value = eval(form1.answer.value) ">
                                            <br>
                                            <!-- Display the Cancel button and erase all data entered by the user. -->
                                            <input type = "button" value = "Clear All" onclick = "form1.answer.value = ' ' " id= "clear" >
                                            <br> 
                                            
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-6">
                        <div class="row align-items-center">
                            <span class="label-po cont-text"><b> Kapasitas Produk </b></span>
                            <div class="col-4">
                                <span class="cont-text"> Berat Produk  </span><br>
                                <input required type="text" class=" text-center cont-form" name="beratproduk" id="beratproduk" value="<%=Produk("pdBerat")%>"  placeholder="Masukan Berat Produk"><br>
                            </div>
                            <div class="col-3 me-4 ">
                                <span class="cont-text">  </span><br>
                                <select required  class=" cont-form" name="jenisberat" id="jenisberat" aria-label="Default select example">
                                    <option value="<%=Produk("pdJenisBerat")%>"><%=Produk("pdJenisBerat")%></option>
                                    <option value="Kg">Kg</option>
                                    <option value="Gram">Gram</option>
                                    <option value="Ons">Ons</option>
                                    <option value="Kwintal">Kwintal</option>
                                    <option value="Ton">Ton</option>
                                </select>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <div class="col-4 mt-2">
                                <span class="cont-text"> Panjang <b> (cm) </b> </span><br>
                                <input  onkeyup="nilaivolume()" required type="number" class=" text-center cont-form" name="panjangproduk" id="panjangproduk" value="<%=Produk("pdPanjang")%>" >
                            </div>
                            <div class="col-4 mt-2">
                                <span class="cont-text"> Lebar <b> (cm) </b></span><br>
                                <input  onkeyup="nilaivolume()" required type="number" class=" text-center cont-form" name="lebarproduk" id="lebarproduk" value="<%=Produk("pdLebar")%>" >
                            </div>
                            <div class="col-4 mt-2">
                                <span  class="cont-text"> Tinggi <b> (cm) </b></span><br>
                                <input onkeyup="nilaivolume()" required type="number" class=" text-center cont-form" name="tinggiproduk" id="tinggiproduk" value="<%=Produk("pdTinggi")%>" style="width:9.2rem">
                                <input type="hidden" required class=" cont-form" name="volumeproduk" id="volumeproduk" value="<%=Produk("pdVolume")%>" style="width:11rem"><br>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="row">
                            <span class="label-po cont-text"><b> Penempatan Produk </span>
                            <div class="col-4 ">
                                <span class="cont-text"> Lokasi Rak </span><br>
                                <input required class="cont-form" type="text" name="lokasirak" id="lokasirak" value="<%=Produk("pdLokasi")%>">
                            </div>
                        </div>
                        <div class="row align-items-center mt-3">
                            <div class="col-3 mt-3">
                                <span class="cont-text"> Status Produk </span><br>
                            </div>
                            <div class="col-8 mt-3">
                                <input type="radio" name="statusproduk" id="statusproduk" value="Y" checked>
                                <span class="cont-text me-4"> Aktif </span>
                                <input type="radio" name="statusproduk" id="statusproduk" value="N">
                                <span class="cont-text"> Tidak Aktif </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3 align-items-center">
                    <div class="col-12">
                        <input type="checkbox" name="verified" id="verified" > 
                        <span class="cont-text" for="verified" > Data Produk Telah Diinput Lengkap </span>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-12 text-start">
                        <button class="cont-btn" onclick="updateproduk()" > Simpan Perubahan</button>
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
        function updateproduk(){
            var pdID   = $('input[name=pdID]').val();
            var pdKey   = $('input[name=katakunci]').val();
            var pdNama = $('input[name=namaproduk]').val();
            var pdUnit = $('select[name=unitproduk]').val();
            var pdPartNumber = $('input[name=partnumber]').val();
            var pd_catID = $('select[name=kategori]').val();
            var pd_mrID = $('select[name=merk]').val();
            var pdKondisi = $('select[name=kondisiproduk]').val();
            var pdTypeProduk = $('select[name=typeproduk]').val();
            var pdStokAwal = $('input[name=stokawal]').val();
            var pdTypePart = $('input[name=typepart]').val();
            var pdDesc = $('input[name=deskripsi]').val();
            var pdDropship = $('input[name=dropship]').val();
            var pdHarga = $('input[name=pdharga]').val();
            var pdBerat = $('input[name=beratproduk]').val();
            var pdJenisBerat = $('select[name=jenisberat]').val();
            var pdPanjang = $('input[name=panjangproduk]').val();
            var pdLebar = $('input[name=lebarproduk]').val();
            var pdTinggi = $('input[name=tinggiproduk]').val();
            var pdVolume = $('input[name=volumeproduk]').val();
            var pdLokasi = $('input[name=lokasirak]').val();
            var pdStatus = $('input[name=statusproduk]').val();
            let cek = document.getElementById("verified");
            if (!cek.checked){
                Swal.fire({
                    icon: 'warning',
                    title: 'Oops...',
                    text: ' Apakah Data Produk Telah Diinput Dengan Lengkap ?'
                });
            }else{
                $.ajax({
                    type: "POST",
                    url: "add-produk.asp",
                        data:{
                            pdID,
                            pdKey,
                            pdNama,
                            pdUnit,
                            pdPartNumber,
                            pd_catID,
                            pd_mrID,
                            pdKondisi,
                            pdTypeProduk,
                            pdStokAwal,
                            pdTypePart,
                            pdDesc,
                            pdDropship,
                            pdHarga,
                            pdBerat,
                            pdJenisBerat,
                            pdPanjang,
                            pdLebar,
                            pdTinggi,
                            pdVolume,
                            pdLokasi,
                            pdStatus
                        },
                    success: function (data) {
                        console.log(data);
                        
                        Swal.fire({
                            icon: 'success',
                            title: 'Produk Dengan ID : '+pdID+' Berhasil Diubah'
                            }).then((result) => {
                                window.open(`index.asp`,`_Self`)
                        })
                    }
                });
            }
        }
        function openkalkulator(){
            var btnkal = document.getElementById("kalkulator");
            if(btnkal.checked == true){
                document.getElementById("cont-calculator-PD").style.display = "block";
            }else{
                document.getElementById("cont-calculator-PD").style.display = "none";
            }
        }
        function aaa(){
            var bb = document.getElementById("calc").value;
            var c = Math.round(eval(bb));
                document.getElementById("pdharga").value = eval(c);
        }
    </script>
</html>