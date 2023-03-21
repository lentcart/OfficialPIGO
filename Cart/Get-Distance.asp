<!--#include file="../connections/pigoConn.asp"-->
<!--#INCLUDE file="../aspJSON.asp" -->

<% 
    LatDestination      = request.QueryString("LatDestination")
    LongDestination     = request.QueryString("LongDestination")
    LatOrigin           = request.QueryString("LatOrigin")
    LongOrigin          = request.QueryString("LongOrigin")
    ' GET JARAK TEMPUH 
        Dim objHttpp
        Set objHttpp = Server.CreateObject("Microsoft.XMLHTTP")

        Dim urlGet, payloadGet
        
        urlGet = "https://maps.googleapis.com/maps/api/directions/json?origin="& LatOrigin &","& LongOrigin &"&destination="& LatDestination &","& LongDestination &"&key=AIzaSyCribiW_PDw6E4weetrQGR-6MlTtJeZmow&avoid=tolls"
        objHttpp.Open "GET", urlGet, False
        objHttpp.setRequestHeader "Content-Type", "application/json"
        objHttpp.send payloadGet
        strReturnGet = objHTTPp.responseText
        'response.write strReturnGet

        Set oJSON = New aspJSON
        oJSON.loadJSON(strReturnGet)

        Set oJSON = New aspJSON

        oJSON.loadJSON(strReturnGet)

        For Each result In oJSON.data("routes")
        Set this = oJSON.data("routes").item(result)
            For Each a In this("legs")
            set thiss = this("legs").item(result)
                For Each b In thiss("distance")
                    id   = thiss("distance").item("value")
                next
                    JarakTempuh = id
            Next
        Next



            Response.Write "{"
                Response.Write """JarakTempuh""" & ":" & """" & JarakTempuh & """"  
            Response.Write "}"

    ' GET JARAK TEMPUH 

%>


