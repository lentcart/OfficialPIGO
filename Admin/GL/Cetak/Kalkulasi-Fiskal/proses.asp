<!--#include file="../../../../Connections/pigoConn.asp" -->

<% 
    FT_Tahun            = request.Form("Tahun")
    FT_Bulan            = request.Form("Bulan")
    FT_TarifPajak       = request.Form("TarifPajak")
    FT_Kompensasi       = request.Form("Kompensasi")

    SaldoBulanD         = "MSCA_SaldoBln"& FT_Bulan &"D"
    SaldoBulanK         = "MSCA_SaldoBln"& FT_Bulan &"K"

    set KalkulasiFiskal_CMD = server.CreateObject("ADODB.command")
    KalkulasiFiskal_CMD.activeConnection = MM_pigo_STRING
    KalkulasiFiskal_CMD.commandText = "exec sp_add_GL_T_Fiskal '"& FT_Tahun &"','"& FT_Bulan &"',0,0,0,0,0,0,0,0,0,0"
    'response.write KalkulasiFiskal_CMD.commandText & "<br><br>"
    set KalkulasiFiskal = KalkulasiFiskal_CMD.execute

    KalkulasiFiskal_CMD.commandText = "SELECT GL_M_Fiskal_D.FMD_ID, GL_M_Fiskal_H.FM_JenisKoreksi FROM GL_M_Fiskal_D RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID GROUP BY  GL_M_Fiskal_D.FMD_ID, GL_M_Fiskal_H.FM_JenisKoreksi"
    'response.write KalkulasiFiskal_CMD.commandText  & "<br><br>"
    set GLMFiskal = KalkulasiFiskal_CMD.execute

    'KOREKSI NEGATIF , KOREKSI POSITIF , DAN KREDIT PAJAK
        do while not GLMFiskal.eof

            KalkulasiFiskal_CMD.commandText = "SELECT GL_M_Fiskal_D.FMD_CA_ID, GL_M_Fiskal_D.FMD_Value, GL_M_Fiskal_H.FM_SaldoAwalYN, GL_M_Fiskal_D.FMD_ID FROM GL_M_Fiskal_D RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID WHERE FM_ID = '"& GLMFiskal("FMD_ID") &"' AND FM_JenisKoreksi = '"& GLMFiskal("FM_JenisKoreksi") &"' "
            'response.write KalkulasiFiskal_CMD.commandText  & "<br><br>"
            set GLMFiskalD = KalkulasiFiskal_CMD.execute

            do while not GLMFiskalD.eof

                SaldoAwalYN  = GLMFiskalD("FM_SaldoAwalYN")
                ValueFiskal  = GLMFiskalD("FMD_Value")

                if SaldoAwalYN = "Y" then

                    KalkulasiFiskal_CMD.commandText = "SELECT ISNULL("& SaldoBulanD &", 0) AS SaldoBulanD , ISNULL("& SaldoBulanK &", 0) AS  SaldoBulanK , ISNULL(GL_T_MutasiSaldoCA.MSCA_SaldoAwalD,0) AS SaldoAwalD, ISNULL(GL_T_MutasiSaldoCA.MSCA_SaldoAwalK,0) AS SaldoAwalK FROM GL_M_Fiskal_D LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_Fiskal_D.FMD_CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID WHERE FMD_CA_ID = '"& GLMFiskalD("FMD_CA_ID") &"' "
                    'response.write KalkulasiFiskal_CMD.commandText & "<br><br>"
                    set FTD = KalkulasiFiskal_CMD.execute

                    SaldoAwal         = FTD("SaldoAwalD") + FTD("SaldoAwalK")
                    SaldoD            = FTD("SaldoBulanD")
                    SaldoD            = FTD("SaldoBulanK")
                    FTD_ValueD        = FTD("SaldoBulanD")*ValueFiskal/100
                    FTD_ValueK        = FTD("SaldoBulanK")*ValueFiskal/100
                    Total             = SaldoAwal+FTD_ValueD+FTD_ValueK

                else

                    KalkulasiFiskal_CMD.commandText = "SELECT ISNULL("& SaldoBulanD &", 0) AS SaldoBulanD, ISNULL("& SaldoBulanK &", 0) AS SaldoBulanK FROM GL_M_Fiskal_D LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_Fiskal_D.FMD_CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID RIGHT OUTER JOIN GL_M_Fiskal_H ON GL_M_Fiskal_D.FMD_ID = GL_M_Fiskal_H.FM_ID WHERE FMD_CA_ID = '"& GLMFiskalD("FMD_CA_ID") &"' "
                    'response.write KalkulasiFiskal_CMD.commandText & "<br><br>"
                    set FTD = KalkulasiFiskal_CMD.execute

                    SaldoD            = FTD("SaldoBulanD")
                    SaldoD            = FTD("SaldoBulanK")
                    FTD_ValueD        = FTD("SaldoBulanD")*ValueFiskal/100
                    FTD_ValueK        = FTD("SaldoBulanK")*ValueFiskal/100
                    Total             = FTD_ValueD+FTD_ValueK

                end if 

            GLMFiskalD.movenext
            loop

            SubTotal = SubTotal + Total
            KalkulasiFiskal_CMD.commandText = "INSERT INTO [dbo].[GL_T_Fiskal_D]([FTD_ID],[FM_ID],[FTD_Value])VALUES('"& KalkulasiFiskal("id") &"','"& GLMFiskal("FMD_ID") &"','"& SubTotal &"')"
            'response.write KalkulasiFiskal_CMD.commandText  & "<br><br>"
            set GLMFiskalD = KalkulasiFiskal_CMD.execute

            GrandTotal = GrandTotal + SubTotal
            SubTotal = 0 

            KalkulasiFiskal_CMD.commandText = "SELECT GL_T_Fiskal_D.FTD_ID, GL_T_Fiskal_D.FM_ID, GL_T_Fiskal_D.FTD_Value, GL_M_Fiskal_H.FM_JenisKoreksi FROM GL_M_Fiskal_H RIGHT OUTER JOIN GL_T_Fiskal_D ON GL_M_Fiskal_H.FM_ID = GL_T_Fiskal_D.FM_ID LEFT OUTER JOIN GL_M_Fiskal_D ON GL_M_Fiskal_H.FM_ID = GL_M_Fiskal_D.FMD_ID WHERE GL_T_Fiskal_D.FM_ID = '"& GLMFiskal("FMD_ID") &"' AND GL_M_Fiskal_H.FM_JenisKoreksi = '"& GLMFiskal("FM_JenisKoreksi") &"' GROUP BY GL_T_Fiskal_D.FTD_ID, GL_T_Fiskal_D.FM_ID, GL_T_Fiskal_D.FTD_Value, GL_M_Fiskal_H.FM_JenisKoreksi " 
            'response.write KalkulasiFiskal_CMD.commandText  & "<br><br>"
            set SETGLTFiskalD = KalkulasiFiskal_CMD.execute
            
            do while not SETGLTFiskalD.eof
                if SETGLTFiskalD("FM_JenisKoreksi") = "P" then 
                    JenisKoreksiPositif = SETGLTFiskalD("FTD_Value")
                else if SETGLTFiskalD("FM_JenisKoreksi") = "N" then 
                    JenisKoreksiNegatif = SETGLTFiskalD("FTD_Value")
                else
                    JenisKoreksiKreditPajak = SETGLTFiskalD("FTD_Value")
                end if end if 
            SETGLTFiskalD.movenext
            loop
        
        GLMFiskal.movenext
        loop
    'KOREKSI NEGATIF , KOREKSI POSITIF , DAN KREDIT PAJAK

    'LABA RUGI HASIL USAHA
        set LabaRugi_CMD = server.createObject("ADODB.COMMAND") 
        LabaRugi_CMD.activeConnection = MM_PIGO_String

        'DEBET

            if FT_Bulan = "1" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D"
            else if FT_Bulan = "2" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D"
            else if FT_Bulan = "3" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D "
            else if FT_Bulan = "4" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D "
            else if FT_Bulan = "5" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D "
            else if FT_Bulan = "6" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D "
            else if FT_Bulan = "7" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D "
            else if FT_Bulan = "8" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D"
            else if FT_Bulan = "9" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D "
            else if FT_Bulan = "10" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D + MSCA_SaldoBln10D "
            else if FT_Bulan = "11" then 
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D + MSCA_SaldoBln10D + MSCA_SaldoBln11D"
            else
                MSCA_SaldoBlnD = "MSCA_SaldoAwalD + MSCA_SaldoBln01D + MSCA_SaldoBln02D + MSCA_SaldoBln03D + MSCA_SaldoBln04D + MSCA_SaldoBln05D + MSCA_SaldoBln06D + MSCA_SaldoBln07D + MSCA_SaldoBln08D + MSCA_SaldoBln09D + MSCA_SaldoBln10D + MSCA_SaldoBln11D + MSCA_SaldoBln12D"
            end if end if end if end if end if end if end if end if end if end if end if 

        'DEBET

        'KREDIT

            if FT_Bulan = "1" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K"
            else if FT_Bulan = "2" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K"
            else if FT_Bulan = "3" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K "
            else if FT_Bulan = "4" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K "
            else if FT_Bulan = "5" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K "
            else if FT_Bulan = "6" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K "
            else if FT_Bulan = "7" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K "
            else if FT_Bulan = "8" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K"
            else if FT_Bulan = "9" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K "
            else if FT_Bulan = "10" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K + MSCA_SaldoBln10K "
            else if FT_Bulan = "11" then 
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K + MSCA_SaldoBln10K + MSCA_SaldoBln11K"
            else
                MSCA_SaldoBlnK = "MSCA_SaldoAwalK + MSCA_SaldoBln01K + MSCA_SaldoBln02K + MSCA_SaldoBln03K + MSCA_SaldoBln04K + MSCA_SaldoBln05K + MSCA_SaldoBln06K + MSCA_SaldoBln07K + MSCA_SaldoBln08K + MSCA_SaldoBln09K + MSCA_SaldoBln10K + MSCA_SaldoBln11K + MSCA_SaldoBln12K"
            end if end if end if end if end if end if end if end if end if end if end if 

        'KREDIT

        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID = 'D100.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
        set Pendapatan = LabaRugi_CMD.execute
            if Pendapatan("CA_Jenis") = "D" then
                TotalPendapatan =  Pendapatan("SaldoDebet")  - Pendapatan("SaldoKredit")
            else 
                TotalPendapatan =  Pendapatan("SaldoKredit") - Pendapatan("SaldoDebet") 
            end if
        
        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID = 'E100.00.00') AND MSCA_Tahun = '"& FT_Tahun &"' GROUP BY GL_M_ChartAccount.CA_Jenis"
            response.write LabaRugi_CMD.commandText
            set HPP = LabaRugi_CMD.execute

            if HPP("CA_Jenis") = "D" then
                TotalHPP =  HPP("SaldoDebet")  - HPP("SaldoKredit")
            else 
                TotalHPP =  HPP("SaldoKredit") - HPP("SaldoDebet") 
            end if 

        LabaKotor = TotalPendapatan-TotalHPP

        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID BETWEEN  'F100.00.00' AND 'F114.00.00') AND (GL_M_ChartAccount.CA_Kelompok = '06') GROUP BY GL_M_ChartAccount.CA_Jenis"
            set BMP = LabaRugi_CMD.execute
            if BMP("CA_Jenis") = "D" then
                TotalBMP =  BMP("SaldoDebet")  - BMP("SaldoKredit")
            else 
                TotalBMP =  BMP("SaldoKredit") - BMP("SaldoDebet") 
            end if
        
        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID BETWEEN  'G100.00.00' AND 'G120.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
            set BAU = LabaRugi_CMD.execute
            if BAU("CA_Jenis") = "D" then
                TotalBAU =  BAU("SaldoDebet")  - BAU("SaldoKredit")
            else 
                TotalBAU =  BAU("SaldoKredit") - BAU("SaldoDebet") 
            end if 

        BebanUsaha = TotalBMP+TotalBAU
        LabaRugiUsaha = LabaKotor + BebanUsaha

        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID = 'G121.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
        set PLL = LabaRugi_CMD.execute
        if PLL("CA_Jenis") = "D" then
            TotalPLL =  PLL("SaldoDebet")  - PLL("SaldoKredit")
        else 
            TotalPLL =  PLL("SaldoKredit") - PLL("SaldoDebet") 
        end if

        LabaRugi_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Jenis, ISNULL(SUM("& MSCA_SaldoBlnD &"),0) AS SaldoDebet, ISNULL(SUM("& MSCA_SaldoBlnK &"),0) AS SaldoKredit FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID WHERE (GL_M_ChartAccount.CA_UpID = 'G123.00.00') GROUP BY GL_M_ChartAccount.CA_Jenis"
        set BLL = LabaRugi_CMD.execute
        if BLL("CA_Jenis") = "D" then
            TotalBLL =  BLL("SaldoDebet")  - BLL("SaldoKredit")
        else 
            TotalBLL =  BLL("SaldoKredit") - BLL("SaldoDebet") 
        end if

        TotalPBLL = TotalPLL+TotalBLL

        EBITDA = LabaRugiUsaha+TotalPBLL

        EBIT = EBITDA-DA

        EBT = EBIT-BebanBunga
    'LABA RUGI HASIL USAHA

    'NILAI FISKAL
        NilaiFiskal = EBT - JenisKoreksiNegatif + JenisKoreksiPositif
    'NILAI FISKAL

    'DPP
        NilaiF      = NilaiFiskal
        Nilai       = Right(NilaiF,3)
        if Nilai < 1000 then '999
            DPP = NilaiF-Nilai
        else
            DPP = NilaiF
        end if
    'DPP

    'PAJAK PENGHASILAN
        if PajakFiskal < 0 then
            PajakPenghasilan = 0
        else
            if TotalPendapatan < 4800000000 then

                PajakPenghasilan = round(DPP*(22/100*50/100))

            else if TotalPendapatan > 4800000000 then

                PajakPenghasilan = round(4800000000/TotalPendapatan*DPP)

            else 

                PajakPenghasilan = round(22/100*TotalPendapatan)

            end if end if
        end if
    'PAJAK PENGHASILAN

    'PAJAK TERHUTANG
        PajakTerhutang = PajakPenghasilan-JenisKoreksiKreditPajak
    'PAJAK TERHUTANG


    KalkulasiFiskal_CMD.commandText = "UPDATE GL_T_Fiskal_H SET FT_JKoreksiNegatif = '"& JenisKoreksiNegatif &"' , FT_JKoreksiPositif = '"& JenisKoreksiPositif &"', FT_NilaiHasilUsaha = '"& EBT &"', FT_TarifPajak = '"& FT_TarifPajak &"', FT_NilaiFiskal = '"& NilaiFiskal &"' , FT_DPP = '"& DPP &"', FT_PajakPenghasilan = '"& PajakPenghasilan &"', FT_Kompensasi = '"& FT_Kompensasi &"', FT_JKreditPajak = '"& JenisKoreksiKreditPajak &"', FT_PajakTerutang = '"& PajakTerhutang &"' WHERE FT_ID = '"& KalkulasiFiskal("id") &"' "
    'response.write KalkulasiFiskal_CMD.commandText  & "<br><br>"
    set UPDATEGLTFiskal = KalkulasiFiskal_CMD.execute

    Response.redirect "print.asp?FTID="& KalkulasiFiskal("id")
%>
