<!--#include file="connections/pigoConn.asp"--> 

<% 

set dproduk_cmd = server.createObject("ADODB.COMMAND")
	dproduk_cmd.activeConnection = MM_PIGO_String

    dproduk_cmd.commandText = "select * from MKT_M_Produk  "
    'Response.Write dproduk_cmd.commandText & "<br>"


set dproduk = dproduk_cmd.execute
        
        response.ContentType = "application/json;charset=utf-8"
      
		response.write "["
        do until  dproduk.eof
            response.write "{"
				response.write """NamaProduk""" & ":" &  """" & dproduk("pdNama") &  """" & ","
				response.write """HargaProduk""" & ":" &  """" & dproduk("pdHargaJual") &  """" & ","
				response.write """TypeProduk""" & ":" &  """" & dproduk("pdType") &  """" 
            response.write "}"
        dproduk.movenext
        loop 
        response.write "]"
        
         %> 