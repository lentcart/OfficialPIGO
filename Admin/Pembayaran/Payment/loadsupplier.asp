<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    key = request.queryString("keysupplier")

    set loadsupplier_CMD = server.createObject("ADODB.COMMAND")
	loadsupplier_CMD.activeConnection = MM_PIGO_String

    loadsupplier_CMD.commandText = "SELECT spID, spKey, spNama1, spPaymentTerm, spNamaCP, spAlamat FROM MKT_M_Supplier where spID = '"& key &"' "
    'Response.Write loadsupplier_CMD.commandText & "<br>"


set loadsupplier = loadsupplier_CMD.execute
        
%>
<div class="row">
    <div class="col-6">
        <div class="row">
            <div class="col-8">
                <span class="txt-payment-request">  Supplier ID </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=loadsupplier("spID")%>" ><br>
                <span class="txt-payment-request"> Nama Supplier </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="namasupplier" id="namasupplier" value="<%=loadsupplier("spNama1")%>" ><br>
            </div>
        </div>
    </div>
    <div class="col-6 align-items-center">
        <div class="row">
            <div class="col-6">
                <span class="txt-payment-request"> Jangan Waktu Pembayaran PO </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="poterm" id="poterm" value="<%=loadsupplier("spPaymentTerm")%>" style="width:15rem"><br>
            </div>
            <div class="col-6">
                <span class="txt-payment-request"> Lokasi Supplier </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="lokasi" id="lokasi" value="<%=loadsupplier("spAlamat")%>" style="width:15rem"><br>
            </div>
        </div>
        <div class="row">
            <div class="col-6">
                <span class="txt-payment-request"> Nama CP Supplier </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="namacp" id="namacp" value="<%=loadsupplier("spNamaCP")%>" style="width:31rem"><br>
            </div>
        </div>
    </div>
</div>