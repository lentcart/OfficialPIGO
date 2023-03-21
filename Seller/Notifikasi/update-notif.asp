<!--#include file="../../connections/pigoConn.asp"-->
<%

    if request.Cookies("custEmail")="" then 
 
    response.redirect("../")
    
    end if
    NotifID = request.queryString("NotifID")

    set Notifikasi_CMD =  server.createObject("ADODB.COMMAND")
    Notifikasi_CMD.activeConnection = MM_PIGO_String

    if NotifID = "" then 
        Notifikasi_CMD.commandText = "UPDATE MKT_M_Notifikasi_D set NotifReadYN = 'Y'"
        set Notif = Notifikasi_CMD.execute
    else
        Notifikasi_CMD.commandText = "UPDATE MKT_M_Notifikasi_D set NotifReadYN = 'Y' Where NotifIDD = '"& NotifID &"'"
        set Notif = Notifikasi_CMD.execute
    end if 

%>