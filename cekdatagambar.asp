<!--#include file="Connections/pigoConn.asp" -->


<%
server.ScriptTimeout=999999999

dim foto_cmd,foto

set foto_cmd = Server.CreateObject ("ADODB.Command")
foto_cmd.ActiveConnection = MM_PIGO_String


'if len(trim(Request.Form("fotoBase64"))) < 100  then

'		response.ContentType = "application/json;charset=utf-8"
'		response.write """INVALID BASE64"""
'else

dim i

i = 1


foto_cmd.commandText = "SELECT top 5 * FROM [PIGO].[dbo].[MKT_M_Produk] ORDER BY [pdID] DESC"

set produk = foto_cmd.execute

%>
<table>


<%

do while not produk.eof

if i = 1 then
%>

<tr>

<%
end if
%><td><img src="<%=produk("pdImage1") %>" width="50%"><br></td>

<%
i = i + 1

if i = 10 then
i = 1
%>

</tr>

<%

end if

produk.movenext
loop
%>


</table>


<%
		
		
		

'end if
'Dim fotoBase64, fotoName

'fotoBase64 = trim(Request.Form("fotoBase64"))
'fotoName = Request.Form("fotoName")



' .. More processing of the other variables .. '

' Processing / validation done... '
'Response.Write fotoBase64
'Response.Write fotoName & vbCrLf



%>

