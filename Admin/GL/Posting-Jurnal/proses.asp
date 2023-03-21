<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    bulan = "10"
    tahun = "2022"

    MSCA_SaldoBlnD = "MSCA_SaldoBln"&bulan&"D"
    MSCA_SaldoBlnK = "MSCA_SaldoBln"&bulan&"K"

    set Closing_cmd = server.createObject("ADODB.COMMAND")
	Closing_cmd.activeConnection = MM_PIGO_String

    Closing_cmd.commandText = "SELECT GL_T_Jurnal_D.JRD_CA_ID FROM GL_T_Jurnal_D INNER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID WHERE year(JR_Tanggal)='"& tahun &"' and month(JR_Tanggal)='"& bulan &"'  AND NOT EXISTS( SELECT MSCA_Tahun , MSCA_CAID FROM [pigo].[dbo].[GL_T_MutasiSaldoCA] WHERE MSCA_Tahun = '"& tahun &"'  and MSCA_CAID = JRD_CA_ID ) GROUP BY JRD_CA_ID"
    response.write Closing_cmd.commandText & "<br><br>"
    set Closing = Closing_cmd.execute

    If Closing.eof = true then 

        Closing_cmd.commandText = "SELECT GL_T_Jurnal_D.JRD_CA_ID ,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet , sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID Where YEAR(JR_Tanggal) = '"& Tahun &"' and Month(JR_Tanggal) = '"& Bulan &"'  GROUP BY GL_T_Jurnal_D.JRD_CA_ID "
        response.write Closing_cmd.commandText & "<br><br>"
        set Jurnal = Closing_cmd.execute

        ' do while not Jurnal.eof 

        '     Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = 0 , "& MSCA_SaldoBlnK &" = 0 WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& Jurnal("JRD_CA_ID") &"' "
        '     response.write Closing_cmd.commandText & "<br><br>"
        '     set UpdateMutasi = Closing_cmd.execute

        '     Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& Jurnal("Debet") &" , "& MSCA_SaldoBlnK &" = "& Jurnal("Kredit") &" WHERE MSCA_Tahun = '"& tahun &"' and MSCA_CAID = '"& Jurnal("JRD_CA_ID") &"'  "
        '     response.write Closing_cmd.commandText & "<br><br>"
        '     set UpdateMutasiSaldo = Closing_cmd.execute

        '     Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID FROM GL_T_Jurnal_D INNER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID, 12) = GL_T_Jurnal_H.JR_ID INNER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE (YEAR(GL_T_Jurnal_H.JR_Tanggal) = '"& tahun &"') AND (MONTH(GL_T_Jurnal_H.JR_Tanggal) = '"& bulan &"') AND (NOT EXISTS (SELECT MSCA_Tahun, MSCA_CAID FROM GL_T_MutasiSaldoCA WHERE (MSCA_Tahun = '"& tahun &"') AND (MSCA_CAID = GL_T_Jurnal_D.JRD_CA_ID))) GROUP BY GL_M_ChartAccount.CA_UpID "
        '     response.write Closing_cmd.commandText & "<br><br>"
        '     set Account_upID = Closing_cmd.execute

        '     if Account_upID.eof = false then
        '         do while not Account_upID.eof
        '             Account_upIDD = Account_upID("CA_UpID")
        '             response.write Account_upIDD  & "<br><br>"

        '             Closing_cmd.commandText = "INSERT INTO [dbo].[GL_T_MutasiSaldoCA]([MSCA_Tahun],[MSCA_CAID],[MSCA_SaldoAwalD],[MSCA_SaldoAwalK],[MSCA_SaldoBln01D],[MSCA_SaldoBln01K],[MSCA_SaldoBln02D],[MSCA_SaldoBln02K],[MSCA_SaldoBln03D],[MSCA_SaldoBln03K],[MSCA_SaldoBln04D],[MSCA_SaldoBln04K],[MSCA_SaldoBln05D],[MSCA_SaldoBln05K],[MSCA_SaldoBln06D],[MSCA_SaldoBln06K],[MSCA_SaldoBln07D],[MSCA_SaldoBln07K],[MSCA_SaldoBln08D],[MSCA_SaldoBln08K],[MSCA_SaldoBln09D],[MSCA_SaldoBln09K],[MSCA_SaldoBln10D],[MSCA_SaldoBln10K],[MSCA_SaldoBln11D],[MSCA_SaldoBln11K],[MSCA_SaldoBln12D],[MSCA_SaldoBln12K])VALUES('"& tahun &"','"& Account_upID("CA_UpID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
        '             response.write Closing_cmd.commandText & "<br><br>"
        '             set AddUpID = Closing_cmd.execute

        '             Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet, sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE YEAR(JR_Tanggal) = '"& tahun &"' and MONTH(JR_Tanggal) = '"& bulan &"' and JRD_CA_ID = '"& Jurnal("JRD_CA_ID") &"' GROUP BY GL_M_ChartAccount.CA_UpID "
        '             response.write Closing_cmd.commandText & "<br><br>"
        '             set UPID = Closing_cmd.execute

        '             Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& UPID("Debet") &" , "& MSCA_SaldoBlnK &" = "& UPID("Kredit") &" WHERE MSCA_Tahun = '"& tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"'  "
        '             response.write Closing_cmd.commandText & "<br><br>"
        '             set UpdateUpID = Closing_cmd.execute

        '         Account_upIDD.movenext
        '         loop

        '     else

        '         Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet, sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE YEAR(JR_Tanggal) = '"& tahun &"' and MONTH(JR_Tanggal) = '"& bulan &"' and JRD_CA_ID = '"& Jurnal("JRD_CA_ID") &"' GROUP BY GL_M_ChartAccount.CA_UpID "
        '         response.write Closing_cmd.commandText & "<br><br>"
        '         set UPID = Closing_cmd.execute

        '         Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = 0 , "& MSCA_SaldoBlnK &" = 0 WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"' "
        '         response.write Closing_cmd.commandText & "<br><br>"
        '         set UpdateMutasi = Closing_cmd.execute


        '         Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& UPID("Debet") &" , "& MSCA_SaldoBlnK &" = "& UPID("Kredit") &" WHERE MSCA_Tahun = '"& tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"'  "
        '         response.write Closing_cmd.commandText & "<br><br>"
        '         set UpdateUpID = Closing_cmd.execute

        '     end if

        ' Jurnal.movenext
        ' loop

    else

        do while not Closing.eof

            Closing_cmd.commandText = "INSERT INTO [dbo].[GL_T_MutasiSaldoCA]([MSCA_Tahun],[MSCA_CAID],[MSCA_SaldoAwalD],[MSCA_SaldoAwalK],[MSCA_SaldoBln01D],[MSCA_SaldoBln01K],[MSCA_SaldoBln02D],[MSCA_SaldoBln02K],[MSCA_SaldoBln03D],[MSCA_SaldoBln03K],[MSCA_SaldoBln04D],[MSCA_SaldoBln04K],[MSCA_SaldoBln05D],[MSCA_SaldoBln05K],[MSCA_SaldoBln06D],[MSCA_SaldoBln06K],[MSCA_SaldoBln07D],[MSCA_SaldoBln07K],[MSCA_SaldoBln08D],[MSCA_SaldoBln08K],[MSCA_SaldoBln09D],[MSCA_SaldoBln09K],[MSCA_SaldoBln10D],[MSCA_SaldoBln10K],[MSCA_SaldoBln11D],[MSCA_SaldoBln11K],[MSCA_SaldoBln12D],[MSCA_SaldoBln12K])VALUES('"& tahun &"','"& Closing("JRD_CA_ID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
            response.write Closing_cmd.commandText & "<br><br>"
            set Mutasi = Closing_cmd.execute

            Closing_cmd.commandText = "SELECT GL_T_Jurnal_D.JRD_CA_ID ,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet , sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID Where JRD_CA_ID = '"& Closing("JRD_CA_ID") &"' GROUP BY GL_T_Jurnal_D.JRD_CA_ID "
            response.write Closing_cmd.commandText & "<br><br>"
            set Jurnal = Closing_cmd.execute

            Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& Jurnal("Debet") &" , "& MSCA_SaldoBlnK &" = "& Jurnal("Kredit") &" WHERE MSCA_Tahun = '"& tahun &"' and MSCA_CAID = '"& Closing("JRD_CA_ID") &"'  "
            response.write Closing_cmd.commandText & "<br><br>"
            set UpdateMutasiSaldo = Closing_cmd.execute

            Closing_cmd.commandText = "SELECT ACCUPID.CA_UpID FROM GL_M_ChartAccount INNER JOIN GL_M_ChartAccount AS ACCUPID ON GL_M_ChartAccount.CA_ID = ACCUPID.CA_UpID LEFT OUTER JOIN GL_T_Jurnal_D ON ACCUPID.CA_ID = GL_T_Jurnal_D.JRD_CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID, 12) = GL_T_Jurnal_H.JR_ID WHERE (YEAR(GL_T_Jurnal_H.JR_Tanggal) = '2022') AND (MONTH(GL_T_Jurnal_H.JR_Tanggal) = '10') AND (NOT EXISTS     (SELECT        MSCA_Tahun, MSCA_CAID       FROM            GL_T_MutasiSaldoCA       WHERE        (YEAR(GL_T_Jurnal_H.JR_Tanggal) = '2022') AND MSCA_CAID = '"& Closing("JRD_CA_ID") &"')) GROUP BY  ACCUPID.CA_UpID"
            response.write Closing_cmd.commandText & "<br><br>"
            set Account_upID = Closing_cmd.execute

            if Account_upID.eof = true then

                Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet, sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE YEAR(JR_Tanggal) = '2022' and MONTH(JR_Tanggal) = '10' GROUP BY GL_M_ChartAccount.CA_UpID"
                response.write Closing_cmd.commandText & "<br><br>"
                set ACCUPID = Closing_cmd.execute

                do while not ACCUPID.eof

                    Closing_cmd.commandText = "INSERT INTO [dbo].[GL_T_MutasiSaldoCA]([MSCA_Tahun],[MSCA_CAID],[MSCA_SaldoAwalD],[MSCA_SaldoAwalK],[MSCA_SaldoBln01D],[MSCA_SaldoBln01K],[MSCA_SaldoBln02D],[MSCA_SaldoBln02K],[MSCA_SaldoBln03D],[MSCA_SaldoBln03K],[MSCA_SaldoBln04D],[MSCA_SaldoBln04K],[MSCA_SaldoBln05D],[MSCA_SaldoBln05K],[MSCA_SaldoBln06D],[MSCA_SaldoBln06K],[MSCA_SaldoBln07D],[MSCA_SaldoBln07K],[MSCA_SaldoBln08D],[MSCA_SaldoBln08K],[MSCA_SaldoBln09D],[MSCA_SaldoBln09K],[MSCA_SaldoBln10D],[MSCA_SaldoBln10K],[MSCA_SaldoBln11D],[MSCA_SaldoBln11K],[MSCA_SaldoBln12D],[MSCA_SaldoBln12K])VALUES('2022','"& ACCUPID("CA_UpID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
                    response.write Closing_cmd.commandText & "<br><br>"
                    set ADDUPID = Closing_cmd.execute

                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = 0 , "& MSCA_SaldoBlnK &" = 0 WHERE MSCA_Tahun = '2022' and MSCA_CAID = '"& ACCUPID("CA_UpID") &"' "
                    response.write Closing_cmd.commandText & "<br><br>"
                    set UPDATEUPID = Closing_cmd.execute

                    Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& ACCUPID("Debet") &" , "& MSCA_SaldoBlnK &" = "& ACCUPID("Kredit") &" WHERE MSCA_Tahun = '2022' and MSCA_CAID = '"& ACCUPID("CA_UpID") &"'  "
                    response.write Closing_cmd.commandText & "<br><br>"
                    set UPID = Closing_cmd.execute

                ACCUPID.movenext
                loop

            else

            end if



            '        

            '         do while not Account_upID.eof
            '             Account_upIDD = Account_upID("CA_UpID")
            '             response.write Account_upIDD  & "<br><br>"

            '             Closing_cmd.commandText = "INSERT INTO [dbo].[GL_T_MutasiSaldoCA]([MSCA_Tahun],[MSCA_CAID],[MSCA_SaldoAwalD],[MSCA_SaldoAwalK],[MSCA_SaldoBln01D],[MSCA_SaldoBln01K],[MSCA_SaldoBln02D],[MSCA_SaldoBln02K],[MSCA_SaldoBln03D],[MSCA_SaldoBln03K],[MSCA_SaldoBln04D],[MSCA_SaldoBln04K],[MSCA_SaldoBln05D],[MSCA_SaldoBln05K],[MSCA_SaldoBln06D],[MSCA_SaldoBln06K],[MSCA_SaldoBln07D],[MSCA_SaldoBln07K],[MSCA_SaldoBln08D],[MSCA_SaldoBln08K],[MSCA_SaldoBln09D],[MSCA_SaldoBln09K],[MSCA_SaldoBln10D],[MSCA_SaldoBln10K],[MSCA_SaldoBln11D],[MSCA_SaldoBln11K],[MSCA_SaldoBln12D],[MSCA_SaldoBln12K])VALUES('"& tahun &"','"& Account_upID("CA_UpID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
            '             response.write Closing_cmd.commandText & "dfgdfgdfgdfgdf<br><br>"
            '             set AddUpID = Closing_cmd.execute

            '             Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet, sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE YEAR(JR_Tanggal) = '"& tahun &"' and MONTH(JR_Tanggal) = '"& bulan &"' and JRD_CA_ID = '"& Jurnal("JRD_CA_ID") &"' GROUP BY GL_M_ChartAccount.CA_UpID "
            '             response.write Closing_cmd.commandText & "<br><br>"
            '             set UPID = Closing_cmd.execute

            '             Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& UPID("Debet") &" , "& MSCA_SaldoBlnK &" = "& UPID("Kredit") &" WHERE MSCA_Tahun = '"& tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"'  "
            '             response.write Closing_cmd.commandText & "<br><br>"
            '             set UpdateUpID = Closing_cmd.execute

            '         Account_upID.movenext
            '         loop

                ' else

            '         Closing_cmd.commandText = "SELECT GL_M_ChartAccount.CA_UpID,sum(GL_T_Jurnal_D.JRD_Debet) AS Debet, sum(GL_T_Jurnal_D.JRD_Kredit) AS Kredit FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE YEAR(JR_Tanggal) = '"& tahun &"' and MONTH(JR_Tanggal) = '"& bulan &"' and JRD_CA_ID = '"& Jurnal("JRD_CA_ID") &"' GROUP BY GL_M_ChartAccount.CA_UpID "
            '         response.write Closing_cmd.commandText & "<br><br>"
            '         set UPID = Closing_cmd.execute

            '         Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = 0 , "& MSCA_SaldoBlnK &" = 0 WHERE MSCA_Tahun = '"& Tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"' "
            '         response.write Closing_cmd.commandText & "<br><br>"
            '         set UpdateMutasi = Closing_cmd.execute


            '         Closing_cmd.commandText = "UPDATE GL_T_MutasiSaldoCA set "& MSCA_SaldoBlnD &" = "& UPID("Debet") &" , "& MSCA_SaldoBlnK &" = "& UPID("Kredit") &" WHERE MSCA_Tahun = '"& tahun &"' and MSCA_CAID = '"& UPID("CA_UpID") &"'  "
            '         response.write Closing_cmd.commandText & "<br><br>"
            '         set UpdateUpID = Closing_cmd.execute

                ' end if

        Closing.movenext
        loop

    end if 


    



%>