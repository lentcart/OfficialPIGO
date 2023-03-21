<!--#include file="../SecureString.asp" -->
<!--#include file="../connections/pigoConn.asp"--> 
<% 

    if request.Cookies("custEmail")="" then 

    response.redirect("../")
    
    end if
			

	set Rekening_cmd =  server.createObject("ADODB.COMMAND")
    Rekening_cmd.activeConnection = MM_PIGO_String

    Rekening_cmd.commandText = "select * from MKT_M_Rekening where rkID = '"& request.Cookies("rkID") &"'"
    set Rekening = Rekening_CMD.execute


%> 

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>

.Form-rekening {
  background-color: #ffffff;
  font-family: Raleway;
  width: 100%;
  min-width: 300px;
}

.text-span-rek{
    font-size: 17px;
    color:grey;
    margin-left: 25px;
    
}
.text-desc-rek{
    font-size: 16px;
    color:grey;
    margin-left: 50px;
    
}
.text-check-rek{
    font-size: 17px;
    color:grey;
    margin-left: 10px;
}
.form-rekening {
    padding: 8px;
    width: 92%;
    font-size: 17px;
    font-family: Raleway;
    border: 1px solid #c4c4c4;
    border-radius : 10px;
    margin-left: 20px;
}

.select-rek {
    padding: 8px;
    width: 95%;
    font-size: 17px;
    font-family: Raleway;
    border: 1px solid #c4c4c4;
    border-radius : 10px;
    margin-left: 20px;
}

.btn-rek {
    background-color: #0dcaf0;
    color: #ffffff;
    border: none;
    padding: 10px 20px;
    font-size: 17px;
    font-family: Raleway;
    cursor: pointer;
    margin-right: 10px;
    border-radius:20px;
    margin-bottom: 15px;
    margin-left:31rem;

}

.modal-rek {
    display: none;
    position: fixed;
    z-index: 1; 
    padding-top: 100px;
    left: 0;
    top: 0;
    width: 100%; 
    height: 100%; 
    overflow: auto; 
    background-color: rgb(0,0,0); 
    background-color: rgba(0,0,0,0.4); 
    }

.modal-content-rek {
    position: relative;
    background-color: #fefefe;
    margin: auto;
    padding: 0;
    border: 1px solid #888;
    width: 50%;
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
    -webkit-animation-name: animatetop;
    -webkit-animation-duration: 0.4s;
    animation-name: animatetop;
    animation-duration: 0.4s;
    border-radius: 30px;
    
}

.close-rek {
    color: rgb(204, 204, 204);
    float: right;
    font-size: 40px;
    font-weight: bold;
    margin-top: 10px;
}

.close:hover,
.close:focus {
    color:cadetblue;
    text-decoration: none;
    cursor: pointer;
}

.modal-header-rek {
    padding: 10px 20px;
    background-color: #ffffff;
    color:black;
    font-size: 15px;
    border-radius: 30px;
 
}

#container-rek {
    width: 500px;
    height: 15rem;    
    margin-bottom: 20px;   
}
#overflow-rek {
    width:40rem;
    height: 100%; 
    overflow-y: auto; 
    margin-left: 50px;
    margin-bottom: 30px;
}

/*ScrollBar*/
::-webkit-scrollbar-rek {
    width: 8px;

}

::-webkit-scrollbar-track-rek {
    box-shadow: inset 0 0 3px grey; 
    border-radius: 50px;

}

::-webkit-scrollbar-thumb-rek {
    background: grey; 
    border-radius: 50px;
}
::-webkit-scrollbar-thumb:hover {
    background: grey; 
}



</style>
</head>
<body>

<button id="btnrekening">Tambah Rekening Bank</button>

<!-- The Modal -->
<div id="modalrekening" class="modal-rek">
    <div class="modal-content-rek">
        <div class="modal-header-rek">
            <span class="close-rek">&times;</span>
            <h2> Tambah Rekening Bank</h2>
        </div>
        <div class="modal-body">
            <div id="container-rek">
                <div id="overflow-rek">
                    <form class="Form-rekening" method="post"action="P-rekening.asp">
                        <div class="tab">
                            <span class="text-desc-rek text-center">Rekening bank yang telah ditambahkan bisa kamu gunakan untuk penarikan Saldo </span><br><br>
                            <hr><br>
                            <span class="text-span-rek"> Pilih Nama Bank </span>
                                <p><select class="select-rek" name="namabank" id="namabank">
                                    <option value="BCA">BCA</option>
                                </select></p>
                            <span class="text-span-rek"> Nomor Rekening</span>
                                <p><input class="form-rekening" type="number" oninput="this.className = ''" name="nomorrekening" id="nomorrekening"></p>
                            <span class="text-span-rek"> Nama Pemilik Rekening</span>
                                <p><input class="form-rekening" type="text" placeholder="In The Name Of" name="namapemilik" id="namapemilik"></p>
                            <span class="text-span-rek"> Status Rekening </span>
                                <p></p><select class="select-rek" name="statusrekening" id="statusrekening">
                                    <option value="Aktif">Aktif</option>
                                </select></p>
                            <span class="text-span-rek">Dengan melanjutkan, kamu menyetujui <br><span class="text-span"style="color:#0dcaf0">Kebijakan Privasi dan Syarat & Ketentuan yang berlaku.</span></span><button class="btn-rek" type="submit" id="btn-sim" value="simpan">Simpan</button>
                        </div>
                    </form>  
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Get the modal
var modal = document.getElementById("modalrekening");

// Get the button that opens the modal
var btn = document.getElementById("btnrekening");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}



</script>

</body>
</html>
