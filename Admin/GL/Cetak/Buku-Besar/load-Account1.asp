<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../../admin/")
    
    end if

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
    set AccountKas = GL_M_ChartAccount_cmd.execute

%>
<div class="row">
    <div class="col-12">
        <table class="table table-bordered cont-text p-0" style="font-size:12px">
        <% do while not AccountKas.eof %>
            <tr>
                <td class="text-center"> 
                    <input onclick="getAccountKas<%=AccountKas("CA_ID")%>()" class="text-center cont-form" readonly type="text" name="CA_ID" id="CA_ID<%=AccountKas("CA_ID")%>" value="<%=AccountKas("CA_ID")%> ">
                </td>
                <td> <%=AccountKas("CA_Name")%> </td>
            </tr>
            <script>
                function getAccountKas<%=AccountKas("CA_ID")%>(){
                    $.ajax({
                        type: "get",
                        url: "get-Account1.asp?CA_ID="+document.getElementById("CA_ID<%=AccountKas("CA_ID")%>").value,
                        success: function (url) {
                            $('.cont-acc-1').html(url);
                            document.getElementById("cont-acc").style.display = "none"
                        }
                    });
                }
            </script>
        <% AccountKas.movenext
        loop %>
        </table>
    </div>
</div>