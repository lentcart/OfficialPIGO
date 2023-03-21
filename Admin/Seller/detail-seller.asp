<!--#include file="../../Connections/pigoConn.asp" -->
<%
    custID = Request.queryString("custID")
    set Seller_cmd = server.createObject("ADODB.COMMAND")
	Seller_cmd.activeConnection = MM_PIGO_String

        Seller_cmd.commandText = "SELECT MKT_M_Seller.slName, MKT_M_Seller.slVerified, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Alamat.almID, MKT_M_Alamat.almLabel, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota,  MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almDetail, MKT_M_Alamat.almJenis FROM MKT_M_Seller LEFT OUTER JOIN MKT_M_Customer ON MKT_M_Seller.sl_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_M_Alamat ON MKT_M_Seller.sl_almID = MKT_M_Alamat.almID Where sl_custID = '"& custID &"' AND almJenis = 'Alamat Toko' "
        'response.writeSeller_cmd.commandText

    set Seller = Seller_cmd.execute
    dim kategori_cmd, kategori
			
	set kategori_cmd = server.createObject("ADODB.COMMAND")
	kategori_cmd.activeConnection = MM_PIGO_String
			
	kategori_cmd.commandText = "SELECT [catID] ,[catName] ,[catAktifYN] FROM [PIGO].[dbo].[MKT_M_Kategori] where catAktifYN = 'Y'" 
	set kategori = kategori_cmd.execute
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
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboard.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <script>
        function tambah(){
            let pem= document.getElementsByClassName("tmb");

            document.getElementById("formsupplier").style.display = "block";
            document.getElementById("tsupplier").style.display = "none";
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
    </script>
    </head>

<body>
    <!--#include file="../loaderpage.asp"-->
<!-- side -->
    <!--#include file="../side.asp"-->
<!-- side -->

    <div class="main-body" style="overflow-y:scroll">
        <div class="row">
            <div class="col-12">
                <div class="data-po">
                    <div class="row align-items-center">
                        <div class="col-8">
                            <span class="txt-po-judul"> DETAIL SELLER  ( <%=Seller("slName")%> )</span>
                        </div>
                        <div class="col-4 text-end">
                            <button onclick="Refresh()" class=" btn-cetak-po" style="width:2rem"> <i class="fas fa-sync-alt"></i> </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="data-po mt-2">
            <div class="row">
                <div class="col-12">
                    <span class="txt-po-judul"> Produk Seller</span><br>
                    
            <div class='row bg-terlaris mx-0 p-2' id="cards">
                <div class='col-sm-12 col-lg-12' >
                    <table> 
                        <tr>
                            <td>
                                <a href="">
                                    <div class="card mt-3 mb-2 me-2">
                                        <img src="<%=base_url%>/assets/sparepart/1.png" class="card-img-top" alt="...">
                                        <input class="terlaris" type="" name="" id="" value="Promo 30%" style="border:none; "readonly>
                                        <div class="card-body">
                                        <span class="txt-purchase-order"> Seal Piston </span>
                                            <div class="row mt-2">
                                                <div class="col-6">
                                                    <img src="<%=base_url%>/assets/produk/icon-star.png" width="11px" class="terjual">
                                                    <span class="label-card"> 4.9 </span>
                                                </div>
                                                <div class="col-6">
                                                    <span class="label-card"> 5 Terjual </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>