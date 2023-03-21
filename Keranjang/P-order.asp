<!--#include file="../../connections/pigoConn.asp"-->

<% 


    dim ps_trID, ps_tglTransaksi, ps_trQty, ps_pdCustID, ps_pdID, ps_trOngkir, ps_trJenisPengiriman, ps_custID, ps_trSubtotal, ps_trJenisPembayaran, psKet, psStatusTransaksi, psKodeBayar, psRekening, psBank, psTotalBayar
    
    ps_trID = request.form("kodetransaksi")
    ps_tglTransaksi = request.form("tgltransaksi")
    ps_trQty = request.form("trqty")
    ps_pdCustID = request.form("kdpdcust")
    ps_pdID = request.form("idpd")
    ps_trOngkir = request.form("ongkir")
    ps_trJenisPengiriman = request.form("jenispengiriman")
    ps_custID = request.form("idcust")
    ps_trSubtotal = request.form("subtotal")
    ps_trJenisPembayaran = request.form("jenispembayaran")
    psKet = request.form("ktt")
    psStatusTransaksi = request.form("statustransaksi")
    psKodeBayar = request.form("kodebayar")
    psRekening = request.form("rekening")
    psBank = request.form("bank")
    psTotalBayar = request.form("totalbayar")

    set order_CMD = server.CreateObject("ADODB.command")
    order_CMD.activeConnection = MM_pigo_STRING

    order_CMD.commandText = "exec sp_add_MKT_T_Pesanan '"& ps_trID &"','"& ps_tglTransaksi &"',"& ps_trQty &",'"& ps_pdCustID &"','"& ps_pdID &"',"& ps_trOngkir &",'"& ps_trJenisPengiriman &"','"& ps_custID &"',"& ps_trSubtotal &",'"& ps_trJenisPembayaran &"','"& psKet &"',"& psStatusTransaksi &",'"& psKodeBayar &"','"& psRekening &"','"& psBank &"',"& psTotalBayar &" "
    'response.write order_CMD.commandText
    set order = order_CMD.execute

    set delete_CMD = server.CreateObject("ADODB.command")
    delete_CMD.activeConnection = MM_pigo_STRING

    delete_CMD.commandText = "DELETE FROM [dbo].[MKT_T_Keranjang_H] WHERE cart_custID = '"& ps_custID  &"' and cart_pdID = '"& ps_pdID &"'"
    'response.write delete_CMD.commandText
    set delete = delete_CMD.execute



    Response.redirect "../../"
%> 

