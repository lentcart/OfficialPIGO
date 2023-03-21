<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    CB_ID = request.Form("CB_ID")
    CBD_ID = request.Form("CBD_ID")

    set Kas_Detail_CMD = server.CreateObject("ADODB.command")
    Kas_Detail_CMD.activeConnection = MM_pigo_STRING
    
    IF CBD_ID = "" then

        Kas_Detail_CMD.commandText = "DELETE FROM GL_T_CashBank_H WHERE CB_ID = '"& CB_ID &"'  "
        set DataKasH = Kas_Detail_CMD.execute
        Kas_Detail_CMD.commandText = "DELETE FROM GL_T_CashBank_D WHERE LEFT(CBD_ID,18) = '"& CB_ID &"'  "
        set DataKasD = Kas_Detail_CMD.execute

    ELSE

        Kas_Detail_CMD.commandText = "DELETE FROM GL_T_CashBank_D WHERE CBD_ID = '"& CBD_ID &"'  "
        set DataKasD = Kas_Detail_CMD.execute

    END IF 

%>