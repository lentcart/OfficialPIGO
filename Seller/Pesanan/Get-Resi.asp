
<!--#include file="../../connections/pigoConn.asp"-->
<!--#INCLUDE file="../../aspJSON.asp" -->
<%
    SuratJalan       = request.QueryString("SuratJalan")

    dim objHttp
    Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

    Dim url, payload
    url = "http://103.111.190.162/dbs/customerapps/orderBooking/read/?key=304139a7188354d7e6f7651b5673a264&noSJ="& SuratJalan &""
    objHttp.Open "GET", url, False
    objHttp.setRequestHeader "Content-Type", "application/json"
    objHttp.send payload
    strReturn = objHTTP.responseText
    'response.Write strReturn

    Set oJSON = New aspJSON
    oJSON.loadJSON(strReturn)
    For Each record In oJSON.data("Booking Orders ")
        Set this = oJSON.data("Booking Orders ").item(record)
        NoResi   = this.item("Booking_BTTID")
        Resi     = Right(NoResi,16)
        BTT      = this.item("Booking_BTTID")
        if BTT <> Resi = false then 
            BTT = "0"
            Response.Write "{"
                Response.Write """Status""" & ":" & """PICKUP"""   & "," 
                Response.Write """Keterangan""" & ":" & """Menunggu paket diserahkan ke pihak jasa kirim"""
            Response.Write "}"
        else
            BTT = Right(NoResi,16)
                'response.Write BTT
            Response.Write "{"
                Response.Write """Resi""" & ":" & """"& BTT &""""
            Response.Write "}"
        end if  
    Next
%>