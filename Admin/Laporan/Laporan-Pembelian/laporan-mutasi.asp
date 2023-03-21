<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    ' id = request.queryString("custID")
    tgla = Cdate(request.queryString("tgla"))
    tgle = Cdate(request.queryString("tgle"))
    bulan = month(request.queryString("tgla"))
    tahun = year(request.queryString("tgla"))
    'response.write tahun &"<BR>"


    tgla = month(request.queryString("tgla")) & "/" & day(request.queryString("tgla")) & "/" & year(request.queryString("tgla"))
    'response.write tgla &"<BR>"
    tgle = month(request.queryString("tgle")) & "/" & day(request.queryString("tgle")) & "/" & year(request.queryString("tgle"))

    id = Split(request.queryString("custID"),",")

    for each x in id
            if len(x) > 0 then

                    filtercust = filtercust & addOR & " MKT_T_MaterialReceipt_H.mm_custID = '"& x &"' "

                    addOR = " or " 
                    
            end if
        next

        if filtercust <> "" then
            FilterFix = "and  ( " & filtercust & " )" 
        end if

        ' response.write FilterFix


    if tgla="" or tgle = "" then
        filterTanggal = ""
    else
        filterTanggal = " and mmTanggal between '"& tgla &"' and '"& tgle &"' "
    end if

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
			
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID = 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String
			
	BussinesPartner_cmd.commandText = "SELECT  MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama as bussines, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almProvinsi FROM MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID WHERE almJenis <> 'Alamat Toko' "& FilterFix &" "& filterTanggal &" GROUP BY  MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama, MKT_M_Customer.custEmail, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Alamat.almLengkap,  MKT_M_Alamat.almProvinsi "
    'response.write BussinesPartner_cmd.commandText
	set BussinesPartner = BussinesPartner_cmd.execute

    set Purchase_cmd = server.createObject("ADODB.COMMAND")
	Purchase_cmd.activeConnection = MM_PIGO_String

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-Mutasi-Pembelian - " & now() & ".xls"

    dim Mbulan
    MBulan = 0
    dim Mtahun
    Mtahun = 0
%>

<table>
    <tr>
        <th colspan="8"><%=Merchant("custNama")%></th>
    </tr>
    <tr>
        <th colspan="8">LAPORAN PEMBELIAN</th>
    </tr>
    <tr>
        <th colspan="8"> Periode Laporan : <%=tgla%> s.d <%=tgle%></th>
    </tr>
    <tr>
        <th colspan="3"> Tahun : <%=tahun%></th>
    </tr>
    <tr>
        <th colspan="3"></th>
    </tr>
    <tr>   
        <th>BULAN</th>
        <th>QTY PEMBELIAN PRODUK</th>
        <th>TOTAL PEMBELIAN </th>
    </tr>
    <%
        Purchase_cmd.commandText = "SELECT MONTH(MKT_T_MaterialReceipt_H.mmTanggal) AS BULAN , sum(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima) AS QTY,  sum(MKT_T_MaterialReceipt_D2.mm_pdSubtotal) as total FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MKT_T_MaterialReceipt_H.mm_custID ='"& BussinesPartner("mm_custID") &"') GROUP BY  MONTH(MKT_T_MaterialReceipt_H.mmTanggal)"
        'response.write Purchase_cmd.commandText
        set Purchase = Purchase_cmd.execute
    %>
    <%do while not Purchase.eof%>
    <tr>
        <td><%=monthname(Purchase("BULAN"))%></td>
        <td><%=Purchase("QTY")%> PRODUK</td>
        <td><%=Purchase("TOTAL")%></td>
        <%subtotal = subtotal + Purchase("TOTAL")%>
    </tr>
    <%
    response.flush
    Purchase.movenext
    loop%>
    <tr>
        <td colspan="2"><b>Total Keseluruhan</b></td>
        <td><%=subtotal%></td>
    </tr>
</table>