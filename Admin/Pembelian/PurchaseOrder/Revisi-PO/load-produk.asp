<!--#include file="../../../../connections/pigoConn.asp"-->

<% 
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    pdID = request.queryString("pdID")
    poID = request.queryString("poID")

    set loadproduk_CMD = server.createObject("ADODB.COMMAND")
	loadproduk_CMD.activeConnection = MM_PIGO_String

    loadproduk_CMD.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_D.poQtyProduk, MKT_T_PurchaseOrder_D.poPdUnit, MKT_T_PurchaseOrder_D.poHargaSatuan, MKT_T_PurchaseOrder_D.poPajak, MKT_T_PurchaseOrder_D.poDiskon,  MKT_T_PurchaseOrder_D.poSubTotal, MKT_T_PurchaseOrder_D.poTotal, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber,  MKT_M_PIGO_Produk.pdLokasi FROM MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID Where poID = '"& poID &"' and pdID = '"& pdID &"'  "
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
        <input required type="text" class="  cont-form" name="namaproduk" id="namaproduk" value="<%=dproduk("pdNama")%>" ><br>
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12">
                <div class="row">
                    <div class="col-lg-10 col-md-6 col-sm-12">
                        <span class="cont-text"> Harga </span><br>
                        <input required type="text" class=" text-center  cont-form" name="harga" id="harga" value="<%=dproduk("poHargaSatuan")%>" >
                        <input  required type="hidden" class=" text-center  cont-form" name="hargabulat" id="hargabulat" value="<%=dproduk("poHargaSatuan")%>" >
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
                    <input  readonly type="number" class=" text-center  cont-form" name="diskon" id="diskon" value="<%=dproduk("poDiskon")%>" ><br>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-12">
                    <span class="cont-text"> QTY Produk </span><br>
                    <input onkeyup="totalline()"  required type="number" class=" text-center  cont-form" name="qtyproduk" id="qtyproduk" value="<%=dproduk("poQtyProduk")%>"><br>
                </div>
            </div>
        </div>
        </div>
<div class="col-lg-6 col-md-6 col-sm-12">
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-12">
            <span class="cont-text"> SKU/Part Number</span><br>
            <input required type="text" class="  cont-form" name="skuproduk" id="skuproduk" value="<%=dproduk("pdPartNumber")%>"  ><br>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12">
            <span class="cont-text"> Lokasi Rak </span><br>
            <input required type="text" class="  cont-form" name="lokasirak" id="lokasirak" value="<%=dproduk("pdLokasi")%>"><br>
        </div>
        <div class="col-lg-2 col-md-2 col-sm-12">
            <span class="cont-text"> Unit </span><br>
            <input required type="text" class=" text-center  cont-form" name="unitproduk" id="unitproduk" value="<%=dproduk("pdUnit")%>" ><br>
        </div>
    </div>
    <div class="row">
        
        <div class="col-lg-4 col-md-4 col-sm-12">
            <span class="cont-text"> Sub Total </span><br>
            <input required type="number" class=" text-center  cont-form" name="subtotalpo" id="subtotalpo" value="<%=dproduk("poSubtotal")%>"><br>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12">
            <span class="cont-text"> TAX (PPN) </span><br>
            <select onchange="tax()" class=" cont-form" name="ppn" id="ppn" aria-label="Default select example" required>
                <option value="<%=dproduk("poPajak")%>"><%=dproduk("poPajak")%></option>
                <% do while not Tax.eof %>
                <option value="<%=Tax("TaxRate")%>"><%=Tax("TaxNama")%></option>
                <% Tax.movenext
                loop %>
            </select>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12">
            <span class="cont-text"> </span><br>
            <input required type="number" class=" text-center  cont-form" name="totalpo" id="totalpo" value="<%=dproduk("poTotal")%>"><br>
        </div>
    </div>
</div>
        <script>
            function tax(){
            var tax = document.getElementById("ppn").value;
            var qty = parseInt(document.getElementById("qtyproduk").value);
            var harga = parseInt(document.getElementById("harga").value);
            //console.log(tax);
            
            if( tax == "0" ){
                var total = Number(qty*harga);
                document.getElementById("subtotalpo").value = total;
                document.getElementById("totalpo").value = total;
                // console.log(total);
                
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
        function totalline(){
            var qty = parseInt(document.getElementById("qtyproduk").value);
            var harga = parseInt(document.getElementById("harga").value);
            var total = Number(qty*harga);
            document.getElementById("subtotalpo").value = total;
            // console.log(qty, harga, total);
        };
        document.addEventListener("DOMContentLoaded", function(event) {
            totalline();
        });
        function getproduk(){
            var pdID = document.getElementById("pdID").value;
            
            $.ajax({
                type: "get",
                url: "loadproduk.asp?pdID="+document.getElementById("pdID").value,
                success: function (url) {
                // console.log(url);
                $('.datapd').html(url);
                                    
                }
            });
        }
        function aaa(){
            var bb = document.getElementById("calc").value;
            var c = Math.round(eval(bb));
                document.getElementById("harga").value = eval(c);
                document.getElementById("hargabulat").value = eval(c);
        }
        function openkalkulator(){
            var btnkal = document.getElementById("kalkulator");
            if(btnkal.checked == true){
                document.getElementById("cont-calculator-PO").style.display = "block";
            }else{
                document.getElementById("cont-calculator-PO").style.display = "none";
                document.getElementById("qtyproduk").value = 0;
                document.getElementById("subtotalpo").value = 0;
                document.getElementById("totalpo").value = 0;
            }
        }
    </script>