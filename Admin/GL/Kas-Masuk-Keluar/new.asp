<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    KasID = request.queryString("X")

    set Kas_Detail_CMD = server.CreateObject("ADODB.command")
    Kas_Detail_CMD.activeConnection = MM_pigo_STRING
    
    Kas_Detail_CMD.commandText = "Select * From GL_T_CashBank_H Where CB_ID = '"& KasID &"' "
    set KasDetail = Kas_Detail_CMD.execute

    Kas_Detail_CMD.commandText = "SELECT GL_M_Item.Item_Cat_ID, GL_M_CategoryItem_PIGO.Cat_Name FROM GL_M_Item LEFT OUTER JOIN GL_M_CategoryItem_PIGO ON GL_M_Item.Item_Cat_ID = GL_M_CategoryItem_PIGO.Cat_ID  Where GL_M_Item.Item_CatTipe = '"& KasDetail("CB_Tipe") &"'GROUP BY GL_M_Item.Item_Cat_ID, GL_M_CategoryItem_PIGO.Cat_Name "
    set KategoriItem = Kas_Detail_CMD.execute


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
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script>
        
        function rincian(){
            document.getElementById("tbbatal").style.display = "block";
            document.getElementById("Tambah-Rincian").style.display = "block";
            document.getElementById("tbtambahrincian").style.display = "none";
        }
        function Batal(){
            let tambah= document.getElementsByClassName("batal");

            document.getElementById("Tambah-Rincian").style.display = "none";
            document.getElementById("tbbatal").style.display = "none";
            document.getElementById("tbtambahrincian").style.display = "block";
        }
        function getKategoriKas(){
            document.getElementById("cont-KategoriKas").style.display = "block"
            document.getElementById("cont-KategoriBiaya").style.display = "none"
            document.getElementById("CBD_Cat_Name").value="";
            document.getElementById("CBD_Cat_ID").value="";

        }
        function getCatName(){
            $.ajax({
                type: "get",
                url: "load-KategoriItem.asp?CATNAME="+document.getElementById("CBD_Cat_Name").value+"&X="+document.getElementById("CBD_ID").value,
                success: function (url) {
                    console.log(url);
                    
                $('.cont-KategoriKas').html(url);
                }
            });
        }
        function getKategoriBiaya(){
            document.getElementById("cont-KategoriKas").style.display = "none"
            document.getElementById("cont-KategoriBiaya").style.display = "block"
            $.ajax({
                type: "get",
                url: "get-KategoriBiaya.asp?CatID="+document.getElementById("CBD_Cat_ID").value,
                success: function (url) {
                    console.log(url);
                    
                $('.cont-KategoriBiaya').html(url);
                }
            });
        }
        function total(){
            var qty = document.getElementById("CBD_Quantity").value;
            var harga = document.getElementById("CBD_Harga").value;
            var total = Number(qty*harga);
            document.getElementById("CB_Total").value = total;
        };
        function tb(){
            
        }
            
    </script>
    <style>
        .cont-KategoriKas{
            background-color:none;
            height:16rem;
            color:black;
            font-weight:bold;
            overflow-y:scroll;
            overflow-x:hidden;
        }
        .cont-KategoriBiaya{
            background-color:none;
            height:16rem;
            color:black;
            font-weight:bold;
            overflow-y:scroll;
            overflow-x:hidden;
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
                    <div class="col-lg-11 col-md-11 col-sm-12">
                        <% if KasDetail("CB_Tipe") = "M" Then %>
                        <span class="cont-judul"> KAS MASUK  </span>
                        <% else %>
                        <span class="cont-judul"> KAS KELUAR </span>
                        <% end if %>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>
            
            <div class="cont-background mt-2 mb-2">
                <div class="row mt-2">
                    <div class="col-2 ">
                        <input type="hidden" name="CBD_ID" id="CBD_ID" value="<%=KasID%>">
                        <span class=" text-right cont-text"> No Jurnal </span>
                    </div>
                    <div class="col-4">
                        <input readonly class="text-center mb-2 cont-form" type="text" name="tgltransaksi" id="tgltransaksi" value="">
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        <span class="cont-text me-4"> Tanggal  </span><br>
                        <input readonly class="text-center mb-2 cont-form" type="text" name="tgltransaksi" id="tgltransaksi" value="<%=Cdate(KasDetail("CB_Tanggal"))%>">
                    </div>
                    <div class="col-2">
                        <span class="cont-text me-4"> Pembuat </span><br>
                        <input readonly class=" mb-2 cont-form" type="text" name="updateid" id="updateid" value="<%=KasDetail("CB_Pembuat")%>">
                    </div>
                    <div class="col-2">
                        <span class="cont-text me-4"> Jenis Transaksi </span><br>
                        <% if KasDetail("CB_Tipe") = "M" Then %>
                        <input readonly class=" mb-2 cont-form" type="text" name="updateid" id="updateid" value="Kas Masuk" >
                        <% else %>
                        <input readonly class=" mb-2 cont-form" type="text" name="updateid" id="updateid" value="Kas Keluar" >
                        <% end if %>
                    </div>
                    <div class="col-6" id="tbtambahrincian">
                        <span class="cont-text me-4"> Keterangan Transaksi </span><br>
                        <input readonly class=" mb-2 cont-form" type="text" name="CatID" id="CatID" value="<%=KasDetail("CB_Keterangan")%>" >
                    </div>
                </div>
            </div>
            <div class="cont-background mt-2">
                <div id="Tambah-Rincian" style="display:block">
                    <div class="row">
                        <div class="col-6">
                            <div class="row cont-CATITEM">
                                <div class="col-4 text-center">
                                    <span class=" text-center cont-text"> ID Kategori Transaksi</span><br>
                                    <input readonly onfocus="getKategoriKas()" class=" mb-2 cont-form" type="text" name="CBD_Cat_ID" id="CBD_Cat_ID" value="">
                                </div>
                                <div class="col-8">
                                    <span class="cont-text"> Kategori Transaksi</span><br>
                                    <input onfocus="getKategoriKas()"  onkeyup="getCatName()" class=" mb-2 cont-form" type="text" name="CBD_Cat_Name" id="CBD_Cat_Name" value="" >
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="row cont-CATBIAYA">
                                <div class="col-4 text-center">
                                    <span class="cont-text"> ID Biaya Transaksi </span><br>
                                    <input readonly onfocus="getKategoriBiaya()" class="text-center mb-2 cont-form" type="text" name="CBD_Item_ID" id="CBD_Item_ID" value="">
                                </div>
                                <div class="col-8">
                                    <span class="cont-text"> Nama Biaya Transaksi </span><br>
                                    <input onfocus="getKategoriBiaya()" class=" mb-2 cont-form" type="text" name="CBD_Item_Name" id="CBD_Item_Name" value="" >
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row text-center mb-3">
                        <div class="col-6 " id="">
                            <div class="cont-KategoriKas" id="cont-KategoriKas" style="display:none">
                                <table class="align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px;">
                                <% 
                                    no = 0
                                    do while not KategoriItem.eof 
                                    no = no + 1
                                %>
                                    <tr>
                                        <td class="text-center"><Input onclick="getCatItem<%=no%>()" class=" text-center cont-form"type="text" name="CatID" id="CatID<%=no%>" Value="<%=KategoriItem("Item_Cat_ID")%>"  style="width:8rem;border:none"></td>
                                        <td><Input onclick="getCatItem<%=no%>()" class="cont-form"type="text" name="CatID" id="CatID" Value="<%=KategoriItem("Cat_Name")%>" style="width:19rem;border:none"> </td>
                                    </tr>
                                    <script>
                                        function getCatItem<%=no%>(){
                                            $.ajax({
                                                type: "get",
                                                url: "get-KategoriItem.asp?CATID="+document.getElementById("CatID<%=no%>").value,
                                                success: function (url) {
                                                $('.cont-CATITEM').html(url);
                                                }
                                            });
                                            document.getElementById("cont-KategoriKas").style.display = "none"
                                        }
                                    </script>
                                <% KategoriItem.Movenext
                                loop %>
                                </table>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="cont-KategoriBiaya" id="cont-KategoriBiaya" style="display:none"> 
                                
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6 cont-Keterangan">
                            <span class="cont-text me-4"> Keterangan </span><br>
                            <input class=" mb-2 cont-form" type="text" name="CBD_Keterangan" id="CBD_Keterangan" value="" >
                        </div>
                        <div class="col-3">
                            <span class="cont-text me-4"> QTY </span><br>
                            <input class=" mb-2 cont-form" type="Number" name="CBD_Quantity" id="CBD_Quantity" value="1" >
                        </div>
                        <div class="col-3">
                            <span class="cont-text me-4"> Harga </span><br>
                            <input onkeyup="total()" class=" mb-2 cont-form" type="Number" name="CBD_Harga" id="CBD_Harga" value="">
                        </div>
                    </div>

                    <div class="row align-item-center mt-1 ">
                        <div class="col-12">
                            <input type="hidden" name="CB_Total" id="CB_Total" value="">
                            <div class="form-check align-item-center">
                                <input class="form-check-input" name="cktb" id="cktb" type="checkbox" value="" id="flexCheckDefault">
                                <label class=" cont-text form-check-label" for="flexCheckDefault">
                                    Konfirmasi Data
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="row align-items-center mt-2">
                        <div class="col-10">
                            <div class="row mt-2">
                                <div class="col-2">
                                    <span class="cont-text">Terbilang</span><br>
                                </div>
                                <div class="col-10 p-0" style="border-bottom: 1px dotted black;">
                                    <span class="cont-text"> : </span>  &nbsp;&nbsp;  <b><span class="as-output-text cont-text"></span></b>
                                    <b><span class=" cont-text">Rupiah</span></b>
                                </div>
                            </div>
                        </div>
                        <div class="col-2">
                            <button onclick="addkas()" class="cont-btn"> Tambah Rincian </button>
                        </div>
                    </div>

                    <div class="row mt-2 mb-3">
                        <div class="col-12 cont-RincianKas">

                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-2">
                            <button class="cont-btn"> Posting </button>
                        </div>
                        <div class="col-2">
                            <Button class="cont-btn" > Cetak </button>
                        </div>
                        <div class="col-2">
                            <Button onclick="window.open('Index.asp','_Self')" class="cont-btn" > Selesai </button>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-12">
                        </div>
                    </div>
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

        function addkas(){
            var CBD_ID         = document.getElementById("CBD_ID").value;
            var CBD_Cat_ID     = document.getElementById("CBD_Cat_ID").value;
            var CBD_Item_ID    = document.getElementById("CBD_Item_ID").value;
            var CBD_Keterangan = document.getElementById("CBD_Keterangan").value;
            var CBD_Quantity   = document.getElementById("CBD_Quantity").value;
            var CBD_Harga      = document.getElementById("CBD_Harga").value;
            var cktb = document.getElementById("cktb");
            if (!cktb.checked){
                alert("CK!")
            } else{
                $(".test").terbilang();
                $(".as-output-text").terbilang({
                    nominal: document.getElementById("CBD_Harga").value,
                    output: 'text'
                });
                setTimeout(function(){
                    $.ajax({
                        type: "GET",
                        url: "add-CashBankD.asp",
                        data: {
                            CBD_ID,
                            CBD_Cat_ID,
                            CBD_Item_ID,
                            CBD_Keterangan,
                            CBD_Quantity,
                            CBD_Harga
                        },
                        success: function (data) {
                            $('.cont-RincianKas').html(data);
                            // Swal.fire('Data Berhasil Di Perbaharui ', data.message, 'then(() => {
                            //     location.reload();
                            // });
                        }
                        
                    });
                        document.getElementById("CBD_Cat_ID").value = "";
                        document.getElementById("CBD_Item_ID").value = "";
                        document.getElementById("CBD_Keterangan").value = "";
                        document.getElementById("CBD_Quantity").value = "1";
                        document.getElementById("CBD_Harga").value = "" ;
                        document.getElementById("CBD_Cat_Name").value = "" ;
                        document.getElementById("CBD_Item_Name").value = "" ;
                        document.getElementById("CB_Total").value = "" ;
                        $('#cktb').prop('checked', false);
                        }, 2000);
            }
        }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>