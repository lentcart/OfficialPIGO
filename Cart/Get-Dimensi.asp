<!--#include file="../connections/pigoConn.asp"-->
<!--#INCLUDE file="../aspJSON.asp" -->
<%
        Dim Berat
        Berat           = 10


        Dim objHttp
        Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim url, payload
        url = "http://103.111.190.162/dbs/customerapps/dimensiharga/"

        objHttp.Open "GET", url, False
        objHttp.setRequestHeader "Content-Type", "application/json"
        objHttp.send payload

        strReturn = objHTTP.responseText
        response.write strReturn
%>