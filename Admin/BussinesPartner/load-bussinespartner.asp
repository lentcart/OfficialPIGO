<!--#include file="../../connections/pigoConn.asp"--> 

<% 

    custID = request.queryString("custID")
    set Bank_cmd =  server.createObject("ADODB.COMMAND")
    Bank_cmd.activeConnection = MM_PIGO_String

    Bank_cmd.commandText = "select * from GLB_M_Bank "
    set Bank = Bank_CMD.execute
    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String
    BussinesPart_CMD.commandText = "SELECT MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almLengkap, MKT_M_Rekening.rkBankID, MKT_M_Rekening.rkNomorRk, MKT_M_Rekening.rkNamaPemilik, GLB_M_Bank.BankName,  MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2 FROM MKT_M_Rekening RIGHT OUTER JOIN GLB_M_Bank ON MKT_M_Rekening.rkBankID = GLB_M_Bank.BankID RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Rekening.rk_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Customer.custID = MKT_M_Alamat.alm_custID Where MKT_M_Customer.custID = '"& custID &"' AND rkJenis = 'Rekening Customer' "
    'Response.Write BussinesPart_CMD.commandText & "<br>"
    set BussinesPart = BussinesPart_CMD.execute

%>
<div class="row align-items-center mt-2">
    <div class="col-lg-2 col-md-6 col-sm-12">
        <span class="cont-text"> Status Kredit </span><br>
        <select required  class="  cont-form" name="statuskredit" id="statuskredit" aria-label="Default select example" >
            <option value="">Pilih</option>
            <option value="1">Kredit</option>
            <option value="2">Cash</option>
        </select><br>
    </div>
    <div class="col-lg-2 col-md-6 col-sm-12">
        <span class="cont-text"> Pembayaran </span><br>
        <select required  class="  cont-form" name="jpembayaran" id="jpembayaran" aria-label="Default select example" >
            <option selected>Pilih</option>
            <option value="1">Transfer</option>
            <option value="2">Cash</option>
            <option value="3">On Credit</option>
            <option value="4">Direct Deposit</option>
            <option value="5">Direct Debit</option>
        </select><br>
    </div>
    <div class="col-lg-2 col-md-3 col-sm-12">
        <input checked  type="checkbox" class=" mt-4" name="statustax" id="statustax" value="PO">
        <label required for="statustax" class="cont-text"> PO Tax Exempt </label>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12">
        <span class="cont-text"> Deskripsi </span><br>
        <input required type="text" class="  cont-form" name="deskripsi" id="deskripsi" value="" placeholder="Masukan Keterangan dari PT/CV/TOKO DLL "><br>
    </div>
    <div class="col-lg-2 col-md-3 col-sm-12">
        <span class="cont-text"> PO Payment Term </span><br>
        <input required type="number" class="text-center  cont-form" name="jangkawaktu" id="jangkawaktu" value="30"><br>
    </div>
</div>
<div class="row mt-2 align-items-center">
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text">  </span><br>
        <input checked  type="checkbox" class="" name="group" id="group" value="V">
        <label required for="group" class="cont-text"> Vendor </label>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text">  </span><br>
        <input checked  type="checkbox" class="" name="jtransaksi" id="jtransaksi" value="2">
        <label required for="jtransaksi" class="cont-text"> Pembelian </label>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text"> NPWP </span><br>
        <input onkeyup="validasiform()" required type="text" class=" text-center cont-form" name="npwp" id="npwp" value="" maxlength="15" style="font-size:12px"><br>
    </div>
    <div class="col-lg-6 col-md-12 col-sm-12">
        <input onchange="alamatnpwpp()"  type="checkbox" class="" name="cekbox" id="cekbox" value="">
        <label required for="cekbox" class="cont-text"> Sesuai Alamat Perusahaan </label>
        <input required type="text" class="cont-form" name="alamatnpwp" id="alamatnpwp" value="" placeholder="Masukan Alamat NPWP "><br>
    </div>
</div>
<div class="row mt-2 text-center">
    <div class="col-12">
        <div class="cont-label-text">
            <span class="cont-text"> Lokasi </span>
        </div>
    </div>
