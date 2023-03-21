<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    set Pengeluaran_cmd = server.createObject("ADODB.COMMAND")
	Pengeluaran_cmd.activeConnection = MM_PIGO_String

        Pengeluaran_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_D1.pscD1_NoPermintaan, MKT_T_PengeluaranSC_D1.pscD1_TglPermintaan,  MKT_M_Supplier.spID, MKT_M_Supplier.spNama1 FROM MKT_M_Supplier RIGHT OUTER JOIN MKT_T_PengeluaranSC_D1 ON MKT_M_Supplier.spID = MKT_T_PengeluaranSC_D1.pscD1_spID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D1.pscID1_H = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D2 ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D2.pscD2_H WHERE MKT_T_PengeluaranSC_H.psc_custID = '"& request.Cookies("custID") &"' group by MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscType, MKT_T_PengeluaranSC_H.pscTanggal, MKT_T_PengeluaranSC_D1.pscD1_NoPermintaan, MKT_T_PengeluaranSC_D1.pscD1_TglPermintaan,  MKT_M_Supplier.spID, MKT_M_Supplier.spNama1"
        'response.write Pengeluaran_cmd.commandText 

    set Pengeluaran = Pengeluaran_cmd.execute

    set DataPSC_cmd = server.createObject("ADODB.COMMAND")
	DataPSC_cmd.activeConnection = MM_PIGO_String

        DataPSC_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal FROM MKT_T_PengeluaranSC_D1 RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D1.pscID1_H = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D2 ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D2.pscD2_H WHERE MKT_T_PengeluaranSC_H.psc_custID = '"& request.Cookies("custID") &"' GROUP BY MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal"
        'response.write  DataPSC_cmd.commandText

    set DataPSC = DataPSC_cmd.execute

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
        $(document).ready(function() {
            $('#example').DataTable( {
            });
        });
        function cetakpsc(){
            $.ajax({
                type: "get",
                url: "getdata.asp?pscID="+document.getElementById("pscID").value,
                success: function (url) {
                    $('.datatr').html(url);
                    console.log(url);
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
                        <div class="col-10">
                            <span class="txt-po-judul"> Pengeluaran Suku Cadang Baru </span>
                        </div>
                        <div class="col-2">
                            <button class=" btn-tambah-po txt-po-judul" onclick="window.open('../PSCB/','_Self')" style="font-size:12px">Tambah Baru </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row align-items-center mt-2">
            <div class="col-12">
                <div class="purchase-order align-items-center">
                    <div class="row">
                        <div class="col-1">
                            <span class="txt-purchase-order"> No PSCB  </span><br>
                        </div>
                        <div class="col-8 me-4">
                            <select  onchange="return cetakpsc()" name="pscID" id="pscID" style="width:25rem" class=" mb-2 inp-purchase-order" name="jenisorder" id="jenisorder" aria-label="Default select example" >
                                <option selected>Pilih No Invoice </option>
                                <% do while not DataPSC.eof %>
                                <option value="<%=DataPSC("pscID")%>"><%=DataPSC("pscID")%>,<%=DataPSC("pscTanggal")%></option>
                                <% DataPSC.movenext
                                loop%>
                            </select>
                            
                        </div>
                        <div class="col-2">
                            <button style="width:13rem" class="btn-cetak-po" onclick="window.open('../../Pembelian/Invoice/buktipsc.asp?pscID='+document.getElementById('pscID').value+'&pscTanggal='+document.getElementById('pscTanggal').value,'_Self')" > Cetak Bukti Pengeluaran </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12">
                <div class="purchase-order">
                    <div class="row">
                        <div class="col-12">
                            <table id="example" class="display txt-purchase-order" style="width:100%">
                                <thead>
                                    <tr>
                                        <th class="text-center"> No PSCB</th>
                                        <th class="text-center"> Tanggal PSCB</th>
                                        <th class="text-center"> Type PSCB</th>
                                        <th class="text-center"> No Permintaan</th>
                                        <th class="text-center"> Tanggal Permintaan </th>
                                        <th class="text-center">Supplier</th>
                                    </tr>
                                </thead>
                                <tbody class="datatr">
                                <% do while not Pengeluaran.eof %>
                                    <tr>
                                        <td class="text-center"> <%=Pengeluaran("pscID")%><input type="hidden" name="pscTanggal" id="pscTanggal" value="<%=Pengeluaran("pscTanggal")%>"> </td>
                                        <td class="text-center" class="text-center"> <%=Pengeluaran("pscTanggal")%> </td>
                                        <td class="text-center"> <%=Pengeluaran("pscType")%> </td>
                                        <td class="text-center"> <%=Pengeluaran("pscD1_noPermintaan")%> </td>
                                        <td class="text-center"> <%=Pengeluaran("pscD1_TglPermintaan")%> </td>
                                        <td class="text-center"> <%=Pengeluaran("spNama1")%> </td>
                                    </tr>
                                <% Pengeluaran.movenext
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