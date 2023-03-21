<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
        response.redirect("../../../admin/")
    end if
    if session("H3B") = false then 
        Response.redirect "../../../Admin/home.asp"
    end if
    
    set Produk_cmd = server.createObject("ADODB.COMMAND")
	Produk_cmd.activeConnection = MM_PIGO_String

        Produk_cmd.commandText = "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdHarga as HargaAwal, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal,  MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo,MKT_M_PIGO_Produk.pdUpdateTime FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') GROUP BY MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty,  MKT_M_Stok.st_pdHarga, MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo,MKT_M_PIGO_Produk.pdHarga, MKT_M_PIGO_Produk.pdUpdateTime ORDER BY pdUpdateTime ASC"
        'response.write Produk_cmd.commandText

    set Produk = Produk_cmd.execute

    set kategori_cmd = server.createObject("ADODB.COMMAND")
    kategori_cmd.activeConnection = MM_PIGO_String

        kategori_cmd.commandText = "SELECT * FROM MKT_M_Kategori WHERE catAktifYN = 'Y' "
    
    set kategori = kategori_cmd.execute

    set Merk_cmd = server.createObject("ADODB.COMMAND")
    Merk_cmd.activeConnection = MM_PIGO_String

        Merk_cmd.commandText = "SELECT * FROM MKT_M_Merk WHERE mrAktifYN = 'Y' "
    
    set Merk = Merk_cmd.execute

    set Pembelian_cmd = server.createObject("ADODB.COMMAND")
	Pembelian_cmd.activeConnection = MM_PIGO_String

    set Penjualan_cmd = server.createObject("ADODB.COMMAND")
	Penjualan_cmd.activeConnection = MM_PIGO_String

    
    Dim Pages
    Set Pages = Server.CreateObject("Adodb.Connection")
    Pages.ConnectionString = MM_PIGO_String
    Pages.Open

    Dim Produk, PagNav, TotalPag
    Dim CurrntPage, NextPage, Page, VisitePage
    Set Produk = Server.CreateObject("Adodb.RecordSet")

