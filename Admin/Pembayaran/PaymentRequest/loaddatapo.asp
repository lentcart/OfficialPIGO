
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    poid = request.queryString("poID")

    set loadpo_CMD = server.createObject("ADODB.COMMAND")
	loadpo_CMD.activeConnection = MM_PIGO_String

    loadpo_CMD.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTglOrder, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.poJenis FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID Where MKT_T_PurchaseOrder_H.poID = '"& poid &"' and  MKT_T_PurchaseOrder_D.po_spoID = '1' and MKT_T_PurchaseOrder_D.po_prYN = 'N' GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTglOrder, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_T_PurchaseOrder_H.poJenis"
    'Response.Write loadpo_CMD.commandText & "<br>"

    set loadpo = loadpo_CMD.execute
    
    set supplier_CMD = server.createObject("ADODB.COMMAND")
	supplier_CMD.activeConnection = MM_PIGO_String
%>
<% do while not loadpo.eof%>
<div class="row">
    <div class="col-3">
        <span class="txt-payment-request"> Tanggal Order  </span><br>
        <input type="text" class=" mb-2 inp-payment-request" name="tglorder" id="tglorder" value="<%=loadpo("poTglOrder")%>" style="width:15rem"><br>
    </div>
    <div class="col-3">
        <span class="txt-payment-request"> Jenis Purchase Order </span><br>
        <input type="text" class=" mb-2 inp-payment-request" name="jenispo" id="jenispo" value="<%=loadpo("poJenis")%>" style="width:14rem"><br>
    </div>
</div>
<%

    Supplier_CMD.commandText = "SELECT MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spProv, MKT_M_Supplier.spPhone1, MKT_M_Supplier.spNamaCP FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_PurchaseOrder_H.po_spID = MKT_M_Supplier.spID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_PurchaseOrder_H.poID = MKT_T_MaterialReceipt_D1.mm_poID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H Where MKT_T_PurchaseOrder_H.poID = '"& loadpo("poID") &"' GROUP BY  MKT_M_Supplier.spID, MKT_M_Supplier.spNama1, MKT_M_Supplier.spPaymentTerm, MKT_M_Supplier.spAlamat, MKT_M_Supplier.spProv, MKT_M_Supplier.spPhone1,  MKT_M_Supplier.spNamaCP "
    'Response.Write Supplier_CMD.commandText & "<br>"

    set Supplier = Supplier_CMD.execute

%>
<div class="row">
    <div class="col-6">
        <div class="row">
            <div class="col-8">
                <span class="txt-payment-request">  Supplier ID </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="supplierid" id="supplierid" value="<%=Supplier("spID")%>" ><br>
                <span class="txt-payment-request"> Nama Supplier </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="namasupplier" id="namasupplier" value="<%=Supplier("spNama1")%>" ><br>
            </div>
        </div>
    </div>
    <div class="col-6 align-items-center">
        <div class="row">
            <div class="col-6">
                <span class="txt-payment-request"> Jangan Waktu Pembayaran PO </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="poterm" id="poterm" value="<%=Supplier("spPaymentTerm")%>" style="width:15rem"><br>
            </div>
            <div class="col-6">
                <span class="txt-payment-request"> Lokasi Supplier </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="lokasi" id="lokasi" value="<%=Supplier("spAlamat")%>" style="width:15rem"><br>
            </div>
        </div>
        <div class="row">
            <div class="col-6">
                <span class="txt-payment-request"> Nama CP Supplier </span><br>
                <input required type="text" class=" mb-2 inp-payment-request" name="namacp" id="namacp" value="<%=Supplier("spnamaCP")%>" style="width:31rem"><br>
            </div>
        </div>
    </div>
</div>
<% loadpo.movenext
loop%>