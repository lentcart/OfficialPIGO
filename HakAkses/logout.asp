<!--#include file="../connections/pigoConn.asp"--> 

<%

For Each cookie in Response.Cookies
    Response.Cookies(cookie).Expires = DateAdd("d",-1,now())
Next

Response.redirect "../Admin/"
%>