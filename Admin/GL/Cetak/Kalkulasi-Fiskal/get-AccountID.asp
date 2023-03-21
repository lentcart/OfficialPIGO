<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    CA_ID = request.queryString("CAID")
    CA_Name = request.queryString("CANAME")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String

    if CA_ID = "" then 
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_Name Like '%"& CA_Name &"%' "
        set ACCID = GL_M_ChartAccount_cmd.execute
    else 
        GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_ID Like '%"& CA_ID &"%' "
        set ACCID = GL_M_ChartAccount_cmd.execute
    end if 

%>
<div class="accountid-cont" id="accountid-cont">
    <table class=" align-items-center cont-tb table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px;">
    <% if ACCID.eof = true then %>
        <tr>
            <td class="text-center" colspan="3">DATA TIDAK DITEMUKAN</td>
        </tr>
    <% else %>
        <% 
            no = 0 
            do while not ACCID.eof 
            no = no + 1
        %>
            <tr>
                <td class="text-center"> 
                    <%=ACCID("CA_ID")%> 
                    <input type="hidden" name="CAID" id="CAID<%=ACCID("CA_ID")%>" value="<%=ACCID("CA_ID")%>">
                </td>
                <td class="text-start"> <%=ACCID("CA_Name")%> </td>
                <td class="text-center"> <button onclick="addGLMFiskalD<%=no%>()" class="cont-btn"> TAMBAHKAN </button> </td>
            </tr>
            <script>
                function addGLMFiskalD<%=no%>(){
                    var CAID      = document.getElementById("CAID<%=ACCID("CA_ID")%>").value;
                    var FMID      = document.getElementById("FMID").value;
                    var FM_JenisKoreksi      = document.getElementById("FM_JenisKoreksi").value;
                    $.ajax({
                        type: "get",
                        url: "add-GLMFiskalD.asp",
                        data:{
                            CAID,
                            FMID,
                            FM_JenisKoreksi
                        },
                        success: function (data) {
                            $('.rincian-acc-komponen').html(data);
                            $('.accountid-cont').hide();
                        }
                    });
                }
            </script>
        <% ACCID.movenext
        loop %>
    <% end if  %>
    </table>
</div>