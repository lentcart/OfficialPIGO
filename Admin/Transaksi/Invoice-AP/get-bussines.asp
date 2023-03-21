<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    custID = request.queryString("bussines")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String
    BussinesPart_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama,MKT_M_Customer.custPhone1,MKT_M_Customer.custEmail,MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID WHERE MKT_M_Customer.custID = '"& custID &"'"
    'Response.Write BussinesPart_CMD.commandText & "<br>"
    set BussinesPart = BussinesPart_CMD.execute
        
%>
<div class="row mt-1">
    <div class="col-lg-2 col-md-4 col-sm-4">
        <span class="cont-text">  Supplier ID </span><br>
        <input readonly type="text" class="cont-form" name="InvAP_custID" id="cont" value="<%=BussinesPart("custID")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-8 col-sm-8">
        <span class="cont-text"> Nama Supplier </span><br>
        <input readonly type="text" class="cont-form" name="namasupplier" id="cont" value="<%=BussinesPart("custNama")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-4">
        <span class="cont-text"> Pay-Term </span><br>
        <input readonly type="text" class="cont-form" name="poterm" id="cont" value="<%=BussinesPart("custPaymentTerm")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-8 col-sm-8">
        <span class="cont-text"> Nama CP Supplier </span><br>
        <input readonly type="text" class="cont-form" name="namacp" id="cont" value="<%=BussinesPart("custNamaCP")%>"><br>
    </div>
</div>
<div class="row">
    <div class="col-lg-6 col-md-12 col-sm-12">
        <span class="cont-text"> Lokasi Supplier </span><br>
        <input readonly type="text" class="cont-form" name="lokasi" id="cont" value="<%=BussinesPart("almlengkap")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-4">
        <span class="cont-text"> Phone </span><br>
        <input readonly type="text" class="cont-form" name="phone" id="cont" value="<%=BussinesPart("custPhone1")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-4">
        <span class="cont-text"> Email </span><br>
        <input readonly type="text" class="cont-form" name="email" id="cont" value="<%=BussinesPart("custEmail")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-4">
        <span class="cont-text"> NPWP </span><br>
        <input readonly type="text" class="cont-form" name="npwp" id="cont" value="<%=BussinesPart("custNpwp")%>" ><br>
    </div>
</div>
<div class="row align-items-center">
<div class="col-lg-2 col-md-3 col-sm-3">
    <span class="cont-text"></span><br>
    <input onchange="addline()" type="checkbox" id="kalkulator">
    <label class="side-toggle" for="kalkulator"> <span class="cont-btn" style="padding:0px 20px"> Create Line From </span></label>
</div>
<div class="col-lg-4 col-md-3 col-sm-3">
    <%
        BussinesPart_CMD.commandText = "SELECT MKT_T_PurchaseOrder_H.poID,MKT_T_PurchaseOrder_H.poTanggal FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID Where MKT_T_PurchaseOrder_H.po_custID = '"& BussinesPart("custID") &"' AND MKT_T_PurchaseOrder_D.po_tfYN = 'N' and MKT_T_PurchaseOrder_D.po_spoID = '1'   AND MKT_T_PurchaseOrder_D.po_spoID = '1' GROUP BY MKT_T_PurchaseOrder_H.poID,MKT_T_PurchaseOrder_H.poTanggal"
        'response.write BussinesPart_CMD.commandText & "<br><br><br>"
        set PurchaseOrder = BussinesPart_CMD.execute
    %>
    <span class="cont-text">  </span><br>
    <select disabled="true" onchange="return getPO()" class="cont-form" name="listpo" id="listpo" aria-label="Default select example" readonly>
        <option value="">Pilih Purchase Order </option>
        <% if PurchaseOrder.eof = true then %>
        <option value=""> Tidak Ada Purchase Order </option>
        <% else %>
        <% do while not PurchaseOrder.eof %>
        <option value="<%=PurchaseOrder("poID")%>"><%=PurchaseOrder("poID")%>&nbsp;(<%=day(CDate(PurchaseOrder("poTanggal")))%>&nbsp;<%=MonthName(Month(PurchaseOrder("poTanggal")))%>&nbsp;<%=Year(PurchaseOrder("poTanggal"))%>)</option>
        <% PurchaseOrder.movenext
        loop %>
        <% end if %>
    </select>
</div>
<div class="col-lg-4 col-md-3 col-sm-3">
    <%
        BussinesPart_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_MaterialReceipt_H.mm_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_H.mm_custID =  '"&  BussinesPart("custID") &"'  and MKT_T_MaterialReceipt_H.mm_tfYN = 'N' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal"
        'response.write BussinesPart_CMD.commandText & "<br><br><br>"
        set MaterialReceipt = BussinesPart_CMD.execute
    %>
    <span class="cont-text">  </span><br>
    <select disabled="true" onchange="return getMM()" class="cont-form" name="listmm" id="listmm" aria-label="Default select example" readonly>
        <option value="">Pilih Material Receipt </option>
        <% if MaterialReceipt.eof = true then %>
        <option value=""> Tidak Ada Material Receipt</option>
        <% else %>
        <% do while not MaterialReceipt.eof %>
        <option value="<%=MaterialReceipt("mmID")%>"><%=MaterialReceipt("mmID")%>&nbsp;(<%=day(CDate(MaterialReceipt("mmTanggal")))%>&nbsp;<%=MonthName(Month(MaterialReceipt("mmTanggal")))%>&nbsp;<%=Year(MaterialReceipt("mmTanggal"))%>)</option>
            <% MaterialReceipt.movenext
            loop %>
            <% end if %>
        </select>
    </div>
    <div class="col-lg-2 col-md-3 col-sm-3 text-end">
        <span class="cont-text">  </span><br>
        <button onclick="addInvoiceH()" name="add" id="add"class="cont-btn" style=" display:block"> <i class="fas fa-plus"></i> &nbsp; Add Invoice Line</button>
        <button onclick="batal()" name="batal" id="batal" class="cont-btn" style=" display:none"> <i class="fas fa-ban"></i> &nbsp; Batalkan Proses </button>
    </div>
</div>
<div class="row" style="display:none">
    <div class="col-lg-2 col-md-4 col-sm-4">
        <span> Line From </span>
    </div>
    <div class="col-lg-6 col-md-8 col-sm-8 cont-Lines">
        <input readonly class="cont-form" type="text" name="InvAP_LineFrom" id="InvAP_LineFrom" value="0" >
    </div>
</div>
<script>
    function addline(){
        var addline = document.getElementById("kalkulator");
        if(addline.checked == true){
            document.getElementById("InvAP_LineFrom").value="";
            $('#listpo').attr('disabled',false);
            $('#listmm').attr('disabled',false);
        }else{
            $('#listpo').attr('disabled',true);
            $('#listmm').attr('disabled',true);
            $('#listpo').val('')
            $('#listmm').val('')
            document.getElementById("InvAP_LineFrom").value="0";
        }
    }
</script>