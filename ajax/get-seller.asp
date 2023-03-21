<!--#include file="../connections/pigoConn.asp"-->

<%
   
    penerimapesan = request.queryString("kodeseller")
    produkid = request.queryString("produkid")
    ' response.write penerimapesan & "<br>"

    set updatechat_cmd =  server.createObject("ADODB.COMMAND")
    updatechat_cmd.activeConnection = MM_PIGO_String

    updatechat_cmd.commandText = "Update MKT_T_ChatLive set chatReadYN = 'Y' where chat_Penerima = '"& request.Cookies("custID") &"'  and chat_Pengirim = '"& penerimapesan &"' "
    'response.write updatechat_cmd.commandText & "<br>"
    set updatechat = updatechat_cmd.execute

    set penerima_cmd =  server.createObject("ADODB.COMMAND")
    penerima_cmd.activeConnection = MM_PIGO_String

    penerima_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Seller.slName, MKT_M_Seller.sl_custID FROM MKT_M_Customer LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID where MKT_M_Customer.custID = '"& penerimapesan &"' "
    'response.write penerima_CMD.commandText & "<br>"
    set penerima = penerima_cmd.execute

    set chat_cmd =  server.createObject("ADODB.COMMAND")
    chat_cmd.activeConnection = MM_PIGO_String

    chat_cmd.commandText = "SELECT MKT_T_ChatLive.chatTanggal FROM MKT_T_ChatLive LEFT OUTER JOIN MKT_M_Customer AS Pengirim ON MKT_T_ChatLive.chat_Pengirim = Pengirim.custID LEFT OUTER JOIN MKT_M_Customer AS Penerima ON MKT_T_ChatLive.chat_Penerima = Penerima.custID Where  chat_Penerima = '"& request.Cookies("custID") &"' OR  chat_Pengirim = '"& request.Cookies("custID") &"' and chat_Penerima = '"& penerimapesan &"' GROUP BY MKT_T_ChatLive.chatTanggal Order BY MKT_T_ChatLive.chatTanggal "
    'response.write chat_CMD.commandText & "<br>"
    set chattanggal = chat_cmd.execute
    

%>
<div class="row align-items-center">
    <div class="col-1">
        <span class="user-chat" style="font-size:13px"><i class="fas fa-user-circle"></i></span>
    </div>
    <div class="col-10">
        <span class="user-chat" ><%=penerima("slname")%> </span>
        <input type="hidden" value="<%=penerima("custID")%>" name="kodeseller" id="kodeseller" >
        <input type="hidden" value="<%=produkid%>" name="produkid" id="produkid" >
    </div>
</div>
<% if chattanggal.eof = true then %>
<div class="row text-center" style="margin-top:1rem">
    <div class="col-12">
        <span class="txt-ChatLive"> Belum Ada Percakapan </span>
        <input class="chattext" type="hidden" value="<%=penerimapesan%>" name="penerimapesan" id="penerimapesan" >
    </div>
