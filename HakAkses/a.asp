<%
    Dim UserIPAddress
    UserIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
    If UserIPAddress = "" Then
    UserIPAddress = Request.ServerVariables("REMOTE_ADDR")
    response.write UserIPAddress
    End If
%>