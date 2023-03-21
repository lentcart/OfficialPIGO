
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    pdpartnumber = request.queryString("pdpartnumber")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdTypePart, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdHarga, MKT_M_PIGO_Produk.pdUpTo, MKT_M_Tax.TaxRate,MKT_M_PIGO_Produk.pdTax FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID WHERE MKT_M_PIGO_Produk.pdPartNumber = '"& pdpartnumber &"'"
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute
    resultup    = dproduk("pdHarga")+(dproduk("pdHarga")*dproduk("pdUpTo")/100)
    resultppn   = resultup*dproduk("TaxRate")/100
    result      = resultup+resultppn
    total       = round(result)
        
%>
<div class="row mt-3">
    <div class="col-lg-2 col-md-4 col-sm-4">
        <span class="cont-text"> ID Produk </span><br>
        <input readonly  type="text" class=" text-center cont-form" name="pdid" id="pdid" value="<%=dproduk("pdID")%>" ><br>
    </div>
    <div class="col-lg-6 col-md-8 col-sm-8">
        <span class="cont-text"> Detail Produk </span><br>
        <input readonly type="text" class="  cont-form" name="pdnama" id="pdnama" value="<%=dproduk("pdPartNumber")%>&nbsp;<%=dproduk("pdNama")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-6 col-sm-6">
        <span class="cont-text"> Type Produk </span><br>
        <input readonly type="text" class="  cont-form" name="pdtypeproduk" id="pdtypeproduk" value="<%=dproduk("pdTypeProduk")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-6 col-sm-6">
        <span class="cont-text"> Type Part </span><br>
        <input readonly type="text" class="  cont-form" name="pdtypepart" id="typepart"  value="<%=dproduk("pdTypePart")%>" ><br>
    </div>
</div>
<div class="row mt-3">
    <div class="col-lg-3 col-md-6 col-sm-6">
        <span class="cont-text"> Lokasi Rak </span><br>
        <input readonly type="text" class="  cont-form" name="pdlokasi" id="pdlokasi" value="<%=dproduk("pdLokasi")%>" >
    </div>
    <div class="col-lg-3 col-md-6 col-sm-6">
        <span class="cont-text"> Harga Beli Produk </span><br>
        <input readonly type="hidden" class=" text-center cont-form" name="harga" id="harga" value="<%=dproduk("pdHarga")%>" >
        <input readonly type="text" class=" text-center cont-form" name="hargabeli" id="hargabeli" value="<%=replace(replace(formatcurrency(dproduk("pdHarga")),"$","Rp. "),".00","")%>" >
    </div>
    <div class="col-lg-3 col-md-6 col-sm-4">
        <span class="cont-text"> Harga Jual </span><br>
        <input  type="text" readonly class=" text-center cont-form" name="pdhargajual" id="pdhargajual" value="<%=Replace(Replace(FormatCurrency(total),"$","Rp. "),".00","")%>" >
        <input  type="hidden"  class=" text-center cont-form" name="hargajual" id="hargajual" value="<%=total%>" >
        <input  type="hidden"  class=" text-center cont-form" name="ppn" id="ppn" value="<%=dproduk("pdTax")%>" >
        <input  type="hidden"  class=" text-center cont-form" name="upto" id="upto" value="<%=dproduk("pdUpTo")%>" >


    </div>
    <div class="col-lg-3 col-md-6 col-sm-12">
        <span class="cont-text"> </span><br>
        <button onclick="return tambahproduk()" class="cont-btn"> Tambah Produk </button>
    </div>
</div>
