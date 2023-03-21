<!--#include file="../Connections/pigoConn.asp" -->
<%
        

        set trSeller_cmd = server.createObject("ADODB.COMMAND")
        trSeller_cmd.activeConnection = MM_PIGO_String

        trSeller_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_H.tr_custID, buyer.custNama, MKT_T_Transaksi_D1A.tr_pdQty AS trQty,  almseller.almNamaPenerima AS NamaPengirim, almseller.almKota AS sellerkota, MKT_T_StatusTransaksi.strName, MKT_M_Seller.slName, MKT_M_Seller.slAktifYN, MKT_T_StatusTransaksi.strID,  MKT_T_Transaksi_H.trJenisPembayaran AS Expr1 FROM MKT_M_Customer AS buyer RIGHT OUTER JOIN MKT_M_Alamat AS almbuyer RIGHT OUTER JOIN MKT_T_Transaksi_H ON almbuyer.almID = MKT_T_Transaksi_H.tr_almID ON buyer.custID = MKT_T_Transaksi_H.tr_custID LEFT OUTER JOIN MKT_T_Transaksi_D1A LEFT OUTER JOIN MKT_M_Alamat AS almseller RIGHT OUTER JOIN MKT_M_Produk ON almseller.almID = MKT_M_Produk.pd_almID ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID RIGHT OUTER JOIN MKT_M_Customer LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_M_Customer.custID = MKT_T_Transaksi_D1.tr_slID ON MKT_T_Transaksi_D1A.trD1A = LEFT(MKT_T_Transaksi_D1.trD1, 12) ON  MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) where MKT_M_Seller.slAktifYN = 'Y' and trTglTransaksi = '"& date &"'  "
        'response.write Transaksi_cmd.commandText
    set trSeller = trSeller_cmd.execute
    
    set trPigo_cmd = server.createObject("ADODB.COMMAND")
	trPigo_cmd.activeConnection = MM_PIGO_String

        trPigo_cmd.commandText = "SELECT MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_Transaksi_D1A.tr_pdQty, MKT_T_Transaksi_H.tr_custID, buyer.custNama, MKT_T_Transaksi_D1A.tr_pdQty AS trQty,  almseller.almNamaPenerima AS NamaPengirim, almseller.almKota AS sellerkota, MKT_T_StatusTransaksi.strName, MKT_M_Seller.slName, MKT_M_Seller.slAktifYN, MKT_T_Transaksi_H.trJenisPembayaran,  MKT_T_StatusTransaksi.strID FROM MKT_M_Customer AS buyer RIGHT OUTER JOIN MKT_M_Alamat AS almbuyer RIGHT OUTER JOIN MKT_T_Transaksi_H ON almbuyer.almID = MKT_T_Transaksi_H.tr_almID ON buyer.custID = MKT_T_Transaksi_H.tr_custID LEFT OUTER JOIN MKT_T_Transaksi_D1A LEFT OUTER JOIN MKT_M_Alamat AS almseller RIGHT OUTER JOIN MKT_M_Produk ON almseller.almID = MKT_M_Produk.pd_almID ON MKT_T_Transaksi_D1A.tr_pdID = MKT_M_Produk.pdID RIGHT OUTER JOIN MKT_M_Customer LEFT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_M_Customer.custID = MKT_T_Transaksi_D1.tr_slID ON MKT_T_Transaksi_D1A.trD1A = left(MKT_T_Transaksi_D1.trD1,12) ON  MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) where MKT_M_Seller.slAktifYN = 'P' and trTglTransaksi = '"& date &"'  "
        'response.write Transaksi_cmd.commandText
    set trPigo = trPigo_cmd.execute

    set Transaksi_cmd =  server.createObject("ADODB.COMMAND")
    Transaksi_cmd.activeConnection = MM_PIGO_String

    Transaksi_cmd.commandText = "SELECT COUNT(MKT_T_Transaksi_D1A.tr_pdID) AS Total FROM MKT_T_Transaksi_H LEFT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_H.trID = left(MKT_T_Transaksi_D1.trD1,12) LEFT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D1A.trD1A where MKT_T_Transaksi_D1.tr_strID = '03' "
    set Transaksi = Transaksi_CMD.execute

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="dashboard.css">
    <link rel="stylesheet" type="text/css" href="../fontawesome/css/all.min.css">
    <script src="../js/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    
    <script>
        // var formatter = new Intl.NumberFormat('en-US', {
        //     style: 'currency',
        //     currency: 'USD',
        //     });

            
            
            const formatter = new Intl.NumberFormat('en-US', {
                style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0
            })

                console.log(formatter.format(2500));
            // formatter.format(1000) // "$1,000.00"
            // formatter.format(10) // "$10.00"
            // formatter.format(123233000) // "$123,233,000.00"
    </script>
    </head>
 
    <style>
    
    </style>
