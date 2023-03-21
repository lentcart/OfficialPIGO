<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
    response.redirect("../../../admin/")
    end if

    set CashBank_H_CMD = server.CreateObject("ADODB.command")
    CashBank_H_CMD.activeConnection = MM_PIGO_String
    CashBank_H_CMD.commandText = "SELECT * FROM GL_T_CashBank_H"
    'response.write CashBank_H_CMD.commandText
    set CashBank = CashBank_H_CMD.execute

    set GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
	GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
    GL_M_ChartAccount_cmd.commandText = "SELECT CA_ID, CA_Name FROM GL_M_ChartAccount WHERE CA_AktifYN = 'Y' AND NOT  CA_Name LIKE  '%n/a%' AND NOT CA_Type = 'H' "
    set AccountKas = GL_M_ChartAccount_cmd.execute

    set Jurnal_CMD = server.createObject("ADODB.COMMAND")
	Jurnal_CMD.activeConnection = MM_PIGO_String
    Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID,GL_T_Jurnal_H.JR_Status, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN,GL_T_Jurnal_H.JR_Status"
    set Jurnal = Jurnal_CMD.execute

    Dim Pages
    Set Pages = Server.CreateObject("Adodb.Connection")
    Pages.ConnectionString = MM_PIGO_String
    Pages.Open

    Dim GL_Jurnal, PagNav, TotalPag
    Dim CurrntPage, NextPage, Page, VisitePage
    Set GL_Jurnal = Server.CreateObject("Adodb.RecordSet")
    
