<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    custID = request.queryString("bussines")

    set BussinesPart_CMD = server.createObject("ADODB.COMMAND")
	BussinesPart_CMD.activeConnection = MM_PIGO_String
    BussinesPart_CMD.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama,MKT_M_Customer.custPhone1,MKT_M_Customer.custEmail,MKT_M_Customer.custNpwp, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID WHERE MKT_M_Customer.custID = '"& custID &"'  "
    'Response.Write BussinesPart_CMD.commandText & "<br>"
    set BussinesPart = BussinesPart_CMD.execute

    set MaterialReceipt_CMD = server.createObject("ADODB.COMMAND")
	MaterialReceipt_CMD.activeConnection = MM_PIGO_String
    MaterialReceipt_CMD.commandText = "SELECT MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 WHERE mm_custID = '"& custID &"' and mm_tfYN = 'N' GROUP BY MKT_T_MaterialReceipt_H.mmID, MKT_T_MaterialReceipt_H.mmTanggal "
    'Response.Write MaterialReceipt_CMD.commandText & "<br>"
    set MaterialReceipt = MaterialReceipt_CMD.execute
        
%>
<div class="row mt-1">
    <div class="col-lg-2 col-md-3 col-sm-12">
        <span class="cont-text">  Supplier ID </span><br>
        <input readonly type="text" class="cont-form" name="TF_custID" id="cont" value="<%=BussinesPart("custID")%>" ><br>
    </div>
    <div class="col-lg-4 col-md-3 col-sm-12">
        <span class="cont-text"> Nama Supplier </span><br>
        <input readonly type="text" class="cont-form" name="namasupplier" id="cont" value="<%=BussinesPart("custNama")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-3 col-sm-6">
        <span class="cont-text"> Pay-Term </span><br>
        <input readonly type="text" class="cont-form" name="poterm" id="cont" value="<%=BussinesPart("custPaymentTerm")%>" ><br>
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
        <input readonly type="text" class="cont-form" name="phone" id="cont" value="<%=BussinesPart("custPhone1")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-6">
        <span class="cont-text"> Email </span><br>
        <input readonly type="text" class="cont-form" name="email" id="cont" value="<%=BussinesPart("custEmail")%>" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-6">
        <span class="cont-text"> NPWP </span><br>
        <input readonly type="text" class="cont-form" name="npwp" id="cont" value="<%=BussinesPart("custNpwp")%>" ><br>
    </div>
</div>
<div class="row mt-3 align-items-center">
    <div class="col-lg-4 col-md-4 col-sm-4">
        <span class="cont-text"> Material Receipt </span><br>
        <select onchange="getMaterialReceipt()" class="TFD_mmID text-center cont-form" name="TFD_mmID" id="TFD_mmID" aria-label="Default select example" required>
            <option value="">Silahkan Pilih Material Receipt </option>
            <% do while not MaterialReceipt.eof%>
            <option value="<%=MaterialReceipt("mmID")%>"><%=MaterialReceipt("mmID")%> &nbsp; <%=MaterialReceipt("mmTanggal")%> </option>
            <% MaterialReceipt.movenext
            loop%>
        </select>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-6 cont-mmID">
        <span class="cont-text"> Total Material Receipt </span><br>
        <input readonly type="number" class="text-center cont-form" name="TFD_TotalMM" id="TFD_TotalMM" value="0" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-6">
        <span class="cont-text"> Jumlah Tukar Faktur </span><br>
        <input onkeyup="total()" type="number" class="text-center cont-form" name="TFD_TotalTukarFaktur" id="TFD_TotalTukarFaktur" value="0" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-6">
        <span class="cont-text">  </span><br>
        <input readonly type="number" class="text-center cont-form" name="TFD_SisaMM" id="TFD_SisaMM" value="0" ><br>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-6">
        <span class="cont-text">  </span><br>
        <button onclick="addTukarFaktur()" class="cont-btn" id="addreceipt"> Add Receipt </button>
    </div>
