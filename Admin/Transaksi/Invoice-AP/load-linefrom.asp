<!--#include file="../../../connections/pigoConn.asp"-->
<%  
    InvAPID       = request.queryString("InvAPID")

    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING
    
    InvoiceVendor_CMD.commandText = "Select * From MKT_T_InvoiceVendor_H Where InvAPID = '"& InvAPID &"' "
    'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
    set InvoiceVendorH = InvoiceVendor_CMD.execute

    InvoiceVendor_CMD.commandText = "Select * From MKT_T_InvoiceVendor_D Where InvAP_IDH = '"& InvAPID &"' "
    'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
    set InvoiceVendorD1 = InvoiceVendor_CMD.execute

%>
<div class="judul-Pdbaru mt-2">
    <div class="row align-items-center">
        <div class="col-lg-6 col-md-6 col-sm-6">
            <input readonly type="hidden" class=" text-center cont-form" name="InvAPID" id="InvAPID" value="<%=InvAPID%>" >
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6">
            <input readonly type="hidden" class=" text-center cont-form" name="InvAP_Line" id="InvAP_LineFrom" value="<%=InvoiceVendorD1("InvAP_Line")%>">
        </div>
    </div>
    <div class="row cont-Lines">
        <div class="col-lg-6 col-md-12 col-sm-12">
            <span class="cont-text"> Keterangan </span><br>
            <input required type="text" class="  cont-form" name="InvAP_Keterangan" id="InvAP_Keterangan" value="<%=InvoiceVendorH("InvAP_Desc")%>" ><br>
        </div>
        <div class="col-lg-2 col-md-4 col-sm-4">
            <span class="cont-text"> Jumlah </span><br>
            <input onkeyup="total()" required type="text" class=" text-center cont-form" name="Jumlah" id="Jumlah" value="0" >
            <input readonly type="hidden" class=" text-center cont-form" name="InvAP_Jumlah" id="InvAP_Jumlah" value="" ><br>
        </div>
        <div class="col-lg-2 col-md-4 col-sm-4">
            <span class="cont-text"> Tax </span><br>
            <input required type="hidden" class=" cont-form" name="InvAP_Tax" id="InvAP_Tax" value="" >
            <select onchange="tax()"  class=" cont-form" name="ppn" id="ppn" aria-label="Default select example" required>
                <option value="">Tax (PPN)</option>
                <option value="0">Tanpa TAX (PPN)</option>
                <option value="11">PPN 2022 ( 11% )</option>
            </select>
        </div>
        <div class="col-lg-2 col-md-4 col-sm-4">
            <span class="cont-text"> Total Line </span><br>
            <input readonly type="text" class=" text-center cont-form" name="total" id="total" value="" ><br>
            <input readonly type="hidden" class=" text-center cont-form" name="InvAP_TotalLine" id="InvAP_TotalLine" value="" ><br>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 text-end">
            <button onclick="addInvoiceD()" class="cont-btn" > Tambah Invoice </button>
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
        var InvAP_Tax           = $('input[name=InvAP_Tax]').val();
        var InvAP_TotalLine     = $('input[name=InvAP_TotalLine]').val();
        if (InvAP_Jumlah == ""){
            $('#Jumlah').focus();
        }else if (InvAP_Tax == ""){
            $('#ppn').focus();
        }else{
            $.ajax({
                type: "GET",
                url: "add-InvoiceD.asp",
                data:{
                    InvAP_IDH,
                    InvAP_LineFrom,
                    InvAP_poID,
                    InvAP_Keterangan,
                    InvAP_Jumlah,
                    InvAP_Tax,
                    InvAP_TotalLine
                },
                success: function (data) {
                    $('.cont-InvoiceDetail').html(data);
                }
            });

            document.getElementById("Jumlah").value = "";
            document.getElementById("total").value = "";
            document.getElementById("ppn").value = "";
            document.getElementById("add").style.display = "none"
        }
    }
    
    
</script>