<body>

    <!-- side -->
    <!--#include file="side.asp"-->
<!-- side -->

    <div class="main-body" style="overflow-y:scroll">
        <div class="row">
            <div class="col-10">
                <span class="font-weight-bolder" style="color:black"> Dashboard </span>
            </div>
            <div class="col-2">
                <div class="dropdown">
                    <button class=" text-dp dropdown-btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        Official PIGO
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="text-dp dropdown-item" href="Data/Akun/">Akun PIGO </a></li>
                        <li><a class="text-dp dropdown-item" href="#">Users</a></li>
                        <li><a class="text-dp dropdown-item" href="../Dashboard/LogoutUser.asp">Log Out</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-sm-2">
                <a href="">
                    <div class="card mb-2 me-2" style="width:10rem; overflow:hidden;background-color:white; border-radius:10px">
                    <span class="stikers"> % </span>
                        <div class="f">
                            <span class="text-center text-dp"> Pesanan Baru </span>
                        </div>
                        <div class="foot" style="border-top:1px solid grey  ">
                            <span class=" text-dp"> 0%</span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-sm-2">
                <a href="">
                    <div class="card mb-2 me-2" style="width:10rem; overflow:hidden;background-color:white; border-radius:10px">
                    <span class="stikers"> % </span>
                        <div class="f">
                            <span class="text-center text-dp"> Pesanan Diproses </span>
                        </div>
                        <div class="foot" style="border-top:1px solid grey  ">
                            <span class=" text-dp"> 0%</span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-sm-2">
                <a href="">
                    <div class="card mb-2 me-2" style="width:10rem; overflow:hidden;background-color:white; border-radius:10px">
                    <span class="stikers"> % </span>
                        <div class="f">
                            <span class="text-center text-dp"> Pesanan Dikirim </span>
                        </div>
                        <div class="foot" style="border-top:1px solid grey  ">
                            <span class=" text-dp"> 0%</span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-sm-2">
                <a href="">
                    <div class="card mb-2 me-2" style="width:10rem; overflow:hidden;background-color:white; border-radius:10px">
                    <span class="stikers"> % </span>
                        <div class="f">
                            <span class="text-center text-dp"> Pesanan Selesai </span>
                        </div>
                        <div class="foot" style="border-top:1px solid grey  ">
                            <span class="text-center     text-dp"><%=Transaksi("total")%></span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-sm-2">
                <a href="">
                    <div class="card mb-2 me-2" style="width:10rem; overflow:hidden;background-color:white; border-radius:10px">
                    <span class="stikers"> % </span>
                        <div class="f">
                            <span class="text-center text-dp"> Pesanan Dibatalkan </span>
                        </div>
                        <div class="foot" style="border-top:1px solid grey  ">
                            <span class=" text-dp"> 0%</span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-sm-2">
                <a href="">
                    <div class="card mb-2 me-2" style="width:10rem; overflow:hidden;background-color:white; border-radius:10px">
                    <span class="stikers"> % </span>
                        <div class="f">
                            <span class="text-center text-dp"> Pengembalian  </span>
                        </div>
                        <div class="foot" style="border-top:1px solid grey  ">
                            <span class=" text-dp"> 0%</span>
                        </div>
                    </div>
                </a>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-6">
                <a href="">
                    <div class="card mb-2 me-2" style="width:100%; overflow:hidden;background-color:white; border-radius:10px">
                            <span class=" text-dp"> Penjualan Official PIGO </span>
                        <div class="card-body">
                            <canvas id="myChart" style="width:100%; max-width:600px; color:black"></canvas>
                        </div>
                        <div class="card-footer">
                            <span class=" text-dp"> 0%</span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-6">
                <a href="">
                    <div class="card mb-2 me-2" style="width:100%; overflow:hidden;background-color:white; border-radius:10px">
                            <span class=" text-dp"> Penjualan Seller </span>
                        <div class="card-body">
                            <canvas id="myChartt" style="width:100%; max-width:600px; color:black"></canvas>
                        </div>
                        <div class="card-footer">
                            <span class=" text-dp"> 0%</span>
                        </div>
                    </div>
                </a>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12">
                <a href="">
                    <div class="card mb-2 me-2" style="width:100%;overflow:hidden;background-color:white; border-radius:10px">
                            <span class=" text-dp"> Transaksi Seller </span>
                        <div class="card-body"  style="overflow-y:scroll; height:10rem">
                            <table class="table  table-bordered table-condensed" style="font-size:11px">
                                <thead class="text-center">
                                <tr> 
                                    <th> Tanggal Transaksi </th>
                                    <th> Status </th>
                                    <th> Nama Seller </th>
                                    <th> QTY </th>
                                    <th> Customer </th>
                                    <th> Alamat Kirim </th>
                                    <th> Alamat Tujuan </th>
                                </tr>
                                </thead>
                                <tbody>
                                <%do while not trSeller.EOF%>
                                <tr> 
                                    <td><%=trSeller("trTglTransaksi")%></td>
                                    <td><%=trSeller("strName")%></td>
                                    <td><%=trSeller("slName")%></td>
                                    <td><%=trSeller("trQty")%></td>
                                    <td><%=trSeller("custNama")%></td>
                                    <td><%=trSeller("Sellerkota")%></td>
                                    <td><%=trSeller("trTglTransaksi")%></td>
                                </tr>
                                <%trSeller.movenext
                                loop%>
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer">
                            <span class=" text-dp"> Total Transaksi () </span>
                        </div>
                    </div>
                </a>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12">
                <a href="">
                    <div class="card mb-2 me-2" style="width:100%;overflow:hidden;background-color:white; border-radius:10px">
                            <span class=" text-dp"> Transaksi Official PIGO </span>
                        <div class="card-body"  style="overflow-y:scroll; height:10rem">
                            <table class="table  table-bordered table-condensed" style="font-size:11px">
                                <thead class="text-center">
                                <tr> 
                                    <th> Tanggal Transaksi </th>
                                    <th> Status </th>
                                    <th> QTY </th>
                                    <th> Customer </th>
                                    <th> Alamat Kirim </th>
                                    <th> Alamat Tujuan </th>
                                </tr>
                                </thead>
                                <tbody>
                                <%if trPigo.eof = true then %>
                                    <tr> 
                                        <td colspan="7" class="text-center">TIDAK ADA TRANSAKSI</td>
                                    </tr>
                                <%else%>
                                <%do while not trPigo.EOF%>
                                <tr> 
                                    <td><%=trPigo("trTglTransaksi")%></td>
                                    <td><%=trPigo("strName")%></td>
                                    <td><%=trPigo("trQty")%></td>
                                    <td><%=trPigo("custNama")%></td>
                                    <td><%=trPigo("Sellerkota")%></td>
                                    <td><%=trPigo("trTglTransaksi")%></td>
                                </tr>
                                <%trPigo.movenext
                                loop%>
                                <%end if%>
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer">
                            <span class=" text-dp"> Total Transaksi () </span>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</body>

    <script>
        var xValues = ["JAN","FEB","MAR","APR","MEI","JUN","JUL","AGS","SEP","OKT","NOV","DES"];
            var yValues = [7,66,8,9,0,80,8,11,50,14,50,18];

            new Chart("myChart", {
            type: "line",
            data: {
                labels: xValues,
                datasets: [{
                fill: false,
                lineTension: 0,
                backgroundColor: "rgba(0,7,255,1.0)",
                borderColor: "rgba(0,0,255,0.1)",
                data: yValues
                }]
            },
            options: {
                legend: {display: false},
                scales: {
                yAxes: [{ticks: {min: 0, max:80}}],
                }
            }
            });
        var xValues = ["JAN","FEB","MAR","APR","MEI","JUN","JUL","AGS","SEP","OKT","NOV","DES"];
            var yValues = [7,66,8,9,0,80,8,11,50,14,50,18];

            new Chart("myChartt", {
            type: "line",
            data: {
                labels: xValues,
                datasets: [{
                fill: false,
                lineTension: 0,
                backgroundColor: "rgba(0,7,255,1.0)",
                borderColor: "rgba(0,0,255,0.1)",
                data: yValues
                }]
            },
            options: {
                legend: {display: false},
                scales: {
                yAxes: [{ticks: {min: 0, max:80}}],
                }
            }
            });

            var a1 = 0.7;
		var b1 = Math.round(a1);
		console.log(b1); // Hasil 1
		
		var a2 = 1.2;
		var b2 = Math.round(a2);
		console.log(b2); // Hasil 1
		
		var a3 = 3.9;
		var b3 = Math.round(a3);
		console.log(b3); // Hasil 4
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
    <script>
    </script>
</html>