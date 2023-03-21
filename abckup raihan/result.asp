<!DOCTYPE HTML>

<script language="JScript" runat="server" src="../json/json2.js"></script>
<% on error resume next %>
<html>
	<head>

<!--#include file="../connections/eHistory.asp"-->   
<!--#include file="../connections/cargo.asp"-->
<!--#include file="../secureString.asp" --> 

    <%
	
	Dim hh, nn, ss
	Dim timevalue, dtsnow
	
	 dim URL
 url = "http://70.38.2.236:8000/webgps/login.aspx?uid=dakota222&pwd=dakotagps222&nokendaraan="
	
	
	dim sp
	sp = trim(request.Form("btt"))
	if len(sp) >= 17 then
		response.redirect "index.asp"
	end if
	
	'if sp = "" then
'		sp = split(decode(request.QueryString("b")),",")
		'for each x in sp
		'sp = trim(x)
	'next
	'end if
	if sp= "" then	
		sp = trim(request.querystring("b"))
	end if

	
	if isNumeric(sp) = true then
	cekBTTLama = true
	end if
	
	cek = trim(left(sp,5))
	cekbdb = mid(trim(sp,10),3)
	
	set btt_cmd = server.CreateObject("ADODB.command")
	btt_cmd.activeConnection = MM_eHistory_STRING
	
	set dbs_alamat = server.CreateObject("ADODB.Command")
	dbs_alamat.activeConnection = MM_DBS_STRING
		set dlb_alamat = server.CreateObject("ADODB.Command")
			dlb_alamat.activeConnection = MM_DLB_STRING
			set logistik_alamat = server.CreateObject("ADODB.Command")
				logistik_alamat.activeConnection = MM_DLI_STRING
	
	dim dbsbtt, dlbbtt, dlibtt
	
	dim cekGPS
	dim cekGPS_cmd

	dim cekMobilGps
	dim cekMobilGps_cmd
	
	set cekGps_cmd = server.CreateObject("ADODB.Command")
	cekGps_cmd.activeConnection = MM_Cargo_string
	
	set cekMobilGps_cmd = server.CreateObject("ADODB.Command")
	cekMobilGps_cmd.activeConnection = MM_cargo_string	
	
	
	%>
    
	
	</head>
	<body>
 <h1>Status Pengiriman<p class= "text-center"> </h1>
               
		
 
<%                                
if sp = "" then
 response.write "Nomor Resi yang anda masukkan tidak lengkap"
 
 
'------------------------------------------------------------------------------------------BDB---------------------------------------------------------------------------------------
elseif cekbdb = "BDB" then
	btt_cmd.commandtext="SELECT MKT_T_eHistory.Hist_BTTID, MKT_T_eHistory.Hist_Tanggal, MKT_T_eHistory.Hist_StatUrut, MKT_M_eBTTStat.Stat_Keterangan, GLB_M_Agen.Agen_Nama, MKT_T_eHistory.Hist_Ket, GLB_M_Agen.Agen_Kota, MKT_T_eBDB.BDB_TujuanNama, GLB_M_Agen_1.Agen_Nama AS tujuancabang FROM GLB_M_Agen GLB_M_Agen_1 LEFT OUTER JOIN MKT_T_eBDB ON GLB_M_Agen_1.Agen_ID = MKT_T_eBDB.BDB_TujuanAgenID RIGHT OUTER JOIN MKT_T_eHistory ON MKT_T_eBDB.BDB_ID = MKT_T_eHistory.Hist_BTTID LEFT OUTER JOIN GLB_M_Agen ON MKT_T_eHistory.Hist_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN MKT_M_eBTTStat ON MKT_T_eHistory.Hist_StatUrut = MKT_M_eBTTStat.Stat_Urut WHERE (MKT_T_eHistory.Hist_BTTID = '"& sp &"') AND (MKT_T_eBDB.BDB_AktifYN = 'Y') ORDER BY MKT_T_eHistory.Hist_Tanggal DESC, MKT_T_eHistory.Hist_StatUrut DESC"
	set rs = btt_cmd.execute
	if rs.eof = false then
		
