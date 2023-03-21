<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("caid")
    JR_Type = request.queryString("jrtype")
    'response.write JR_Type
    if JR_Type  = "M" then 
    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE  CA_Name Like '%"& CA_ID &"%' AND CA_Type <> 'H' AND CA_ItemTipe <> 'C' AND CA_ID <> 'A100.02.00' AND CA_UpID <> 'A100.02.00'"
    'response.write GL_M_ChartAccount_cmd.commandText
    set AccountKas = GL_M_ChartAccount_cmd.execute 
    else 
    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount  WHERE  CA_ID Like '%"& CA_ID &"%' AND CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
    'response.write GL_M_ChartAccount_cmd.commandText
    set AccountKas = GL_M_ChartAccount_cmd.execute 
    end if

%>
<div class="col-6">
    <table class=" table tb-account-id tb-transaksi table-bordered table-condensed p-0">
        <% if AccountKas.eof = true then %>
        <tr>
            <td class="text-center" style="width:25%;"> Data Tidak Ditemukan </td>
        </tr>
        <% else %>
        <% 
            no = 0 
            do while not AccountKas.eof 
            no = no+1
        %>
        <tr>
            <td class="text-center" style="width:25%;"> <input onclick="getAccount<%=no%>()" readonly  class="cont-form text-center"type="text" name="ACID" id="ACID<%=no%>" value="<%=AccountKas("CA_ID")%>" style="width:100%; border:none"> </td>
            <td> <input  onclick="getAccount<%=no%>()" class="cont-form" type="text" name="CA_Name" id="CA_Name" value="<%=AccountKas("CA_Name")%>" style="width:100%; border:none"> </td>
        </tr>
        <script>
            function getAccount<%=no%>(){
                $.ajax({
                    type: "get",
                    url: "get-Account.asp?CA_ID="+document.getElementById("ACID<%=no%>").value,
                    success: function (url) {
                    $('.Account-Kas-Cont').html(url);
                    }
                });
                document.getElementById("cont-account-id").style.display = "none";
            }
        </script>
        <% AccountKas.movenext
        loop %>
        <% end if %>
    </table>
<div>