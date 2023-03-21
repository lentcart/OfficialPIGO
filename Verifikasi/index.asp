<!--#include file="../connections/pigoConn.asp"--> 

<% 

verifCode = request.queryString("b")
response.write verifCode &"<br><br>"

set Verif_CMD = server.CreateObject("ADODB.command")
	Verif_CMD.activeConnection = MM_pigo_STRING

    Verif_CMD.commandText = " select custID_H, verifCode from GLB_T_Verifikasi where verifCode = '"& verifCode &"' "
    response.write Verif_CMD.commandText &"<br><br>"

    set verif = Verif_CMD.execute 

    if verif.EOF = true then 

        response.write(" Kode Verifikasi Tidak Sesuai atau Expired") &"<br><br>"

    else 

    set UpdateCustomer_CMD = server.CreateObject("ADODB.command")
	UpdateCustomer_CMD.activeConnection = MM_pigo_STRING

    UpdateCustomer_CMD.commandText = " update MKT_M_Customer set custVerified = 'Y' where custID = '"& verif("custID_H") &"'   "

    UpdateCustomer_CMD.execute

    UpdateCustomer_CMD.commandText = " update MKT_M_Seller set slVerified = 'Y' where sl_custID = '"& verif("custID_H") &"'   "

    UpdateCustomer_CMD.execute

    UpdateCustomer_CMD.commandText = " delete from GLB_T_Verifikasi where verifCode = '"& verifCode &"' "

    UpdateCustomer_CMD.execute

    response.redirect("Success.html")

    end if



%> 