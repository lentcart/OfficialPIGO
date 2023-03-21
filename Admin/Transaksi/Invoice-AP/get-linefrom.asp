<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    InvAP_poID = request.queryString("InvAP_poID")
    InvAP_Keterangan = request.queryString("InvAP_Keterangan")

    set PurchaseOrder_CMD = server.createObject("ADODB.COMMAND")
	PurchaseOrder_CMD.activeConnection = MM_PIGO_String
    PurchaseOrder_CMD.commandText = "SELECT MKT_T_PurchaseOrder_D.poSubTotal, MKT_T_PurchaseOrder_D.poPajak FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID Where MKT_T_PurchaseOrder_H.poID = '"& InvAP_poID &"' GROUP BY MKT_T_PurchaseOrder_D.poSubTotal, MKT_T_PurchaseOrder_D.poPajak"
    'Response.Write PurchaseOrder_CMD.commandText & "<br>"
    set PurchaseOrder = PurchaseOrder_CMD.execute
        
%>
<div class="col-6">
    <span class="txt-purchase-order"> Keterangan </span><br>
    <input required type="text" class="  inp-purchase-order" name="InvAP_Keterangan" id="InvAP_Keterangan" value="<%=InvAP_Keterangan%>(<%=InvAP_poID%>)"><br>
</div>
<div class="col-2">
    <span class="txt-purchase-order"> Jumlah </span><br>
    <% do while not PurchaseOrder.eof %>
        <input readonly type="hidden" class=" text-center inp-purchase-order" name="a" id="a" value="<%=PurchaseOrder("poSubTotal")%>" style="width:10rem">
        <input readonly type="hidden" class=" text-center inp-purchase-order" name="a" id="a" value="<%=PurchaseOrder("poPajak")%>" style="width:10rem">
        <% 
            total = total + PurchaseOrder("poSubTotal")

            tax     = PurchaseOrder("poPajak")
            totaltax = tax/100*total
        %>
    <% PurchaseOrder.movenext
    loop %>
    <% grandtotal = totaltax+total%>

    <input required type="text" class=" text-center inp-purchase-order" name="Jumlah" id="Jumlah" value="<%=Replace(Replace(FormatCurrency(total),"$","Rp. "),".00","")%>" style="width:10rem">
    <input readonly type="hidden" class=" text-center inp-purchase-order" name="InvAP_Jumlah" id="InvAP_Jumlah" value="<%=total%>" style="width:10rem"><br>
</div>
<div class="col-2">
    <span class="txt-purchase-order"> Tax </span><br>
    <input readonly type="hidden" class=" text-center inp-purchase-order" name="InvAP_Tax" id="InvAP_Tax" value="<%=totaltax%>" style="width:10rem">
    <input readonly type="text" class=" text-center inp-purchase-order" name="ppn" id="ppn" value="<%=Replace(Replace(FormatCurrency(totaltax),"$","Rp. "),".00","")%>" >
</div>
<div class="col-2">
    <span class="txt-purchase-order"> Total Line </span><br>
    <input readonly type="text" class=" text-center inp-purchase-order" name="total" id="total" value="<%=Replace(Replace(FormatCurrency(grandtotal),"$","Rp. "),".00","")%>" >
    <input readonly type="hidden" class=" text-center inp-purchase-order" name="InvAP_TotalLine" id="InvAP_TotalLine" value="<%=grandtotal%>" ><br>
</div>
%>
<div class="col-6">
    <span class="txt-purchase-order"> Keterangan </span><br>
    <input required type="text" class="  inp-purchase-order" name="InvAP_Keterangan" id="InvAP_Keterangan" value="<%=InvAP_Keterangan%>(<%=InvAP_poID%>)"><br>
</div>
<div class="col-2">
    <span class="txt-purchase-order"> Jumlah </span><br>
    <% do while not PurchaseOrder.eof %>
        <input readonly type="hidden" class=" text-center inp-purchase-order" name="a" id="a" value="<%=PurchaseOrder("poSubTotal")%>" style="width:10rem">
        <input readonly type="hidden" class=" text-center inp-purchase-order" name="a" id="a" value="<%=PurchaseOrder("poPajak")%>" style="width:10rem">
        <% 
            total = total + PurchaseOrder("poSubTotal")

            tax     = PurchaseOrder("poPajak")
            totaltax = tax/100*total
        %>
    <% PurchaseOrder.movenext
    loop %>
    <% grandtotal = totaltax+total%>

    <input required type="text" class=" text-center inp-purchase-order" name="Jumlah" id="Jumlah" value="<%=Replace(Replace(FormatCurrency(total),"$","Rp. "),".00","")%>" style="width:10rem">
    <input readonly type="hidden" class=" text-center inp-purchase-order" name="InvAP_Jumlah" id="InvAP_Jumlah" value="<%=total%>" style="width:10rem"><br>
</div>
<div class="col-2">
    <span class="txt-purchase-order"> Tax </span><br>
    <input readonly type="hidden" class=" text-center inp-purchase-order" name="InvAP_Tax" id="InvAP_Tax" value="<%=totaltax%>" style="width:10rem">
    <input readonly type="text" class=" text-center inp-purchase-order" name="ppn" id="ppn" value="<%=Replace(Replace(FormatCurrency(totaltax),"$","Rp. "),".00","")%>" >
</div>
<div class="col-2">
    <span class="txt-purchase-order"> Total Line </span><br>
    <input readonly type="text" class=" text-center inp-purchase-order" name="total" id="total" value="<%=Replace(Replace(FormatCurrency(grandtotal),"$","Rp. "),".00","")%>" >
    <input readonly type="hidden" class=" text-center inp-purchase-order" name="InvAP_TotalLine" id="InvAP_TotalLine" value="<%=grandtotal%>" ><br>
</div>