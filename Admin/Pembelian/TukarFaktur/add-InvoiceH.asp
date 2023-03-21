<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    InvAP_Tanggal       = request.queryString("InvAP_Tanggal")
    InvAP_Faktur        = request.queryString("InvAP_Faktur")
    InvAP_TglFaktur     = request.queryString("InvAP_TglFaktur")
    InvAP_Desc          = request.queryString("InvAP_Desc")
    InvAP_GrandTotal    = request.queryString("InvAP_GrandTotal")
    InvAP_custID        = request.queryString("InvAP_custID")
    InvAP_LineFrom       = request.queryString("InvAP_LineFrom")
    falg                = request.queryString("falg")
    InvAP_UpdateID      = request.queryString("InvAP_UpdateID")
        
    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING
    InvoiceVendor_CMD.commandText = "exec sp_add_MKT_T_InvoiceVendor '"& InvAP_Tanggal &"','"& InvAP_Faktur &"','"& InvAP_TglFaktur &"','"& InvAP_Desc &"',0,'"& InvAP_custID &"','"& session("username")&"' "
    set InvoiceVendor = InvoiceVendor_CMD.execute

    InvoiceVendor_CMD.commandText = "UPDATE MKT_T_TukarFaktur_H set TF_prYN = 'Y' WHERE MKT_T_TukarFaktur_H.TF_ID = '"& InvAP_LineFrom &"'  "
    set UpdateTF = InvoiceVendor_CMD.execute

    if InvAP_LineFrom = "0" then
    
    InvoiceVendor_CMD.commandText = "INSERT INTO [dbo].[MKT_T_InvoiceVendor_D]([InvAP_IDH],[InvAP_Line],[InvAP_Ket])VALUES('"& InvoiceVendor("id") &"','"& InvoiceVendor("id") &"','SL') "
    set InvoiceVendorD = InvoiceVendor_CMD.execute

    Response.redirect "load-linefrom.asp?InvAPID=" & trim(InvoiceVendor("id"))

    else 

    InvoiceVendor_CMD.commandText = "INSERT INTO [dbo].[MKT_T_InvoiceVendor_D]([InvAP_IDH],[InvAP_Line],[InvAP_Ket])VALUES('"& InvoiceVendor("id") &"','"& InvAP_LineFrom &"','TF') "
    set InvoiceVendorD = InvoiceVendor_CMD.execute

    end if 
    

    InvoiceVendor_CMD.commandText = "Select * From MKT_T_InvoiceVendor_H Where InvAPID = '"& InvoiceVendor("id") &"' "
    set InvoiceVendorH = InvoiceVendor_CMD.execute

    InvoiceVendor_CMD.commandText = "Select * From MKT_T_InvoiceVendor_D Where InvAP_IDH = '"& InvoiceVendor("id") &"' "
    set InvoiceVendorD1 = InvoiceVendor_CMD.execute

    set TukarFaktur_CMD = server.createObject("ADODB.COMMAND")
	TukarFaktur_CMD.activeConnection = MM_PIGO_String
    TukarFaktur_CMD.commandText = "SELECT MKT_T_TukarFaktur_D1.TFD1_poID FROM MKT_T_InvoiceVendor_H LEFT OUTER JOIN MKT_T_TukarFaktur_D1 RIGHT OUTER JOIN MKT_T_TukarFaktur_H RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_TukarFaktur_H.TF_ID = MKT_T_InvoiceVendor_D.InvAP_Line LEFT OUTER JOIN MKT_T_TukarFaktur_D ON MKT_T_TukarFaktur_H.TF_ID = LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) ON LEFT(MKT_T_TukarFaktur_D1.TFD1_ID,20) = MKT_T_TukarFaktur_D.TFD_ID ON  MKT_T_InvoiceVendor_H.InvAPID = MKT_T_InvoiceVendor_D.InvAP_IDH WHERE MKT_T_InvoiceVendor_D.InvAP_Line = '"& InvoiceVendorD1("InvAP_Line") &"' GROUP BY  MKT_T_TukarFaktur_D1.TFD1_poID "
    set PO = TukarFaktur_CMD.execute

    do while not PO.eof
    InvAP_Tanggal       = request.queryString("InvAP_Tanggal")
    'response.write  InvAP_Tanggal

        TukarFaktur_CMD.commandText = "SELECT DATEADD(day, MKT_M_Customer.custPaymentTerm, MKT_T_InvoiceVendor_H.InvAP_Tanggal) AS DateAdd FROM MKT_T_InvoiceVendor_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_InvoiceVendor_H.InvAP_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_TukarFaktur_D1 RIGHT OUTER JOIN MKT_T_TukarFaktur_H RIGHT OUTER JOIN MKT_T_InvoiceVendor_D ON MKT_T_TukarFaktur_H.TF_ID = MKT_T_InvoiceVendor_D.InvAP_Line LEFT OUTER JOIN MKT_T_TukarFaktur_D ON MKT_T_TukarFaktur_H.TF_ID = LEFT(MKT_T_TukarFaktur_D.TFD_ID, 16) ON LEFT(MKT_T_TukarFaktur_D1.TFD1_ID, 20) = MKT_T_TukarFaktur_D.TFD_ID ON  MKT_T_InvoiceVendor_H.InvAPID = MKT_T_InvoiceVendor_D.InvAP_IDH WHERE (MKT_T_InvoiceVendor_D.InvAP_Line = '"& InvoiceVendorD1("InvAP_Line") &"')  GROUP BY MKT_M_Customer.custPaymentTerm, MKT_T_InvoiceVendor_H.InvAP_Tanggal"
        set JatuhTempo = TukarFaktur_CMD.execute

        TukarFaktur_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_H SET po_InvAP_Tanggal = '"& InvAP_Tanggal &"', po_JatuhTempo = '"& JatuhTempo("DateAdd") &"' WHERE poID = '"& PO("TFD1_poID") &"' "
        set UpdatePO = TukarFaktur_CMD.execute

    PO.movenext
    loop

	TukarFaktur_CMD.activeConnection = MM_PIGO_String
    TukarFaktur_CMD.commandText = "SELECT  SUM(MKT_T_TukarFaktur_D.TF_TFTotal) AS  TF_TFTotal FROM MKT_T_TukarFaktur_D RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) = MKT_T_TukarFaktur_H.TF_ID WHERE (LEFT(MKT_T_TukarFaktur_D.TFD_ID,16) = '"& InvoiceVendorD1("InvAP_Line") &"') "
    'Response.Write TukarFaktur_CMD.commandText & "<br>"
    set TukarFaktur = TukarFaktur_CMD.execute