%>
<!doctype html>
<html lang="en"><!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/Admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
    <script>
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
<body>
<!--#include file="../../loaderpage.asp"-->
    <div class="wrapper">
        <!--#include file="../../sidebar.asp"-->
        <div id="content">
            <div class="cont-background mt-2" style="margin-top:2rem">
                <button class="content-dropdown" id="myBtn" style="width:3rem"> <i class="fas fa-bars"></i> </button>
                <div class="row">
                    <div class="col-lg-8 col-md-4 col-sm-8">
                        <span class="cont-judul"> Produk Kepemilikan Official PIGO </span>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-2">
                        <button onclick="window.open('../ProdukBaru/','_Self')" name="tambah" id="tambah" class="cont-btn" > <i class="fas fa-add"></i> Tambah Produk </button>
                        </div>
                    <div class="col-lg-2 col-md-4 col-sm-2">
                        <button onclick="window.open('eco.asp','_Self')" name="tambah" id="tambah" class="cont-btn" style="width:7rem" > <i class="fas fa-info-circle"></i> Official PIGO</button>
                        <button onclick="Refresh()" class="cont-btn" style="width:1.8rem"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2">
                <div class="row align-items-center">
                    <div class="col-lg-4 col-md-4 col-sm-12">
                        <span class="cont-text"> Cari Produk <span><br>
                        <input type="search" onkeyup="getproduk()"class="cont-form" name="search" id="search" value=""placeholder="Cari Berdasarkan Nama Atau SKU/Part Number Produk">
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-12">
                        <span class="cont-text"> Kategori <span><br>
                        <select required onchange="kategori()" class="cont-form" name="kategori" id="kategori" aria-label="Default select example">
                            <option value="">Pilih</option>
                            <%do while not kategori.eof%>
                            <option value="<%=kategori("catID")%>"><%=kategori("catName")%></option>
                            <% kategori.movenext
                            loop%>
                        </select>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-12">
                        <span class="cont-text"> Merk </span><br>
                        <select disabled="true" onchange="getproduk()" class="cont-form" name="merk" id="merk" aria-label="Default select example">
                            <option value="">Pilih</option>
                            <% do while not merk.eof %>
                            <option value="<%=merk("mrID")%>"><%=merk("mrNama")%></option>
                            <% merk.movenext
                            loop%>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-12">
                        <br>
                        <button onclick="window.open('list-produk.asp?mrID='+document.getElementById('merk').value)" class="cont-btn"> Generate List Harga </button>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <span class="cont-text"> UpTo Produk = 5% </span> &nbsp;  <span class="cont-text"> PPn/Tax = 11% </span>
                    </div>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="cont-produk">
                        <div class="row d-flex flex-row-reverse">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <table class="align-items-center table tb-transaksi table-bordered" style="font-size:12px; border:1px solid black;width:100rem">
                                    <%
                                        Pages.CursorLocation = 3
                                        Produk.PageSize = 8
                                        Produk.Open "SELECT MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama,MKT_M_PIGO_Produk.pdHarga as HargaAwal, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty AS StokAwal,  MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo,pdUpdateTime FROM MKT_M_PIGO_Produk LEFT OUTER JOIN MKT_M_Tax ON MKT_M_PIGO_Produk.pdTax = MKT_M_Tax.TaxID LEFT OUTER JOIN MKT_M_Stok ON MKT_M_PIGO_Produk.pdID = MKT_M_Stok.st_pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') GROUP BY MKT_M_Stok.st_pdID, MKT_M_PIGO_Produk.pdID, MKT_M_PIGO_Produk.pdNama, MKT_M_PIGO_Produk.pdLokasi, MKT_M_PIGO_Produk.pdPartNumber, MKT_M_Stok.st_pdQty,  MKT_M_Stok.st_pdHarga, MKT_M_Tax.TaxRate, MKT_M_PIGO_Produk.pdUpTo,MKT_M_PIGO_Produk.pdHarga, pdUpdateTime ORDER BY pdUpdateTime DESC",Pages

                                        PagNav = CInt(Request.QueryString("Pages"))
                                            
                                        If (PagNav = 0) Then : PagNav = 1 : End If

                                        Produk.AbsolutePage = PagNav
                                        TotalPag = Produk.PageCount
                                    %>
                                    <thead >
                                        <tr  class="text-center">
                                            <th>NO</th>
                                            <th>UPDATE-TIME</th>
                                            <th>ID PRODUK</th>
                                            <th>NAMA</th>
                                            <th>SKU/PART NUMBER</th>
                                            <th>HARGA BELI </th>
                                            <th>UpTo</th>
                                            <th>HARGA JUAL (/PPN)</th>
                                            <th>HARGA JUAL (+PPN)</th>
                                            <th>STOK</th>
                                            <th>PEMBELIAN</th>
                                            <th>PENJUALAN</th>
                                            <th> SISA</th>
                                            <th>RAK</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                            no = 0 
                                            While Not Produk.Eof And Produk.AbsolutePage = PagNav 
                                            no = no + 1
                                        %>
                                        <tr>
                                            <td class="text-center"> <%=no%> </td>
                                            <td class="text-center"><%=Day(CDate(Produk("pdUpdateTime")))%>-<%=Month(CDate(Produk("pdUpdateTime")))%>-<%=Year(CDate(Produk("pdUpdateTime")))%> </td>
                                            <td class="text-center"> 
                                                <button id="myBtn<%=Produk("pdID")%>" class="cont-btn"> <%=Produk("pdID")%> 
                                            </td>
                                            <td>
                                                <%=Produk("pdNama")%>
                                                <input type="hidden" name="pdID" id="pdID<%=Produk("pdID")%>" value="<%=Produk("pdID")%>">
                                            </td>
                                            <td><%=Produk("pdPartNumber")%></td>
                                            <td class="text-center"><%=Replace(Replace(FormatCurrency(Produk("HargaAwal")),"$","Rp. "),".00","")%></td>
                                            <td class="text-center"> <%=Produk("pdUpTo")%> % </td>
                                            <%

                                                Harga = Produk("HargaAwal")
                                                UpTo  = Harga+(Harga*Produk("pdUpTo")/100)
                                                Tax   = UpTo*Produk("TaxRate")/100
                                                SebelumPPN = round(UpTo)
                                                SetelahPPN = round(UpTo+Tax)
                                                
                                            %>
                                            <td class="text-center"> <%=Replace(Replace(FormatCurrency(SebelumPPN),"$","Rp. "),".00","")%> </td>
                                            <td class="text-center"> <%=Replace(Replace(FormatCurrency(SetelahPPN),"$","Rp. "),".00","")%> </td>
                                            <td class="text-center"><%=Produk("StokAwal")%></td>
                                            <%
                                                Produk_CMD.commandText = "SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian, ISNULL(MKT_M_PIGO_Produk.pdHarga, 0) AS HargaPembelian FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y') AND pdID = '"& Produk("pdID") &"' GROUP BY MKT_M_PIGO_Produk.pdHarga"
                                                'response.write Produk_CMD.commandText &"<br>"
                                                set SaldoMasuk = Produk_CMD.execute
                                            %>
                                            <td class="text-center"> <%=SaldoMasuk("Pembelian")%> </td>
                                            <input type="hidden" name="pdStok" id="pdStok<%=Produk("pdID")%>" value="<%=SaldoMasuk("Pembelian")%>">
                                            <input type="hidden" name="pdHargaJual" id="pdHargaJual<%=Produk("pdID")%>" value="<%=SaldoMasuk("HargaPembelian")%>">
                                            <%
                                                Produk_CMD.commandText = "SELECT ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, 0) AS HargaPenjualan, ISNULL(MKT_T_Permintaan_Barang_D.Perm_pdQty, 0) AS Penjualan FROM MKT_T_Permintaan_Barang_H LEFT OUTER JOIN MKT_T_Permintaan_Barang_D ON MKT_T_Permintaan_Barang_H.PermID = MKT_T_Permintaan_Barang_D.Perm_IDH FULL OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID WHERE (MKT_M_PIGO_Produk.pdAktifYN = 'Y')AND pdID = '"& Produk("pdID") &"' "
                                                'response.write Produk_CMD.commandText &"<br>"
                                                set SaldoKeluar = Produk_CMD.execute
                                            %>
                                            <td class="text-center"> <%=SaldoKeluar("Penjualan")%> </td>
                                            <%
                                                Sisa = Produk("StokAwal")+SaldoMasuk("Pembelian")-SaldoKeluar("Penjualan")
                                            %>
                                            <td class="text-center"> <%=Sisa%></td>
                                            
                                            <td class="text-center"><%=Produk("pdLokasi")%></td>
                                        </tr>
                                        <!-- Modal -->
                                            <!-- The Modal -->
                                            <div id="myModal<%=Produk("pdID")%>" class="modal-PD">

                                            <!-- Modal content -->
                                                <div class="modal-content-PD">
                                                    <div class="modal-body-PD">
                                                        <div class="row mt-3 p-1">
                                                            <div class="col-11">
                                                                <span class="cont-judul"> Produk ID : <%=Produk("pdID")%> <input class=" txt-modal-desc  mb-2 text-center"type="text" name="ItemID" id="ItemID" Value="" style="border:none"> </span>
                                                                </div>
                                                                <div class="col-1">
                                                                    <span><i class="fas fa-times closee<%=Produk("pdID")%>" id="closee"></i></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="body" style="padding:5px 20px">
                                                            <div class="row  mb-2 text-center">
                                                                <div class="col-12">
                                                                </div>
                                                            </div>
                                                            <div class="row  mb-2 text-center">
                                                                <div class="col-4" >
                                                                    <div class="cont-a" style="background-color:#eee; border-radius:10px; padding:10px 10px;">
                                                                        <span class="txt-modal-desc" style="font-size:25px"> <i class="fas fa-edit"></i> </span><br>
                                                                        <button onclick="window.open('update-Produk.asp?pdID='+document.getElementById('pdID<%=Produk("pdID")%>').value,'_Self')" class="cont-btn"> Edit Produk </button>
                                                                    </div>
                                                                </div>
                                                                <div class="col-4">
                                                                    <div class="cont-a" style="background-color:#eee; border-radius:10px; padding:10px 10px;">
                                                                        <span class="txt-modal-desc" style="font-size:25px"> <i class="fas fa-trash"></i> </span><br>
                                                                    <button onclick="deleteproduk<%=Produk("pdID")%>()" class="cont-btn"> Hapus Produk </button>
                                                                    </div>
                                                                </div>
                                                                <div class="col-4">
                                                                    <div class="cont-a" style="background-color:#eee; border-radius:10px; padding:10px 10px;">
                                                                        <span class="txt-modal-desc" style="font-size:25px"> <i class="fas fa-upload"></i> </span><br>
                                                                        <button onclick="window.open('P-upproduk.asp?produkid='+document.getElementById('pdID<%=Produk("pdID")%>').value+'&stokproduk='+document.getElementById('pdStok<%=Produk("pdID")%>').value+'&harga='+document.getElementById('pdHargaJual<%=Produk("pdID")%>').value,'_Self')" class="cont-btn"> Up Produk </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            <!-- Modal content -->
                                        <!-- Modal -->
                                        <script>
                                            var modal<%=Produk("pdID")%> = document.getElementById("myModal<%=Produk("pdID")%>");
                                            var btn<%=Produk("pdID")%> = document.getElementById("myBtn<%=Produk("pdID")%>");
                                            var span<%=Produk("pdID")%> = document.getElementsByClassName("closee<%=Produk("pdID")%>")[0];
                                            btn<%=Produk("pdID")%>.onclick = function() {
                                            modal<%=Produk("pdID")%>.style.display = "block";
                                            }
                                            span<%=Produk("pdID")%>.onclick = function() {
                                            modal<%=Produk("pdID")%>.style.display = "none";
                                            }
                                            window.onclick = function(event) {
                                            if (event.target == modal<%=Produk("pdID")%>) {
                                                modal<%=Produk("pdID")%>.style.display = "none";
                                            }
                                            }
                                            function upproduk<%=Produk("pdID")%>(){
                                                var pdID = document.getElementById("pdID<%=Produk("pdID")%>").value;
                                                
                                                var pdStok = document.getElementById("pdStok<%=Produk("pdID")%>").value;
                                                var pdHargaJual = document.getElementById("pdHargaJual<%=Produk("pdID")%>").value;
                                                $.ajax({
                                                    type: "get",
                                                    url: "P-upproduk.asp",
                                                    data: { produkid : pdID, stokproduk : pdStok, harga : pdHargaJual },
                                                    success: function (data) {
                                                        console.log(data);  
                                                    }
                                                    
                                                });
                                            }
                                            function deleteproduk<%=Produk("pdID")%>(){
                                                var pdID = document.getElementById("pdID<%=Produk("pdID")%>").value;
                                                Swal.fire({
                                                    title: 'Apakah Anda Yakin Akan Menghapus Produk Ini ?',
                                                    showDenyButton: true,
                                                    showCancelButton: true,
                                                    confirmButtonText: 'Iya',
                                                    denyButtonText: `Tidak`,
                                                    }).then((result) => {
                                                    if (result.isConfirmed) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "delete-Produk.asp",
                                                            data: { 
                                                                pdID
                                                            },
                                                            success: function (data) {
                                                                Swal.fire({
                                                                    icon: 'success',
                                                                    title: 'Data Berhasil Dinonaktifkan'
                                                                    }).then((result) => {
                                                                        window.open(`index.asp`,`_Self`)
                                                                })
                                                            }
                                                            
                                                        });
                                                    } else if (result.isDenied) {
                                                        window.open(`index.asp`,`_Self`)
                                                    }
                                                })
                                                
                                            }
                                        </script>
                                        <%
                                            Produk.MoveNext : Wend
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
                <div class="row mb-4">
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
    </div>
    <!--#include file="../../ModalHome.asp"-->
</body>
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
    <script>
        function getproduk(){
            var Produk = document.getElementById("search").value;
            var kategori = document.getElementById("kategori").value;
            var merk = document.getElementById("merk").value;
            $.ajax({
                type: "GET",
                url: "get-produk.asp",
                    data:{
                        Produk,
                        kategori,
                        merk
                    },
                success: function (data) {
                    $('.cont-produk').html(data);
                }
            });
        }
        function kategori(){
            var kategori = document.getElementById("kategori").value;
            if( kategori == "" ){
                $('#merk').prop("disabled", true);;
            }else{
                $('#merk').prop("disabled", false);;
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
    </script>
</html>