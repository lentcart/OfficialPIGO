<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("AC_ID")
    CA_Name = request.queryString("CA_Name")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID Like '%"& CA_ID &"%' AND CA_Name Like '%"& CA_Name &"%'"
        'response.Write GL_M_ChartAccount_cmd.commandText
    set CAID = GL_M_ChartAccount_cmd.execute

%>
<div class="col-12">
    <% if CAID.eof = true then %>
    <span> Data Tidak Ditemukan ! </span>
    <% else %>
    <% 
        no = 0 
        do while not CAID.eof 
        no = no + 1
    %>
        <div class="row ">
            <div class="col-4">
                <input readonly onclick="getDataACID<%=no%>()"type="text" style="width:100%"  class="mb-1 text-center cont-form" name="AC_ID" id="AC_ID<%=no%>" value="<%=CAID("CA_ID")%>">
            </div>
            <div class="col-8">
                <input readonly onclick="getDataACID<%=no%>()"type="text" style="width:100%"  class="mb-1 cont-form" name="ACC_Name" id="ACC_Name<%=no%>" value="<%=CAID("CA_Name")%>">
            </div>
        </div>
        <script>
            function getDataACID<%=no%>(){
                $.ajax({
                    type: "get",
                    url: "Update-GL/upd-ACIDD.asp?AC_ID="+document.getElementById("AC_ID<%=no%>").value,
                    success: function (url) {
                    $('.Upd-LISTACID').html(url);
                    document.getElementById("cont-up-d").style.display = "none";
                    }
                });
            }
        </script>

    <% CAID.movenext
    loop %>
    <% end if %>
</div>