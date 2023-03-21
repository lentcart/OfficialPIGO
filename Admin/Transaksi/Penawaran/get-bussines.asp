<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    custID = request.queryString("bussines")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String
    BussinesPart_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama,MKT_M_Customer.custPhone1,MKT_M_Customer.custEmail,MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap , MKT_M_Alamat.almKota FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID WHERE MKT_M_Customer.custID = '"& custID &"'  "
    'Response.Write BussinesPart_CMD.commandText & "<br>"
    set BussinesPart = BussinesPart_CMD.execute
        
%>
<div class="row mt-1">
    <div class="col-lg-6 col-md-63 col-sm-12">
        <span class="cont-text"> Nama Supplier </span><br>
        <input required type="text" class="cont-form" name="namacust" id="cont" value="<%=BussinesPart("custNama")%>" ><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-6">
        <span class="cont-text"> Phone </span><br>
        <input required type="text" class="cont-form" name="phonecust" id="cont" value="<%=BussinesPart("custPhone1")%>" ><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-6">
        <span class="cont-text"> Email </span><br>
        <input required type="text" class="cont-form" name="emailcust" id="cont" value="<%=BussinesPart("custEmail")%>"><br>
    </div>
</div>
<div class="row">
    <div class="col-lg-6 col-md-6 col-sm-12">
        <span class="cont-text"> Lokasi Bussines Partner </span><br>
        <input required type="text" class="cont-form" name="alamatlengkap" id="cont" value="<%=BussinesPart("almlengkap")%>" ><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-6">
        <span class="cont-text"> Kota </span><br>
        <input required type="text" class="cont-form" name="kota" id="cont" value="<%=BussinesPart("almKota")%>" ><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-6">
        <span class="cont-text"> Nama Contact Person </span><br>
        <input required type="text" class="cont-form" name="namacp" id="cont" value="<%=BussinesPart("custNamaCP")%>" ><br>
    </div>
</div>