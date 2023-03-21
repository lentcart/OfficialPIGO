
<!--#include file="../../connections/pigoConn.asp"-->
<!--#INCLUDE file="../../aspJSON.asp" -->
<%
    BookingID = request.queryString("BookingID")
    Dim objHttpp
    Set objHttpp = Server.CreateObject("Microsoft.XMLHTTP")

    Dim urlGet, payloadGet
    urlGet = "http://103.111.190.162/dbs/customerapps/orderBooking/history/?b="& BookingID &""
    objHttpp.Open "GET", urlGet, False
    objHttpp.setRequestHeader "Content-Type", "application/json"
    objHttpp.send payloadGet
    strReturnGet = objHTTPp.responseText
    response.Write strReturnGet
%>