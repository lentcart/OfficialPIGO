<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    mmID = request.queryString("mmID") 
    
    set Penawaran_CMD = server.CreateObject("ADODB.command")
    Penawaran_CMD.activeConnection = MM_pigo_STRING

    Penawaran_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poID FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 WHERE MKT_T_MaterialReceipt_H.mmID = '"& mmID &"'  GROUP BY MKT_T_MaterialReceipt_D1.mm_poID "
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set POID = Penawaran_CMD.execute
    do while not POID.eof
        IDPO = POID("mm_poID")
        response.write IDPO &"<br><br>"

        Penawaran_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set po_spoID = '0' Where poID_H = '"& POID("mm_poID") &"' "
        'response.write Penawaran_CMD.commandText &"<br><br>"
        set UpdatePO = Penawaran_CMD.execute
    POID.movenext
    loop

    Penawaran_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN GL_T_Jurnal_H ON MKT_T_MaterialReceipt_H.mmID = GL_T_Jurnal_H.JR_Keterangan LEFT OUTER JOIN GL_T_Jurnal_D ON GL_T_Jurnal_H.JR_ID = GL_T_Jurnal_D.JRD_ID WHERE MKT_T_MaterialReceipt_H.mmID  = '"& mmID &"' GROUP BY GL_T_Jurnal_H.JR_ID  "
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set Jurnal = Penawaran_CMD.execute

    do while not Jurnal.eof
        JURNALID = Jurnal("JR_ID")
        'response.write JURNALID &"<br><br>"

        Penawaran_CMD.commandText = " DELETE FROM GL_T_Jurnal_D WHERE LEFT(JRD_Keterangan,16) = '"& mmID&"' "
        'response.write Penawaran_CMD.commandText &"<br><br>"
        set UpdateJurnalD1 = Penawaran_CMD.execute
        
        If Jurnal.eof = true then 

        Penawaran_CMD.commandText = " DELETE FROM GL_T_Jurnal_H WHERE JR_ID = '"& Jurnal("JR_ID") &"' "
        'response.write Penawaran_CMD.commandText &"<br><br>"
        set UpdateJurnalH = Penawaran_CMD.execute


        Penawaran_CMD.commandText = " DELETE FROM GL_T_Jurnal_D WHERE LEFT(JR_ID,12) = '"& Jurnal("JR_ID") &"' "
        'response.write Penawaran_CMD.commandText &"<br><br>"
        set UpdateJurnalD2 = Penawaran_CMD.execute
        else

        end if 
    Jurnal.movenext
    loop

    Penawaran_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_MaterialReceipt_H] Where mmID =  '"& mmID &"' "
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set Penawaran = Penawaran_CMD.execute
    Penawaran_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_MaterialReceipt_D1] Where mmID_D1 =  '"& mmID &"' "
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set PenawaranD = Penawaran_CMD.execute
    Penawaran_CMD.commandText = " Delete FROM [pigo].[dbo].[MKT_T_MaterialReceipt_D2] Where mmID_D2 =  '"& mmID &"' "
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set PenawaranD = Penawaran_CMD.execute

    
%> 