<!--#include file="../../../Connections/pigoConn.asp" -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    bulan = request.queryString("bulan")
    tahun = request.queryString("tahun")

    set Closing_cmd = server.createObject("ADODB.COMMAND")
	Closing_cmd.activeConnection = MM_PIGO_String

    Closing_cmd.commandText = "DELETE FROM GLB_M_Closing Where Bulan = '"& bulan &"' and Tahun = '"& tahun &"' "
    'response.write Closing_cmd.commandText & "<br><br>"
    set DeleteClosing = Closing_cmd.execute

    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> DATA BERHASIL DI UN-POSTING </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/GL/Closing/new.asp?bulan="& bulan &"&tahun="& tahun &" style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'> POSTING ULANG </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="& base_url &"/Admin/GL/UN-Posting-Jurnal/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'> BATAL </a><br><br></div></div></div>"
%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>