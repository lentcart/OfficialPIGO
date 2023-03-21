<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    set PaymentRequest_cmd = server.createObject("ADODB.COMMAND")
	PaymentRequest_cmd.activeConnection = MM_PIGO_String

        PaymentRequest_cmd.commandText = "SELECT MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv, MKT_T_PaymentRequest_D.pr_poID, MKT_T_PaymentRequest_D.pr_mmID, MKT_M_Customer.custNama,  MKT_T_PaymentRequest_H.pr_custID, MKT_M_StatusPayment.spayID, MKT_M_StatusPayment.spayName FROM MKT_T_PurchaseOrder_D RIGHT OUTER JOIN MKT_T_PurchaseOrder_H ON MKT_T_PurchaseOrder_D.poID_H = MKT_T_PurchaseOrder_H.poID RIGHT OUTER JOIN MKT_T_PaymentRequest_D LEFT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_PaymentRequest_D.pr_mmID = MKT_T_MaterialReceipt_H.mmID ON MKT_T_PurchaseOrder_H.poID = MKT_T_PaymentRequest_D.pr_poID RIGHT OUTER JOIN MKT_M_Customer RIGHT OUTER JOIN MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_M_StatusPayment ON MKT_T_PaymentRequest_H.pr_spayID = MKT_M_StatusPayment.spayID ON MKT_M_Customer.custID = MKT_T_PaymentRequest_H.pr_custID ON  MKT_T_PaymentRequest_D.prID_H = MKT_T_PaymentRequest_H.prID LEFT OUTER JOIN MKT_T_MaterialReceipt_D1 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D1.mmID_D1 LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_PaymentRequest_H.prAktifYN = 'Y' GROUP BY MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv, MKT_T_PaymentRequest_D.pr_poID, MKT_T_PaymentRequest_D.pr_mmID, MKT_M_Customer.custNama,MKT_M_StatusPayment.spayID,  MKT_T_PaymentRequest_H.pr_custID, MKT_M_StatusPayment.spayName "
        'response.write PaymentRequest_cmd.commandText 

    set PaymentRequest = PaymentRequest_cmd.execute

    set DataPR_cmd = server.createObject("ADODB.COMMAND")
	DataPR_cmd.activeConnection = MM_PIGO_String

        DataPR_cmd.commandText = "SELECT MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv FROM MKT_T_PaymentRequest_H LEFT OUTER JOIN MKT_T_PaymentRequest_D ON MKT_T_PaymentRequest_H.prID = MKT_T_PaymentRequest_D.prID_H WHERE MKT_T_PaymentRequest_H.pr_spayID = '1'  group by  MKT_T_PaymentRequest_H.prID, MKT_T_PaymentRequest_H.prFaktur, MKT_T_PaymentRequest_H.prTanggalInv "
        'response.write  DataPR_cmd.commandText

    set DataPR = DataPR_cmd.execute

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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script>
        function cetakpr(){
            $.ajax({
                type: "get",
                url: "get-datapr.asp?prID="+document.getElementById("prID").value,
                success: function (url) {
                    $('.datatr').html(url);
                    // console.log(url);
                }
            });
        }
        function caripr(){
            $.ajax({
                type: "get",
                url: "loaddatapr.asp?caripr="+document.getElementById("caripr").value,
                success: function (url) {
                    $('.datatr').html(url);
                    // console.log(url);
                }
            });
        }
        function tgla(){
            $.ajax({
                type: "get",
                url: "get-data.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                    $('.datatr').html(url);
                    // console.log(url);
                    
                }
            });
        }
    </script>
    </head>
<body>
<!-- side -->
    <!--#include file="../../side.asp"-->
