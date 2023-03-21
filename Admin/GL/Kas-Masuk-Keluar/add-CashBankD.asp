<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    no = 0 
    CBD_ID = request.queryString("CBD_ID")
    CBD_Cat_ID = request.queryString("CBD_Cat_ID")
    CBD_Item_ID = request.queryString("CBD_Item_ID")
    CBD_Keterangan = request.queryString("CBD_Keterangan")
    CBD_Quantity = request.queryString("CBD_Quantity")
    CBD_Harga = request.queryString("CBD_Harga")
    CBD_UpdateID = request.queryString("CBD_UpdateID")

    set Kas_H_CMD = server.CreateObject("ADODB.command")
    Kas_H_CMD.activeConnection = MM_PIGO_String
    Kas_H_CMD.commandText = "exec sp_add_GL_T_CashBank_D '"& CBD_ID &"', '"& CBD_Cat_ID &"', '"& CBD_Item_ID &"', '"& CBD_Keterangan &"',"& CBD_Quantity &", "& CBD_Harga &", '"& session("username") &"' "

    ' Kas_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_CashBank_D]([CBD_ID],[CBD_Cat_ID],[CBD_Item_ID],[CBD_Keterangan],[CBD_Quantity],[CBD_Harga],[CBD_UpdateID],[CBD_AktifYN],[CBD_UpdateTime])VALUES('"& CBD_ID &"','"& CBD_Cat_ID &"','"& CBD_Item_ID &"','"& CBD_Keterangan &"','"& CBD_Quantity &"','"& CBD_Harga &"','"& Session("username")& "','Y','"& now() &"')"
    'response.write Kas_H_CMD.commandText
    set Kas_H = Kas_H_CMD.execute

    Kas_H_CMD.commandText = "SELECT * FROM [dbo].[GL_T_CashBank_D] WHERE LEFT(CBD_ID,18) = '"& CBD_ID &"' "
    'response.write Kas_H_CMD.commandText
    set DataKasD = Kas_H_CMD.execute

%>
<table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:13px; border: 1px solid black;">
    <thead>
        <tr class="text-center">
            <th>ACTION</th>
            <th>KODE ITEM</th>
            <th>KETERANGAN</th>
            <th>QUANTITY</th>
            <th>HARGA SATUAN</th>
            <th>SUBTOTAL</th>
        </tr>
    </thead>
    <tbody>
        <% 
            no = 0 
            do while not DataKasD.eof 
            no = no + 1
        %>
        <tr>
            <td class="text-center"> <button onclick="deleteCashBankD<%=no%>()" class="cont-btn"> DELETE </button> </td>
            <td class="text-center"> <%=DataKasD("CBD_Item_ID")%> </td>
            <td class="text-center"> <%=DataKasD("CBD_Keterangan")%> </td>
            <td class="text-center"> <%=DataKasD("CBD_Quantity")%> </td>
            <td class="text-center"> <%=DataKasD("CBD_Harga")%> </td>
            <% SUBTOTAL = DataKasD("CBD_Quantity")*DataKasD("CBD_Harga") %>
            <td class="text-center"> <%=SUBTOTAL%> </td>
        </tr>
        <script>
            function deleteCashBankD<%=no%>(){
                var CBD_ID  = $('input[name=CBD_ID]').val();
                $.ajax({
                    type: "POST",
                    url: "delete-CashBankD.asp",
                    data: {
                        CB_ID : CBD_ID
                    },
                    success: function (data) {
                        location.reload();
                    }
                });
            }
        </script>
        <% DataKasD.movenext
        loop %>
    </tbody>
</table>