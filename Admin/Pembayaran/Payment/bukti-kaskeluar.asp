<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    payID = request.queryString("payID")

    set Payment_cmd = server.createObject("ADODB.COMMAND")
	Payment_cmd.activeConnection = MM_PIGO_String
			
	Payment_cmd.commandText = "SELECT MKT_T_InvoiceVendor_H.InvAP_custID, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal,MKT_T_Payment_H.payType FROM MKT_T_Payment_D LEFT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_Payment_D.pay_Ref = MKT_T_InvoiceVendor_H.InvAPID RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID LEFT OUTER JOIN MKT_M_Customer ON MKT_T_InvoiceVendor_H.InvAP_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_InvoiceVendor_D1 RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_InvoiceVendor_D1.InvAP_DLine = MKT_T_InvoiceVendor_D.InvAP_Line ON MKT_T_InvoiceVendor_H.InvAPID = MKT_T_InvoiceVendor_D.InvAP_IDH where MKT_T_Payment_H.payID = '"& payID &"'GROUP BY MKT_T_InvoiceVendor_H.InvAP_custID, MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal,MKT_M_Customer.custID,MKT_T_Payment_H.payType "
    'response.write Payment_cmd.commandText
	set Payment = Payment_cmd.execute

    set mm_cmd = server.createObject("ADODB.COMMAND")
	mm_cmd.activeConnection = MM_PIGO_String

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

    set Rekening_cmd = server.createObject("ADODB.COMMAND")
	Rekening_cmd.activeConnection = MM_PIGO_String

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Official PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script>
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "BuktiKasKeluar-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
    const myTimeout = setTimeout(myGreeting, 2000);

        function myGreeting() {
        window.print();
        }
    
        // document.getElementById("terbilang").value = output;
        // $(".as-output-digit").terbilang({
        //     nominal: 1000,
        //     output: 'digit'
        // });
    function onload(){
        let subtotal = document.getElementById("subtotal").value;
        document.getElementById("total").value = subtotal;
        // console.log(subtotal);
        
    }

    $(function () {
        $(".test").terbilang();
        $(".as-output-text").terbilang({
            nominal: document.getElementById("subtotal").value,
            output: 'text'
        });
    })
    </script>
    <style>
        body {
        width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
        font-size: 12px;
    }
    * {
        box-sizing: border-box;
        -moz-box-sizing: border-box;
    }
    .page {
        width: 210mm;
        min-height: 297mm;
        padding: 0mm;
        margin: 10mm auto;
        border: 0px #D3D3D3 solid;
        border-radius: 5px;
        background: white;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }
    .subpage {
        padding: 1cm;
        border: 0px red solid;
        height: 257mm;
        outline: 0cm #FFEAEA solid;
    }
    
    @page {
        size: A4;
        margin: 0;
    }
    @media print {
        html, body {
            width: 210mm;
            height: 297mm;        
        }
        .page {
            margin: 0;
            border: initial;
            border-radius: initial;
            width: initial;
            min-height: initial;
            box-shadow: initial;
            background: initial;
            page-break-after: always;
        }
    }
    </style>
    </head>
