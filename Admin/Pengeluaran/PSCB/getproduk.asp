
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    key = request.queryString("keyproduk")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT ISNULL(MKT_T_MaterialReceipt_D2.mm_pdHarga,0) as Harga, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdPartNumber FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 FULL OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE MKT_M_PIGO_Produk.pdID = '"& key &"' group by MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_T_MaterialReceipt_D2.mm_pdHarga,MKT_M_PIGO_Produk.pdPartNumber "
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute
        
%> 
<input type="hidden" class=" inp-purchase-order" name="produkid" id="produkid" value="<%=dproduk("pdID")%>" ><br>
    <div class="col-6">
        <div class="row">
            <div class="col-7">
                <span class="txt-purchase-order"> Nama Produk </span><br>
                <input required type="text" class=" mb-2 inp-purchase-order" name="namaproduk" id="namaproduk" value="<%=dproduk("pdNama")%>" style="width:100%"><br>
            </div>
            <div class="col-5">
                <span class="txt-purchase-order"> Part Number </span><br>
                <input required type="text" class=" mb-2 inp-purchase-order" name="namaproduk" id="namaproduk" value="<%=dproduk("pdPartNumber")%>" style="width:11.7rem"><br>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <button onclick="sendproduk()" class="btn-tambah-produk"> Tambah Produk </button>
            </div>
        </div>
    </div>
    <div class="col-6">
        <div class="row">
            <div class="col-4">
                <span class="txt-purchase-order"> Harga </span><br>
                <input onkeyup="subtotal()" required type="text" class=" mb-2 inp-purchase-order" name="harga" id="harga" value="<%=dproduk("Harga")%>" style="width:10rem"><br>
            </div>
            <div class="col-2 ">
                <span class="txt-purchase-order"> Jumlah  </span><br>
                <input onkeyup="subtotal()" required type="text" class=" mb-2 inp-purchase-order" name="jumlah" id="jumlah" value="0" style="width:5rem"><br>
            </div>
            <div class="col-2">
                <span class="txt-purchase-order"> Unit </span><br>
                <select required style="width:4rem" class=" mb-2 inp-purchase-order" name="unit" id="unit" aria-label="Default select example" required>
                    <option selected>Pilih</option>
                    <option value="Pcs">Pcs</option>
                    <option value="Kg">Kg</option>
                    <option value="Dus">Dus</option>
                    <option value="Pck">Pck</option>
                    <option value="Mm">Mm</option>
                    <option value="Ml">Ml</option>
                </select>
            </div>
            <div class="col-3">
                <span class="txt-purchase-order"> Sub Total </span><br>
                <input required type="number" class=" mb-2 inp-purchase-order" name="subtotal" id="subtotal" value="0" style="width:10rem"><br>
            </div>
        </div>
    </div>