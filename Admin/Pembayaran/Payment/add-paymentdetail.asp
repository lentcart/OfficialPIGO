<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    payID           = request.queryString("payID")
    payTanggal      = request.queryString("payTanggal")
    pay_custID      = request.queryString("pay_custID")
    pay_Ref         = request.queryString("pay_Ref")
    pay_Tipe        = request.queryString("pay_Tipe")
    pay_Total       = request.queryString("pay_Total")
    pay_Dibayar     = request.queryString("pay_Dibayar")
    pay_Sisa        = request.queryString("pay_Sisa")
    pay_Tax         = request.queryString("pay_Tax")
    pay_Subtotal    = request.queryString("pay_Subtotal")

    set Payment_D_CMD = server.CreateObject("ADODB.command")
    Payment_D_CMD.activeConnection = MM_pigo_STRING
    set PaymentBank_CMD = server.CreateObject("ADODB.command")
    PaymentBank_CMD.activeConnection = MM_pigo_STRING

    Payment_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Payment_D]([payID_H],[pay_Ref],[pay_Tipe],[pay_Total],[pay_Dibayar],[pay_Sisa],[pay_Tax],[pay_Subtotal],[payDUpdateTime],[payDAktifYN])VALUES('"& payID &"','"& pay_Ref &"','"& pay_Tipe &"','"& pay_Total &"','"& pay_Dibayar &"','"& pay_Sisa &"','"& pay_Tax &"','"& pay_Subtotal &"','"& now() &"','Y')"
    'response.write Payment_D_CMD.commandText & "<br><br>"
    set Payment_D = Payment_D_CMD.execute

    if pay_Tipe = "AP" then
        Payment_D_CMD.commandText = "UPDATE MKT_T_InvoiceVendor_H SET InvAP_prYN = 'Y' WHERE InvAPID  = '"& pay_Ref &"' "
        'response.write Payment_D_CMD.commandText & "<br><br>"
        set UpdatePayment = Payment_D_CMD.execute
        
        PaymentBank_CMD.commandText = "SELECT MKT_T_TukarFaktur_D1.TFD1_poID FROM MKT_T_TukarFaktur_D LEFT OUTER JOIN MKT_T_TukarFaktur_D1 ON MKT_T_TukarFaktur_D.TFD_ID = LEFT(MKT_T_TukarFaktur_D1.TFD1_ID,20) RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) = MKT_T_TukarFaktur_H.TF_ID RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_TukarFaktur_H.TF_ID = MKT_T_InvoiceVendor_D.InvAP_Line RIGHT OUTER JOIN MKT_T_InvoiceVendor_H ON MKT_T_InvoiceVendor_D.InvAP_IDH = MKT_T_InvoiceVendor_H.InvAPID WHERE InvAPID  = '"& pay_Ref &"' "
        'response.write PaymentBank_CMD.commandText & "<br><br>"
        set PO = PaymentBank_CMD.execute
            do while not PO.eof
                a = PO("TFD1_poID")
                PaymentBank_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_H set po_payID = '"& payID &"', po_payYN = 'Y',  po_payTanggal = '"& payTanggal &"' WHERE poID = '"& PO("TFD1_poID") &"' "
                'response.write PaymentBank_CMD.commandText& "<br><br>"
                set UpdatePO = PaymentBank_CMD.execute
            PO.movenext
            loop
    else
        IF pay_Sisa = "0" then 
            PaymentBank_CMD.commandText = "UPDATE MKT_T_Faktur_Penjualan SET InvAR_PayYN = 'Y'  WHERE InvARID = '"& pay_Ref &"' "
            'response.write PaymentBank_CMD.commandText & "<br><br>"
            set UpdatePayment = PaymentBank_CMD.execute
            PaymentBank_CMD.commandText = "SELECT MKT_T_PengeluaranSC_H.psc_permID FROM MKT_T_Faktur_Penjualan LEFT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_Faktur_Penjualan.InvAR_pscID = MKT_T_PengeluaranSC_H.pscID Where MKT_T_Faktur_Penjualan.InvARID = '"& pay_Ref &"' "
            'response.write PaymentBank_CMD.commandText & "<br><br>"
            set PERM = PaymentBank_CMD.execute
                do while not PERM.eof
                    a = PERM("psc_permID")
                    PaymentBank_CMD.commandText = "UPDATE MKT_T_Permintaan_Barang_H set Perm_stID = '03' , Perm_spID = '05' WHERE PermID = '"& PERM("psc_permID") &"'  "
                    'response.write PaymentBank_CMD.commandText& "<br><br>"
                    set UpdatePERM = PaymentBank_CMD.execute
                PERM.movenext
                loop
        Else
            PaymentBank_CMD.commandText = "UPDATE MKT_T_Faktur_Penjualan SET InvAR_PayYN = 'S'  WHERE InvARID = '"& pay_Ref &"' "
            'response.write PaymentBank_CMD.commandText & "<br><br>"
            set UpdatePayment = PaymentBank_CMD.execute
            PaymentBank_CMD.commandText = "SELECT MKT_T_PengeluaranSC_H.psc_permID FROM MKT_T_Faktur_Penjualan LEFT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_Faktur_Penjualan.InvAR_pscID = MKT_T_PengeluaranSC_H.pscID Where MKT_T_Faktur_Penjualan.InvARID = '"& pay_Ref &"' "
            'response.write PaymentBank_CMD.commandText & "<br><br>"
            set PERM = PaymentBank_CMD.execute
                do while not PERM.eof
                    a = PERM("psc_permID")
                    PaymentBank_CMD.commandText = "UPDATE MKT_T_Permintaan_Barang_H set Perm_stID = '03' , Perm_spID = '03' WHERE PermID = '"& PERM("psc_permID") &"'  "
                    'response.write PaymentBank_CMD.commandText& "<br><br>"
                    set UpdatePERM = PaymentBank_CMD.execute
                PERM.movenext
                loop
        end if 
    end if 

    set UpPayment_CMD = server.CreateObject("ADODB.command")
    UpPayment_CMD.activeConnection = MM_pigo_STRING
    UpPayment_CMD.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pay_Ref) AS NO, MKT_T_Payment_H.payDesc,MKT_T_Payment_D.pay_Ref, MKT_T_Payment_D.pay_Tipe, MKT_T_Payment_D.pay_Total, MKT_T_Payment_D.pay_Dibayar, MKT_T_Payment_D.pay_Subtotal, MKT_T_Payment_H.payID,  MKT_T_Payment_H.payTanggal FROM MKT_T_Payment_D RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID WHERE MKT_T_Payment_H.payID = '"& payID &"' "
    'response.write UpPayment_CMD.commandText
    set UpPayment = UpPayment_CMD.execute

    
