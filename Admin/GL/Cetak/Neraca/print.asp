<!--#include file="../../../../Connections/pigoConn.asp" -->
<!--#include file="../../../../UpdateLOG/UpdateLOG.asp"-->
<%

    bulan       = request.Form("Bulan")
    tahun       = request.Form("Tahun")
    AccountType = request.Form("typejr")

    MSCA_SaldoBlnD = "MSCA_SaldoBln"& bulan &"D"
    MSCA_SaldoBlnK = "MSCA_SaldoBln"& bulan &"K"


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))



    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and poTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Neraca_cmd = server.createObject("ADODB.COMMAND")
	Neraca_cmd.activeConnection = MM_PIGO_String
			
	Neraca_cmd.commandText = "select CONVERT(varchar,dateadd(d,-(day(dateadd(m,1,getdate()))),dateadd(m,1,getdate())),106) as tgl"
	set bln = Neraca_cmd.execute

	Neraca_cmd.commandText = "SELECT GL_M_Kelompok.KCA_Name, GL_M_ChartAccount.CA_Kelompok, GL_M_Kelompok.KCA_ID FROM GL_M_ChartAccount LEFT OUTER JOIN GL_M_Kelompok ON GL_M_ChartAccount.CA_Kelompok = GL_M_Kelompok.KCA_ID WHERE CA_Kelompok <> '' and GL_M_Kelompok.KCA_ID between '01' and '03'  GROUP BY GL_M_Kelompok.KCA_Name, GL_M_ChartAccount.CA_Kelompok, GL_M_Kelompok.KCA_ID ORDER BY GL_M_Kelompok.KCA_ID  ASC"
    'response.Write Neraca_cmd.commandText
	set Neraca = Neraca_cmd.execute

	' set supplier_cmd = server.createObject("ADODB.COMMAND")
	' supplier_cmd.activeConnection = MM_PIGO_String
			
	' supplier_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi  FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_M_Customer.custID = MKT_T_PurchaseOrder_H.po_custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H Where poTanggal between '"& tgla &"' and '"& tgle &"' AND almJenis <> 'Alamat Toko' GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custNpwp, MKT_M_Customer.custFax,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custTransaksi, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almProvinsi  "
    ' 'response.write supplier_cmd.commandText
	' set supplier = supplier_cmd.execute

    ' set produk_cmd = server.createObject("ADODB.COMMAND")
	' produk_cmd.activeConnection = MM_PIGO_String

    Log_ServerID 	= "" 
    Log_Action   	= "PRINT"
    Log_Key         = "GL-Neraca"
    Log_Keterangan  = "Melakukan cetak (GL) Neraca Periode Bulan : "& bulan &" Tahun : "& tahun &" Kategori : "& AccountType
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

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
        document.title = "Laporan-PurchaseOrder-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
    </script>
    <style>
        body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: white;
            font-size:12px;
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
        .text-judul-gl{
            font-size:24px;
            font-weight:bold;
            color:black;
        }
        .text-desc-gl{
            font-size:13px;
            font-weight:500;
            color:black;
        }
    </style>
    </head>
