<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->

<%
        CA_IDHeader       = request.Form("CA_IDHeader")
        CA_IDDetail       = request.Form("CA_IDDetail")
        CA_Name           = request.Form("CA_Name")
        CA_UpID           = request.Form("CA_UpIDNew")
        CA_Jenis          = request.Form("CA_Jenis")
        CA_Type           = request.Form("CA_Type")
        CA_Golongan       = request.Form("CA_Golongan")
        CA_Kelompok       = request.Form("CA_Kelompok")
        CA_ItemTipe       = request.Form("CA_ItemTipe")

        if CA_UpID = "" then
            CA_UpID = CA_IDHeader
        end if


        set GL_M_GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
        GL_M_GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_GL_M_ChartAccount_cmd.commandText = "INSERT INTO [dbo].[GL_M_ChartAccount]([CA_ID],[CA_Name],[CA_UpID],[CA_Jenis],[CA_Type],[CA_Golongan],[CA_Kelompok],[CA_ItemTipe],[CA_AktifYN],[CA_UpdateID],[CA_UpdateTime],[CA_Group])VALUES('"& CA_IDDetail &"','"& CA_Name &"','"& CA_UpID &"','"& CA_Jenis &"','"& CA_Type &"','"& CA_Golongan &"','"& CA_Kelompok &"','"& CA_ItemTipe &"','N','"& session("username") &"','"& Now() &"', '') "
        response.write GL_M_GL_M_ChartAccount_cmd.commandText
        set ChartAccount = GL_M_GL_M_ChartAccount_cmd.execute

        Log_ServerID 	= "" 
        Log_Action   	= "ADD"
        Log_Key         = CA_IDDetail"/"CA_IDHeader
        Log_Keterangan  = "Tambah Account Kas ID : "& CA_IDDetail"/"CA_IDHeader &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

        response.redirect "index.asp"
%>
