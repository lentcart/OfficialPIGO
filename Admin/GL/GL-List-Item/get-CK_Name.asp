<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("CA_IK")
    CA_Name = request.queryString("CA_NameK")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID Like '%"& CA_ID &"%' AND CA_Name Like '%"& CA_Name &"%' AND NOT CA_Type = 'H' "
    set ACCIK = GL_M_ChartAccount_cmd.execute

%>
<div class="col-12">
    <table class=" table tb-transaksi cont-text table-bordered table-condensed p-0">
    <% if ACCIK.eof = true then %>
        <tr>
            <td class="center"> Data Tidak Ditemukan </td>
        </tr>
    <% else %>
    <% 
        no= 0 
        do while not ACCIK.eof 
        no = no+1
    %>
        <tr>
            <td class="text-center" style="width:25%;"> <input class="cont-form" onclick="getACCIK<%=no%>()"class="cont-form text-center"type="text" name="ACC_ACIK" id="ACC_ACIK<%=no%>" value="<%=ACCIK("CA_ID")%>" style="width:100%; border:none"> </td>
            <td> <input  class="cont-form"onclick="getACCIK<%=no%>()"type="text" name="CA_Name" id="CA_Name" value="<%=ACCIK("CA_Name")%>" style="width:100%; border:none"> </td>
        </tr>
        <script>
            function getACCIK<%=no%>(){
            var accid = document.getElementById("ACC_ACID<%=no%>").value;
            
            $.ajax({
                type: "get",
                url: "get-ACCIK.asp?ACC_ACID="+document.getElementById("ACC_ACIK<%=no%>").value,
                success: function (url) {
                
                $('.CONTACCIK').html(url);
                }
            });
            document.getElementById("ACIDADK").style.display = "none";
        }
        </script>
    <% ACCIK.movenext
    loop %>
    <% end if %>
    </table>
</div>