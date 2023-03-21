<!--#include file="../../connections/pigoConn.asp"-->
<%

    if request.Cookies("custEmail")="" then 
    response.redirect("../")
    end if

    TransaksiID = request.queryString("trID")

    set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT TOP (10) MKT_T_Transaksi_H.trID,MKT_T_StatusTransaksi.strID, convert(varchar(10), MKT_T_Transaksi_H.trUpdateTime, 103) AS Date, CONVERT(VARCHAR(5),MKT_T_Transaksi_H.trUpdateTime,8) AS Time, MKT_M_Customer.custID,MKT_M_Customer.custNama, MKT_M_Customer.custPhoto,  MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almKel, MKT_M_Alamat.almKec,  MKT_M_Alamat.almKota, MKT_M_Alamat.almProvinsi,MKT_M_Alamat.almKdpos,  MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_H.trUpdateTime AS Tanggal, MKT_T_Transaksi_D1.trPengiriman,MKT_T_Transaksi_D1.trBiayaOngkir,MKT_T_Transaksi_D1.tr_IDBooking FROM MKT_M_Customer RIGHT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Alamat.almID = MKT_T_Transaksi_H.tr_almID ON MKT_M_Customer.custID = MKT_T_Transaksi_H.tr_custID LEFT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) WHERE (MKT_T_Transaksi_D1.tr_slID = '"&request.Cookies("custID") &"') AND trID = '"& TransaksiID &"' GROUP BY MKT_M_Customer.custID,MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trUpdateTime, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.tr_strID, MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_H.trTotalPembayaran, MKT_T_Transaksi_H.tr_custID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.tr_IDBooking, MKT_T_StatusTransaksi.strID, MKT_M_Customer.custNama,  MKT_M_Customer.custPhoto, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almPhonePenerima,MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_H.trUpdateTime  ORDER BY MKT_T_Transaksi_H.trUpdateTime DESC"
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_CMD.execute 
    StatusSend = Transaksi("strID")
