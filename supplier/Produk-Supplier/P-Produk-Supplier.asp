<!--#include file="../../connections/pigoConn.asp"-->

<% 

        sp_spNama  = request.form("sp_spNama")		
        sp_pdNama  = request.form("sp_pdNama")		
        sp_pdQty  = request.form("sp_pdQty")		
        sp_pdHarga  = request.form("sp_pdHarga")
        sp_pdType  = request.form("sp_pdType")
        sp_pdMerk  = request.form("sp_pdMerk")
        sp_pdKat  = request.form("sp_pdKat")
        sp_pdTglPembelian  = request.form("sp_pdTglPembelian")
    
    
    set Supplier_P_CMD = server.CreateObject("ADODB.command")
    Supplier_P_CMD.activeConnection = MM_pigo_STRING

    Supplier_P_CMD.commandText = "exec sp_add_MKT_M_Supplier_P '"& sp_spNama &"','"& sp_pdNama &"','"& sp_pdQty &"',"& sp_pdHarga &",'"& sp_pdType &"','"& sp_pdMerk &"','"& sp_pdKat &"','"& sp_pdTglPembelian &"' "
    'response.write Supplier_P_CMD.commandText
    set pr = Supplier_P_CMD.execute

    Response.redirect "../"
%> 