<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    poTanggal           = request.queryString("poTanggal")
    poJenis             = request.queryString("poJenis")
    poJenisOrder        = request.queryString("poJenisOrder")
    poTglOrder          = request.queryString("poTglOrder")
    poTglDiterima       = request.queryString("poTglDiterima")
    poStatusKredit      = request.queryString("poStatusKredit")
    poDesc              = request.queryString("poDesc")
    po_spID             = request.queryString("po_spID")
    poKonfPem           = request.queryString("poKonfPem")
    if poStatusKredit = "01" then
    po_spID             = request.queryString("po_spID")
    else 
    po_spID             = "C001-CASH"
    end if 


    set PurchaseOrder_H_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_H_CMD.activeConnection = MM_pigo_STRING

    if poStatusKredit = "01" then 
        PurchaseOrder_H_CMD.commandText = "exec sp_add_MKT_T_PurchaseOrder_H '"& poTanggal &"','"& poJenisOrder &"','"& poTglOrder &"','"& poTglDiterima &"','"& poStatusKredit &"','"& poDesc &"','','',0,'"& po_spID &"','','N','','N','','"& session("username") &"'"
        'response.write PurchaseOrder_H_CMD.commandText
        set PurchaseOrder_H = PurchaseOrder_H_CMD.execute 
    else 
        PurchaseOrder_H_CMD.commandText = "exec sp_add_MKT_T_PurchaseOrder_H '"& poTanggal &"','"& poJenisOrder &"','"& poTglOrder &"','"& poTglDiterima &"','"& poStatusKredit &"','"& poDesc &"','','',0,'"& po_spID &"','','N','','N','','"& session("username") &"'"
        'response.write PurchaseOrder_H_CMD.commandText
        set PurchaseOrder_H = PurchaseOrder_H_CMD.execute 
    end if

    set PurchaseOrder_R_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_R_CMD.activeConnection = MM_pigo_STRING
    PurchaseOrder_R_CMD.commandText = " INSERT INTO [dbo].[MKT_T_PurchaseOrder_R]([poID],[po_Ket],[po_custID],[poUpdateID],[poUpdateTime],[poAktifYN])VALUES('"& PurchaseOrder_H("id") &"','01','"& po_spID &"','"& session("username") &"','"& now() &"','Y') "
    'response.write PurchaseOrder_R_CMD.commandText
    set PurchaseOrder_R = PurchaseOrder_R_CMD.execute

%>

<input type="hidden" name="poID" id="poID" value="<%=PurchaseOrder_H("id")%>"><input type="hidden" name="poTanggal" id="poTanggal" value="<%=poTanggal%>">
<button onclick="batal()" class="cont-btn"> <i class="fas fa-ban"></i>&nbsp;&nbsp; Batalkan PO </button>