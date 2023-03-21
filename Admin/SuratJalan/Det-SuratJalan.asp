<!--#include file="../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../admin/")
    
    end if

    pscID = request.queryString("pscID")
    
    set Pengeluaran_cmd = server.createObject("ADODB.COMMAND")
	Pengeluaran_cmd.activeConnection = MM_PIGO_String

        Pengeluaran_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_H.pscTanggal, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPaymentTerm, MKT_M_Customer.custNamaCP,  MKT_M_Alamat.almLengkap, MKT_M_Customer.custPhone1, MKT_M_Customer.custEmail, MKT_M_Customer.custNpwp FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_M_Customer.custID = MKT_T_PengeluaranSC_H.psc_custID Where almJenis <> 'Alamat Toko' AND pscID = '"& pscID &"' "
        'response.write Pengeluaran_cmd.commandText

    set Pengeluaran = Pengeluaran_cmd.execute

    set suratjalan_cmd = server.createObject("ADODB.COMMAND")
	suratjalan_cmd.activeConnection = MM_PIGO_String

        suratjalan_cmd.commandText = "SELECT MKT_T_SuratJalan_H.SJID, MKT_T_SuratJalan_H.SJ_Tanggal, MKT_T_SuratJalan_H.SJ_pscID,  MKT_M_Customer.custID, MKT_M_Customer.custNama FROM MKT_T_SuratJalan_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_SuratJalan_H.SJ_custID = MKT_M_Customer.custID  "
        'response.write suratjalan_cmd.commandText 

    set suratjalan = suratjalan_cmd.execute

    set DataSJ_cmd = server.createObject("ADODB.COMMAND")
	DataSJ_cmd.activeConnection = MM_PIGO_String

        DataSJ_cmd.commandText = "SELECT SJID, SJ_Tanggal FROM MKT_T_SuratJalan_H WHERE MKT_T_SuratJalan_H.SJ_custID = '"& request.Cookies("custID") &"' "
        'response.write  DataSJ_cmd.commandText

    set DataSJ = DataSJ_cmd.execute

%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!--#include file="../IconPIGO.asp"-->

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
        

        $('#keysearch').on("change",function(){
            let keysp = $('#keysearch').val();
            console.log("a");
        });

        function getdata(){
            $.ajax({
                type: "get",
                url: "getdata.asp?pscID="+document.getElementById("pscID").value,
                success: function (url) {
                // console.log(url);
                $('.datasp').html(url);
                                    
                }
            });
        }

        function cetaksuratjalan(){
            $.ajax({
                type: "get",
                url: "loaddata.asp?sjID="+document.getElementById("sjID").value,
                success: function (url) {
                    $('.datatr').html(url);
                    console.log(url);
                }
            });
        }
        function tambah(){
            let pem= document.getElementsByClassName("tambah");

            
            document.getElementById("tambahsuratjalan").style.display = "block";
            document.getElementById("bck").style.display = "block";
            document.getElementById("tambah").style.display = "none";
            document.getElementById("tb").style.display = "none";
        }
        function bck(){
            let pem= document.getElementsByClassName("bck");
            location.reload();
        }
        
    </script>
    </head>
    <!--#include file="../loaderpage.asp"-->
