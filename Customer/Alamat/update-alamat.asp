<!--#include file="../../connections/pigoConn.asp"--> 

<% 
id= request.form("id")

set update_CMD = server.CreateObject("ADODB.command")
update_CMD.activeConnection = MM_pigo_STRING

    update_CMD.commandText = "select * from MKT_M_Alamat where alm_custID  = '"& id &"' "
    ' response.write update_CMD.commandText
    set updatealm = update_CMD.execute

    dim data(10)
    data(0) = updatealm("almNamaPenerima")
    data(1) = updatealm("almPhonePenerima")
    data(2) = updatealm("almLabel")
    data(3) = updatealm("almProvinsi")
    data(4) = updatealm("almKota")
    data(5) = updatealm("almKec")
    data(6) = updatealm("almKel")
    data(7) = updatealm("almKdpos")
    data(8) = updatealm("almLengkap")
    data(9) = updatealm("almDetail")
    
    For Each x In data
        response.write(x & ",")
    Next
%> 