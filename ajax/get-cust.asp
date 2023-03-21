<!--#include file="../connections/pigoConn.asp"-->

<%
    customer = request.queryString("customer")

    ' set updatechat_cmd =  server.createObject("ADODB.COMMAND")
    ' updatechat_cmd.activeConnection = MM_PIGO_String

    ' updatechat_cmd.commandText = "Update MKT_T_ChatLive set chatReadYN = 'Y' where chat_custID= '"& custID &"' and chat_slID = '"& request.Cookies("custID") &"' "
    ' 'response.write updatechat_cmd.commandText & "<br>"
    ' set updatechat = updatechat_cmd.execute

    set pengirim_cmd =  server.createObject("ADODB.COMMAND")
    pengirim_cmd.activeConnection = MM_PIGO_String

    pengirim_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Seller.slName, MKT_M_Seller.sl_custID FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID where MKT_M_Customer.custID = '"& customer &"' group by MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Seller.slName, MKT_M_Seller.sl_custID "
    'response.write pengirim_CMD.commandText & "<br>"
    set pengirim = pengirim_cmd.execute

    set chat_cmd =  server.createObject("ADODB.COMMAND")
    chat_cmd.activeConnection = MM_PIGO_String

    chat_cmd.commandText = "SELECT MKT_T_ChatLive.chatDesc, MKT_T_ChatLive.chatTanggal, MKT_T_ChatLive.chatTime, Penerima.custPhoto, MKT_T_ChatLive.chat_Penerima,  MKT_T_ChatLive.chat_Pengirim, Penerima.custNama AS namapenerima, Pengirim.custNama AS namapengirim FROM MKT_T_ChatLive LEFT OUTER JOIN MKT_M_Customer AS Pengirim ON MKT_T_ChatLive.chat_Pengirim = Pengirim.custID LEFT OUTER JOIN MKT_M_Customer AS Penerima ON MKT_T_ChatLive.chat_Penerima = Penerima.custID Where chat_Pengirim = '"& request.Cookies("custID") &"' OR chat_Penerima = '"& request.Cookies("custID") &"' and chat_Pengirim = '"& customer &"' ORDER BY ChatTime"
    'response.write chat_CMD.commandText & "<br>"
    set chat = chat_cmd.execute

%>
<div class="row align-items-center">
    <div class="col-1">
        <span class="user-chat" style="font-size:13px"><i class="fas fa-user-circle"></i></span>
    </div>
    <div class="col-10">
        <span class="user-chat" ><%=pengirim("custNama")%> </span>
        <input type="hidden" value="<%=pengirim("custID")%>" name="customer" id="customer" >
    </div>
</div>
<div class="chatrSoom" style="overflow-y:scroll;overflow-x:hidden; height:12.5rem">
    <% do while not Chat.eof %>
    <% if chat("chat_Penerima") = request.Cookies("custID") then %>
    <div class="row">
        <div class="col-1 me-2 mt-3">
            <span class=""  style="font-size:22px"> <i class="fas fa-user-circle"></i>  </span>
        </div>
        <div class="col-8">
            <span class="txt-ChatDesc"> <%=CDate(Chat("chatTanggal"))%> - <%=Chat("chatTime")%>  </span><br>
            <input class="chattext" type="text" value="<%=Chat("chatDesc")%>" name="s" id="s" >
        </div>
    </div>
    <% else %>
    <div class="row">
        <div class="col-8 me-4">
            <span class="txt-ChatDesc"> <%=CDate(Chat("chatTanggal"))%> - <%=Chat("chatTime")%>  </span><br>
            <input class="chattext" type="text" value="<%=Chat("chatDesc")%>" name="s" id="s" >
        </div>
        <div class="col-2 mt-3 ms-2">
            <span class=""  style="font-size:22px"> <i class="fas fa-user-circle"></i>  </span>
        </div>
    </div>
    <% end if %>
    <% Chat.movenext
    loop %>
</div>
<script>
    $('.chatrSoom').ready(function() {
        $.ajax({
            type: "get",
            url: "../Ajax/get-cust.asp?customer="+document.getElementById("customer").value,
            success: function (url) {
            $('.chatseller').html(url);
            return url;
            }
        });
    });
</script>