%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Official PIGO </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/admin/dashboardnew.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"> </script>
    <script>
        function getListData(){
                $.ajax({
                    type: "get",
                    url: "load-list-jurnal.asp?tgla="+document.getElementById("tgla").value+"&tgle="+document.getElementById("tgle").value+"&JR_Type="+document.getElementById("typejr").value+"&JR_ID="+document.getElementById("jrid").value,
                    success: function (url) {
                        console.log(url);
                    $('.DataListJurnal').html(url);
                    }
                });
            }
        function newjurnal(){
            document.getElementById("add-jurnal").style.display = "block";
            document.getElementById("list-jurnal").style.display = "none";
            document.getElementById("btn-batal").style.display = "block";
            document.getElementById("btn-add").style.display = "none";
        }
        function canclejurnal(){
            document.getElementById("list-jurnal").style.display = "block";
            document.getElementById("add-jurnal").style.display = "none";
            document.getElementById("btn-batal").style.display = "none";
            document.getElementById("btn-add").style.display = "block";
        }
        function getAccountID(){
            document.getElementById("cont-account-id").style.display = "block"
        }
        function getAccountName(){
            $.ajax({
                type: "get",
                url: "get-ACName.asp?CA_Name="+document.getElementById("AccountID").value,
                success: function (url) {
                $('.cont-account-kas').html(url);
                }
            });
        }
        function getAccountKas(){
            $.ajax({
                type: "get",
                url: "get-ACID.asp?CA_ID="+document.getElementById("AccountID").value,
                success: function (url) {
                $('.cont-account-kas').html(url);
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
        .cont-rincian-data-jurnal{
            background-color:white;
            height:13rem;
            overflow:scroll;
            overflow-x:hidden;
        }
        .cont-account-id{
            background-color:white;
            height:6rem;
            overflow:scroll;
            overflow-x:hidden;
        }
        .tb-account-id{
            border:1px solid black;
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
                        <span class="cont-judul">  JURNAL </span>
                    </div>
                    <div class="col-1">
                        <button class="cont-btn" onclick="Refresh()"> <i class="fas fa-sync-alt"></i> </button>
                    </div>
                    <div class="col-lg-2 col-md-1 col-sm-12">
                        <button onclick="newjurnal()" class="cont-btn" name="btn-add" id="btn-add" style="display:block"> <i class="fas fa-plus"></i> &nbsp; JURNAL BARU </button>
                        <button onclick="canclejurnal()" class="cont-btn" name="btn-batal" id="btn-batal" style="display:none"> <i class="fas fa-ban"></i> &nbsp; BATALKAN  </button>
                    </div>
                </div>
            </div>

            <div class="cont-background mt-2"  id="add-jurnal" style="display:none">
                <div class="add-jurnal mt-1 mb-2">
                    <form class="add-jurnal" action="add-jurnalH.asp" method="POST">
                        <div class="row">
                            <div class="col-2">
                                <span class="cont-text"> Pembuat </span> <br>
                                <input readonly class="text-center cont-form" type="text" name="JR_UpdateID" id="cont" value="<%=session("username")%>">
                            </div>
                            <div class="col-2">
                                <span class="cont-text"> Tanggal </span> <br>
                                <input required class="text-center cont-form" type="date" name="JR_Tanggal" id="cont" value="">
                            </div>
                            <div class="col-2">
                                <span class="cont-text"> Type Jurnal </span> <br>
                                <select  class="cont-form" name="JR_Type" id="cont" aria-label="Default select example" required>
                                    <option value=""> Pilih Type Jurnal </option>
                                    <option value="T">Kas Masuk</option>
                                    <option value="K">Kas Keluar</option>
                                    <option value="M">Memorial</option>
                                </select>
                            </div>
                            <div class="col-4">
                                <span class="cont-text"> Keterangan Jurnal </span> <br>
                                <input required class="text-center cont-form" type="text" name="JR_Keterangan" id="cont" value="">
                            </div>
                            <div class="col-2">
                                <br>
                                <input class="cont-btn" type="submit" name="simpan" id="simpan" value="Tambah Jurnal">
                                <!--<button onclick="addjurnal()" class="cont-btn" name="tambah-jurnal" id="tambah-jurnal" style="display:block"> Tambah Jurnal </button>
                                <button onclick="batal()" class="cont-btn" name="batal-jurnal" id="batal-jurnal" style="display:none"> Batal Jurnal </button>-->
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="cont-background mt-2"  id="list-jurnal" style="display:block">
                <div class="list-jurnal mb-2">
                    <div class="row">
                        <div class="col-2">
                            <span class="cont-text"> Periode Jurnal </span> <br>
                            <input onchange="getListData()" class="text-center cont-form" type="Date" name="tgla" id="tgla" value="">
                        </div>
                        <div class="col-2">
                            <br>
                            <input onchange="getListData()" class="text-center cont-form" type="Date" name="tgle" id="tgle" value="">
                        </div>
                        <div class="col-2">
                            <span class="cont-text"> Type Jurnal </span> <br>
                            <select onchange="getListData()" class="cont-form" name="typejr" id="typejr" aria-label="Default select example" required>
                                <option value=""> Pilih Type Jurnal </option>
                                <option value="MM">Pembelian</option>
                                <option value="SJ">Penjualan</option>
                                <option value="T">Terima Kas</option>
                                <option value="K">Kas Keluar</option>
                                <option value="M">Memorial</option>
                            </select>
                        </div>
                        <div class="col-2">
                            <span class="cont-text"> Jurnal ID </span> <br>
                            <input onkeyup="getListData()" class="cont-form" type="text" name="jrid" id="jrid" value="" placeholder="Masukan No Jurnal">
                        </div>
                        <div class="col-2">
                            <br>
                            <button class="cont-btn"  onclick="window.open('Print-GL-Jurnal.asp?Jurnal_Tgla='+document.getElementById('tgla').value+'&Jurnal_Tgle='+document.getElementById('tgle').value+'&Jurnal_Type='+document.getElementById('typejr').value+'&Jurnal_ID='+document.getElementById('jrid').value)"> Cetak Jurnal </button>
                        </div>
                        <div class="col-2">
                            <br>
                            <button class="cont-btn"  onclick="window.open('Exc-GL-Jurnal.asp?Jurnal_Tgla='+document.getElementById('tgla').value+'&Jurnal_Tgle='+document.getElementById('tgle').value+'&Jurnal_Type='+document.getElementById('typejr').value+'&Jurnal_ID='+document.getElementById('jrid').value,'_Self')"> Export Excel </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tb-jurnal" id="tb-jurnal" style="display:block">
                <div class="row mt-2 p-1">
                    <div class="col-12">
                        <div class="cont-tb">
                            <table class=" align-items-center cont-tb table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px;">
                                <%
                                    Pages.CursorLocation = 3
                                    GL_Jurnal.PageSize = 8
                                    GL_Jurnal.Open "SELECT GL_T_Jurnal_H.JR_ID,GL_T_Jurnal_H.JR_Status, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type, GL_T_Jurnal_H.JR_PostingYN, GL_T_Jurnal_H.JR_DeleteYN,GL_T_Jurnal_H.JR_Status",Pages
                                     If GL_Jurnal.Eof Then
                                            Response.Write("<tr><td colspan=""8"" height=""28"" align=""center"">BELUM ADA DATA TERSIMPAN</td></tr>")
                                        Else
                                    PagNav = CInt(Request.QueryString("Pages"))
                                        
                                    If (PagNav = 0) Then : PagNav = 1 : End If
                                    GL_Jurnal.AbsolutePage = PagNav
                                    TotalPag = GL_Jurnal.PageCount
                                    end if
                                %>
                                <thead>
                                    <tr class="text-center">
                                        <th> NO </th>
                                        <th> NO JURNAL </th>
                                        <th> TANGGAL </th>
                                        <th> TYPE </th>
                                        <th> KETERANGAN </th>
                                        <th> STATUS </th>
                                        <th> POSTING </th>
                                        <th> TOTAL </th>
                                    </tr>
                                </thead>
                                <tbody class="DataListJurnal">
                                <% 
                                    no = 0 
                                    While Not GL_Jurnal.Eof And GL_Jurnal.AbsolutePage = PagNav 
                                    no = no + 1
                                %>
                                    <tr>
                                        <td class="text-center"> <%=no%> </td>
                                        <td class="text-center"> 
                                            <input type="hidden" name="JR_ID" id="JR_ID<%=no%>" value="<%=GL_Jurnal("JR_ID")%>">
                                            <% if GL_Jurnal("JR_Status") = "A" then %>
                                            <button class="cont-btn"  > <%=GL_Jurnal("JR_ID")%> </button> 
                                            <% else %>
                                            <button class="cont-btn" onclick="window.open('detail-jurnal.asp?JR_ID='+document.getElementById('JR_ID<%=no%>').value,'_Self')" > <%=GL_Jurnal("JR_ID")%> </button> 
                                            <% end if %>
                                        </td>
                                        <td class="text-center"> <%=Day(CDate(GL_Jurnal("JR_Tanggal")))%>/<%=Month(CDate(GL_Jurnal("JR_Tanggal")))%>/<%=Year(CDate(GL_Jurnal("JR_Tanggal")))%></td>
                                        <td class="text-center"> <%=GL_Jurnal("JR_Type")%> </td>
                                        <td> <%=GL_Jurnal("JR_Keterangan")%> </td>
                                        <td class="text-center">  </td>
                                        <td class="text-center"> <%=GL_Jurnal("JR_PostingYN")%> </td>
                                        <%
                                            Jurnal_CMD.commandText = "SELECT SUM(GL_T_Jurnal_D.JRD_Debet + GL_T_Jurnal_D.JRD_Kredit) AS Total FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID, 12) = GL_T_Jurnal_H.JR_ID WHERE JR_ID = '"& GL_Jurnal("JR_ID") &"' "
                                            set TotalJurnal = Jurnal_CMD.execute
                                        
                                        %>
                                        <td class="text-end"> <%=Replace(Replace(Formatcurrency(TotalJurnal("Total")),"$","Rp. "),".00","")%> </td>
                                    </tr>
                                <%
                                    GL_Jurnal.MoveNext : Wend
                                    CurrntPage = PagNav - 1
                                    NextPage  = PagNav + 1
                                    If (CurrntPage <= 0) Then      : CurrntPage = 1        : End If
                                    If (NextPage > TotalPag) Then : NextPage  = TotalPag : End If
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                <div>
            <div>
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
        function addjurnal(){
            var JR_Tanggal      = $('input[name=JR_Tanggal]').val();
            var JR_Keterangan   = $('input[name=JR_Keterangan]').val();
            var JR_Type         = $('select[name=JR_Type]').val();
            var JR_UpdateID     = $('input[name=JR_UpdateID]').val();
            $.ajax({
                type: "get",
                url: "add-jurnalH.asp",
                data: {
                    JR_Tanggal,
                    JR_Keterangan,
                    JR_Type,
                    JR_UpdateID
                },
                success: function (data) {
                $('.cont-rincian-jurnal').html(data);
                }
            });
            document.getElementById("tb-jurnal").style.display = "none";
            document.getElementById("btn-batal").style.display = "none";
            document.getElementById("batal-jurnal").style.display = "block";
            document.getElementById("tambah-jurnal").style.display = "none";
            var permintaan = document.querySelectorAll("[id^=cont]");
            for (let i = 0; i < permintaan.length; i++) {
                permintaan[i].setAttribute("readonly", true);
                permintaan[i].setAttribute("disabled", true);
            }
        }

        function batal() {
            var JR_ID = document.getElementById("JRD_ID").value;
            console.log(JR_ID);
            $.ajax({
                type: "POST",
                url: "delete-jurnal.asp",
                    data:{
                        JR_ID
                    },
                success: function (data) {
                    Swal.fire('Deleted !!', data.message, 'success').then(() => {
                    location.reload();
                    });
                }
            });
            document.getElementById("tb-jurnal").style.display = "block";
            document.getElementById("btn-batal").style.display = "none";
            document.getElementById("btn-add").style.display = "block";
            document.getElementById("batal-jurnal").style.display = "none";
            document.getElementById("tambah-jurnal").style.display = "block";

            var permintaan = document.querySelectorAll("[id^=cont]");
            for (let i = 0; i < permintaan.length; i++) {
                permintaan[i].removeAttribute("readonly");
                permintaan[i].removeAttribute("disabled");
                permintaan[i].value="";
            }
        }

        function addjurnalD(){
            var JRD_ID      = $('input[name=JRD_ID]').val();
            var JRD_CA_ID   = $('input[name=AccountID]').val();
            var JRD_Keterangan   = $('input[name=JRD_Keterangan').val();
            var JRD_Debet         = $('input[name=JRD_Debet]').val();
            var JRD_Kredit     = $('input[name=JRD_Kredit]').val();
            $.ajax({
                type: "get",
                url: "add-jurnalD.asp",
                data: {
                    JRD_ID,
                    JRD_CA_ID,
                    JRD_Keterangan,
                    JRD_Debet,
                    JRD_Kredit
                },
                success: function (data) {
                $('.cont-data-jurnal').html(data);
                }
            });
            $('input[name=AccountID]').val('');
            $('input[name=JRD_Debet]').val(0);
            $('input[name=JRD_Kredit]').val(JRD_Debet);
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
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>