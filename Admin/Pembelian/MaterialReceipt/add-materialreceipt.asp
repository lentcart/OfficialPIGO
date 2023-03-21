<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    mmTanggal                   = request.queryString("mmTanggal")
    mmType                      = request.queryString("mmType")
    mmMoveDate                  = request.queryString("mmMoveDate")
    mmAccDate                   = request.queryString("mmAccDate")
    mm_spID                     = request.queryString("mm_spID")

    set MaterialReceipt_H_CMD = server.CreateObject("ADODB.command")
    MaterialReceipt_H_CMD.activeConnection = MM_pigo_STRING
    MaterialReceipt_H_CMD.commandText = "exec sp_add_MKT_T_MaterialReceipt_H '"& mmTanggal &"','"& mm_spID &"','N','','N'"
    set MaterialReceipt_H = MaterialReceipt_H_CMD.execute

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String
    PurchaseOrder_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID,MKT_T_PurchaseOrder_H.poTanggal, MKT_M_Customer.custID FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE  MKT_T_PurchaseOrder_H.po_custID = '"& mm_spID &"' AND MKT_T_PurchaseOrder_D.po_spoID = '0'  group by MKT_T_PurchaseOrder_H.poID,MKT_T_PurchaseOrder_H.poTanggal, MKT_M_Customer.custID "
    set PurchaseOrder = PurchaseOrder_cmd.execute
%>
<input type="hidden" name="mmID" id="mmID" value="<%=MaterialReceipt_H("id")%>"><input type="hidden" name="mmTanggal" id="mmTanggal" value="<%=mmTanggal%>">
<button onclick="batal()" class="cont-btn" id="cont-btn-batal" style="width:10rem"> <i class="fas fa-ban"></i>&nbsp;&nbsp; Batalkan  </button>
<br>
<div class="row mt-3 align-items-center">
    <div class="col-lg-4 col-md-12 col-sm-12">
        <select onchange="getpo()" class="text-center poID cont-form mt-1" name="poID" id="poID" aria-label="Default select example" >
            <option value=""> Pilih Purchase Order </option>
            <% do while not PurchaseOrder.eof %>
            <option value="<%=PurchaseOrder("poID")%>"><%=PurchaseOrder("poID")%>&nbsp;-&nbsp;<%=PurchaseOrder("poTanggal")%></option>
            <% PurchaseOrder.movenext
            loop%>
        </select>
    </div>
    <div class="col-lg-6 col-md-4 col-sm-6 text-start">
        <div class="form-check">
            <input onchange="selesai()" class="form-check-input" type="checkbox" value="" id="ckselesaimm">
            <label class=" cont-text form-check-label" for="ckselesaimm" id="labelcek">
                Konfirmasi Material Receipt
            </label>
        </div>
    </div>
</div>
<div class="cont-selesai" id="cont-selesai">
    <div class="row mt-3" >
        <div class="col-12 cont-Status-mm">
            <input type="text" name="status" id="status" value="0">
            <button class="cont-btn" style="height:1.5rem" onclick="posting()" > SIMPAN MATERIAL RECEIPT </button>
        </div>
    </div>
</div>
<script>
    $("#cont-selesai").hide();
    
    function selesai(){
        let cek = document.getElementById("ckselesaimm");
        var labelcek = document.getElementById("labelcek");
        if (!cek.checked){
            $("#cont-btn-batal").show();
            $('#poID').attr('disabled', false);
            labelcek.innerHTML = "Konfirmasi Material Receipt";
            $("#cont-tb").show();
            $("#cont-selesai").hide();
        }else{
            $("#cont-tb").hide();
            labelcek.innerHTML = "Change Material Receipt";
            $('#poID').attr('disabled', true);
            $("#cont-btn-batal").hide();
            $("#cont-selesai").show();
        }
    }
    function posting(){
        var status = document.getElementById("status").value;
        if ( status == "0"){
            alert("Tidak Ada Produk Yang Diinput!")
        }else{
            var mmID = document.getElementById("idmm").value;
            console.log(mmID);
            Swal.fire({
                title: 'Simpan Material Receipt ?',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'YA',
                denyButtonText: `TIDAK`,
                }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                    type: "GET",
                    url: "../MaterialReceiptDetail/posting-jurnal.asp",
                    data:{
                        mmID
                    },
                    success: function (data) {
                        window.open(`../MaterialReceiptDetail/buktimm.asp?mmID=${mmID}`)
                        location.reload();
                        }
                    });
                } else if (result.isDenied) {
    
                }
            })
        }
    }
</script>

