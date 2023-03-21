
<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    key = request.queryString("pdID")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT pdID, pdNama, pdUnit, pdPartNumber, pdHarga, pdLokasi From MKT_M_PIGO_Produk where pdID  = '"& key &"' "
    'Response.Write loadproduk_CMD.commandText & "<br>"

    set dproduk = loadproduk_CMD.execute

    set Tax_CMD = server.createObject("ADODB.COMMAND")
	Tax_CMD.activeConnection = MM_PIGO_String

    Tax_CMD.commandText = "SELECT * FROM MKT_M_Tax Where TaxAktifYN = 'Y' "
    'Response.Write Tax_CMD.commandText & "<br>"

    set Tax = Tax_CMD.execute
    


%> 
<input type="hidden" class=" cont-form" name="produkid" id="produkid" value="<%=dproduk("pdID")%>" ><br>
    <div class="col-lg-6 col-md-6 col-sm-12">
        <span class="cont-text"> Nama Produk </span><br>
        <input readonly type="text" class="  cont-form" name="namaproduk" id="namaproduk" value="<%=dproduk("pdNama")%>" ><br>
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12">
                <div class="row">
                    <div class="col-lg-10 col-md-6 col-sm-12">
                        <span class="cont-text"> Harga </span><br>
                        <!--<input required type="text" class=" text-center  cont-form" name="harga" id="harga" value="" >-->
                        <input  required type="text" class=" text-center  cont-form" name="hargabulat" id="hargabulat" value="<%=dproduk("pdHarga")%>" >
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12"   style="margin-top:26px;margin-left:-8px">
                        <input  onchange="openkalkulator()" type="checkbox" id="kalkulator">
                        <label class="side-toggle" for="kalkulator"> <span class="fas fa-calculator" style="font-size:17px"> </span></label>
                    </div>
                    <!--<div class="col-2" style="margin-top:20px;margin-left:-20px">
                        <div class="popover__wrapper">
                            <div class="itemm">
                                <button class="btn-cetak-po" style="width:2rem"><i class="fas fa-calculator" style="font-size:17px"></i></button>
                            </div><div class="popover__content">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="calculator">
                                            <div class="input" id="input">
                                            </div>
                                            <div class="buttons">
                                                <div class="operators">
                                                <div>+</div>
                                                <div>-</div>
                                                <div>&times;</div>
                                                <div>&divide;</div>
                                                </div>
                                                <div class="leftPanel">
                                                    <div class="numbers">
                                                        <div>7</div>
                                                        <div>8</div>
                                                        <div>9</div>
                                                    </div>
                                                    <div class="numbers">
                                                        <div>4</div>
                                                        <div>5</div>
                                                        <div>6</div>
                                                    </div>
                                                    <div class="numbers">
                                                        <div>1</div>
                                                        <div>2</div>
                                                        <div>3</div>
                                                    </div>
                                                    <div class="numbers">
                                                        <div>0</div>
                                                        <div>.</div>
                                                        <div id="clear">C</div>
                                                    </div>
                                                </div>
                                                <div class="equal" id="result">=
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>-->
                </div>
                <div class="cont-calculator-PO" id="cont-calculator-PO" >
                    <div class="row">
                        <div class="col-12">
                            <div class= "formstyle">
                                <form name = "form1" onkeydown="return event.key != 'Enter';">
                                    <input id = "calc" type ="text" name = "answer"> <br>
                                    <input class="inp-cal mt-3" type = "button" value = "1" onclick = "form1.answer.value += '1' ">
                                    <input class="inp-cal mt-3" type = "button" value = "2" onclick = "form1.answer.value += '2' ">
                                    <input class="inp-cal mt-3" type = "button" value = "3" onclick = "form1.answer.value += '3' ">
                                    <input class="inp-cal mt-3" type = "button" value = "+" onclick = "form1.answer.value += '+' ">
                                    <br>
                                        
                                    <input class="inp-cal" type = "button" value = "4" onclick = "form1.answer.value += '4' ">
                                    <input class="inp-cal" type = "button" value = "5" onclick = "form1.answer.value += '5' ">
                                    <input class="inp-cal" type = "button" value = "6" onclick = "form1.answer.value += '6' ">
                                    <input class="inp-cal" type = "button" value = "-" onclick = "form1.answer.value += '-' ">
                                    <br> 

                                    <input class="inp-cal" type = "button" value = "7" onclick = "form1.answer.value += '7' ">
                                    <input class="inp-cal" type = "button" value = "8" onclick = "form1.answer.value += '8' ">
                                    <input class="inp-cal" type = "button" value = "9" onclick = "form1.answer.value += '9' ">
                                    <input class="inp-cal" type = "button" value = "*" onclick = "form1.answer.value += '*' ">
                                    <br>
                                        
                                    <input class="inp-cal" type = "button" value = "/" onclick = "form1.answer.value += '/' ">
                                    <input class="inp-cal" type = "button" value = "0" onclick = "form1.answer.value += '0' ">
                                    <input class="inp-cal" type = "button" value = "." onclick = "form1.answer.value += '.' ">

                                    <input class="inp-cal mb-2" type = "button" value = "=" onclick = "aaa(),form1.answer.value = eval(form1.answer.value) ">
                                    <br>

                                    <input type = "button" value = "Clear All" onclick = "form1.answer.value = ' ' " id= "clear" >
                                    <br> 
                                                    
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-12">
                    <span class="cont-text"> Diskon </span><br>
                    <input  readonly type="number" class=" text-center  cont-form" name="diskon" id="diskon" value="0" ><br>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-12">
                    <span class="cont-text"> QTY Produk </span><br>
                    <input onkeyup="totalline()"  required type="number" class="qtyproduk text-center  cont-form" name="qtyproduk" id="qtyproduk" value="0"><br>
                </div>
            </div>
        </div>
        </div>
