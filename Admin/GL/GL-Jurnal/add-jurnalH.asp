<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->
<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

    JR_Tanggal      = request.Form("JR_Tanggal")
    JR_Keterangan   = request.Form("JR_Keterangan")
    JR_Type         = request.Form("JR_Type")
    JR_UpdateID     = request.Form("JR_UpdateID")

    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_pigo_STRING
    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& JR_Tanggal &"','"& JR_Keterangan &"','"& JR_Type &"','N','N','N','"& JR_UpdateID &"','JR','N' "
    'response.write Jurnal_H_CMD.commandText 
    set Jurnal = Jurnal_H_CMD.execute

    Log_ServerID 	= "" 
    Log_Action   	= "CREATE"
    Log_Key         = Jurnal("id")
    Log_Keterangan  = "Tambah Jurnal Hearder ID : "& Jurnal("id") &" Type Jurnal : "& JR_Type &" dengan keterangan "& JR_Keterangan &" pada : "& JR_Tanggal 
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    Response.redirect "detail-jurnal.asp?JR_ID=" & trim(Jurnal("id"))
%>