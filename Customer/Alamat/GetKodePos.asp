<!--#include file="../../connections/pigoConn.asp"-->
<%
    dim Kunci, Keterangan

    Kunci           = request.queryString("kunci")
    Keterangan      = request.queryString("keterangan")
    
        Dim objHttp
        Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim url, payload
        url = "https://www.dakotacargo.co.id/api/api_glb_M_kodepos.asp?key=15f6a51696a8b034f9ce366a6dc22138&id=11022019000001&"& Kunci &"="& Keterangan &""
        objHttp.Open "GET", url, False
        objHttp.setRequestHeader "Content-Type", "application/json"
        objHttp.send payload

        strReturn = objHTTP.responseText
        response.write strReturn
%>