<div class="col-lg-6 col-md-6 col-sm-12">
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-12">
            <span class="cont-text"> SKU/Part Number</span><br>
            <input readonly type="text" class="  cont-form" name="skuproduk" id="skuproduk" value="<%=dproduk("pdPartNumber")%>"  ><br>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12">
            <span class="cont-text"> Lokasi Rak </span><br>
            <input readonly type="text" class="  cont-form" name="lokasirak" id="lokasirak" value="<%=dproduk("pdLokasi")%>"><br>
        </div>
        <div class="col-lg-2 col-md-2 col-sm-12">
            <span class="cont-text"> Unit </span><br>
            <input readonly type="text" class=" text-center  cont-form" name="unitproduk" id="unitproduk" value="<%=dproduk("pdUnit")%>" ><br>
        </div>
    </div>
    <div class="row">
        
        <div class="col-lg-4 col-md-4 col-sm-12">
            <span class="cont-text"> Sub Total </span><br>
            <input readonly type="number" class=" text-center  cont-form" name="subtotalpo" id="subtotalpo" value="0"><br>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12">
            <span class="cont-text"> TAX (PPN) </span><br>
            <select onchange="tax()" class=" cont-form" name="ppn" id="ppn" aria-label="Default select example" required>
                <option value="">Pilih</option>
                <% do while not Tax.eof %>
                <option value="<%=Tax("TaxRate")%>"><%=Tax("TaxNama")%></option>
                <% Tax.movenext
                loop %>
            </select>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12">
            <span class="cont-text"> </span><br>
            <input readonly type="number" class=" text-center  cont-form" name="totalpo" id="totalpo" value="0"><br>
        </div>
    </div>
