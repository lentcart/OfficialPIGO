<!--#include file="../../../connections/pigoConn.asp"-->
<%
    if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if
			
	set Alamat_cmd =  server.createObject("ADODB.COMMAND")
    Alamat_cmd.activeConnection = MM_PIGO_String

    Alamat_cmd.commandText = "SELECT MKT_M_Alamat.almID, MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong, MKT_M_Alamat.alm_custID,   MKT_M_Alamat.almUpdateID, MKT_M_Alamat.almAktifYN, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custPhone3, MKT_M_Seller.slName FROM MKT_M_Alamat LEFT OUTER JOIN  MKT_M_Seller ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID LEFT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where alm_custID = '"& request.Cookies("custID") &"' and MKT_M_Alamat.almJenis = 'Alamat Toko' "
    'response.write Alamat_cmd.commandText
    set Alamat = Alamat_CMD.execute

%>
<% if Alamat.eof = true then%>
    <div class="row d-alamat mt-3">
        <div class="col-12">
            <span class="txt-dsc-alamat"> Tidak Ada Alamat </span>
        </div>
    </div>
<% else %>

<% do while not Alamat.EOF %>
<div class="row d-alamat mt-3">
    <div class="col-10">
        <div class="row mt-1">
            <div class="col-12">
                <span class="txt-dsc-alamat"> <%=Alamat("almJenis")%> </span><br>
            </div>
        </div>
        <div class="row mt-1">
            <div class="col-4">
                <span class="txt-dsc-alamat"> <%=Alamat("almNamaPenerima")%> </span><br>
            </div>
            <div class="col-2">
                <span class="txt-dsc-alamat label-alamat"> <%=Alamat("almLabel")%> </span>
            </div>
            <div class="col-3">
                <span class="txt-dsc-alamat label-alamat"> <%=Alamat("almJenis")%> </span>
            </div>
        </div>
        <div class="row ">
            <div class="col-12">
                <span class="txt-dsc-alamat"> <b><%=Alamat("almPhonePenerima")%></b> </span><br>
                <span class="txt-dsc-alamat"> <%=Alamat("almLengkap")%> </span><br>
                <span class="txt-dsc-alamat"> <%=Alamat("almDetail")%> </span><br>
                <span class="txt-dsc-alamat"> <%=Alamat("almKel")%> - <%=Alamat("almKec")%> - <%=Alamat("almKota")%> - <%=Alamat("almProvinsi")%> - <%=Alamat("almKdpOs")%></span><br>
            </div>
        </div>
    </div>
    <div class="col-2">
        <span class="txt-dsc-alamat"> Ubah Alamat </span>
    </div>
</div>
<% Alamat.movenext
loop%>
<% end if %>