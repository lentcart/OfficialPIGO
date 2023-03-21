
<%

    set Chat_cmd =  server.createObject("ADODB.COMMAND")
    Chat_cmd.activeConnection = MM_PIGO_String

    Chat_cmd.commandText = "SELECT count(chatDesc) as total FROM MKT_T_ChatLive Where chat_Penerima = '"& request.Cookies("custID") &"' and chatReadYN = 'N'"
    set Chat = Chat_CMD.execute


%>
<!-- Popup Chat -->
    <button class="open-button" onclick="openForm()"><img src="assets/logo/bantuan.png" class="  me-1" alt="..." id="chat" >  <span class="notify-badgee2"><%=Chat("total")%></span>Live Chat</button>
        <div class="chat-popup" id="myForm">
            <div class="form-container">
                <div class="row">
                    <div class="col-9 me-4">
                        <span class="txt-ChatLive"> ChatLive () </span>
                    </div>
                    <div class="col-2">
                        <span class=""  style="font-size:15px"><i onclick="closeForm()" class="fas fa-times-circle me-4"></i><i class="fas fa-list-ul"></i></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-7">
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
                            <div class="col-8 me-3">
                                <input Required class="chatStart" type="text" value="" name="isipesan" id="isipesan" placeholder="Masukan Pesan Anda">
                            </div>
                            <div class="col-2">
                                <button onclick="return sendChat()" class="sendChat"> Kirim </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-5">
                        <div class="row ">
                            <div class="col-12">
                                    <div class="s" style="overflow-y:scroll; overflow-x:hidden; height:8.8rem">
                                    <% do while not Listseller.eof %>
                                        <button onclick="setTimeout(selectsl<%=Listseller("sl_custID")%>(), 100)" class="listt mt-2">
                                        <div class="row align-items-center">
                                            <div class="col-2">
                                                <span class="" style="font-size:22px"> <i class="fas fa-user-circle"></i>  </span>
                                            </div>
                                            <div class="col-7 text-start">
                                                <span  style="font-size:8px; font-weight:bold"><%=Listseller("slName")%> </span>
                                                <input readonly class="txt-ChatDesc" type="hidden" value="<%=Listseller("slName")%>" name="A" id="A" style="width:8rem" ><br>
                                                <span class="txt-ChatDesc" style="font-size:8px; font-weight:bold"> Isi Pesan Terakhir </span>
                                                <input readonly class="txt-ChatDesc" type="hidden" value="<%=Listseller("sl_custID")%>" name="penerimapesan" id="penerimapesan<%=Listseller("sl_custID")%>" style="width:8rem" >
                                                <input readonly class="txt-ChatDesc" type="hidden" value="Isi Pesan Terakhir" name="A" id="A" style="width:8rem"  ><br>
                                            </div>
                                            <div class="">
                                            
                                            </div>
                                        </div>
                                        </button>
                                        <script>
                                        $('.chatrSoom').ready(function() {
                                            alert( "ready!" );
                                        });
                                            function selectsl<%=Listseller("sl_custID")%>(){
                                                $.ajax({
                                                    type: "get",
                                                    url: "Ajax/get-seller.asp?penerimapesan="+document.getElementById("penerimapesan<%=Listseller("sl_custID")%>").value,
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
<!-- Popup Chat -->
<script>
    function sendChat(){
        $.ajax({
            type: "get",
            url: "ChatLive/chatcust.asp?isipesan="+document.getElementById("isipesan").value+"&penerimapesan="+documentgetElementById("penerimapesan").value,
            success: function (url) {
            // console.log(url);
            $('.chatseller').html(url);
            // console.log(url);
            document.getElementById("isipesan").value = "";
            }
        });
    }
</script>