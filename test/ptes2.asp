<html>
<body>

<%
dim a
a = request.form("fname")

For i = 1 To a
  response.write("HELLO WORD  <br />")
Next
%>

</body>
</html>