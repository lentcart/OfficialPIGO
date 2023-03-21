<!--#include file="../../../connections/pigoConn.asp"-->

<% 
    nopermintaan = request.queryString("nopermintaan")           
    tglpermintaan = request.queryString("tglpermintaan")            
    namacust = request.queryString("namacust")
    phonecust = request.queryString("phonecust")
    emailcust = request.queryString("emailcust")
    alamatlengkap = request.queryString("alamatlengkap")
    kota = request.queryString("kota")
    namacp = request.queryString("namacp")
    
    set Penawaran_CMD = server.CreateObject("ADODB.command")
    Penawaran_CMD.activeConnection = MM_pigo_STRING

    Penawaran_CMD.commandText = " exec sp_add_MKT_T_Penawaran '"& nopermintaan &"','"& tglpermintaan &"','"& namacust &"','"& phonecust &"','"& emailcust &"','"& alamatlengkap &"','"& kota &"','"& namacp &"','1','','"& Session("username") &"' "
    'response.write Penawaran_CMD.commandText &"<br><br>"
    set Penawaran = Penawaran_CMD.execute
    'response.Write Penawaran("id")
    'Response.redirect "index.asp"
%> 
<input type="hidden" name="pshID" id="pshID" value="<%=Penawaran("id")%>">
<button onclick="batal()"class="cont-btn label-po"><i class="fas fa-ban"></i> Batalkan Permintaan </button>