<!--#include file="../../connections/pigoConn.asp"--> 

<% 
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    produkid = request.queryString("produkid")
%> 

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="../../js/jquery-3.6.0.min.js"></script>
<style>


h2 {
  text-align: center;  
  font-family: unito Sans, -apple-system, sans-serif;
}
.text-span{
    font-size: 17px;
    color:grey;
    margin-left: 25px;
    
}
.text-desc{
    font-size: 16px;
    color:grey;
    margin-left: 50px;
    
}
hr{
    width: 35rem;
}
.text-check{
    font-size: 17px;
    color:grey;
    margin-left: 10px;
}
.form-rekening {
    padding: 8px;
    font-size: 17px;
    font-family: Raleway;
    border: 1px solid #c4c4c4;
    border-radius : 10px;
    margin-bottom: 1rem;
    margin-left: 20px;
}

.select-rek {
    padding: 8px;
    width: 25%;
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
    padding: 7px 20px;
    font-size: 17px;
    font-family: Raleway;
    cursor: pointer;
    margin-right: 10px;
    border-radius:20px;
    margin-bottom: 15px;
    margin-left:31.5rem;
    margin-top: 1rem;
    width: 7rem;
}
    .btn-stk {
    background-color: #0dcaf0;
    color: #ffffff;
    border: none;
    padding: 7px 20px;
    font-size: 17px;
    font-family: Raleway;
    cursor: pointer;
    margin-right: 10px;
    border-radius:20px;
    margin-left:10px;
    width: 11rem;

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

.modal-content {
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
.modal {

overflow-y: scroll;
}

.close {
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

.modal-header {
    padding: 10px 20px;
    background-color: #ffffff;
    color:black;
    font-size: 15px;
    border-radius: 30px;
 
}

#container {
    width: 500px;
    height: 18rem;    
    margin-bottom:5rem;   
    margin-top: 1rem;
}
#overflow {
    width:40rem;
    height: 100%; 
    overflow-y: auto; 
    margin-left: 50px;
    margin-bottom: 30px;
}

/*ScrollBar*/
::-webkit-scrollbar {
    width: 8px;

}

::-webkit-scrollbar-track {
    box-shadow: inset 0 0 3px grey; 
    border-radius: 50px;

}

::-webkit-scrollbar-thumb {
    background: grey; 
    border-radius: 50px;
}
::-webkit-scrollbar-thumb:hover {
    background: grey; 
}



</style>

<script>
     $(document).on('keypress',function(e) {
    if(e.which == 13) {
       // alert('You pressed enter!');
       form1.submit();
    }
});
</script>
</head>
<body onload="document.getElementById('sku').focus();">


<!-- The Modal -->
    <div class="modal-content">
        <div class="modal-header">
            <span class="close">&times;</span>
            <h2> Stok Baru</h2>
        </div>
        <div class="modal-body">
            <div id="container">
                <div id="overflow">
                    <form class="Form-rekening" action="p-addStok.asp" id="form1" method="post">
                        <span class="text-span">Produk ID</span>
                        <p><input class="form-rekening" type="text"  readonly  name="produkid" id="produkid" value='<%=produkID%>' ></p>
                        <span class="text-span">Stok ID</span>
                        <input class="form-rekening" type="text"  name="stokid" id="stokid" style="width:150px">
                        <!--<span class="text-span"> SKU</span>
                        <input class="form-rekening" type="text" name="sku" id="sku" style="width:19rem"  >-->
                        <div class="row">
                            <div class="row">
                                <div class="col-6"></div>
                                <span class="text-span">Masukan Jumlah Stok</span>
                                <input class="form-rekening" type="number"  name="jmlstok" id="jmlstok" style="width:100px">
                                <button onclick="window.open('label/?jmlbarcode='+document.getElementById('jmlstok').value+'&pdID='+document.getElementById('produkid').value);" class="btn-stk"  id="btn-sim" value="simpan">Cetak Barcode Stok</button>
                                </div>
                            </div>
                    </form>  
                    <input type="submit" value="simpan">
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
<script src="../js/bootstrap.js"></script>
<script src="../js/popper.min.js"></script>

</body>
</html>
