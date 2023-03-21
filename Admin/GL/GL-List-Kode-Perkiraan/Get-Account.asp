<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    CA_ID = Request.QueryString("accountid")

    set GL_M_GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
    GL_M_GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount WHERE CA_ID = '"& CA_ID &"' "
    'response.WRITE GL_M_GL_M_ChartAccount_cmd.commandText 
    set CID = GL_M_GL_M_ChartAccount_cmd.execute

    GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT MAX(CA_ID) AS LastID  FROM GL_M_ChartAccount WHERE CA_UpID = '"& CA_ID &"' "
    'response.WRITE GL_M_GL_M_ChartAccount_cmd.commandText 
    set LastCID = GL_M_GL_M_ChartAccount_cmd.execute

    GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT  CA_Name FROM GL_M_ChartAccount WHERE CA_ID = '"& LastCID("LastID") &"' "
    'response.WRITE GL_M_GL_M_ChartAccount_cmd.commandText 
    set LastCName = GL_M_GL_M_ChartAccount_cmd.execute

    
    do while not CID.eof

        AccountName     = CID("CA_Name")
        AccountID       = CID("CA_ID")
        AccountUP       = CID("CA_UpID")
        CA_Jenis        = CID("CA_Jenis")
        CA_Type         = CID("CA_Type")
        CA_Golongan     = CID("CA_Golongan")
        CA_Kelompok     = CID("CA_Kelompok")
        CA_ItemTipe     = CID("CA_ItemTipe")

    CID.movenext
    loop

        LastAccountID       = LastCID("LastID")
        if LastCName.eof = false then
        LastAccountName     = LastCName("CA_Name")
        end if
%>
<form class="" method="POST" action="P-NewAccount.asp">
<div class="cont-new-account" style="background-color:#eee; padding: 10px 20px; border-radius:10px; margin-top:10px; margin-bottom:10px">
    <div class="row ">
        <div class="col-12">
            <span class="cont-text"> Nama Header Account <b>( <%=AccountName%> - <%=AccountID%> )</b> </span>
        </div>
    </div>
    <div class="row mt-2 ">
        <div class="col-3">
            <span class="cont-text"> Type Account </span>
            <% if CA_Type = "H" then %>
            <input class="text-center cont-form" readonly type="text" value="Header">
            <% else %>
            <input class="text-center cont-form" readonly type="text" value="Detail">
            <% end if %>
        </div>
        <div class="col-3">
            <span class="cont-text"> Last Account ID (Detail)  </span>
            <input class="text-center cont-form" readonly type="text" value="<%=LastAccountID%>">
        </div>
        <div class="col-6">
            <span class="cont-text"> Last Account Name (Detail)  </span>
            <input class="cont-form" readonly type="text" value="<%=LastAccountName%>">
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-3">
            <span class="cont-text"> Account ID (Detail) Baru  </span>
            <input class="cont-form" type="hidden" name="CA_IDHeader" id="CA_IDHeader" value="<%=AccountID%>">
            <input Required class="cont-form" type="text" name="CA_IDDetail" id="CA_IDDetail" value="">
        </div>
        <div class="col-9">
            <span class="cont-text"> Masukan Nama Account (Detail) Baru </span>
            <input Required class="cont-form" type="text" name="CA_Name" id="CA_Name" value="">
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <!-- Data Account -->
                <input type="hidden" name="CA_UpIDNew" id="CA_UpIDNew" value="<%=AccountUP%>">
                <input type="hidden" name="CA_Jenis" id="CA_Jenis" value="<%=CA_Jenis%>">
                <input type="hidden" name="CA_Type" id="CA_Type" value="D">
                <input type="hidden" name="CA_Golongan" id="CA_Golongan" value="<%=CA_Golongan%>">
                <input type="hidden" name="CA_Kelompok" id="CA_Kelompok" value="<%=CA_Kelompok%>">
                <input type="hidden" name="CA_ItemTipe" id="CA_ItemTipe" value="<%=CA_ItemTipe%>">
            <!-- Data Account -->
        </div>
    </div>
    <div class="row mt-2 text-center">
        <div class="col-12">
            <input type="submit" class="cont-btn" name="up-account" id="up-account" value="TAMBAH">
        </div>
    </div>
</div>
</form>
