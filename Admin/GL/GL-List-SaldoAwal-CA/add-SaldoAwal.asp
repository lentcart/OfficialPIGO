<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->
<%
    SA_Tahun        = request.form("SA_Tahun")
    SA_CA_ID        = request.form("SA_CA_ID")
    SA_Debet        = request.form("SA_Debet")
    SA_Kredit       = request.form("SA_Kredit")

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_ChartAccount_cmd.commandText = "INSERT INTO [dbo].[GL_M_SaldoAwal]([SA_Tahun],[SA_CA_ID],[SA_Debet],[SA_Kredit],[SA_UpdateID],[SA_UpdateTime],[SA_AktifYN])VALUES('"& SA_Tahun &"','"& SA_CA_ID &"',"& SA_Debet &","& SA_Kredit &",'"& session("username") &"','"& now() &"','Y')"
        'response.write GL_M_ChartAccount_cmd.commandText & "<br><br>"
    set SA = GL_M_ChartAccount_cmd.execute

    GL_M_ChartAccount_cmd.commandText = "SELECT SA_CA_ID FROM GL_M_SaldoAwal WHERE (NOT EXISTS (SELECT MSCA_Tahun, MSCA_CAID FROM GL_T_MutasiSaldoCA WHERE (MSCA_Tahun = '"& SA_Tahun &"') AND (MSCA_CAID = GL_M_SaldoAwal.SA_CA_ID))) GROUP BY SA_CA_ID"
    'response.write GL_M_ChartAccount_cmd.commandText & "<br><br>"
    set SAMutasi = GL_M_ChartAccount_cmd.execute 

    if SAMutasi.eof = true then 

        GL_M_ChartAccount_cmd.commandText = "SELECT SA_CA_ID,SA_Debet, SA_Kredit FROM GL_M_SaldoAwal WHERE SA_Tahun = '"& SA_Tahun &"'"
        'response.write GL_M_ChartAccount_cmd.commandText & "<br><br>"
        set SaldoAwal = GL_M_ChartAccount_cmd.execute

        do while not SaldoAwal.eof
            GL_M_ChartAccount_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set MSCA_SaldoAwalD = '"&  SaldoAwal("SA_Debet") &"' , MSCA_SaldoAwalK = '"&  SaldoAwal("SA_Kredit") &"' WHERE MSCA_Tahun = '"& SA_Tahun &"' and MSCA_CAID = '"& SaldoAwal("SA_CA_ID") &"'"
            r'esponse.write GL_M_ChartAccount_cmd.commandText & "<br><br>"
            set SAMutasi = GL_M_ChartAccount_cmd.execute
        SaldoAwal.movenext
        loop

    else
        do while not SAMutasi.eof
            GL_M_ChartAccount_cmd.commandText = "INSERT INTO [dbo].[GL_T_MutasiSaldoCA]([MSCA_Tahun],[MSCA_CAID],[MSCA_SaldoAwalD],[MSCA_SaldoAwalK],[MSCA_SaldoBln01D],[MSCA_SaldoBln01K],[MSCA_SaldoBln02D],[MSCA_SaldoBln02K],[MSCA_SaldoBln03D],[MSCA_SaldoBln03K],[MSCA_SaldoBln04D],[MSCA_SaldoBln04K],[MSCA_SaldoBln05D],[MSCA_SaldoBln05K],[MSCA_SaldoBln06D],[MSCA_SaldoBln06K],[MSCA_SaldoBln07D],[MSCA_SaldoBln07K],[MSCA_SaldoBln08D],[MSCA_SaldoBln08K],[MSCA_SaldoBln09D],[MSCA_SaldoBln09K],[MSCA_SaldoBln10D],[MSCA_SaldoBln10K],[MSCA_SaldoBln11D],[MSCA_SaldoBln11K],[MSCA_SaldoBln12D],[MSCA_SaldoBln12K])VALUES('"& SA_Tahun &"','"& SAMutasi("SA_CA_ID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
            'response.write GL_M_ChartAccount_cmd.commandText& "<br><br>"
            set JRDCAID = Closing_cmd.execute

            GL_M_ChartAccount_cmd.commandText = "SELECT SA_CA_ID,SA_Debet, SA_Kredit FROM GL_M_SaldoAwal WHERE SA_Tahun = '"& SA_Tahun &"'"
            'response.write GL_M_ChartAccount_cmd.commandText & "<br><br>"
            set SaldoAwal = GL_M_ChartAccount_cmd.execute

            do while not SaldoAwal.eof
                GL_M_ChartAccount_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set MSCA_SaldoAwalD = '"&  SaldoAwal("SA_Debet") &"' , MSCA_SaldoAwalK = '"&  SaldoAwal("SA_Kredit") &"' WHERE MSCA_Tahun = '"& SA_Tahun &"' and MSCA_CAID = '"& SaldoAwal("SA_CA_ID") &"'"
                'response.write GL_M_ChartAccount_cmd.commandText & "<br><br>"
                set SAMutasi = GL_M_ChartAccount_cmd.execute

            SaldoAwal.movenext
            loop

        SAMutasi.movenext
        loop

    end if 

    Log_ServerID 	= "" 
    Log_Action   	= "ADD"
    Log_Key         = SA_CA_ID
    Log_Keterangan  = "Tambah Saldo Awal Account Kas : "& SA_CA_ID &" pada : "& Date()
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    response.redirect "index.asp"

%>