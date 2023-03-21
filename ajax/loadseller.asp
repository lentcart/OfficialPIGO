
<!--#include file="../connections/pigoConn.asp"--> 

<%
        sl_custID = request.queryString("idseller")
        slName = request.queryString("namaseller")

        set almSeller_CMD = server.CreateObject("ADODB.command")
        almSeller_CMD.activeConnection = MM_pigo_STRING

        almSeller_CMD.commandText = "INSERT INTO [dbo].[MKT_M_Seller]([sl_custID],[sl_almID],[slName],[slVerified],[slAktifYN]) VALUES ('"& sl_custID &"',' ','"& slname &"','N','Y')"
        'Response.Write almSeller_CMD.commandText
        almSeller_CMD.execute
%>