<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))



    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " mmTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

	tgla = request.queryString("tgla")
    tgle = request.queryString("tgle")
    CB_ID = request.queryString("CB_ID")
    CB_JR_ID = request.queryString("CB_JR_ID")
    CB_Jenis = request.queryString("CB_Jenis")
    CB_PostingYN = request.queryString("CB_PostingYN")

    set CashBank_cmd = server.createObject("ADODB.COMMAND")
	CashBank_cmd.activeConnection = MM_PIGO_String

        CashBank_cmd.commandText = "SELECT GL_T_CashBank_H.* FROM GL_T_CashBank_H WHERE CB_Tanggal between '08-01-2022' and '08-24-2022'  ORDER BY CB_Tanggal ASC"
        'response.write CashBank_cmd.commandText 

    set CashBank = CashBank_cmd.execute

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
    <script>
    var today = new Date();

    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        // window.print();
        document.title = "Laporan-MaterialReceipt-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
    </script>
    <style>
        body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: white;
            font-weight:450;
        }
        * {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
        }
        .page {
            width: 355.6mm;
            min-height: 215.9mm;
            padding: 10mm;
            margin: auto;
            border: none;
            border-radius: 5px;
            background: white;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .subpage {
            padding: 0cm;
            border:none;
            height:100%;
            outline: 0cm green solid;
        }
        
        @page {
            size: landscape;
            margin: 0;
        }
        @media print {
            html, body {
                width: 355.6mm;
            min-height: 215.9mm;        
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
                    <div class="col-7">
                        <span class="cont-text"><b> LAPORAN CASH FLOW </b></span><br>
                        <span> <b> Periode -  <%=tgla%> s.d. <%=tgle%> </b></span>
                    </div>
                    <div class="col-5">
                        <div class="row align-items-center">   
                            <div class="col-2">
                                <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                            </div>
                            <div class="col-10">
                                <span class="Judul-Merchant" style="font-size:22px"> <b><%=Merchant("custNama")%> </b></span><br>
                        <span class="txt-desc"> <%=Merchant("almLengkap")%> </span><br>
                        <span class="txt-desc"> <%=Merchant("custEmail")%> </span><br>
                        <span class="txt-desc"> <%=Merchant("custPhone1")%> </span> / <span class="txt-desc"> <%=Merchant("custPhone2")%> </span><br>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 mb-2" style="border-bottom:2px solid black">
                
                </div>
                <div class="row">
                    <div class="col-12">
                        <table class="table cont-tb tb-transaksi table-bordered table-condensed mt-1">
                            <thead style="background-color:#aaa">
                                <tr class="text-center">
                                    <th> NO URUT </th>
                                    <th> TANGGAL </th>
                                    <th> NO TRANSAKSI </th>
                                    <th colspan="2"> KETERANGAN </th>
                                </tr>
                            </thead>
                            <tbody>
                            <% 
                                no = 0 
                                do while not CashBank.eof 
                                no = no + 1 
                            %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td class="text-center"> <%=Cdate(CashBank("CB_Tanggal"))%> </td>
                                    <td class="text-center"> <%=CashBank("CB_ID")%> </td>
                                    <td colspan="2"> <%=CashBank("CB_Keterangan")%> </td>
                                </tr>
                            </tbody>
                            <thead style="background-color:#aaa">
                                <tr class="text-center">
                                    <th colspan="2"> URAIAN </th>
                                    <th> KODE PERKIRAAN </th>
                                    <th> DEBET </th>
                                    <th> KREDIT </th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                CashBank_cmd.commandText = "SELECT GL_M_Item.Item_CAIDK, GL_M_ChartAccount.CA_Name, GL_T_CashBank_D.CBD_Harga AS KREDIT, 0 AS DEBET, GL_T_CashBank_D.CBD_Keterangan FROM GL_M_ChartAccount RIGHT OUTER JOIN GL_M_Item ON GL_M_ChartAccount.CA_ID = GL_M_Item.Item_CAIDK RIGHT OUTER JOIN GL_T_CashBank_D ON GL_M_Item.Item_ID = GL_T_CashBank_D.CBD_Item_ID RIGHT OUTER JOIN GL_T_CashBank_H ON LEFT(GL_T_CashBank_D.CBD_ID, 18) = GL_T_CashBank_H.CB_ID WHERE CB_Tanggal between '08-01-2022' and '08-24-2022' and   GL_T_CashBank_H.CB_ID = '"& CashBank("CB_ID") &"' "
                                'response.write CashBank_cmd.commandText 

                                set CashBankD = CashBank_cmd.execute
                            %>
                            <% 
                                do while not CashBankD.eof 
                            %>
                                <tr>
                                    <td colspan="2"> <%=CashBankD("CBD_Keterangan")%> </td>
                                    <td class="text-center"> <%=CashBankD("Item_CAIDK")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(CashBankD("DEBET")),"$","Rp. "),".00",",-")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(CashBankD("KREDIT")),"$","Rp. "),".00",",-")%> </td>
                                </tr>
                                <%
                                    debet = debet + CashBankD("DEBET")
                                    kredit = kredit + CashBankD("KREDIT")
                                %>
                            <%
                                CashBankD.movenext
                                loop
                            %>
                            </tbody>
                                <tr style="background-color:#aaa" >
                                    <th colspan="3"> SUBTOTAL </th>
                                    <th class="text-end"> <%=debet%> </th>
                                    <th class="text-end"> <%=kredit%> </th>
                                </tr>
                                <%
                                    totaldebet = totaldebet + debet
                                    debet = 0 
                                    totalkredit = totalkredit + kredit
                                    kredit = 0
                                %>
                            <% CashBank.movenext
                            loop %>
                            <thead style="background-color:#aaa">
                                <%
                                    subtotaldebet = subtotaldebet + totaldebet
                                    subtotalkredit = subtotalkredit + totalkredit
                                %>
                                <tr >
                                    <th colspan="3"> TOTAL KESELURUHAN </th>
                                    <th class="text-end"> <%=subtotaldebet%> </th>
                                    <th class="text-end"> <%=subtotalkredit%> </th>
                                </tr>
                                <% 
                                    sisa = subtotaldebet - subtotalkredit
                                %>
                                <tr >
                                    <th colspan="3"> TOTAL KESELURUHAN </th>
                                    <th colspan="2" class="text-center"> <%=sisa%> </th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>    
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>