
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    bpID = request.queryString("bussines")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String
    BussinesPart_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1, MKT_M_Customer.custEmail, MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP,  MKT_M_Alamat.almLengkap, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkID, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, GLB_M_Bank.BankName FROM MKT_M_Rekening LEFT OUTER JOIN GLB_M_Bank ON MKT_M_Rekening.rkBankID = GLB_M_Bank.BankID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Rekening.rk_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID WHERE MKT_M_Customer.custID = '"& bpID &"'  "
    'Response.Write BussinesPart_CMD.commandText & "<br>"
    set BussinesPart = BussinesPart_CMD.execute
%>
<div class="row">
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text">  Bussines Partner ID </span><br>
        <input readonly type="text" class=" mb-2 cont-form" name="pay_custID" id="cont" value="<%=BussinesPart("custID")%>"  ><br>
    </div>
    <div class="col-lg-4 col-md-8 col-sm-12">
        <span class="cont-text">  Nama Bussines Partner </span><br>
        <input readonly type="text" class=" mb-2 cont-form" name="namasupplier" id="cont" value="<%=BussinesPart("custNama")%>"  ><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text"> PaymentTerm </span><br>
        <input readonly type="text" class="text-center mb-2 cont-form" name="poterm" id="cont" value="<%=BussinesPart("custPaymentTerm")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-8 col-sm-12">
        <span class="cont-text"> Nama CP BussinesPartner </span><br>
        <input readonly type="text" class=" mb-2 cont-form" name="namacp" id="cont" value="<%=BussinesPart("custNamaCP")%>"><br>
    </div>
</div>
<div class="row">
    <div class="col-lg-6 col-md-12 col-sm-12">
        <span class="cont-text"> Lokasi BussinesPartner </span><br>
        <input readonly type="text" class=" mb-2 cont-form" name="alamat" id="cont" value="<%=BussinesPart("almLengkap")%>"><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text"> BANK </span><br>
        <input readonly type="hidden" class="text-center mb-2 cont-form" name="pay_rkID" id="cont" value="<%=BussinesPart("rkID")%>" >
        <input readonly type="hidden" class="text-center mb-2 cont-form" name="bankid" id="cont" value="<%=BussinesPart("rkBankID")%>" >
        <input readonly type="text" class="text-center mb-2 cont-form" name="payBank" id="cont" value="<%=BussinesPart("BankName")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text"> No Rekening </span><br>
        <input readonly type="text" class="text-center mb-2 cont-form" name="payNoRek" id="cont" value="<%=BussinesPart("rkNomorRk")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text"> Nama Pemilik Rek </span><br>
        <input readonly type="text" class=" mb-2 cont-form" name="pemilikrek" id="cont" value="<%=BussinesPart("rkNamaPemilik")%>"><br>
    </div>
</div>
