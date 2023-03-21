<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if
    
    set GL_M_Item_cmd = server.createObject("ADODB.COMMAND")
	GL_M_Item_cmd.activeConnection = MM_PIGO_String
        GL_M_Item_cmd.commandText = "SELECT GL_M_Item.Item_ID, GL_M_Item.Item_Cat_ID, GL_M_Item.Item_Tipe, GL_M_Item.Item_Name, GL_M_Item.Item_Status, GL_M_Item.Item_CAIDD, GL_M_Item.Item_CAIDK, GL_M_Item.Item_UpdateID,  CAST(GL_M_Item.Item_UpdateTime AS DATE) AS Tanggal, GL_M_Item.Item_AktifYN, CANameD.CA_Name AS CANameD, CANameK.CA_Name AS CANameK, GL_M_Item.Item_CatTipe, GL_M_CategoryItem_PIGO.Cat_Name FROM GL_M_ChartAccount AS CANameK RIGHT OUTER JOIN GL_M_CategoryItem_PIGO RIGHT OUTER JOIN GL_M_Item ON GL_M_CategoryItem_PIGO.Cat_ID = GL_M_Item.Item_Cat_ID ON CANameK.CA_ID = GL_M_Item.Item_CAIDK LEFT OUTER JOIN GL_M_ChartAccount AS CANameD ON GL_M_Item.Item_CAIDD = CANameD.CA_ID "
    set ItemList = GL_M_Item_cmd.execute

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
        set ACCID = GL_M_ChartAccount_cmd.execute
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
        set ACCIK = GL_M_ChartAccount_cmd.execute
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
        set CAID = GL_M_ChartAccount_cmd.execute
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
        set CAIK = GL_M_ChartAccount_cmd.execute


    set GL_M_CategoryItem_cmd = server.createObject("ADODB.COMMAND")
	GL_M_CategoryItem_cmd.activeConnection = MM_PIGO_String
        GL_M_CategoryItem_cmd.commandText = "SELECT Cat_ID, Cat_Name FROM GL_M_CategoryItem WHERE Cat_AktifYN = 'Y' "
        set CategoryItem = GL_M_CategoryItem_cmd.execute
        GL_M_CategoryItem_cmd.commandText = "SELECT Cat_ID, Cat_Name FROM GL_M_CategoryItem_PIGO WHERE Cat_AktifYN = 'Y' "
    set CatItem = GL_M_CategoryItem_cmd.execute


