<!--#include file="../../../Connections/pigoConn.asp" -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%

    bulan = request.queryString("bulan")
    tahun = request.queryString("tahun")

    MSCA_SaldoBlnD = "MSCA_SaldoBln"&bulan&"D"
    MSCA_SaldoBlnK = "MSCA_SaldoBln"&bulan&"K"
    'response.write MSCA_SaldoBlnD & "<br><br>"
    set Closing_cmd = server.createObject("ADODB.COMMAND")
	Closing_cmd.activeConnection = MM_PIGO_String

    Closing_cmd.commandText = "SELECT Bulan, Tahun From GLB_M_Closing Where Bulan = '"& bulan &"' and Tahun = '"& tahun &"' "
    response.write Closing_cmd.commandText & "<br><br>"
    set GLBMClosing = Closing_cmd.execute

    if GLBMClosing.eof = true then

        Closing_cmd.commandText = "SELECT GL_T_Jurnal_D.JRD_CA_ID FROM GL_T_Jurnal_D INNER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID WHERE year(JR_Tanggal)='"& tahun &"' and month(JR_Tanggal)='"& bulan &"' AND NOT EXISTS( SELECT MSCA_Tahun , MSCA_CAID FROM [pigo].[dbo].[GL_T_MutasiSaldoCA] WHERE MSCA_Tahun = '"& tahun &"' AND  MSCA_CAID = JRD_CA_ID ) GROUP BY JRD_CA_ID"
        response.write Closing_cmd.commandText & "<br><br>"
        set Closing = Closing_cmd.execute
        'response.write "Jalan Ditutup" & "<br><br>"
        
        
        if Closing.eof = true then

            Closing_cmd.commandText = "SELECT GL_T_Jurnal_D.JRD_CA_ID ,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet , sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID  GROUP BY GL_T_Jurnal_D.JRD_CA_ID "
            response.write Closing_cmd.commandText & "<br><br>"
            set JurnalDetail = Closing_cmd.execute

                do while not JurnalDetail.eof
                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = 0 , "& MSCA_SaldoBlnK &" = 0 WHERE MSCA_Tahun = '"& tahun &"' and MSCA_CAID = '"& JurnalDetail("JRD_CA_ID") &"'  "
                    response.write Closing_cmd.commandText & "<br><br>"
                    set UpdateMutasiSaldo = Closing_cmd.execute

                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& JurnalDetail("Debet") &" , "& MSCA_SaldoBlnK &" = "& JurnalDetail("Kredit") &" WHERE MSCA_Tahun = '"& tahun &"' and MSCA_CAID = '"& JurnalDetail("JRD_CA_ID") &"'  "
                    response.write Closing_cmd.commandText & "<br><br>"
                    set UpdateMutasiSaldo = Closing_cmd.execute
                JurnalDetail.movenext
                loop

            Closing_cmd.commandText = "SELECT ACCUPID.CA_UpID FROM GL_M_ChartAccount INNER JOIN GL_M_ChartAccount AS ACCUPID ON GL_M_ChartAccount.CA_ID = ACCUPID.CA_UpID LEFT OUTER JOIN GL_T_Jurnal_D ON ACCUPID.CA_ID = GL_T_Jurnal_D.JRD_CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID, 12) = GL_T_Jurnal_H.JR_ID WHERE (YEAR(GL_T_Jurnal_H.JR_Tanggal) = '"& Tahun &"') AND (MONTH(GL_T_Jurnal_H.JR_Tanggal) = '"& Bulan &"') AND (NOT EXISTS (SELECT MSCA_Tahun, MSCA_CAID FROM GL_T_MutasiSaldoCA WHERE (YEAR(GL_T_Jurnal_H.JR_Tanggal) = '"& Tahun &"') AND MSCA_CAID = JRD_CA_ID )) GROUP BY ACCUPID.CA_UpID"
            response.write Closing_cmd.commandText & "<br><br>"
            set ACCUPID = Closing_cmd.execute

            if ACCUPID.eof = true then

                Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet, sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE YEAR(JR_Tanggal) = '"& Tahun &"' and MONTH(JR_Tanggal) = '"& Bulan &"' GROUP BY GL_M_ChartAccount.CA_UpID"
                response.write Closing_cmd.commandText & "<br><br>"
                set UPID = Closing_cmd.execute

                do while not UPID.eof

                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = 0 , "& MSCA_SaldoBlnK &" = 0 WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"' "
                    'response.write Closing_cmd.commandText & "<br><br>"
                    set UPDATEUPID = Closing_cmd.execute

                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& UPID("Debet") &" , "& MSCA_SaldoBlnK &" = "& UPID("Kredit") &" WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"'  "
                    response.write Closing_cmd.commandText & "<br><br>"
                    set ADDUPID = Closing_cmd.execute

                UPID.movenext
                loop

            else

                Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet, sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE YEAR(JR_Tanggal) = '"& Tahun &"' and MONTH(JR_Tanggal) = '"& Bulan &"' GROUP BY GL_M_ChartAccount.CA_UpID"
                response.write Closing_cmd.commandText & "<br><br>"
                set UPID = Closing_cmd.execute
                do while not UPID.eof
                    'response.write UPID("Debet") & "<br><br>"
                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = 0 , "& MSCA_SaldoBlnK &" = 0 WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"' "
                    response.write Closing_cmd.commandText & "<br><br>"
                    set UPDATEUPID = Closing_cmd.execute

                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& UPID("Debet") &" , "& MSCA_SaldoBlnK &" = "& UPID("Kredit") &" WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"'  "
                    response.write Closing_cmd.commandText & "<br><br>"
                    set ADDUPID = Closing_cmd.execute
                UPID.movenext
                loop

            end if 

        else

            do while not Closing.eof
            
                Closing_cmd.commandText = "INSERT INTO [dbo].[GL_T_MutasiSaldoCA]([MSCA_Tahun],[MSCA_CAID],[MSCA_SaldoAwalD],[MSCA_SaldoAwalK],[MSCA_SaldoBln01D],[MSCA_SaldoBln01K],[MSCA_SaldoBln02D],[MSCA_SaldoBln02K],[MSCA_SaldoBln03D],[MSCA_SaldoBln03K],[MSCA_SaldoBln04D],[MSCA_SaldoBln04K],[MSCA_SaldoBln05D],[MSCA_SaldoBln05K],[MSCA_SaldoBln06D],[MSCA_SaldoBln06K],[MSCA_SaldoBln07D],[MSCA_SaldoBln07K],[MSCA_SaldoBln08D],[MSCA_SaldoBln08K],[MSCA_SaldoBln09D],[MSCA_SaldoBln09K],[MSCA_SaldoBln10D],[MSCA_SaldoBln10K],[MSCA_SaldoBln11D],[MSCA_SaldoBln11K],[MSCA_SaldoBln12D],[MSCA_SaldoBln12K])VALUES('"& tahun &"','"& Closing("JRD_CA_ID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
                'response.write Closing_cmd.commandText & "<br><br>"
                set JRDCAID = Closing_cmd.execute

                Closing_cmd.commandText = "SELECT GL_T_Jurnal_D.JRD_CA_ID ,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet , sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID Where JRD_CA_ID = '"& Closing("JRD_CA_ID") &"' GROUP BY GL_T_Jurnal_D.JRD_CA_ID "
                'response.write Closing_cmd.commandText & "<br><br>"
                set JurnalDetail = Closing_cmd.execute

                do while not JurnalDetail.eof
                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& JurnalDetail("Debet") &" , "& MSCA_SaldoBlnK &" = "& JurnalDetail("Kredit") &" WHERE MSCA_Tahun = '"& tahun &"' and MSCA_CAID = '"& Closing("JRD_CA_ID") &"'  "
                    response.write Closing_cmd.commandText & "<br><br>"
                    set UpdateMutasiSaldo = Closing_cmd.execute
                JurnalDetail.movenext
                loop

            Closing.movenext
            loop

            Closing_cmd.commandText = "SELECT ACCUPID.CA_UpID FROM GL_M_ChartAccount INNER JOIN GL_M_ChartAccount AS ACCUPID ON GL_M_ChartAccount.CA_ID = ACCUPID.CA_UpID LEFT OUTER JOIN GL_T_Jurnal_D ON ACCUPID.CA_ID = GL_T_Jurnal_D.JRD_CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID, 12) = GL_T_Jurnal_H.JR_ID WHERE (YEAR(GL_T_Jurnal_H.JR_Tanggal) = '"& Tahun &"') AND (MONTH(GL_T_Jurnal_H.JR_Tanggal) = '"& Bulan &"') AND (NOT EXISTS (SELECT MSCA_Tahun, MSCA_CAID FROM GL_T_MutasiSaldoCA WHERE (YEAR(GL_T_Jurnal_H.JR_Tanggal) = '"& Tahun &"') AND MSCA_CAID = JRD_CA_ID )) GROUP BY ACCUPID.CA_UpID"
            'response.write Closing_cmd.commandText & "<br><br>"
            set ACCUPID = Closing_cmd.execute
            
            if Closing.eof = true then

                Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet, sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE YEAR(JR_Tanggal) = '"& Tahun &"' and MONTH(JR_Tanggal) = '"& Bulan &"' GROUP BY GL_M_ChartAccount.CA_UpID"
                'response.write Closing_cmd.commandText & "<br><br>"
                set UPID = Closing_cmd.execute

                do while not UPID.eof

                    Closing_cmd.commandText = "INSERT INTO [dbo].[GL_T_MutasiSaldoCA]([MSCA_Tahun],[MSCA_CAID],[MSCA_SaldoAwalD],[MSCA_SaldoAwalK],[MSCA_SaldoBln01D],[MSCA_SaldoBln01K],[MSCA_SaldoBln02D],[MSCA_SaldoBln02K],[MSCA_SaldoBln03D],[MSCA_SaldoBln03K],[MSCA_SaldoBln04D],[MSCA_SaldoBln04K],[MSCA_SaldoBln05D],[MSCA_SaldoBln05K],[MSCA_SaldoBln06D],[MSCA_SaldoBln06K],[MSCA_SaldoBln07D],[MSCA_SaldoBln07K],[MSCA_SaldoBln08D],[MSCA_SaldoBln08K],[MSCA_SaldoBln09D],[MSCA_SaldoBln09K],[MSCA_SaldoBln10D],[MSCA_SaldoBln10K],[MSCA_SaldoBln11D],[MSCA_SaldoBln11K],[MSCA_SaldoBln12D],[MSCA_SaldoBln12K])VALUES('"& Tahun &"','"& UPID("CA_UpID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
                    'response.write Closing_cmd.commandText & "<br><br>"
                    set ADDUPID = Closing_cmd.execute

                    'response.write UPID("Debet") & "<br><br>"
                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = 0 , "& MSCA_SaldoBlnK &" = 0 WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"' "
                    'response.write Closing_cmd.commandText & "<br><br>"
                    set UPDATEUPID = Closing_cmd.execute

                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& UPID("Debet") &" , "& MSCA_SaldoBlnK &" = "& UPID("Kredit") &" WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"'  "
                    'response.write Closing_cmd.commandText & "<br><br>"
                    set ADDUPID = Closing_cmd.execute

                UPID.movenext
                loop

            else

                Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet, sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE YEAR(JR_Tanggal) = '"& Tahun &"' and MONTH(JR_Tanggal) = '"& Bulan &"'GROUP BY GL_M_ChartAccount.CA_UpID"
                'response.write Closing_cmd.commandText & "<br><br>"
                set UPID = Closing_cmd.execute

                do while not UPID.eof
                    'response.write UPID("Debet") & "<br><br>"
                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = 0 , "& MSCA_SaldoBlnK &" = 0 WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"' "
                    'response.write Closing_cmd.commandText & "<br><br>"
                    set UPDATEUPID = Closing_cmd.execute

                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& UPID("Debet") &" , "& MSCA_SaldoBlnK &" = "& UPID("Kredit") &" WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"'  "
                    'response.write Closing_cmd.commandText & "<br><br>"
                    set ADDUPID = Closing_cmd.execute
                UPID.movenext
                loop

            end if 
        end if

        Closing_cmd.commandText = "INSERT INTO [dbo].[GLB_M_Closing]([Bulan],[Tahun],[UpdateID])VALUES('"& Bulan &"','"& Tahun &"','"& session("username") &"')"
        'response.write Closing_cmd.commandText & "<br><br>"
        set GLBClosing = Closing_cmd.execute
    
        'Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> BERHASIL POSTING JURNAL </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/GL/Posting-Jurnal/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>KEMBALI</a></div></div></div>"
    
    else

        'Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> TIDAK DAPAT MELAKUKAN PROSES CLOSING </span><br><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> DATA SUDAH ADA </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/GL/Posting-Jurnal/unposting.asp?bulan="& bulan &"&tahun="& tahun &" style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>UN-POSTING</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="& base_url &"/Admin/GL/Posting-Jurnal/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>KEMBALI</a><br><br></div></div></div>"

    end if
%>

<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>