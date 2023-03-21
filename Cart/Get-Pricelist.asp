<!--#include file="../connections/pigoConn.asp"-->
<%
    dim AsalKota, TujuanProvinsi, TujuanKota, TujuanKecamatan

    AsalKota            = "Jakarta Selatan"
    TujuanProvinsi      = "Jawa Barat"
    TujuanKota          = "Bekasi"
    TujuanKecamatan     = "Jatiasih"
    
    Dim objHttp
    Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

    Dim url, payload
    url = "https://www.dakotacargo.co.id/api/pricelist/index.asp?ak="& AsalKota &"&tpr="& TujuanProvinsi &"&tko="& TujuanKota &"&tke="& TujuanKecamatan &""


    objHttp.Open "GET", url, False
    objHttp.setRequestHeader "Content-Type", "application/json"
    objHttp.send payload

    strReturn = objHTTP.responseText
    response.write strReturn
%>