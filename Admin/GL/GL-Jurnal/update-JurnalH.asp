<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->
<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

    JR_ID      = request.Form("JR_ID")
    Proses1      = request.Form("Proses1")
    if Proses1 = "" then
        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING
        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_H SET JR_AktifYN = '"& Proses1 &"' WHERE JR_ID = '"& JR_ID &"'  "
        response.write Jurnal_H_CMD.commandText 
        set Jurnal = Jurnal_H_CMD.execute

        Log_ServerID 	= "" 
        Log_Action   	= "SAVED"
        Log_Key         = JR_ID
        Log_Keterangan  = "Saved transaksi Jurnal ID : "& JR_ID &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    else 
        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING
        Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_H SET JR_AktifYN = 'Y' WHERE JR_ID = '"& JR_ID &"'  "
        response.write Jurnal_H_CMD.commandText 
        set Jurnal = Jurnal_H_CMD.execute
    end if
%>