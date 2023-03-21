<%
    
    set Listseller_cmd =  server.createObject("ADODB.COMMAND")
    Listseller_cmd.activeConnection = MM_PIGO_String

    Listseller_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_M_Seller.sl_custID,MKT_M_Customer.custPhoto FROM MKT_M_Customer RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_T_Keranjang ON MKT_M_Seller.sl_custID = MKT_T_Keranjang.cart_slID WHERE (MKT_T_Keranjang.cart_custID = '"& request.Cookies("custID") &"') GROUP BY MKT_M_Seller.slName, MKT_M_Customer.custPhoto,MKT_M_Seller.sl_custID "
    'response.write Listseller_CMD.commandText & "<br>"
    set Listseller = Listseller_cmd.execute

    set chat_cmd =  server.createObject("ADODB.COMMAND")
    chat_cmd.activeConnection = MM_PIGO_String

    chat_cmd.commandText = "SELECT MKT_T_ChatLive.chatDesc, MKT_T_ChatLive.chatTanggal, MKT_T_ChatLive.chatTime, Penerima.custPhoto, MKT_T_ChatLive.chat_Penerima,  MKT_T_ChatLive.chat_Pengirim, Penerima.custNama AS namapenerima, Pengirim.custNama AS namapengirim FROM MKT_T_ChatLive LEFT OUTER JOIN MKT_M_Customer AS Pengirim ON MKT_T_ChatLive.chat_Pengirim = Pengirim.custID LEFT OUTER JOIN MKT_M_Customer AS Penerima ON MKT_T_ChatLive.chat_Penerima = Penerima.custID Where chat_Penerima = '"& request.Cookies("custID") &"' Order BY ChatTime"
    'response.write chat_CMD.commandText & "<br>"
    set chat = chat_cmd.execute
%>
<style>
    .cont-chatlive{
        background-color:red;
        width:20rem;
        position:absolute;
    }
    .header-chat{
        background-color:red;
    }
</style>
<div class="cont-chatlive">
    <input type="hidden" name="custEmail" id="custEmail" value="<%=request.cookies("custEmail")%>">
    <div class="chat-popup" id="myForm">
        <div class="form-container">
            <div class="row">
                <div class="col-10">
                    <span class="txt-ChatLive"> ChatLive () </span>
                </div>
                <div class="col-2">
                    <span class=""  style="font-size:15px"><i onclick="closeForm()" class="fas fa-times-circle me-4"></i><i class="fas fa-list-ul"></i></span>
                </div>
            </div>
            <div class="row">
                <div class="col-8">
                    <div class="row mt-2 mb-1">
                        <div class="col-12">
                            <div class="roomChat chatseller" id="chatseller">
                                <div class="row text-center">
                                    <div class="col-12">
                                        <img src="<%=base_url%>/assets/logo/Maskotnew.png"  class="logo" alt="" width="70" height="75" ><br>
                                        <span class="txt-ChatLive"> Selamat Datang Di Fitur Chat  </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-9">
                            <input Required class="cont-chat chatStart" type="text" value="" name="isipesan" id="isipesan" placeholder="Masukan Pesan Anda">
                        </div>
                        <div class="col-3">
                            <button onclick="return sendChat()" class="sendChat"> Kirim </button>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="row ">
                        <div class="col-12">
                            <div class="list-seller-chat">
                            <% do while not Listseller.eof %>
                                <button onclick="setTimeout(selectsl<%=Listseller("sl_custID")%>(), 100)" class="listt mt-2">
                                <div class="row align-items-center">
                                    <div class="col-2">
                                        <span class="" style="font-size:22px"> <i class="fas fa-user-circle"></i>  </span>
                                    </div>
                                    <div class="col-7 text-start">
                                        <input class="text-desc inp-chat-seller" type="text" name="nameseller" id="nameseller" value="<%=Listseller("slName")%>">
                                        <span class="text-desc" style="font-size"> </span><br>
                                        <span class="txt-ChatDesc" style="font-size:8px; font-weight:bold"> Isi Pesan Terakhir </span>
                                        <input readonly class="txt-ChatDesc" type="hidden" value="<%=Listseller("sl_custID")%>" name="kodeseller" id="kodeseller<%=Listseller("sl_custID")%>" style="width:8rem" >
                                    </div>
                                </div>
                                </button>
                                <script>
                                    function selectsl<%=Listseller("sl_custID")%>(){
                                        $.ajax({
                                            type: "get",
                                            url: "Ajax/get-seller.asp?kodeseller="+document.getElementById("kodeseller<%=Listseller("sl_custID")%>").value,
                                            success: function (url) {
                                                $('.chatseller').html(url);
                                                return url;
                                                // console.log(url);
                                            }
                                        });
                                    }
                                </script>
                            <% Listseller.movenext
                            loop %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function openForm() {
        var custEmail = document.getElementById("custEmail").value;
        if ( custEmail == "" ){
            window.open(`Login/`,`_Self`)
        }else{
            document.getElementById("myForm").style.display = "block";
            $('.cont-chat').focus();
        }
    }
    function closeForm() {
        document.getElementById("myForm").style.display = "none";
    }
</script>