function openkalkulator(){
    var btnkal = document.getElementById("kalkulator");
    if(btnkal.checked == true){
        document.getElementById("cont-calculator").style.display = "block";
    }else{
        document.getElementById("cont-calculator").style.display = "none";
        document.getElementById("qtyproduk").value = 0;
        document.getElementById("subtotalpo").value = 0;
        document.getElementById("totalpo").value = 0;
        document.getElementById("ppn").value = "";
    }
}
function aaa(){
    var bb = document.getElementById("calc").value;
    var c = Math.round(eval(bb));
        document.getElementById("harga").value = eval(c);
        document.getElementById("hargabulat").value = eval(c);
}
