<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    TF_ID  = request.queryString("TF_ID")
    TFD_mmID  = request.queryString("TFD_mmID")

    set TukarFaktur_H_CMD = server.CreateObject("ADODB.command")
    TukarFaktur_H_CMD.activeConnection = MM_pigo_STRING
    TukarFaktur_H_CMD.commandText = "SELECT MKT_T_TukarFaktur_D.TF_mmID FROM MKT_T_TukarFaktur_D RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) = MKT_T_TukarFaktur_H.TF_ID WHERE TF_ID = '"& TF_ID &"'  "
    set TukarFaktur = TukarFaktur_H_CMD.execute

    do while not TukarFaktur.eof

    a = TukarFaktur("TF_mmID")

        set UpdateJurnalD_CMD = server.CreateObject("ADODB.command")
        UpdateJurnalD_CMD.activeConnection = MM_pigo_STRING
        UpdateJurnalD_CMD.commandText = "Delete FROM [pigo].[dbo].[GL_T_Jurnal_D] WHERE RIGHT(JRD_Keterangan,16) = '"& TukarFaktur("TF_mmID") &"' "
        response.write UpdateJurnalD_CMD.commandText & "<br>"
        set UpdateJurnalD = UpdateJurnalD_CMD.execute

        set UpdateMM_CMD = server.CreateObject("ADODB.command")
        UpdateMM_CMD.activeConnection = MM_pigo_STRING
        UpdateMM_CMD.commandText = "UPDATE MKT_T_MaterialReceipt_H set mm_tfYN = 'N' where mmID = '"& TukarFaktur("TF_mmID") &"' "
        set UpdateMM = UpdateMM_CMD.execute

        UpdateMM_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poID FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID Where mmID = '"& TukarFaktur("TF_mmID") &"' GROUP BY MKT_T_MaterialReceipt_D1.mm_poID "
        response.write UpdateMM_CMD.commandText &"<br><br>"
        set POID = UpdateMM_CMD.execute

        UpdateMM_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set po_tfYN = 'N' where poID_H = '"& POID("mm_poID") &"' "
        set UpdatePOMM = UpdateMM_CMD.execute

        TukarFaktur_H_CMD.commandText = "DELETE MKT_T_TukarFaktur_H Where TF_ID = '"& TF_ID &"' "
        set TukarFaktur_H = TukarFaktur_H_CMD.execute

        TukarFaktur_H_CMD.commandText = "DELETE MKT_T_TukarFaktur_D Where LEFT(TFD_ID,16) = '"& TF_ID &"' "
        set TukarFaktur_D = TukarFaktur_H_CMD.execute

        TukarFaktur_H_CMD.commandText = "DELETE MKT_T_TukarFaktur_D1 Where LEFT(TFD1_ID,16) = '"& TF_ID &"' "
        set TukarFaktur_D = TukarFaktur_H_CMD.execute
        
    TukarFaktur.movenext
    loop

%>