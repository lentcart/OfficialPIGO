
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    custID = request.queryString("bussines")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String

    BussinesPart_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama,MKT_M_Customer.custNama,MKT_M_Customer.custPhone1,MKT_M_Customer.custEmail,MKT_M_Customer.custNPWP, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID WHERE MKT_M_Customer.custID = '"& custID &"' "
    'Response.Write BussinesPart_CMD.commandText & "<br>"


set BussinesPart = BussinesPart_CMD.execute
        
        ' response.ContentType = "application/json;charset=utf-8"
		' response.write "["
        ' do until  dproduk.eof
        '     response.write "{"
		' 		response.write """SupplierID""" & ":" &  """" & dproduk("spID") &  """" & ","
		' 		response.write """KeySearch""" & ":" &  """" & dproduk("spKey") &  """" & ","
		' 		response.write """NamaSupplier""" & ":" &  """" & dproduk("spNama1") &  """" 
		' 		response.write """NamaCP""" & ":" &  """" & dproduk("spNamaCP") &  """" 
		' 		response.write """AlamatSP""" & ":" &  """" & dproduk("spAlamat") &  """" 
        '     response.write "}"
        ' dproduk.movenext
        ' loop 
        ' response.write "]"
        
%>
<div class="row">
    <div class="col-lg-2 col-md-6 col-sm-12">
        <span class="cont-text">  BussinesPartner ID </span><br>
        <input readonly type="text" class="text-center mb-1 cont-form" name="supplierid" id="cont" value="<%=BussinesPart("custID")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12">
        <span class="cont-text"> Nama BussinesPartner </span><br>
        <input readonly type="text" class=" mb-1 cont-form" name="namasupplier" id="cont" value="<%=BussinesPart("custNama")%>" ><br>
    </div>
    <div class="col-lg-1 col-md-2 col-sm-12">
        <span class="cont-text"> PayTerm</span><br>
        <input readonly type="text" class=" text-center mb-1 cont-form" name="poterm" id="cont" value="<%=BussinesPart("custPaymentTerm")%>" ><br>
    </div>
    <div class="col-lg-5 col-md-10 col-sm-12">
        <span class="cont-text"> Nama CP BussinesPartner </span><br>
        <input readonly type="text" class=" mb-1 cont-form" name="namacp" id="cont" value="<%=BussinesPart("custNamaCP")%>" ><br>
    </div>
</div>
<div class="row">
    <div class="col-lg-6 col-md-6 col-sm-12">
        <span class="cont-text"> Lokasi BussinesPartner </span><br>
        <input readonly type="text" class=" mb-1 cont-form" name="lokasi" id="cont" value="<%=BussinesPart("almLengkap")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-12">
        <span class="cont-text"> Phone </span><br>
        <input readonly  type="text" class="  text-center cont-form" name="Phone" id="cont" value="<%=BussinesPart("custPhone1")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-12">
        <span class="cont-text"> Email </span><br>
        <input readonly  type="text" class="  cont-form" name="Email" id="cont" value="<%=BussinesPart("custEmail")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-12">
        <span class="cont-text"> NPWP </span><br>
        <input readonly  type="text" class=" text-center  cont-form" name="NPWP" id="cont" value="<%=BussinesPart("custNpwp")%>" ><br>
    </div>
</div>