%>		
 <p class="mb-5">Terimakasih telah menggunakan pengiriman Dakota Cargo, Silahkan cek daftar pengiriman Anda.</p>
		<div class="table-responsive" style="overflow-x:auto;height:200px;"  >
<table class="table" >
  <thead class="thead-dark">
    <tr>
      <th scope="col">Tanggal</th>
      <th scope="col">Keterangan <p class= "text-center"> </th> 
      <th scope="col">Posisi Barang <p class= "text-center"> </th>
    </tr>
  </thead>
  <tbody>
	<%
	do while not rs.EOF
	%>

	<tr>
	<th scope="row"><% = right("00"&month(rs.fields("Hist_Tanggal")),2) &"/"& right("00"&day(rs.fields("Hist_Tanggal")),2) &"/"& right("0000"&year(rs.fields("Hist_Tanggal")),4) %></th>
    <td><% if rs.fields("Hist_StatUrut") = 8 then %>
    		<% response.write(rs.fields("Stat_Keterangan") & " ") 
				if not isnull(rs.fields("Reason_Lokal")) then 
					response.Write("("&rs.fields("Reason_Lokal")&")") 
				end if %>
        <% elseif rs.fields("Hist_StatUrut") = 14 then %>
    		<% = rs.fields("Stat_Keterangan") & "<b> [ " & rs.fields("Hist_Ket")  & " ]</b>"%> 
         <% elseif rs.fields("Hist_StatUrut") = 15 then %>
    		<% = rs.fields("Stat_Keterangan") %>
         <% elseif rs.fields("Hist_StatUrut") = 16 then %>
    		<% = rs.fields("Stat_Keterangan") %>
           <% elseif rs.fields("Hist_StatUrut") = 17 then %>
    		<% = rs.fields("Stat_Keterangan") %>
        <% elseif (rs.fields("Hist_StatUrut")=1) or (rs.fields("Hist_StatUrut")=4) then%>  
        	<% if not isnull(rs("Hist_Ket")) then
			 		response.Write rs.fields("Stat_Keterangan") &" "& left(rs("Hist_Ket"),len(rs("Hist_Ket"))-15) &", Dengan Nomor SP : "& right(rs("Hist_Ket"),15)
				else
					Response.Write rs.fields("Stat_Keterangan")
				end if%>    
       	<% elseif rs.fields("hist_StatUrut") = 0 then  %>
        
      	<% if mid(rs("Hist_BTTID"),10,1) = "A" then
			
			PT = "PT. DAKOTA BUANA SEMESTA"
			
			dbs_alamat.commandText = "SELECT [BTTT_ID],[BTTT_TujuanAlamat],[BTTT_TujuanKota],[BTTT_TujuanKelurahan],[BTTT_TujuanKecamatan],[BTTT_TujuanPulau],[BTTT_TujuanKodepos] FROM MKT_T_eConote where BTTT_ID = '"& rs("Hist_BTTID") &"' "
			set alamatbtt = dbs_alamat.execute
			if alamatbtt.eof = false then
				alamattujuan = alamatbtt("BTTT_TujuanAlamat") & ", " & alamatbtt("BTTT_TujuanKota") & ", " & alamatbtt("BTTT_TujuanKelurahan")
			
			end if	
			
			
			elseif mid(rs("Hist_BTTID"),10,1) = "B" or mid(rs("Hist_BTTID"),10,1) = "R" then
			PT = "PT. DAKOTA LINTAS BUANA"
			
			dlb_alamat.commandText = "SELECT [BTTT_ID],[BTTT_TujuanAlamat],[BTTT_TujuanKota],[BTTT_TujuanKelurahan],[BTTT_TujuanKecamatan],[BTTT_TujuanPulau],[BTTT_TujuanKodepos] FROM MKT_T_eConote where BTTT_ID = '"& rs("Hist_BTTID") &"' "
			set alamatbtt = dlb_alamat.execute
			if alamatbtt.eof = false then
				alamattujuan = alamatbtt("BTTT_TujuanAlamat") & ", " & alamatbtt("BTTT_TujuanKota") & ", " & alamatbtt("BTTT_TujuanKelurahan")
			
			end if	
			
			else
			PT = "PT. DAKOTA LOGISTIK INDONESIA"
			logistik_alamat.commandText = "SELECT [BTTT_ID],[BTTT_TujuanAlamat],[BTTT_TujuanKota],[BTTT_TujuanKelurahan],[BTTT_TujuanKecamatan],[BTTT_TujuanPulau],[BTTT_TujuanKodepos] FROM MKT_T_eConote where BTTT_ID = '"& rs("Hist_BTTID") &"' "
			set alamatbtt = logistik_alamat.execute
			if alamatbtt.eof = false then
				alamattujuan = alamatbtt("BTTT_TujuanAlamat") & ", " & alamatbtt("BTTT_TujuanKota") & ", " & alamatbtt("BTTT_TujuanKelurahan")
			
			end if	
			end if
		 %>
        
        <% = rs.fields("Stat_Keterangan") &" "& rs.fields("Agen_Nama") & ", " & PT  %>
       
    	<% else %>
    		<% = rs.fields("Stat_Keterangan") &" "& rs.fields("Agen_Nama") &" "& rs.fields("Hist_Ket") %>
      <% end if %></td>    
    <td><% if rs.fields("hist_StatUrut") = 299 then %>
    		DITERIMA <a href="DetailHistoryTerima.asp?b=<%=encode(rs.fields("Hist_BTTID"))%>">(click detail..)</a>
        <% elseif rs.fields("hist_StatUrut") = 300 then %>
        	DIAMBIL SENDIRI
        <% elseif rs.fields("Hist_StatUrut") = 14 then %>
    		<% = rs.fields("Hist_Ket") %>   
             <% elseif rs.fields("Hist_StatUrut") = 17 then %>
    		<% = rs.fields("Hist_Ket") %>     
        <% elseif (rs.fields("Hist_StatUrut")=1) or (rs.fields("Hist_StatUrut")=4) then%>   
        	  <!-- cek GPS -->
								<% cekgps_cmd.commandText = "SELECT [SPT_eID],[SPT_NoMobil],[SPT_GPS_AktifYN] FROM [dbs].[dbo].[OPR_T_eSP_Terima] where SPT_eID = '"& trim(right(rs("Hist_Ket"),15)) &"' and SPT_GPS_AktifYN is not null "
  									'response.write cekgps_cmd.commandText & "<HR>"
									set cekgps = cekgps_cmd.execute
									cekgps_cmd.commandText = ""
									'response.write cekgps("SPT_NoMobil") & " - " & cekgps("SPT_GPS_AktifYN") & "<HR>"
									
									if cekgps("SPT_GPS_AktifYN") = "Y" then
									%>
                                    
                                    
																<%
                                    url = url & left(cekGPS("SPT_NoMobil"),1) & " " & mid(cekGPS("SPT_NoMobil"),2,4) & " " & mid(cekGPS("SPT_NoMobil"),6,3)
                                    Set HttpReq = Server.CreateObject("MSXML2.ServerXMLHTTP")
                            HttpReq.open "POST", url , false
                            HttpReq.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
                            HttpReq.Send("Foo=bar")
                            'use json2 via jscript to parse the response
                            Set myJSON = JSON.parse(HttpReq.responseText)
                            
                            'response.write url
                            
                            if MyJson.vehicle = "false" then
                            response.write "DALAM PERJALANAN"
                            else
							session("addreGPS") = myJSON.Addr
                            response.write "<a href=dbs/opr_t_pos_kendaraan.asp?lat=" & myJSON.Lat & "&lon=" & myJSON.Long & "&kend_nomor=" & myJSON.Vehicle & "&addr=" & myJson.addr &  ">" & "Lihat Pada Peta" & "</a>"
                            'response.write myJSON.Vehicle & "<br />"
                            'response.write myJSON.Long & "<br />"
                            'response.write myJSON.Lat & "<br />"
                            end if
                            url = "http://70.38.2.236:8000/webgps/login.aspx?uid=dakota222&pwd=dakotagps222&nokendaraan="
                                                 
                                                 %>
                                    
                                    
                                    <%
									
									'cekMobilGps_cmd.commandText = "SELECT [Kend_ID] ,Kend_Nomor_Spasi FROM [dbs].[dbo].[GLB_M_Kendaraan] where Kend_ID = '"& trim(cekgps("SPT_NoMobil")) &"' and Kend_Nomor_Spasi is not null "
									'response.write cekmobilgps_cmd.commandText & "<HR>"
									'set cekMobilGps = cekMobilGps_cmd.execute
									'response.write cekmobilGps("Kend_ID") & " - " & cekmobilGps("Kend_gps_imei")
									'		if cekMobilGps("kend_gps_imei") = "" then
									'		response.write "Dalam Perjalanan"
									'		else
								'				url = "http://www.dakotacargo.co.id/dbs/opr_t_pos_kendaraan.asp?imei=" & cekmobilGps("Kend_gps_imei")
											%>
                                            <!--
												<a href="<%=url%>">Lihat Pada Peta</a>
                                            -->
                                            <%
											'end if
									else
									response.write "Dalam Perjalanan"
									end if
								 %>    
                                 
                                 <!-- end cek gps -->
        <% elseif rs.fields("Hist_StatUrut") = 5 then 
			'smu_cmd.commandtext = "SELECT OPR_T_SuratMuatanUdara_BTT.BTTT_ID, OPR_T_SuratMuatanUdara_BTT.BTTT_SMUNo, OPR_T_SuratMuatanUdara.SMU_Dari, GLB_M_Bandara.Airport_Name FROM GLB_M_Bandara LEFT OUTER JOIN OPR_T_SuratMuatanUdara ON GLB_M_Bandara.IATA_Code = OPR_T_SuratMuatanUdara.SMU_Dari RIGHT OUTER JOIN OPR_T_SuratMuatanUdara_BTT ON OPR_T_SuratMuatanUdara.SMU_No = OPR_T_SuratMuatanUdara_BTT.BTTT_SMUNo WHERE (OPR_T_SuratMuatanUdara_BTT.BTTT_ID = '"& request.querystring("sp") &"')"
			'set smu = smu_cmd.execute
			'if not smu.eof then
			'	response.Write(smu.fields.item("Airport_Name"))
			'end if
			%>
		<% else %>
			<% = rs.fields("Agen_Kota") %>
      <% end if %></td>    
	</tr>

	
	<% 
	rs.MoveNext
	loop
	%>
    
    </table>


