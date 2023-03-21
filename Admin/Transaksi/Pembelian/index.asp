<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT * FROM MKT_M_Produk WHERE pd_custID = '"& request.Cookies("custID") &"' "
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set Pembelian_cmd = server.createObject("ADODB.COMMAND")
	Pembelian_cmd.activeConnection = MM_PIGO_String

        Pembelian_cmd.commandText = "SELECT MKT_T_Pembelian_D1.pmD1, MKT_T_Pembelian_D1.pm_pdID, MKT_T_Pembelian_D1.pm_pdNama, MKT_T_Pembelian_D1.pm_pdQty, MKT_T_Pembelian_D1.pm_pdUnit, MKT_T_Pembelian_D1.pm_pdHarga, MKT_T_Pembelian_D1.pm_pdMerk, MKT_T_Pembelian_D1.pm_pdKategori, MKT_T_Pembelian_D1.pm_pdType, MKT_T_Pembelian_D1.pm_pdKondisi, MKT_T_Pembelian_D1.pmD1AktifYN, MKT_T_Pembelian_H.pmID, MKT_T_Pembelian_H.pmTglPembelian, MKT_T_Pembelian_H.pm_custID, MKT_T_Pembelian_H.pmUpdateTime, MKT_T_Pembelian_D.pmD, MKT_T_Pembelian_D.pmNamaSupplier, MKT_T_Pembelian_D.pmEmail, MKT_T_Pembelian_D.pmNamaCP, MKT_T_Pembelian_D.pmPhone1, MKT_T_Pembelian_D.pmPhone2, MKT_T_Pembelian_D.pmPhone3, MKT_T_Pembelian_D.pmAlamatSupplier, MKT_T_Pembelian_D.pmProvinsi, MKT_T_Pembelian_D.pmDeskripsi FROM MKT_T_Pembelian_D1 RIGHT OUTER JOIN  MKT_T_Pembelian_D ON left(MKT_T_Pembelian_D1.pmD1,10) = left(MKT_T_Pembelian_D.pmD,10) RIGHT OUTER JOIN  MKT_T_Pembelian_H ON left(MKT_T_Pembelian_D.pmD,10) = MKT_T_Pembelian_H.pmID  WHERE MKT_T_Pembelian_H.pm_custID = '"& request.Cookies("custID") &"'  order by MKT_T_Pembelian_H.pmTglPembelian"
        'response.write Pembelian_cmd.commandText

    set Pembelian = Pembelian_cmd.execute

   

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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Dashboard/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.min.js"></script>
    <script src="<%=base_url%>/DataTables/datatables.js"></script>
    <script>
        function tambah(){
            let pem= document.getElementsByClassName("tmb");

            document.getElementById("formpembelian").style.display = "block";
            document.getElementById("tpembelian").style.display = "none";
            }
        var array = [];

        function cust(){
            let pem= document.getElementsByClassName("custID");

            document.getElementById("cust").style.display = "block";
        }

        var id = [];
        // console.log(id);
    
        function loaddata(){
            var no = document.getElementById('no').value;
            var custID = id;
            var pdidall = "";
            for ( i=1; i<=no; i++){
                id.push($(`#custID${i}`).val());
            }
            if ( pdidall.length<1 ){
                pdidall = pdidall+id;
            }else{
                    pdidall  = pdidall+","+id; 
                }
            document.getElementById("custall").value = pdidall;
            return id;

            
        }
        $('#periode').on("change",function(){
            let pr = $('#periode').val();
            console.log(pr);
            if (ongkir == "tahun" ){
                $("#cont-tahun").show();
            
            }else{
                $("#cont-tanggal").show();

            }
        });
        
        function tgla(){
            $.ajax({
                type: "get",
                url: "get-data.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                   $('.datatr').html(url);
                    
                }
            });
        }
        function tgle(){
            $.ajax({
                type: "get",
                url: "get-data.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value,
                success: function (url) {
                    
                    
                   $('.datatr').html(url);
                    
                }
            });
        }
        $(document).ready(function() {
            $('#example').DataTable();
            $('#example1').DataTable();
        } );
    </script>
    </head>

<!-- side -->
    <!--#include file="../../side.asp"-->
<!-- side -->

    <div class="main-body" style="overflow-y:scroll">
        <div class="row">
            <div class="col-12">
                <button class="btn-sp" type="button" name="tmb" id="tmb" onclick="return tambah()" style="width:10rem">Tambah Pembelian </button>
            </div>
        </div>
        <div class="row" style="display:none; margin-top:1rem" id="formpembelian">
            <div class="col-12">
                <div class="card-body">
                    <table class="table  table-bordered table-condensed" style="font-size:11px" id="example">
                        <thead class="text-center">
                        <tr> 
                            <th> Kode Produk </th>
                            <th> Nama Produk </th>
                            <th> Aksi </th>
                        </tr>
                        </thead>
                        <tbody>
                        <%do while not Produk.EOF%>
                        <tr> 
                            <td><%=Produk("pdID")%></td>
                            <td><%=Produk("pdnama")%></td>
                            <td class="text-center"><input type="button" value="Pembelian" onClick="window.open('pembelian.asp?pdID=<%=Produk("pdID")%>','_self')"></td>
                        </tr>
                        <%Produk.movenext
                        loop%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="row mt-3" id="tpembelian">
            <div class="col-12">
                <div class="card-body"style="overflow-y:scroll; height:31rem">
                    <table class="table  table-bordered table-condensed" style="font-size:11px" id="example1">
                        <thead class="text-center">
                        <tr> 
                            <th> Tanggal </th>
                            <th> Kode Produk </th>
                            <th> Nama Produk </th>
                            <th> Jumlah  </th>
                            <th> Harga </th>
                            <th>  Supplier </th>
                        </tr>
                        </thead>
                        <tbody>
                        <%do while not Pembelian.EOF%>
                        <tr> 
                            <td><%=Pembelian("pmTglPembelian")%></td>
                            <td><%=Pembelian("pm_pdID")%></td>
                            <td><%=Pembelian("pm_pdNama")%></td>
                            <td><%=Pembelian("pm_pdQty")%></td>
                            <td><%=Pembelian("pm_pdHarga")%></td>
                            <td><%=Pembelian("pmNamaSupplier")%></td>
                        </tr>
                        <%Pembelian.movenext
                        loop%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>


    <script>

            $('#provinsi').click(function(){     
            $.getJSON(`https://dev.farizdotid.com/api/daerahindonesia/provinsi`,function(data){ 
                for(let i = 0; i < data.provinsi.length; i++){
                    $('#provinsi').append(new Option(`${data.provinsi[i].nama}`, `${data.provinsi[i].nama}`));
                    
                }

            });
        });
    </script>
   
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>