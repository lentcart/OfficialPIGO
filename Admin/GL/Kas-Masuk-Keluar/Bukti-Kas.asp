<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    CB_ID = request.queryString("CB_ID")    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set CashBank_cmd = server.createObject("ADODB.COMMAND")
	CashBank_cmd.activeConnection = MM_PIGO_String
			
	CashBank_cmd.commandText = "SELECT GL_T_CashBank_H.* FROM GL_T_CashBank_H WHERE CB_ID = '"& CB_ID &"' "
    'response.write CashBank_cmd.commandText
	set CashBank = CashBank_cmd.execute


    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

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
    <script src="<%=base_url%>/js/terbilang.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>

     
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "BuktiKas-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-OFICIAL PIGO";

    
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
    </style>
    </head>
<body>  
    <!--<div class="container">
    <div class="row">
        <div class="col-12">
            <a href="index.asp"> Kembali </a>
        </div>
    </div>
    </div>-->
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
                        <span class="txt-desc"> <%=Merchant("custEmail")%> </span><br>
                        <span class="txt-desc"> <%=Merchant("custPhone1")%> </span> / <span class="txt-desc"> <%=Merchant("custPhone2")%> </span><br>
                    </div>
                </div>
                <div class="row mt-2" style="border-bottom:3px solid black">
                </div>

            <% do while not CashBank.eof %>
            <div class="row">
                <div class="col-3">
                    <span class="txt-desc"> No Jurnal </span><br>
                    <span class="txt-desc"> No Kas/Bank </span><br>
                    <span class="txt-desc"> Tanggal Pembuatan </span><br>
                </div>
                <div class="col-9">
                    <input type="hidden" name="CB_JR_ID" id="CB_JR_ID" value="<%=CashBank("CB_JR_ID")%>">
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"><%=CashBank("CB_JR_ID")%></span><br>
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"><%=CashBank("CB_ID")%></span><br>
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"><%=CashBank("CB_Tanggal")%></span><br>
                </div>
            </div>
            <div class="row mt-2 mb-2 text-center">
                    <div class="col-12">
                        <span class="cont-text" style="font-size:20px; font-weight:bold"><u> TANDA BUKTI KAS/BANK KELUAR </u></span>
                    </div>
                </div>
            <div class="row mt-3">
                <div class="col-3">
                    <span class="txt-desc"> Terima Dari  </span><br>
                </div>
                <div class="col-9">
                    <span class="txt-desc"> : </span>&nbsp;<span class="txt-desc"> <%=CashBank("CB_Keterangan")%> </span><br>
                </div>
            </div>
            <div class="row mt-1">
                <div class="col-12">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:11px">
                        <thead>
                            <tr>
                                <th class="text-center"> NO </th>
                                <th class="text-center"> KETERANGAN SINGKAT </th>
                                <th class="text-center"> KODE PERKIRAAN </th>
                                <th class="text-center"> JUMLAH</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                CashBank_cmd.commandText = "SELECT GL_T_CashBank_D.CBD_Item_ID,GL_T_CashBank_D.CBD_Keterangan, GL_M_Item.Item_Name, GL_T_CashBank_D.CBD_Quantity, GL_T_CashBank_D.CBD_Harga FROM GL_M_Item RIGHT OUTER JOIN GL_T_CashBank_D ON GL_M_Item.Item_ID = GL_T_CashBank_D.CBD_Item_ID RIGHT OUTER JOIN GL_T_CashBank_H ON LEFT(GL_T_CashBank_D.CBD_ID,18) = GL_T_CashBank_H.CB_ID WHERE LEFT(GL_T_CashBank_H.CB_ID,18) = '"& CashBank("CB_ID") &"' "
                                'response.write CashBank_cmd.commandText
                                set CashBankD = CashBank_cmd.execute
                            %>
                            <% 
                                no = 0 
                                do while not CashBankD.eof 
                                no = no + 1 
                            %>
                            <tr>
                                <td> <%=no%> </td>
                                <td> <%=CashBankD("CBD_Keterangan")%> </td>
                                <td> <%=CashBankD("CBD_Item_ID")%> </td>
                                <td class="text-end"> <%=Replace(Replace(FormatCurrency(CashBankD("CBD_Harga")),"$","Rp. "),".00",",-")%> </td>
                                <%
                                    subtotal = subtotal + CashBankD("CBD_Harga")
                                %>
                            </tr>
                            <% 
                                CashBankD.movenext
                                loop 
                            %>
                            <tr>
                                <td colspan="3"> Total </td>
                                <td class="text-end"> 
                                    <input type="hidden" name="subtotal" id="subtotal" value="<%=subtotal%> ">
                                    <%=Replace(Replace(FormatCurrency(subtotal),"$","Rp. "),".00",",-")%> 
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <%
                CB_JR_ID = CashBank("CB_JR_ID")
            %>
            <% CashBank.movenext
            loop %>  
            <div class="row mt-1">
                <div class="col-2">
                    <span class="txt-desc">Terbilang</span><br>
                </div>
                <div class="col-10 p-0" style="border-bottom: 1px dotted black;">
                    <input type="hidden" name="total" id="total" value="12584">
                    <span class="txt-desc"> : </span>  &nbsp;&nbsp;  <b><span class="as-output-text txt-desc"></span></b>
                    <b><span class=" txt-desc">Rupiah</span></b>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12">
                    <%
                        NOJURNAL = CB_JR_ID
                    %>
                    <span class="txt-desc"><B>DETAIL JURNAL</B></span><br><br>
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:11px">
                            <%
                                ' Jurnal Debet In Rincian Kredit 
                                CashBank_cmd.commandText = "SELECT DEBET.CA_Name, GL_M_Item.Item_CAIDD, SUM(GL_T_CashBank_D.CBD_Harga) AS DEBET, 0 AS KREDIT, GL_T_CashBank_H.CB_JR_ID, GL_T_CashBank_H.CB_Keterangan FROM GL_M_ChartAccount AS DEBET RIGHT OUTER JOIN GL_M_Item ON DEBET.CA_ID = GL_M_Item.Item_CAIDD RIGHT OUTER JOIN GL_T_CashBank_D ON GL_M_Item.Item_ID = GL_T_CashBank_D.CBD_Item_ID RIGHT OUTER JOIN GL_T_Jurnal_H RIGHT OUTER JOIN GL_T_CashBank_H ON GL_T_Jurnal_H.JR_ID = GL_T_CashBank_H.CB_JR_ID ON LEFT(GL_T_CashBank_D.CBD_ID, 18) = GL_T_CashBank_H.CB_ID WHERE (GL_T_Jurnal_H.JR_ID ='"& NOJURNAL &"') GROUP BY DEBET.CA_Name, GL_M_Item.Item_CAIDD, GL_T_CashBank_H.CB_JR_ID, GL_T_CashBank_H.CB_Keterangan "
                                set JurnalH = CashBank_cmd.execute
                                ' 'Jurnal Debet Jumlah Total Dari Kredit
                                ' CashBank_cmd.commandText = "SELECT GL_T_Jurnal_D.JRD_Keterangan, GL_T_Jurnal_D.JRD_CA_ID, Debet.CA_Name, GL_T_Jurnal_D.JRD_Debet, GL_T_Jurnal_D.JRD_Kredit FROM GL_T_Jurnal_D LEFT OUTER JOIN GL_M_ChartAccount AS Debet ON GL_T_Jurnal_D.JRD_CA_ID = Debet.CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID WHERE LEFT(GL_T_Jurnal_D.JRD_ID,12) = '"& NOJURNAL &"' ORDER BY JRD_Kredit"
                                ' 'response.write CashBank_cmd.commandText
                                ' set JurnalH = CashBank_cmd.execute
                            %>
                            <% do while not JurnalH.eof %>
                            <tr>
                                <td> <%=JurnalH("Item_CAIDD")%> </td>
                                <td> <%=JurnalH("CA_Name")%> </td>
                                <td class="text-end"> <%=JurnalH("DEBET")%> </td>
                                <td class="text-end"> <%=JurnalH("KREDIT")%> </td>
                                <td> <%=JurnalH("CB_Keterangan")%> </td>
                            </tr>
                            <% 
                                JurnalH.movenext
                                loop
                            %>
                            <%
                                ' Jurnal Debet In Rincian Kredit 
                                CashBank_cmd.commandText = "SELECT KREDIT.CA_Name, GL_T_CashBank_D.CBD_Harga AS KREDIT, 0 AS DEBET, GL_T_CashBank_H.CB_JR_ID, GL_T_CashBank_D.CBD_Keterangan, KREDIT.CA_ID FROM GL_M_ChartAccount AS KREDIT RIGHT OUTER JOIN GL_M_Item ON KREDIT.CA_ID = GL_M_Item.Item_CAIDK RIGHT OUTER JOIN GL_T_CashBank_D ON GL_M_Item.Item_ID = GL_T_CashBank_D.CBD_Item_ID RIGHT OUTER JOIN GL_T_Jurnal_H RIGHT OUTER JOIN GL_T_CashBank_H ON GL_T_Jurnal_H.JR_ID = GL_T_CashBank_H.CB_JR_ID ON LEFT(GL_T_CashBank_D.CBD_ID, 18) = GL_T_CashBank_H.CB_ID WHERE (GL_T_Jurnal_H.JR_ID = '"& NOJURNAL &"')"
                                set JurnalH = CashBank_cmd.execute
                                ' 'Jurnal Debet Jumlah Total Dari Kredit
                                ' CashBank_cmd.commandText = "SELECT GL_T_Jurnal_D.JRD_Keterangan, GL_T_Jurnal_D.JRD_CA_ID, Debet.CA_Name, GL_T_Jurnal_D.JRD_Debet, GL_T_Jurnal_D.JRD_Kredit FROM GL_T_Jurnal_D LEFT OUTER JOIN GL_M_ChartAccount AS Debet ON GL_T_Jurnal_D.JRD_CA_ID = Debet.CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID WHERE LEFT(GL_T_Jurnal_D.JRD_ID,12) = '"& NOJURNAL &"' ORDER BY JRD_Kredit"
                                ' 'response.write CashBank_cmd.commandText
                                ' set JurnalH = CashBank_cmd.execute
                            %>
                            <% do while not JurnalH.eof %>
                            <tr>
                                <td> <%=JurnalH("CA_ID")%> </td>
                                <td> <%=JurnalH("CA_Name")%> </td>
                                <td class="text-end"> <%=JurnalH("DEBET")%> </td>
                                <td class="text-end"> <%=JurnalH("KREDIT")%> </td>
                                <td> <%=JurnalH("CBD_Keterangan")%> </td>
                            </tr>
                            <% 
                                JurnalH.movenext
                                loop
                            %>
                    </table>
                </div>
            </div>
            <div class="row text-center" style="margin-top:1rem">
                <div class="col-7">
                    <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                        <thead>
                            <tr>
                                <th class="text-center"> Direksi </th>
                                <th class="text-center"> Fiat Byr </th>
                                <th class="text-center"> Pembk. </th>
                                <th class="text-center"> Kabag </th>
                            </tr>
                            
                        </thead>
                        <tbody>
                            <td><br><br><br><br></td>
                            <td><br><br><br><br></td>
                            <td><br><br><br><br></td>
                            <td><br><br><br><br></td>
                        </tbody>
                    </table>
                </div>
                <div class="col-5">
                    <span   class="cont-text"> Tanggal, <%=Cdate(date())%> </span><br>
                    <span   class="cont-text"> Tanda Tangan Penerima</span><br><br><br><br>
                    <span   class="cont-text"> ...................</span><br><br><br><br>
                    
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