<!--#include file="connections/pigoConn.asp"--> 

<% 
    set provinsi_CMD = server.CreateObject("ADODB.command")
    provinsi_CMD.activeConnection = MM_pigo_STRING

    provinsi_CMD.commandText = "select * from MKT_M_Alamat where almID = '"&  request.cookies("custID") &"' "
    provinsi_CMD.execute

     

 %>
 <script src="js/jquery-3.6.0.min.js"></script>
 <script>
 $.getJSON("https://www.dakotacargo.co.id/api/pricelist/index.asp",function(data){ 

    })
  </script>