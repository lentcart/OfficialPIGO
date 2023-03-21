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

    Cat_ID = request.queryString("Cat_ID")
    Item_Status = request.queryString("Item_Status")
    Item_Name = request.queryString("Item_Name")
    'response.write Cat_ID
    set GL_M_Item_cmd = server.createObject("ADODB.COMMAND")
    GL_M_Item_cmd.activeConnection = MM_PIGO_String

    IF Item_Name = "" then 
        IF Item_Status = "" then 
            GL_M_Item_cmd.commandText = "SELECT GL_M_Item.Item_ID, GL_M_Item.Item_Cat_ID, GL_M_Item.Item_Tipe, GL_M_Item.Item_Name, GL_M_Item.Item_Status, GL_M_Item.Item_CAIDD, GL_M_Item.Item_CAIDK, GL_M_Item.Item_UpdateID,  CAST(GL_M_Item.Item_UpdateTime AS DATE) AS Tanggal, GL_M_Item.Item_AktifYN, CANameD.CA_Name AS CANameD, CANameK.CA_Name AS CANameK, GL_M_Item.Item_CatTipe, GL_M_CategoryItem_PIGO.Cat_Name FROM GL_M_ChartAccount AS CANameK RIGHT OUTER JOIN GL_M_CategoryItem_PIGO RIGHT OUTER JOIN GL_M_Item ON GL_M_CategoryItem_PIGO.Cat_ID = GL_M_Item.Item_Cat_ID ON CANameK.CA_ID = GL_M_Item.Item_CAIDK LEFT OUTER JOIN GL_M_ChartAccount AS CANameD ON GL_M_Item.Item_CAIDD = CANameD.CA_ID Where Item_Cat_ID = '"& Cat_ID &"' "
            'response.write GL_M_Item_cmd.commandText 
            set ItemList = GL_M_Item_cmd.execute
        else
            GL_M_Item_cmd.commandText = "SELECT GL_M_Item.Item_ID, GL_M_Item.Item_Cat_ID, GL_M_Item.Item_Tipe, GL_M_Item.Item_Name, GL_M_Item.Item_Status, GL_M_Item.Item_CAIDD, GL_M_Item.Item_CAIDK, GL_M_Item.Item_UpdateID,  CAST(GL_M_Item.Item_UpdateTime AS DATE) AS Tanggal, GL_M_Item.Item_AktifYN, CANameD.CA_Name AS CANameD, CANameK.CA_Name AS CANameK, GL_M_Item.Item_CatTipe, GL_M_CategoryItem_PIGO.Cat_Name FROM GL_M_ChartAccount AS CANameK RIGHT OUTER JOIN GL_M_CategoryItem_PIGO RIGHT OUTER JOIN GL_M_Item ON GL_M_CategoryItem_PIGO.Cat_ID = GL_M_Item.Item_Cat_ID ON CANameK.CA_ID = GL_M_Item.Item_CAIDK LEFT OUTER JOIN GL_M_ChartAccount AS CANameD ON GL_M_Item.Item_CAIDD = CANameD.CA_ID Where Item_Status = '"& Item_Status &"' "
            'response.write GL_M_Item_cmd.commandText 
            set ItemList = GL_M_Item_cmd.execute
        end if
    else
        GL_M_Item_cmd.commandText = "SELECT GL_M_Item.Item_ID, GL_M_Item.Item_Cat_ID, GL_M_Item.Item_Tipe, GL_M_Item.Item_Name, GL_M_Item.Item_Status, GL_M_Item.Item_CAIDD, GL_M_Item.Item_CAIDK, GL_M_Item.Item_UpdateID,  CAST(GL_M_Item.Item_UpdateTime AS DATE) AS Tanggal, GL_M_Item.Item_AktifYN, CANameD.CA_Name AS CANameD, CANameK.CA_Name AS CANameK, GL_M_Item.Item_CatTipe, GL_M_CategoryItem_PIGO.Cat_Name FROM GL_M_ChartAccount AS CANameK RIGHT OUTER JOIN GL_M_CategoryItem_PIGO RIGHT OUTER JOIN GL_M_Item ON GL_M_CategoryItem_PIGO.Cat_ID = GL_M_Item.Item_Cat_ID ON CANameK.CA_ID = GL_M_Item.Item_CAIDK LEFT OUTER JOIN GL_M_ChartAccount AS CANameD ON GL_M_Item.Item_CAIDD = CANameD.CA_ID Where Item_Name Like '%"& Item_Name &"%'"
        'response.write GL_M_Item_cmd.commandText 
        set ItemList = GL_M_Item_cmd.execute
    end if

%>

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
