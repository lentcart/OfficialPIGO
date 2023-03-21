<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    InvAP_Tanggal       = request.queryString("InvAP_Tanggal")
    InvAP_Faktur        = request.queryString("InvAP_Faktur")
    InvAP_TglFaktur     = request.queryString("InvAP_TglFaktur")
    InvAP_Desc          = request.queryString("InvAP_Desc")
    InvAP_GrandTotal    = request.queryString("InvAP_GrandTotal")
    InvAP_custID        = request.queryString("InvAP_custID")
    InvAP_LineFrom      = request.queryString("InvAP_LineFrom")
    falg                = request.queryString("flag")
    InvAP_UpdateID      = request.queryString("InvAP_UpdateID")
    
    set InvoiceVendor_CMD = server.CreateObject("ADODB.command")
    InvoiceVendor_CMD.activeConnection = MM_pigo_STRING
    InvoiceVendor_CMD.commandText = "exec sp_add_MKT_T_InvoiceVendor '"& InvAP_Tanggal &"','"& InvAP_Faktur &"','"& InvAP_TglFaktur &"','"& InvAP_Desc &"',0,'"& InvAP_custID &"',' ' "
    'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
    set InvoiceVendor = InvoiceVendor_CMD.execute

    if InvAP_LineFrom = "0" then
    
    InvoiceVendor_CMD.commandText = "INSERT INTO [dbo].[MKT_T_InvoiceVendor_D]([InvAP_IDH],[InvAP_Line],[InvAP_Ket])VALUES('"& InvoiceVendor("id") &"','"& InvoiceVendor("id") &"','SL') "
    'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
    set InvoiceVendorD = InvoiceVendor_CMD.execute

    Response.redirect "load-linefrom.asp?InvAPID=" & trim(InvoiceVendor("id"))

    else 

        IF falg = "PO" then

            InvoiceVendor_CMD.commandText = "INSERT INTO [dbo].[MKT_T_InvoiceVendor_D]([InvAP_IDH],[InvAP_Line],[InvAP_Ket])VALUES('"& InvoiceVendor("id") &"','"& InvAP_LineFrom &"','PO') "
            'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
            set InvoiceVendorD = InvoiceVendor_CMD.execute
        
        else 

            InvoiceVendor_CMD.commandText = "INSERT INTO [dbo].[MKT_T_InvoiceVendor_D]([InvAP_IDH],[InvAP_Line],[InvAP_Ket])VALUES('"& InvoiceVendor("id") &"','"& InvAP_LineFrom &"','MM') "
            'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
            set InvoiceVendorD = InvoiceVendor_CMD.execute
        
        end if

        If falg = "PO" then
            set UpdatePO_CMD = server.CreateObject("ADODB.command")
            UpdatePO_CMD.activeConnection = MM_pigo_STRING
            UpdatePO_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set po_prYN = 'Y' where poID_H = '"& InvAP_LineFrom &"' "
            'response.write UpdatePO_CMD.commandText  & "<br><br><br>"
            set UpdatePO = UpdatePO_CMD.execute

            set UpdateMM_CMD = server.CreateObject("ADODB.command")
            UpdateMM_CMD.activeConnection = MM_pigo_STRING
            UpdateMM_CMD.commandText = "UPDATE MKT_T_MaterialReceipt_D1 set mm_prYN = 'Y' where mm_poID = '"& InvAP_LineFrom &"' "
            'response.write UpdateMM_CMD.commandText  & "<br><br><br>"
            set UpdateMM = UpdateMM_CMD.execute
            
        else

            set UpdateMM_CMD = server.CreateObject("ADODB.command")
            UpdateMM_CMD.activeConnection = MM_pigo_STRING
            UpdateMM_CMD.commandText = "UPDATE MKT_T_MaterialReceipt_D1 set mm_prYN = 'Y' where mmID_D1 = '"& InvAP_LineFrom &"' "
            'response.write UpdateMM_CMD.commandText  & "<br><br><br>"
            set UpdateMM = UpdateMM_CMD.execute

            UpdateMM_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poID FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID Where mmID = '"& InvAP_LineFrom &"' GROUP BY MKT_T_MaterialReceipt_D1.mm_poID "
            'response.write UpdateMM_CMD.commandText  & "<br><br><br>"
            set POID = UpdateMM_CMD.execute

            UpdateMM_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set po_prYN = 'Y' where poID_H = '"& POID("mm_poID") &"' "
            'response.write UpdateMM_CMD.commandText  & "<br><br><br>"
            set UpdatePOMM = UpdateMM_CMD.execute
        end if 
    end if 
    

    InvoiceVendor_CMD.commandText = "Select * From MKT_T_InvoiceVendor_H Where InvAPID = '"& InvoiceVendor("id") &"' "
    'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
    set InvoiceVendorH = InvoiceVendor_CMD.execute

    InvoiceVendor_CMD.commandText = "Select * From MKT_T_InvoiceVendor_D Where InvAP_IDH = '"& InvoiceVendor("id") &"' "
    'response.write InvoiceVendor_CMD.commandText & "<br><br><br>"
    set InvoiceVendorD1 = InvoiceVendor_CMD.execute

    IF falg = "PO" then
        set PurchaseOrder_CMD = server.createObject("ADODB.COMMAND")
        PurchaseOrder_CMD.activeConnection = MM_PIGO_String
        PurchaseOrder_CMD.commandText = "SELECT MKT_T_PurchaseOrder_D.poSubTotal, MKT_T_PurchaseOrder_D.poPajak FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID Where MKT_T_PurchaseOrder_H.poID = '"& InvoiceVendorD1("InvAP_Line") &"' GROUP BY MKT_T_PurchaseOrder_D.poSubTotal, MKT_T_PurchaseOrder_D.poPajak"
        'Response.Write PurchaseOrder_CMD.commandText & "<br>"
        set PurchaseOrder = PurchaseOrder_CMD.execute
    Else 
        set PurchaseOrder_CMD = server.createObject("ADODB.COMMAND")
        PurchaseOrder_CMD.activeConnection = MM_PIGO_String
        PurchaseOrder_CMD.commandText = "SELECT MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_D.poSubTotal FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_PurchaseOrder_H RIGHT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 ON  MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE MKT_T_MaterialReceipt_H.mmID = '"& InvoiceVendorD1("InvAP_Line") &"'  GROUP BY MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_D.poSubTotal"
        'Response.Write PurchaseOrder_CMD.commandText & "<br>"
        set PurchaseOrder = PurchaseOrder_CMD.execute
    End If 

