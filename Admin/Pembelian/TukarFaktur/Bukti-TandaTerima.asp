<!--#include file="../../../Connections/pigoConn.asp" -->

<% 

    TF_ID = request.queryString("TF_ID")
    KWID = request.queryString("KWID")

    set TukarFaktur_CMD = server.createObject("ADODB.COMMAND")
	TukarFaktur_CMD.activeConnection = MM_PIGO_String

    TukarFaktur_CMD.commandText = "SELECT MKT_M_Customer.custNama, MKT_M_Customer.custID,MKT_T_TukarFaktur_H.TF_Tanggal, MKT_T_TukarFaktur_H.TF_Invoice, SUM(MKT_T_TukarFaktur_D.TF_TFTotal) AS Total, MKT_T_PurchaseOrder_H.poDesc FROM MKT_M_Customer LEFT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID RIGHT OUTER JOIN MKT_T_TukarFaktur_H ON MKT_M_Customer.custID = MKT_T_TukarFaktur_H.TF_custID LEFT OUTER JOIN MKT_T_TukarFaktur_D ON MKT_T_TukarFaktur_H.TF_ID = LEFT(MKT_T_TukarFaktur_D.TFD_ID, 16) WHERE TF_ID = '"& TF_ID &"' GROUP BY MKT_M_Customer.custNama, MKT_T_TukarFaktur_H.TF_Tanggal, MKT_T_TukarFaktur_H.TF_Invoice, MKT_M_Customer.custID,MKT_T_PurchaseOrder_H.poDesc"
    'Response.Write TukarFaktur_CMD.commandText & "<br>"
    set TukarFaktur = TukarFaktur_CMD.execute

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute
%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!--#include file="../../IconPIGO.asp"-->

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/DataTables/datatables.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script>
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "TukarFaktur-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";

    $(function () {
        $(".test").terbilang();
        $(".as-output-text").terbilang({
            nominal: document.getElementById("subtotal").value,
            output: 'text'
        });
    })
    </script>
    <style>
        .tb-faktur{
            border:0px;
            border-bottom:2px solid black;
            border-top:2px solid black;
        }
        .dotted {
            border: 2px dotted black; 
            width:100%;
            border-style: none none dotted; 
            color: #fff; 
            background-color: #fff; }
                body {
                width: 100%;
                height: 100%;
                margin: 0;
                padding: 0;
                font-size: 12px;
            }
            * {
                box-sizing: border-box;
                -moz-box-sizing: border-box;
            }
            .page {
                width: 210mm;
                height: 150mm;
                padding: 0mm;
                margin: 10mm auto;
                border: 0px #D3D3D3 solid;
                border-radius: 5px;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            }
            .subpage {
                padding: 1cm;
                border: 0px red solid;
                height: 257mm;
                outline: 0cm #FFEAEA solid;
            }
            .footer{
                margin-top:3rem;
                padding:2px 30px;
                border: 0px red solid;
                height: 100%;
                background:blue;
                outline: 0cm #FFEAEA solid;
            }
            .cont-footer{
                padding:10px 5px;
                background:green;
                color:black;
                border:1px solid #eee;
            }
            .as-output-text{
                font-style: italic;
                font-weight:bold;
                font-family:'Lucida Handwriting';
            }
            .ass-output-text{
                font-style: italic;
                font-weight:bold;
                font-family:'Lucida Handwriting';
            }
            @page {
                size: A4;
                margin: 0;
            }
            @media print {
                html, body {
                    width: 210mm;
                    height: 297mm;        
                }
                .page {
                    margin: 0;
                    border: initial;
                    border-radius: initial;
                    width: initial;
                    min-height: initial;
                    box-shadow: initial;
                    background: initial;
                    page-break-after: always;
                }
            }
    </style>
    </head>
<body>  
    <div class="book">
        <div class="page">
            <div class="subpage">
                <!--#include file="../../HeaderPIGOA4.asp"-->
                
                <div class="row mt-2 text-center">
                    <div class="col-12">
                        <span class="txt-desc" style="font-size:25px"><b><u> T A N D A  &nbsp; T E R I M A  &nbsp; F A K T U R </u></b> </span><br>
                    </div>
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col-4">
                        <span class="txt-desc" style="font-size:15px"> TELAH DITERIMA DARI  </span>
                    </div>
                    <div class="col-8 p-0"style="border-bottom:1px solid #aaa">
                    <% if TukarFaktur("custID") <> "C001-CASH" then %>
                        <span class="txt-desc" style="font-size:15px"><span class="txt-desc"> : </span>  &nbsp;&nbsp; <%=TukarFaktur("custNama")%>  </span>
                    <% else %>
                        <span class="txt-desc" style="font-size:15px"><span class="txt-desc"> : </span>  &nbsp;&nbsp; <%=TukarFaktur("poDesc")%>  </span>
                    <% end if %>
                    </div>
                </div>
                

                <div class="row mt-4 mb-2">
                    <div class="col-4">
                        <span class="txt-desc" style="font-size:15px"> FAKTUR/INVOICE NO   </span>
                    </div>
                    <div class="col-8 p-0" style="border-bottom:1px solid #aaa">
                        <span class="txt-desc" style="font-size:15px"><span class="txt-desc"> : </span>  &nbsp;&nbsp; <%=TukarFaktur("TF_Invoice")%>  </span>
                    </div>
                </div>

                <div class="row mt-4 mb-2">
                    <div class="col-4">
                        <span class="txt-desc" style="font-size:15px"> SEJUMLAH  </span>
                    </div>
                    <div class="col-8 p-0"style="border-bottom:1px solid #aaa">
                        <input type="hidden" name="subtotal" id="subtotal" value="<%=TukarFaktur("Total")%>">
                        <span class="txt-desc"> : </span>  &nbsp;&nbsp; <span class="as-output-text txt-desc"style="font-size:15px"><b></b></span>
                        <b><span class=" txt-desc ass-output-text" style="font-size:15px">Rupiah</span></b>
                    </div>
                </div>
                
                <div class="row mt-4 text-align-center">
                    <div class="col-7 text-center" style="margin-top:4.2rem">
                        <span class="txt-desc ass-output-text" style="font-size:25px"><b> <%=Replace(Replace(FormatCurrency(TukarFaktur("Total")),"$","Rp. "),".00","")%> </b> </span>
                    </div>
                    <div class="col-5 text-center">
                        <div class="row">
                            <div class="col-12 mb-3">
                                <span class="txt-desc"  style="font-size:14px"> Bekasi, ................................</span><br>
                                <span class="txt-desc"  style="font-size:14px"><%=Merchant("custNama")%></span><br>
                            </div>
                        </div>
                        <div class="row mt-4 mb-4">
                            <div class="col-12">
                                <span class="txt-desc"  style="font-size:13px"><b><i></b></i></span><br>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-12">
                                <span class="txt-desc"  style="font-size:14px"><u> Bag.Keuangan </u></span><br>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
    <script>
            // var total = document.getElementById('totalnilai').value;
            // // var fax = document.getElementById('totalfax').value;
            // // var subtotal = document.getElementById('grandtotal').value;
            
            // var	reverse1 = total.toString().split('').reverse().join('');
            // // var reverse2 = fax.toString().split('').reverse().join('');
            // // var reverse3 = subtotal.toString().split('').reverse().join('');
            // var ribuan1 	= reverse1.match(/\d{1,3}/g);
            // // var ribuan2 	= reverse2.match(/\d{1,3}/g);
            // // var ribuan3 	= reverse3.match(/\d{1,3}/g);
            //     ribuan1	= ribuan1.join('.').split('').reverse().join('');
            //     // ribuan2	= ribuan2.join('.').split('').reverse().join('');
            //     // ribuan3	= ribuan3.join('.').split('').reverse().join('');
            
            // // Cetak hasil	
            // document.getElementById('totalnilai').value = ("Rp."+ribuan1);
            // // document.getElementById('totalfax').value = ("Rp."+ribuan2);
            // // document.getElementById('grandtotal').value = ("Rp."+ribuan3);
    </script>

    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>