</div>
<script>
    function getMaterialReceipt(){
        $.ajax({
            type: "get",
            url: "get-materialreceipt.asp?TFD_mmID="+document.getElementById("TFD_mmID").value,
            success: function (url) {
                $('.cont-mmID').html(url);
            }
        });
    }
    function total(){
        var TFD_TotalMM = $('input[name=TFD_Total]').val();
        var TFD_TotalTukarFaktur = $('input[name=TFD_TotalTukarFaktur]').val();
        var TFD_SisaMM = $('input[name=TFD_SisaMM]').val();
        var Subtotal = TFD_TotalMM-TFD_TotalTukarFaktur
        var Total = Math.round(Subtotal);
        $('input[name=TFD_SisaMM]').val(Total);
    }
    document.addEventListener("DOMContentLoaded", function(event) {
        total();
    });

    function addTukarFaktur() {
        var TF_ID                   = $('input[name=TF_ID]').val();
        var TF_Tanggal              = $('input[name=TF_Tanggal]').val();
        var TF_Invoice              = $('input[name=TF_Invoice]').val();
        var TF_FakturPajak          = $('input[name=TF_FakturPajak]').val();
        var TF_SuratJalan           = $('input[name=TF_SuratJalan]').val();
        var TF_Status               = $('input[name=TF_Status]').val();
        var TF_custID               = $('input[name=TF_custID]').val();
        var TFD_mmID                = $('select[name=TFD_mmID]').val();
        var TFD_TotalMM             = $('input[name=TFD_Total]').val();
        var TFD_TotalTukarFaktur    = $('input[name=TFD_TotalTukarFaktur]').val();
        var TFD_SisaMM              = $('input[name=TFD_SisaMM]').val();
        if (TFD_TotalTukarFaktur == "0"){
            $('#TFD_TotalTukarFaktur').focus();
        }else{
            $.ajax({
                type: "GET",
                url: "add-TukarFaktur.asp",
                    data:{
                    TF_ID,
                    TF_Tanggal,
                    TF_FakturPajak,
                    TF_SuratJalan,
                    TF_Invoice,
                    TF_Status,
                    TF_custID,
                    TFD_mmID,
                    TFD_TotalMM,
                    TFD_TotalTukarFaktur,
                    TFD_SisaMM
                },
                success: function (data) {
                    $('.data-TukarFaktur').html(data);
                    $('select[name=TFD_mmID]').val('');
                    $('input[name=TFD_Total]').val(0);
                    $('input[name=TFD_TotalMM]').val(0);
                    $('input[name=TFD_TotalTukarFaktur]').val(0);
                    $('input[name=TFD_SisaMM]').val(0);
                }
            }); 
            // $('.TFD_mmID')focus();
            $('#bussinespartner').attr('disabled',true);
                var permintaan = document.querySelectorAll("[id^=cont]");
                
                for (let i = 0; i < permintaan.length; i++) {
                    permintaan[i].setAttribute("readonly", true);
                    permintaan[i].setAttribute("disabled", true);
                } 
        }   
    }
    function batal() {
        var TF_ID     = $('input[name=TF_ID]').val();
        var TFD_mmID  = $('select[name=TFD_mmID]').val();
        Swal.fire({
            title: 'Anda Yakin Akan Menghapus Proses Ini ?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Iya',
            denyButtonText: `Tidak`,
            }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: "GET",
                    url: "delete-TukarFaktur.asp",
                        data:{
                            TF_ID,
                            TFD_mmID
                        },
                    success: function (data) {
                        Swal.fire('Deleted !!', data.message, 'success').then(() => {
                        location.reload();
                        });
                    }
                });
                $('#bussinespartner').removeAttr('disabled');
                $('#bussinespartner').val('');
                var permintaan = document.querySelectorAll("[id^=cont]");
                
                for (let i = 0; i < permintaan.length; i++) {
                    permintaan[i].removeAttribute("readonly");
                    permintaan[i].removeAttribute("disabled");
                    permintaan[i].value="";
                }
            } else if (result.isDenied) {
                
            }
        }) 
    }
    function simpan(){
        var TF_ID = $('input[name=TF_ID]').val();
        Swal.fire({
            title: 'Simpan Tukar Faktur ?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'YA',
            denyButtonText: `TIDAK`,
            }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                type: "GET",
                url: "posting-jurnal.asp",
                data:{
                    TF_ID
                },
                success: function (data) {
                    Swal.fire('Berhasil', data.message, 'success').then(() => {
                        window.open(`List-TukarFaktur.asp`,`_Self`)
                    });
                }
            });
            }
            else if (result.isDenied) {
            }
        })
        $('#TFD_mmID').attr('disabled',true);
        $('#TFD_TotalTukarFaktur').attr('disabled',true);
    }
</script>
