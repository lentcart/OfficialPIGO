<!--#include file="../../../../Connections/pigoConn.asp" -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    if Session("Username")="" then 
        response.redirect("../../../../admin/")
    end if

    RUP_Tanggala     = CDate(Request.Form("RUP_Tanggala"))
    RUP_Tanggale     = CDate(Request.Form("RUP_Tanggale"))
    RUP_Jenis        =  Request.Form("RUP_Jenis")
    RUP_Bulan        = Month(Request.Form("RUP_Tanggala"))
    RUP_Tahun        = Year(Request.Form("RUP_Tanggala"))

    set RUP_CMD = server.createObject("ADODB.COMMAND")
	RUP_CMD.activeConnection = MM_PIGO_String

    If RUP_Jenis = "AP" then
        ' TRANSAKSI AP
            RUP_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mm_custID FROM MKT_M_Customer INNER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID WHERE (YEAR(MKT_T_MaterialReceipt_H.mmTanggal) = '"& RUP_Tahun &"') AND (NOT EXISTS (SELECT RUP_Tahun, RUP_custID FROM GL_T_RekapUmurPiutang WHERE (RUP_Tahun = '"& RUP_Tahun &"') AND (RUP_custID = MKT_T_MaterialReceipt_H.mm_custID))) GROUP BY MKT_T_MaterialReceipt_H.mm_custID"
            'response.write RUP_CMD.commandText & "<br><br>"
            set RUP = RUP_CMD.execute 
            response.write RUP.eof & "<br><br>"

            if RUP.eof = true then

                RUP_CMD.commandText = "SELECT MKT_M_Customer.custNama, MKT_M_Customer.custID FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_MaterialReceipt_H.mm_custID = MKT_M_Customer.custID WHERE mmTanggal BETWEEN '"& RUP_Tanggala &"' AND '"& RUP_Tanggale &"' GROUP BY MKT_M_Customer.custNama, MKT_M_Customer.custID"
                'response.write RUP_CMD.commandText & "<br><br>"
                set BussinesPartner = RUP_CMD.execute 

                do while not BussinesPartner.eof  

                    RUP_CMD.commandText = "DELETE FROM [dbo].[GL_T_RekapUmurPiutang]  WHERE [RUP_custID] = '"& BussinesPartner("custID") &"' AND RUP_Jenis '"& RUP_Jenis &"'"
                    'response.write RUP_CMD.commandText & "<br><br>"
                    set UpdateInvAR = RUP_CMD.execute

                    RUP_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, SUM(MKT_T_MaterialReceipt_D2.mm_pdSubtotal) AS TotalAP, MKT_T_MaterialReceipt_H.mm_tfYN FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE mmTanggal BETWEEN '"& RUP_Tanggala &"' AND '"& RUP_Tanggale &"' AND mm_custID = '"& BussinesPartner("custID") &"' GROUP BY MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_tfYN,MKT_T_MaterialReceipt_H.mmID "
                    'response.write RUP_CMD.commandText & "<br><br>"
                    set InvAP = RUP_CMD.execute

                    do while not InvAP.eof

                        UmurPiutang =  RUP_Tanggale - CDate(InvAP("mmTanggal")) 

                        if UmurPiutang <= 30 then
                            RUP_UmurPiutang = "RUP0130"
                        Else if UmurPiutang >=31 then
                            if  UmurPiutang >=61 then
                                if UmurPiutang >=91 then
                                    if UmurPiutang >=181 then
                                        if UmurPiutang >181 then
                                            RUP_UmurPiutang = "RUP366"
                                        else
                                            RUP_UmurPiutang = "RUP181360"
                                        end if 
                                    else 
                                        RUP_UmurPiutang = "RUP91180"
                                    end if 
                                else
                                    RUP_UmurPiutang = "RUP6190"
                                end if 
                            else 
                                RUP_UmurPiutang = "RUP3160"
                            end if 
                        end if end if 

                            if InvAP("mm_tfYN") = "Y" then 

                                
                                RUP_CMD.commandText = "INSERT INTO [dbo].[GL_T_RekapUmurPiutang]([RUP_Tahun],[RUP_Jenis],[RUP_Tanggal],[RUP_Keterangan],"& RUP_UmurPiutang &",[RUP_custID],[RUP_AktifYN],[RUP_UpdateID],[RUP_UpdateTime])VALUES('"& RUP_Tahun &"','"& RUP_Jenis &"','"& InvAP("mmTanggal") &"','"& InvAP("mmTanggal") &" - "& InvAP("mmID") & " - Sudah Tukar Faktur" &"','"& InvAP("TotalAP") &"','"& BussinesPartner("custID") &"','Y','"& session("username") &"','"& now() &"')"
                                'response.write RUP_CMD.commandText & "<br><br>"
                                set AddRUP = RUP_CMD.execute

                            else

                                RUP_CMD.commandText = "INSERT INTO [dbo].[GL_T_RekapUmurPiutang]([RUP_Tahun],[RUP_Jenis],[RUP_Tanggal],[RUP_Keterangan],"& RUP_UmurPiutang &",[RUP_custID],[RUP_AktifYN],[RUP_UpdateID],[RUP_UpdateTime])VALUES('"& RUP_Tahun &"','"& RUP_Jenis &"','"& InvAP("mmTanggal") &"','"& InvAP("mmTanggal") &" - "& InvAP("mmID") & " - Belum Tukar Faktur" &"','"& InvAP("TotalAP") &"','"& BussinesPartner("custID") &"','Y','"& session("username") &"','"& now() &"')"
                                'response.write RUP_CMD.commandText & "<br><br>"
                                set AddRUP = RUP_CMD.execute

                            end if 

                        InvAP.movenext
                        loop

                BussinesPartner.movenext
                loop
            else
                do while not RUP.eof 
                    RUP_CMD.commandText = "INSERT INTO [dbo].[GL_T_RekapUmurPiutang]([RUP_Tahun],[RUP_Jenis],[RUP_Tanggal],[RUP_Keterangan],[RUP0130],[RUP3160],[RUP6190],[RUP91180],[RUP181360],[RUP366],[RUPPasal23],[RUPLainnya],[RUP_Total],[RUP_custID],[RUP_AktifYN],[RUP_UpdateID],[RUP_UpdateTime])VALUES('"& RUP_Tahun &"','"& RUP_Jenis &"','','',0,0,0,0,0,0,0,0,0,'"& RUP("mm_custID") &"','Y','"& session("username") &"','"& now() &"')"
                    'response.write RUP_CMD.commandText & "<br><br>"
                    set AddRUP = RUP_CMD.execute

                    RUP_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, SUM(MKT_T_MaterialReceipt_D2.mm_pdSubtotal) AS TotalAP, MKT_T_MaterialReceipt_H.mm_tfYN FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE mmTanggal BETWEEN '"& RUP_Tanggala &"' AND '"& RUP_Tanggale &"' AND mm_custID = '"& RUP("mm_custID") &"' GROUP BY MKT_T_MaterialReceipt_H.mmTanggal, MKT_T_MaterialReceipt_H.mm_tfYN,MKT_T_MaterialReceipt_H.mmID "
                    'response.write RUP_CMD.commandText & "<br><br>"
                    set InvAP = RUP_CMD.execute

                    do while not InvAP.eof

                        UmurPiutang =  RUP_Tanggale - CDate(InvAP("mmTanggal")) 

                        if UmurPiutang <= 30 then
                            RUP_UmurPiutang = "RUP0130"
                        Else if UmurPiutang >=31 then
                            if  UmurPiutang >=61 then
                                if UmurPiutang >=91 then
                                    if UmurPiutang >=181 then
                                        if UmurPiutang >181 then
                                            RUP_UmurPiutang = "RUP366"
                                        else
                                            RUP_UmurPiutang = "RUP181360"
                                        end if 
                                    else 
                                        RUP_UmurPiutang = "RUP91180"
                                    end if 
                                else
                                    RUP_UmurPiutang = "RUP6190"
                                end if 
                            else 
                                RUP_UmurPiutang = "RUP3160"
                            end if 
                        end if end if 

                            if InvAP("mm_tfYN") = "Y" then 

                                RUP_CMD.commandText = "UPDATE GL_T_RekapUmurPiutang SET "& RUP_UmurPiutang &" = '"& InvAP("TotalAP") &"', RUP_Tanggal = '"& InvAP("mmTanggal") &"', RUP_Keterangan = '"& InvAP("mmTanggal") &" - "& InvAP("mmID") & " - Sudah Tukar Faktur" &"'Where RUP_custID = '"& RUP("mm_custID") &"' AND RUP_Tahun = '"& RUP_Tahun &"' "
                                'response.write RUP_CMD.commandText & "<br><br>"
                                set AddInvAP = RUP_CMD.execute

                            else
                                RUP_CMD.commandText = "UPDATE GL_T_RekapUmurPiutang SET "& RUP_UmurPiutang &" = '"& InvAP("TotalAP") &"', RUP_Tanggal = '"& InvAP("mmTanggal") &"', RUP_Keterangan = '"& InvAP("mmTanggal") &" - "& InvAP("mmID") & " - Belum Tukar Faktur"&"'Where RUP_custID = '"& RUP("mm_custID") &"' AND RUP_Tahun = '"& RUP_Tahun &"' "
                                'response.write RUP_CMD.commandText & "<br><br>"
                                set AddInvAP = RUP_CMD.execute
                            end if 

                        InvAP.movenext
                        loop

                RUP.movenext
                loop
            end if 
        ' TRANSAKSI AP
    else
        ' TRANSAKSI AR
            RUP_CMD.commandText = "SELECT MKT_T_SuratJalan_H.SJ_custID FROM MKT_M_Customer INNER JOIN MKT_T_SuratJalan_H ON MKT_M_Customer.custID = MKT_T_SuratJalan_H.SJ_custID  WHERE (YEAR(MKT_T_SuratJalan_H.SJ_Tanggal) = '"& RUP_Tahun &"') AND (NOT EXISTS (SELECT RUP_Tahun, RUP_custID FROM GL_T_RekapUmurPiutang  WHERE (RUP_Tahun = '"& RUP_Tahun &"') AND (RUP_Jenis = '"& RUP_Jenis &"') AND (RUP_custID = MKT_T_SuratJalan_H.SJ_custID))) GROUP BY MKT_T_SuratJalan_H.SJ_custID"
            'response.write RUP_CMD.commandText & "<br><br>"
            set RUP = RUP_CMD.execute 
            response.write RUP.eof & "<br><br>"

            if RUP.eof = true then
                RUP_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_SuratJalan_H ON MKT_M_Customer.custID = MKT_T_SuratJalan_H.SJ_custID WHERE MKT_T_SuratJalan_H.SJ_Tanggal BETWEEN '"& RUP_Tanggala &"' AND '"& RUP_Tanggale &"' GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama"
                'response.write RUP_CMD.commandText & "<br><br>"
                set BussinesPartner = RUP_CMD.execute

                do while not BussinesPartner.eof
                    
                    RUP_CMD.commandText = "DELETE FROM [dbo].[GL_T_RekapUmurPiutang]  WHERE [RUP_custID] = '"& BussinesPartner("custID") &"' AND RUP_Jenis '"& RUP_Jenis &"'"
                    'response.write RUP_CMD.commandText & "<br><br>"
                    set UpdateInvAR = RUP_CMD.execute

                    RUP_CMD.commandText = "SELECT MKT_T_SuratJalan_H.SJID,MKT_T_SuratJalan_H.SJ_Tanggal, MKT_T_SuratJalan_H.SJ_TerimaYN, sum(MKT_T_SuratJalan_D.SJIDD_pdHargaJual*MKT_T_SuratJalan_D.SJID_pdQty) AS Total, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax FROM MKT_T_SuratJalan_H LEFT OUTER JOIN MKT_T_SuratJalan_D ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH,18) WHERE SJ_custID = '"& BussinesPartner("custID") &"'  GROUP BY MKT_T_SuratJalan_H.SJ_Tanggal,MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax,MKT_T_SuratJalan_H.SJ_TerimaYN,MKT_T_SuratJalan_H.SJID "
                    'response.write RUP_CMD.commandText & "<br><br>"
                    set InvAR = RUP_CMD.execute

                    do while not InvAR.eof 
                        Total       = InvAR("Total")
                        PPN         = InvAR("SJID_pdTax")
                        UPTO        = InvAR("SJID_pdUpto")
                        ReturnUPTO  = Total+(Total*UPTO/100)
                        ReturnPPN   = ReturnPPN*PPN/100
                        SubTotal    = ReturnPPN+ReturnUPTO

                        'response.write SubTotal & "<br><br>"
                    
                        UmurPiutang =  RUP_Tanggal - CDate(InvAR("SJ_Tanggal")) 
                        'response.write UmurPiutang & "gg<br><br>"

                        if UmurPiutang <= 30 then
                            RUP_UmurPiutang = "RUP0130"
                        Else if UmurPiutang >=31 then
                            if  UmurPiutang >=61 then
                                if UmurPiutang >=91 then
                                    if UmurPiutang >=181 then
                                        if UmurPiutang >181 then
                                            RUP_UmurPiutang = "RUP366"
                                        else
                                            RUP_UmurPiutang = "RUP181360"
                                        end if 
                                    else 
                                        RUP_UmurPiutang = "RUP91180"
                                    end if 
                                else
                                    RUP_UmurPiutang = "RUP6190"
                                end if 
                            else 
                                RUP_UmurPiutang = "RUP3160"
                            end if 
                        end if end if

                        RUP_CMD.commandText = "INSERT INTO [dbo].[GL_T_RekapUmurPiutang]([RUP_Tahun],[RUP_Jenis],[RUP_Tanggal],[RUP_Keterangan],"& RUP_UmurPiutang &",[RUP_custID],[RUP_AktifYN],[RUP_UpdateID],[RUP_UpdateTime])VALUES('"& RUP_Tahun &"','"& RUP_Jenis &"','"& InvAR("SJ_Tanggal") &"','"& InvAR("SJ_Tanggal") &" - "& InvAR("SJID") & " - Sudah Tukar Faktur" &"','"& SubTotal &"','"& BussinesPartner("custID") &"','Y','"& session("username") &"','"& now() &"')"
                        'response.write RUP_CMD.commandText & "<br><br>"
                        set AddRUP = RUP_CMD.execute


                        ' if InvAR("SJ_TerimaYN") = "Y" then 

                        '     RUP_CMD.commandText = "UPDATE GL_T_RekapUmurPiutang SET "& RUP_UmurPiutang &" = '"& SubTotal &"', RUP_Tanggal = '"& InvAR("SJ_Tanggal") &"', RUP_Keterangan = '"& InvAR("SJ_Tanggal") &" - "& InvAR("SJID") & " - Sudah Tukar Faktur" &"'Where RUP_custID = '"& RUP("SJ_custID") &"' AND RUP_Tahun = '"& RUP_Tahun &"' "
                        '     'response.write RUP_CMD.commandText & "<br><br>"
                        '     set AddInvAP = RUP_CMD.execute

                        ' else

                        '     RUP_CMD.commandText = "UPDATE GL_T_RekapUmurPiutang SET "& RUP_UmurPiutang &" = '"& SubTotal &"', RUP_Tanggal = '"& InvAR("SJ_Tanggal") &"', RUP_Keterangan = '"& InvAR("SJ_Tanggal") &" - "& InvAR("SJID") & " - Belum Tukar Faktur"&"'Where RUP_custID = '"& RUP("SJ_custID") &"' AND RUP_Tahun = '"& RUP_Tahun &"' "
                        '     'response.write RUP_CMD.commandText & "<br><br>"
                        '     set AddInvAP = RUP_CMD.execute

                        ' end if 
                    InvAR.movenext
                    loop
                BussinesPartner.movenext
                loop

            else

                do while not RUP.eof 
                
                    RUP_CMD.commandText = "SELECT MKT_T_SuratJalan_H.SJID,MKT_T_SuratJalan_H.SJ_Tanggal, MKT_T_SuratJalan_H.SJ_TerimaYN, sum(MKT_T_SuratJalan_D.SJIDD_pdHargaJual*MKT_T_SuratJalan_D.SJID_pdQty) AS Total, MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax FROM MKT_T_SuratJalan_H LEFT OUTER JOIN MKT_T_SuratJalan_D ON MKT_T_SuratJalan_H.SJID = LEFT(MKT_T_SuratJalan_D.SJIDH,18) WHERE SJ_custID = '"& RUP("SJ_custID") &"'  GROUP BY MKT_T_SuratJalan_H.SJ_Tanggal,MKT_T_SuratJalan_D.SJID_pdUpto, MKT_T_SuratJalan_D.SJID_pdTax,MKT_T_SuratJalan_H.SJ_TerimaYN,MKT_T_SuratJalan_H.SJID "
                    'response.write RUP_CMD.commandText & "<br><br>"
                    set InvAR = RUP_CMD.execute

                    do while not InvAR.eof 
                        Total       = InvAR("Total")
                        PPN         = InvAR("SJID_pdTax")
                        UPTO        = InvAR("SJID_pdUpto")
                        ReturnUPTO  = Total+(Total*UPTO/100)
                        ReturnPPN   = ReturnPPN*PPN/100
                        SubTotal    = ReturnPPN+ReturnUPTO

                        'response.write SubTotal & "<br><br>"
                    
                        UmurPiutang =  RUP_Tanggal - CDate(InvAR("SJ_Tanggal")) 
                        'response.write UmurPiutang & "gg<br><br>"

                        if UmurPiutang <= 30 then
                            RUP_UmurPiutang = "RUP0130"
                        Else if UmurPiutang >=31 then
                            if  UmurPiutang >=61 then
                                if UmurPiutang >=91 then
                                    if UmurPiutang >=181 then
                                        if UmurPiutang >181 then
                                            RUP_UmurPiutang = "RUP366"
                                        else
                                            RUP_UmurPiutang = "RUP181360"
                                        end if 
                                    else 
                                        RUP_UmurPiutang = "RUP91180"
                                    end if 
                                else
                                    RUP_UmurPiutang = "RUP6190"
                                end if 
                            else 
                                RUP_UmurPiutang = "RUP3160"
                            end if 
                        end if end if

                        RUP_CMD.commandText = "INSERT INTO [dbo].[GL_T_RekapUmurPiutang]([RUP_Tahun],[RUP_Jenis],[RUP_Tanggal],[RUP_Keterangan],"& RUP_UmurPiutang &",[RUP_custID],[RUP_AktifYN],[RUP_UpdateID],[RUP_UpdateTime])VALUES('"& RUP_Tahun &"','"& RUP_Jenis &"','"& InvAR("SJ_Tanggal") &"','"& InvAR("SJ_Tanggal") &" - "& InvAR("SJID") & " - Sudah Tukar Faktur" &"','"& SubTotal &"','"& RUP("SJ_custID") &"','Y','"& session("username") &"','"& now() &"')"
                        'response.write RUP_CMD.commandText & "<br><br>"
                        set AddRUP = RUP_CMD.execute


                        ' if InvAR("SJ_TerimaYN") = "Y" then 

                        '     RUP_CMD.commandText = "UPDATE GL_T_RekapUmurPiutang SET "& RUP_UmurPiutang &" = '"& SubTotal &"', RUP_Tanggal = '"& InvAR("SJ_Tanggal") &"', RUP_Keterangan = '"& InvAR("SJ_Tanggal") &" - "& InvAR("SJID") & " - Sudah Tukar Faktur" &"'Where RUP_custID = '"& RUP("SJ_custID") &"' AND RUP_Tahun = '"& RUP_Tahun &"' "
                        '     'response.write RUP_CMD.commandText & "<br><br>"
                        '     set AddInvAP = RUP_CMD.execute

                        ' else

                        '     RUP_CMD.commandText = "UPDATE GL_T_RekapUmurPiutang SET "& RUP_UmurPiutang &" = '"& SubTotal &"', RUP_Tanggal = '"& InvAR("SJ_Tanggal") &"', RUP_Keterangan = '"& InvAR("SJ_Tanggal") &" - "& InvAR("SJID") & " - Belum Tukar Faktur"&"'Where RUP_custID = '"& RUP("SJ_custID") &"' AND RUP_Tahun = '"& RUP_Tahun &"' "
                        '     'response.write RUP_CMD.commandText & "<br><br>"
                        '     set AddInvAP = RUP_CMD.execute

                        ' end if 
                    InvAR.movenext
                    loop

                RUP.movenext
                loop
            end if  
        ' TRANSAKSI AR
    end if 

    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> REKAP BERHASIL DI PROSES </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/GL/Cetak/Rekap-Umur-Piutang/RUP-Print.asp?RUP_Tanggala="& RUP_Tanggala &"&RUP_Tanggale="& RUP_Tanggale &"&RUP_Jenis="& RUP_Jenis &" style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'> LIHAT BUKTI REKAP</a></div></div></div>"
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
        