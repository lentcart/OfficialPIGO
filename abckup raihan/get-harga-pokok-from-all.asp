<!--#include file="../Connections/cargo.asp" -->

 <p class="mb-4"></p>
			  <h2 class="text-center text-uppercase text-danger text-secondary mb-200">Tarif Dakota Cargo</h2> 
				<section class="section overfree">
					<div class="icon-center"><i class="fa fa-bar-chart"></i></div>
					<div class="container">
					<div class="section-title text-center">
								  <p class="mb-4"></p>
								  
						<div class="table-responsive" style="overflow-y:auto;">
						<table class="table" >
						  <thead class="thead-dark">
							<tr>
							  <th scope="col">Tarif Dasar</th>
							  <th scope="col">KG Minimal</th>
							  <th scope="col">KG Selanjutnya</th>
							  <th scope="col">Keterangan</th>
							</tr>
						  </thead>
						  <tbody>


<%

dim harga
dim harga_cmd

dim asalKota
dim tujuanProp
dim tujuanKota
dim tujuanKec
dim tujuanKdpos

tujuanKdpos = trim(request.querystring("tujKdpos"))
asalKota = ucase(request.QueryString("tagen"))
tujuan = request.QueryString("tuj")
	if tujuan <> "" then
		tujuan = split(trim(request.querystring("tuj")),",")
		tujuanProp = trim(tujuan(0))
		tujuanKota = trim(tujuan(1))
		tujuanKec = trim(tujuan(2))
	end if
if asalKota = "JAKARTA PUSAT" then
	asalKota = "JAKARTA TIMUR"
elseif asalKota = "JAKARTA SELATAN" then
		asalKota = "JAKARTA TIMUR"
elseif asalKota = "JAKARTA UTARA" then
		asalKota = "JAKARTA TIMUR"
elseif asalKota = "JAKARTA BARAT" then
		asalKota = "JAKARTA TIMUR"
elseif asalKota = "JAKARTA" then
		asalKota = "JAKARTA TIMUR"	
elseif asalKota = "DKI JAKARTA" then
		asalKota = "JAKARTA TIMUR"		
end if


groupby = " GROUP BY dbo.GLB_M_Agen.Agen_Kota, dbo.MKT_M_eHarga.minimalKG, dbo.MKT_M_eHarga.bypasskg, dbo.MKT_M_eHarga.hargapokok, dbo.MKT_M_eHarga.hargakgselanjutnya, dbo.MKT_M_eHarga.bypass1kg,                           dbo.MKT_M_eHarga.harga1kg, dbo.MKT_M_eHarga.bypass2kg, dbo.MKT_M_eHarga.harga2kg, dbo.MKT_M_eHarga.bypass3kg, dbo.MKT_M_eHarga.harga3kg, dbo.MKT_M_eHarga.biayatambahan,                           dbo.MKT_M_eHarga.minimalVol, dbo.MKT_M_eHarga.bypassVol, dbo.MKT_M_eHarga.hargapokokvol, dbo.MKT_M_eHarga.HargaVolSelanjutnya, dbo.MKT_M_eHarga.ByPass1Vol, dbo.MKT_M_eHarga.Harga1Vol,                           dbo.MKT_M_eHarga.ByPass2Vol, dbo.MKT_M_eHarga.ByPass3Vol, dbo.MKT_M_eHarga.Harga2Vol, dbo.MKT_M_eHarga.Harga3Vol, dbo.MKT_M_eHarga.estimasiHari, dbo.MKT_M_eHarga.keterangan,                           dbo.GLB_M_eKodePos.KecamatanDistrik, dbo.GLB_M_eKodePos.Propinsi, dbo.GLB_M_eKodePos.KotaKabupaten, dbo.GLB_M_eKodePos.DesaKelurahan, dbo.GLB_M_eKodePos.KodePos " 
orderby = " ORDER BY dbo.GLB_M_Agen.Agen_Kota "

set harga_cmd = server.CreateObject("adodb.command")
harga_cmd.activeConnection = MM_Cargo_string


