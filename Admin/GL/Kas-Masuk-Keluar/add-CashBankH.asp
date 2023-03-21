<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    CB_Tanggal = request.form("tgltransaksi")
    CB_Tipe = request.form("jenis")
    CB_Keterangan = request.form("keterangan")
    CB_Pembuat = request.form("updatename")


    set Kas_H_CMD = server.CreateObject("ADODB.command")
    Kas_H_CMD.activeConnection = MM_PIGO_String
    Kas_H_CMD.commandText = "exec sp_add_GL_T_CashBank_H '"& CB_Tanggal &"','"& CB_Tipe &"','"& CB_Keterangan &"',0,'','"& CB_Pembuat &"','N', '"& session("username")  &"' "
    response.write Kas_H_CMD.commandText
    set Kas_H = Kas_H_CMD.execute

    response.redirect "Kas-Detail.asp?X=" & trim(Kas_H("id"))

%>