<body onload="onload()">  
    <div class="book">
        <div class="page">
            <div class="subpage">
               <!--#include file="../../HeaderPIGO.asp"-->
                <div class="row text-center mt-3 mt-3">
                    <div class="col-12">
                        <span class="cont-text" style="font-size:20px"><u><b>TANDA BUKTI BANK/KAS KELUAR</b></u></span><br>
                        <span class="cont-text">  <%=Payment("payID")%> -  <%=CDate(Payment("payTanggal"))%>  </span><br>
                    </div>
                </div>
                <% if Payment("payType") = "02" then %>
                    <div class="row mt-3">
                        <div class="col-3">
                            <span class="cont-text">Dibayarkan Kepada</span><br>
                        </div>
                        <div class="col-9 p-0">
                            <span class="cont-text">:</span>&nbsp;&nbsp;<span class="cont-text"><%=payment("custNama")%></span><br>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-3">
                            <span class="cont-text">Terbilang</span><br>
                        </div>
                        <div class="col-9 p-0">
                            <input type="hidden" name="total" id="total" value="">
                            <span class="cont-text">:</span>&nbsp;&nbsp;<b><span class="as-output-text cont-text"></span></b>
                            <b><span class=" cont-text">Rupiah</span></b>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                </div>
                                <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                                <thead>
                                    <tr>
                                        <th class="text-center"> No </th>
                                        <th class="text-center"> Keterangan </th>
                                        <th class="text-center"> Jumlah </th>
                                    </tr>
                                    
                                </thead>
                                <tbody>
                                <% 
                                Payment_cmd.commandText = " SELECT MKT_T_InvoiceVendor_H.InvAP_custID, MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payBank, MKT_T_Payment_H.payType,  MKT_T_Payment_H.payDesc, MKT_T_Payment_D.pay_subtotal, MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_T_InvoiceVendor_D.InvAP_Line FROM MKT_T_Payment_D LEFT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_Payment_D.pay_Ref = MKT_T_InvoiceVendor_H.InvAPID RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID LEFT OUTER JOIN MKT_M_Customer ON MKT_T_InvoiceVendor_H.InvAP_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_InvoiceVendor_D1 RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_InvoiceVendor_D1.InvAP_DLine = MKT_T_InvoiceVendor_D.InvAP_Line ON MKT_T_InvoiceVendor_H.InvAPID = MKT_T_InvoiceVendor_D.InvAP_IDH WHERE MKT_T_Payment_H.payID = '"& payment("payID") &"' AND MKT_T_Payment_H.pay_custID = '"& Payment("custID") &"' GROUP BY MKT_T_InvoiceVendor_H.InvAP_custID, MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payBank, MKT_T_Payment_H.payType,  MKT_T_Payment_H.payDesc, MKT_T_Payment_D.pay_subtotal, MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_T_InvoiceVendor_D.InvAP_Line  "
                                'response.write Payment_cmd.commandText
                                set paymentdetail = Payment_cmd.execute
                            %>
                            <% 
                                no = 0 
                                do while not paymentdetail.eof
                                no = no + 1
                            %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td> <%=paymentdetail("payDesc")%> <b>[ <%=paymentdetail("InvAPID")%> - <%=CDate(paymentdetail("InvAP_Tanggal"))%> ]</b></td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(paymentdetail("pay_subtotal")),"$","Rp.  ")%> </td>
                                </tr>
                                <%
                                    subtotal = subtotal + paymentdetail("pay_subtotal")
                                %>
                                <% paymentdetail.movenext
                                loop%>
                                <tr>
                                    <th colspan="2" class="text-right"> Total </th>
                                    <td class="text-center"><%=Replace(FormatCurrency(subtotal),"$","Rp.  ")%><input type="hidden" name="subtotal" id="subtotal"  value="<%=subtotal%>"> </td>
                                </tr>
                            
                            </tbody>
                        </table>
                        </div>
                    </div>
                    <div class="row mt-1">
                <div class="col-2">
                    <span class="cont-text">Terbilang</span><br>
                </div>
                <div class="col-10 p-0" style="border-bottom: 1px dotted black;">
                    <input type="hidden" name="total" id="total" value="12584">
                    <span class="cont-text"> : </span>  &nbsp;&nbsp;  <b><span class="as-output-text cont-text"></span></b>
                    <b><span class=" cont-text">Rupiah</span></b>
                </div>
            </div>
            <div class="row text-center" style="margin-top:1rem">
                <div class="col-7">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                        <thead>
                            <tr>
                                <th class="text-center"> Direksi </th>
                                <th class="text-center"> Fiat Byr </th>
                                <th class="text-center"> Pembk. </th>
                                <th class="text-center"> Kabag </th>
                            </tr>
                            
                        </thead>
                        <tbody>
                            <td><br><br><br><br></td>
                            <td><br><br><br><br></td>
                            <td><br><br><br><br></td>
                            <td><br><br><br><br></td>
                        </tbody>
                    </table>
                </div>
                <div class="col-5">
                    <span   class="cont-text"> Tanggal, <%=Cdate(date())%> </span><br>
                    <span   class="cont-text"> Tanda Tangan Penerima</span><br><br><br><br>
                    <span   class="cont-text"> ...................</span><br><br><br><br>
                    
                </div>
            </div>
                <% else %>
                    <div class="row mt-3">
                        <div class="col-3">
                            <span class="cont-text">Dibayarkan Kepada</span><br>
                        </div>
                        <div class="col-9 p-0">
                            <span class="cont-text">:</span>&nbsp;&nbsp;<span class="cont-text"><%=payment("custNama")%></span><br>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-3">
                            <span class="cont-text">Rekening </span><br>
                        </div>
                        <div class="col-9 p-0">
                            <%
                                Rekening_cmd.commandText = "SELECT MKT_M_Rekening.rkBankID, GLB_M_Bank.BankName, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik FROM GLB_M_Bank RIGHT OUTER JOIN MKT_M_Rekening ON GLB_M_Bank.BankID = MKT_M_Rekening.rkBankID  Where rk_custID = '"& Payment("custID") &"'  "
                                'response.write Rekening_cmd.commandText
                                set Rekening = Rekening_cmd.execute
                            %>
                            <span class="cont-text">:</span>&nbsp;&nbsp;<span class="cont-text"><%=Rekening("BankName")%>&nbsp; <b> <%=Rekening("rkNomorRK")%> </b> <%=Rekening("rkNamaPemilik")%> </span><br>
                        </div>
                    </div>
                    <!--<div class="row mt-1">
                        <div class="col-3">
                            <span class="cont-text">Terbilang</span><br>
                        </div>
                        <div class="col-9 p-0">
                            <input type="hidden" name="total" id="total" value="">
                            <span class="cont-text">:</span>&nbsp;&nbsp;<b><span class="as-output-text cont-text"></span></b>
                            <b><span class=" cont-text">Rupiah</span></b>
                        </div>
                    </div>-->
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                </div>
                                <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                                <thead>
                                    <tr>
                                        <th class="text-center"> No </th>
                                        <th class="text-center"> Keterangan </th>
                                        <th class="text-center"> Jumlah </th>
                                    </tr>
                                    
                                </thead>
                                <tbody>
                                <% 
                                Payment_cmd.commandText = " SELECT MKT_T_InvoiceVendor_H.InvAP_custID, MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payBank, MKT_T_Payment_H.payType,  MKT_T_Payment_H.payDesc, MKT_T_Payment_D.pay_subtotal, MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_T_InvoiceVendor_D.InvAP_Line FROM MKT_T_Payment_D LEFT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_Payment_D.pay_Ref = MKT_T_InvoiceVendor_H.InvAPID RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID LEFT OUTER JOIN MKT_M_Customer ON MKT_T_InvoiceVendor_H.InvAP_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_InvoiceVendor_D1 RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_InvoiceVendor_D1.InvAP_DLine = MKT_T_InvoiceVendor_D.InvAP_Line ON MKT_T_InvoiceVendor_H.InvAPID = MKT_T_InvoiceVendor_D.InvAP_IDH WHERE MKT_T_Payment_H.payID = '"& payment("payID") &"' AND MKT_T_Payment_H.pay_custID = '"& Payment("custID") &"' GROUP BY MKT_T_InvoiceVendor_H.InvAP_custID, MKT_M_Customer.custNama, MKT_T_InvoiceVendor_H.InvAPID, MKT_T_Payment_H.payID, MKT_T_Payment_H.payTanggal, MKT_T_Payment_H.payBank, MKT_T_Payment_H.payType,  MKT_T_Payment_H.payDesc, MKT_T_Payment_D.pay_subtotal, MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_T_InvoiceVendor_D.InvAP_Line  "
                                'response.write Payment_cmd.commandText
                                set paymentdetail = Payment_cmd.execute
                            %>
                            <% 
                                no = 0 
                                do while not paymentdetail.eof
                                no = no + 1
                            %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td> Pembayaran INV-AP <b>[ <%=paymentdetail("InvAPID")%> - <%=paymentdetail("InvAP_Tanggal")%> ]</b></td>
                                    <td class="text-center"> <%=Replace(FormatCurrency(paymentdetail("pay_subtotal")),"$","Rp.  ")%> </td>
                                </tr>
                                <%
                                    subtotal = subtotal + paymentdetail("pay_subtotal")
                                %>
                                <% paymentdetail.movenext
                                loop%>
                                <tr>
                                    <th colspan="2" class="text-right"> Total </th>
                                    <td class="text-center"><%=Replace(FormatCurrency(subtotal),"$","Rp.  ")%><input type="hidden" name="subtotal" id="subtotal"  value="<%=subtotal%>"> </td>
                                </tr>
                            
                            </tbody>
                        </table>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-2">
                            <span class="cont-text">Terbilang</span><br>
                        </div>
                        <div class="col-10 p-0" style="border-bottom: 1px dotted black;">
                            <input type="hidden" name="total" id="total" value="12584">
                            <span class="cont-text"> : </span>  &nbsp;&nbsp;  <b><span class="as-output-text cont-text"></span></b>
                            <b><span class=" cont-text">Rupiah</span></b>
                        </div>
                    </div>
                    <div class="row " style="margin-top:1rem">
                        <div class="col-12">
                            <span class="cont-text"> Catatan </span> <br>
                            <span class="cont-text"> Lampirkan Bukti Transfer Pembayaran </span>
                        </div>
                    </div>
                <% end if %>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>