
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    pdpartnumber = request.queryString("pdpartnumber")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdStokAwal, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdTypePart, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdHarga, MKT_M_PIGO_Produk.pdUpTo, MKT_M_Tax.TaxRate,MKT_M_PIGO_Produk.pdTax FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID WHERE MKT_M_PIGO_Produk.pdPartNumber = '"& pdpartnumber &"'"
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute

    ' set dproduk = loadproduk_CMD.execute
    ' resultup    = dproduk("pdHarga")+(dproduk("pdHarga")*dproduk("pdUpTo")/100)
    ' resultppn   = resultup*dproduk("TaxRate")/100
    ' result      = resultup+resultppn
    ' total       = round(result)

    set Tax_CMD = server.createObject("ADODB.COMMAND")
	Tax_CMD.activeConnection = MM_PIGO_String
    Tax_CMD.commandText = "SELECT * FROM MKT_M_Tax Where TaxAktifYN = 'Y' "
    set Tax = Tax_CMD.execute
        
%>
<div class="row mt-2">
    <div class="col-lg-2 col-md-4 col-sm-4">
        <span class="cont-text"> ID Produk </span><br>
        <input readonly  type="text" class=" text-center cont-form" name="pdid" id="pdid" value="<%=dproduk("pdID")%>" ><br>
    </div>
    <div class="col-lg-6 col-md-8 col-sm-8">
        <span class="cont-text"> Detail Produk </span><br>
        <input readonly type="text" class="  cont-form" name="pdnama" id="pdnama" value="<%=dproduk("pdPartNumber")%>&nbsp;<%=dproduk("pdNama")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-6 col-sm-6">
        <span class="cont-text"> Type Part </span><br>
        <input readonly type="text" class="  cont-form" name="typepart" id="typepart" value="<%=dproduk("pdTypePart")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-6 col-sm-6">
        <span class="cont-text"> Lokasi RAK </span><br>
        <input readonly type="text" class="  cont-form" name="pdlokasi" id="pdlokasi"  value="<%=dproduk("pdLokasi")%>" >
    </div>
</div>
<div class="row mt-2">
    <div class="col-lg-2 col-md-6 col-sm-6">
        <span class="cont-text"> Harga Beli Produk </span><br>
        <input readonly type="hidden" class=" text-center cont-form" name="harga" id="harga" value="<%=dproduk("pdHarga")%>" >
        <input readonly type="text" class=" text-center cont-form" name="hargabeli" id="hargabeli" value="<%=replace(replace(formatcurrency(dproduk("pdHarga")),"$","Rp. "),".00","")%>" >
    </div>
    <div class="col-lg-2 col-md-6 col-sm-6">
        <span class="cont-text"> TAX (PPN) </span><br>
        <select onchange="hargajual()"  class=" pdPPN ppn cont-form" name="ppn" id="ppn" aria-label="Default select example" required>
            <option value="">Pilih Tax(PPN)</option>
            <% do while not TAX.eof %>
            <option value="<%=TAX("TaxRate")%>"><%=TAX("TaxNama")%></option>
            <% TAX.movenext
            loop%>
        </select>
    </div>
    <div class="col-lg-2 col-md-6 col-sm-4">
        <span class="cont-text"> Up To (%) </span><br>
        <input onkeyup="hargajual()"  type="number"  class=" text-center cont-form" name="pdUpto" id="pdUpto" value="0" >
    </div>
    <div class="col-lg-2 col-md-6 col-sm-4">
        <span class="cont-text"> Harga Jual </span><br>
        <input onkeyup="hargajual()"  type="number"  class=" text-center cont-form" name="pdhargajual" id="pdhargajual" value="0" >
    </div>
    <div class="col-lg-2 col-md-6 col-sm-6">
        <span class="cont-text">  </span><br>
        <input readonly onblur="hargajual()" type="number" class=" text-center cont-form" name="subtotal" id="subtotal" value="" >
    </div>
    <div class="col-lg-2 col-md-6 col-sm-6">
        <span class="cont-text"> QTY Permintaan </span><br>
        <input type="hidden" class=" text-center cont-form" name="Stok" id="Stok" value="<%=dproduk("pdStokAwal")%>" >
        <input required  onblur="stokbarang()" type="number" class="pdQty text-center cont-form" name="pdQty" id="pdQty" value="0" >
    </div>
</div>
<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <span class="cont-text"> </span><br>
        <button onclick="return tambahproduk()" class="cont-btn"> Tambah Produk </button>
    </div>
</div>

<script>
    function stokbarang(){
        var permintaan  = Number(document.getElementById("pdQty").value);
        var stok        = Number(document.getElementById("Stok").value);
        if( permintaan > stok ) {
            Swal.fire({
                title: 'Stok Hanya Tersedia : '+stok+''
                }).then((result) => {
                    document.getElementById("pdQty").value = "";
            })
        }else{
            document.getElementById("pdQty").value = permintaan;
        }
    }
    function hargajual() {
        var ppn = Number(document.getElementById("ppn").value);
        var up = Number(document.getElementById("pdUpto").value);
        var harga = Number(document.getElementById("pdhargajual").value);
        var total = 0;
        var resultup = Number(harga+(harga*up/100));
        var resultppn = Number(resultup*ppn/100);
        var result = Number(resultup+resultppn);
        total = Math.round(result);
        document.getElementById("subtotal").value = total;
        }
        document.addEventListener("DOMContentLoaded", function(event) {
            hargajual();
        });
</script>