%>
    <script>

        $(document).ready(function(){
            var statuspesanan = `<%=StatusSend%>`;
            if (statuspesanan !== "00" && statuspesanan !== "01"){
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
                                <span class="text3-ps-seller" >${posisi}</span><br>
                                <span class="text4-ps-seller"> ${Tanggal} </span> &nbsp; <span class="text4-ps-seller"> ${waktu} </span><br>
                                <span class="text4-ps-seller">${ket}</span>
                            </li>
                        `
                        document.getElementById("liststatusBTT").innerHTML = contArrv ;
                    }
                });
            }
        });

        $(document).ready(function(){
            var statuspesanan = `<%=StatusSend%>`;
            if (statuspesanan !== "00" && statuspesanan !== "01"){
            $.get("Get-Resi.asp?SuratJalan=<%=Transaksi("trID")%>&StatusSend=", function( data ) {
                const obj   = JSON.parse(data);
                var NoResi  = obj.Resi
                console.log(obj.Resi);
                if(NoResi == ""){
                    $('#resipengiriman').text("#");
                }else{
                    $('#resipengiriman').text("#"+NoResi);
                }
            });
            }
        });
        
    </script>

        <div class="cont-pesanan">
            <div class="row align-items-center">
                <div class="col-6">
                    <span class="text1-ps-seller" onclick="back()">< &nbsp;  Detail Pesanan </span>
                </div>
                <div class="col-6 text-end">
                    <span class="text1-ps-seller">No Transaksi : <%=TransaksiID%></span>
                </div>
            </div>
        </div>
        <div class="cont-pesanan mt-3">
            <div class="row align-items-center">
                <div class="col-9">
                    <img src="data:image/png;base64,<%=Transaksi("custPhoto") %>"  class="rounded-pill" id="output" width="40" height="40"> &nbsp;
                    <span class="text3-ps-seller"> <%=Transaksi("custNama") %> </span>
                </div>
                <div class="col-3 text-end">
                    <button class="btn1-ps-seller"> Ikuti </button> &nbsp;&nbsp;
                    <button class="btn1-ps-seller"> <i class="fas fa-envelope"></i> &nbsp; Chat Sekarang </button>
                </div>
            </div>

            <hr style="color:#0077a2">

            <div class="row align-items-center">
                <div class="col-9">
                    <span class="text1-ps-seller"><i class="fas fa-box-open"></i> &nbsp;  Alamat Penerimaan </span>
                </div>
            </div>
            <div class="row mt-2 align-items-center">
                <div class="col-9">
                    <span class="text3-ps-seller"> <%=Transaksi("almPhonePenerima")%> </span><br>
                    <span class="text3-ps-seller"> <%=Transaksi("almLengkap")%> </span><br>
                    <span class="text3-ps-seller"> <%=Transaksi("almKel")%> , <%=Transaksi("almKec")%> , <%=Transaksi("almKota")%> </span><br>
                    <span class="text3-ps-seller"> <%=Transaksi("almProvinsi")%>-<%=Transaksi("almKdPos")%> </span>
                </div>
            </div>
        </div>
        <div class="cont-pesanan mt-3">
            <div class="row align-items-center">
                <div class="col-12">
                    <div class="stepper-cont">
                        <div class="stepper-wrapper">
                            <div class="stepper-item completed">
                                <div class="step-counter">
                                    <i class="fas fa-shopping-bag"></i>
                                </div>
                                <div class="text-center">
                                    <span class="text3-ps-seller">Pesanan Dibuat<span><br>
                                    <span class="text4-ps-seller" style="font-weight:450"><%=Transaksi("tanggal")%></span>
                                </div>
                            </div>
                            <div class="stepper-item">
                                <div class="step-counter">
                                    <i class="fas fa-money-check-alt"></i>
                                </div>
                                <div class="text-center">
                                    <span class="text3-ps-seller">Dalam Pengiriman<span><br>
                                    <span class="text4-ps-seller" style="font-weight:450">Pesanan dalam proses pengiriman</span><br>
                                    <span class="text4-ps-seller" style="font-weight:450">23/09/2022 21:15</span><br>
                                </div>
                            </div>
                            <div class="stepper-item">
                                <div class="step-counter"><i class="fas fa-truck"></i></div>
                                <div class="text-center">
                                    <span class="text3-ps-seller">Diterima<span><br>
                                    <span class="text4-ps-seller" style="font-weight:450">Pesanan telah diterima dan dikonfirmasi oleh pembeli</span><br>
                                    <span class="text4-ps-seller" style="font-weight:450">23/09/2022 21:15</span><br>
                                </div>
                            </div>
                            <div class="stepper-item">
                                <div class="step-counter"><i class="fas fa-box-open"></i></div>
                                <div class="text-center">
                                    <span class="text3-ps-seller">Selesai<span><br>
                                    <span class="text4-ps-seller" style="font-weight:450">Dana sedang diproses.</span><br>
                                    <span class="text4-ps-seller" style="font-weight:450">23/09/2022 21:15</span><br>
                                </div>
                            </div>
                            <div class="stepper-item">
                                <div class="step-counter"><i class="fas fa-star"></i></div>
                                <div class="text-center">
                                    <span class="text3-ps-seller">Dana Diterima<span><br>
                                    <span class="text4-ps-seller" style="font-weight:450">Dana telah dikirimkan ke Anda.</span><br>
                                    <span class="text4-ps-seller" style="font-weight:450">23/09/2022 21:15</span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-8">
                <div class="cont-pesanan">
                    <div class="row align-items-center">
                        <div class="col-4">
                            <span class="text1-ps-seller"><i class="fas fa-truck"></i> &nbsp;  Informasi Pengiriman </span>
                        </div>
                        <div class="col-8 text-end">
                            <button class="btn2-ps-seller"> <%=Transaksi("trPengiriman")%> </button> &nbsp;&nbsp;
                            <button class="btn2-ps-seller"> <%=Replace(Replace(FormatCurrency(Transaksi("trBiayaOngkir")),"$","Rp.  "),".00","")%> </button> &nbsp;&nbsp;
                            <% if Transaksi("strID") <> "00" AND Transaksi("strID") <> "01" then%>
                            <button class="btn2-ps-seller" id="resipengiriman"> # </button>
                            <% end if %>
                        </div>
                    </div>

                    <hr style="color:#0077a2">

                    <div class="row mt-3 align-items-center">
                        <div class="col-4">
                            <span class="text1-ps-seller"><i class="fas fa-money-check"></i> &nbsp;  Informasi Pembayaran </span>
                        </div>
                    </div>
                    <hr style="color:#0077a2">
                    <%
                        Transaksi_cmd.commandText = "SELECT  MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1.trPengiriman,MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, pdSku, MKT_T_Transaksi_D1A.tr_pdQty,  MKT_T_StatusTransaksi.strName,  MKT_T_Transaksi_D1A.tr_pdHarga, SUM(MKT_T_Transaksi_D1A.tr_pdHarga*MKT_T_Transaksi_D1A.tr_pdQty) AS SubtotalProduk, MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID, MKT_T_Transaksi_H.trJenisPembayaran FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Produk.pd_custID AND LEFT(MKT_T_Transaksi_D1.trD1, 12) = LEFT(MKT_T_Transaksi_D1A.trD1A,  12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID where MKT_T_Transaksi_H.tr_custID = '"& Transaksi("custID") &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trD1, MKT_M_Produk.pdImage1, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_D1.trPengiriman, MKT_T_StatusTransaksi.strName,  MKT_M_Produk.pdID, MKT_T_StatusTransaksi.strID, MKT_M_Produk.pd_custID,pdSku, MKT_T_Transaksi_H.trJenisPembayaran  "
                        'response.write Transaksi_cmd.commandText
                        set pdtr = Transaksi_CMD.execute 
                    %>
                    <% 
                        do while not pdtr.eof 
                    %>
                    <div class="row"> 
                        <div class = "col-2">
                            <img src="data:image/png;base64,<%=pdtr("pdImage1")%>" style="height:70px;width: 80px;" alt=""/>
                        </div>
                        <div class = "col-8">
                            <span class="text3-ps-seller"> <%=pdtr("pdNama")%> </span> <br>
                            <span class="text4-ps-seller"> <%=pdtr("pdSku")%> </span> <br>
                            <span class="text4-ps-seller"> <i class="fas fa-box"></i> x <%=pdtr("tr_pdQty")%> </span> <br>
                        </div>
                        <div class = " text-end col-2">
                            <span class="text5-ps-seller"> <%=Replace(Replace(FormatCurrency(pdtr("tr_pdHarga")),"$","Rp. "),".00","")%> </span>
                        </div>
                    </div>
                    <hr style="color:#0077a2">
                    <%
                        pdtr.movenext
                        loop
                    %>
                </div>
                <div class="cont-pesanan mt-2">
                    <%
                        Transaksi_cmd.commandText = "SELECT SUM(MKT_T_Transaksi_D1A.tr_pdHarga * MKT_T_Transaksi_D1A.tr_pdQty) AS TotalPesanan, SUM(MKT_T_Transaksi_D1A.tr_pdHarga * MKT_T_Transaksi_D1A.tr_pdQty) AS HargaProduk, SUM(MKT_T_Transaksi_D1A.tr_BiayaProteksi) AS BiayaProteksi, MKT_T_Transaksi_D1.trBiayaOngkir AS OngkosKirim,  SUM(MKT_T_Transaksi_D1A.tr_pdHarga * MKT_T_Transaksi_D1A.tr_pdQty) AS SubTotalPesanan, MKT_T_Transaksi_D1.trBiayaOngkir AS SubOngkosKirim, SUM(MKT_T_Transaksi_D1A.tr_BiayaProteksi) AS SubBiayaProteksi, SUM(MKT_T_Transaksi_H.trBiayaLayanan+MKT_T_Transaksi_H.trBiayaPenanganan) AS BiayaTransaksi FROM MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON LEFT(MKT_T_Transaksi_H.trID, 12) = LEFT(MKT_T_Transaksi_D1.trD1, 12) where MKT_T_Transaksi_H.tr_custID = '"& Transaksi("custID") &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' AND trID = '"& Transaksi("trID") &"'  GROUP BY MKT_T_Transaksi_D1.trBiayaOngkir "
                        'response.write Transaksi_cmd.commandText
                        set SubTotal = Transaksi_CMD.execute
                    %>
                    <button class="collapsible">
                        <span class="text1-ps-seller"><i class="fas fa-money-check"></i> &nbsp;  Rincian Penghasilan </span>
                    </button>
                    <div class="content">
                        <div class="row mt-2">
                            <div class="col-9 text-end">
                                <ul>
                                    <li> <span class="text3-ps-seller"> Total Pesanan <span> </li>
                                    <li> <span class="text4-ps-seller"> Harga Produk <span> </li>
                                    <li> <span class="text4-ps-seller"> Proteksi Produk Dibayar Pembeli <span> </li>
                                    <li> <span class="text4-ps-seller"> Ongkos Kirim Dibayar Pembeli <span> </li>
                                    <li> <span class="text4-ps-seller"> Ongkos Kirim yang diteruskan oleh Official PIGO kepada Kurir <span> </li>
                                    <li> <span class="text4-ps-seller"> Gratis Ongkir dari Shopee <span> </li>
                                    <li> <span class="text3-ps-seller"> Total Penghasilan <span> </li>
                                </ul>
                            </div>
                            <div class="col-3 text-end">
                                <ul>
                                    <li> <span class="text3-ps-seller" style="font-size:15px"> <%=Replace(Replace(FormatCurrency(SubTotal("TotalPesanan")),"$","Rp. "),".00","")%> <span> </li>
                                    <li> <span class="text4-ps-seller"> <%=Replace(Replace(FormatCurrency(SubTotal("HargaProduk")),"$","Rp. "),".00","")%> <span> </li>
                                    <li> <span class="text4-ps-seller"> <%=Replace(Replace(FormatCurrency(SubTotal("BiayaProteksi")),"$","Rp. "),".00","")%> <span> </li>
                                    <li> <span class="text4-ps-seller"> <%=Replace(Replace(FormatCurrency(SubTotal("OngkosKirim")),"$","Rp. "),".00","")%> <span> </li>
                                    <li> <span class="text4-ps-seller"> <%=Replace(Replace(FormatCurrency(0),"$","Rp. "),".00","")%> <span> </li>
                                    <li> <span class="text4-ps-seller"> <%=Replace(Replace(FormatCurrency(0),"$","Rp. "),".00","")%> <span> </li>
                                    <%
                                        TotalPenghasilan = SubTotal("TotalPesanan")
                                    %>
                                    <li> <span class="text5-ps-seller" style="font-size:18px"><b> <%=Replace(Replace(FormatCurrency(TotalPenghasilan),"$","Rp. "),".00","")%> </b><span> </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="cont-pesanan mt-2">
                    <button class="collapsible">
                        <span class="text1-ps-seller"><i class="fas fa-money-check"></i> &nbsp; Informasi Pembayaran Pembeli </span>
                    </button>
                    <div class="content">
                        <div class="row mt-2">
                            <div class="col-9 text-end">
                                <ul>
                                    <li> <span class="text3-ps-seller"> Total Pesanan <span> </li>
                                    <li> <span class="text3-ps-seller"> Ongkos Kirim <span> </li>
                                    <li> <span class="text3-ps-seller"> Proteksi Produk <span> </li>
                                    <li> <span class="text4-ps-seller"> Voucher Official PIGO <span> </li>
                                    <li> <span class="text4-ps-seller"> Voucher Seller <span> </li>
                                    <li> <span class="text3-ps-seller"> Biaya Transaksi Pembeli <span> </li>
                                    <li> <span class="text3-ps-seller"> Total Pembayaran Pembeli <span> </li>
                                </ul>
                            </div>
                            <div class="col-3 text-end">
                                <ul>
                                    <li> <span class="text3-ps-seller" style="font-size:15px"> <%=Replace(Replace(FormatCurrency(SubTotal("SubTotalPesanan")),"$","Rp. "),".00","")%> <span> </li>
                                    <li> <span class="text3-ps-seller"> <%=Replace(Replace(FormatCurrency(SubTotal("SubOngkosKirim")),"$","Rp. "),".00","")%> <span> </li>
                                    <li> <span class="text3-ps-seller"> <%=Replace(Replace(FormatCurrency(SubTotal("SubBiayaProteksi")),"$","Rp. "),".00","")%> <span> </li>
                                    <% VoucherPIGO = 0 %>
                                    <li> <span class="text4-ps-seller"> <%=Replace(Replace(FormatCurrency(VoucherPIGO),"$","Rp. "),".00","")%> <span> </li>
                                    <% VoucherSeller = 0 %>
                                    <li> <span class="text4-ps-seller"> <%=Replace(Replace(FormatCurrency(VoucherSeller),"$","Rp. "),".00","")%> <span> </li>
                                    <% BiayaTransaksiPembeli = SubTotal("BiayaTransaksi") %>
                                    <li> <span class="text3-ps-seller"> <%=Replace(Replace(FormatCurrency(BiayaTransaksiPembeli),"$","Rp. "),".00","")%> <span> </li>
                                    <%
                                        TotalPembayaranPembeli = SubTotal("SubTotalPesanan")+SubTotal("SubBiayaProteksi")+SubTotal("SubOngkosKirim")+VoucherPIGO+VoucherSeller+BiayaTransaksiPembeli
                                    %>
                                    <li> <span class="text5-ps-seller" style="font-size:18px"> <%=Replace(Replace(FormatCurrency(TotalPembayaranPembeli),"$","Rp. "),".00","")%><span> </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="cont-pesanan">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <span class="text1-ps-seller">  Status Pengiriman</span>
                        </div>
                    </div>
                    <div class="row mt-3 align-items-center">
                        <div class="col-12">
                            <div class="wrapper-cont">
                                <div class="wrapper">
                                    <ul class="StepProgress">
                                        <% if Transaksi("strID") <> "04" then%>
                                            <% if Transaksi("tr_IDBooking") = "" then%>
                                                <li class="StepProgress-item done">
                                                    <span class="text3-ps-seller">Pesanan Di Buat</span><br>
                                                    <span class="text4-ps-seller"><%=Transaksi("Date")%></span> &nbsp; <span class="text4-ps-seller"><%=Transaksi("time")%></span>
                                                </li>
                                            <% else %>
                                                <div class="mb-2" id="liststatusBTT">

                                                </div>
                                                <div class="mb-2" id="liststatusBooking">

                                                </div>
                                                <li class="StepProgress-item done">
                                                    <span  class="text3-ps-seller">Pesanan Di Buat</span><br>
                                                    <span class="text4-ps-seller"><%=Transaksi("Date")%></span> &nbsp; <span class="text4-ps-seller"><%=Transaksi("time")%></span>
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
                </div>
            </div>
        </div>
<script> 
    $(document).ready(function(){
    var statuspesanan = `<%=StatusSend%>`;
        if (statuspesanan !== "00" && statuspesanan !== "01"){
            $.get( "Get-StatusBooking.asp?BookingID=<%=Transaksi("tr_IDBooking")%>", function( data ) {
                var jsonData        = JSON.parse(data);
                var contDetail      = jsonData.detail
                var contAppnd       = " ";
                SortData = contDetail.sort((a, b) => {
                    if (a.tanggal > b.tanggal) {
                        return -1;
                    }
                });
                for(i=0; i<SortData.length; i++){
                    var Keterangan  = SortData[i].keterangan
                    var Status      = SortData[i].status
                    var Tanggal     = SortData[i].tanggal
                    var waktu       = "";
                    function convertDate(Tanggal) {
                        function pad(s) { return (s < 10) ? '0' + s : s; }
                            var d = new Date(Tanggal)
                                return [pad(d.getDate()), pad(d.getMonth()+1), d.getFullYear()].join('/')
                        }
                    var tgl = convertDate(Tanggal)
                    const [dateComponents, timeComponents] = Tanggal.split(' ');
                    var convertedTime = moment(timeComponents+" PM", 'hh:mm A').format('HH:mm')
                    if (convertedTime == "Invalid date"){
                        var waktu = "";
                    }else{
                        var waktu = convertedTime;
                    }
                    contAppnd += `
                        <li class="StepProgress-item is-done">
                            <span class="text3-ps-seller" >${Keterangan}</span><br>
                            <span class="text4-ps-seller"> ${Tanggal} </span> &nbsp; <span class="text4-ps-seller"> ${waktu} </span><br>
                        </li>
                    `
                    document.getElementById("liststatusBooking").innerHTML = contAppnd ;
                }
            }); 
        }
    });
    var coll = document.getElementsByClassName("collapsible");
    var i;

    for (i = 0; i < coll.length; i++) {
    coll[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var content = this.nextElementSibling;
        if (content.style.maxHeight){
        content.style.maxHeight = null;
        } else {
        content.style.maxHeight = content.scrollHeight + "px";
        } 
    });
    }
</script>