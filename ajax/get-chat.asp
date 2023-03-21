<!--#include file="../connections/pigoConn.asp"-->

<%
   
    penerimapesan = request.queryString("kodeseller")
    
    set chat_cmd =  server.createObject("ADODB.COMMAND")
    chat_cmd.activeConnection = MM_PIGO_String

    chat_cmd.commandText = "SELECT MKT_T_ChatLive.chatDesc, MKT_T_ChatLive.chatTanggal,  convert(char(5), MKT_T_ChatLive.chatUpdateTime, 108) AS Waktu, Penerima.custPhoto, MKT_T_ChatLive.chat_Penerima,  MKT_T_ChatLive.chat_Pengirim, MKT_T_ChatLive.chatReadYN, Penerima.custNama AS namapenerima, Pengirim.custNama AS namapengirim FROM MKT_T_ChatLive LEFT OUTER JOIN MKT_M_Customer AS Pengirim ON MKT_T_ChatLive.chat_Pengirim = Pengirim.custID LEFT OUTER JOIN MKT_M_Customer AS Penerima ON MKT_T_ChatLive.chat_Penerima = Penerima.custID Where  chat_Penerima = '"& request.Cookies("custID") &"' OR  chat_Pengirim = '"& request.Cookies("custID") &"' and chat_Penerima = '"& penerimapesan &"' GROUP BY MKT_T_ChatLive.chatDesc, MKT_T_ChatLive.chatTanggal, MKT_T_ChatLive.chatUpdateTime,Penerima.custPhoto, MKT_T_ChatLive.chat_Penerima,  MKT_T_ChatLive.chat_Pengirim, MKT_T_ChatLive.chatReadYN, Penerima.custNama,Pengirim.custNama Order BY chatUpdateTime "
    'response.write chat_CMD.commandText & "<br>"
    set chat = chat_cmd.execute

%>

    <% do while not Chat.eof %>
        <% if chat("chat_Pengirim") = request.Cookies("custID") then %>
        <div class="row cont-chat">
            <div class="col-8 me-4">
                <span class="txt-ChatDesc"> <%=day(CDate(Chat("chatTanggal")))%>&nbsp;<%=MonthName(Month(Chat("chatTanggal")),3)%>&nbsp;<%=year(Chat("chatTanggal"))%> -  </span><br>
                <input readonly class="chattext" type="text" value="<%=Chat("chatDesc")%>" name="s" id="s" >
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
                <span class="txt-ChatDesc"> <%=day(CDate(Chat("chatTanggal")))%>&nbsp;<%=MonthName(Month(Chat("chatTanggal")),3)%>&nbsp;<%=year(Chat("chatTanggal"))%> - </span><br>
                <input readonly class="chattext" type="text" value="<%=Chat("chatDesc")%>" name="s" id="s" >
            </div>
        </div>
        <% end if %>
        <% Chat.movenext
        loop %>
