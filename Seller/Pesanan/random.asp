
<!--#include file="../../connections/pigoConn.asp"-->
<!--#INCLUDE file="../../aspJSON.asp" -->
<%
    TransaksiID     = request.QueryString("tr")
    
    
    
    dim objHttpx
    Set objHttpx = Server.CreateObject("Microsoft.XMLHTTP")

    Dim urlx, payloadx
    urlx = "http://103.111.190.162/dbs/customerapps/orderBooking/read/?key=304139a7188354d7e6f7651b5673a264&noSJ="& TransaksiID &""
    objHttpx.Open "GET", urlx, False
    objHttpx.setRequestHeader "Content-Type", "application/json"
    objHttpx.send payloadx
    strReturnn = objHTTPx.responseText
    Set oJSON = New aspJSON
    oJSON.loadJSON(strReturnn)
    For Each records In oJSON.data("Booking Orders ")
        Set this = oJSON.data("Booking Orders ").item(records)
        BookingAktifYN      = this.item("Booking_AktifYN")
        BookingID           = this.item("BookingID")

        if BookingAktifYN = "Y" then 

            BookingID       = BookingID
            StatusBTT       = request.QueryString("status")
            
            if StatusBTT = "" then 

                Dim objHttpp
                Set objHttpp = Server.CreateObject("Microsoft.XMLHTTP")

                Dim urlGet, payloadGet
                urlGet = "http://103.111.190.162/dbs/customerapps/orderBooking/history/?b="& BookingID &""
                objHttpp.Open "GET", urlGet, False
                objHttpp.setRequestHeader "Content-Type", "application/json"
                objHttpp.send payloadGet
                strReturnGet = objHTTPp.responseText
                response.Write strReturnGet
                
            else 

                SuratJalan      = request.QueryString("sj")
                
                dim objHttp
                Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

                Dim url, payload
                url = "http://103.111.190.162/dbs/customerapps/orderBooking/read/?key=304139a7188354d7e6f7651b5673a264&noSJ="& TransaksiID &""
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
                    BTT      = Right(NoResi,16)

                    if BTT = NoResi = true then 
                        if BTT = Right(NoResi,16) = true then 
                        Response.Write"{""detail"":[{""tanggal"":"""& Now() &""", ""keterangan"":""Menunggu Konfirmasi Pihak Pengiriman"", ""posisi"":""-"", ""status"":""BTT Belum Dibuat""}]}"
                        end if
                    else
                        dim objHttpStatus
                        Set objHttpStatus = Server.CreateObject("Microsoft.XMLHTTP")

                        Dim urlStatus, payloadStatus
                        urlStatus = "http://103.111.190.162/api/trace/?b="& BTT &""
                        objHttpStatus.Open "GET", urlStatus, False
                        objHttpStatus.setRequestHeader "Content-Type", "application/json"
                        objHttpStatus.send payloadStatus
                        strReturnStatus = objHTTPStatus.responseText
                        'response.Write strReturnStatus
                        Set oJSON = New aspJSON
                        oJSON.loadJSON(strReturnStatus)
                        For Each result In oJSON.data("detail")
                            Set this = oJSON.data("detail").item(result)
                            Keterangan      = this.item("keterangan")
                            Status          = this.item("status")
                            Tanggal          = this.item("tanggal")
                            Response.Write "{"
                                Response.Write """Status""" & ":" & """"& Status &""""   & "," 
                                Response.Write """Tanggal""" & ":" & """"& Tanggal &""""   & "," 
                                Response.Write """Keterangan""" & ":" & """"& Keterangan &""""  
                            Response.Write "}"
                        next
                    end if 
                Next
            
            end if 
        else
            Response.Write"{""detail"":[{""tanggal"":"""& Now() &""", ""keterangan"":""Booking ID Batal Diproses"", ""posisi"":""-"", ""status"":""Booking ID Gagal""}]}"
        end if
        
    Next

%>