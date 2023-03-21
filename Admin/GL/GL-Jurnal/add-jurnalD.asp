<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->
<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if
    JRD_ID          = request.queryString("JRD_ID")
    JRD_CA_ID       = request.queryString("JRD_CA_ID")
    JRD_Keterangan  = request.queryString("JRD_Keterangan")
    JRD_Debet       = request.queryString("JRD_Debet")
    JRD_Kredit      = request.queryString("JRD_Kredit")

    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_pigo_STRING
    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_D  '"& JRD_ID &"', '"& JRD_CA_ID &"', '"& JRD_Keterangan &"', '"& JRD_Debet &"', '"& JRD_Kredit &"' "
    'response.write Jurnal_H_CMD.commandText 
    set JurnalD = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "SELECT GL_T_Jurnal_D.JRD_CA_ID, GL_M_ChartAccount.CA_Name,GL_T_Jurnal_D.JRD_Keterangan, GL_T_Jurnal_D.JRD_Debet, GL_T_Jurnal_D.JRD_Kredit,GL_T_Jurnal_H.JR_Status, GL_T_Jurnal_D.JRD_ID FROM GL_M_ChartAccount RIGHT OUTER JOIN GL_T_Jurnal_D ON GL_M_ChartAccount.CA_ID = GL_T_Jurnal_D.JRD_CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID Where JR_ID = '"& JRD_ID &"' "
    'response.write Jurnal_H_CMD.commandText 
    set JurnalD = Jurnal_H_CMD.execute

    Log_ServerID 	= "" 
    Log_Action   	= "CREATE"
    Log_Key         = JRD_ID
    Log_Keterangan  = "Tambah Jurnal Detail berdasarkan ID Jurnal Header : "& JRD_ID &" Account Kas : "& JRD_CA_ID &" dengan keterangan "& JRD_Keterangan &" besaran nilai Debet "& JRD_Debet &" Kredit "& JRD_Kredit &" pada : "& Date()
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)
%>
<div class="mt-2 cont-rincian-data-jurnal" id="cont-rincian-data-jurnal">
    <div class="row text-center" >
        <div class="col-12">
            <table class="cont-text cont-tb table  table-bordered table-condensed" style="font-size:12px">
                <thead>
                    <tr class="text-center">
                        <th>ACTION</th>
                        <th colspan="2">KODE PERKIRAAN</th>
                        <th>KETERANGAN</th>
                        <th>DEBET</th>
                        <th>KREDIT</th>
                    </tr>
                </thead>
                <tbody class="datatr">
                    <% 
                        no = 0 
                        do while not JurnalD.eof 
                        no = no + 1
                    %>
                    <tr class="text-center">
                        <td>
                            <% if JurnalD("JR_Status") = "JR" then %>
                            <button onclick="deleteJurnalD<%=no%>()" name="delete-rincian" id="delete-rincian<%=no%>" class="delete-rincian cont-btn" style="display:block"> DELETE </button>
                            <input type="hidden" name="JRD_ID" id="JRD_ID<%=no%>" Value="<%=JurnalD("JRD_ID")%>">
                            <span class="cont-text label-stpo6" name="span-tb" id="span-tb" style="display:none"> <i class="fas fa-check"></i> </span>
                            <% else %>
                            <span class="cont-text label-stpo6" name="span-tb" id="span-tb"> <i class="fas fa-check"></i> </span>
                            <% end if %>
                        </td>
                        <td> <%=JurnalD("JRD_CA_ID")%> </td>
                        <td> <%=JurnalD("CA_Name")%> </td>
                        <td> <%=JurnalD("JRD_Keterangan")%> </td>
                        <td> <%=JurnalD("JRD_Debet")%> </td>
                        <td> <%=JurnalD("JRD_Kredit")%> </td>
                    </tr>
                    <script>
                        function deleteJurnalD<%=no%>(){
                            var JRD_ID = document.getElementById("JRD_ID<%=no%>").value;
                            var Kode   = "DE";
                            $.ajax({
                                type: "POST",
                                url: "delete-jurnalD.asp",
                                data: {
                                    JRD_ID,
                                    Kode
                                },
                                success: function (data) {
                                    Swal.fire('Deleted !!', data.message, 'success').then(() => {
                                    location.reload();
                                    });
                                }
                            });
                        }
                    </script>
                        <% 
                            totaldebet = totaldebet + JurnalD("JRD_Debet") 
                            totalkredit = totalkredit + JurnalD("JRD_Kredit") 
                        %>
                    <% JurnalD.movenext
                    loop %>
                </tbody>
                    <tr class="text-center">
                        <th colspan="4">TOTAL</th>
                        <td ><%=totaldebet%></td>
                        <td ><%=totalkredit%></td>
                    </tr>
                    <tr class="text-center">
                        <th colspan="4">SELISIH</th>
                        <% selisih = totalkredit - totaldebet%>
                        <td colspan="2">
                            <input class="text-center cont-text"  type="number" name="selisih" id="selisih" value="<%=selisih%>" style="border:none">
                            
                        </td>
                    </tr>
            </table>
        </div>
    </div>
