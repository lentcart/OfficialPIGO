<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    pscType  = request.form("typedokumen")
    pscTanggal  = request.form("tglpscb")
    pscMoveDate  = request.form("movedate")
    pscAccDate  = request.form("accdate")
    pscDesc  = request.form("desc")
    pscDelvRule  = request.form("delrule")
    pscDelvVia  = request.form("delvia")
    pscPriority  = request.form("Priority")
    pscFCRule  = request.form("fcrule")

    pscD1_NoPermintaan  = request.form("nopermintaan")
    pscD1_TglPermintaan  = request.form("tglpermintaan")
    pscD1_spID  = request.form("supplierid")


        
    set PengeluaranSC_H_CMD = server.CreateObject("ADODB.command")
    PengeluaranSC_H_CMD.activeConnection = MM_pigo_STRING
    PengeluaranSC_H_CMD.commandText = "exec sp_add_MKT_T_PengeluaranSC_H '"& pscType &"','"& pscTanggal &"','"& pscMoveDate &"','"& pscAccDate &"','"& pscDesc &"','"& pscDelvRule &"','"& pscDelvVia &"','"& pscPriority &"','"& pscFCRule &"','"& request.Cookies("custID") &"'"
    'response.write PengeluaranSC_H_CMD.commandText
    set PengeluaranSC_H = PengeluaranSC_H_CMD.execute

    set PengeluaranSC_D1_CMD = server.CreateObject("ADODB.command")
    PengeluaranSC_D1_CMD.activeConnection = MM_pigo_STRING
    PengeluaranSC_D1_CMD.commandText = "INSERT INTO [dbo].[MKT_T_PengeluaranSC_D1]([pscID1_H],[pscD1_NoPermintaan],[pscD1_TglPermintaan],[pscD1_spID],[pscD1UpdateTime],[pscD1AktifYN]) VALUES ('"& PengeluaranSC_H("id") &"','"& pscD1_NoPermintaan &"','"& pscD1_TglPermintaan &"','"& pscD1_spID &"','"& now() &"','Y')"
    'response.write PengeluaranSC_D1_CMD.commandText
    set PengeluaranSC_D1 = PengeluaranSC_D1_CMD.execute



    response.redirect "loadproduk.asp?pscID=" & trim(PengeluaranSC_H("id"))

%>