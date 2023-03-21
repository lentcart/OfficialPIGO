<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    mmID_D	= request.queryString("mmID_D")
    mm_pdID	= request.queryString("mm_pdID")
    mm_pdQty	= request.queryString("mm_pdQty")
    mm_pdQtyDiterima	= request.queryString("mm_pdQtyDiterima")
    mm_pdSubtotal	= request.queryString("mm_pdSubtotal")
    poid	= request.queryString("poid")
    potanggal	= request.queryString("potanggal")
    statuspo	= request.queryString("statuspo")
    harga	= request.queryString("harga")
    sisa	= request.queryString("sisa")
    
    

    set MaterialReceipt_D1_CMD = server.CreateObject("ADODB.command")
    MaterialReceipt_D1_CMD.activeConnection = MM_pigo_STRING
    MaterialReceipt_D1_CMD.commandText = "INSERT INTO [dbo].[MKT_T_MaterialReceipt_D1]([mmID_D1],[mm_poID],[mm_poTanggal],[mmD1UpdateTime],[mmD1AktifYN]) VALUES ('"& mmID_D &"','"& poid &"','"& potanggal &"','"& now() &"','Y')"
    set MaterialReceipt_D1 = MaterialReceipt_D1_CMD.execute

    set MaterialReceipt_D2_CMD = server.CreateObject("ADODB.command")
    MaterialReceipt_D2_CMD.activeConnection = MM_pigo_STRING
    MaterialReceipt_D2_CMD.commandText = "INSERT INTO [dbo].[MKT_T_MaterialReceipt_D2]([mmID_D2],[mm_poID],[mm_pdID],[mm_pdQty],[mm_pdQtyDiterima],[mm_pdHarga],[mm_pdSubtotal],[mm_prYN],[mmD2UpdateTime],[mmD2AktifYN]) VALUES('"& mmID_D &"','"& poid &"','"& mm_pdID &"','"& mm_pdQty &"','"& mm_pdQtyDiterima &"',"& harga &","& mm_pdSubtotal &",'N','"& now() &"','Y')"
    set MaterialReceipt_D2 = MaterialReceipt_D2_CMD.execute

    set UpdateStok_CMD = server.CreateObject("ADODB.command")
    UpdateStok_CMD.activeConnection = MM_pigo_STRING
    UpdateStok_CMD.commandText = "INSERT INTO [dbo].[MKT_M_Stok]([ID],[SCustID],[SProdukID],[TanggalUpdate],[QTYUpdate],[HargaUpdate],[Keterangan],[SUpdateTime],[SAktifYN]) VALUES ('"& mmID_D  &"','"& request.Cookies("custID") &"','"& mm_pdID &"','"& Cdate(date()) &"','"& mm_pdQtyDiterima &"',"& harga &",'Pembelian Produk','"& now() &"','Y')"
    set UpdateStok = UpdateStok_CMD.execute

    set Update_CMD = server.CreateObject("ADODB.command")
    Update_CMD.activeConnection = MM_pigo_STRING
    Update_CMD.commandText = "INSERT INTO [dbo].[MKT_T_PurchaseOrder_R]([poID],[poTanggal],[po_pdID],[po_pdQty],[po_pdHarga],[po_spoID],[po_Ket],[po_custID],[poUpdateID],[poUpdateTime],[poAktifYN]) VALUES ('"& poid &"','"& potanggal &"','"& mm_pdID &"','"& mm_pdQty &"','"& harga &"','"& statuspo &"','Material Receipt','"& request.Cookies("custID") &"','"& request.Cookies("custEmail") &"','"& now() &"','Y')"
    set Update = Update_CMD.execute

    ' set UpdatePO_CMD = server.CreateObject("ADODB.command")
    ' UpdatePO_CMD.activeConnection = MM_pigo_STRING
    ' UpdatePO_CMD.commandText = "Update MKT_T_PurchaseOrder_D set poQtyProduk = '"& sisa &"' where poID_H = '"& poid &"' and po_pdID = '"& mm_pdID &"' "
    'response.write UpdatePO_CMD.commandText
    'set UpdatePO = UpdatePO_CMD.execute

    set UpdatePO_CMD = server.CreateObject("ADODB.command")
    UpdatePO_CMD.activeConnection = MM_pigo_STRING
    UpdatePO_CMD.commandText = "Update MKT_T_PurchaseOrder_D set po_spoID = '"& statuspo &"' where poID_H = '"& poid &"' AND po_pdID = '"& mm_pdID &"'  "
    set UpdatePO = UpdatePO_CMD.execute
    
    UpdatePO_CMD.commandText = "Update MKT_M_PIGO_Produk set pdHarga = '"& harga &"' where pdID = '"& mm_pdID &"'  "
    set UpdateHarga = UpdatePO_CMD.execute


%>