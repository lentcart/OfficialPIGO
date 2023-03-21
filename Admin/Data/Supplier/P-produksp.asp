<!--#include file="../../../connections/pigoConn.asp"-->

<% 

        spID  = request.form("spID")		
        sp_pdNama  = request.form("sp_pdNama")		
        sp_pdQty  = request.form("sp_pdQty")		
        sp_pdHarga  = request.form("sp_pdHarga")
        sp_pdType  = request.form("sp_pdType")
        sp_pdMerk  = request.form("sp_pdMerk")
        sp_pdKat  = request.form("sp_pdKat")
        sp_pdTglPembelian  = request.form("sp_pdTglPembelian")
    
    
    set Supplier_D_CMD = server.CreateObject("ADODB.command")
    Supplier_D_CMD.activeConnection = MM_pigo_STRING

    Supplier_D_CMD.commandText = "exec sp_add_MKT_M_Supplier_D '"& spID &"','"& sp_pdNama &"','"& sp_pdQty &"',"& sp_pdHarga &",'"& sp_pdType &"','"& sp_pdMerk &"','"& sp_pdKat &"','"& sp_pdTglPembelian &"', '"& request.cookies("custID") &"' "
    'response.write Supplier_D_CMD.commandText
    Supplier_D_CMD.execute

    Response.redirect "index.asp"
%> 