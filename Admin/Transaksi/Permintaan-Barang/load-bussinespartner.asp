
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    custID = request.queryString("keysupplier")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String

    BussinesPart_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama,MKT_M_Customer.custPhone1,MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap,MKT_M_Alamat.almKota FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID WHERE MKT_M_Customer.custID = '"& custID &"' "
    'Response.Write BussinesPart_CMD.commandText & "<br>"

    set BussinesPart = BussinesPart_CMD.execute

%>
<div class="row mt-1">
    <div class="col-lg-2 col-md-4 col-sm-3">
        <span class="cont-text">  Bussines Partner ID </span><br>
        <input readonly type="text" class="cont-form" name="supplierid" id="cont" value="<%=BussinesPart("custID")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-8 col-sm-9">
        <span class="cont-text"> Nama Bussines Partner </span><br>
        <input readonly type="text" class="cont-form" name="namasupplier" id="cont" value="<%=BussinesPart("custNama")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-6 col-sm-6">
        <span class="cont-text">  Phone </span><br>
        <input readonly type="text" class=" text-center cont-form" name="phone" id="cont" value="<%=BussinesPart("custPhone1")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-6">
        <span class="cont-text"> Nama CP </span><br>
        <input readonly type="text" class="cont-form" name="namacp" id="cont" value="<%=BussinesPart("custNamaCP")%>" ><br>
    </div>
</div>
<div class="row mt-1">
    <div class="col-lg-6 col-md-6 col-sm-12">
        <span class="cont-text">  Alamat </span><br>
        <input readonly type="text" class="cont-form" name="alamat" id="cont" value="<%=BussinesPart("almLengkap")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-3 col-sm-6">
        <span class="cont-text"> Kota </span><br>
        <input readonly type="text" class="cont-form" name="kota" id="cont" value="<%=BussinesPart("almKota")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-3 col-sm-6">
        <span class="cont-text">  NPWP </span><br>
        <input readonly type="text" class=" text-center cont-form" name="npwp" id="cont" value="<%=BussinesPart("custNpwp")%>"><br>
    </div>
</div>