<!-- side -->
    <div class="main-body" style="overflow-y:scroll">
        <div class="row">
            <div class="col-12">
                <div class="judul-PO">
                    <div class="row align-items-center">
                        <div class="col-9">
                            <span class="txt-po-judul"> Payment Request </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="purchase-order">
            <div class="row">
                <div class="col-12">
                    <div class="data-po">
                        <div class="row align-items-center">
                            <div class="col-8">
                                <span class="txt-purchase-order me-4"> Cari </span><span class="txt-purchase-order" style="font-size:10px; color:red"><i>( Silahkan Masukan No Payment Request) </i></span><br>
                                <input onkeyup="caripr()" class=" mb-2 inp-purchase-order" type="search" name="caripr" id="caripr" value="PIGO/INV/">
                            </div>
                            <div class="col-4">
                                <span class="txt-purchase-order"> Cetak Payment Request </span><br>
                                <select onchange="cetakpr()" name="prID" id="prID" style="width:15rem" class=" mb-2 inp-purchase-order"  aria-label="Default select example" >
                                <option selected>Pilih </option>
                                <% do while not DataPR.eof %>
                                <option value="<%=DataPR("prID")%>"><%=DataPR("prID")%>,<%=DataPR("prTanggalInv")%></option>
                                <% DataPR.movenext
                                loop%>
                            </select>
                            <button class="btn-cetak-po" style="width:4rem;height:1.6rem; border-radius:5px" onclick="window.open('buktipr.asp?prID='+document.getElementById('prID').value+'&tglinvoice='+document.getElementById('tglinvoice').value,'_Self')" > Cetak </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="purchase-order">
            <div class="row">
                <div class="col-12">
                    <span class="txt-purchase-order me-4"> Periode Payment Request </span><br>
                </div>
            </div>
            <div class="row">
                <div class="col-2">
                    <input onchange="tgla()" class=" mb-2 inp-purchase-order" type="date" name="tgla" id="tgla" value="" style="width:10rem">
                </div>
                <div class="col-2">
                    <input onchange="tgla()" class=" mb-2 inp-purchase-order" type="date" name="tgle" id="tgle" value="" style="width:10rem">
                </div>
                <div class="col-2">
                    <div class="dropdown">
                        <button style="width:11rem;height:1.6rem; border-radius:5px"class="btn-cetak-po dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                            Download Laporan 
                        </button>
                        <ul class="dropdown-menu text-center btn-cetak-po" aria-labelledby="dropdownMenuButton1">
                            <li>
                                <button class="btn-cetak-po" onclick="window.open('lapprpdf.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')">Laporan PDF</button>
                            </li>
                            <li>
                                <button class=" mt-2 btn-cetak-po" onclick="window.open('lappoexc.asp?tgla='+document.getElementById('tgla').value+'&tgle='+document.getElementById('tgle').value,'_Self')"> Laporan Excel </button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12">
                <div class="purchase-order">
                    <div class="row">
                        <div class="col-12">
                            <table class=" align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                                <thead>
                                    <tr>
                                        <th class="text-center">No </th>
                                        <th class="text-center">No Invoice</th>
                                        <th class="text-center">Tanggal</th>
                                        <th class="text-center">BussinesPartner</th>
                                        <th class="text-center"> Status Payment </th>
                                        <th class="text-center"> Aksi </th>
                                    </tr>
                                </thead>
                                <tbody class="datatr">
                                <% 
                                    no = 0
                                    do while not PaymentRequest.eof 
                                    no = no + 1 
                                %>
                                    <tr>
                                        <td class="text-center"> <%=no%> </td>
                                        <td class="text-center"> <%=PaymentRequest("prID")%><input type="hidden" name="tglinvoice" id="tglinvoice" value="<%=PaymentRequest("prTanggalInv")%>">
                                        <input type="hidden" name="prID" id="prID<%=no%>" value="<%=PaymentRequest("prID")%>"> </td>
                                        <td class="text-center"> <%=PaymentRequest("prTanggalInv")%> </td>
                                        <td> <%=PaymentRequest("custNama")%> </td>
                                        <% if PaymentRequest("spayID") = "1" then %>
                                        <td class="text-center"><span class="label-pr1"> <%=PaymentRequest("spayName")%> </span></td>
                                        <% else %>
                                        <td class="text-center"><span class="label-pr2"> <i class="fas fa-clipboard-check"></i> </span></td>
                                        <%end if%>
                                        <td class="text-center">
                                            <div class="dropdown">
                                                <button style="width:2.5rem;height:1.4rem; border-radius:5px"class="btn-cetak-po dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                                </button>
                                                <ul class="dropdown-menu text-center btn-cetak-po" aria-labelledby="dropdownMenuButton1">
                                                    <li>
                                                        <button class="btn-cetak-po"> Detail Payment </button>
                                                    </li>
                                                    <li>
                                                        <button class="mt-2  btn-cetak-po"onclick="window.open('../Payment/?prID='+document.getElementById('prID<%=no%>').value,'_Self')"> Add Payment </button>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                <% PaymentRequest.movenext
                                loop%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12">
                
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>