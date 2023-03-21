<!--#include file="../../../Connections/pigoConn.asp" -->

<% 
    InvARID = request.queryString("InvARID")
    custID = request.queryString("custID")
    


    if custID = "" then 

	set Kwitansi_CMD = server.createObject("ADODB.COMMAND")
	Kwitansi_CMD.activeConnection = MM_PIGO_String
    Kwitansi_CMD.commandText = "SELECT MKT_T_Kwitansi_H.KWID, MKT_T_Kwitansi_H.KWTanggal, MKT_M_Customer.custNama, MKT_T_Kwitansi_D.KW_InvARTotalLine, MKT_T_Kwitansi_D.KW_InvARID FROM MKT_T_Kwitansi_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Kwitansi_H.KW_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_Kwitansi_D ON MKT_T_Kwitansi_H.KWID = MKT_T_Kwitansi_D.KWID_H RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_Kwitansi_D.KW_InvARID = MKT_T_Faktur_Penjualan.InvARID WHERE MKT_T_Faktur_Penjualan.InvARID  = '"& InvARID &"'"
    'Response.Write Kwitansi_CMD.commandText & "<br>"
    set Kwitansi = Kwitansi_CMD.execute

    TotalKwitansi = Kwitansi("KW_InvARTotalLine")
    else

    Kwitansi_CMD.commandText = "SELECT MKT_T_Kwitansi_H.KWID, MKT_T_Kwitansi_H.KWTanggal, MKT_M_Customer.custNama, MKT_T_Kwitansi_D.KW_InvARTotalLine, MKT_T_Kwitansi_D.KW_InvARID FROM MKT_T_Kwitansi_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_Kwitansi_H.KW_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_Kwitansi_D ON MKT_T_Kwitansi_H.KWID = MKT_T_Kwitansi_D.KWID_H RIGHT OUTER JOIN MKT_T_Faktur_Penjualan ON MKT_T_Kwitansi_D.KW_InvARID = MKT_T_Faktur_Penjualan.InvARID WHERE MKT_T_Kwitansi_H.KW_custID = '"& custID &"'"
    'Response.Write Kwitansi_CMD.commandText & "<br>"
    set Kwitansi = Kwitansi_CMD.execute

    do while not Kwitansi.eof

        Total = Kwitansi("KW_InvARTotalLine")
        TotalKwitansi = TotalKwitansi + Total

    Kwitansi.movenext
    loop

    end if 

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
    <title>Official PIGO</title>

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
        document.title = "Kwitansi-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";

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
                    <div class="row align-items-center">
                        <div class="col-1">
                        <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                    </div>
                    <div class="col-11 text-end">
                        <span class="Judul-Merchant" style="font-size:22px"> <b><%=Merchant("custNama")%> </b></span><br>
                        <span class="txt-desc"> <%=Merchant("almLengkap")%> </span><br>
                        <span class="txt-desc"> <%=Merchant("custPhone1")%> </span> / <span class="txt-desc"> <%=Merchant("custEmail")%> </span><br>
                        
                    </div>
                    </div>
                    <div class="row mt-2" style="border-bottom:3px solid #363636">
                    </div>
                

                <div class="row mt-2 text-center">
                    <div class="col-12">
                        <span class="txt-desc" style="font-size:25px"><b><u> K W I T A N S I </u></b> </span><br>
                    </div>
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col-4">
                        <span class="txt-desc" style="font-size:15px"> NOMOR KWITANSI  </span>
                    </div>
                    <div class="col-8 p-0"style="border-bottom:1px solid #aaa">
                        <span class="txt-desc" style="font-size:15px"><span class="txt-desc"> : </span>  &nbsp;&nbsp; <%=Kwitansi("KWID")%>  </span>
                    </div>
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col-4">
                        <span class="txt-desc" style="font-size:15px"> TELAH DITERIMA DARI  </span>
                    </div>
                    <div class="col-8 p-0"style="border-bottom:1px solid #aaa">
                        <span class="txt-desc" style="font-size:15px"><span class="txt-desc"> : </span>  &nbsp;&nbsp; <%=Kwitansi("custNama")%>  </span>
                    </div>
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col-4">
                        <span class="txt-desc" style="font-size:15px"> SEJUMLAH  </span>
                    </div>
                    <div class="col-8 p-0"style="border-bottom:1px solid #aaa">
                        <input type="hidden" name="subtotal" id="subtotal" value="<%=TotalKwitansi%>">
                        <span class="txt-desc"> : </span>  &nbsp;&nbsp; <span class="as-output-text txt-desc"style="font-size:15px"><b></b></span>
                        <b><span class=" txt-desc ass-output-text" style="font-size:15px">Rupiah</span></b>
                    </div>
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col-4">
                        <span class="txt-desc" style="font-size:15px"> UNTUK PEMBAYARAN   </span>
                    </div>
                    <div class="col-8 p-0" style="border-bottom:1px solid #aaa">
                        <span class="txt-desc" style="font-size:15px"><span class="txt-desc"> : </span>  &nbsp;&nbsp; Pembelian Sparepart  </span>
                    </div>
                </div>
                <div class="row mt-4 text-align-center">
                    <div class="col-7 text-center" style="margin-top:5rem">
                        <span class="txt-desc ass-output-text" style="font-size:25px"> <%=Replace(FormatCurrency(TotalKwitansi),"$", "Rp. ")%>  </span>
                    </div>
                    <div class="col-5 text-center">
                        <div class="row">
                            <div class="col-12 mb-4">
                                <span class="txt-desc"  style="font-size:14px"> Bekasi, <%=day(date())%>&nbsp;<%=MonthName(month(date()))%>&nbsp;<%=Year(date())%></span><br>
                                <span class="txt-desc"  style="font-size:14px"><%=Merchant("custNama")%></span><br>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-12">
                                <span class="txt-desc"  style="font-size:14px">Bag.Keuangan</span><br>
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