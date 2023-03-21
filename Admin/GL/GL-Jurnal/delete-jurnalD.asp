<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->
<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if
    Detail       = request.Form("Kode")
    JR_ID        = request.Form("JR_ID")
    JRD_ID       = request.Form("JRD_ID")
    
        set Jurnal_H_CMD = server.CreateObject("ADODB.command")
        Jurnal_H_CMD.activeConnection = MM_pigo_STRING

    if Detail = "DE" then

        Jurnal_H_CMD.commandText = "DELETE FROM GL_T_Jurnal_D WHERE JRD_ID = '"& JRD_ID &"'  "
        'response.write Jurnal_H_CMD.commandText 
        set JurnalD = Jurnal_H_CMD.execute


        Log_ServerID 	= "" 
        Log_Action   	= "DELETE"
        Log_Key         = JRD_ID
        Log_Keterangan  = "Hapus ID Jurnal Detail berdasarakan Jurnal Detail ID : "& JRD_ID &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    else 
    
        Jurnal_H_CMD.commandText = "DELETE FROM GL_T_Jurnal_D WHERE LEFT(JRD_ID,12) = '"& JR_ID &"'  "
        'response.write Jurnal_H_CMD.commandText 
        set JurnalD = Jurnal_H_CMD.execute

        Log_ServerID 	= "" 
        Log_Action   	= "DELETE"
        Log_Key         = JR_ID
        Log_Keterangan  = "Hapus ID Jurnal Detail berdasarakan Jurnal Header ID : "& JR_ID &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    end if 

    
%>