%>
<div class="judul-Pdbaru mt-1" id="judul-Pdbaru">
    <div class="row align-items-center">
        <div class="col-lg-6 col-md-6 col-sm-12">
            <span class="cont-text"> Invoice </span><br>
            <input readonly type="text" class=" text-center cont-form" name="InvAPID" id="InvAPID" value="<%=InvoiceVendor("id")%>" ><br>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-12">
            <span class="cont-text"> Line From </span><br>
            <input readonly type="text" class=" text-center cont-form" name="InvAP_Line" id="InvAP_LineFrom" value="<%=InvoiceVendorD1("InvAP_Line")%>"><br>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-12">
            <span class="cont-text"> Keterangan </span><br>
            <input readonly type="text" class="cont-form" name="InvAP_Keterangan" id="InvAP_Keterangan" value="<%=InvAP_Desc%>(<%=InvoiceVendorD1("InvAP_Line")%>)"><br>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-4">
            <span class="cont-text"> Jumlah </span><br>
            <input readonly type="text" class=" text-center cont-form" name="Jumlah" id="Jumlah" value="<%=Replace(Replace(FormatCurrency(TukarFaktur("TF_TFTotal")),"$","Rp. "),".00","")%>" >
            <input readonly type="hidden" class=" text-center cont-form" name="InvAP_Jumlah" id="InvAP_Jumlah" value="<%=TukarFaktur("TF_TFTotal")%>" ><br>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-4">
            <span class="cont-text"> Total Line </span><br>
            <input readonly type="text" class=" text-center cont-form" name="total" id="total" value="<%=Replace(Replace(FormatCurrency(TukarFaktur("TF_TFTotal")),"$","Rp. "),".00","")%>" >
            <input readonly type="hidden" class=" text-center cont-form" name="InvAP_TotalLine" id="InvAP_TotalLine" value="<%=TukarFaktur("TF_TFTotal")%>" ><br>
        </div>
    </div>
    <div class="row mt-3 mb-3">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <button onclick="addInvoiceD()" class="cont-btn" id="TambahInvoice"> Tambah Invoice </button>
        </div>
    </div>
