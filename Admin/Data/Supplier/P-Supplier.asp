<!--#include file="../../../connections/pigoConn.asp"-->

<% 

    spNama = request.form("spNama")
    spNamaCP = request.form("spNamaCP")
    spAlmLengkap = request.form("spAlmLengkap")
    spAlmProvinsi = request.form("provinsi")
    spTelp1 = request.form("spTelp1")
    spTelp2 = request.form("spTelp2")
    spTelp3 = request.form("spTelp3")
    spEmail = request.form("spEmail")
    spDesc = request.form("spDesc")
    
    
    set Supplier_CMD = server.CreateObject("ADODB.command")
    Supplier_CMD.activeConnection = MM_pigo_STRING

    Supplier_CMD.commandText = "exec sp_add_MKT_M_Supplier_H '"& spNama &"','"& spNamaCP &"','"& spAlmLengkap &"','"& spAlmProvinsi &"','"& spTelp1 &"','"& spTelp2 &"','"& spTelp3 &"','"& spEmail &"','"& spDesc &"', '"& request.Cookies("custID") &"' "
    'response.write Supplier_CMD.commandText
    set pr = Supplier_CMD.execute

    Response.redirect "index.asp"
%> 