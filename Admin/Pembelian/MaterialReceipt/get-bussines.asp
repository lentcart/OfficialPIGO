<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    custID = request.queryString("bussines")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String
    BussinesPart_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama,MKT_M_Customer.custPhone1,MKT_M_Customer.custEmail,MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID WHERE MKT_M_Customer.custID = '"& custID &"'  "
    'Response.Write BussinesPart_CMD.commandText & "<br>"
    set BussinesPart = BussinesPart_CMD.execute
        
%>
<div class="row mt-1">
    <div class="col-lg-2 col-md-3 col-sm-12">
        <span class="cont-text">  Supplier ID </span><br>
        <input readonly type="text" class="text-center cont-form" name="supplierid" id="cont" value="<%=BussinesPart("custID")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-3 col-sm-12">
        <span class="cont-text"> Nama Supplier </span><br>
        <input readonly type="text" class="cont-form" name="namasupplier" id="cont" value="<%=BussinesPart("custNama")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-3 col-sm-6">
        <span class="cont-text"> Pay-Term </span><br>
        <input readonly type="text" class="text-center cont-form" name="poterm" id="cont" value="<%=BussinesPart("custPaymentTerm")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-3 col-sm-6">
        <span class="cont-text"> Nama CP Supplier </span><br>
        <input readonly type="text" class="cont-form" name="namacp" id="cont" value="<%=BussinesPart("custNamaCP")%>"><br>
    </div>
</div>
<div class="row">
    <div class="col-lg-6 col-md-6 col-sm-6">
        <span class="cont-text"> Lokasi Supplier </span><br>
        <input readonly type="text" class="cont-form" name="lokasi" id="cont" value="<%=BussinesPart("almlengkap")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-6">
        <span class="cont-text"> Phone </span><br>
        <input readonly type="text" class=" text-center cont-form" name="phone" id="cont" value="<%=BussinesPart("custPhone1")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-6">
        <span class="cont-text"> Email </span><br>
        <input readonly type="text" class="cont-form" name="email" id="cont" value="<%=BussinesPart("custEmail")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-6">
        <span class="cont-text"> NPWP </span><br>
        <input readonly type="text" class=" text-center cont-form" name="npwp" id="cont" value="<%=BussinesPart("custNpwp")%>" ><br>
    </div>
</div>