</div>
<% else %>
    <div class="chatrSoom" >
    <% do while not chattanggal.eof %>
        <div class="row mt-1 text-center">
            <div class="col-12">
                <span class="txt-ChatDesc" style="color:#aaa"> <%=day(CDate(chattanggal("chatTanggal")))%>&nbsp;<%=MonthName(Month(chattanggal("chatTanggal")),3)%>&nbsp;<%=year(chattanggal("chatTanggal"))%> </span><br>
            </div>
        </div>
        <%
            chat_cmd.commandText = "SELECT MKT_T_ChatLive.chatDesc, MKT_T_ChatLive.chatTanggal,  convert(char(5), MKT_T_ChatLive.chatUpdateTime, 108) AS Waktu, Penerima.custPhoto, MKT_T_ChatLive.chat_Penerima,  MKT_T_ChatLive.chat_Pengirim, MKT_T_ChatLive.chatReadYN, Penerima.custNama AS namapenerima, Pengirim.custNama AS namapengirim FROM MKT_T_ChatLive LEFT OUTER JOIN MKT_M_Customer AS Pengirim ON MKT_T_ChatLive.chat_Pengirim = Pengirim.custID LEFT OUTER JOIN MKT_M_Customer AS Penerima ON MKT_T_ChatLive.chat_Penerima = Penerima.custID Where MKT_T_ChatLive.chatTanggal = '"& chattanggal("chatTanggal") &"' GROUP BY MKT_T_ChatLive.chatDesc, MKT_T_ChatLive.chatTanggal, MKT_T_ChatLive.chatUpdateTime,Penerima.custPhoto, MKT_T_ChatLive.chat_Penerima,  MKT_T_ChatLive.chat_Pengirim, MKT_T_ChatLive.chatReadYN, Penerima.custNama,Pengirim.custNama Order BY chatUpdateTime "
            'response.write chat_CMD.commandText & "<br>"
            set chat = chat_cmd.execute
        %>
        <% do while not Chat.eof %>
        <% if chat("chat_Pengirim") = request.Cookies("custID") then %>
        <div class="row mt-2 mb-2">
            <div class="col-2">
            </div>
            <div class="col-10">
                <div class="chattext">
                    <span> <%=Chat("chatDesc")%> </span>
                    <div class="row text-end mt-1">
                        <div class="col-12">
                        <% if Chat("chatReadYN") = "Y" then %>
                            <span style="color:#0077a2"> <i class="fas fa-check"></i></i> </span><span class="txt-ChatDesc"> <%=Chat("waktu")%>  </span><br>
                        <% else %>
                            <span style="color:grey"> <i class="fas fa-check"></i></i> </span><span class="txt-ChatDesc"> <%=Chat("waktu")%>  </span><br>
                        <% end if %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% else %>
        <div class="row mt-1">
            <div class="col-9">
                <div class="chattext-cust">
                    <span> <%=Chat("chatDesc")%> </span>
                    <div class="row text-end mt-1">
                        <div class="col-12">
                        <% if Chat("chatReadYN") = "Y" then %>
                            <span style="color:#0077a2"> <i class="fas fa-check"></i></i> </span><span class="txt-ChatDesc"> <%=Chat("waktu")%>  </span><br>
                        <% else %>
                            <span style="color:grey"> <i class="fas fa-check"></i></i> </span><span class="txt-ChatDesc"> <%=Chat("waktu")%>  </span><br>
                        <% end if %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-2">
            </div>
        </div>
        <% end if %>
        <% Chat.movenext
        loop %>
        <% chattanggal.movenext
        loop %>
        <% IF produkid = "" then %>
        <% else %>
        
            <%
                chat_cmd.commandText = "SELECT pdID , pdImage1, pdNama, pdSKU FROM MKT_M_Produk WHERE pdID = '"& produkid &"' "
                'response.write chat_CMD.commandText & "<br>"
                set Produk = chat_cmd.execute
            %>
            <div class="row mb-1">
            <div class="col-9">
                <div class="chattext-cust">
                    <div class="row align-items-center">
                        <div class="col-3">
                            <img src="data:image/png;base64,<%=produk("pdImage1")%>" style="width:60px; height:60px" class="card-img-top rounded" alt="...">
                        </div>
                        <div class="col-9">
                            <span> <%=produk("pdNama")%> </span><br>
                            <span> <%=produk("pdSKU")%> </span><br>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-2">
            </div>
        </div>
        <% end if  %>
    </div>
<% end if %>
<script>
    $('.chatrSoom').ready(function() {
        setTimeout(() => {
            var kodeseller = document.getElementById("kodeseller").value;
            var produkid = document.getElementById("produkid").value;
            if (produkid == ""){
                $.ajax({
                        type: "get",
                        url: "Ajax/get-seller.asp",
                        data: {
                            kodeseller
                        },
                        success: function (url) {
                            $('.chatseller').html(url);
                            return url;
                            // console.log(url);
                        }
                    });
            }else{
                $.ajax({
                        type: "get",
                        url: "Ajax/get-seller.asp",
                        data: {
                            kodeseller,
                            produkid
                        },
                        success: function (url) {
                            $('.chatseller').html(url);
                            return url;
                            // console.log(url);
                        }
                    });
            }
                    
        }, 10000);
    });
</script>