<body>
    <div class="wrapper">
        <!--#include file="../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-9 col-md-9 col-sm-12">
                        <span class="cont-text"> SURAT JALAN </span>
                    </div>
                </div>
            </div>
            <form class="" action="P-SuratJalan.asp" method="POST">
                <div class="cont-background mt-2">
                    <div class="row">
                        <div class="col-2">
                            <span class="cont-text"> Tanggal Surat Jalan </span><br>
                            <input required type="Date" class="cont-form" name="sTanggal" id="sTanggal" value=""><br>
                        </div>
                        <div class="col-4 ">
                            <span class="cont-text"> No PSCB </span> &nbsp; <span style="font-size:11px; color:#aaa">(<i>Pengeluaran Suku Cabang Baru</i>)</span><br>
                            <input readonly type="text" class=" text-center cont-form" name="s_pscID" id="s_pscID" value="<%=Pengeluaran("pscID")%>"><br>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-lg-2 col-md-3 col-sm-12">
                            <span class="cont-text">  Supplier ID </span><br>
                            <input readonly type="text" class=" supplierid cont-form" name="s_spID" id="s_spID" value="<%=Pengeluaran("custID")%>" ><br>
                        </div>
                        <div class="col-lg-4 col-md-3 col-sm-12">
                            <span class="cont-text"> Nama Supplier </span><br>
                            <input readonly type="text" class="cont-form" name="namasupplier" id="namasupplier" value="<%=Pengeluaran("custNama")%>" ><br>
                        </div>
                        <div class="col-lg-2 col-md-3 col-sm-6">
                            <span class="cont-text"> Pay-Term </span><br>
                            <input readonly type="text" class="text-center cont-form" name="poterm" id="poterm" value="<%=Pengeluaran("custPaymentTerm")%>" ><br>
                        </div>
                        <div class="col-lg-4 col-md-3 col-sm-6">
                            <span class="cont-text"> Nama CP Supplier </span><br>
                            <input readonly type="text" class="cont-form" name="namacp" id="namacp" value="<%=Pengeluaran("custNamaCP")%>"><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <span class="cont-text"> Lokasi Supplier </span><br>
                            <input readonly type="text" class="cont-form" name="lokasi" id="lokasi" value="<%=Pengeluaran("almLengkap")%>" ><br>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6">
                            <span class="cont-text"> Phone </span><br>
                            <input readonly type="text" class="text-center cont-form" name="phone" id="phone" value="<%=Pengeluaran("custPhone1")%>" ><br>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6">
                            <span class="cont-text"> Email </span><br>
                            <input readonly type="text" class="cont-form" name="email" id="email" value="<%=Pengeluaran("custEmail")%>" ><br>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6">
                            <span class="cont-text"> NPWP </span><br>
                            <input readonly type="text" class="cont-form" name="npwp" id="npwp" value="<%=Pengeluaran("custNpwp")%>" ><br>
                        </div>
                    </div>
                </div>
                <div class="row text-center mt-3">
                    <div class="col-12">
                        <div class="cont-label-text">
                            <span class="cont-text"> DAFTAR PRODUK </span>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <table class="table cont-tb tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                            <thead>
                            <tr>
                                <th class="text-center">  NO </th>
                                <th class="text-center">  DETAIL PRODUK </th>
                                <th class="text-center" colspan="2">  JUMLAH </th>
                                <th class="text-center" colspan="3">  DETAIL HARGA </th>
                                <th class="text-center">  TOTAL </th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                Pengeluaran_cmd.commandText = "SELECT MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_D.pscD_pdQty, MKT_T_PengeluaranSC_D.pscD_pdHargaJual, MKT_T_PengeluaranSC_D.pscD_pdUpTo, MKT_T_PengeluaranSC_D.pscD_pdTaxID,  MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdUnit, MKT_M_PIGO_Produk.pdPartNumber FROM MKT_M_Tax RIGHT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_M_Tax.TaxID = MKT_T_PengeluaranSC_D.pscD_pdTaxID LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PengeluaranSC_D.pscD_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON LEFT(MKT_T_PengeluaranSC_D.pscIDH,17) = MKT_T_PengeluaranSC_H.pscID WHERE pscID = '"& Pengeluaran("pscID") &"' "
                                'response.write Pengeluaran_cmd.commandText
                                set Produk = Pengeluaran_cmd.execute
                            %>
                            <%
                                no = 0 
                                do while not Produk.eof
                                no = no + 1
                            %>
                                <tr>
                                    <td class="text-center"> <%=no%> </td>
                                    <td>   <%=Produk("pdNama")%> [<%=Produk("pdPartNumber")%>]  </td>
                                    <td class="text-center"> <%=Produk("pdUnit")%></td>
                                    <td class="text-center"> <%=Produk("pscD_pdQty")%> </td>
                                    <td class="text-end"> <%=Replace(Replace(FormatCurrency(Produk("pscD_pdHargaJual")),"$","Rp. "),".00","")%> </td>
                                    <td class="text-center"> <%=Produk("pscD_pdTaxID")%> %</td>
                                    <td class="text-center"> <%=Produk("pscD_pdUpTo")%> %</td>
                                        <%

                                            Qty         = Produk("pscD_pdQty")
                                            Harga       = Produk("pscD_pdHargaJual")
                                            PPN         = Produk("pscD_pdTaxID")
                                            UPTO        = Produk("pscD_pdUpTo")

                                            Total       = Qty*Harga
                                            ReturnPPN   = Total+(Total*PPN/100)
                                            ReturnUPTO  = ReturnPPN*UPTO/100
                                            SubTotal    = ReturnPPN+ReturnUPTO
                                        
                                        %>
                                        <td class="text-end"> <%=Replace(Replace(FormatCurrency(SubTotal),"$","Rp. "),".00","")%> </td>
                                        <%
                                            GrandTotal = GrandTotal + SubTotal
                                        %>
                                </tr>
                            <%
                                Produk.movenext
                                loop
                            %>
                            </tbody>
                        </table>
                        <input type="hidden" value="<%=GrandTotal%>">
                    </div>
                </div>
                <div class="row text-center mt-2">
                    <div class="col-12">
                    <input class="cont-btn" type="submit" name="simpan" id="simpan" value="PROSES SURAT JALAN">
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!--#include file="../ModalHome.asp"-->
</body>
    <script>
        
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
        /* Dengan Rupiah */
        /* Fungsi */
        function formatRupiah(angka, prefix)
        {
            var number_string = angka.replace(/[^,\d]/g, '').toString(),
                split	= number_string.split(','),
                sisa 	= split[0].length % 3,
                rupiah 	= split[0].substr(0, sisa),
                ribuan 	= split[0].substr(sisa).match(/\d{3}/gi);
                
            if (ribuan) {
                separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');
            }
            
            rupiah = split[1] != undefined ? rupiah + ',' + split[1] : rupiah;
            return prefix == undefined ? rupiah : (rupiah ? 'Rp. ' + rupiah : '');
        }
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>