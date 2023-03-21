<!--#include file="../connections/pigoConn.asp"-->
<%
    ChatDesc = request.queryString("isipesan")
    penerimapesan = request.queryString("kodeseller")
    
    set sendChat_CMD = server.CreateObject("ADODB.command")
    sendChat_CMD.activeConnection = MM_pigo_STRING

    sendChat_CMD.commandText = "INSERT INTO [dbo].[MKT_T_ChatLive]([chatDesc],[chatTanggal],[chatTime],[chatReadYN],[chat_Penerima],[chat_Pengirim],[chatUpdateTime],[chatAktifYN])VALUES('"& ChatDesc &"','"& date() &"','"& time() &"','N','"& penerimapesan &"','"& request.Cookies("custID") &"','"& now() &"','Y') "
    'response.write sendChat_CMD.commandText
    set chatlive = sendChat_CMD.execute

    set penerima_cmd =  server.createObject("ADODB.COMMAND")
    penerima_cmd.activeConnection = MM_PIGO_String

    penerima_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Seller.slName, MKT_M_Seller.sl_custID FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID where MKT_M_Customer.custID = '"& penerimapesan &"' "
    'response.write penerima_CMD.commandText & "<br>"
    set penerima = penerima_cmd.execute

    set chat_cmd =  server.createObject("ADODB.COMMAND")
    chat_cmd.activeConnection = MM_PIGO_String

    chat_cmd.commandText = "SELECT MKT_T_ChatLive.chatDesc, MKT_T_ChatLive.chatTanggal, MKT_T_ChatLive.chatTime, Penerima.custPhoto, MKT_T_ChatLive.chat_Penerima,  MKT_T_ChatLive.chat_Pengirim, Penerima.custNama AS namapenerima, Pengirim.custNama AS namapengirim FROM MKT_T_ChatLive LEFT OUTER JOIN MKT_M_Customer AS Pengirim ON MKT_T_ChatLive.chat_Pengirim = Pengirim.custID LEFT OUTER JOIN MKT_M_Customer AS Penerima ON MKT_T_ChatLive.chat_Penerima = Penerima.custID Where  chat_Penerima = '"& request.Cookies("custID") &"' OR  chat_Pengirim = '"& request.Cookies("custID") &"' and chat_Penerima = '"& penerimapesan &"' Order BY ChatTime"
    'response.write chat_CMD.commandText & "<br>"
    set chat = chat_cmd.execute

%>
<div class="row align-items-center">
    <div class="col-1">
        <span class="user-chat" style="font-size:13px"><i class="fas fa-user-circle"></i></span>
    </div>
    <div class="col-10">
        <span class="user-chat" ><%=penerima("slname")%> </span>
        <input type="hidden" value="<%=penerima("custID")%>" name="kodeseller" id="kodeseller" >
    </div>
</div>
<% if Chat.eof = true then %>
<div class="row text-center">
    <div class="col-12">
        <span class="txt-ChatLive"> Belum Ada Percakapan </span>
        <input class="chattext" type="hidden" value="<%=penerimapesan%>" name="kodeseller" id="kodeseller" >
    </div>
</div>
<% else %>
<div class="chatrSoom" style="overflow-y:scroll;overflow-x:hidden; height:12.5rem">
    <% do while not Chat.eof %>
    <% if chat("chat_Pengirim") = request.Cookies("custID") then %>
    <div class="row">
        <div class="col-8 me-4">
            <span class="txt-ChatDesc"> <%=CDate(Chat("chatTanggal"))%> - <%=Chat("chatTime")%>  </span><br>
            <input class="chattext" type="text" value="<%=Chat("chatDesc")%>" name="s" id="s" >
        </div>
        <div class="col-2 mt-3 ms-2">
            <span class=""  style="font-size:22px"> <i class="fas fa-user-circle"></i>  </span>
        </div>
    </div>
    <% else %>
    <div class="row">
        <div class="col-1 me-2 mt-3">
            <span class=""  style="font-size:22px"> <i class="fas fa-user-circle"></i>  </span>
        </div>
        <div class="col-8">
            <span class="txt-ChatDesc"> <%=CDate(Chat("chatTanggal"))%> - <%=Chat("chatTime")%>  </span><br>
            <input class="chattext" type="text" value="<%=Chat("chatDesc")%>" name="s" id="s" >
        </div>
    </div>
    <% end if %>
    <% Chat.movenext
    loop %>
</div>
<% end if %>
<script>
    $('.chatrSoom').ready(function() {
        $.ajax({
            type: "get",
            url: "Ajax/get-seller.asp?kodeseller="+document.getElementById("kodeseller").value,
            success: function (url) {
                $('.chatseller').html(url);
                return url;
            // console.log(url);
            }
        });
    });
</script>