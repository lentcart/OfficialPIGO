<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    
    payID = request.queryString("payID")
    pay_spID = request.queryString("pay_spID")
    pay_prID = request.queryString("pay_prID")
    pay_total = request.queryString("pay_total")
    pay_tax = request.queryString("pay_tax")
    pay_subtotal = request.queryString("pay_subtotal")

        set Payment_D_CMD = server.CreateObject("ADODB.command")
        Payment_D_CMD.activeConnection = MM_pigo_STRING
        Payment_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Payment_D]([payID_H],[pay_prID],[pay_total],[pay_tax],[pay_subtotal],[payDUpdateTime],[payDAktifYN]) VALUES ('"& payID &"','"& pay_prID &"','"& pay_total &"','"& pay_tax &"','"& pay_subtotal &"','"& now() &"','Y')"
        'response.write Payment_D_CMD.commandText
        set Payment_D = Payment_D_CMD.execute

        set UpdatePayment_CMD = server.CreateObject("ADODB.command")
        UpdatePayment_CMD.activeConnection = MM_pigo_STRING
        UpdatePayment_CMD.commandText = " Update MKT_T_PaymentRequest_H set pr_spayID = 2 where prID = '"& pay_prID &"' "
        'response.write UpdatePayment_CMD.commandText
        set UpdatePayment = UpdatePayment_CMD.execute

        set UpPayment_CMD = server.CreateObject("ADODB.command")
        UpPayment_CMD.activeConnection = MM_pigo_STRING
        UpPayment_CMD.commandText = " SELECT ROW_NUMBER() OVER(ORDER BY pay_prID) AS no, MKT_T_Payment_H.payDesc, MKT_T_Payment_D.pay_total, MKT_T_Payment_D.pay_tax, MKT_T_Payment_D.pay_subtotal, MKT_T_Payment_D.pay_prID, MKT_T_PaymentRequest_H.prID,  MKT_T_PaymentRequest_H.prTanggalInv FROM MKT_T_Payment_H LEFT OUTER JOIN MKT_T_PaymentRequest_H RIGHT OUTER JOIN MKT_T_Payment_D ON MKT_T_PaymentRequest_H.prID = MKT_T_Payment_D.pay_prID ON MKT_T_Payment_H.payID = MKT_T_Payment_D.payID_H WHERE MKT_T_Payment_H.payID = '"& payID &"' AND MKT_T_Payment_H.pay_spID = '"& pay_spID &"' group by MKT_T_Payment_H.payDesc, MKT_T_Payment_D.pay_total, MKT_T_Payment_D.pay_tax, MKT_T_Payment_D.pay_subtotal, MKT_T_Payment_D.pay_prID, MKT_T_PaymentRequest_H.prID,  MKT_T_PaymentRequest_H.prTanggalInv   "
        'response.write UpPayment_CMD.commandText
        set UpPayment = UpPayment_CMD.execute


%>
<div class="row">
    <div class="col-12">
        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
            <thead>
                <tr>
                    <th class="text-center"> No </th>
                    <th class="text-center"> Keterangan </th>
                    <th class="text-center"> Jumlah Pembayaran Invoice </th>
                    <th class="text-center"> Dec Point</th>
                </tr>
            </thead>
            <tbody>
            <tr>
                <% do while not UpPayment.eof%>
                    <td class="text-center"> <%=UpPayment("no")%> </td>
                    <td> <%=UpPayment("payDesc")%>/<%=UpPayment("prID")%>/<%=UpPayment("prTanggalInv")%> </td>
                    <td class="text-center"> <%=UpPayment("pay_subtotal")%> </td>
                    <td class="text-center"> - </td>
                <%UpPayment.movenext
                loop%>
            </tr>
            <tbody>
        </table>
    </div>
</div>