<body>  
    <div class="book">
        <div class="page">
            <div class="subpage">
                <div class="row">
                    <div class="col-11">
                        <span class="text-judul-gl"> PT. PERKASA INDAH GEMILANG OETAMA </span><br>
                        <span class="text-desc-gl"> Jalan Alternatif Cibubur, Cimangis, Depok – Jawa Barat</span><br>
                        <span class="text-desc-gl"> oficial@otopigo.com</span><br>
                        <span class="text-desc-gl"> 0881-8808-8088</span><br>
                    </div>
                    <div class="col-1">
                        <img src="<%=base_url%>/assets/logo/3.png" class="logo me-3" alt="" width="65" height="85" />
                    </div>
                </div>
                <div class="row mt-3 mb-3 text-center" >
                    <div class="col-12">
                        <span class="text-judul-gl"> LAPORAN POSISI KEUANGAN </span><br>
                        <span class="text-desc-gl"> PERIODE <b><%=bln("tgl")%></b> </span><br>
                    </div>
                </div>

                <div class="row ">
                    <div class="col-12">
                        <table class="table tb-transaksi cont-tb table-bordered table-condensed" style="font-size:13px;border:1px solid white;color:black">
                            <thead style="background-color:#eee">
                                <tr>
                                    <th class="text-center"> KODE PERKIRAAN </th>
                                    <th class="text-center"> NAMA PERKIRAAN </th>
                                    <th class="text-center"> SALDO </th>
                                    <th class="text-center"> TOTAL </th>
                                </tr>
                            </thead>
                            <tbody>
                            <%  no = 0 
                                do while not Neraca.eof
                                no = no + 1 
                            %>
                            <%
                                Neraca_cmd.commandText = "SELECT GL_M_ChartAccount.CA_ID, GL_M_ChartAccount.CA_Jenis, GL_M_ChartAccount.CA_Name FROM GL_M_ChartAccount LEFT OUTER JOIN GL_M_Kelompok ON GL_M_ChartAccount.CA_Kelompok = GL_M_Kelompok.KCA_ID WHERE (GL_M_ChartAccount.CA_Kelompok <> '') AND (GL_M_ChartAccount.CA_Type = '"& AccountType &"') AND KCA_ID = '"& Neraca("KCA_ID") &"' and GL_M_ChartAccount.CA_ID <> 'C102.00.00'  GROUP BY GL_M_ChartAccount.CA_Name, GL_M_ChartAccount.CA_Jenis , GL_M_ChartAccount.CA_ID ORDER BY GL_M_ChartAccount.CA_ID "
                                'response.write Neraca_cmd.commandText
                                set Account = Neraca_cmd.execute
                            %>
                            <% do while not Account.eof %>
                            <tr>
                                <td class="text-center"> <%=Account("CA_ID")%> </td>
                                <td><%=Account("CA_Name")%> </td>
                                <% if Account("CA_Jenis") = "D" then %>
                                <%
                                    Neraca_cmd.commandText = "SELECT ISNULL(SUM(GL_T_MutasiSaldoCA."& MSCA_SaldoBlnD &"-GL_T_MutasiSaldoCA."& MSCA_SaldoBlnK &"),0) AS Saldo FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID Where MSCA_CAID = '"& Account("CA_ID") &"' and  CA_Kelompok = '"& Neraca("KCA_ID") &"'  "
                                    'response.write Neraca_cmd.commandText
                                    set Saldo = Neraca_cmd.execute
                                %>
                                <% else %>
                                <%
                                    Neraca_cmd.commandText = "SELECT ISNULL(SUM(GL_T_MutasiSaldoCA."& MSCA_SaldoBlnK &"-GL_T_MutasiSaldoCA."& MSCA_SaldoBlnD &"),0) AS Saldo FROM GL_M_ChartAccount LEFT OUTER JOIN GL_T_MutasiSaldoCA ON GL_M_ChartAccount.CA_ID = GL_T_MutasiSaldoCA.MSCA_CAID Where MSCA_CAID = '"& Account("CA_ID") &"' and  CA_Kelompok = '"& Neraca("KCA_ID") &"'  "
                                    'response.write Neraca_cmd.commandText
                                    set Saldo = Neraca_cmd.execute
                                %>
                                <% end if %>
                                <% do while not Saldo.eof %>
                                <td class="text-end"><%=Replace(Replace(FormatCurrency(Saldo("Saldo")),"$",""),".00","")%> </td>
                                <% TotalSaldo = TotalSaldo + Saldo("Saldo") %>
                                <% Saldo.movenext
                                loop %>
                            </tr>
                            <% Account.movenext
                            loop %>
                            <tr style="background-color:#eee; color:black; font-weight:bold">
                                <td colspan="2" class="text-end"> JUMLAH <%=Neraca("KCA_Name")%></td>
                                <td  class="text-end"> <%=Replace(Replace(FormatCurrency(TotalSaldo),"$",""),".00","")%></td>
                                <td > </td>
                                <% 
                                    Total = Total + TotalSaldo
                                    TotalSaldo = 0 
                                %>
                            </tr>
                            <% 
                                Neraca.movenext
                                loop
                            %>
                            <% subtotal = subtotal + Total %>
                            <tr style="background-color:#eee">
                                <td colspan="4" class="text-end" style="font-weight:bold; color:black"> <%=Replace(Replace(FormatCurrency(subtotal),"$",""),".00","")%></td>
                            </tr>
                            
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>  
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>