<%	end if

	
'------------------------------------------------------------------------------------------BTT---------------------------------------------------------------------------------------
else
	'parsing surat jalan ke BTT
							If InStr(1, sp, "-") > 0  or IsNumeric(sp) = true then
									'cek btt di dbs
										dbs_alamat.commandText = "select BTTT_ID from MKT_T_eConote where BTTT_NoSuratJalan = '"& sp &"'"
										set dbsbtt = dbs_alamat.execute
										
											if dbsbtt.eof = false then
												sp = dbsbtt("BTTT_ID")
											end if
											
										dbs_alamat.commandText = ""
								
									'cek btt di dlb
										dlb_alamat.commandText = "select BTTT_ID from MKT_T_eConote where BTTT_NoSuratJalan = '"& sp &"'"
										set dlbbtt = dlb_alamat.execute
										'response.write dlb_alamat.commandText
											if dlbbtt.eof = false then
												sp = dlbbtt("BTTT_ID")
											end if
										dlb_alamat.commandText = ""
										
									'cek btt di dli
										logistik_alamat.commandText = "select BTTT_ID from MKT_T_eConote where BTTT_NoSuratJalan = '"& sp &"'"
										set dlibtt = logistik_alamat.execute
										
											if dlibtt.eof = false then
												sp = dlibtt("BTTT_ID")
											end if
										logistik_alamat.commandText = ""
									
								
							end if

	
	btt_cmd.commandtext="SELECT MKT_T_eHistory.Hist_BTTID, MKT_T_eHistory.Hist_Tanggal, MKT_T_eHistory.Hist_StatUrut, MKT_M_eBTTStat.Stat_Keterangan, GLB_M_Agen.Agen_Nama, MKT_T_eHistory.Hist_Ket, GLB_M_Agen.Agen_Kota, OPR_M_Reason.Reason_Lokal, OPR_M_Reason.Reason_Inter FROM GLB_M_Agen RIGHT OUTER JOIN MKT_T_eHistory LEFT OUTER JOIN OPR_M_Reason ON MKT_T_eHistory.Hist_Ket = OPR_M_Reason.Reason_ID ON GLB_M_Agen.Agen_ID = MKT_T_eHistory.Hist_AgenID LEFT OUTER JOIN MKT_M_eBTTStat ON MKT_T_eHistory.Hist_StatUrut = MKT_M_eBTTStat.Stat_Urut WHERE ((MKT_T_eHistory.Hist_StatUrut NOT BETWEEN 100 AND 101) AND (MKT_T_eHistory.Hist_BTTID = '"& sp &"')) OR ((MKT_T_eHistory.Hist_StatUrut NOT BETWEEN 100 AND 101) AND (MKT_T_eHistory.Hist_SuratJalan = '"& sp &"'))  ORDER BY MKT_T_eHistory.Hist_Tanggal desc ,MKT_T_eHistory.Hist_StatUrut desc "


