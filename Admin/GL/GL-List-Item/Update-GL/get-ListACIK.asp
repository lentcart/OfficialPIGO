<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("AC_ID")
    CA_Name = request.queryString("CA_Name")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID Like '%"& CA_ID &"%' AND CA_Name Like '%"& CA_Name &"%'"
        'response.Write GL_M_ChartAccount_cmd.commandText
    set CAIK = GL_M_ChartAccount_cmd.execute

%>
<div class="col-12">
    <% if CAIK.eof = true then %>

        <span> Data Tidak Ditemukan ! </span>

    <% else %>

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
                url: "Update-GL/upd-ACIDK.asp?AC_IK="+document.getElementById("AC_IK<%=no%>").value,
                success: function (url) {
                $('.Upd-LISTACIK').html(url);
                document.getElementById("cont-up-k").style.display = "none";
                }
            });
        }
    </script>
    <% 
        CAIK.movenext
        loop 
    %>
    <% end if %>
</div>