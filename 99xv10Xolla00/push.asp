<!--#include file="../connections/pigoConn.asp"--> 
<%
    IPAdd       = request.queryString("d")
    response.write IPAdd
    Latt        = request.queryString("Latt")
    Longs        = request.queryString("Long")
    loc         = request.queryString("loc")

    set Add_CMD = server.CreateObject("ADODB.command")
    Add_CMD.activeConnection = MM_pigo_STRING

    Add_CMD.commandText = "INSERT INTO [dbo].[MKT_M_Add]([IPAdd],[Latt],[Long],[Loc])VALUES('"& IPAdd &"', '"& Latt &"', '"& Longs &"', '"& Loc &"')"
    response.write Add_CMD.commandText
    set Addresss = Add_CMD.execute 
%>