set rs = btt_cmd.execute

if rs.eof = false then
	
%>
<p class="mb-5">Terimakasih telah menggunakan pengiriman Dakota Cargo, Silahkan cek daftar pengiriman Anda.</p>
<div class="table-responsive" style="overflow-x:auto;height:200px;"  >
<table class="table" >
  <thead class="thead-dark">
    <tr>
      <th scope="col">Tanggal <p class= "text-center"> </th>
	  <th scope="col">Keterangan <p class= "text-center"> </th>
      <th scope="col">Posisi Barang</th>
    </tr>
  </thead>
  <tbody>
	<%
	do while not rs.EOF
	
	dtsnow = rs.fields("hist_tanggal")
	
	hh = Right("00" & Hour(dtsnow), 2)
	nn = Right("00" & Minute(dtsnow), 2)
	ss = Right("00" & Second(dtsnow), 2)
	
	timevalue = hh & ":" & nn & ":" & ss
	
	
	
	%>

	<tr>
	<th scope="row"><% = right("00"&month(rs.fields("Hist_Tanggal")),2) &"/"& right("00"&day(rs.fields("Hist_Tanggal")),2) &"/"& right("0000"&year(rs.fields("Hist_Tanggal")),4) & " [ " &  timevalue & " ] " %></th>
    <td><% if rs.fields("Hist_StatUrut") = 8 then %>
    		<% response.write(rs.fields("Stat_Keterangan") & " ") 
				if not isnull(rs.fields("Reason_Lokal")) then 
					response.Write("("&rs.fields("Reason_Lokal")&")") 
				end if %>

        <% elseif rs.fields("Hist_StatUrut") = 14 then %>
    		<% = rs.fields("Stat_Keterangan") & "<b> [ " & rs.fields("Hist_Ket") &" ]</b>"%> 
         <% elseif rs.fields("Hist_StatUrut") = 15 then %>
    		<% = rs.fields("Stat_Keterangan") %>
         <% elseif rs.fields("Hist_StatUrut") = 16 then %>
    		<% = rs.fields("Stat_Keterangan") %>
           <% elseif rs.fields("Hist_StatUrut") = 17 then %>
    		<% = rs.fields("Stat_Keterangan") %>
        <% elseif (rs.fields("Hist_StatUrut")=1) or (rs.fields("Hist_StatUrut")=4) then%>  
        	<% if not isnull(rs("Hist_Ket")) then
			 		response.Write rs.fields("Stat_Keterangan") &" "& left(rs("Hist_Ket"),len(rs("Hist_Ket"))-15) &", Dengan Nomor SP : "& right(rs("Hist_Ket"),15) & " / Nomor BTT : <b> " & rs("hist_bttid") & "</b>"
				else
					Response.Write rs.fields("Stat_Keterangan")
				end if%>    
       	<% elseif rs.fields("hist_StatUrut") = 0 then  %>
        
        	<% if mid(rs("Hist_BTTID"),10,1) = "A" then
			
			PT = "PT. DAKOTA BUANA SEMESTA"
			
			dbs_alamat.commandText = "SELECT [BTTT_ID],[BTTT_TujuanAlamat],[BTTT_TujuanKota],[BTTT_TujuanKelurahan],[BTTT_TujuanKecamatan],[BTTT_TujuanPulau],[BTTT_TujuanKodepos] FROM MKT_T_eConote where BTTT_ID = '"& rs("Hist_BTTID") &"' "
			set alamatbtt = dbs_alamat.execute
			if alamatbtt.eof = false then
				alamattujuan = alamatbtt("BTTT_TujuanAlamat") & ", " & alamatbtt("BTTT_TujuanKota") & ", " & alamatbtt("BTTT_TujuanKelurahan")
			
			end if	
			
			
			elseif mid(rs("Hist_BTTID"),10,1) = "B" or mid(rs("Hist_BTTID"),10,1) = "R" then
			PT = "PT. DAKOTA LINTAS BUANA"
			
			dlb_alamat.commandText = "SELECT [BTTT_ID],[BTTT_TujuanAlamat],[BTTT_TujuanKota],[BTTT_TujuanKelurahan],[BTTT_TujuanKecamatan],[BTTT_TujuanPulau],[BTTT_TujuanKodepos] FROM MKT_T_eConote where BTTT_ID = '"& rs("Hist_BTTID") &"' "
			set alamatbtt = dlb_alamat.execute
			if alamatbtt.eof = false then
				alamattujuan = alamatbtt("BTTT_TujuanAlamat") & ", " & alamatbtt("BTTT_TujuanKota") & ", " & alamatbtt("BTTT_TujuanKelurahan")
			
			end if	
			
			else
			PT = "PT. DAKOTA LOGISTIK INDONESIA"
			logistik_alamat.commandText = "SELECT [BTTT_ID],[BTTT_TujuanAlamat],[BTTT_TujuanKota],[BTTT_TujuanKelurahan],[BTTT_TujuanKecamatan],[BTTT_TujuanPulau],[BTTT_TujuanKodepos] FROM MKT_T_eConote where BTTT_ID = '"& rs("Hist_BTTID") &"' "
			set alamatbtt = logistik_alamat.execute
			if alamatbtt.eof = false then
				alamattujuan = alamatbtt("BTTT_TujuanAlamat") & ", " & alamatbtt("BTTT_TujuanKota") & ", " & alamatbtt("BTTT_TujuanKelurahan")
			
			end if	
			end if
		 %>
        
        <% = rs.fields("Stat_Keterangan") &" "& rs.fields("Agen_Nama") & ", " & PT & ". Untuk Tujuan : " & alamattujuan  %>
       
	   <% elseif rs.fields("hist_StatUrut") = 2 or rs.fields("hist_StatUrut") = 6 then %>
			<% = rs.fields("Stat_Keterangan") &"  " & rs.fields("agen_nama") %>
	   
    	<% else %>
    		<% = rs.fields("Stat_Keterangan") &"  " & rs.fields("Hist_Ket") %>
      <% end if %></td>    
    <td>
	
	<% if rs.fields("hist_StatUrut") = 299 then %>
    		DITERIMA <!--<a href="DetailHistoryTerima.asp?b=<%'=encode(rs.fields("Hist_BTTID"))
			%>">(click detail..)</a> ini ga bisa-->
            
            <!-- cek GPS untuk loperan -->
                   <% elseif (rs.fields("hist_statUrut") = 7) or (rs.fields("hist_staturut") = 9) then 
				   	cekgps_cmd.commandText = "SELECT dbo.OPR_T_eLoperDetail.LoperD_eLoperID, dbo.OPR_T_eLoperDetail.LoperD_BTTID, dbo.OPR_T_eLoperDetail.LoperD_GPS, dbo.OPR_T_eLoper.Loper_NoMobil FROM   dbo.OPR_T_eLoperDetail LEFT OUTER JOIN                       dbo.OPR_T_eLoper ON dbo.OPR_T_eLoperDetail.LoperD_eLoperID = dbo.OPR_T_eLoper.Loper_eID WHERE     (dbo.OPR_T_eLoperDetail.LoperD_GPS IS NOT NULL) AND (dbo.OPR_T_eLoper.Loper_NoMobil IS NOT NULL) and LoperD_eLoperID = '"& trim(right(rs("hist_ket"),20)) &"' and LoperD_BTTID = '"& sp &"'"
					set cekGps = cekGps_cmd.execute
					cekGps_cmd.commandText = ""
					
					if cekGPS("LoperD_GPS") = "Y" then
				   
				   %>
                   		<%
                                    url = url & left(cekGPS("Loper_NoMobil"),1) & " " & mid(cekGPS("Loper_NoMobil"),2,4) & " " & mid(cekGPS("Loper_NoMobil"),6,3)
                                    Set HttpReq = Server.CreateObject("MSXML2.ServerXMLHTTP")
                            HttpReq.open "POST", url , false
                            HttpReq.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
                            HttpReq.Send("Foo=bar")
                            'use json2 via jscript to parse the response
                            Set myJSON = JSON.parse(HttpReq.responseText)
                            
                            'response.write url
                            
                            if MyJson.vehicle = "false" then
                            response.write "Dalam Proses Pengantaran"
                            else
							session("addreGPS") = myJSON.Addr
                            response.write "<a href=dbs/opr_t_pos_kendaraan.asp?lat=" & myJSON.Lat & "&lon=" & myJSON.Long & "&kend_nomor=" & myJSON.Vehicle & "&addr=" & myJson.addr &  ">" & "Lihat Pada Peta" & "</a>"
                            'response.write myJSON.Vehicle & "<br />"
                            'response.write myJSON.Long & "<br />"
                            'response.write myJSON.Lat & "<br />"
                            end if
                            url = "http://70.38.2.236:8000/webgps/login.aspx?uid=dakota222&pwd=dakotagps222&nokendaraan="
                                                 
                                                 %>
                                    
                                    
                     <% else %>
                     Dalam Proses Pengantaran
                   <% end if %>
                   	
        <% elseif rs.fields("hist_StatUrut") = 300 then %>
        	DIAMBIL SENDIRI
        <% elseif rs.fields("Hist_StatUrut") = 14 then %>
    		<% = rs.fields("Hist_Ket") %>   
             <% elseif rs.fields("Hist_StatUrut") = 17 then %>
    		<% = rs.fields("Hist_Ket") %>     
        <% elseif (rs.fields("Hist_StatUrut")=1) or (rs.fields("Hist_StatUrut")=4) then%>   
        	  <!-- cek GPS -->
								<% cekgps_cmd.commandText = "SELECT [SPT_eID],[SPT_NoMobil],[SPT_GPS_AktifYN] FROM [dbs].[dbo].[OPR_T_eSP_Terima] where SPT_eID = '"& trim(right(rs("Hist_Ket"),15)) &"' and SPT_GPS_AktifYN is not null "
  									'response.write cekgps_cmd.commandText & "<HR>"
									set cekgps = cekgps_cmd.execute
									cekgps_cmd.commandText = ""
									'response.write cekgps("SPT_NoMobil") & " - " & cekgps("SPT_GPS_AktifYN") & "<HR>"
									
									if cekgps("SPT_GPS_AktifYN") = "Y" then
									%>
                                    
                                    
																<%
                                    url = url & left(cekGPS("SPT_NoMobil"),1) & " " & mid(cekGPS("SPT_NoMobil"),2,4) & " " & mid(cekGPS("SPT_NoMobil"),6,3)
                                    Set HttpReq = Server.CreateObject("MSXML2.ServerXMLHTTP")
                            HttpReq.open "POST", url , false
                            HttpReq.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
                            HttpReq.Send("Foo=bar")
                            'use json2 via jscript to parse the response
                            Set myJSON = JSON.parse(HttpReq.responseText)
                            
                            'response.write url
                            
                            if MyJson.vehicle = "false" then
                            response.write "DALAM PERJALANAN"
                            else
							session("addreGPS") = myJSON.Addr
                            response.write "<a href=dbs/opr_t_pos_kendaraan.asp?lat=" & myJSON.Lat & "&lon=" & myJSON.Long & "&kend_nomor=" & myJSON.Vehicle & "&addr=" & myJson.addr &  ">" & "Lihat Pada Peta" & "</a>"
                            'response.write myJSON.Vehicle & "<br />"
                            'response.write myJSON.Long & "<br />"
                            'response.write myJSON.Lat & "<br />"
                            end if
                            url = "http://70.38.2.236:8000/webgps/login.aspx?uid=dakota222&pwd=dakotagps222&nokendaraan="
                                                 
                                                 %>
                                    
                                    
                                    <%
									
									'cekMobilGps_cmd.commandText = "SELECT [Kend_ID] ,Kend_Nomor_Spasi FROM [dbs].[dbo].[GLB_M_Kendaraan] where Kend_ID = '"& trim(cekgps("SPT_NoMobil")) &"' and Kend_Nomor_Spasi is not null "
									'response.write cekmobilgps_cmd.commandText & "<HR>"
									'set cekMobilGps = cekMobilGps_cmd.execute
									'response.write cekmobilGps("Kend_ID") & " - " & cekmobilGps("Kend_gps_imei")
									'		if cekMobilGps("kend_gps_imei") = "" then
									'		response.write "Dalam Perjalanan"
									'		else
								'				url = "http://www.dakotacargo.co.id/dbs/opr_t_pos_kendaraan.asp?imei=" & cekmobilGps("Kend_gps_imei")
											%>
                                            <!--
												<a href="<%=url%>">Lihat Pada Peta</a>
                                            -->
                                            <%
											'end if
									else
									response.write "Dalam Perjalanan"
									end if
								 %>    
                                 
                                 <!-- end cek gps -->
        <% elseif rs.fields("Hist_StatUrut") = 5 then 
			'smu_cmd.commandtext = "SELECT OPR_T_SuratMuatanUdara_BTT.BTTT_ID, OPR_T_SuratMuatanUdara_BTT.BTTT_SMUNo, OPR_T_SuratMuatanUdara.SMU_Dari, GLB_M_Bandara.Airport_Name FROM GLB_M_Bandara LEFT OUTER JOIN OPR_T_SuratMuatanUdara ON GLB_M_Bandara.IATA_Code = OPR_T_SuratMuatanUdara.SMU_Dari RIGHT OUTER JOIN OPR_T_SuratMuatanUdara_BTT ON OPR_T_SuratMuatanUdara.SMU_No = OPR_T_SuratMuatanUdara_BTT.BTTT_SMUNo WHERE (OPR_T_SuratMuatanUdara_BTT.BTTT_ID = '"& request.querystring("sp") &"')"
			'response.write smu_cmd.commandText & "<HR>"
			'set smu = smu_cmd.execute
			'if not smu.eof then
			'	response.Write(smu.fields.item("Airport_Name"))
			'end if	
			%>
		<% else %>
			<% = rs.fields("Agen_Kota") %>
      <% end if %></td>    
	</tr>

	
	<% 
	rs.MoveNext
	loop
	%>
    
    </table>


<%	
else
	response.write "<p class='mb-5'> MAAF, No. Resi tidak ditemukan</p>"

end if
end if
%>  
                              
                                
                                
                               
				

	</body>
</html>