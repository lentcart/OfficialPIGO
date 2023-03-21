<!--#include file="../../connections/pigoConn.asp"-->
<%

    set Transaksi_H_CMD = server.CreateObject("ADODB.command")
    Transaksi_H_CMD.activeConnection = MM_pigo_STRING


    Transaksi_H_CMD.commandText = "SELECT TOP 100 MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trPembayaranYN, MKT_T_Transaksi_D1.tr_IDBooking FROM MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1,12) WHERE (MKT_T_Transaksi_H.trPembayaranYN = 'N') ORDER BY trUpdateTime ASC"
    set Transaksi = Transaksi_H_CMD.execute 

    response.ContentType = "Application/json;charset=utf-8"

    if not Transaksi.eof then

        Response.Write "["
        do until Transaksi.eof
            Response.Write "{"
                Response.Write """external_id""" & ":" & """" & Transaksi("trID") & """" & ","
                Response.Write """bookingid""" & ":" & """" & Transaksi("tr_IDBooking") & """" & "," 
                Response.Write """statustransaksi""" & ":" & """" & Transaksi("trPembayaranYN") & """"  
            Response.Write "}"
        Transaksi.movenext
            if Transaksi.eof = false then
                response.write ","
            end if 
        loop
        Response.Write "]"

    else

        Response.Write "["
            Response.Write "{"
                Response.Write """statustransaksi""" & ":" & """Y"""  
            Response.Write "}"
        Response.Write "]" 

    end if
    
%>
