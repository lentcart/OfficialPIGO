<%
    tanggal = "2023-01-25T10:31:08.754Z"
    tgl = CDate(left(tanggal,10))
    hari = Day(Cdate(tgl))&"-"&Month(Cdate(tgl))&"-"&year(Cdate(tgl))
    response.write hari
%>