%>
<div class="judul-Pdbaru mt-2">
    <div class="row align-items-center">
        <div class="col-lg-6 col-md-6 col-sm-6">
            <input readonly type="hidden" class=" text-center cont-form" name="InvAPID" id="InvAPID" value="<%=InvoiceVendor("id")%>" ><br>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6">
            <input readonly type="hidden" class=" text-center cont-form" name="InvAP_Line" id="InvAP_LineFrom" value="<%=InvoiceVendorD1("InvAP_Line")%>"><br>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6 col-md-12 col-sm-12">
            <span class="cont-text"> Keterangan </span><br>
            <input required type="text" class="  cont-form" name="InvAP_Keterangan" id="InvAP_Keterangan" value="<%=InvAP_Desc%>(<%=InvoiceVendorD1("InvAP_Line")%>)"><br>
        </div>
        <div class="col-lg-2 col-md-4 col-sm-4">
            <span class="cont-text"> Jumlah </span><br>
            <% do while not PurchaseOrder.eof %>
                <input readonly type="hidden" class=" text-center cont-form" name="a" id="a" value="<%=PurchaseOrder("poSubTotal")%>">
                <input readonly type="hidden" class=" text-center cont-form" name="a" id="a" value="<%=PurchaseOrder("poPajak")%>">
                <% 
                    total = total + PurchaseOrder("poSubTotal")

                    tax     = PurchaseOrder("poPajak")
                    totaltax = tax/100*total
                %>
            <% PurchaseOrder.movenext
            loop %>
            <% grandtotal = totaltax+total%>

            <input required type="text" class=" text-center cont-form" name="Jumlah" id="Jumlah" value="<%=Replace(Replace(FormatCurrency(total),"$","Rp. "),".00","")%>" >
            <input readonly type="hidden" class=" text-center cont-form" name="InvAP_Jumlah" id="InvAP_Jumlah" value="<%=total%>" ><br>
        </div>
        <div class="col-lg-2 col-md-4 col-sm-4">
            <span class="cont-text"> Tax </span><br>
            <input readonly type="hidden" class=" text-center cont-form" name="InvAP_Tax" id="InvAP_Tax" value="<%=totaltax%>" >
            <input readonly type="text" class=" text-center cont-form" name="ppn" id="ppn" value="<%=Replace(Replace(FormatCurrency(totaltax),"$","Rp. "),".00","")%>" >
        </div>
        <div class="col-lg-2 col-md-4 col-sm-4">
            <span class="cont-text"> Total Line </span><br>
            <input readonly type="text" class=" text-center cont-form" name="total" id="total" value="<%=Replace(Replace(FormatCurrency(grandtotal),"$","Rp. "),".00","")%>" >
            <input readonly type="hidden" class=" text-center cont-form" name="InvAP_TotalLine" id="InvAP_TotalLine" value="<%=grandtotal%>" ><br>
        </div>
    </div>
    <div class="row mt-1 mb-1">
        <div class="col-lg-2 col-md-4 col-sm-12 text-end">
            <button onclick="addInvoiceD()" class="cont-btn" > Tambah Invoice </button>
        </div>
    </div>
    <div class="cont-InvoiceDetail" id="cont-InvoiceDetail">
    
    </div>
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
        document.getElementById("batal").style.display = "none"
    }
    
    
</script>