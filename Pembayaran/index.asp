<!--#include file="../connections/pigoConn.asp"--> 
<%
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    id = request.Form("TransaksiID")

    set Transaksi_cmd = server.createObject("ADODB.COMMAND")
	Transaksi_cmd.activeConnection = MM_PIGO_String

	Transaksi_cmd.commandText = "SELECT MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.trTglTransaksi FROM MKT_T_Transaksi_D1 LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_D1.trD1 = MKT_T_Transaksi_D1A.trD1A RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_Transaksi_D1.trD1 = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_H.trID = '"& id &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"'  "
    'response.write Transaksi_cmd.commandText
    set Transaksi = Transaksi_cmd.execute

	Transaksi_cmd.commandText = "SELECT MKT_T_StatusTransaksi.strName, MKT_T_StatusPembayaran.spName,MKT_T_Transaksi_H.trTotalPembayaran FROM MKT_T_Transaksi_D1A RIGHT OUTER JOIN MKT_T_StatusPembayaran RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_T_StatusPembayaran.spID = MKT_T_Transaksi_H.tr_spID LEFT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_H.trID = '"& id &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"' "
    'response.write Transaksi_cmd.commandText
    set StatusPembayaran = Transaksi_cmd.execute

    set Customer_cmd = server.createObject("ADODB.COMMAND")
	Customer_cmd.activeConnection = MM_PIGO_String

	Customer_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.tr_custID, MKT_T_Transaksi_H.tr_rkID, MKT_T_Transaksi_H.tr_rkBankID, MKT_T_Transaksi_H.tr_rkNomorRk, MKT_T_Transaksi_H.tr_almID,  MKT_T_Transaksi_H.trJenisPembayaran, MKT_T_Transaksi_H.trTglTransaksi, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1,  MKT_M_Customer.custPhone2, MKT_M_Rekening.rkID, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, MKT_M_Rekening.rkJenis, MKT_M_Alamat.almID,  MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel,  MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong, MKT_M_Alamat.alm_custID, GLB_M_Bank.BankID,  GLB_M_Bank.BankName FROM MKT_T_Transaksi_D1A RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_D1A.trD1A = MKT_T_Transaksi_D1.trD1 RIGHT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN GLB_M_Bank RIGHT OUTER JOIN MKT_M_Rekening ON GLB_M_Bank.BankID = MKT_M_Rekening.rkBankID RIGHT OUTER JOIN MKT_T_Transaksi_H ON MKT_M_Rekening.rkID = MKT_T_Transaksi_H.tr_rkID ON MKT_M_Alamat.almID = MKT_T_Transaksi_H.tr_almID LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID ON MKT_T_Transaksi_D1.trD1 = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_H.trID = '"& id &"' AND MKT_T_Transaksi_H.tr_custID = '"& request.Cookies("custID") &"'  "
    'response.write Customer_cmd.commandText
    set Customer = Customer_cmd.execute

    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String
%>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="../css/stylehome.css">
    <link rel="stylesheet" type="text/css" href="payment.css">
    <script src="../js/jquery-3.6.0.min.js"></script>

    <title>Otopigo</title>
    <script>

    const characters ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    function generateString(length) {
        let result = ' ';
        const charactersLength = characters.length;
        for ( let i = 0; i < length; i++ ) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }
    console.log(generateString(10));
    
    function getData(){
            let detail = document.getElementById("detail");

            document.getElementById("sub-payment").style.display = "block";
            document.getElementById("bayar").style.display = "none";
    }
    function closes(){
            let detail = document.getElementById("closes");

            document.getElementById("sub-payment").style.display = "none";
            document.getElementById("bayar").style.display = "block";
    }
    </script>

    <style>
        p {
        text-align: center;
        font-size: 20px;
        margin-top: 0px;
        }
        .tr-done{
            margin-left:12rem;
            margin-right:12rem;
            border: 2px solid #eeeeee;
            padding:20px;
            border-radius:20px;
        }
    </style>
</head>
<body >

<!-- Header -->
    <!--<div class="header">
        <div class="container">
            <div class="row align-items-center">
                <div class="logo col-lg-0 col-md-0 col-sm-0 col-2 mt-3 mb-3 me-4">
                    <a class="logo " href="#">
                        <img src="<%=base_url%>/assets/logo1.jpg" class="rounded-pill" class="logo" alt="" width="70" height="70" />
                    </a>
                </div>
                <div class="logo col-lg-0 col-md-0 col-sm-0 col-6 mt-3 mb-3">
                    <span>PIGO</span>
                </div>
            </div>
        </div>
    </div>-->
<!-- Header -->

