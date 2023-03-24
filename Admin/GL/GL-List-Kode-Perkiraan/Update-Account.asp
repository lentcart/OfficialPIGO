<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->

<%
    dim newaccid , oldaccid, accname, accup, accjenis, acctype, accgol, acckel, acctipeitem, aktifyn 

    oldaccid            = trim(request.queryString("oldaccid"))
    newaccid            = trim(request.queryString("newaccid"))
    accname             = trim(request.queryString("accname"))
    accup               = trim(request.queryString("accup"))
    accjenis            = trim(request.queryString("accjenis"))
    acctype             = trim(request.queryString("acctype"))
    accgol              = trim(request.queryString("accgol"))
    acckel              = trim(request.queryString("acckel"))
    acctipeitem         = trim(request.queryString("acctipeitem"))
    aktifyn             = trim(request.queryString("aktifyn"))

    set GL_M_GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
    GL_M_GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String

    GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount WHERE CA_ID = '"& oldaccid &"'"
    set AccID = GL_M_GL_M_ChartAccount_cmd.execute

    if not AccID.eof then

        SND_newaccid            = AccID("CA_ID")
        SND_accname             = AccID("CA_Name")
        SND_accup               = AccID("CA_UpID")
        SND_accjenis            = AccID("CA_Jenis")
        SND_acctype             = AccID("CA_Type")
        SND_accgol              = AccID("CA_Golongan")
        SND_acckel              = AccID("CA_Kelompok")
        SND_acctipeitem         = AccID("CA_ItemTipe")
        SND_aktifyn             = AccID("CA_AktifYN")

        if SND_newaccid   <>  newaccid THEN 
            UpdateCAID  =   "Perubahan Account ID Kas Dari " & SND_newaccid & " Ke " & newaccid & ","
        else 
            UpdateCAID  =   ""
        end if

        if SND_accname   <>  accname THEN 
            UpdateCAName  =   "Perubahan Nama Account Kas  Dari " & SND_accname & " Ke " & accname & ","
        else 
            UpdateCAName  =   ""
        end if
        
        if SND_accup   <>  accup THEN 
            UpdateCAUP  =   "Perubahan Account UP ID Dari " & SND_accup & " Ke " & accup & ","
        else 
            UpdateCAUP  =   ""
        end if

        if SND_accjenis   <>  accjenis THEN 
            UpdateCAJenis  =   "Perubahan Jenis Account Kas Dari " & SND_accjenis & " Ke " & accjenis & ","
        else 
            UpdateCAJenis  =   ""
        end if

        if SND_acctype   <>  acctype THEN 
            UpdateCATipe  =   "Perubahan Tipe Account Kas Dari " & SND_acctype & " Ke " & acctype & ","
        else 
            UpdateCATipe  =   ""
        end if

        if SND_accgol   <>  accgol THEN 
            UpdateCAGol  =   "Perubahan Account Golongan " & SND_accgol & " Ke " & accgol & ","
        else 
            UpdateCAGol  =   ""
        end if

        if SND_acckel   <>  acckel THEN 
            UpdateCAKel  =   "Perubahan Account Kelompok Dari " & SND_acckel & " Ke " & acckel & ","
        else 
            UpdateCAKel  =   ""
        end if

        if SND_acctipeitem   <>  acctipeitem THEN 
            UpdateCATipeItem  =   "Perubahan Account Tipe Item Dari " & SND_acctipeitem & " Ke " & acctipeitem & ","
        else 
            UpdateCATipeItem  =   ""
        end if

        if SND_aktifyn   <>  aktifyn THEN 
            UpdateCAAktifYN  =   "Perubahan Status Aktif Account Kas Dari " & SND_aktifyn & " Ke " & aktifyn & ","
        else 
            UpdateCAAktifYN  =   ""
        end if

        GL_M_GL_M_ChartAccount_cmd.commandText = "UPDATE [dbo].[GL_M_ChartAccount] SET [CA_ID] = '"& newaccid &"',[CA_Name] = '"& accname &"',[CA_UpID] = '"& accup &"',[CA_Jenis] = '"& accjenis &"',[CA_Type] = '"& acctype &"',[CA_Golongan] = '"& accgol &"',[CA_Kelompok] = '"& acckel &"',[CA_ItemTipe] = '"& acctipeitem &"',[CA_AktifYN] = '"& aktifyn &"',[CA_UpdateID] = '"& Session("username") &"',[CA_UpdateTime] = '"& now() &"',[CA_Group] = '' WHERE  CA_ID = '"& oldaccid &"'"
        set CID = GL_M_GL_M_ChartAccount_cmd.execute

        Ket =  "UPDATE " & UpdateCAID & UpdateCAName & UpdateCAUP & UpdateCAJenis & UpdateCATipe & UpdateCAGol & UpdateCAKel & UpdateCATipeItem & UpdateCAAktifYN & " Berdasarkan Account ID  : ("& oldaccid &") "
        ' response.write Ket & "<br><br>"

        Log_ServerID 	= "" 
        Log_Action   	= "UPDATE"
        Log_Key         = oldaccid
        Log_Keterangan  = Ket
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    end if

        
        

%>