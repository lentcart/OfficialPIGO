
<script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script>
        
        $(document).ready(function(){
            setInterval(LoadInvoice, 60000);
        })
            function LoadInvoice(){
                var status = "N";
                $.ajax({
                    type: 'GET',
                    contentType: "application/json",
                    url: '<%=base_url%>/Cart/Payment/CekTransaksi.asp',
                    data:{
                        status
                    },
                    traditional: true,
                    success: function (data) {
                        var string1 = JSON.stringify(data);
                        var parsed = JSON.parse(string1); 
                        for (var i = 0; i < parsed.length; i++) {
                            var counter         = parsed[i];
                            var TransaksiID     = counter.external_id;
                            var IDBooking       = counter.bookingid;
                            var StatusTransaksi = counter.statustransaksi;
                            if ( StatusTransaksi == "Y" ){
                                LoadInvoice();
                            }else{
                                $.ajax({
                                    type: 'GET',
                                    contentType: "application/json",
                                    url: '<%=base_url%>/Cart/Payment/Get-Invoice.asp',
                                    data:{
                                        external_id : TransaksiID
                                    },
                                    traditional: true,
                                    success: function (data) {
                                        var jsonData = JSON.parse(data);
                                        for (var i = 0; i < jsonData.length; i++) {
                                        var counter   = jsonData[i];
                                        var JenisPay  = counter.payment_method
                                        var BankCode  = counter.bank_code;
                                        var PayStatus = counter.status;
                                        var PaidAt    = counter.paid_at;
                                            if ( PayStatus == "SETTLED" ){
                                                $.ajax({
                                                    type: 'GET',
                                                    contentType: "application/json",
                                                    url: '<%=base_url%>/Cart/Payment/Create-IDBooking.asp',
                                                    data:{
                                                        external_id : TransaksiID
                                                    },
                                                    traditional: true,
                                                    success: function (data) {
                                                        console.log(data);
                                                        var Booking = JSON.parse(data)
                                                        var BookingID = Booking['BOOKING ID']
                                                        $.ajax({
                                                            type: 'GET',
                                                            contentType: "application/json",
                                                            url: '<%=base_url%>/Cart/Payment/Update-Transaksi.asp',
                                                            data:{
                                                                external_id : TransaksiID, 
                                                                JenisPay,
                                                                BankCode,
                                                                PayStatus,
                                                                PaidAt,
                                                                BookingID
                                                            },
                                                            traditional: true,
                                                            success: function (data) {
                                                                console.log(data);
                                                            }
                                                        });
                                                    }
                                                });
                                            }else if ( PayStatus == "EXPIRED") {
                                                var BookingID = "-"
                                                $.ajax({
                                                    type: 'GET',
                                                    contentType: "application/json",
                                                    url: '<%=base_url%>/Cart/Payment/Update-Transaksi.asp',
                                                    data:{
                                                        external_id : TransaksiID, 
                                                        JenisPay,
                                                        BankCode,
                                                        PayStatus,
                                                        PaidAt,
                                                        BookingID
                                                    },
                                                    traditional: true,
                                                    success: function (data) {
                                                        console.log(data);
                                                    }
                                                });
                                            }else{
                                                
                                            }
                                        }
                                    }
                                });
                            }
                        }
                    }   
                });
            };
        </script> 
