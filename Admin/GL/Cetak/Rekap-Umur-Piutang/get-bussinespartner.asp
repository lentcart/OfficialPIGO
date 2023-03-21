<!--#include file="../../../../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    custID = request.queryString("custID")


    id = Split(request.queryString("custID"),",")

    if custID = "" then
    id = "Xh868hdgXJuy86"
    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String

        BussinesPartner_cmd.commandText = "SELECT MKT_M_Customer.custNama, MKT_M_Customer.custID FROM GL_T_RekapUmurPiutang LEFT OUTER JOIN MKT_M_Customer ON GL_T_RekapUmurPiutang.RUP_custID = MKT_M_Customer.custID WHERE custID = '"& id &"' GROUP BY MKT_M_Customer.custNama, MKT_M_Customer.custID ORDER BY custNama ASC "
        'response.write BussinesPartner_cmd.commandText

    set bussines = BussinesPartner_cmd.execute
    else 
    for each x in id
        if len(x) > 0 then

            filtercust = filtercust & addOR & " MKT_M_Customer.custID = '"& x &"' "

            addOR = " or " 
                    
        end if

    next

        if filtercust <> "" then
            FilterFix = "( " & filtercust & " )" 
        end if

    'response.write FilterFix

    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String

        BussinesPartner_cmd.commandText = "SELECT MKT_M_Customer.custNama, MKT_M_Customer.custID FROM GL_T_RekapUmurPiutang LEFT OUTER JOIN MKT_M_Customer ON GL_T_RekapUmurPiutang.RUP_custID = MKT_M_Customer.custID WHERE "& FilterFix &" GROUP BY MKT_M_Customer.custNama, MKT_M_Customer.custID ORDER BY custNama ASC "
        'response.write BussinesPartner_cmd.commandText

    set bussines = BussinesPartner_cmd.execute

    end if
%>
<style>
    .a{
        background:white;
        border:1px solid black;
        padding:5px 10px;
        height:2.3rem;
    }
</style>
<div class="a align-items-center">
    <% if bussines.eof = true then %>
    <span class="cont-text"> Pilih Salah Satu Bussines Partner </span>
    <% else %>
    <% do while not bussines.eof %>
    <button class="cont-btn" style="width:5rem"> <input class=" text-center cont-form" type="text" name="c" id="c" value="<%=bussines("custNama")%>" style="width:3rem;border:none; background:none"> <i class="fas fa-times"></i> </button>
    <% bussines.movenext
    loop%>
    <% end if %>
</div>