<!-- Body -->
    <div class="cont-pay" style="padding:6rem 12rem">
        <div class="payment">
            <div class="row text-align-center text-center">
                <div class="col-12">
                    <h5><b>PESANAN TELAH BERHASIL</b></h5>
                </div>
            </div>
            <div class="row text-align-center text-center">
                <div class="col-12">
                    <span style="font-size:15px"><b><%=id%></b></span>
                </div>
            </div>
            <div class="row mt-2 text-align-center text-center">
                <div class="col-12">
                    <span style="font-size:15px"><%=StatusPembayaran("spName")%></span> : <span style="font-size:15px"><%=Replace(replace(FormatCurrency(StatusPembayaran("trTotalPembayaran")),"$","Rp. "),".00","")%></span>
                </div>
            </div>
            <div class="row mt-4 text-align-center text-center">
                <div class="col-6">
                    <a style="color:black"href="../Customer/Pesanan/"> Lihat Pesanan </a>
                    <input type="hidden" name="trID" id="trID" value="<%=id%>">
                </div>
                <div class="col-6">
                    <a onclick="window.open('invoice.asp?trID='+document.getElementById('trID').value,'_Self')"> Lihat Invoice </a>
                </div>
            </div>
            
        </div>
        
        <div class="sub-payment mt-3" >
            <div class="row text-align-center" id="sub-payment" style="display:none">
                <div class="col-12">
                    <div class="row text-center mb-2">
                        <div class="col-11">
                            <span class="txt-judul-pay"> Customer Detail </span>
                        </div>
                        <div class="col-1 text-center">
                            <span onclick="closes()" class="txt-judul-pay" id="closes"> <i class="fas fa-times-circle"></i> </span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <span class="txt-desc-pay"> <%=customer("almNamaPenerima")%> [  <%=customer("almLabel")%> ] </span><br>
                            <span class="txt-desc-pay"> <%=customer("almPhonePenerima")%> </span><br>
                            <span class="txt-desc-pay"> <%=customer("almlengkap")%> </span><br>
                            <span class="txt-desc-pay"> <%=customer("almkel")%> - <%=customer("almkec")%> - <%=customer("almKota")%> - <%=customer("almProvinsi")%> - <%=customer("almkdPos")%> </span>
                        </div>
                        <div class="col-6">
                            <span class="txt-desc-pay"> <%=customer("custNama")%> [ <%=customer("custEmail")%> ]</span><br>
                            <span class="txt-desc-pay"> <%=customer("tr_rkNomorrk")%> [ <%=customer("BankName")%> / <%=customer("rkNamaPemilik")%> ] </span><br>
                            <span class="txt-desc-pay"> <%=customer("trID")%> [ <%=CDate(customer("trTgltransaksi"))%> ] </span><br>
                            <span class="txt-desc-pay"> <%=customer("trJenisPembayaran")%> </span><br>
                        </div>
                    </div>
                    <hr style="border:2px solid #a1a1a1; padding:0px">
                    <span class="txt-judul-pay"> Rincian Produk </span>
                    <div class="row">
                        <div class="col-12">
                            <span class="txt-desc-pay"> Detail Seller :  </span>
                            <%
                                Seller_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.tr_rkID, MKT_T_Transaksi_D1.tr_BankID, MKT_T_Transaksi_D1.tr_rkNomorRK,  MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking,  MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.tr_strID, GLB_M_Bank.BankID, GLB_M_Bank.BankName, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkID, MKT_M_Rekening.rkNomorRk,  MKT_M_Rekening.rkNamaPemilik, MKT_M_Rekening.rkJenis, MKT_M_Seller.sl_custID, MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Customer.custEmail, MKT_M_Customer.custNama,  MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi,  MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almJenis, MKT_M_Alamat.almLatt,  MKT_M_Alamat.almLong, MKT_M_Alamat.alm_custID FROM MKT_T_Transaksi_H LEFT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Seller LEFT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID ON MKT_M_Alamat.almID = MKT_M_Seller.sl_almID RIGHT OUTER JOIN MKT_M_Rekening LEFT OUTER JOIN GLB_M_Bank ON MKT_M_Rekening.rkBankID = GLB_M_Bank.BankID RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Rekening.rkID = MKT_T_Transaksi_D1.tr_rkID ON MKT_M_Seller.sl_custID = MKT_T_Transaksi_D1.tr_slID ON MKT_T_Transaksi_H.trID = left(MKT_T_Transaksi_D1.trD1,12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_D1A.trD1A WHERE MKT_M_Alamat.almJenis = 'Alamat Toko' AND MKT_T_Transaksi_H.trID = '"& id &"' AND MKT_T_Transaksi_H.tr_custID = '"& Customer("custID") &"'  GROUP BY MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1.trD1, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_D1.tr_rkID, MKT_T_Transaksi_D1.tr_BankID, MKT_T_Transaksi_D1.tr_rkNomorRK,  MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking,  MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.tr_strID, GLB_M_Bank.BankID, GLB_M_Bank.BankName, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkID, MKT_M_Rekening.rkNomorRk,  MKT_M_Rekening.rkNamaPemilik, MKT_M_Rekening.rkJenis, MKT_M_Seller.sl_custID, MKT_M_Seller.sl_almID, MKT_M_Seller.slName, MKT_M_Customer.custEmail, MKT_M_Customer.custNama,  MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi,  MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almJenis, MKT_M_Alamat.almLatt,  MKT_M_Alamat.almLong, MKT_M_Alamat.alm_custID"
                                'response.write Seller_cmd.commandText
                                set Seller = Seller_cmd.execute
                            
                            %>
                            <% do while not seller.eof %>
                            <div class="row mt-2 mb-2">
                                <div class="col-6">
                                    <span class="txt-desc-pay"> <%=Seller("slName")%> [  <%=Seller("custnama")%> ] </span><br>
                                    <span class="txt-desc-pay"> <%=Seller("almLengkap")%> /<%=Seller("almJenis")%> </span><br>
                                    <span class="txt-desc-pay"> <%=Seller("almkel")%> - <%=Seller("almKec")%> - <%=Seller("almKota")%> - <%=Seller("almProvinsi")%> - <%=Seller("almKdPos")%> </span><br>
                                    <span class="txt-desc-pay"> <%=Seller("almlatt")%> [  <%=Seller("almlong")%> ] </span><br>
                                    
                                </div>
                                <div class="col-6">
                                    <span class="txt-desc-pay"> <%=Seller("custEmail")%> [<%=Seller("custPhone1")%>/<%=Seller("custPhone2")%>] </span><br>
                                    <span class="txt-desc-pay"> <%=Seller("tr_rkNomorRk")%> [  <%=Seller("BankName")%> ]  </span><br>
                                    <span class="txt-desc-pay"> <%=Seller("trPengiriman")%> [  <%=Seller("trBiayaOngkir")%> ]  </span><br>
                                    <span class="txt-desc-pay"> <%=Seller("trD1Catatan")%> </span><br>
                                    
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <table class="table txt-desc-pay  table-bordered table-condensed">
                                        <thead class="text-center">
                                            <tr>
                                                <th> Nama Produk </th>
                                                <th> Harga </th>
                                                <th> Qty </th>
                                                <th> Total </th>
                                            </tr>
                                        </thead>

                                        <%
                                            Produk_cmd.commandText = " SELECT MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1A.trD1A, MKT_M_Produk.pdID FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID AND MKT_T_Transaksi_D1A.trD1A = left(MKT_T_Transaksi_D1.trD1,12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON left(MKT_T_Transaksi_D1.trD1,12) = MKT_T_Transaksi_H.trID WHERE MKT_T_Transaksi_H.trID = '"& id &"' AND MKT_T_Transaksi_D1.tr_slID = '"& Seller("tr_slID") &"' AND MKT_T_Transaksi_H.tr_custID = '"& Customer("custID") &"' GROUP BY MKT_T_Transaksi_D1A.tr_pdID, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1.tr_slID, MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trD1,  MKT_T_Transaksi_D1A.trD1A, MKT_M_Produk.pdID "
                                            'response.write Produk_cmd.commandText
                                            set Produk = Produk_cmd.execute
                                        %>

                                        <tbody>
                                            <tr>
                                                <td>[<%=Produk("tr_pdID")%>] - <%=Produk("pdNama")%> </td>
                                                <td class="text-center"> <%=Produk("tr_pdHarga")%> </td>
                                                <td class="text-center"> <%=Produk("tr_pdQty")%> </td>
                                                <% total = Produk("tr_pdHarga") * Produk("tr_pdQty")  %>
                                                <td class="text-center"> <%=total%> </td>
                                                <% GrandTotal = GrandTotal + total %>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <% seller.movenext
                            loop %>
                        </div>
                    </div>
                </div>
            </div>
            <div id="bayar">
                <div class="row">
                    <div class="col-12 text-center">
                        <span onclick="getData()" class="txt-desc-pay" id="detail"> Lihat Rincian Pesanan </span><br>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- Body -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="../js/bootstrap.js"></script>
    <script src="../js/popper.min.js"></script>
    <script>

        function Timer(duration, display) 
        {
            var timer = duration, hours, minutes, seconds;
            setInterval(function () {
                hours = parseInt((timer /3600)%24, 10)
                minutes = parseInt((timer / 60)%60, 10)
                seconds = parseInt(timer % 60, 10);

                        hours = hours < 10 ? "0" + hours : hours;
                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                display.text(hours +":"+minutes + ":" + seconds);

                        --timer;
            }, 1000);
        }

        jQuery(function ($) 
        {
            var twentyFourHours = 24 * 60 * 60;
            var display = $('#remainingTime');
            Timer(twentyFourHours, display);
        });
    </script>
</body>
</html>
