<!--#include file="../../../connections/pigoConn.asp"-->
<% 
    
    payID         = request.form("payID")
    payBukti      = request.form("payBukti")

    set Payment_CMD = server.CreateObject("ADODB.command")
    Payment_CMD.activeConnection = MM_pigo_STRING
    set Jurnal_H_CMD = server.CreateObject("ADODB.command")
    Jurnal_H_CMD.activeConnection = MM_pigo_STRING

    Payment_CMD.commandText = "SELECT * FROM MKT_T_Payment_H WHERE payID = '"& payID &"' "
    response.write Payment_CMD.commandText & "<br><br><br>"
    set Payment = Payment_CMD.execute

    Payment_CMD.commandText = "UPDATE MKT_T_Payment_H set payBukti = '"& payBukti &"' WHERE payID = '"& payID &"'  "
    response.write Payment_CMD.commandText & "<br><br><br>"
    set UpdatePayment = Payment_CMD.execute
    
        Payment_CMD.commandText = "SELECT MKT_T_Payment_H.payID, MKT_T_Payment_H.payDesc, MKT_T_Payment_D.pay_Ref, MKT_T_Payment_H.payType, MKT_T_Payment_D.pay_Total, MKT_T_Payment_D.pay_Dibayar, MKT_T_Payment_D.pay_Sisa, MKT_T_Payment_D.pay_Subtotal,  MKT_T_Payment_D.pay_Tax FROM MKT_T_Payment_D RIGHT OUTER JOIN MKT_T_Payment_H ON MKT_T_Payment_D.payID_H = MKT_T_Payment_H.payID WHERE MKT_T_Payment_H.PayID = '"& payID &"'  "
        response.write Payment_CMD.commandText & "<br><br><br>"
        set Payment_H = Payment_CMD.execute
        response.write Payment_H("payType") & "<br><br><br>"

        if Payment_H("payType") = "02" then 
            do while not Payment_H.eof

                Total = Payment_H("pay_Dibayar")

                Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A100.02.01','"& Payment_H("payDesc")&"/"&payID&"','"& Total &"',0 )"
                response.write Jurnal_H_CMD.commandText  & "<br><br>"
                set JurnalD1 = Jurnal_H_CMD.execute

                SubTotal = SubTotal + Total

            Payment_H.movenext
            loop

            Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A102.02.00','"& "Payment-AP/"&payID &"',0,'"& SubTotal&"' )"
            response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set JurnalD2 = Jurnal_H_CMD.execute

            Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& CDate(now()) &"','"& "Penerimaan Pembayaran/"&payID  &"','T','N','N','N','"& session("username") &"','PY','Y'"
            response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set Jurnal = Jurnal_H_CMD.execute

            Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan FROM GL_T_Jurnal_D WHERE RIGHT(JRD_Keterangan,18) = '"& payID &"' and JRD_ID = ''  "
            response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set ListJurnalD = Jurnal_H_CMD.execute
            
            no = 0
            Do While Not ListJurnalD.eof
            no = no + 1
            nourut=right("0000000"&no,7)

            Keterangan       = ListJurnalD("JRD_Keterangan")

                Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& Jurnal("id")&nourut &"' WHERE JRD_Keterangan = '"& Keterangan &"' and JRD_ID = ''   "
                response.write Jurnal_H_CMD.commandText  & "<br><br>"
                set UpdateJurnalD = Jurnal_H_CMD.execute

            ListJurnalD.movenext
            loop
        else
            do while not Payment_H.eof

                Total = Payment_H("pay_Dibayar")

                Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','B100.01.00','"& Payment_H("payDesc")&"/"&payID&"','"& Total &"',0 )"
                response.write Jurnal_H_CMD.commandText  & "<br><br>"
                set JurnalD1 = Jurnal_H_CMD.execute

                SubTotal = SubTotal + Total

            Payment_H.movenext
            loop

            Jurnal_H_CMD.commandText = "INSERT INTO [dbo].[GL_T_Jurnal_D]([JRD_ID],[JRD_CA_ID],[JRD_Keterangan],[JRD_Debet],[JRD_Kredit])VALUES('','A100.02.01','"& "Payment-AP/"&payID &"',0,'"& SubTotal &"' )"
            response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set JurnalD2 = Jurnal_H_CMD.execute

            Jurnal_H_CMD.commandText = "exec sp_add_GL_T_Jurnal_H '"& CDate(now()) &"','"& "Pembayaran INV-AP/"&payID  &"','K','N','N','N','"& session("username") &"','PY','Y'"
            response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set Jurnal = Jurnal_H_CMD.execute

            Jurnal_H_CMD.commandText = "SELECT JRD_Keterangan FROM GL_T_Jurnal_D WHERE RIGHT(JRD_Keterangan,18) = '"& payID &"' and JRD_ID = ''  "
            response.write Jurnal_H_CMD.commandText  & "<br><br>"
            set ListJurnalD = Jurnal_H_CMD.execute
            
            no = 0
            Do While Not ListJurnalD.eof
            no = no + 1
            nourut=right("0000000"&no,7)

            Keterangan       = ListJurnalD("JRD_Keterangan")

                Jurnal_H_CMD.commandText = "UPDATE GL_T_Jurnal_D set JRD_ID = '"& Jurnal("id")&nourut &"' WHERE JRD_Keterangan = '"& Keterangan &"' and JRD_ID = ''   "
                response.write Jurnal_H_CMD.commandText  & "<br><br>"
                set UpdateJurnalD = Jurnal_H_CMD.execute

            ListJurnalD.movenext
            loop
        end if 
        
    set Update_CMD = server.CreateObject("ADODB.command")
    Update_CMD.activeConnection = MM_pigo_STRING
    Update_CMD.commandText = "UPDATE MKT_T_Payment_H set paypostingYN = 'Y' , pay_JR_ID = '"& Jurnal("id") &"' Where payID = '"& payID &"' "
    set UpdatePembayaran = Update_CMD.execute

%>
