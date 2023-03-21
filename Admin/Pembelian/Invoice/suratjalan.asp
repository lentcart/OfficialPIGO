<!--#include file="../../../Connections/pigoConn.asp" -->
<%

    sjID = request.queryString("sjID")
    tglSuratJalan = request.queryString("tglSuratJalan")
    


    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= '"& request.Cookies("custID") &"'  "
	set Merchant = Merchant_cmd.execute

    set SuratJalan_cmd = server.createObject("ADODB.COMMAND")
	SuratJalan_cmd.activeConnection = MM_PIGO_String
			
	' SuratJalan_cmd.commandText = "SELECT MKT_T_SuratJalan.sjID, MKT_T_SuratJalan.sTanggal, MKT_T_SuratJalan.s_pscID, MKT_T_SuratJalan.s_spID, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_M_Customer.custPhone1,  MKT_M_Customer.custPhone2, MKT_M_Customer.custNamaCP, MKT_T_PengeluaranSC_H.pscID, MKT_T_PengeluaranSC_D.pscD1_NoPermintaan, MKT_T_PengeluaranSC_D.pscD1_TglPermintaan FROM MKT_T_PengeluaranSC_D RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D.pscIDH = MKT_T_PengeluaranSC_H.pscID RIGHT OUTER JOIN MKT_T_SuratJalan ON MKT_T_PengeluaranSC_H.pscID = MKT_T_SuratJalan.s_pscID LEFT OUTER JOIN MKT_M_Customer ON MKT_T_SuratJalan.s_spID = MKT_M_Customer.custID WHERE (MKT_T_SuratJalan.sjID ='"& sjID &"') AND (MKT_T_SuratJalan.sTanggal  ='"& tglSuratJalan &"') "
    ' 'response.write SuratJalan_cmd.commandText
	' set SuratJalan = SuratJalan_cmd.execute

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

%>

<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PIGO</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="invoice.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    
    <script>
    </script>
    </head>
<body>
    <div class="container invoice">
        <div class="invoice-header">
        <% do while not Merchant.eof%>
            <div class="row align-items-center">
                <div class="col-1">
                    <img src="data:image/png;base64,<%=Merchant("custPhoto")%>" class="logo me-3" alt="" width="65" height="65" />
                </div>
                <div class="col-6">
                    <span class="Judul-Merchant"> <%=Merchant("custNama")%> </span><br>
                    <span class="Txt-Merchant"> <%=Merchant("custPhone1")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone2")%> </span> | <span class="Txt-Merchant"> <%=Merchant("custPhone3")%> </span><br>
                    <span class="Txt-Merchant"> <%=Merchant("almLengkap")%> </span><br>
                </div>
                <div class="col-5 text-center">
                    <span class="Judul-Merchant" style="font-size:35px; border:5px solid black; padding:2px 10px"> SURAT JALAN </span><br>
                </div>
            </div>
            <% Merchant.movenext
            loop%>
            <hr>
            <div class="invoice-body" style="background-color:#eeeeee; padding: 10px 20px; border-radius:20px;">
            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <div class="col-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> Tanggal </span><br>
                                    <span class="txt-desc"> Penerima </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-7 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <!--<span class="txt-desc"><%=CDate(SuratJalan("sTanggal"))%></span><br>
                                    <span class="txt-desc"><%=SuratJalan("spNama1")%></span><br>
                                    <span class="txt-desc"><%=SuratJalan("spAlamat")%></span><br>
                                    <span class="txt-desc"><%=SuratJalan("spNamaCP")%>/<%=SuratJalan("spPhone1")%></span><br>-->
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> No Surat Jalan  </span><br>
                                    <span class="txt-desc"> No Ref. </span><br>
                                    <span class="txt-desc"> Tanggal </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                    <span class="txt-desc"> : </span><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-5 p-0">
                            <div class="panel panel-default">
                                <!--<div class="panel-body">
                                    <span class="txt-desc"><%=SuratJalan("sjID")%></span><br>
                                    <span class="txt-desc"><%=SuratJalan("pscD1_NoPermintaan")%></span><br>
                                    <span class="txt-desc"><%=CDate(SuratJalan("pscD1_TglPermintaan"))%></span><br>
                                </div>-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-12">
                    <div class="panel panel-default">
                        <table class="table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px">
                        <thead>
                            <tr>
                                <th class="text-center"> No </th>
                                <th class="text-center"> Nama Produk </th>
                                <th class="text-center"> Unit </th>
                                <th class="text-center"> Jumlah </th>
                            </tr>
                            
                        </thead>
                        <tbody>
                        <% 
                            produk_cmd.commandText = "SELECT ROW_NUMBER() OVER(ORDER BY pdNama) AS no,MKT_T_PengeluaranSC_D2.pscD2_pdID, MKT_T_PengeluaranSC_D2.pscD2_pdQty, MKT_T_PengeluaranSC_D2.pscD2_pdUnit, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdPartNumber,  MKT_T_SuratJalan.sDesc FROM MKT_T_PengeluaranSC_D2 LEFT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_PengeluaranSC_D2.pscD2_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_PengeluaranSC_H ON MKT_T_PengeluaranSC_D2.pscD2_H = MKT_T_PengeluaranSC_H.pscID LEFT OUTER JOIN MKT_T_PengeluaranSC_D ON MKT_T_PengeluaranSC_H.pscID = MKT_T_PengeluaranSC_D.pscIDH RIGHT OUTER JOIN MKT_T_SuratJalan ON MKT_T_PengeluaranSC_H.pscID = MKT_T_SuratJalan.s_pscID WHERE MKT_T_SuratJalan.sjID = '"& SuratJalan("sjID") &"' AND MKT_T_SuratJalan.s_pscID = '"& SuratJalan("pscID") &"'  "
                            'response.write produk_cmd.commandText
	                        set produk = produk_cmd.execute
                        %>
                        <% do while not produk.eof%>
                            <tr>
                                <td class="text-center"> <%=produk("no")%> </td>
                                <td> [ <%=produk("pdPartNumber")%> ] -  <%=produk("pdNama")%>  </td>
                                <td class="text-center"> <%=produk("pscD2_pdUnit")%> </td>
                                <td class="text-center"> <%=produk("pscD2_pdQty")%> </td>
                            </tr>
                            <%
                                totalqty = totalqty + produk("pscD2_pdQty")
                            %>
                            <% produk.movenext
                            loop%>
                           
                            <tr>
                                <th colspan="3" class="text-right"> Total QTY </th>
                                <td class="text-center"> <%=totalqty%> </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
              
            <div class="row text-center" style="margin-top:2rem">
                <div class="col-4">
                    <span class="txt-desc"> </span><br>
                    <span class="txt-desc"> Dibuat Oleh,</span><br><br><br>
                    <span class="txt-desc">...........................</span><br>
                </div>
                <div class="col-4">
                    <span class="txt-desc"> </span><br>
                    <span class="txt-desc"> Gudang,</span><br><br><br>
                    <span class="txt-desc">...........................</span><br>
                </div>
                <div class="col-4">
                    <span class="txt-desc"> Tanggal,..........................</span><br>
                    <span class="txt-desc"> Diterima Oleh,</span><br><br><br>
                    <span class="txt-desc">...........................</span><br>
                </div>
            </div>          
        </div>
    </div>
</body>

    <script>

        
    </script>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>