%>
<div class="row">
    <div class="col-12">
        <table class="table cont-tb tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
            <thead>
                <tr>
                    <th class="text-center"> NO </th>
                    <th class="text-center"> KETERANGAN </th>
                    <th class="text-center"> JUMLAH PEMBAYARAN </th>
                    <th class="text-center"> DECS POINT</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                <% do while not UpPayment.eof%>
                    <td class="text-center"> <%=UpPayment("NO")%> </td>
                    <td> <%=UpPayment("payDesc")%>/<%=UpPayment("pay_Ref")%> </td>
                    <td class="text-center"> <%=UpPayment("pay_subtotal")%> </td>
                    <td class="text-center"> <%=UpPayment("pay_Tipe")%> </td>
                    <%
                        subtotal = subtotal + UpPayment("pay_subtotal")
                    %>
                <%UpPayment.movenext
                loop%>
                </tr>
            <tbody>
        </table>
        <input type="hidden" name="payGrandTotal" id="payGrandTotal" value="<%=subtotal%>">
        <input type="hidden" name="payID" id="payID" value="<%=payID%>">
    </div>
</div>
<div class="row mt-4 mb-1">
    <div class="col-lg-2 col-md-4 col-sm-6 text-start">
        <div class="form-check">
            <input onchange="complete()" class="cont-text form-check-input" type="checkbox" value="" id="completepayment">
            <label class="cont-text form-check-label" for="flexCheckDefault">
                Selesai
            </label>
        </div>
    </div>
</div>
<div class="cont-payment-selesai" id="cont-payment-selesai" style="display:none">
    <div class="row mt-4 mb-1" >
        <div class="col-lg-2 col-md-4 col-sm-6 text-start">
            <button onclick="window.open('../PaymentDetail/','_Self')" class="cont-btn" ><i class="fas fa-arrow-to-left"></i> &nbsp;  Payment Detail </button>
        </div>
    </div>
</div>
<script>
    function complete(){
        var complete = document.getElementById("completepayment");
        if (!complete.checked){
            document.getElementById("cont-payment-selesai").style.display = "none" 
        }else{
            document.getElementById("cont-payment-selesai").style.display = "block" 
        }
    }
</script>