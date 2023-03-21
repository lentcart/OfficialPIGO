
<!--#include file="../../connections/pigoConn.asp"--> 

<% 

    pscID = request.queryString("pscID")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_D1.pscD1_NoPermintaan, MKT_T_PengeluaranSC_D1.pscD1_TglPermintaan, MKT_M_Supplier.spID,  MKT_M_Supplier.spNama1, MKT_M_Supplier.spAlamat FROM MKT_T_PengeluaranSC_D1 LEFT OUTER JOIN MKT_M_Supplier ON MKT_T_PengeluaranSC_D1.pscD1_spID = MKT_M_Supplier.spID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D1.pscID1_H = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D2 ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D2.pscD2_H where MKT_T_PengeluaranSC_H.pscID  = '"& pscID &"' group by MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_D1.pscD1_NoPermintaan, MKT_T_PengeluaranSC_D1.pscD1_TglPermintaan, MKT_M_Supplier.spID,  MKT_M_Supplier.spNama1, MKT_M_Supplier.spAlamat  "
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute
        
    set dataproduk_CMD = server.createObject("ADODB.COMMAND")
	dataproduk_CMD.activeConnection = MM_PIGO_String
%> 
<%do while not dproduk.eof%>
<div class="row ">
    <div class="col-6">
        <span class="txt-purchase-order"> No PSCB </span><span style="font-size:10px; color:#ggg"><i>(Pengeluaran Suku Cabang Baru) </i></span><br>
            <select class=" mb-2 inp-purchase-order" name="pscID" id="pscID" aria-label="Default select example" required>
                <option value="<%=dproduk("pscID")%>"><%=dproduk("pscID")%></option>
            </select>
    </div>
    <div class="col-6">
        <span class="txt-purchase-order"> Tanggal PSCB </span><span style="font-size:10px; color:#ggg"><i>(Pengeluaran Suku Cabang Baru) </i></span><br>
        <input required type="Date" class=" mb-2 inp-purchase-order" name="tglpermintaan" id="tglpermintaan" value="<%=dproduk("pscTanggal")%>" style="width:16rem"><br>
    </div>
</div>
<div class="row">
    <div class="col-6">
        <span class="txt-purchase-order"> No Permintaan ( PO )</span><br>
        <input required type="text" class=" mb-2 inp-purchase-order" name="tglpermintaan" id="tglpermintaan" value="<%=dproduk("pscD1_NoPermintaan")%>" ><br>
    </div>
    <div class="col-6">
        <span class="txt-purchase-order"> Tanggal Permintaan ( PO )</span><br>
        <input required type="date" class=" mb-2 inp-purchase-order" name="tglpermintaan" id="tglpermintaan" value="<%=dproduk("pscD1_TglPermintaan")%>" style="width:16rem"><br>
    </div>
</div>
<div class="row">
    <div class="col-2">
        <span class="txt-purchase-order">  Supplier ID </span><br>
        <input required type="text" class=" mb-2 inp-purchase-order" name="supplierid" id="supplierid" value="<%=dproduk("spID")%>" style="width:10rem" ><br>
    </div>
    <div class="col-4">
        <span class="txt-purchase-order">  Nama Supplier  </span><br>
        <input required type="text" class=" mb-2 inp-purchase-order" name="supplierid" id="supplierid" value="<%=dproduk("spnama1")%>" style="width:19.4rem" ><br>
    </div>
    <div class="col-6">
        <span class="txt-purchase-order">  Alamat Supplier  </span><br>
        <input required type="text" class=" mb-2 inp-purchase-order" name="supplierid" id="supplierid" value="<%=dproduk("spAlamat")%>"><br>
    </div>
</div>
<div class="row mt-1">
    <span class=" text-center label-po txt-purchase-order"><b> Daftar Produk </b></span>
    <div class="col-12">
        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
            <thead>
                <tr>
                    <th class="text-center"> No </th>
                    <th class="text-center"> SKU/Part Number </th>
                    <th class="text-center"> Nama Produk </th>
                    <th class="text-center">  Jumlah </th>
                    <th class="text-center">  Satuan </th>
                </tr>
            </thead>
            <tbody>
            <%
                dataproduk_CMD.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no,MKT_T_PengeluaranSC_H.pscID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber, MKT_T_PengeluaranSC_D2.pscD2_pdQty, MKT_T_PengeluaranSC_D2.pscD2_pdUnit FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PengeluaranSC_D2 ON MKT_M_PIGO_Produk.pdID = MKT_T_PengeluaranSC_D2.pscD2_pdID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H LEFT OUTER JOIN MKT_T_PengeluaranSC_D1 ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D1.pscID1_H ON MKT_T_PengeluaranSC_D2.pscD2_H = MKT_T_PengeluaranSC_H.pscID WHERE MKT_T_PengeluaranSC_H.pscID = '"& dproduk("pscID") &"'"
                'Response.Write dataproduk_CMD.commandText & "<br>"

                set dataproduk = dataproduk_CMD.execute
            %>
            <%do while not dataproduk.eof%>
                <tr>
                    <td class="text-center"> <%=dataproduk("no")%> </td>
                    <td class="text-center"> <%=dataproduk("pdPartNumber")%> </td>
                    <td class="text-center"> <%=dataproduk("pdNama")%> </td>
                    <td class="text-center"> <%=dataproduk("pscD2_pdQty")%> </td>
                    <td class="text-center"> <%=dataproduk("pscD2_pdUnit")%> </td>
                </tr>
            <% dataproduk.movenext
            loop %>
            </tbody>
        </table>
    </div>
</div>
<% dproduk.movenext
loop%>