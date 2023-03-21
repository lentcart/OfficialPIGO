<!--#include file="../../connections/pigoConn.asp"-->
<%
    Dim objHttp
    Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

    TransaksiID = request.queryString("external_id")

    Dim url, payload
    url = "https://api.xendit.co/v2/invoices/?external_id="& TransaksiID &""
    objHttp.Open "GET", url, False
    objHttp.setRequestHeader "Content-Type", "application/json"
    objHttp.setRequestHeader "Authorization", "Basic eG5kX2RldmVsb3BtZW50X2p3NzllSVVBTWQwTEdjd1B4S1hDcVdtZU1rVnpnZndJSlQzMlJMTUlvWTFvUjVWTkdqeEFsdmpOWkNHZmxDZDo"
    objHttp.send payload

    strReturn = objHTTP.responseText
    response.write strReturn

    Dim status
    status = objHttp.status

    If status = 200 Then
    ' Success!
    Else
    ' Error occurred.
    End If
%>