<!--#include file="../../connections/pigoConn.asp"--> 

<%
	if request.Cookies("custEmail")="" then 
        response.redirect("../../")
    end if
    Transaksi = request.queryString("trID")
	set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trTotalPembayaran,  MKT_T_Transaksi_H.trID, MKT_M_Customer.custID, MKT_T_Transaksi_D1.tr_IDBooking, convert(varchar(10), MKT_T_Transaksi_H.trUpdateTime, 103) AS Date, CONVERT(VARCHAR(5),MKT_T_Transaksi_H.trUpdateTime,8) AS Time, MKT_T_Transaksi_H.trUpdateTime,  MKT_T_Transaksi_H.trUpdateTime AS tanggal,MKT_M_Alamat.alm_custID, MKT_T_Transaksi_H.tr_almID, MKT_M_Alamat.almNamaPenerima,  MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos,  MKT_M_Alamat.almLengkap,MKT_T_Transaksi_H.tr_PaidAt FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Alamat.almID = MKT_T_Transaksi_H.tr_almID RIGHT OUTER JOIN MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_StatusTransaksi ON MKT_T_Transaksi_D1.tr_strID = MKT_T_StatusTransaksi.strID ON LEFT(MKT_T_Transaksi_H.trID, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Seller ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID WHERE (MKT_T_Transaksi_H.trID = '"& Transaksi &"') GROUP BY MKT_M_Seller.slName, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strID, MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_H.trID,  MKT_M_Customer.custID, MKT_T_Transaksi_D1.tr_IDBooking, MKT_T_Transaksi_H.trUpdateTime, MKT_M_Alamat.alm_custID, MKT_T_Transaksi_H.tr_almID, MKT_M_Alamat.almNamaPenerima,  MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos,  MKT_M_Alamat.almLengkap,MKT_T_Transaksi_H.tr_PaidAt "
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute   

    set pdtr_cmd =  server.createObject("ADODB.COMMAND")
    pdtr_cmd.activeConnection = MM_PIGO_String
    
%>
<script>
    $.get( "Get-StatusBTT.asp?SuratJalan=<%=Transaksi("trID")%>&StatusSend=", function( data ) {
        var jsonDimensi = JSON.parse(data);
        var contData    = jsonDimensi.detail;
        var contArrv    = " ";
        for(i=0; i<contData.length; i++){
            var posisi  = contData[i].posisi
            var tgl   = contData[i].tanggal
            var ket     = contData[i].keterangan
            function convertDate(tgl) {
            function pad(s) { return (s < 10) ? '0' + s : s; }
            var d = new Date(tgl)
            return [pad(d.getDate()), pad(d.getMonth()+1), d.getFullYear()].join('/')
            }
            var Tanggal = convertDate(tgl)
            const [dateComponents, timeComponents] = tgl.split(' ');
            var convertedTime = moment(timeComponents+" PM", 'hh:mm A').format('HH:mm')
            if (convertedTime == "Invalid date"){
                var waktu = "";
            }else{
                var waktu = convertedTime;
            }
            contArrv += `
                <li class="StepProgress-item is-done">
                    <span class="text-judul-track" >${posisi}</span><br>
                    <span class="text-desc-track"> ${Tanggal} </span> &nbsp; <span class="text-desc-track"> ${waktu} </span><br>
                    <span class="text-desc-track">${ket}</span>
                </li>
            `
            document.getElementById("liststatus").innerHTML = contArrv ;
        }
    });
</script>
<div class="row mt-2"> 
    <div class = "col-12">
        <div class="cont-pesanan mb-3">
            <div class="row align-items-center"> 
                <div class = "col-6">
                    <span onclick="back()"style="font-weight:bold;color:#c70505" >< No Transaksi : <%=Transaksi("trID")%> </span>
                </div>
                <input type="hidden" name="bookingid" id="bookingid" value="<%=Transaksi("tr_IDBooking")%>">
                <div class = " text-end col-6">
                    <% if Transaksi("strID") <> "04" then%>
                        <% if Transaksi("tr_IDBooking") = "" then %>
                            <span style="color:#c70505;"><i class="fas fa-box"></i> &nbsp; Seller sedang menyiapkan pesanan anda</span>
                        <% else %>
                            <script>
                            $.get( "Get-StatusPengiriman.asp?SuratJalan=<%=Transaksi("trID")%>&StatusSend=", function( data ) {
                                var jsonData = JSON.parse(data);
                                $("#statusdev<%=Transaksi("trID")%>").text(jsonData.Keterangan);
                                $("#pesananditerima<%=Transaksi("trID")%>").text(jsonData.Tanggal);
                                console.log(jsonData.Tanggal);
                            });
                                </script>
                            <span style="color:#c70505; font-size:12px"><i class="fas fa-truck"></i> &nbsp; <span style="color:#c70505; font-size:12px"  id="statusdev<%=Transaksi("trID")%>"></span></span>
                        <% end if %>
                    <% else %>
                        <span style="color:#c70505"> <i class="fas fa-box"></i> &nbsp;  <%=Transaksi("strName")%></span>
                    <% end if  %>
                </div>
            </div>
            <hr>
            <div class="stepper-cont">
                <div class="stepper-wrapper">
                    <%  if  Transaksi("strID") = "00" then %>
                        <div class="stepper-item completed">
                            <div class="step-counter"><i class="fas fa-shopping-bag"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dibuat<span>
                                <span class="text-desc-track"><%=Transaksi("tanggal")%></p>
                            </div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-money-check-alt"></i></div>
                            <div class="text-center">Belum Dibayar</div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-truck"></i></div>
                            <div class="text-center">Third</div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-box-open"></i></div>
                            <div class="text-center">Third</div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-star"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Belum Dinilai<span>
                            </div>
                        </div>
                    <% else if Transaksi("strID") = "01" then%>
                        <div class="stepper-item completed">
                            <div class="step-counter"><i class="fas fa-shopping-bag"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dibuat<span>
                                <span class="text-desc-track"><%=Transaksi("tanggal")%></p>
                            </div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-money-check-alt"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dibuat<span>
                                <%  if  Transaksi("tr_PaidAt") <> "" then %>
                                    <span class="text-desc-track">(<%=Transaksi("trTotalPembayaran")%>)</span>
                                    <span class="text-desc-track"><%=Transaksi("tr_PaidAt")%></span>
                                <% end if %>
                            </div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-truck"></i></div>
                            <div class="text-center">Pesanan Dikirim</div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-box-open"></i></div>
                            <div class="text-center">Diterima</div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-star"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Belum Dinilai<span>
                            </div>
                        </div>
                    <% else if Transaksi("strID") = "02" then%>
                        <div class="stepper-item completed">
                            <div class="step-counter"><i class="fas fa-shopping-bag"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dibuat<span>
                                <span class="text-desc-track"><%=Transaksi("tanggal")%></p>
                            </div>
                        </div>
                        <div class="stepper-item completed">
                            <div class="step-counter"><i class="fas fa-money-check-alt"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dibuat<span>
                                <%  if  Transaksi("tr_PaidAt") <> "" then %>
                                    <span class="text-desc-track">(<%=Transaksi("trTotalPembayaran")%>)</span>
                                    <span class="text-desc-track"><%=Transaksi("tr_PaidAt")%></span>
                                <% end if %>
                            </div>
                        </div>
                        <div class="stepper-item completed">
                            <div class="step-counter"><i class="fas fa-truck"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dikirimkan<span>
                                <script>
                                $.get( "Get-StatusBooking.asp?BookingID=<%=Transaksi("tr_IDBooking")%>", function( data ) {
                                    var jsonData = JSON.parse(data);
                                    var jsonData = JSON.parse(data);
                                    var a        = jsonData.detail
                                    var last = Object.keys(a).pop();
                                    $("#statusdev").text(a[last].tanggal);

                                });
                                </script>
                                <span class="text-desc-track" id="statusdev"> </span>
                            </div>
                        </div>
                        <div class="stepper-item completed">
                            <div class="step-counter"><i class="fas fa-money-check-alt"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Diterima<span><br>
                                <span class="text-desc-track" id="pesananditerima<%=Transaksi("trID")%>"> </span>
                            </div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-money-check-alt"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Belum Dinilai<span>
                            </div>
                        </div>
                    <% else if Transaksi("strID") = "03" then%>
                        <div class="stepper-item completed">
                            <div class="step-counter"><i class="fas fa-shopping-bag"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dibuat<span><br>
                                <span class="text-desc-track"><%=Transaksi("tanggal")%></p>
                            </div>
                        </div>
                        <div class="stepper-item completed">
                            <div class="step-counter "><i class="fas fa-money-check-alt"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dibuat<span><br>
                                <%  if  Transaksi("tr_PaidAt") <> "" then %>
                                    <span class="text-desc-track">(<%=Transaksi("trTotalPembayaran")%>)</span>
                                    <span class="text-desc-track"><%=Transaksi("tr_PaidAt")%></span>
                                <% end if %>
                            </div>
                        </div>
                        <div class="stepper-item completed">
                            <div class="step-counter "><i class="fas fa-truck"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dikirimkan<span><br>
                                <script>
                                $.get( "Get-StatusBooking.asp?BookingID=<%=Transaksi("tr_IDBooking")%>", function( data ) {
                                    var jsonData = JSON.parse(data);
                                    var jsonData = JSON.parse(data);
                                    var a        = jsonData.detail
                                    var last = Object.keys(a).pop();
                                    $("#statusdev").text(a[last].tanggal);

                                });
                                </script>
                                <span class="text-desc-track" id="statusdev"> </span>
                            </div>
                        </div>
                        <div class="stepper-item completed">
                            <div class="step-counter"><i class="fas fa-box-open"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Diterima<span><br>
                                <span class="text-desc-track" id="pesananditerima<%=Transaksi("trID")%>"> </span>
                            </div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-star"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Belum Dinilai<span>
                            </div>
                        </div>
                    <% else if Transaksi("strID") = "04" then%>
                        <div class="stepper-item completed">
                            <div class="step-counter"><i class="fas fa-shopping-bag"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dibuat<span><br>
                                <span class="text-desc-track"><%=Transaksi("tanggal")%></p>
                            </div>
                        </div>
                        <div class="stepper-item">
                            <div class="step-counter"><i class="fas fa-times"></i></div>
                            <div class="text-center">
                                <span class="text-judul-track">Pesanan Dibatalkan<span><br>
                                <span class="text-desc-track"><%=Transaksi("tanggal")%></p>
                            </div>
                        </div>
                    <% end if %> <% end if %> <% end if %> <% end if %> <% end if %>
                </div>
            </div>
            <hr style="color:#0077a2">
            <div class="row "> 
                <div class="col-8">
                    <span style="font-weight:bold;color:#c70505" > Pengiriman </span>
                </div>
            </div>
            <div class="row mt-3"> 
                <div class="col-4" style="border-right:2px solid #aaa">
                    <span class="text-judul-track"> <%=Transaksi("almNamaPenerima")%></span><br>
                    <span class="text-desc-track"> ( <%=Transaksi("almPhonePenerima")%> ) </span><br>
                    <span class="text-desc-track"> <%=Transaksi("almLengkap")%></span><br>
                    <span class="text-desc-track"> <%=Transaksi("almKota")%>, <%=Transaksi("almKec")%>, <%=Transaksi("almKel")%>, <%=Transaksi("almProvinsi")%>, <%=Transaksi("almKdPos")%></span><br>
                </div>

                <div class="col-8">
                    <div class="wrapper-cont">
                        <div class="wrapper">
                            <ul class="StepProgress">
                                <% if Transaksi("strID") <> "04" then%>
                                    <% if Transaksi("tr_IDBooking") = "" then%>
                                        <li class="StepProgress-item done">
                                            <span><b>Pesanan Di Buat</b></span><br>
                                            <span><%=Transaksi("Date")%></span> &nbsp; <span><%=Transaksi("time")%></span>
                                        </li>
                                    <% else %>
                                        <div class="mb-2" id="liststatus">

                                        </div>
                                        <li class="StepProgress-item is-done">
                                            <span class="text-judul-track">Sedang Dikemas</span><br>
                                            <span id="tgl" class="text-desc-track">  </span>&nbsp; <span id="wkt" class="text-desc-track"></span><br>
                                            <span class="text-desc-track"> Pengirim telah mengatur pengiriman. Menunggu paket diserahkan ke pihak jasa kirim. </span>
                                        </li>
                                        <li class="StepProgress-item done">
                                            <span class="text-judul-track">Pesanan Di Buat</span><br>
                                            <span class="text-desc-track"><%=Transaksi("Date")%></span> &nbsp; <span class="text-desc-track"><%=Transaksi("time")%></span>
                                        </li>
                                    <% end if %>
                                <% else%>
                                    <li class="StepProgress-item done">
                                        <span class="text-judul-track">Pesanan Di Buat</span><br>
                                        <span><%=Transaksi("Date")%></span> &nbsp; <span><%=Transaksi("time")%></span>
                                    </li>
                                <% end if %>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <hr style="color:#0077a2">

            <div class="row align-items-center"> 
                <div class = "col-10">
                    <span style="font-weight:bold;color:#c70505" > <i class="fas fa-store"></i> &nbsp; <%=Transaksi("slName")%> </span> &nbsp;&nbsp; <button class="cont-chat"> <i class="fas fa-envelope"></i> &nbsp; Chat </button> &nbsp;&nbsp;
                    <button class="cont-action"> Kunjungi Seller </button>
                </div>
            </div>
            <hr style="color:#0077a2">
            <%
                pdtr_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdQty,pdSku,   MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, SUM(MKT_T_Transaksi_D1A.tr_pdHarga*MKT_T_Transaksi_D1A.tr_pdQty) AS SubtotalProduk, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
                'response.write pdtr_cmd.commandText
                set pdtr = pdtr_CMD.execute 
            %>
            <% 
                do while not pdtr.eof 
            %>
            <div class="row"> 
                <div class = "col-1">
                    <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:60px;width: 75px;" alt=""/>
                </div>
                <div class = "col-9">
                    <span> <%=pdtr("pdNama")%> </span> <br>
                    <span class="cont-desc"> <%=pdtr("pdSku")%> </span> <br>
                    <span> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                </div>
                <div class = " text-end col-2">
                    <span style="color:#c70505"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                </div>
            </div>
            <hr style="color:#0077a2">
            <%
                pdtr.movenext
                loop
            %>

            <%
                pdtr_cmd.commandText = "SELECT SUM(MKT_T_Transaksi_D1A.tr_pdHarga*MKT_T_Transaksi_D1A.tr_pdQty) AS SubTotalProduk, MKT_T_Transaksi_D1.trBiayaOngkir AS SubTotalPengiriman, MKT_T_Transaksi_H.trBiayaLayanan AS BiayaLayanan,  MKT_T_Transaksi_H.trBiayaPenanganan AS BiayaPenanganan, MKT_T_Transaksi_H.trTotalPembayaran AS TotalPesanan, MKT_T_Transaksi_H.trJenisPembayaran AS JenisPembayaran,SUM(MKT_T_Transaksi_D1A.tr_BiayaProteksi) AS BiayaProteksi FROM MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON LEFT(MKT_T_Transaksi_H.trID, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) where MKT_T_Transaksi_D1.tr_slID = '"& Transaksi("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"' GROUP BY  MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_H.trBiayaLayanan, MKT_T_Transaksi_H.trBiayaPenanganan, MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_H.trJenisPembayaran  "
                'response.write pdtr_cmd.commandText
                set SubTotal = pdtr_CMD.execute
            %>

            <div class="row"> 
                <div class = "col-12">
                    <table class="table">
                        <tr>
                            <td class="text-end text-desc-track">Sub Total Produk </td>
                            <td class="text-end text-desc-track" style="width:15%"><%=Replace(Replace(FormatCurrency(SubTotal("SubTotalProduk")),"$","Rp. "),".00","")%> </td>
                        </tr>
                        <tr>
                            <td class="text-end text-desc-track">Total Proteksi Produk </td>
                            <td class="text-end text-desc-track" style="width:max-content"><%=Replace(Replace(FormatCurrency(SubTotal("BiayaProteksi")),"$","Rp. "),".00","")%> </td>
                        </tr>
                        <tr>
                            <td class="text-end text-desc-track">Sub Total Pengiriman </td>
                            <td class="text-end text-desc-track" style="width:max-content"><%=Replace(Replace(FormatCurrency(SubTotal("SubTotalPengiriman")),"$","Rp. "),".00","")%> </td>
                        </tr>
                        <tr>
                            <td class="text-end text-desc-track">Total Pesanan </td>
                            <td class="text-end text-desc-track" style="width:max-content"><%=Replace(Replace(FormatCurrency(SubTotal("TotalPesanan")),"$","Rp. "),".00","")%> </td>
                        </tr>
                        <tr>
                            <td class="text-end text-desc-track"> Metode Pembayaran </td>
                            <td class="text-end text-desc-track" style="width:max-content"><%=SubTotal("JenisPembayaran")%> </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
$(document).ready(function(){
            var BookingID =$('#bookingid').val();
            $.get( `Get-StatusBooking.asp?BookingID=${BookingID}`, function( data ) {
                var jsonData        = JSON.parse(data);
                var contDetail      = jsonData.detail
                const firstValue    = Object.values(contDetail)[0];
                var tglbooking      = firstValue.tanggal
                function convertDate(tglbooking) {
                function pad(s) { return (s < 10) ? '0' + s : s; }
                var d = new Date(tglbooking)
                return [pad(d.getDate()), pad(d.getMonth()+1), d.getFullYear()].join('/')
                }
                var Tanggal = convertDate(tglbooking)
                const [dateComponents, timeComponents] = tglbooking.split(' ');
                var convertedTime = moment(timeComponents+" PM", 'hh:mm A').format('HH:mm')
                var Waktu = convertedTime;
                $("#tgl").text(Tanggal);
                $("#wkt").text(Waktu);
            });
        });
</script>