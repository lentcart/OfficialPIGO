<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("CA_ID")
    CA_Name = request.queryString("CA_Name")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID Like '%"& CA_ID &"%' AND CA_Name Like '%"& CA_Name &"%' AND NOT CA_Type = 'H'"
    set ACCID = GL_M_ChartAccount_cmd.execute

%>
<div class="col-12">
    <table class=" table tb-transaksi cont-text table-bordered table-condensed p-0">
    <% if ACCID.eof = true then %>
        <tr>
            <td class="center"> Data Tidak Ditemukan </td>
        </tr>
    <% else %>
    <% 
        no= 0 
        do while not ACCID.eof 
        no = no+1
    %>
        <tr>
            <td class="text-center" style="width:25%;"> <input class="text-center cont-form" onclick="getACCID<%=no%>()"class="text-center"type="text" name="ACC_ACID" id="ACC_ACID<%=no%>" value="<%=ACCID("CA_ID")%>" style=" border:none"> </td>
            <td> <input class="cont-form" onclick="getACCID<%=no%>()"type="text" name="CA_Name" id="CA_Name" value="<%=ACCID("CA_Name")%>" style=" border:none"> </td>
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
    <% end if %>
    </table>
</div>