</div>

    <script>

        // "use strict";

        // var input = document.getElementById('input'),
        // number = document.querySelectorAll('.numbers div'),
        // operator = document.querySelectorAll('.operators div'),
        // result = document.getElementById('result'),
        // clear = document.getElementById('clear'),
        // resultDisplayed = false;

        // for (var i = 0; i < number.length; i++) {
        //   number[i].addEventListener("click", function(e) {
        //   var currentString = input.innerHTML;
        //   var lastChar = currentString[currentString.length - 1];
        //     if (resultDisplayed === false) {
        //       input.innerHTML += e.target.innerHTML;
        //     } else if (resultDisplayed === true && lastChar === "+" || lastChar === "-" || lastChar === "×" || lastChar === "÷") {
        //       resultDisplayed = false;
        //       input.innerHTML += e.target.innerHTML;
        //     } else {
        //       resultDisplayed = false;
        //       input.innerHTML = "";
        //       input.innerHTML += e.target.innerHTML;
        //     }
        //   });
        // }

        // for (var i = 0; i < operator.length; i++) {
        //   operator[i].addEventListener("click", function(e) {
        //   var currentString = input.innerHTML;
        //   var lastChar = currentString[currentString.length - 1];
        //     if (lastChar === "+" || lastChar === "-" || lastChar === "×" || lastChar === "÷") {
        //       var newString = currentString.substring(0, currentString.length - 1) + e.target.innerHTML;
        //       input.innerHTML = newString;
        //     } else if (currentString.length == 0) {
        //       console.log("enter a number first");
        //     } else {
        //       input.innerHTML += e.target.innerHTML;
        //     }
        //   });
        // }

        // result.addEventListener("click", function() {

        // var inputString = input.innerHTML;
        // var numbers = inputString.split(/\+|\-|\×|\÷/g);
        // var operators = inputString.replace(/[0-9]|\./g, "").split("");
        // // console.log(inputString);
        // // console.log(operators);
        // // console.log(numbers);
        // var divide = operators.indexOf("÷");
        // while (divide != -1) {
        //   numbers.splice(divide, 2, numbers[divide] / numbers[divide + 1]);
        //   operators.splice(divide, 1);
        //   divide = operators.indexOf("÷");
        // }

        // var multiply = operators.indexOf("×");
        // while (multiply != -1) {
        //   numbers.splice(multiply, 2, numbers[multiply] * numbers[multiply + 1]);
        //   operators.splice(multiply, 1);
        //   multiply = operators.indexOf("×");
        // }

        // var subtract = operators.indexOf("-");
        // while (subtract != -1) {
        //   numbers.splice(subtract, 2, numbers[subtract] - numbers[subtract + 1]);
        //   operators.splice(subtract, 1);
        //   subtract = operators.indexOf("-");
        // }

        // var add = operators.indexOf("+");
        // while (add != -1) {
        //   numbers.splice(add, 2, parseFloat(numbers[add]) + parseFloat(numbers[add + 1]));
        //   operators.splice(add, 1);
        //   add = operators.indexOf("+");
        // }

        // input.innerHTML = numbers[0]; 
        // var s = 0;
        // s = numbers[0]; 
        // var bulat = Math.round(s)
        // document.getElementById("harga").value = s;
        // document.getElementById("hargabulat").value = bulat;
        
        // console.log(bulat);
  

        //   resultDisplayed = true; 
        // });

        // clear.addEventListener("click", function() {
        //   input.innerHTML = "";
        // })
        function totalline(){
            var qty = parseInt(document.getElementById("qtyproduk").value);
            var harga = parseInt(document.getElementById("hargabulat").value);
            var total = Number(qty*harga);
            document.getElementById("subtotalpo").value = total;
            // console.log(qty, harga, total);
        };
        document.addEventListener("DOMContentLoaded", function(event) {
            totalline();
        });

        function tax(){
            var tax = document.getElementById("ppn").value;
            var qty = parseInt(document.getElementById("qtyproduk").value);
            var harga = parseInt(document.getElementById("hargabulat").value);
            //console.log(tax);
            
            if( tax == "0" ){
                if( qty == "0" ){
                    $('.qtyproduk').focus();
                    document.getElementById("ppn").value = "";
                }else{
                    var total = Number(qty*harga);
                    document.getElementById("subtotalpo").value = total;
                    document.getElementById("totalpo").value = total;
                    // console.log(total);
                }
            }else{
                if ( qty == "0" ){
                    $('.qtyproduk').focus();
                }else{
                    tax = 11;
                    var total = Number(qty*harga);
                    pajak = tax/100*total;
                    subtotal = total+pajak;
                    var grandtotal = Math.round(subtotal);
                    document.getElementById("subtotalpo").value = total;
                    document.getElementById("totalpo").value = grandtotal;
                    // console.log(subtotal);
                }
            }

        }
    </script>