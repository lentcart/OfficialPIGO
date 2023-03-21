<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

        set GL_M_GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
        GL_M_GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String

        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount "
        set ChartAccount = GL_M_GL_M_ChartAccount_cmd.execute
%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Export PDF - Account Kas PIGO</title>

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
        window.print();
        document.title = "Account-Kas-"+today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+"-PIGO";
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
    </style>
    </head>
<body>  
    <div class="book">
        <div class="page">
            <div class="subpage">
                <div class="row align-items-center">
                    <div class="col-5">
                        <span style="font-size:21px"> ACCOUNT KAS </span><br>
                        <span> Tanggal Cetak&nbsp;<b> <%=CDate(Date())%> </b> </span>
                    </div>
                    <div class="col-7 text-end">
                        <span class="Judul-Merchant" style="font-size:25px; color:#0077a2"> <b>PT. PERKASA INDAH GEMILANG OETAMA</b></span><br>
                        <span class="txt-desc"> Jln. Alternatif Cibubur, Komplek Ruko Cibubur Point Automotiv Center Blok B No. 12B Cimangis,</span><br>
                        <span class="txt-desc"> Depok – Jawa Barat </span><br>
                        <span class="txt-desc"> otopigo.sekertariat@gmail.com </span><br>
                        <span class="txt-desc"> Telp : (021) 8459 6001 / 0811-8838-008 </span>
                    </div>
                </div>
                <div class="row mt-2 mb-2" style="border-bottom:4px solid black">
                
                </div>
                <div class="row mt-1">
                    <div class="col-12">
                        <table class="table tb-transaksi cont-tb table-bordered table-condensed" style=" border:1px solid black;font-size:12px">
                        <thead class="text-center">
                            <tr>
                                <th> NO </th>
                                <th> ACC ID </th>
                                <th> NAMA ACC  </th>
                                <th> ACC UP ID </th>
                                <th> ACC JENIS </th>
                                <th> ACC TYPE </th>
                                <th> ACC GOLONGAN </th>
                                <th> ACC KELOMPOK </th>
                                <th> ACC TYPE ITEM </th>
                                <th> ACC AKTIFYN </th>
                            </tr>
                        </thead>
                        <tbody> 
                            <%
                                no = 0 
                                do while not ChartAccount.eof
                                no = no + 1
                            %>
                            <tr>
                                <td><%=no%></td>
                                <% if ChartAccount("CA_Type") = "H" then %>
                                <td><b><%=ChartAccount("CA_ID")%></b></td>
                                <td><b><%=ChartAccount("CA_Name")%></b></td>
                                <% else %>
                                <td><%=ChartAccount("CA_ID")%></td>
                                <td><%=ChartAccount("CA_Name")%></td>
                                <% end if %>
                                <td class="text-center"><%=ChartAccount("CA_UpID")%></td>
                                <td class="text-center"><%=ChartAccount("CA_Jenis")%></td>
                                <td class="text-center"><%=ChartAccount("CA_Type")%></td>
                                <td class="text-center"><%=ChartAccount("CA_Golongan")%></td>
                                <td class="text-center"><%=ChartAccount("CA_Kelompok")%></td>
                                <td class="text-center"><%=ChartAccount("CA_ItemTipe")%></td>
                                <td class="text-center"><%=ChartAccount("CA_AktifYN")%></td>
                            </tr>
                            <% 
                                ChartAccount.movenext
                                loop
                            %>
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