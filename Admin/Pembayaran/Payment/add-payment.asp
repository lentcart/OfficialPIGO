<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    payBank	        = request.queryString("payBank")
    payType	        = request.queryString("payType")
    payTanggal	    = request.queryString("payTanggal")
    payJenis	    = request.queryString("payJenis")
    payDesc	        = request.queryString("payDesc")
    pay_custID	    = request.queryString("pay_custID")
    pay_rkID        = request.queryString("pay_rkID")
    payNoRek        = request.queryString("payNoRek")
    payBank         = request.queryString("payBank")
    
    set Payment_H_CMD = server.CreateObject("ADODB.command")
    Payment_H_CMD.activeConnection = MM_pigo_STRING
    Payment_H_CMD.commandText = "exec sp_add_MKT_T_Payment '"& payBank &"','"& payType &"','"& payTanggal &"','"& payJenis &"','"& payDesc &"','N','','"& pay_custID &"','"& pay_rkID &"','"& payNoRek &"','"& payBank &"',2,''"
    'response.write Payment_H_CMD.commandText
    set Payment_H = Payment_H_CMD.execute

    if payType = "01" then 
    set Paymentrequest_CMD = server.CreateObject("ADODB.command")
    Paymentrequest_CMD.activeConnection = MM_pigo_STRING
    Paymentrequest_CMD.commandText = "SELECT InvAPID , InvAP_Tanggal FROM MKT_T_InvoiceVendor_H WHERE InvAP_custID = '"& pay_custID &"' and InvAP_prYN = 'N' "
    'response.write Paymentrequest_CMD.commandText
    set Paymentrequest = Paymentrequest_CMD.execute
    else
    set FakturPenjualan_CMD = server.CreateObject("ADODB.command")
    FakturPenjualan_CMD.activeConnection = MM_pigo_STRING
    FakturPenjualan_CMD.commandText = "SELECT InvARID , InvARTanggal, InvAR_Status FROM MKT_T_Faktur_Penjualan where InvAR_custID = '"& pay_custID &"' AND InvAR_PayYN = 'N' OR InvAR_PayYN = 'S'"
    'response.write FakturPenjualan_CMD.commandText
    set FakturPenjualan = FakturPenjualan_CMD.execute
    end if 
%>
<input type="hidden" name="payType" id="payType" value="<%=payType%>">
<input type="hidden" name="payID" id="payID" value="<%=Payment_H("id")%>">
<input type="hidden" name="payTanggal" id="payTanggal" value="<%=payTanggal%>">
<input type="hidden" name="custID" id="custID" value="<%=pay_custID%>">
<input type="hidden" name="paytanggal" id="paytanggal" value="<%=payTanggal%>">

<% if payType = "01" then  %>
<div class="row align-items-center">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <span class="cont-text"> Pilih Invoice AP </span><br>
        <select onchange="getinvoice()" class=" mb-2 cont-form" name="payRef" id="payRef" aria-label="Default select example">
            <option value="">Pilih</option>
            <% do while not PaymentRequest.eof %>
            <option value="<%=PaymentRequest("InvAPID")%>"><%=PaymentRequest("InvAPID")%> &nbsp; - &nbsp; <%=Day(CDate(PaymentRequest("InvAP_Tanggal")))%>/<%=MonthName(Month(PaymentRequest("InvAP_Tanggal")))%>/<%=Year(PaymentRequest("InvAP_Tanggal"))%></option>
            <% PaymentRequest.movenext
            loop %>
        </select>
    </div>
</div>
<% else %>
<div class="row align-items-center">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <span class="cont-text"> Pilih Invoice AR </span><br>
        <select onchange="getinvoice()" class=" mb-2 cont-form" name="payRef" id="payRef" aria-label="Default select example">
            <option value="">Pilih</option>
            <% do while not FakturPenjualan.eof %>
                <% if FakturPenjualan("InvAR_Status") = "N" then %>
                    <option value="0"><%=FakturPenjualan("InvARID")%> &nbsp; - &nbsp; INVOICE BELUM TUKAR FAKTUR </option>
                <% else %>
                    <option value="<%=FakturPenjualan("InvARID")%>"><%=FakturPenjualan("InvARID")%> &nbsp; - &nbsp; <%=Day(CDate(FakturPenjualan("InvARTanggal")))%>/<%=MonthName(Month(FakturPenjualan("InvARTanggal")))%>/<%=Year(FakturPenjualan("InvARTanggal"))%></option>
                <% end if %>
            <% FakturPenjualan.movenext
            loop %>
        </select>
    </div>
</div>
<% end if %>

<script>
    function getinvoice(){
        var payRef      = document.getElementById("payRef").value;
        var custID      = document.getElementById("custID").value;
        var payType    = document.getElementById("payType").value;
        if ( payRef == 0 ){
            alert("INVOICE BELUM TUKAR FAKTUR, SILAHKAN BATALKAN PROSES !");
        }else{
            $.ajax({
                type: "get",
                url: "get-invoice.asp",
                data:{
                    payRef,
                    custID,
                    payType
                },
                success: function (data) {
                    // console.log(data);
                    $('.data-payment').html(data);
                }
            });
        }
    }
    
</script>