</div>
<div class="cont-InvoiceDetail" id="cont-InvoiceDetail">
    
</div>

<script>
    function tax(){
        var tax = document.getElementById("ppn").value;
        var Jumlah = parseInt(document.getElementById("InvAP_Jumlah").value);
        //console.log(tax);
            
        if( tax == "0" ){
            var total = Jumlah;
            document.getElementById("InvAP_Tax").value = 0;
            document.getElementById("InvAP_TotalLine").value = total;
            document.getElementById("total").value = total;
            // console.log(total);
                
        }else{
            tax = 11;
            var total = Jumlah;
            var pajak = tax/100*total;
            var subtotal = total+pajak;
            var grandtotal = Math.round(subtotal);
            document.getElementById("InvAP_Tax").value = pajak;
            document.getElementById("total").value = grandtotal;
            document.getElementById("InvAP_TotalLine").value = grandtotal;
            // console.log(subtotal);
                
        }
        var Total = document.getElementById('total');
        Total.addEventListener('focus', function(e)
        {
            Total.value = formatRupiah(this.value, 'Rp. ');
        });
    }

    function batal() {
        var InvAPID = $('input[name=InvAPID]').val();
        console.log(InvAPID);
        $.ajax({
            type: "GET",
            url: "../../Transaksi/Invoice-AP/delete-InvoiceH.asp",
                data:{
                    InvAPID
                },
            success: function (data) {
                console.log(data);
                Swal.fire('Data Berhasil Di Hapus !', data.message, 'success').then(() => {
                    location.reload();
                });
            }
        });
    }

    /* Dengan Rupiah */
	var Jumlah = document.getElementById('Jumlah');
	Jumlah.addEventListener('blur', function(e)
	{
		Jumlah.value = formatRupiah(this.value, 'Rp. ');
	});
	
	
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

    function total(){
        var Jumlah = document.getElementById("Jumlah").value;
        document.getElementById("InvAP_Jumlah").value = Jumlah;
    };

    function addInvoiceD() {
        var InvAP_IDH           = $('input[name=InvAPID]').val();
        var InvAP_LineFrom      = $('input[name=InvAP_Line]').val();
        var InvAP_poID           = $('select[name=listpo]').val();
        var InvAP_Keterangan    = $('input[name=InvAP_Keterangan]').val();
        var InvAP_Jumlah        = $('input[name=InvAP_Jumlah]').val();
        var InvAP_TotalLine     = $('input[name=InvAP_TotalLine]').val();
        
        $.ajax({
            type: "GET",
            url: "add-InvoiceD.asp",
            data:{
                InvAP_IDH,
                InvAP_LineFrom,
                InvAP_poID,
                InvAP_Keterangan,
                InvAP_Jumlah,
                InvAP_TotalLine
            },
            success: function (data) {
                $('#TambahInvoice').hide();
                $('#judul-Pdbaru').hide();
                $('.cont-InvoiceDetail').html(data);
            }
        });

        document.getElementById("Jumlah").value = "";
        document.getElementById("total").value = "";
        document.getElementById("add").style.display = "none"
    }
    
    
</script>