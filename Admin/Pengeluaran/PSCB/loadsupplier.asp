
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    key = request.queryString("keysupplier")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT spID, spKey, spNama1, spPaymentTerm, spNamaCP, spAlamat FROM MKT_M_Supplier where spID = '"& key &"' "
    'Response.Write loadproduk_CMD.commandText & "<br>"


set dproduk = loadproduk_CMD.execute
        
        ' response.ContentType = "application/json;charset=utf-8"
		' response.write "["
        ' do until  dproduk.eof
        '     response.write "{"
		' 		response.write """SupplierID""" & ":" &  """" & dproduk("spID") &  """" & ","
		' 		response.write """KeySearch""" & ":" &  """" & dproduk("spKey") &  """" & ","
		' 		response.write """NamaSupplier""" & ":" &  """" & dproduk("spNama1") &  """" 
		' 		response.write """NamaCP""" & ":" &  """" & dproduk("spNamaCP") &  """" 
		' 		response.write """AlamatSP""" & ":" &  """" & dproduk("spAlamat") &  """" 
        '     response.write "}"
        ' dproduk.movenext
        ' loop 
        ' response.write "]"
        
%> 
<div class="col-6">
    <div class="row">
        <div class="col-8">
            <span class="txt-purchase-order">  Supplier ID </span><br>
            <input type="text" class=" mb-2 inp-purchase-order" name="supplierid" id="supplierid" value="<%=dproduk("spID")%>" ><br>
            <span class="txt-purchase-order"> Nama Supplier </span><br>
            <input type="text" class=" mb-2 inp-purchase-order" name="namasupplier" id="namasupplier" value="<%=dproduk("spNama1")%>" ><br>
        </div>
    </div>
</div>
<div class="col-6 align-items-center">
    <div class="row">
        <div class="col-6">
            <span class="txt-purchase-order"> Jangan Waktu Pembayaran PO </span><br>
            <input type="text" class=" mb-2 inp-purchase-order" name="poterm" id="poterm" value="<%=dproduk("spPaymentTerm")%>" style="width:15rem"><br>
        </div>
        <div class="col-6">
            <span class="txt-purchase-order"> Lokasi Supplier </span><br>
            <input type="text" class=" mb-2 inp-purchase-order" name="lokasi" id="lokasi" value="<%=dproduk("spAlamat")%>" style="width:15rem"><br>
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <span class="txt-purchase-order"> Nama CP Supplier </span><br>
            <input type="text" class=" mb-2 inp-purchase-order" name="namacp" id="namacp" value="<%=dproduk("spNamaCP")%>" style="width:15rem"><br>
        </div>
        <div class="col-6">
            <input type="checkbox" class="mb-2 mt-4" name="dropship" id="dropship" value="Y">
            <label for="dropship" class="txt-purchase-order"> Drop Shipment </label>
        </div>
    </div>
    
</div>