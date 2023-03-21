<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    payRef = request.queryString("payRef")
    custID = request.queryString("custID")
    payType = request.queryString("payType")

    set Invoice_cmd = server.createObject("ADODB.COMMAND")
	Invoice_cmd.activeConnection = MM_PIGO_String

    Invoice_cmd.commandText = "SELECT MKT_T_Payment_D.pay_Ref AS PayRef, MKT_T_Payment_D.pay_Total, MKT_T_Payment_D.pay_Dibayar, MKT_T_Payment_D.pay_Sisa  AS TotalLine, MKT_T_Payment_H.payID, MKT_T_Payment_D.pay_Tipe FROM MKT_T_Payment_D LEFT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID WHERE MKT_T_Payment_D.pay_Ref = '"& payRef &"'  GROUP BY  MKT_T_Payment_D.pay_Ref, MKT_T_Payment_D.pay_Total, MKT_T_Payment_D.pay_Dibayar, MKT_T_Payment_D.pay_Sisa, MKT_T_Payment_H.payID, MKT_T_Payment_D.pay_Tipe"
    'response.write Invoice_cmd.commandText
    set Invoice = Invoice_cmd.execute

    if Invoice.eof = true then
        if payType = "01" then 
            Invoice_cmd.commandText = "SELECT MKT_T_InvoiceVendor_H.InvAPID AS PayRef , MKT_T_InvoiceVendor_H.InvAP_Tanggal, MKT_T_InvoiceVendor_D1.InvAP_TotalLine AS TotalLine, MKT_T_InvoiceVendor_D1.InvAP_Jumlah, MKT_T_InvoiceVendor_D1.InvAP_Tax FROM MKT_T_InvoiceVendor_D LEFT OUTER JOIN MKT_T_InvoiceVendor_D1 ON MKT_T_InvoiceVendor_D.InvAP_Line = MKT_T_InvoiceVendor_D1.InvAP_DLine RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID Where MKT_T_InvoiceVendor_H.InvAPID = '"& payRef &"' and MKT_T_InvoiceVendor_H.InvAP_custID = '"& custID &"'  "
            'response.write Invoice_cmd.commandText
            set Invoice = Invoice_cmd.execute
        else
            Invoice_cmd.commandText = "SELECT InvARID AS PayRef , InvARTanggal, Round(InvARTotalLine,0) AS TotalLine FROM MKT_T_Faktur_Penjualan where InvARID = '"& payRef &"' AND InvAR_custID = '"& custID &"' AND InvAR_PayYN = 'N' OR InvAR_PayYN = 'S' AND InvAR_Status = 'Y'  "
            'response.write Invoice_cmd.commandText
            set Invoice = Invoice_cmd.execute
        end if
    else
        payType = Invoice("pay_Tipe")
    end if 
%>
<input type="hidden" class=" mb-2 cont-form" name="payRef" id="payRef" value="<%=payRef%>">
<input type="hidden" class=" mb-2 cont-form" name="custID" id="custID" value="<%=custID%>">
<% if payType = "01" then %>
<input type="hidden" class=" mb-2 cont-form" name="payTipe" id="payTipe" value="AP">
<% else %>
<input type="hidden" class=" mb-2 cont-form" name="payTipe" id="payTipe" value="AR">
<% end if %>
<div class="row">
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> Total Line </span><br>
        <input type="text" readonly class=" text-center mb-2 cont-form" name="linetotal" id="linetotal" value="<%=Replace(Replace(FormatCurrency(Invoice("TotalLine")),"$","Rp. "),".00","")%>"><br>
        <input type="hidden" class=" mb-2 cont-form" name="totalline" id="totalline" value="<%=Invoice("TotalLine")%>"><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> Total Yang Dibayarkan </span><br>
        <input onkeyup="subtotal()" type="text" class="text-center mb-2 cont-form" name="tdibayar" id="tdibayar" value="">
        <input type="hidden" class="text-center mb-2 cont-form" name="dibayar" id="dibayar" value="">
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> Sisa Pembayaran </span><br>
        <input type="hidden" readonly class="text-center mb-2 cont-form" name="sisa" id="sisa" value="">
        <input type="text" readonly class="text-center mb-2 cont-form" name="tsisa" id="tsisa" value="">    
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> Grand Total </span><br>
        <input type="hidden" readonly class="text-center mb-2 cont-form" name="grandtotal" id="grandtotal" value="">
        <input type="text" readonly class="text-center mb-2 cont-form" name="tgrandtotal" id="tgrandtotal" value="">
    </div>
</div>
<div class="row text-center mt-1 mb-1">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <button onclick="addpay()"  class="cont-btn"><i class="fas fa-plus"></i>&nbsp; Tambah Pembayaran </button>
    </div>
</div>
<div class="cont-datapayment">

</div>


<script>
    function subtotal(){
        var total = document.getElementById("totalline").value;
        var dibayar = document.getElementById("tdibayar").value;
        var totalsisa = total-dibayar;
        document.getElementById("dibayar").value = dibayar;
        document.getElementById("sisa").value = totalsisa;
        document.getElementById("tsisa").value = totalsisa;
        document.getElementById("grandtotal").value = dibayar;
        document.getElementById("tgrandtotal").value = dibayar;

            var subtotal = document.getElementById('tgrandtotal');
            subtotal.addEventListener('blur', function(e)
            {
                subtotal.value = formatRupiah(this.value, 'Rp. ');
            });

            var totaldibayar = document.getElementById('tdibayar');
            totaldibayar.addEventListener('blur', function(e)
            {
                totaldibayar.value = formatRupiah(this.value, 'Rp. ');
            });

            var totalsisa = document.getElementById('tsisa');
            totalsisa.addEventListener('blur', function(e)
            {
                totalsisa.value = formatRupiah(this.value, 'Rp. ');
            });

        };
        document.addEventListener("DOMContentLoaded", function(event) {
            subtotal();
        });
    function addpay() {
        var payID           = $('input[name=payID]').val();
        var payTanggal      = $('input[name=payTanggal]').val();
        var pay_custID      = $('input[name=custID]').val();
        var pay_Ref         = $('input[name=payRef]').val();
        var pay_Tipe         = $('input[name=payTipe]').val();
        var pay_Total       = $('input[name=totalline]').val();
        var pay_Dibayar     = $('input[name=dibayar]').val();
        var pay_Sisa        = $('input[name=sisa]').val();
        var pay_Tax         = $('select[name=ppn]').val();
        var pay_Subtotal    = $('input[name=grandtotal]').val();
        console.log(pay_Tipe);
        $.ajax({
            type: "GET",
            url: "add-paymentdetail.asp",
            data:{
                payID,
                payTanggal,
                pay_custID,
                pay_Ref,
                pay_Tipe,
                pay_Total,
                pay_Dibayar,
                pay_Sisa,
                pay_Tax,
                pay_Subtotal
            },
            success: function (data) {      
                console.log(data);
                    $('.cont-datapayment').html(data);
            }
        });
    }
    /* Dengan Rupiah */
	
	
        /* Fungsi */
        function formatRupiah(angka, prefix)
        {
            var number_string = angka.replace(/[^,\d]/g, '').toString(),
                split	= number_string.split(','),
                sisa 	= split[0].length % 3,
                rupiah 	= split[0].substr(0, sisa),
                ribuan 	= split[0].substr(sisa).match(/\d{3}/gi);
                
            if (ribuan) {
                separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');
            }
            
            rupiah = split[1] != undefined ? rupiah + ',' + split[1] : rupiah;
            return prefix == undefined ? rupiah : (rupiah ? 'Rp. ' + rupiah : '');
        }
</script>