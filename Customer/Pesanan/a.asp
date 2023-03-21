<%
    TanggalMasuk    = CDate("01/02/2022")
    TanggalHariIni  = CDate(Date())

    JumlahHari      = TanggalHariIni - TanggalMasuk

    if JumlahHari >= 360 then
        cuti = 12 
    else 
        cuti = 0
    end if 

    response.Write cuti  & "<br>"
    response.Write JumlahHari & "<br>"
%>