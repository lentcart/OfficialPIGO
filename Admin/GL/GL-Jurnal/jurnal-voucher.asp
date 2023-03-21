<!--#include file="../../../Connections/pigoConn.asp" -->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->
<%

    JR_ID = request.queryString("JR_ID")    

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set Jurnal_CMD = server.createObject("ADODB.COMMAND")
	Jurnal_CMD.activeConnection = MM_PIGO_String
			
	Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.* FROM GL_T_Jurnal_H WHERE JR_ID = '"& JR_ID &"' "
    'response.write Jurnal_CMD.commandText
	set Jurnal = Jurnal_CMD.execute

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

    Log_ServerID 	= "" 
    Log_Action   	= "PRINT"
    Log_Key         = "GL-Jurnal Voucher"
    Log_Keterangan  = "Melakukan cetak (GL) Jurnal Voucher ID : "& JR_ID &" pada : "& Date()
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

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
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
     
        var today = new Date();

        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
            // window.print();
        document.title = "BuktiKas-<%=JR_ID%>-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";

    
    </script>
    <style>
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
            min-height: 297mm;
            padding: 0mm;
            margin: 10mm auto;
            border: 0px #D3D3D3 solid;
            border-radius: 5px;
            background: white;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .subpage {
            padding: 1cm;
            border: 0px red solid;
            height: 257mm;
            outline: 0cm #FFEAEA solid;
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
        .cont-form-jurnal{
            max-width:6.5rem;
            border:none;
        }
        input:read-only{
            background-color:white;
            color:black;
        }
        tr:hover{
        color: white;
        }
    </style>
    </head>
<body>  
    <div class="book">
        <div class="page">
            <div class="subpage">
                <!--#include file="../../HeaderPIGOA4.asp"-->
                <% do while not Jurnal.eof %>
                <div class="row mt-2">
                    <div class="col-2">
                        <span class="cont-text"> No Transaksi </span><br>
                        <span class="cont-text"> Tanggal </span><br>
                        <span class="cont-text"> Keterangan </span><br>
                    </div>
                    <div class="col-10">
                        <span class="cont-text"> : </span>&nbsp;<span class="cont-text"> <%=Jurnal("JR_ID")%> </span><br>
                        <span class="cont-text"> : </span>&nbsp;<span class="cont-text"> <%=day(CDate(Jurnal("JR_Tanggal")))%>&nbsp; <%=MonthName(Month(Jurnal("JR_Tanggal")))%>&nbsp;<%=year(CDate(Jurnal("JR_Tanggal")))%></span><br>
                        <span class="cont-text"> : </span>&nbsp;<span class="cont-text"> <%=Jurnal("JR_Keterangan")%> </span><br>
                    </div>
                </div>
                <div class="row mt-2 mb-2 text-center">
                    <div class="col-12">
                    <% if Jurnal("JR_Type") = "T" then %>
                        <span class="cont-text" style="font-size:20px; font-weight:bold"><u> VOUCHER TERIMA KAS </u></span>
                    <% else if Jurnal("JR_Type") = "K" then %>
                        <span class="cont-text" style="font-size:20px; font-weight:bold"><u> VOUCHER KAS KELUAR </u></span>
                    <% else %>
                        <% if Jurnal("JR_Status") = "MM" then %>
                        <span class="cont-text" style="font-size:20px; font-weight:bold"><u> VOUCHER MEMORIAL - MATERIAL RECEIPT </u></span>
                        <% else if Jurnal("JR_Status") = "TF" then %>
                        <span class="cont-text" style="font-size:20px; font-weight:bold"><u> VOUCHER MEMORIAL - TUKAR FAKTUR </u></span>
                        <% else %>
                        <span class="cont-text" style="font-size:20px; font-weight:bold"><u> VOUCHER MEMORIAL </u></span>
                        <% end if %><% end if %>
                    <% end if %><% end if %>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-12">
                        <table class="table cont-tb  tb-transaksi table-bordered table-condensed" style="font-size:11px">
                            <thead style="background-color:#aaa; color:black">
                                <tr>
                                    <th colspan="2"class="text-center"> ACCOUNT </th>
                                    <th class="text-center"> KETERANGAN </th>
                                    <th class="text-center"> DEBET </th>
                                    <th class="text-center"> KREDIT     </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Jurnal_cmd.commandText = "SELECT GL_T_Jurnal_D.JRD_ID, GL_T_Jurnal_D.JRD_CA_ID, GL_T_Jurnal_D.JRD_Keterangan, GL_T_Jurnal_D.JRD_Debet, GL_T_Jurnal_D.JRD_Kredit, GL_M_ChartAccount.CA_Name FROM GL_T_Jurnal_D LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID WHERE LEFT(JRD_ID,12) = '"& JR_ID &"' ORDER BY JRD_Kredit"
                                    'response.write Jurnal_cmd.commandText
                                    set JurnalD = Jurnal_cmd.execute
                                %>
                                <% 
                                    no = 0 
                                    do while not JurnalD.eof 
                                    no = no + 1 
                                %>
                                <tr>
                                    <td> <%=JurnalD("JRD_CA_ID")%> </td>
                                    <td> <%=JurnalD("CA_Name")%> </td>
                                    <td> <%=JurnalD("JRD_Keterangan")%> </td>
                                    <td class="text-end"><input type="text" readonly class="cont-form-jurnal text-end" value="<%=Replace(Replace(FormatCurrency(JurnalD("JRD_Debet")),"$","Rp. "),".00","")%>"> </td>
                                    <td class="text-end"><input type="text" readonly class="cont-form-jurnal text-end" value="<%=Replace(Replace(FormatCurrency(JurnalD("JRD_Kredit")),"$","Rp. "),".00","")%>"></td>
                                </tr>
                                <% 
                                    subtotaldebet = subtotaldebet + JurnalD("JRD_Debet") 
                                    subtotalkredit = subtotalkredit + JurnalD("JRD_Kredit") 
                                %>
                                <% 
                                    JurnalD.movenext
                                    loop 
                                %>
                                <tr style="background-color:#aaa; color:black">
                                    <td class="text-center"colspan="3"><b> TOTAL </b></td>
                                    <td class="text-end"> 
                                        <input type="hidden" name="subtotal" id="subtotal" value="<%=subtotal%> ">
                                        <%=Replace(Replace(FormatCurrency(subtotaldebet),"$","Rp. "),".00","")%> 
                                    </td>
                                    <td class="text-end"> 
                                        <input type="hidden" name="subtotal" id="subtotal" value="<%=subtotal%> ">
                                        <%=Replace(Replace(FormatCurrency(subtotalkredit),"$","Rp. "),".00","")%> 
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <% Jurnal.movenext
                loop %> 
                <div class="row mt-2 mb-2 text-center">
                    <div class="col-4">
                        <span class="cont-text" style="font-size:13px; font-weight:bold"> Diterima</span><br><br><br>
                    </div>
                    <div class="col-4">
                        <span class="cont-text" style="font-size:13px; font-weight:bold"> Disetujui</span><br><br><br>
                    </div>
                    <div class="col-4">
                        <span class="cont-text" style="font-size:13px; font-weight:bold"> Diketahui</span><br><br><br>
                    </div>
                </div>
                <div class="row mt-4 text-center">
                    <div class="col-4">
                        <span class="cont-text" style="font-size:13px; font-weight:bold"><u>( Keuangan )</u></span>
                    </div>
                    <div class="col-4">
                        <span class="cont-text" style="font-size:13px; font-weight:bold"><u>( Direksi )</u></span>
                    </div>
                    <div class="col-4">
                        <span class="cont-text" style="font-size:13px; font-weight:bold"><u>( Akunting )</u></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    $(function () {
        $(".test").terbilang();
        $(".as-output-text").terbilang({
            nominal: document.getElementById("subtotal").value,
            output: 'text'
        });
    })
</script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>