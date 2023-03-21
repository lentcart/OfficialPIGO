<!--#include file="../../../Connections/pigoConn.asp" --><html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Paginando Dados</title>
	<link type="text/css" rel="stylesheet" href="style.css" />
</head>
<body>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
<%
Dim Conexao
Set Conexao = Server.CreateObject("Adodb.Connection")
Conexao.ConnectionString = MM_PIGO_String
Conexao.Open

Dim Rs_DADOS, PagNav, TotalPag
Dim Anterior, Proximo, Jo, PaginaVisita
Set Rs_DADOS = Server.CreateObject("Adodb.RecordSet")

Conexao.CursorLocation = 3
Rs_DADOS.PageSize = 3
Rs_DADOS.Open "SELECT MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_T_PurchaseOrder_H.poUpdateTime,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custPaymentTerm, MKT_T_PurchaseOrder_H.po_JatuhTempo, MKT_T_PurchaseOrder_H.poDesc, MKT_T_PurchaseOrder_H.po_InvAP_Tanggal,  MKT_T_PurchaseOrder_H.poStatus, MKT_T_PurchaseOrder_H.po_payID, MKT_T_PurchaseOrder_H.po_payYN, MKT_T_PurchaseOrder_H.po_payTanggal, MKT_T_PurchaseOrder_H.poStatusKredit FROM MKT_T_PurchaseOrder_H LEFT OUTER JOIN MKT_M_Customer ON MKT_T_PurchaseOrder_H.po_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_PurchaseOrder_D ON MKT_T_PurchaseOrder_H.poID = MKT_T_PurchaseOrder_D.poID_H WHERE (MKT_T_PurchaseOrder_H.poAktifYN = 'Y') GROUP BY MKT_T_PurchaseOrder_H.poID, MKT_T_PurchaseOrder_H.poTanggal, MKT_T_PurchaseOrder_H.poJenisOrder, MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_T_PurchaseOrder_H.poUpdateTime,  MKT_M_Customer.custPembayaran, MKT_M_Customer.custPaymentTerm, MKT_T_PurchaseOrder_H.po_JatuhTempo, MKT_T_PurchaseOrder_H.poDesc, MKT_T_PurchaseOrder_H.po_InvAP_Tanggal,  MKT_T_PurchaseOrder_H.poStatus, MKT_T_PurchaseOrder_H.po_payID, MKT_T_PurchaseOrder_H.po_payYN, MKT_T_PurchaseOrder_H.po_payTanggal, MKT_T_PurchaseOrder_H.poStatusKredit ORDER BY  MKT_T_PurchaseOrder_H.poUpdateTime DESC",Conexao

If Rs_DADOS.Eof Then
	Response.Write("<tr><td height=""28"" align=""center"">LISTA VAZIA</td></tr>")
Else
    PagNav = CInt(Request.QueryString("Pages"))
    
    If (PagNav = 0) Then : PagNav = 1 : End If

    Rs_DADOS.AbsolutePage = PagNav
    TotalPag = Rs_DADOS.PageCount
%>
<tr>
<td><table class="table" width="600" border="0" cellspacing="0" cellpadding="0">
    <tr class="fonteBr">
      <td width="145" height="36" align="center" bgcolor="#FFBA75"><strong>CÃ“DIGO</strong></td>
      <td width="334" align="center" bgcolor="#FFBA75"><strong>NOME</strong></td>
      <td width="119" align="center" bgcolor="#FFBA75"><strong>UNIDADE</strong></td>
    </tr>
    <% While Not Rs_DADOS.Eof And Rs_DADOS.AbsolutePage = PagNav %>
    <tr class="fontePr">
      <td height="27" align="center"><% Response.Write(Rs_DADOS("poID")) %></td>
      <td align="center"><% Response.Write(Rs_DADOS("poTanggal")) %></td>
      <td align="center"><% Response.Write(Rs_DADOS("poJenisOrder")) %></td>
    </tr>
    <%
    Rs_DADOS.MoveNext : Wend

    Anterior = PagNav - 1
    Proximo = PagNav + 1
    If (Anterior <= 0) Then : Anterior = 1 : End If
    If (Proximo > TotalPag) Then : Proximo = TotalPag : End If
    %>
  </table></td>
</tr>
<tr>
<td height="28">&nbsp;</td>
</tr>
<tr>
<td align="center"><table width="457" height="41" border="0" cellpadding="0" cellspacing="4">
<tr>
  <td width="300" height="30" align="center" class="fontePr"><%
If Request.QueryString("Pages") = "" Then
    Response.Write("Página 1 de "&TotalPag)