</div>
<div class="row mt-2">
    <div class="col-lg-6 col-md-12 col-sm-12">
        <span class="cont-text"> Alamat Lengkap Perusahaan </span><br>
        <input required type="text" class=" AlamatPerusahaan cont-form" name="alamatlengkap" id="alamatlengkap" value="<%=BussinesPart("almLengkap")%>" placeholder="Co: Nama Jalan/RT/No/Blok/Kel/Kec"><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text"> No Telp 1 </span><br>
        <input  onkeyup="validasiform()" required type="text" class="text-center cont-form" name="phone1" id="phone1" value="<%=BussinesPart("custPhone1")%>" maxlength="13" placeholder="No Telepon Perusahaan"><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text"> No Telp 2 </span>&nbsp;<span style="color:red; font-size:11px"><b><i>( opsional )</b></i></span><br>
        <input required type="text" class="text-center cont-form" name="phone2" id="phone2" value="<%=BussinesPart("custPhone2")%>"  maxlength="13" placeholder="No Telepon Perusahaan"><br>
    </div>
    <div class="col-lg-2 col-md-4 col-sm-12">
        <span class="cont-text"> Fax (021)</span><br>
        <input onkeyup="validasiform()" required type="text" class="text-center  cont-form" name="fax" id="fax" value="" maxlength="10" placeholder="Masukan No Fax"><br>
    </div>
</div>
<div class="row mt-2">
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> Provinsi </span><br>
        <input  required type="text" class="cont-form" name="provinsi" id="provinsi"  value="<%=BussinesPart("almProvinsi")%>"><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> Kota </span><br>
        <input  required type="text" class="cont-form" name="kab" id="kab" value="<%=BussinesPart("almKota")%>" placeholder="Masukan Kota/Kab" ><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> Email  </span><br>
        <input onblur="validasiEmail()" required type="text" class="cont-form" name="emailpr" id="emailpr" value="<%=BussinesPart("custEmail")%>" placeholder="Masukan Alamat Email Perusahaan"><br>
    </div>
    <div class="col-lg-2 col-md-3 col-sm-12">
        <span class="cont-text">  </span><br>
        <input checked  type="checkbox" class="" name="wpenjualan" id="wpenjualan" value="Standard">
        <label required for="wpenjualan" class="cont-text"> Sales Region </label>
    </div>
</div>
<div class="row mt-2 text-center">
    <div class="col-12">
        <div class="cont-label-text">
            <span class=" cont-text"> Akun BANK </span>
        </div>
    </div>
</div>
<div class="row mt-2">
    <div class="col-lg-6 col-md-6 col-sm-12">
        <span class="cont-text"> Nama Bank  </span><br>
        <select  class=" cont-form" name="idBank" id="idBank" required>
            <option value="<%=BussinesPart("rkBankID")%>"><%=BussinesPart("BankName")%></option>
            <% do while not Bank.eof %>
            <option value="<%=Bank("BankID")%>"><%=Bank("BankName")%></option>
            <% Bank.movenext
            loop %>
        </select>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> No Rekening </span><br>
        <input required type="number" class="  cont-form" name="norekening" id="norekening" value="<%=BussinesPart("rkNomorRk")%>" placeholder="Nomor Rekening Perusahaan"><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> Nama Pemilik Rekening </span><br>
        <input required type="text" class="cont-form" name="pemilikrek" id="pemilikrek" value="a.n <%=BussinesPart("rkNamaPemilik")%>"><br>
    </div>
</div>
<div class="row mt-2 text-center">
    <div class="col-12">
        <div class="cont-label-text">
            <span class=" cont-text"> Orang Yang Dapat Dihubungi </span>
        </div>
    </div>
</div>
<div class="row mt-2">
    <div class="col-lg-6 col-md-6 col-sm-12">
        <span class="cont-text"> Nama </span><br>
        <input required type="text" class="  cont-form" name="namacp" id="namacp" value="" placeholder="Masukan Nama Lengkap Orang Yang Dapat Dihubungi (CP)"><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> No Telp/HandPhone </span><br>
        <input onkeyup="validasiform()" required type="text" class=" cont-form" name="phonecp" id="phonecp" value="" maxlength="13" placeholder="Masukan No Handphone CP"><br>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12">
        <span class="cont-text"> Email  CP</span>&nbsp;<span style="color:red; font-size:11px"><b><i>Jika Tidak Ada Masukan (-)</b></i></span><br>
        <input onblur="validasiEmailcp()" required type="text" class="  cont-form" name="emailcp" id="emailcp" value="" placeholder="Masukan Alamat Email CP" ><br>
    </div>
</div>
<div class="row mt-2">
    <div class="col-lg-6 col-md-6 col-sm-12">
        <input onchange="alamatnpwpp()"  type="checkbox" class="" name="cekboxcp" id="cekboxcp" value="">
        <label required for="cekbox" class="cont-text"> Sesuai Alamat Perusahaan </label>
        <input required type="text" class="  cont-form" name="alamatcp" id="alamatcp" value="" placeholder="Masukan Alamat Contact Person"><br>
    </div>
    <div class="col-lg-6 col-md-6 col-sm-12">
        <span class="cont-text"> Jabatan </span><br>
        <input required type="text" class="  cont-form" name="jabatancp" id="jabatancp" value="" placeholder="Masukan Jabatan CP"><br>
    </div>
</div>