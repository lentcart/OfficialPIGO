<%
	Dim strPassWord, strHash
	strPassWord = "abc"
	strHash = hex_sha1(strPassWord)

	Response.Write("strPassWord: " & strPassWord & "")
	Response.Write("strHash: " & strHash & "")
%>