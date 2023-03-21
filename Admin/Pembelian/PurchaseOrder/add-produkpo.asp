<!--#include file="../../../connections/pigoConn.asp"-->

<% 

    poID_H          = request.queryString("poID")
    poTanggal       = request.queryString("poTanggal")
    po_pdID         = request.queryString("po_pdID")
    poQtyProduk     = request.queryString("poQtyProduk")
    poPdUnit        = request.queryString("poPdUnit")
    poHarga         = request.queryString("poHarga")
    poPajak         = request.queryString("poPajak")
    poDiskon        = request.queryString("poDiskon")
    poSubTotal      = request.queryString("poSubTotal")
    poTotal         = request.queryString("poTotal")
    
    set PurchaseOrder_D_CMD = server.CreateObject("ADODB.command")
    PurchaseOrder_D_CMD.activeConnection = MM_pigo_STRING
    PurchaseOrder_D_CMD.commandText = "SELECT * FROM MKT_T_PurchaseOrder_D Where po_pdID  = '"& po_pdID &"' AND poID_H = '"& poID_H &"'  "
    set pdID = PurchaseOrder_D_CMD.execute

%>
<% if pdID.eof = false then %>
    <tr>
        <td colspan="7" class="text-center"> Produk Tersebut Telah Ditambahkan </td>
    </tr>
<% else %>
    <%
        set PurchaseOrder_D_CMD = server.CreateObject("ADODB.command")
        PurchaseOrder_D_CMD.activeConnection = MM_pigo_STRING
        PurchaseOrder_D_CMD.commandText = " INSERT INTO [dbo].[MKT_T_PurchaseOrder_D] ([poID_H],[po_pdID],[poQtyProduk],[poPdUnit],[poHargaSatuan],[poPajak],[poDiskon],[poSubTotal],[poTotal],[po_spoID],[po_tfYN],[poDUpdateTime],[poDAktifYN]) VALUES ('"& poID_H &"','"& po_pdID &"',"& poQtyProduk &",'"& poPdUnit &"',"& poHarga &","& poPajak &","& poDiskon &","& poSubTotal &","& poTotal &",0,'N','"& now() &"','Y') "
        set PurchaseOrder_D = PurchaseOrder_D_CMD.execute

        PurchaseOrder_D_CMD.commandText = "SELECT MKT_T_PurchaseOrder_D.po_pdID, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poPdUnit, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak,MKT_T_PurchaseOrder_D.poSubTotal, MKT_T_PurchaseOrder_D.poTotal, MKT_M_PIGO_Produk.pdNama FROM MKT_T_PurchaseOrder_D LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PurchaseOrder_D.po_pdID = MKT_M_PIGO_Produk.pdID Where MKT_T_PurchaseOrder_D.poID_H = '"& poID_H &"' "
        set produkpo = PurchaseOrder_D_CMD.execute
    %>
    <% 
        no = 0 
        do while not produkpo.eof 
        no = no + 1 
    %>
    <tr>
        <td> <%=no%></td>
        <td> <%=produkpo("po_pdID")%></td>
        <td> <%=produkpo("pdNama")%></td>
        <td> <%=produkpo("poQtyProduk")%></td>
        <td> <%=produkpo("poHargaSatuan")%></td>
        <td> <%=produkpo("poPajak")%></td>
        <td> <%=produkpo("poTotal")%></td>
    </tr>
    <% produkpo.movenext
    loop %>
<% end if %>