</div>
<script>
    var hasil = document.getElementById("selisih").value;
    if(hasil == 0){
        document.getElementById("comp").style.display = "block"
    }else{
        document.getElementById("comp").style.display = "none"
    }
</script>
<div class="complete" id="comp" style="display:none">
    <div class="row align-items-center mt-2">
        <div class="col-3">
            <div class="form-check">
                <input onclick="comp()" class="form-check-input" type="checkbox" id="check1" name="option1" value="something" >
                <label class="cont-text form-check-label">Complete Rincian</label>
            </div>
        </div>
        <div class="col-2">
            <button onclick="DelDetailJurnal()" name="clear-jurnal" id="clear-jurnal" class="cont-btn" style="display:block"> Clear Rincian Jurnal </button>
        </div>
    </div>
</div>
<script>
    function comp(){
        var JR_ID = document.getElementById("JRD_ID").value;
        var Proses1 = "P";
        var complete = document.getElementById("check1");
        if (!complete.checked){
            $.ajax({
                type: "POST",
                url: "update-JurnalH.asp",
                data: {
                    JR_ID,
                    Proses1
                },
                success: function (data) {
                }
            });
            document.getElementById("cont-simpan-jurnal").style.display = "none" 
            document.getElementById("rincian-data-jurnal").style.display = "block" 
            document.getElementById("clear-jurnal").style.display = "block" 
            // $('button[name=delete-rincian]').html("DELETE");
            $('button[name=delete-rincian]').attr("style", "display:block")
            $('span[name=span-tb]').attr("style", "display:none")
        }else{
            
            $.ajax({
                type: "POST",
                url: "update-JurnalH.asp",
                data: {
                    JR_ID
                },
                success: function (data) {
                    alert("Proses Berhasil Complete !!");
                }
            });
            document.getElementById("cont-simpan-jurnal").style.display = "block" 
            document.getElementById("rincian-data-jurnal").style.display = "none" 
            document.getElementById("clear-jurnal").style.display = "none" 
            // $('button[name=delete-rincian]').html("-");
            $('span[name=span-tb]').attr("style", "display:block")
            $('button[name=delete-rincian]').attr("style", "display:none")
        }
    }


    
    
</script>
<div class="cont-simpan-jurnal" id="cont-simpan-jurnal" style="display:none">
    <div class="row mt-2">
        <div class="col-2">
            <button onclick="simjurnal()" class="cont-btn"> Simpan </button>
        </div>
        <div class="col-2">
            <button onclick="window.open('jurnal-voucher.asp?JR_ID='+document.getElementById('JRD_ID').value,'_Self')"  class="cont-btn"> Cetak </button>
        </div>
        <div class="col-2">
            <button onclick="window.open('index.asp','_Self')" class="cont-btn"> Kembali </button>
        </div>
    </div>
    <script>
        function simjurnal(){
            var JR_IDD = document.getElementById("JRD_ID").value;
            var Proses11 = "D";
            $.ajax({
                type: "POST",
                url: "update-JurnalH.asp",
                data: {
                    JR_ID : JR_IDD,
                    Proses1 : Proses11
                },
                success: function (data) {
                    Swal.fire('Jurnal Berhasil Di Simpan', data.message, 'success').then(() => {
                    location.reload();
                    });
                }
            });
            document.getElementById("comp").style.display = "none" 
        }
    </script>
</div>