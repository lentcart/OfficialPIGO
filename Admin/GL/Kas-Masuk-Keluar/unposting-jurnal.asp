<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    CB_ID = request.queryString("CB_ID")
    CB_JR_ID = request.queryString("CB_JR_ID")

    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_PIGO_String
    Jurnal_H_CMD.commandText = "UPDATE GL_T_CashBank_H SET CB_PostingYN = 'N'  WHERE CB_ID = '"& CB_ID &"' "
    response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set UpdateKas = Jurnal_H_CMD.execute

    Jurnal_H_CMD.commandText = "DELETE FROM [pigo].[dbo].[GL_T_Jurnal_D] WHERE LEFT(JRD_ID,12) = '"& CB_JR_ID &"' "
    response.write Jurnal_H_CMD.commandText  & "<br><br>"
    set UpdateJurnal = Jurnal_H_CMD.execute

%>