<!--#include file="../../connections/pigoConn.asp"-->
<%

    if request.Cookies("custEmail")="" then 
 
    response.redirect("../")
    
    end if

    set Notifikasi_CMD =  server.createObject("ADODB.COMMAND")
    Notifikasi_CMD.activeConnection = MM_PIGO_String

    Notifikasi_CMD.commandText = "SELECT COUNT(NotifIDD) AS SemuaNotif FROM MKT_M_Notifikasi_D WHERE NotifReadYN = 'N'"
    set Notif = Notifikasi_CMD.execute

    Notifikasi_CMD.commandText = "SELECT TOP 1 MKT_M_Notifikasi_D.NotifIDD, MKT_M_Notifikasi_D.NotifType, MKT_M_Notifikasi_D.NotifDesc, MKT_M_Notifikasi_D.NotifReadYN, MKT_M_Notifikasi_D.NotifUserID, CAST(MKT_M_Notifikasi_D.NotifUpdateTime AS date) AS Tanggal,CONVERT(VARCHAR(5), MKT_M_Notifikasi_D.NotifUpdateTime,108) AS Waktu ,MKT_M_Notifikasi_H.NotifID FROM MKT_M_Notifikasi_D LEFT OUTER JOIN MKT_M_Notifikasi_H ON Left(MKT_M_Notifikasi_D.NotifIDD,2) = MKT_M_Notifikasi_H.NotifID WHERE NotifUserID = '"& request.cookies("custID") &"' AND NotifReadYN = 'N' ORDER BY NotifUpdateTime DESC "
    set NotifDetail = Notifikasi_CMD.execute

    if not NotifDetail.eof then


            Response.Write "{"
                Response.Write """NotifIDD""" & ":" & """" & NotifDetail("NotifIDD") & """" & ","
                Response.Write """NotifType""" & ":" & """" & NotifDetail("NotifType") & """" & "," 
                Response.Write """NotifDesc""" & ":" & """" & NotifDetail("NotifDesc") & """" & "," 
                Response.Write """NotifReadYN""" & ":" & """" & NotifDetail("NotifReadYN") & """" & "," 
                Response.Write """NotifUserID""" & ":" & """" & NotifDetail("NotifUserID") & """" & "," 
                Response.Write """Tanggal""" & ":" & """" & NotifDetail("Tanggal") & """" & "," 
                Response.Write """Waktu""" & ":" & """" & NotifDetail("Waktu") & """" & "," 
                Response.Write """NotifID""" & ":" & """" & NotifDetail("NotifID") & """"  & "," 
                Response.Write """statusnotif"""  & ":" & """Y"""  
            Response.Write "}"


    else

            Response.Write "{"
                Response.Write """statusnotif""" & ":" & """NULL"""  
            Response.Write "}"


    end if

%>