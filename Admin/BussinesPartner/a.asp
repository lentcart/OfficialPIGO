
<html>
<head>
<script type="text/javascript">
function validasiEmail() {
	var rs = document.forms["formInput"]["email"].value;
	var atps=rs.indexOf("@");
	var dots=rs.lastIndexOf(".");
	if (atps<1 || dots<atps+2 || dots+2>=rs.length) {
		alert("Alamat email tidak valid.");
		return false;
	} else {
		alert("Alamat email valid.");
	}
}
</script>
</head>
<body>

<form name="formInput" onsubmit="validasiEmail();">
	<input type="text" name="email">
	<input type="submit" value="submit">
</form>

</body>
</html>