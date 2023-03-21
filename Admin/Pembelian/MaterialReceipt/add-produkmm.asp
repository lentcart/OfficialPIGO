<!--#include file="../../../connections/pigoConn.asp"-->

<%  
    mmIDStatus	        = request.queryString("mmIDStatus")
    mmID_D	            = request.queryString("mmID_D")
    mm_pdID	            = request.queryString("mm_pdID")
    mm_pdQty	        = request.queryString("mm_pdQty")
    mm_pdQtyDiterima	= request.queryString("mm_pdQtyDiterima")
    mm_pdSubtotal	    = request.queryString("mm_pdSubtotal")
    poid	            = request.queryString("poid")
    potanggal	        = request.queryString("potanggal")
    statuspo	        = request.queryString("statuspo")
    harga	            = request.queryString("harga")
    sisa	            = request.queryString("sisa")
    
    If mmIDStatus = "ADD" then 
        set MaterialReceipt_D1_CMD = server.CreateObject("ADODB.command")
        MaterialReceipt_D1_CMD.activeConnection = MM_pigo_STRING
        MaterialReceipt_D1_CMD.commandText = "INSERT INTO [dbo].[MKT_T_MaterialReceipt_D1]([mmID_D1],[mm_poID],[mm_poTanggal],[mmD1UpdateTime],[mmD1AktifYN]) VALUES ('"& mmID_D &"','"& poid &"','"& potanggal &"','"& now() &"','Y')"
        set MaterialReceipt_D1 = MaterialReceipt_D1_CMD.execute

        set MaterialReceipt_D2_CMD = server.CreateObject("ADODB.command")
        MaterialReceipt_D2_CMD.activeConnection = MM_pigo_STRING
        MaterialReceipt_D2_CMD.commandText = "INSERT INTO [dbo].[MKT_T_MaterialReceipt_D2]([mmID_D2],[mm_poID],[mm_pdID],[mm_pdQty],[mm_pdQtyDiterima],[mm_pdHarga],[mm_pdSubtotal],[mmD2UpdateTime],[mmD2AktifYN]) VALUES('"& mmID_D &"','"& poid &"','"& mm_pdID &"','"& mm_pdQty &"','"& mm_pdQtyDiterima &"',"& harga &","& mm_pdSubtotal &",'"& now() &"','Y')"
        set MaterialReceipt_D2 = MaterialReceipt_D2_CMD.execute

        set UpdatePO_CMD = server.CreateObject("ADODB.command")
        UpdatePO_CMD.activeConnection = MM_pigo_STRING
        UpdatePO_CMD.commandText = "Update MKT_T_PurchaseOrder_D set po_spoID = '"& statuspo &"' where poID_H = '"& poid &"' AND po_pdID = '"& mm_pdID &"'  "
        set UpdatePO = UpdatePO_CMD.execute
        
        UpdatePO_CMD.commandText = "SELECT pdStokAwal FROM MKT_M_PIGO_Produk Where pdID = '"& mm_pdID &"' "
        set ProdukID = UpdatePO_CMD.execute

        Stok = ProdukID("pdStokAwal") + mm_pdQtyDiterima

        UpdatePO_CMD.commandText = "Update MKT_M_PIGO_Produk set pdHarga = '"& harga &"', pdStokAwal = '"& Stok &"' where pdID = '"& mm_pdID &"'  "
        set UpdateHarga = UpdatePO_CMD.execute

        MaterialReceipt_D2_CMD.commandText = "SELECT sum(mm_pdSubtotal) as totalmm FROM MKT_T_MaterialReceipt_D2 WHERE mmID_D2 = '"& mmID_D &"' "
        set totalmm = MaterialReceipt_D2_CMD.execute

        MaterialReceipt_D2_CMD.commandText = "SELECT COUNT(mm_pdID) AS totalpd FROM MKT_T_MaterialReceipt_D2 WHERE mmID_D2 = '"& mmID_D &"' "
        set totalpd = MaterialReceipt_D2_CMD.execute

        MaterialReceipt_D1_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, ISNULL(COUNT(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS PO, ISNULL(COUNT(MKT_T_MaterialReceipt_D2.mm_poID), 0) AS PD FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 Where mmID = '"& mmID_D &"' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal "
        'response.write MaterialReceipt_CMD.commandText & "<br><br>"
        set Status = MaterialReceipt_D1_CMD.execute

    else 
        set MaterialReceipt_D1_CMD = server.CreateObject("ADODB.command")
        MaterialReceipt_D1_CMD.activeConnection = MM_pigo_STRING
        MaterialReceipt_D1_CMD.commandText = "Delete FROM [pigo].[dbo].[MKT_T_MaterialReceipt_D1] Where mmID_D1 = '"& mmID_D &"' and mm_poID = '"& poid &"' "
        set MaterialReceipt_D1 = MaterialReceipt_D1_CMD.execute

        set MaterialReceipt_D2_CMD = server.CreateObject("ADODB.command")
        MaterialReceipt_D2_CMD.activeConnection = MM_pigo_STRING
        MaterialReceipt_D2_CMD.commandText = "Delete FROM [pigo].[dbo].[MKT_T_MaterialReceipt_D2] Where mmID_D2 = '"& mmID_D &"' and mm_poID = '"& poid &"' and mm_pdID = '"& mm_pdID &"' "
        set MaterialReceipt_D2 = MaterialReceipt_D2_CMD.execute

        set UpdatePO_CMD = server.CreateObject("ADODB.command")
        UpdatePO_CMD.activeConnection = MM_pigo_STRING
        UpdatePO_CMD.commandText = "Update MKT_T_PurchaseOrder_D set po_spoID = '"& statuspo &"' where poID_H = '"& poid &"' AND po_pdID = '"& mm_pdID &"'  "
        set UpdatePO = UpdatePO_CMD.execute
        
        UpdatePO_CMD.commandText = "SELECT pdStokAwal FROM MKT_M_PIGO_Produk Where pdID = '"& mm_pdID &"' "
        set ProdukID = UpdatePO_CMD.execute

        Stok = ProdukID("pdStokAwal") - mm_pdQtyDiterima

        UpdatePO_CMD.commandText = "Update MKT_M_PIGO_Produk set pdHarga = '"& harga &"', pdStokAwal = '"& Stok &"' where pdID = '"& mm_pdID &"'  "
        set UpdateHarga = UpdatePO_CMD.execute

        MaterialReceipt_D1_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal, ISNULL(COUNT(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS PO, ISNULL(COUNT(MKT_T_MaterialReceipt_D2.mm_poID), 0) AS PD FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 Where mmID = '"& mmID_D &"' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal "
        'response.write MaterialReceipt_CMD.commandText & "<br><br>"
        set Status = MaterialReceipt_D1_CMD.execute

    end if 
%>
<% if mmIDStatus = "ADD" then %>
<input type="hidden" name="totalmm" id="totalmm" value="<%=totalmm("totalmm")%>">
<input type="hidden" name="idmm" id="idmm" value="<%=mmID_D%>">
<input type="hidden" name="totalpd" id="totalpd" value="<%=totalpd("totalpd")%>">
<input type="hidden" name="idpo" id="idpo" value="<%=poid%>">
<input type="hidden" name="status" id="status" value="<%=Status("PO")%>">
<button class="cont-btn" style="height:1.5rem" onclick="posting()" > SIMPAN MATERIAL RECEIPT </button>
<% else  %>
<input type="hidden" name="idmm" id="idmm" value="<%=mmID_D%>">
<input type="hidden" name="status" id="status" value="<%=Status("PO")%>">
<button class="cont-btn" style="height:1.5rem" onclick="posting()" > SIMPAN MATERIAL RECEIPT </button>
<% end if %>