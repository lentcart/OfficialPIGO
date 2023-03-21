<!--#include file="../../../../Connections/pigoConn.asp" -->

<% 
    FMD_ID              = request.queryString("FMID")
    FMD_CA_ID           = request.queryString("CAID")
    FM_JenisKoreksi     = request.queryString("FM_JenisKoreksi")

    set KalkulasiFiskal_CMD = server.CreateObject("ADODB.command")
    KalkulasiFiskal_CMD.activeConnection = MM_pigo_STRING
    KalkulasiFiskal_CMD.commandText = "INSERT INTO [dbo].[GL_M_Fiskal_D]([FMD_ID],[FMD_CA_ID],[FMD_Value])VALUES('"& FMD_ID &"','"& FMD_CA_ID &"',100)"
    'response.write KalkulasiFiskal_CMD.commandText
    set KalkulasiFiskalD = KalkulasiFiskal_CMD.execute

    KalkulasiFiskal_CMD.commandText = "SELECT GL_M_Fiskal_D.FMD_ID, GL_M_Fiskal_D.FMD_CA_ID, GL_M_Fiskal_D.FMD_Value, GL_M_ChartAccount.CA_Name, GL_M_Fiskal_H.FM_JenisKoreksi FROM GL_M_Fiskal_D RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_M_Fiskal_D.FMD_CA_ID = GL_M_ChartAccount.CA_ID WHERE FMD_ID = '"& FMD_ID &"' AND FM_JenisKoreksi = '"& FM_JenisKoreksi &"' "
    'response.write KalkulasiFiskal_CMD.commandText
    set GLMFiskalD = KalkulasiFiskal_CMD.execute
%>
<table class=" align-items-center cont-tb table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px;">
            <tr class="text-center">
                <th> KODE AKUN </th>
                <th> NAMA AKUN </th>
                <th> VALUE (%) </th>
                <th> AKSI </th>
            </tr>
        <% 
            no = 0 
            do while not GLMFiskalD.eof 
            no = no + 1
        %>
            <tr>
                <td class="text-center"> 
                    <%=GLMFiskalD("FMD_CA_ID")%> 
                    <input type="hidden" name="CA_ID" id="CA_ID<%=no%>" value="<%=GLMFiskalD("FMD_CA_ID")%>">
                    <input type="hidden" name="FMD_ID" id="FMD_ID<%=no%>" value="<%=GLMFiskalD("FMD_ID")%>">
                    <input type="hidden" name="FM_JenisKoreksi" id="FM_JenisKoreksi<%=no%>" value="<%=FM_JenisKoreksi%>">
                </td>
                <td class="text-start"> <%=GLMFiskalD("CA_Name")%> </td>
                <td class="text-center"> <input onkeyup="addValue<%=no%>()" type="number" class="text-end cont-form" name="FMD_Value" id="FMD_Value<%=no%>" value="<%=GLMFiskalD("FMD_Value")%>" style="width:5rem"> </td>
                <td class="text-center"> <button onclick="DeleteGLMFiskalD<%=no%>()" class="cont-btn"> HAPUS </button> </td>
            </tr>
            <script>
                function addValue<%=no%>(){
                    var FMD_CA_ID   = document.getElementById("CA_ID<%=no%>").value;
                    var FMD_ID      = document.getElementById("FMD_ID<%=no%>").value;
                    var FMD_Value   = document.getElementById("FMD_Value<%=no%>").value;
                    $.ajax({
                        type: "get",
                        url: "up-ValueFiskalD.asp",
                        data:{
                            FMD_ID,
                            FMD_CA_ID,
                            FMD_Value
                        },
                        success: function (data) {
                        }
                    });
                }
                function DeleteGLMFiskalD<%=no%>(){
                    var FMD_CA_ID       = document.getElementById("CA_ID<%=no%>").value;
                    var FMD_ID          = document.getElementById("FMD_ID<%=no%>").value;
                    var FMD_Value       = document.getElementById("FMD_Value<%=no%>").value;
                    var FM_JenisKoreksi = document.getElementById("FM_JenisKoreksi<%=no%>").value;
                    $.ajax({
                        type: "get",
                        url: "del-GLMFiskalD.asp",
                        data:{
                            FMD_ID,
                            FMD_CA_ID,
                            FMD_Value,
                            FM_JenisKoreksi
                        },
                        success: function (data) {
                            $('.rincian-acc-komponen').html(data);
                        }
                    });
                }
            </script>
        <% GLMFiskalD.movenext
        loop %>
    </table>