if trim(tujuanKdpos) <> "" then
	harga_cmd.commandText = "SELECT top 1 dbo.GLB_M_Agen.Agen_Kota, dbo.MKT_M_eHarga.minimalKG, dbo.MKT_M_eHarga.bypasskg, dbo.MKT_M_eHarga.hargapokok, dbo.MKT_M_eHarga.hargakgselanjutnya, dbo.MKT_M_eHarga.bypass1kg,   dbo.MKT_M_eHarga.harga1kg, dbo.MKT_M_eHarga.bypass2kg, dbo.MKT_M_eHarga.harga2kg, dbo.MKT_M_eHarga.bypass3kg, dbo.MKT_M_eHarga.harga3kg, dbo.MKT_M_eHarga.biayatambahan,                           dbo.MKT_M_eHarga.minimalVol, dbo.MKT_M_eHarga.bypassVol, dbo.MKT_M_eHarga.hargapokokvol, dbo.MKT_M_eHarga.HargaVolSelanjutnya, dbo.MKT_M_eHarga.ByPass1Vol, dbo.MKT_M_eHarga.Harga1Vol,                           dbo.MKT_M_eHarga.ByPass2Vol, dbo.MKT_M_eHarga.ByPass3Vol, dbo.MKT_M_eHarga.Harga2Vol, dbo.MKT_M_eHarga.Harga3Vol, dbo.MKT_M_eHarga.estimasiHari, dbo.MKT_M_eHarga.keterangan,                           dbo.GLB_M_eKodePos.KecamatanDistrik, dbo.GLB_M_eKodePos.Propinsi, dbo.GLB_M_eKodePos.KotaKabupaten, dbo.GLB_M_eKodePos.DesaKelurahan, dbo.GLB_M_eKodePos.KodePos FROM            dbo.GLB_M_Agen LEFT OUTER JOIN                          dbo.MKT_M_eHarga ON dbo.GLB_M_Agen.Agen_ID = dbo.MKT_M_eHarga.agenID_asal LEFT OUTER JOIN                          dbo.GLB_M_eKodePos ON dbo.MKT_M_eHarga.Tujuan_Kecamatan = dbo.GLB_M_eKodePos.KecamatanDistrik AND dbo.MKT_M_eHarga.Tujuan_Kabupaten = dbo.GLB_M_eKodePos.KotaKabupaten AND                           dbo.MKT_M_eHarga.Tujuan_Propinsi = dbo.GLB_M_eKodePos.Propinsi where Agen_kota = '"& trim(asalKota) &"' and Kodepos = '"& trim(tujuanKdpos) &"'"  
else
	harga_cmd.commandText = "SELECT top 1 dbo.GLB_M_Agen.Agen_Kota, dbo.MKT_M_eHarga.minimalKG, dbo.MKT_M_eHarga.bypasskg, dbo.MKT_M_eHarga.hargapokok, dbo.MKT_M_eHarga.hargakgselanjutnya, dbo.MKT_M_eHarga.bypass1kg,   dbo.MKT_M_eHarga.harga1kg, dbo.MKT_M_eHarga.bypass2kg, dbo.MKT_M_eHarga.harga2kg, dbo.MKT_M_eHarga.bypass3kg, dbo.MKT_M_eHarga.harga3kg, dbo.MKT_M_eHarga.biayatambahan,                           dbo.MKT_M_eHarga.minimalVol, dbo.MKT_M_eHarga.bypassVol, dbo.MKT_M_eHarga.hargapokokvol, dbo.MKT_M_eHarga.HargaVolSelanjutnya, dbo.MKT_M_eHarga.ByPass1Vol, dbo.MKT_M_eHarga.Harga1Vol,                           dbo.MKT_M_eHarga.ByPass2Vol, dbo.MKT_M_eHarga.ByPass3Vol, dbo.MKT_M_eHarga.Harga2Vol, dbo.MKT_M_eHarga.Harga3Vol, dbo.MKT_M_eHarga.estimasiHari, dbo.MKT_M_eHarga.keterangan,                           dbo.GLB_M_eKodePos.KecamatanDistrik, dbo.GLB_M_eKodePos.Propinsi, dbo.GLB_M_eKodePos.KotaKabupaten, dbo.GLB_M_eKodePos.DesaKelurahan, dbo.GLB_M_eKodePos.KodePos FROM            dbo.GLB_M_Agen LEFT OUTER JOIN                          dbo.MKT_M_eHarga ON dbo.GLB_M_Agen.Agen_ID = dbo.MKT_M_eHarga.agenID_asal LEFT OUTER JOIN                          dbo.GLB_M_eKodePos ON dbo.MKT_M_eHarga.Tujuan_Kecamatan = dbo.GLB_M_eKodePos.KecamatanDistrik AND dbo.MKT_M_eHarga.Tujuan_Kabupaten = dbo.GLB_M_eKodePos.KotaKabupaten AND                           dbo.MKT_M_eHarga.Tujuan_Propinsi = dbo.GLB_M_eKodePos.Propinsi where Agen_kota = '"& trim(asalKota) &"' and tujuan_propinsi = '"& trim(tujuanProp)  &"' and tujuan_Kabupaten = '"& trim(tujuanKota) &"' and tujuan_kecamatan = '"& trim(tujuanKec) &"'"  

end if 
 
harga_cmd.commandText = harga_cmd.commandText + groupby + orderby

'response.write harga_cmd.commandText
set harga = harga_cmd.execute
%>

<% if harga.eof = true then %>
Mohon maaf, tarif tidak ditemukan. Mohon gunakan tujuan kodepos.

<% end if %>



<%
do while not harga.eof 
%>



							<tr>
							  <th scope="row">Rp. <%=formatNumber(harga.fields.item("hargaPokok"))%></th>
							  <td><%=harga.fields.item("minimalKG")%> Kg</td>
							  <td>Rp. <%=formatNumber(harga.fields.item("hargakgselanjutnya"))%></td>
							  <td><%=harga.fields.item("keterangan")%></td>
							</tr>
						 


<%
harga.movenext
loop
%>

 </tbody>
						</table>
						</div>
					</div>
						<div class="clearfix"></div>
					</div>