%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>OFFICIAL PIGO</title>
        <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        <script>
            function Tambah(){
                let pem= document.getElementsByClassName("tambah-list");

                document.getElementById("GL-LIST-KAS").style.display = "none";
                document.getElementById("ADD-GL-LIST-KAS").style.display = "block";
                document.getElementById("btn-add").style.display = "none";
                document.getElementById("btn-cancle").style.display = "block";
                document.getElementById("btn-refresh").style.display = "none";

            } 
            function getSubKategori(){
                $.ajax({
                    type: "get",
                    url: "get-SubKategori.asp?Cat_ID="+document.getElementById("Cat_ID").value+"&Item_Status="+document.getElementById("StatusListItem").value+"&Item_Name="+document.getElementById("NameItem").value,
                    success: function (url) {
                        console.log(url);
                    $('.DataListItem').html(url);
                    }
                });
            }
            function selectcont(){
                var cash = document.getElementById("Item_Tipe").value;
                if( cash == "C"){
                    document.getElementById("cont-cash").style.display = "block";
                    document.getElementById("cont-tipe").style.display = "none";
                    document.getElementById("cont-bank").style.display = "none"
                } else if( cash == "B"){
                    document.getElementById("cont-bank").style.display = "block"
                    document.getElementById("cont-tipe").style.display = "none";
                    document.getElementById("cont-cash").style.display = "none";
                }else{
                    document.getElementById("cont-memo").style.display = "block"
                    document.getElementById("cont-bank").style.display = "none"
                    document.getElementById("cont-tipe").style.display = "none";
                    document.getElementById("cont-cash").style.display = "none";
                }
            } 
            function Update(){
                document.getElementById("Update-GL-Cont").style.display = "Block";
                document.getElementById("Cont-Update-GL").style.display = "none";
            } 
            function GetKode(){
                document.getElementById("ACIDADD").style.display = "block";
                document.getElementById("ACIDADK").style.display = "none";
                document.getElementById("CA_ID").value="";
                document.getElementById("CA_Name").value="";
            }
            function GetKodeK(){
                document.getElementById("ACIDADK").style.display = "block";
                document.getElementById("ACIDADD").style.display = "none";
                document.getElementById("CA_IK").value="";
                document.getElementById("CA_NameK").value="";
            }
            function Refresh(){
                location.reload();
            }
            function getCaName(){
                $.ajax({
                    type: "get",
                    url: "get-CA_Name.asp?CA_ID="+document.getElementById("CA_ID").value+"&CA_Name="+document.getElementById("CA_Name").value,
                    success: function (url) {
                    $('.ACCCANAME').html(url);
                    }
                });
            }
            function getCaNameK(){
                $.ajax({
                    type: "get",
                    url: "get-CK_Name.asp?CA_IK="+document.getElementById("CA_IK").value+"&CA_NameK="+document.getElementById("CA_NameK").value,
                    success: function (url) {                    
                    $('.ACCCANAMEK').html(url);
                    }
                });
            }
            function getCATID(){
                $.ajax({
                    type: "get",
                    url: "get-CATID.asp?CATName="+document.getElementById("CATName").value,
                    success: function (url) {
                    $('.SUBCatID').html(url);
                                        
                    }
                });
            }
            function getCatItem(){
                $.ajax({
                    type: "get",
                    url: "get-CatItem.asp?Item_CatTipe="+document.getElementById("Item_CatTipe").value+"&Item_CatTipee="+document.getElementById("Item_CatTipee").value,
                    success: function (url) {
                        $('.cont-CatItem').html(url);
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
                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <span class="cont-text"> DAFTAR PEMASUKAN DAN PENGELUARAN  </span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button class="cont-btn"name="btn-refresh" id="btn-refresh" onclick="return Refresh()" type="button" style="display:block" >  <i class="fas fa-sync"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12">
                        <button class="tambah-list cont-btn" name="btn-add" id="btn-add" onclick="return Tambah()" type="button" style="display:block"> Tambah  </button>
                        <button class="tambah-list cont-btn" name="btn-cancle" id="btn-cancle" onclick="return Refresh()" type="button" style="display:none"> Batal  </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <!-- ADD-GL-LIST-KAS -->
                <div class="ADD-GL-LIST-KAS" id="ADD-GL-LIST-KAS" style="display:none">
                    <form class="GL-List-Item" method="POST" action="P-GL-Item.asp">
                        <div class="row mt-2 align-items-center">
                            <div class="col-lg-4 col-md-4 col-sm-4">
                                <span class="cont-text"> Tipe Item </span><br>
                                <select onchange="selectcont()"  class="  cont-form" name="Item_Tipe" id="Item_Tipe" aria-label="Default select example">
                                    <option selected>Pilih</option>
                                    <option value="C"> CASH </option>
                                    <option value="B"> BANK </option>
                                    <option value="M"> Memorial </option>
                                </select>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4" id="cont-tipe">
                                <span class="cont-text"> Kategori </span><br>
                                <select  class="  cont-form" name="" id="" aria-label="Default select example">
                                    <option selected>Pilih</option>
                                </select>
                            </div>
                            
                            <div class="col-lg-4 col-md-4 col-sm-4" id="cont-cash" style="display:none">
                                <span class="cont-text"> Tipe Kategori </span><br>
                                <select onchange="getCatItem()"  class="  cont-form" name="Item_CatTipe" id="Item_CatTipe" aria-label="Default select example">
                                    <option value="">Pilih</option>
                                    <option value="T"> CASH Masuk</option>
                                    <option value="K"> CASH Keluar </option>
                                </select>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4" id="cont-bank" style="display:none">
                                <span class="cont-text"> Tipe Kategori </span><br>
                                <select onchange="getCatItem()"  class="  cont-form" name="Item_CatTipee" id="Item_CatTipee" aria-label="Default select example">
                                    <option value="">Pilih</option>
                                    <option value="T"> BANK Masuk </option>
                                    <option value="K"> BANK Keluar </option>
                                </select>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 cont-CatItem" id="cont-CatItem">
                                <span class="cont-text"> Sub Kategori </span><br>
                                <select class="  cont-form" aria-label="Default select example">
                                    <option selected>Pilih</option>
                                </select>
                            </div>
                        </div>

                        <div class="row align-items-center">
                            <div class="col-lg-8 col-md-6 col-sm-6">
                                <span class="cont-text"> Nama </span><br>
                                <input type="text"  class="  cont-form" name="Item_Name" id="Item_Name" value="">
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <span class="cont-text"> Status </span><br>
                                <div class="row align-items-center">
                                    <div class="col-6">
                                        <div class=" form-check">
                                            <input class="form-check-input" type="radio" name="Item_Status" id="Item_Status" value="A">
                                            <label class=" cont-text form-check-label" for="flexRadioDefault1">
                                                Aktiva Tetap
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-check">
                                            <input class=" form-check-input" type="radio" name="Item_Status" id="Item_Status" Value="L">
                                            <label class=" cont-text form-check-label" for="flexRadioDefault1">
                                                Lain Lain
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <hr>

                        <div class="cont-acc" style="height:21rem">
                            <div class="row mt-2 align-items-center CONTACCID">
                                <div class="col-lg-4 col-md-4 col-sm-4">
                                    <span class="cont-text"> No ACC (Debet)</span><br>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3">
                                    <input type="text" onclick="GetKode()" onkeyup="getCaName()"  name="CA_ID" id="CA_ID"  class="  cont-form" value="">
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-5 CAName">
                                    <input type="text" onclick="GetKode()" onkeyup="getCaName()"  name="CA_Name" id="CA_Name"  class="  cont-form" value="">
                                </div>
                            </div>

                            <div class="ADDACC_ID" id="ACIDADD" style="display:none">
                                <div class="row align-items-center ACCID">
                                    <div class="col-4">
                                    </div>
                                    <div class="col-8">
                                        <div class="ACCID" style="background-color:white; height:10rem; overflow-y:scroll; overflow-x:hidden; padding:3px 10px">
                                            <div class="row ACCCANAME">
                                                <div class="col-12">
                                                    <table class=" table tb-transaksi table-bordered table-condensed p-0">
                                                    <% 
                                                        no = 0 
                                                        do while not ACCID.eof 
                                                        no = no+1
                                                    %>
                                                        <tr>
                                                            <td class="text-center" style="width:25%;"> <input readonly onclick="getACCID<%=no%>()"class=" cont-form text-center"type="text" name="ACC_ACID" id="ACC_ACID<%=no%>" value="<%=ACCID("CA_ID")%>" style="width:100%; border:none"> </td>
                                                            <td> <input readonly class="cont-form"onclick="getACCID<%=no%>()"type="text" name="CA_Name" id="CA_Name" value="<%=ACCID("CA_Name")%>" style="width:100%; border:none"> </td>
                                                        </tr>
                                                        <script>
                                                            function getACCID<%=no%>(){
                                                            var accid = document.getElementById("ACC_ACID<%=no%>").value;
                                                            $.ajax({
                                                                type: "get",
                                                                url: "get-ACCID.asp?ACC_ACID="+document.getElementById("ACC_ACID<%=no%>").value,
                                                                success: function (url) {
                                                                $('.CONTACCID').html(url);
                                                                }
                                                            });
                                                            document.getElementById("ACIDADD").style.display = "none";
                                                        }
                                                        </script>
                                                        <% ACCID.movenext
                                                        loop %>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-2 align-items-center CONTACCIK">
                                <div class="col-lg-4 col-md-4 col-sm-4">
                                    <span class="cont-text"> No ACC CASH / BANK  (Kredit)</span><br>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3">
                                    <input type="text" onclick="GetKodeK()" onkeyup="getCaNameK()"  name="CA_IK" id="CA_IK"  class="  cont-form" value="">
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-5 CANameK">
                                    <input type="text" onclick="GetKodeK()" onkeyup="getCaNameK()"  name="CA_NameK" id="CA_NameK"  class="  cont-form" value="">
                                </div>
                            </div>

                            <div class="ADDACC_IK" id="ACIDADK" style="display:none">
                                <div class="row align-items-center ACCIK">
                                    <div class="col-4">
                                    </div>
                                    <div class="col-8">
                                        <div class="ACCIK" style="background-color:white; height:10rem; overflow-y:scroll; overflow-x:hidden; padding:3px 10px">
                                            <div class="row ACCCANAMEK">
                                                <div class="col-12">
                                                    <table class=" table tb-transaksi table-bordered table-condensed p-0">
                                                    <% 
                                                        no = 0 
                                                        do while not ACCIK.eof 
                                                        no = no+1
                                                    %>
                                                        <tr>
                                                            <td class="text-center" style="width:25%;"> <input readonly onclick="getACCIK<%=no%>()"class="cont-form text-center"type="text" name="ACC_ACIK" id="ACC_ACIK<%=no%>" value="<%=ACCIK("CA_ID")%>" style="width:100%; border:none"> </td>
                                                            <td> <input readonly class="cont-form"onclick="getACCIK<%=no%>()"type="text" name="CA_Name" id="CA_Name" value="<%=ACCIK("CA_Name")%>" style="width:100%; border:none"> </td>
                                                        </tr>
                                                        <script>
                                                            function getACCIK<%=no%>(){
                                                            var accid = document.getElementById("ACC_ACID<%=no%>").value;
                                                            $.ajax({
                                                                type: "get",
                                                                url: "get-ACCIK.asp?ACC_ACID="+document.getElementById("ACC_ACIK<%=no%>").value,
                                                                success: function (url) {
                                                                $('.CONTACCIK').html(url);
                                                                }
                                                            });
                                                            document.getElementById("ACIDADK").style.display = "none";
                                                        }
                                                        </script>
                                                        <% ACCIK.movenext
                                                        loop %>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--<div class="row mt-2 align-items-center">
                                <div class="col-4">
                                    <span class="cont-text"> No ACC Cash / Bank (Kredit)</span><br>
                                </div>
                                <div class="col-3">
                                    <select  onchange="getCaName()" class="  cont-form" name="CA_Kelompok" id="CA_Kelompok" aria-label="Default select example">
                                        <option selected>Pilih Kode ACC Cash / Bank </option>
                                        <%' do while not CA_Kel2.eof %>
                                        <option value="<%'=CA_Kel2("CA_Kelompok")%>"> <%'=CA_Kel2("CA_Kelompok")%></option>
                                        <%' CA_Kel2.movenext
                                        'loop %>
                                    </select>
                                    <input type="text" name="input-name"  class=" input-name  cont-form" value="">
                                </div>
                                <div class="col-5 CANameII">
                                <select  class="  cont-form" name="kategori" id="kategori" aria-label="Default select example">
                                        <option selected>Pilih </option>
                                        <option value="Kas Masuk"> Kas Masuk </option>
                                        <option value="Kas Keluar"> Kas Keluar </option>
                                        <option value="Memorial"> Memorial </option>
                                    </select><br>
                                    <input type="text"  class="  cont-form" value="">
                                </div>
                            </div>
                            <div class="row mt-2 align-items-center">
                                <div class="col-4">
                                    <span class="cont-text"> No ACC Biaya </span><br>
                                </div>
                                <div class="col-3">
                                    <select  class="  cont-form" name="kategori" id="kategori" aria-label="Default select example">
                                        <option selected>Pilih No ACC Biaya </option>
                                        <option value="Kas Masuk"> Kas Masuk </option>
                                        <option value="Kas Keluar"> Kas Keluar </option>
                                        <option value="Memorial"> Memorial </option>
                                    </select><br>
                                    <input type="text"  class="  cont-form" value="">
                                </div>
                                <div class="col-5">
                                    <select  class="  cont-form" name="kategori" id="kategori" aria-label="Default select example">
                                        <option selected>Pilih </option>
                                        <option value="Kas Masuk"> Kas Masuk </option>
                                        <option value="Kas Keluar"> Kas Keluar </option>
                                        <option value="Memorial"> Memorial </option>
                                    </select><br>
                                    <input type="text"  class="  cont-form" value="">
                                </div>
                            </div>
                            <div class="row mt-2 align-items-center">
                                <div class="col-4 mt-2">
                                    <span class="cont-text"> Batas Penyusutan </span><br>
                                    <input type="text"  class="  cont-form" value="">
                                </div>
                                <div class="col-4 mt-2">
                                    <span class="cont-text"> Lama Penyusutan </span><br>
                                    <input type="text"  class="  cont-form" value="">
                                </div>
                        </div>-->
                        <div class=" mt-4  row align-items-center">
                            <div class="col-2">
                                <input type="submit" class="cont-btn" value="Simpan">
                            </div>
                        </div>
                    </form>
                </div>
                <!-- ADD-GL-LIST-KAS -->

                <!-- GL-LIST-KAS -->
                <div class="GL-LIST-KAS" id="GL-LIST-KAS">
                    <div class="row">
                        <div class="col-12">
                            <div class="GL-List">
                                <div class="row align-items-center">
                                    <div class="col-lg-5 col-md-8 col-sm-12">
                                        <span class="cont-text"> SUB Kategori </span><br>
                                        <select  onchange="getSubKategori()"  class=" mb-2 cont-form" name="Cat_ID" id="Cat_ID" aria-label="Default select example">
                                        <%
                                            do while not CatItem.eof 
                                        %>
                                            <option value="<%=CatItem("Cat_ID")%>"><%=CatItem("Cat_ID")%>&nbsp;-&nbsp;<%=CatItem("Cat_Name")%></option>
                                        <%
                                            CatItem.movenext
                                            loop
                                        %>
                                        </select>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <span class="cont-text"> Status </span><br>
                                        <select  onchange="getSubKategori()"  class=" mb-2 cont-form" name="StatusListItem" id="StatusListItem" aria-label="Default select example">
                                            <option value="">Pilih</option>
                                            <option value="A">Aktiva Tetap</option>
                                            <option value="L">Lain-Lain</option>
                                        </select>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <span class="cont-text">Keterangan </span><br>
                                        <input  onkeyup="getSubKategori()" type="text"  class="  cont-form" value="" placeholder="Masukan Nama/Keterangan" name="NameItem" id="NameItem">
                                    </div>
                                    <div class="col-lg-1 col-md-12 col-sm-12">
                                        <span class="cont-text">  </span><br>
                                        <button class=" cont-btn txt-desc "  onclick="return SearchListItem()" type="button" ><i class="fas fa-search"></i> </button>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="GL-List mt-4" style="height:30rem; overflow:scroll;">
                                <div class="row align-items-center">
                                    <div class="col-12">
                                        <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:13px; border: 1px solid black; width:80rem">
                                            <thead>
                                                <tr class="text-center">
                                                    <th>KODE</th>
                                                    <th>KATEGORI</th>
                                                    <th>NAMA</th>
                                                    <th>TIPE</th>
                                                    <th>STATUS</th>
                                                    <th>ACC IDD</th>
                                                    <th>ACC IDK</th>
                                                    <th colspan="2">UPDATE ID</th>
                                                    <th>KET</th>
                                                </tr>
                                            </thead>
                                            <tbody class="DataListItem" id="DataListItem">
                                            <% do while not ItemList.eof %>
                                                <tr>
                                                    <td class="text-center"><input id="myBtn<%=ItemList("Item_ID")%>" class="text-center cont-form" readonly type="text" name="kodeitem" id="kodeitem" value="<%=ItemList("Item_ID")%>" style="border:none;width:9.2rem"></td>
                                                    <td class="text-center">
                                                        <%=ItemList("Cat_Name")%>
                                                    </td>
                                                    <td><%=ItemList("Item_Name")%></td>

                                                        <% if ItemList("Item_Tipe") = "C" then %>
                                                        <td class="text-center"> CASH </td>
                                                        <% else %>
                                                        <td class="text-center"> BANK </td>
                                                        <% end if %>

                                                        <% if ItemList("Item_Status") = "L" then %>
                                                        <td class="text-center">Lain-Lain</td>
                                                        <% else %>
                                                        <td class="text-center">Aktiva Tetap</td>
                                                        <% end if %>
                                                        
                                                    <td class="text-center"><%=ItemList("Item_CAIDD")%></td>
                                                    <td class="text-center"><%=ItemList("Item_CAIDK")%></td>
                                                    <td class="text-center"><%=ItemList("Item_UpdateID")%></td>
                                                    <td class="text-center"><%=ItemList("Tanggal")%></td>
                                                    <% if ItemList("Item_AktifYN") = "Y" then %>
                                                    <td class="text-center"> Aktif </td>
                                                    <% else %>
                                                    <td class="text-center"> Tidak Aktif </td>
                                                    <% end if %>
                                                </tr>
                                                <!-- Modal -->
                                                <div id="myModal<%=ItemList("Item_ID")%>" class="modal-GL">
                                                <!-- Modal content -->
                                                    <div class="modal-content-GL">
                                                        <div class="modal-body-GL">
                                                            <div class="row mt-3">
                                                                <div class="col-11">
                                                                    <span class="cont-text">Kode Item : <input class="    text-center cont-text"type="text" name="ItemID" id="ItemID<%=ItemList("Item_ID")%>" Value="<%=ItemList("Item_ID")%>" style="border:none"> </span>
                                                                </div>
                                                                <div class="col-1">
                                                                    <span><i class="fas fa-times closee<%=ItemList("Item_ID")%>"></i></span>
                                                                </div>
                                                            </div>
                                                            <hr style="p-0">
                                                            <div class="body" style="padding:5px 20px">
                                                                <div class="row align-items-center " id="Cont-Update-GL<%=ItemList("Item_ID")%>" >
                                                                    <div class="col-12">
                                                                        <% if ItemList("Item_AktifYN") = "Y" then %>
                                                                        <div class="row d-flex justify-content-center text-center">
                                                                            <div class="col-5 me-2 gl-update">
                                                                                <span onclick="Update<%=ItemList("Item_ID")%>()"class="" style="font-size:25px"> <i class="fas fa-edit"></i> </span><br>
                                                                                <span onclick="Update<%=ItemList("Item_ID")%>()"class="cont-text"> Buat Perubahan Pada Item </span>
                                                                            </div>
                                                                            <div class="col-5 gl-update">
                                                                                <span onclick="Delete<%=ItemList("Item_ID")%>()"class="" style="font-size:25px"> <i class="fas fa-toggle-off"></i> </span><br>
                                                                                <span onclick="Delete<%=ItemList("Item_ID")%>()"class="cont-text"> Hapus Atau Non Aktifkan Item </span>
                                                                            </div>
                                                                        </div>
                                                                        <% else %>
                                                                        <div class="row d-flex justify-content-center text-center">
                                                                            <div class="col-5 me-2 gl-update">
                                                                                <span class="" style="font-size:25px"> <i class="fas fa-edit"></i> </span><br>
                                                                                <span class="cont-text"> Tidak Dapat Melakukan Perubahan </span>
                                                                            </div>
                                                                            <div class="col-5 gl-update">
                                                                                <span onclick="Delete<%=ItemList("Item_ID")%>()"class="" style="font-size:25px"> <i class="fas fa-toggle-on"></i> </span><br>
                                                                                <span onclick="Delete<%=ItemList("Item_ID")%>()"class="cont-text"> Aktifkan Item </span>
                                                                            </div>
                                                                        </div>
                                                                        <% end if %>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="Update-GL-Cont" id="Update-GL-Cont<%=ItemList("Item_ID")%>" style="display:none;">
                                                                    <div class="row   text-center">
                                                                        <div class="col-12">
                                                                            <span class="cont-text"> Edit Data Pemasukan dan Pengeluaran </span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row ">
                                                                        <div class="col-12">
                                                                            <span class="cont-text "> Kode Item </span><br>
                                                                            <input readonly disabled="true" type="text"   class="  cont-form" name="updItemID" id="updItemID<%=ItemList("Item_ID")%>" value="<%=ItemList("Item_ID")%>">
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-12">
                                                                            <span class="cont-text "> Tipe Item </span><br>
                                                                            <% if ItemList("Item_Tipe") = "C" then %>
                                                                            <input readonly type="hidden" class="cont-form" name="updItemTipe" id="updItemTipe<%=ItemList("Item_ID")%>" value="<%=ItemList("Item_Tipe")%>">
                                                                            <input readonly type="text" class="cont-form" name="updItemTipe" id="updItemTipe<%=ItemList("Item_ID")%>" value="CASH">
                                                                            <% else %>
                                                                            <input readonly type="hidden" class="cont-form" name="updItemTipe" id="updItemTipe<%=ItemList("Item_ID")%>" value="<%=ItemList("Item_Tipe")%>">
                                                                            <input readonly type="text"   class="  cont-form" name="updItemTipe" id="updItemTipe<%=ItemList("Item_ID")%>" value="BANK">
                                                                            <% end if %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-12">
                                                                            <span class=" cont-text"> Kategori </span><br>
                                                                            <input readonly  type="text"   class="  cont-form" name="updCatItemID" id="updCatItemID<%=ItemList("Item_ID")%>" value="<%=ItemList("Item_CatTipe")%>">
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-12">
                                                                            <span class=" cont-text">SUB Kategori </span><br>
                                                                            <select   class="   cont-form" name="updCatItem" id="updCatItem<%=ItemList("Item_ID")%>" aria-label="Default select example">
                                                                                <option value="<%=ItemList("Item_Cat_ID")%>"> <%=ItemList("Cat_Name")%> </option>
                                                                                <% do while not CatItem.eof %>
                                                                                <option value="<%=CatItem("Cat_ID")%>"> <%=CatItem("Cat_Name")%> </option>
                                                                                <% CatItem.movenext
                                                                                loop %>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-12">
                                                                            <span class=" cont-text"> Nama </span><br>
                                                                            <input type="text"   class="   cont-form" name="updNameItem" id="updNameItem<%=ItemList("Item_ID")%>" value="<%=ItemList("Item_Name")%> ">
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-12">
                                                                            <span class=" cont-text"> Status </span><br>
                                                                            <select   class="   cont-form" name="updStatusItem" id="updStatusItem<%=ItemList("Item_ID")%>" aria-label="Default select example">
                                                                                <% if ItemList("Item_Status") = "A" Then  %>
                                                                                <option value="<%=ItemList("Item_Status")%>"> Aktiva Tetap </option>
                                                                                <% else %>
                                                                                <option value="<%=ItemList("Item_Status")%>"> Lain-Lain </option>
                                                                                <% end if %>
                                                                                <option value="A"> Aktiva Tetap </option>
                                                                                <option value="L"> Lain-Lain </option>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-1">
                                                                        <div class="col-12">
                                                                            <span class=" cont-text"> No ACC ( Debet ) </span><br>
                                                                            <div class="row Upd-LISTACID">
                                                                                <div class="col-4">
                                                                                    <input onclick="OpenD()"  onkeyup="getListACID()" type="text"   class="   cont-form" name="ACID" id="ACID" value="<%=ItemList("Item_CAIDD")%>">
                                                                                </div>
                                                                                <div class="col-8">
                                                                                    <input onclick="OpenD()"  onkeyup="getListACID()" type="text"   class="   cont-form" name="NameACID" id="NameACID" value="<%=ItemList("CANameD")%>">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 Table-List-ACID " name="Table-List-ACID" id="cont-up-d" style="display:none; background-color:#aaa; height:10rem; overflow:scroll">
                                                                        <div class="col-12">
                                                                        <% 
                                                                            no = 0 
                                                                            do while not CAID.eof 
                                                                            no = no + 1
                                                                        %>
                                                                            <div class="row ">
                                                                                <div class="col-4">
                                                                                    <input readonly onclick="getDataACID<%=no%>()" type="text"   class="text-center mb-1  cont-form" name="AC_ID" id="AC_ID<%=no%>" value="<%=CAID("CA_ID")%>">
                                                                                </div>
                                                                                <div class="col-8">
                                                                                    <input readonly onclick="getDataACID<%=no%>()" type="text"   class="cont-form mb-1 " name="ACC_Name" id="ACC_Name<%=no%>" value="<%=CAID("CA_Name")%>">
                                                                                </div>
                                                                            </div>
                                                                            <script>
                                                                                function getDataACID<%=no%>(){
                                                                                    $.ajax({
                                                                                        type: "get",
                                                                                        url: "Update-GL/upd-ACIDD.asp?AC_ID="+document.getElementById("AC_ID<%=no%>").value+"&ItemID="+document.getElementById("ItemID<%=ItemList("Item_ID")%>").value,
                                                                                        success: function (url) {
                                                                                        $('.Upd-LISTACIK').html(url);
                                                                                        document.getElementById("cont-up-d").style.display = "none";
                                                                                        }
                                                                                    });
                                                                                }
                                                                            </script>
                                                                        <% CAID.movenext
                                                                        loop %>
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-1">
                                                                        <div class="col-12">
                                                                            <span class=" cont-text"> No ACC CASH/BANK ( Kredit ) </span><br>
                                                                            <div class="row Upd-LISTACIK">
                                                                                <div class="col-4">
                                                                                    <input onclick="OpenK()"  onkeyup="getListACIK()" type="text"   class="   cont-form" name="ACIK" id="ACIK" value="<%=ItemList("Item_CAIDK")%>">
                                                                                </div>
                                                                                <div class="col-8">
                                                                                    <input onclick="OpenK()"  onkeyup="getListACIK()" type="text"   class="   cont-form" name="NameACIK" id="NameACIK" value="<%=ItemList("CANameK")%>">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 Table-List-ACIK " name="Table-List-ACID" id="cont-up-k" style="display:none; background-color:#aaa; height:10rem; overflow:scroll">
                                                                        <div class="col-12">
                                                                        <% 
                                                                            no = 0 
                                                                            do while not CAIK.eof 
                                                                            no = no + 1
                                                                        %>
                                                                            <div class="row ">
                                                                                <div class="col-4">
                                                                                    <input readonly onclick="getDataACIK<%=no%>()" type="text"   class="text-center mb-1  cont-form" name="AC_IK" id="AC_IK<%=no%>" value="<%=CAIK("CA_ID")%>">
                                                                                </div>
                                                                                <div class="col-8">
                                                                                    <input readonly onclick="getDataACIK<%=no%>()" type="text"   class="cont-form mb-1 " name="ACC_Name" id="ACC_Name<%=no%>" value="<%=CAIK("CA_Name")%>">
                                                                                </div>
                                                                            </div>
                                                                            <script>
                                                                                function getDataACIK<%=no%>(){
                                                                                    $.ajax({
                                                                                        type: "get",
                                                                                        url: "Update-GL/upd-ACIDK.asp?AC_IK="+document.getElementById("AC_IK<%=no%>").value+"&ItemID="+document.getElementById("ItemID<%=ItemList("Item_ID")%>").value,
                                                                                        success: function (url) {
                                                                                        $('.Upd-LISTACIK').html(url);
                                                                                        document.getElementById("cont-up-k").style.display = "none";
                                                                                        }
                                                                                    });
                                                                                }
                                                                            </script>
                                                                        <% CAIK.movenext
                                                                        loop %>
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-4 mb-1">
                                                                        <div class="col-4">
                                                                            <button onclick="updListItem()" class="tambah-list cont-btn txt-desc"> Simpan Perubahan </button>
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <button onclick="Refresh()" class="tambah-list cont-btn txt-desc"> Batal </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Modal content -->
                                            <script>
                                                function Update<%=ItemList("Item_ID")%>(){                                                
                                                    // document.getElementById("loader-up").style.display = "block";
                                                        // setTimeout(() => {
                                                        // document.getElementById("loader-up").style.display = "none";
                                                        document.getElementById("Update-GL-Cont<%=ItemList("Item_ID")%>").style.display = "Block";
                                                        document.getElementById("Cont-Update-GL<%=ItemList("Item_ID")%>").style.display = "none";
                                                    // }, 10000);
                                                    
                                                } 
                                                function OpenD(){
                                                    document.getElementById("cont-up-d").style.display = "block";
                                                } 
                                                function OpenK(){
                                                    document.getElementById("cont-up-k").style.display = "block";
                                                } 
                                                function getListACID(){
                                                    $.ajax({
                                                        type: "get",
                                                        url: "Update-GL/get-ListACID.asp?AC_ID="+document.getElementById("ACID").value+"&CA_Name="+document.getElementById("NameACID").value,
                                                        success: function (url) {
                                                        $('.Table-List-ACID').html(url);
                                                        }
                                                    });
                                                }
                                                function getListACIK(){
                                                    $.ajax({
                                                        type: "get",
                                                        url: "Update-GL/get-ListACIK.asp?AC_ID="+document.getElementById("ACIK").value+"&CA_Name="+document.getElementById("NameACIK").value,
                                                        success: function (url) {
                                                            console.log(url);
                                                        $('.Table-List-ACIK').html(url);
                                                        }
                                                    });
                                                }
                                                function Delete<%=ItemList("Item_ID")%>(){
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "Update-GL/del-GL-Item.asp?ItemID="+document.getElementById("ItemID<%=ItemList("Item_ID")%>").value,
                                                        success: function (url) {
                                                            Swal.fire({
                                                                text: 'Status Kode Item Berhasil Di Hapus '
                                                            });
                                                        }
                                                    });
                                                }
                                                var modal<%=ItemList("Item_ID")%> = document.getElementById("myModal<%=ItemList("Item_ID")%>");
                                                var btn<%=ItemList("Item_ID")%> = document.getElementById("myBtn<%=ItemList("Item_ID")%>");
                                                var span<%=ItemList("Item_ID")%> = document.getElementsByClassName("closee<%=ItemList("Item_ID")%>")[0];
                                                    btn<%=ItemList("Item_ID")%>.onclick = function() {
                                                        document.getElementById("loader-page").style.display = "block";
                                                            setTimeout(() => {
                                                            document.getElementById("loader-page").style.display = "none";
                                                        }, 1000);
                                                        setTimeout(() => {
                                                            modal<%=ItemList("Item_ID")%>.style.display = "block";
                                                        }, 1000);
                                                    }
                                                    span<%=ItemList("Item_ID")%>.onclick = function() {
                                                        modal<%=ItemList("Item_ID")%>.style.display = "none";
                                                        document.getElementById("Cont-Update-GL<%=ItemList("Item_ID")%>").style.display= "block";
                                                        document.getElementById("Update-GL-Cont<%=ItemList("Item_ID")%>").style.display= "none";
                                                        document.getElementById("loader-page").style.display = "block";
                                                            setTimeout(() => {
                                                            document.getElementById("loader-page").style.display = "none";
                                                            window.location.reload();
                                                        }, 1000);
                                                    }
                                                    window.onclick = function(event) {
                                                        if (event.target == modal<%=ItemList("Item_ID")%>) {
                                                            modal<%=ItemList("Item_ID")%>.style.display = "none";
                                                        }
                                                    }
                                                function updListItem(){
                                                    var Item_ID     = document.getElementById("updItemID<%=ItemList("Item_ID")%>").value;
                                                    var updCatItemID     = document.getElementById("updCatItemID<%=ItemList("Item_ID")%>").value;
                                                    var Item_Cat_ID = document.getElementById("updCatItem<%=ItemList("Item_ID")%>").value;
                                                    var Item_Tipe   = document.getElementById("updItemTipe<%=ItemList("Item_ID")%>").value;
                                                    var Item_Name   = document.getElementById("updNameItem<%=ItemList("Item_ID")%>").value;
                                                    var Item_Status = document.getElementById("updStatusItem<%=ItemList("Item_ID")%>").value;
                                                    var Item_CAIDD  = document.getElementById("ACID").value;
                                                    var Item_CAIDK  = document.getElementById("ACIK").value;
                                                    $.ajax({
                                                        type: "GET",
                                                        url: "Update-GL/upd-GL-List.asp",
                                                        data: {
                                                            Item_ID,
                                                            updCatItemID,
                                                            Item_Cat_ID,
                                                            Item_Tipe,
                                                            Item_Name,
                                                            Item_Status,
                                                            Item_CAIDD,
                                                            Item_CAIDK
                                                        },
                                                        success: function (data) {
                                                            Swal.fire('Data Berhasil Di Perbaharui ', data.message, 'success').then(() => {
                                                                location.reload();
                                                            });
                                                        }
                                                    });
                                                }
                                            </script>
                                            <% ItemList.movenext
                                            loop %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- GL-LIST-KAS -->
            </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
    <script>
        function SearchListItem(){
            let CATName = document.getElementById("CATName").value;
            let CatListItem = document.getElementById("CatListItem").value;
            let StatusListItem = document.getElementById("StatusListItem").value;
            let NameItem = document.getElementById("NameItem").value;
                // console.log(CATName);
                
            $.ajax({
                type: "get",
                url: "get-ListItem.asp",
                data: {
                    CATName,
                    CatListItem ,
                    StatusListItem ,
                    NameItem
                },
                success: function (data) {
                // console.log(data);
                $('.DataListItem').html(data);
                                    
                }
            });
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