<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->
<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

    JR_ID = request.Form("JR_ID")

        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING
        Jurnal_H_CMD.commandText = "DELETE FROM GL_T_Jurnal_H WHERE JR_ID = '"& JR_ID &"'  "
        'response.write Jurnal_H_CMD.commandText 
        set JurnalH = Jurnal_H_CMD.execute
    
        Log_ServerID 	= "" 
        Log_Action   	= "DELETE"
        Log_Key         = JR_ID
        Log_Keterangan  = "Membatalkan proses input transaksi Jurnal berdasarakan ID : "& JR_ID &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)
%>