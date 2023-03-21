<!--#include file="../../../../Connections/pigoConn.asp" -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    if Session("Username")="" then 

    response.redirect("../../../../admin/")
    
    end if
    tgla            = Cdate("2022-09-01")
    tgle            = Cdate("2022-10-31")
    Bulan           = MONTH("2022-09-01")
    Tahun           = YEAR("2022-09-01")
    pdID            = "P072200002"
    

    set SAPD_CMD = server.CreateObject("ADODB.command")
    SAPD_CMD.activeConnection = MM_pigo_STRING
    SAPD_CMD.commandText = "SELECT SAPD_pdID FROM MKT_T_SAPD WHERE SAPD_pdID = '"& pdID &"' and SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' "
    'response.Write SAPD_CMD.commandText & "<br><br>"
    set SAPD = SAPD_CMD.execute

    if SAPD.eof = true then
        
    else
        
    end if

%>



