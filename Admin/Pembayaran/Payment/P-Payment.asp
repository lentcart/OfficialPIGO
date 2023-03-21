<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    payBank	= request.form("namabank")
    payType	= request.form("typepayment")
    payTanggal	= request.form("tglpayment")
    payTanggalAcc	= request.form("tglaccount")
    payDesc	= request.form("desc")
    pay_prID	= request.form("noinvoice")
    pay_spID	= request.form("supplierid")


        
    set Payment_H_CMD = server.CreateObject("ADODB.command")
    Payment_H_CMD.activeConnection = MM_pigo_STRING
    Payment_H_CMD.commandText = "exec sp_add_MKT_T_Payment '"& payBank &"','"& payType &"','"& payTanggal &"','"& payTanggalAcc &"','"& payDesc &"','"& pay_spID &"',2 "
    response.write Payment_H_CMD.commandText
    set Payment_H = Payment_H_CMD.execute

    response.redirect "get-invoice.asp?payID=" & trim(Payment_H("id"))

%>