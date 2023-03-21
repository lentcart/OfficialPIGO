<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    CB_ID               = request.queryString("CB_ID")
    CB_Keterangan       = request.queryString("CB_Keterangan")
    CB_Tanggal          = request.queryString("CB_Tanggal")
    CB_Tipe             = request.queryString("CB_Tipe")
    JR_Type             = request.queryString("JR_Type")
    JR_UpdateID         = request.queryString("JR_UpdateID")

    set Kas_CMD = server.CreateObject("ADODB.command")
    Kas_CMD.activeConnection = MM_pigo_STRING
    Kas_CMD.commandText = "SELECT CB_JR_ID FROM GL_T_CashBank_H WHERE CB_ID = '"& CB_ID &"' "
    'response.write Kas_CMD.commandText  & "<br><br>"
    set KasH = Kas_CMD.execute

    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_pigo_STRING

    if KasH("CB_JR_ID") = "" then
    
    Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& CB_Tanggal &"','"& CB_Keterangan &"','"& CB_Tipe &"','N','N','N','"& session("username") &"','CB','Y'"
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set Jurnal = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "UPDATE GL_T_CashBank_H SET CB_PostingYN = 'Y', CB_JR_ID = '"& Jurnal("id") &"'  WHERE CB_ID = '"& CB_ID &"' "
    'response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set UpdateKas = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "SELECT count(GL_M_Item.Item_CAIDD) as jumlah FROM GL_M_ChartAccount AS DEBET RIGHT OUTER JOIN GL_M_ChartAccount AS KREDIT RIGHT OUTER JOIN GL_T_CashBank_H LEFT OUTER JOIN GL_T_CashBank_D LEFT OUTER JOIN GL_M_Item ON GL_T_CashBank_D.CBD_Item_ID = GL_M_Item.Item_ID ON GL_T_CashBank_H.CB_ID = LEFT(GL_T_CashBank_D.CBD_ID,18) ON KREDIT.CA_ID = GL_M_Item.Item_CAIDK ON  DEBET.CA_ID = GL_M_Item.Item_CAIDD WHERE (GL_T_CashBank_H.CB_ID = '"& CB_ID &"')"
    'response.write Jurnal_H_CMD.commandText & "<br><br>"
    set JmlDebet = Jurnal_H_CMD.execute
    response.write JmlDebet("jumlah") & "<br><br>"

    Jurnal_H_CMD.commandText = "SELECT  GL_M_Item.Item_CAIDD,GL_T_CashBank_H.CB_Keterangan,GL_T_CashBank_D.CBD_Keterangan, GL_T_CashBank_D.CBD_Harga AS Debet, 0 as Kredit FROM GL_M_ChartAccount AS DEBET RIGHT OUTER JOIN GL_M_ChartAccount AS KREDIT RIGHT OUTER JOIN GL_T_CashBank_H LEFT OUTER JOIN GL_T_CashBank_D LEFT OUTER JOIN GL_M_Item ON GL_T_CashBank_D.CBD_Item_ID = GL_M_Item.Item_ID ON GL_T_CashBank_H.CB_ID = LEFT(GL_T_CashBank_D.CBD_ID,18) ON KREDIT.CA_ID = GL_M_Item.Item_CAIDK ON  DEBET.CA_ID = GL_M_Item.Item_CAIDD WHERE (GL_T_CashBank_H.CB_ID = '"& CB_ID &"')"
    'response.write Jurnal_H_CMD.commandText & "<br><br>"
    set DataKasDebet = Jurnal_H_CMD.execute

    Do while not DataKasDebet.eof

        JRD_CA_ID = DataKasDebet("Item_CAIDD")
        JRD_Keterangan = DataKasDebet("CBD_Keterangan")
        JRD_Debet = DataKasDebet("Debet")
        JRD_Kredit = DataKasDebet("Kredit")

        acc  = JmlDebet("jumlah")
        jml = split(acc)

        for i = 0 to Ubound(jml)
            set Jurnal_H_CMD = server.CreateObject("ADODB.command")
            Jurnal_H_CMD.activeConnection = MM_pigo_STRING
            Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_D  '"& Jurnal("id") &"', '"& JRD_CA_ID &"', '"& JRD_Keterangan &"', '"& JRD_Debet &"', '"& JRD_Kredit &"' "
            'response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set JurnalD = Jurnal_H_CMD.execute
        next
        
    DataKasDebet.movenext
    loop 

    Jurnal_H_CMD.commandText = "SELECT GL_T_CashBank_H.CB_Keterangan,GL_T_CashBank_D.CBD_Keterangan,  GL_T_CashBank_D.CBD_Harga AS Kredit, 0 AS Debet, GL_M_Item.Item_CAIDK FROM GL_M_ChartAccount AS DEBET RIGHT OUTER JOIN GL_M_ChartAccount AS KREDIT RIGHT OUTER JOIN GL_T_CashBank_H LEFT OUTER JOIN GL_T_CashBank_D LEFT OUTER JOIN GL_M_Item ON GL_T_CashBank_D.CBD_Item_ID = GL_M_Item.Item_ID ON GL_T_CashBank_H.CB_ID =  LEFT(GL_T_CashBank_D.CBD_ID,18) ON KREDIT.CA_ID = GL_M_Item.Item_CAIDK ON  DEBET.CA_ID = GL_M_Item.Item_CAIDD WHERE (GL_T_CashBank_H.CB_ID = '"& CB_ID &"')"
    response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set DataKasKredit = Jurnal_H_CMD.execute

    Do while not DataKasKredit.eof

        JRD_CA_ID = DataKasKredit("Item_CAIDK")
        JRD_Keterangan = DataKasKredit("CBD_Keterangan")
        JRD_Debet = DataKasKredit("Debet")
        JRD_Kredit = DataKasKredit("Kredit")

        acc  = JmlDebet("jumlah")
        jml = split(acc)

        for i = 0 to Ubound(jml)
            set Jurnal_H_CMD = server.CreateObject("ADODB.command")
            Jurnal_H_CMD.activeConnection = MM_pigo_STRING
            Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_D  '"& Jurnal("id") &"', '"& JRD_CA_ID &"', '"& JRD_Keterangan &"', '"& JRD_Debet &"', '"& JRD_Kredit &"' "
            'response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set JurnalD = Jurnal_H_CMD.execute
        next
    DataKasKredit.movenext
    loop 

    else 

    Jurnal_H_CMD.commandText = "UPDATE GL_T_CashBank_H SET CB_PostingYN = 'Y', CB_JR_ID = '"& KasH("CB_JR_ID") &"'  WHERE CB_ID = '"& CB_ID &"' "
    response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set UpdateKas = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "SELECT count(GL_M_Item.Item_CAIDD) as jumlah FROM GL_M_ChartAccount AS DEBET RIGHT OUTER JOIN GL_M_ChartAccount AS KREDIT RIGHT OUTER JOIN GL_T_CashBank_H LEFT OUTER JOIN GL_T_CashBank_D LEFT OUTER JOIN GL_M_Item ON GL_T_CashBank_D.CBD_Item_ID = GL_M_Item.Item_ID ON GL_T_CashBank_H.CB_ID =  LEFT(GL_T_CashBank_D.CBD_ID,18) ON KREDIT.CA_ID = GL_M_Item.Item_CAIDK ON  DEBET.CA_ID = GL_M_Item.Item_CAIDD WHERE (GL_T_CashBank_H.CB_ID = '"& CB_ID &"')"
    response.write Jurnal_H_CMD.commandText & "<br><br>"
    set JmlDebet = Jurnal_H_CMD.execute
    response.write JmlDebet("jumlah") & "<br><br>"

    Jurnal_H_CMD.commandText = "SELECT  GL_M_Item.Item_CAIDD,GL_T_CashBank_H.CB_Keterangan,GL_T_CashBank_D.CBD_Keterangan,GL_T_CashBank_D.CBD_Harga AS Debet, 0 as Kredit FROM GL_M_ChartAccount AS DEBET RIGHT OUTER JOIN GL_M_ChartAccount AS KREDIT RIGHT OUTER JOIN GL_T_CashBank_H LEFT OUTER JOIN GL_T_CashBank_D LEFT OUTER JOIN GL_M_Item ON GL_T_CashBank_D.CBD_Item_ID = GL_M_Item.Item_ID ON GL_T_CashBank_H.CB_ID =  LEFT(GL_T_CashBank_D.CBD_ID,18) ON KREDIT.CA_ID = GL_M_Item.Item_CAIDK ON  DEBET.CA_ID = GL_M_Item.Item_CAIDD WHERE (GL_T_CashBank_H.CB_ID = '"& CB_ID &"')"
    response.write Jurnal_H_CMD.commandText & "<br><br>"
    set DataKasDebet = Jurnal_H_CMD.execute

    Do while not DataKasDebet.eof

        JRD_CA_ID = DataKasDebet("Item_CAIDD")
        JRD_Keterangan = DataKasDebet("CBD_Keterangan")
        JRD_Debet = DataKasDebet("Debet")
        JRD_Kredit = DataKasDebet("Kredit")

        acc  = JmlDebet("jumlah")
        jml = split(acc)

        for i = 0 to Ubound(jml)
            set Jurnal_H_CMD = server.CreateObject("ADODB.command")
            Jurnal_H_CMD.activeConnection = MM_pigo_STRING
            Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_D  '"& KasH("CB_JR_ID") &"', '"& JRD_CA_ID &"', '"& JRD_Keterangan &"', '"& JRD_Debet &"', '"& JRD_Kredit &"' "
            ' response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set JurnalD = Jurnal_H_CMD.execute
        next
    DataKasDebet.movenext
    loop 

    Jurnal_H_CMD.commandText = "SELECT GL_T_CashBank_H.CB_Keterangan, GL_T_CashBank_D.CBD_Keterangan,GL_T_CashBank_D.CBD_Harga AS Kredit, 0 AS Debet, GL_M_Item.Item_CAIDK FROM GL_M_ChartAccount AS DEBET RIGHT OUTER JOIN GL_M_ChartAccount AS KREDIT RIGHT OUTER JOIN GL_T_CashBank_H LEFT OUTER JOIN GL_T_CashBank_D LEFT OUTER JOIN GL_M_Item ON GL_T_CashBank_D.CBD_Item_ID = GL_M_Item.Item_ID ON GL_T_CashBank_H.CB_ID =  LEFT(GL_T_CashBank_D.CBD_ID,18) ON KREDIT.CA_ID = GL_M_Item.Item_CAIDK ON  DEBET.CA_ID = GL_M_Item.Item_CAIDD WHERE (GL_T_CashBank_H.CB_ID = '"& CB_ID &"')"
    response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set DataKasKredit = Jurnal_H_CMD.execute

    Do while not DataKasKredit.eof

        JRD_CA_ID = DataKasKredit("Item_CAIDK")
        JRD_Keterangan = DataKasKredit("CBD_Keterangan")
        JRD_Debet = DataKasKredit("Debet")
        JRD_Kredit = DataKasKredit("Kredit")

        acc  = JmlDebet("jumlah")
        jml = split(acc)

        for i = 0 to Ubound(jml)
            set Jurnal_H_CMD = server.CreateObject("ADODB.command")
            Jurnal_H_CMD.activeConnection = MM_pigo_STRING
            Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_D  '"& KasH("CB_JR_ID") &"', '"& JRD_CA_ID &"', '"& JRD_Keterangan &"', '"& JRD_Debet &"', '"& JRD_Kredit &"' "
            ' response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set JurnalD = Jurnal_H_CMD.execute
        next
    DataKasKredit.movenext
    loop 

    end if

%>