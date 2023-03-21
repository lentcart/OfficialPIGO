<!--#include file="../../connections/pigoConn.asp"-->
<%

        Dim objHttp
        Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim url, payload
        url = "https://dev.farizdotid.com/api/daerahindonesia/provinsi"
        objHttp.Open "GET", url, False
        objHttp.setRequestHeader "Content-Type", "application/json"
        objHttp.send payload

        strReturn = objHTTP.responseText
        response.write strReturn
%>