Else
    Response.Write("Página "&Request.QueryString("Pages")&" de "&TotalPag)
End If 
%></td>
  <td width="42" align="center" class="pagNumber"><a href="?Pages=1" class="fonte">&nbsp;&laquo;&nbsp;InÃ­cio&nbsp;</a>
<%
PaginaVisita = CInt(Request.QueryString("Pages"))

If PagNav > 1 Then
    Response.Write("<td width=""36"" align=""center"" "& _
    "class=""pagNumberMark""><a href=""?Pages="&Anterior&""" "& _
    "style=""font: 12px Arial; color: #FFFFFF;"">&nbsp;&laquo;&nbsp;</a></td>")
End If

If PagNav > 5 Then
    Response.Write("<td width=""28"" align=""center"" class=""fontePontos"">&nbsp;...&nbsp;</td>")
End If

If PagNav <= 5 Then
If TotalPag >= 5 Then
For Jo = 1 To 5
	If PagNav = Jo Then
		Response.Write("<td width=""36"" align=""center"" class=""pagNumberMark""> "& _
		"&nbsp;<strong>"&Jo&"</strong>&nbsp;</td>")
	Else
		Response.Write("<td width=""36"" align=""center"" class=""pagNumber""> "& _
		"<a href=""?Pages="&Jo&""" class=""fonte"">&nbsp;"&Jo&"&nbsp;</a></td>")
	End If
Next
Else
For Jo = 1 To TotalPag
	If PagNav = Jo Then
		Response.Write("<td width=""36"" align=""center"" class=""pagNumberMark""> "& _
		"&nbsp;<strong>"&Jo&"</strong>&nbsp;</td>")
	Else
		Response.Write("<td width=""36"" align=""center"" class=""pagNumber""> "& _
		"<a href=""?Pages="&Jo&""" class=""fonte"">&nbsp;"&Jo&"&nbsp;</a></td>")
	End If
Next
End If
End If

If PagNav > 5 Then
	PagNav = PagNav + 4
	Pg = PagNav
	MaxB = Request.QueryString("Pages") - 1
	
	If (MaxB + 1) = TotalPag Then
	For Jo = MaxB To (Pg - 4)
		If PaginaVisita = Jo Then
			Response.Write("<td width=""36"" align=""center"" class=""pagNumberMark""> "& _
			"&nbsp;<strong>"&Jo&"</strong>&nbsp;</td>")
		Else
			Response.Write("<td width=""36"" align=""center"" class=""pagNumber""> "& _
			"<a href=""?Pages="&Jo&""" class=""fonte"">&nbsp;"&Jo&"&nbsp;</a></td>")
		End If
	Next            
	ElseIf (MaxB + 2) = TotalPag Then
	For Jo = MaxB To (Pg - 3)
		If PaginaVisita = Jo Then
			Response.Write("<td width=""36"" align=""center"" class=""pagNumberMark""> "& _
			"&nbsp;<strong>"&Jo&"</strong>&nbsp;</td>")
		Else
			Response.Write("<td width=""36"" align=""center"" class=""pagNumber""> "& _
			"<a href=""?Pages="&Jo&""" class=""fonte"">&nbsp;"&Jo&"&nbsp;</a></td>")
		End If
	Next
	Else
	For Jo = (MaxB - 1) To (Pg - 2)
		If PaginaVisita = Jo Then
			Response.Write("<td width=""36"" align=""center"" class=""pagNumberMark""> "& _
			"&nbsp;<strong>"&Jo&"</strong>&nbsp;</td>")
		Else
			Response.Write("<td width=""36"" align=""center"" class=""pagNumber""> "& _
			"<a href=""?Pages="&Jo&""" class=""fonte"">&nbsp;"&Jo&"&nbsp;</a></td>")
		End If
	Next
	End If
End If

If (TotalPag <> PaginaVisita) And (TotalPag >= 5) Then
	Response.Write("<td width=""28"" align=""center"" class=""fontePontos"">&nbsp;...&nbsp;</td>")
End If
%>
  <td width="34" align="center" class="pagNumberMark"><a href="?Pages=<% Response.Write(Proximo) %>" class="fonte">&nbsp;&raquo;&nbsp;</a></td>
  <td width="42" align="center" class="pagNumber"><a href="?Pages=<% Response.Write(TotalPag) %>" class="fonte">&nbsp;Final&nbsp;&raquo;&nbsp;</a></td>
</tr>
</table></td>
</tr>
<%
End If
Set Rs_DADOS = Nothing
%>
</table>
</body>
</html>