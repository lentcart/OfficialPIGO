<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if

    dim records

    set PurchaseOrder_cmd = server.createObject("ADODB.COMMAND")
	PurchaseOrder_cmd.activeConnection = MM_PIGO_String

        PurchaseOrder_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_T_PurchaseOrder_H.poUpdateTime,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custPaymentTerm, MKT_T_PurchaseOrder_H.po_JatuhTempo, MKT_T_PurchaseOrder_H.poDesc, MKT_T_PurchaseOrder_H.po_InvAP_Tanggal,  MKT_T_PurchaseOrder_H.poStatus, MKT_T_PurchaseOrder_H.po_payID, MKT_T_PurchaseOrder_H.po_payYN, MKT_T_PurchaseOrder_H.po_payTanggal, MKT_T_PurchaseOrder_H.poStatusKredit FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE (MKT_T_PurchaseOrder_H.poAktifYN = 'Y') GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_T_PurchaseOrder_H.poUpdateTime,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custPaymentTerm, MKT_T_PurchaseOrder_H.po_JatuhTempo, MKT_T_PurchaseOrder_H.poDesc, MKT_T_PurchaseOrder_H.po_InvAP_Tanggal,  MKT_T_PurchaseOrder_H.poStatus, MKT_T_PurchaseOrder_H.po_payID, MKT_T_PurchaseOrder_H.po_payYN, MKT_T_PurchaseOrder_H.po_payTanggal, MKT_T_PurchaseOrder_H.poStatusKredit ORDER BY poTanggal DESC"
        'response.write PurchaseOrder_cmd.commandText 

    set PurchaseOrder = PurchaseOrder_cmd.execute

    set DataPO_cmd = server.createObject("ADODB.COMMAND")
	DataPO_cmd.activeConnection = MM_PIGO_String

        DataPO_cmd.commandText = "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.po_custID FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN   MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H where  MKT_T_PurchaseOrder_D.po_spoID = '0'  GROUP BY MKT_T_PurchaseOrder_H.poID,MKT_T_PurchaseOrder_H.poTanggal,MKT_T_PurchaseOrder_H.po_custID"
        'response.write  DataPO_cmd.commandText

    set DataPO = DataPO_cmd.execute

    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_M_PIGO_Produk RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_PIGO_Produk.pdID = MKT_T_PurchaseOrder_D.po_pdID ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE MKT_T_PurchaseOrder_H.poAktifYN = 'Y'  GROUP BY MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama "
        'response.write  Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set statuspo_cmd = server.createObject("ADODB.COMMAND")
	statuspo_cmd.activeConnection = MM_PIGO_String

    set jatuhtempo_cmd = server.createObject("ADODB.COMMAND")
	jatuhtempo_cmd.activeConnection = MM_PIGO_String

    Dim Pages
    Set Pages = Server.CreateObject("Adodb.Connection")
    Pages.ConnectionString = MM_PIGO_String
    Pages.Open

    Dim PurchOrder, PagNav, TotalPag
    Dim CurrntPage, NextPage, Page, VisitePage
    Set PurchOrder = Server.CreateObject("Adodb.RecordSet")
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
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
        <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        <script>            
            function cetakpo(){
                $.ajax({
                    type: "get",
                    url: "get-datapo.asp?poID="+document.getElementById("poID").value,
                    success: function (url) {
                        $('.datatr').html(url);
                        // console.log(url);
                    }
                });
            }
            function caripo(){
                $.ajax({
                    type: "get",
                    url: "load-datapo.asp?caripo="+document.getElementById("caripo").value+"&jenispo="+document.getElementById("jenispo").value,
                    success: function (url) {
                        $('.datatr').html(url);
                        // console.log(url);
                    }
                });
            }
            function cetaklist(){
                $.ajax({
                    type: "get",
                    url: "listprodukpo.asp?namapd="+document.getElementById("namapd").value,
                    success: function (url) {
                        $('.datatr').html(url);
                        // console.log(url);
                    }
                });
            }
            function tgla(){
                $.ajax({
                    type: "get",
                    url: "get-tanggal.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                    success: function (url) {
                        console.log(url);
                        $('.datatr').html(url);
                    }
                });
            }
        </script>
        <style>
            .d{
                background-color:transparent;
                padding:5px 5px;
            }
            .d a {
                color: black;
                width:100%;
                font-size:12px;
                font-weight:bold;
                padding:5px 15px;
                text-decoration: none;
                margin-left:10px;
                background-color:#eee;
            }

            .d a.active {
                font-size:12px;
                background-color: #0077a2;
                color: white;
            }

            .d a:hover:not(.active) {background-color: #ddd;}
            .fonte a{
                color:red;
            }
            .cont-produk-tb{
                height:100% !important;
                overflow:scroll;
            }
        </style>
    </head>
    <!--#include file="../../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-9 col-md-9 col-sm-12">
                        <span class="cont-text"> PURCHASE ORDER DETAIL</span>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-12">
                        <button onclick="Refresh()" class="cont-btn"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <button class=" cont-btn" onclick="window.open('<%=base_url%>/Admin/Pembelian/PurchaseOrder/','_Self')" > Tambah PO  </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row align-items-center">
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <span class="cont-text me-4"> Cari </span><br>
                        <input disabled="true" onkeyup="return caripo()" class="cont-form" type="search" name="caripo" id="caripo" value="PIGO/PO/">
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <span class="cont-text"> Jenis Order PO </span><br>
                        <select disabled="true" onchange="return caripo(),window.open('list-jenisorder.asp?jenispo='+document.getElementById('jenispo').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"  class="cont-form" name="jenispo" id="jenispo" aria-label="Default select example" required>
                            <option value="">Pilih Jenis PO</option>
                            <option value="1">Slow Moving</option>
                            <option value="2">Fast Moving</option>
                        </select>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-12">
                        <span class="cont-text"> </span><br>
                        <select  onchange="return cetakpo()" name="poID" id="poID"  class=" cont-form" name="jenispo" id="jenispo" aria-label="Default select example" >
                            <option selected>Pilih PO </option>
                            <% if DataPO.eof = true then %>
                            <option value="0"> Belum Ada PO Terbaru </option>
                            <% else %>
                            <% do while not DataPO.eof %>
                            <option value="<%=DataPO("poID")%>"><%=DataPO("poID")%>,<%=DataPO("poTanggal")%></option>
                            <% DataPO.movenext
                            loop%>
                            <% end if %>
                        </select>
                    </div>  
                    <div class="col-lg-1 col-md-6 col-sm-12">
                        <span class="cont-text"> </span><br>
                        <button onclick="window.open('buktipo.asp?poID='+document.getElementById('poID').value+'&poTanggal='+document.getElementById('tanggalpo').value,'_Self')" class="cont-btn" > Cetak </button>
                    </div>  
                </div>

                <div class="row align-items-center mt-1">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <span class="cont-text me-4"> Periode PO </span><br>
                    </div>
                </div>

                <div class="row align-items-center mt-1">
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <input onchange="tgla()" class=" mb-2 cont-form" type="date" name="tgla" id="tgla" value="" >
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12">
                        <input onchange="tgla(),updatebtn()" class=" mb-2 cont-form" type="date" name="tgle" id="tgle" value="" >
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <select  onchange="window.open('list-namaproduk.asp?namapd='+document.getElementById('namapd').value+'&tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')" name="namapd" id="namapd"  class=" mb-2 cont-form" name="jenispo" id="jenispo" aria-label="Default select example" disabled >
                            <option value=""> Nama Produk </option>
                            <% do while not Produk.eof %>
                            <option value="<%=Produk("pdNama")%>"> <%=Produk("pdNama")%> </option>
                            <% Produk.movenext
                            loop %>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12 align-items-center">
                        <div class="dropdown mb-2">
                            <button class="cont-btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                Download 
                            </button>
                            <ul class="dropdown-menu text-center cont-btn" aria-labelledby="dropdownMenuButton1">
                                <li>
                                    <button class="cont-btn" onclick="window.open('lap-popdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value)">Laporan PDF</button>
                                </li>
                                <li>
                                    <button class=" mt-2 cont-btn" onclick="window.open('lap-poexc.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value)"> Laporan Excel </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="cont-tb p-2">
                <div class="purchase-order" style="overflow:scroll; overflow-x:scroll">
                    <div class="row d-flex flex-row-reverse align-items-center datatr">
                        <div class="col-12">
                            <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="width:80rem">  
                                <%
                                    Pages.CursorLocation = 3
                                    PurchOrder.PageSize = 8
                                    PurchOrder.Open "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_T_PurchaseOrder_H.poUpdateTime,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custPaymentTerm, MKT_T_PurchaseOrder_H.po_JatuhTempo, MKT_T_PurchaseOrder_H.poDesc, MKT_T_PurchaseOrder_H.po_InvAP_Tanggal,  MKT_T_PurchaseOrder_H.poStatus, MKT_T_PurchaseOrder_H.po_payID, MKT_T_PurchaseOrder_H.po_payYN, MKT_T_PurchaseOrder_H.po_payTanggal, MKT_T_PurchaseOrder_H.poStatusKredit FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE (MKT_T_PurchaseOrder_H.poAktifYN = 'Y') GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_T_PurchaseOrder_H.poUpdateTime,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custPaymentTerm, MKT_T_PurchaseOrder_H.po_JatuhTempo, MKT_T_PurchaseOrder_H.poDesc, MKT_T_PurchaseOrder_H.po_InvAP_Tanggal,  MKT_T_PurchaseOrder_H.poStatus, MKT_T_PurchaseOrder_H.po_payID, MKT_T_PurchaseOrder_H.po_payYN, MKT_T_PurchaseOrder_H.po_payTanggal, MKT_T_PurchaseOrder_H.poStatusKredit ORDER BY poUpdateTime DESC",Pages

                                    If PurchOrder.Eof Then
                                        Response.Write("<tr><td height=""28"" align=""center"">LISTA VAZIA</td></tr>")
                                    Else

                                        PagNav = CInt(Request.QueryString("Pages"))
                                            
                                        If (PagNav = 0) Then : PagNav = 1 : End If
                                        PurchOrder.AbsolutePage = PagNav
                                        TotalPag = PurchOrder.PageCount
                                    end if 
                                %>
                                <thead>
                                        <tr class="text-center">
                                            <th> NO </th>
                                            <th> PO ID </th>
                                            <th> TANGGAL </th>
                                            <th> JENIS ORDER </th>
                                            <th> BUSSINES PARTNER </th>
                                            <th colspan="2"> STATUS PO </th>
                                            <th colspan="2"> STATUS PEMBAYARAN </th>
                                            <th colspan="2"> JATUH TEMPO </th>
                                            <th> AKSI </th>
                                        </tr>
                                </thead>
                                <tbody >
                                    <% 
                                        no = 0 
                                        While Not PurchOrder.Eof And PurchOrder.AbsolutePage = PagNav 
                                        no = no + 1
                                    %>
                                    <tr>
                                        <td class="text-center"> 
                                            <%=no%> 
                                            
                                        </td>
                                        <%
                                            PurchaseOrder_cmd.commandText = "SELECT ISNULL(COUNT(MKT_T_PurchaseOrder_D.poID_H),0) as ID FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE poID_H = '"& PurchaseOrder("poID") &"' "
                                            'response.write PurchaseOrder_cmd.commandText 
                                            set PO = PurchaseOrder_cmd.execute
                                        %>
                                        <% If PO("ID") = "0" then %>

                                            <td style="color:red"class="text-center"> <%=PurchOrder("poID")%> </td>
                                                <input type="hidden" name="tanggalpo" id="tanggalpo" value="<%=PurchOrder("poTanggal")%>">
                                            <td style="color:red"class="text-center"> <%=Day(CDate(PurchOrder("poTanggal")))%>/<%=Month(CDate(PurchOrder("poTanggal")))%>/<%=Year(CDate(PurchOrder("poTanggal")))%> </td>

                                            <td  style="color:red"class="text-center"> 
                                                <% if PurchOrder("poJenisOrder") = "1" then %>
                                                <span style="color:red" class="cont-text"> Slow Moving </span>
                                                <% else %>
                                                <span style="color:red" class="cont-text"> Fast Moving </span>
                                                <% end if %>
                                            </td>
                                            <% if PurchOrder("poStatusKredit") = "01" then %>
                                            <td style="color:red"> <%=PurchOrder("custNama")%> </td>
                                            <% else %>
                                            <td style="color:red"> <%=PurchOrder("poDesc")%> </td>
                                            <% end if %>
                                            <td style="color:red"class="text-center"> - </td>
                                            <td style="color:red"class="text-center"> - </td>
                                            <td style="color:red"class="text-center"> - </td>
                                            <td style="color:red"class="text-center"> - </td>
                                            <td style="color:red"class="text-center"> - </td>
                                            <td style="color:red"class="text-center"> - </td>

                                            <td class="text-center">
                                                <button class="cont-btn" onclick="hapus<%=no%>()"> DELETE </button>
                                            </td>

                                        <% else %>

                                            <td class="text-center"> 
                                                <input type="hidden" name="idpo" id="idpo<%=no%>" value="<%=PurchOrder("poID")%>">
                                                <input type="hidden" name="tanggalpo" id="tanggalpo<%=no%>" value="<%=PurchOrder("poTanggal")%>">
                                                <button onclick="window.open('buktipo.asp?poID='+document.getElementById('idpo<%=no%>').value+'&poTanggal='+document.getElementById('tanggalpo<%=no%>').value,'_Self')" class="cont-btn" > <%=PurchOrder("poID")%>  </button>
                                            </td>
                                            <td class="text-center"> <%=Day(CDate(PurchOrder("poTanggal")))%>-<%=Month(CDate(PurchOrder("poTanggal")))%>-<%=Year(CDate(PurchOrder("poTanggal")))%> </td>

                                            <td class="text-center"> 
                                                <% if PurchOrder("poJenisOrder") = "1" then %>
                                                <span class="cont-text"> Slow Moving </span>
                                                <% else %>
                                                <span class="cont-text"> Fast Moving </span>
                                                <% end if %>
                                            </td>
                                            <% if PurchOrder("poStatusKredit") = "01" then %>
                                            <td> <%=PurchOrder("custNama")%> </td>
                                            <% else %>
                                            <td> <%=PurchOrder("poDesc")%> </td>
                                            <% end if %>
                                            <!-- Status Purchase Order -->
                                                <% 
                                                    statuspo_cmd.commandText = "SELECT MKT_M_StatusPurchaseOrder.spoName, MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_D.po_spoID FROM MKT_M_StatusPurchaseOrder RIGHT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_M_StatusPurchaseOrder.spoID = MKT_T_PurchaseOrder_D.po_spoID RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID WHERE MKT_T_PurchaseOrder_H.poID = '"& PurchOrder("poID") &"'"
                                                    'response.write statuspo_cmd.commandText
                                                    set statuspo = statuspo_cmd.execute
                                                %>
                                                <% if statuspo("po_spoID") = "0" then %>
                                                    <td class="text-center"><span class="label-stpo0"><%=statuspo("spoName")%></span></td>
                                                <% else if statuspo("po_spoID") = "1" then %>
                                                    <td class="text-center"><span class="label-stpo1"><%=statuspo("spoName")%></span></td>
                                                <% else if statuspo("po_spoID") = "2" then %>
                                                    <td class="text-center"><span class="label-stpo2"><%=statuspo("spoName")%></span></td>
                                                <% else if statuspo("po_spoID") = "3" then %>
                                                    <td class="text-center"><span class="label-stpo3"><%=statuspo("spoName")%></span></td>
                                                <% else %>
                                                    <td class="text-center"><span class="label-stpo4"><%=statuspo("spoName")%></span></td>
                                                <% end if %><% end if %><% end if %><% end if %>
                                                <td class="text-center">
                                                    <% if PurchOrder("poStatus") = "1" then %>
                                                    <button onclick="window.open('../PurchaseOrderDraft/?poID='+document.getElementById('idpo<%=no%>').value,'_Self')" class="label-stpo5"> DRAF </button>
                                                    <% else if  PurchOrder("poStatus") = "2" then  %>
                                                    <span class="label-stpo6"> COMPLETE </span>
                                                    <% else %>
                                                    <span class="label-stpo6"> COMPLETE </span>
                                                    <% end if %><% end if %>
                                                </td>
                                            <!-- Status Purchase Order -->

                                            <!-- Status Pembayaran -->
                                                <% if PurchOrder("po_payID") = "" then%>
                                                    <td class="text-center">-</td>
                                                    <td class="text-center">Belum Bayar</td>
                                                <% else %>
                                                <td class="text-center"><button class="cont-btn"> <%=PurchOrder("po_payID")%> </button></td>
                                                <td class="text-center"><button class="cont-btn"> <%=Cdate(PurchOrder("po_payTanggal"))%> </button></td>
                                                <% end if %>

                                                <% if PurchOrder("po_payYN") = "N" then%>
                                                    <!-- Jatuh Tempo -->
                                                    <% if PurchOrder("po_JatuhTempo") = "1900-01-01" then %>
                                                    <td class="text-center "style="color:red">Pending</td>
                                                    <td class="text-center "style="color:red">-</td>
                                                    <%else%>
                                                    <td class="text-center"><%=Day(CDate(PurchOrder("po_JatuhTempo")))%>/<%=Month(CDate(PurchOrder("po_JatuhTempo")))%>/<%=Year(CDate(PurchOrder("po_JatuhTempo")))%></td>
                                                    <% 
                                                        sekarang = date()
                                                        sisahari = CDate(PurchOrder("po_JatuhTempo")) - sekarang
                                                    %>
                                                    <td class="text-center"><span class="label-JatuhTempo"><%=sisahari%></span></td>
                                                    <%end if%>
                                                    <!-- Jatuh Tempo -->
                                                <% else %>
                                                    <td class="text-center "style="color:green"><i class="fas fa-signature"></i></td>
                                                    <td class="text-center "style="color:green"><i class="fas fa-check"></i></td>
                                                <% end if %>
                                            <!-- Status Pembayaran -->
                                            <td class="text-center">
                                                <div class="dropdown">
                                                    <button style="width:3rem;height:1.4rem; border-radius:5px"class="cont-btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="fas fa-list-ul"></i>
                                                    </button>
                                                    <ul class="dropdown-menu text-center cont-btn" aria-labelledby="dropdownMenuButton1">
                                                    <% if statuspo("po_spoID") = "0" then %>
                                                        <li>
                                                            <button onclick="window.open('get-detail-po.asp?poID='+document.getElementById('idpo<%=no%>').value,'_Self')" class="mt-2 cont-btn"style="width:8rem"> Rincian PO</button>
                                                        </li>
                                                        <li>
                                                            <button class="mt-2 cont-btn" onclick="window.open('../PurchaseOrder/Revisi-PO/load-revisi-po.asp?poID='+document.getElementById('idpo<%=no%>').value,'_Self')" style="width:8rem"> Revisi PO</button>
                                                        </li>
                                                        <li>
                                                            <button onclick="return modal<%=no%>()" class="mt-2 cont-btn" id="myBtn<%=no%>"style="width:8rem"> Pembatalan PO </button>
                                                        </li>
                                                    <% else %>
                                                        <li>
                                                            <button onclick="window.open('get-detail-po.asp?poID='+document.getElementById('idpo<%=no%>').value,'_Self')" class="mt-2 cont-btn"style="width:8rem"> Rincian PO</button>
                                                        </li>
                                                    <% end if %>
                                                    </ul>
                                                </div>
                                            </td>

                                        <% end if %>

                                        <script>
                                            function hapus<%=no%>() {
                                                var poID = document.getElementById("idpo<%=no%>").value;
                                                $.ajax({
                                                    type: "POST",
                                                    url: "../PurchOrder/delete-PurchOrder.asp",
                                                        data:{
                                                            poID
                                                        },
                                                    success: function (data) {
                                                        Swal.fire('Deleted !!', data.message, 'success').then(() => {
                                                        location.reload();
                                                        });
                                                    }
                                                });
                                            }
                                        </script>
                                        <!-- Modal -->
                                            <div id="myModal<%=no%>" class="modal">
                                            <!-- Modal content -->
                                                <div class="modall-content">
                                                    <div class="modal-body">
                                                        <div class="row mt-3">
                                                            <div class="col-11">
                                                                <span class="txt-modal-judul"> Konfirmasi Pembatalan Purchase Order </span>
                                                            </div>
                                                            <div class="col-1">
                                                                <span onclick="return close<%=no%>()"><i onclick="return close<%=no%>()" class="fas fa-times close<%=no%>"></i></span>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div class="body mt-3 mb-3" style="padding:2px 5px">
                                                            <div class="row align-items-center">
                                                                <div class="col-12">
                                                                    <span class="txt-modal-desc"> Tanggal Pembatalan : <input class="txt-modal-desc" type="text" name="" id="" Value="<%=CDate(now())%>" style="width:65%; border:none"></span>
                                                                    </div>
                                                            </div>
                                                            <div class=" row mt-3 mb-2 align-items-center">
                                                                <div class="col-12 text-center">
                                                                    <span class="txt-modal-desc"> DETAIL PURCHASE ORDER </span>
                                                                </div>
                                                            </div>
                                                            <div class=" row mt-3 mb-2 align-items-center">
                                                                <div class="col-4">
                                                                    <span class=" txt-modal-desc"> PO ID  </span><br>
                                                                </div>
                                                                <div class="col-8">
                                                                    <input class="txt-modal-desc inp-purchase-order" style="width:17rem" type="text" name="poid" id="poid<%=PurchOrder("poID")%>" value="<%=PurchOrder("poID")%>">
                                                                </div>
                                                            </div>
                                                            <div class=" row mt-1 align-items-center">
                                                                <div class="col-4">
                                                                    <span class=" txt-modal-desc"> TANGGAL PO  </span><br>
                                                                </div>
                                                                <div class="col-8">
                                                                    <input class="txt-modal-desc inp-purchase-order" style="width:17rem" type="text" name="potanggal" id="potanggal<%=PurchOrder("poID")%>" value="<%=PurchOrder("poTanggal")%>">
                                                                </div>
                                                            </div>
                                                            <div class=" row mt-1 align-items-center">
                                                                <div class="col-4">
                                                                    <span class=" txt-modal-desc"> JENIS ORDER PO  </span><br>
                                                                </div>
                                                                <div class="col-8">
                                                                    <input class="txt-modal-desc inp-purchase-order" style="width:17rem" type="text" name="pojenisorder" id="pojenisorder<%=PurchOrder("poID")%>" value="<%=PurchOrder("poJenisOrder")%>">
                                                                </div>
                                                            </div>
                                                            <div class=" row mt-1 align-items-center">
                                                                <div class="col-4">
                                                                    <span class=" txt-modal-desc"> SUPPLIER  </span><br>
                                                                </div>
                                                                <div class="col-8">
                                                                    <input class="txt-modal-desc inp-purchase-order" style="width:17rem" type="hidden" name="pospid" id="pospid<%=PurchOrder("poID")%>" value="<%=PurchOrder("custID")%>">
                                                                    <input class="txt-modal-desc inp-purchase-order" style="width:17rem" type="text" name="namasupplierid" id="namasupplierid" value="<%=PurchOrder("custNama")%>">
                                                                </div>
                                                            </div>
                                                            <div class=" row mt-1 align-items-center">
                                                                <div class="col-4">
                                                                    <span class=" txt-modal-desc"> KET.PEMBATALAN  </span><br>
                                                                </div>
                                                                <div class="col-8">
                                                                    <input class="txt-modal-desc inp-purchase-order" style="width:17rem" type="text" name="poalasan" id="poalasan<%=PurchOrder("poID")%>" value=""placeholder="Masukan Keterangan Pembatalan">
                                                                </div>
                                                            </div>
                                                            <div class=" row mt-4 align-items-center">
                                                                <div class="col-4">
                                                                    <button onclick="pembatalan<%=no%>()" class="cont-btn" style=""> SIMPAN </button>
                                                                </div>
                                                                <div class="col-3">
                                                                    <button class="cont-btn"> BATAL </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                            <!-- Modal content -->
                                            </div>
                                        <!-- Modal -->
                                        <script>
                                                function upbtn<%=no%>(){
                                                    document.getElementById("cont-konf<%=no%>").style.display = "block";
                                                }
                                                function pembatalan<%=no%>(){
                                                    var poid = document.getElementById("poid<%=PurchOrder("poID")%>").value;
                                                    var pospid = document.getElementById("pospid<%=PurchaseOrder("poID")%>").value;
                                                    var alasan = document.getElementById("poalasan<%=PurchaseOrder("poID")%>").value;
                                                    
                                                    $.ajax({
                                                        type: "GET",
                                                        url: "add-pembatalanpo.asp",
                                                        data: { 
                                                            poid,
                                                            pospid,
                                                            alasan
                                                        },
                                                        success: function (data) {
                                                            // console.log(data);
                                                            
                                                            document.getElementById("loader-page").style.display = "block";
                                                            setTimeout(() => {
                                                                document.getElementById("loader-page").style.display = "none";
                                                                Swal.fire({
                                                                    text: "BERHASIL DIBATALKAN"
                                                                }).then((result) => {
                                                                    location.reload();
                                                                })
                                                            }, 10000);
                                                        }
                                                    });
                                                }
                                                function modal<%=no%>(){
                                                    var modal<%=no%> = document.getElementById("myModal<%=no%>");
                                                    var btn<%=no%> = document.getElementById("myBtn<%=no%>");
                                                        document.getElementById("myModal<%=no%>").style.display = "block";
                                                    window.onclick = function(event) {
                                                        if (event.target == modal<%=no%>) {
                                                            modal<%=no%>.style.display = "none";
                                                        }
                                                    }
                                                }
                                                function close<%=no%>(){
                                                    document.getElementById("myModal<%=no%>").style.display = "none";
                                                }
                                                function konfirmasi<%=no%>(){
                                                    var poid = document.getElementById("idpo<%=no%>").value;
                                                    var jeniskonfirmasi = document.getElementById("jeniskonfirmasi<%=no%>").value;
                                                    $.ajax({
                                                        type: "post",
                                                        url: "get-konfirmasi.asp",
                                                        data : {
                                                            poid,
                                                            jeniskonfirmasi
                                                        },
                                                        success: function (data) {
                                                            // console.log(data);
                                                            document.getElementById("loader-page").style.display = "block";
                                                            setTimeout(() => {
                                                                document.getElementById("loader-page").style.display = "none";
                                                                    Swal.fire({
                                                                    title: 'Berhasil Dikonfirmasi',
                                                                    }).then((result) => {
                                                                    // Reload the Page
                                                                    location.reload();
                                                                    });
                                                            }, 1000);
                                                        }
                                                    });
                                                }
                                                function revisipo<%=no%>(){
                                                    var id = document.getElementById("idpo<%=no%>").value; console.log(id);
                                                    
                                                    $.ajax({
                                                        type: "get",
                                                        url: "add-revisipo.asp",
                                                        data: { 
                                                            id
                                                        },
                                                        success: function (data) {
                                                            window.location.replace('add-revisipo.asp');
                                                        }
                                                    });
                                                }
                                        </script>
                                    </tr>
                                    <%
                                        PurchOrder.MoveNext : Wend
                                        CurrntPage = PagNav - 1
                                        NextPage  = PagNav + 1
                                        If (CurrntPage <= 0) Then      : CurrntPage = 1        : End If
                                        If (NextPage > TotalPag) Then : NextPage  = TotalPag : End If
                                    %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

                <div class="row">
                    <div class="col-12">
                        <% If Request.QueryString("Pages") = "" Then %>
                        <span class="cont-text"> Page 1 Dari <%=TotalPag%> </span>
                        <% else %>
                        <span class="cont-text"> Page <%= Request.QueryString("Pages") %> Dari <%=TotalPag%> </span>
                        <% end if  %>
                    </div>
                </div>
                <div class="row mt-2 mb-4">
                    <div class="col-12">
                        <div class="d">
                            <a href="?Pages=1" class="fonte">&nbsp; &laquo; &nbsp;</a>
                            <% 
                                VisitePage = CInt(Request.QueryString("Pages"))

                                If PagNav > 1 Then
                                    Response.Write("<a href=""?Pages="&CurrntPage&""" ""style=""font: 12px Arial; color: black;"">&nbsp;PREVIOUS&nbsp;</a>")
                                End If

                                If PagNav > 5 Then
                                    Response.Write("&nbsp;...&nbsp;")
                                End If

                                If PagNav <= 5 Then
                                    If TotalPag >= 5 Then
                                    For Page = 1 To 5
                                        If PagNav = Page Then
                                            Response.Write("&nbsp;<a ""style=""background-color:#0077a2; color: red"" class=""fonte"">"&Page&"</strong>&nbsp;")
                                        Else
                                            Response.Write("<a href=""?Pages="&Page&""" class=""fonte"">&nbsp;"&Page&"&nbsp;</a>")
                                        End If
                                    Next
                                Else
                                    For Page = 1 To TotalPag
                                        If PagNav = Page Then
                                            Response.Write("&nbsp;<a class=""fonte"">"&Page&"</strong>&nbsp;")
                                        Else
                                            Response.Write("<a href=""?Pages="&Page&""" class=""fonte"">&nbsp;"&Page&"&nbsp;</a>")
                                        End If
                                    Next
                                    End If
                                End If

                                If PagNav > 5 Then
                                    PagNav = PagNav + 4
                                    Pg = PagNav
                                    MaxB = Request.QueryString("Pages") - 1

                                    If (MaxB + 1) = TotalPag Then
                                        For Page = MaxB To (Pg - 4)
                                            If VisitePage = Page Then
                                                Response.Write(" "& "&nbsp;<a class=""fonte"">"&Page&"</strong>&nbsp;")
                                            Else
                                                Response.Write(" "& "<a href=""?Pages="&Page&""" class=""fonte"">&nbsp;"&Page&"&nbsp;</a>")
                                            End If
                                        Next            
                                    ElseIf (MaxB + 2) = TotalPag Then
                                        For Page = MaxB To (Pg - 3)
                                            If VisitePage = Page Then
                                                Response.Write(" "& "&nbsp;<a class=""fonte"">"&Page&"</strong>&nbsp;")
                                            Else
                                                Response.Write(" "& "<a href=""?Pages="&Page&""" class=""fonte"">&nbsp;"&Page&"&nbsp;</a>")
                                            End If
                                        Next
                                    Else
                                        For Page = (MaxB - 1) To (Pg - 2)
                                            If VisitePage = Page Then
                                                Response.Write(" "& "&nbsp;<a class=""fonte"">"&Page&"</strong>&nbsp;")
                                            Else
                                                Response.Write(" "& "<a href=""?Pages="&Page&""" class=""fonte"">&nbsp;"&Page&"&nbsp;</a>")
                                            End If
                                        Next
                                    End If
                                End If

                                If (TotalPag <> VisitePage) And (TotalPag >= 5) Then
                                    Response.Write("&nbsp;...&nbsp;")
                                End If
                            %>
                            <a href="?Pages=<% Response.Write(NextPage) %>" class="fonte">&nbsp; NEXT &nbsp;</a>
                            <a href="?Pages=<% Response.Write(TotalPag) %>" class="fonte" style="font-size:12px">&raquo;&nbsp;</a>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script>
        function updatebtn(){
                document.getElementById("caripo").disabled = false
                document.getElementById("jenispo").disabled = false
                document.getElementById("namapd").disabled = false
            }

        

        var dropdown = document.getElementsByClassName("dropdown-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
        } else {
        dropdownContent.style.display = "block";
        }
        });
        }
        var dropdown = document.getElementsByClassName("cont-dp-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
        } else {
        dropdownContent.style.display = "block";
        }
        });
        }
        var modal = document.getElementById("myModal");
        var btn = document.getElementById("myBtn");
        var span = document.getElementsByClassName("closee")[0];
        btn.onclick = function() {
        modal.style.display = "block";
        }
        span.onclick = function() {
        modal.style.display = "none";
        }
        window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        }
        $('.dashboard-sidebar').click(function() {
            $(this).addClass('active');
        })
        $('.Dashboard').click(function() {
            $(this).addClass('active');
        })
        function CheckSession() {
                var session = '<%=Session("username") <> null%>';
                //session = '<%=Session("username")%>';
                alert(session);
                if (session == false) {
                    alert("Your Session has expired");
                    window.location = "login.aspx";
                }
                else {
                    alert(session);
                     }
            }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>