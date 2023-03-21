 <!--#include file="../../../Connections/pigoConn.asp" -->
<%
    Jurnal_Tgla     = Request.QueryString("Jurnal_Tgla")
    Jurnal_Tgle     = Request.QueryString("Jurnal_Tgle")
    Jurnal_Type     = Request.QueryString("Jurnal_Type")
    Jurnal_ID       = Request.QueryString("Jurnal_ID")

    set Jurnal_CMD = server.createObject("ADODB.COMMAND")
	Jurnal_CMD.activeConnection = MM_PIGO_String

    if Jurnal_ID = "" then 
        if Jurnal_Type = "" then 
            Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON GL_T_Jurnal_D.JRD_ID = GL_T_Jurnal_H.JR_ID WHERE JR_Tanggal BETWEEN '"& Jurnal_Tgla &"' AND '"& Jurnal_Tgle &"'  GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type ORDER BY JR_Tanggal ASC"
            set Jurnal = Jurnal_CMD.execute
        else
            Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON GL_T_Jurnal_D.JRD_ID = GL_T_Jurnal_H.JR_ID WHERE JR_Tanggal BETWEEN '"& Jurnal_Tgla &"' AND '"& Jurnal_Tgle &"'  AND JR_Type = '"& Jurnal_Type &"' GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type ORDER BY JR_Tanggal ASC"
            set Jurnal = Jurnal_CMD.execute
        end if 
        Log_ServerID 	= "" 
        Log_Action   	= "EXPORT"
        Log_Key         = "GL-Laporan Jurnal"
        Log_Keterangan  = "Melakukan export (GL) Laporan Jurnal to EXCEL periode tanggal  : "& Jurnal_Tgla &" s.d "& Jurnal_Tgle &" dengan type jurnal : "& Jurnal_Type &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)
    else 
        Jurnal_CMD.commandText = "SELECT GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type FROM GL_T_Jurnal_D RIGHT OUTER JOIN GL_T_Jurnal_H ON GL_T_Jurnal_D.JRD_ID = GL_T_Jurnal_H.JR_ID WHERE JR_Tanggal BETWEEN '"& Jurnal_Tgla &"' AND '"& Jurnal_Tgle &"'  AND JR_Type = '"& Jurnal_Type &"' AND JR_ID LIKE '%"& Jurnal_ID &"%' GROUP BY GL_T_Jurnal_H.JR_ID, GL_T_Jurnal_H.JR_Tanggal, GL_T_Jurnal_H.JR_Keterangan, GL_T_Jurnal_H.JR_Type ORDER BY JR_Tanggal ASC"
        set Jurnal = Jurnal_CMD.execute

        Log_ServerID 	= "" 
        Log_Action   	= "EXPORT"
        Log_Key         = "GL-Laporan Jurnal"
        Log_Keterangan  = "Melakukan export (GL) Laporan Jurnal to EXCEL ID : "& Jurnal_ID &"  periode tanggal  : "& Jurnal_Tgla &" s.d "& Jurnal_Tgle &" dengan type jurnal : "& Jurnal_Type &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

    end if 
    
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=Lap-Jurnal - " & now() & ".xls"

    
%>
<table>
    <tr>
        <th colspan="7" class="text-start"> <b>PT. PERKASA INDAH GEMILANG OETAMA</b> </th>
    </tr>
    <tr>
        <th colspan="7" class="text-start"> Jln. Alternatif Cibubur, Komplek Ruko Cibubur Point Automotiv Center Blok B No. 12B Cimangis, Depok – Jawa Barat </th>
    </tr>
    <tr>
        <th colspan="7" class="text-start"> otopigo.sekertariat@gmail.com - Telp : (021) 8459 6001 / 0811-8838-008  </th>
    </tr>
    <tr>
        <th> <br>  </th>
    </tr>
    <tr>
        <th colspan="7" class="text-center"> LAPORAN JURNAL </th>
    </tr>
    <tr>
        <th colspan="7" class="text-center"> PERIODE : <%=DAY(CDate(Jurnal_Tgla))%>/<%=MONTH(CDate(Jurnal_Tgla))%>/<%=YEAR(CDate(Jurnal_Tgla))%>  s.d.  <%=DAY(CDate(Jurnal_Tgle))%>/<%=MONTH(CDate(Jurnal_Tgle))%>/<%=YEAR(CDate(Jurnal_Tgle))%> </th>
    </tr>
    <tr>
        <th> <br>  </th>
    </tr>
    <tr>
        <th> NO </th>
        <th> NO JURNAL </th>
        <th> TANGGAL </th>
        <th colspan="2"> KETERANGAN </th>
        <th colspan="2"> TYPE JURNAL </th>
    </tr>
    <% 
        no = 0 
        do while not Jurnal.eof
        no = no + 1
    %>
    <tr>
        <td class="text-center"> <%=no%> </td>
        <td class="text-center"> <%=Jurnal("JR_ID")%> </td>
        <td class="text-center"> <%=DAY(CDate(Jurnal("JR_Tanggal")))%>/<%=MONTH(CDate(Jurnal("JR_Tanggal")))%>/<%=YEAR(CDate(Jurnal("JR_Tanggal")))%> </td>
        <td class="" colspan="2"> <%=Jurnal("JR_Keterangan")%> </td>
        <% if Jurnal("JR_Type") = "K" then %>
        <td colspan="2" class="text-center"> Kas Keluar </td>
        <% else if Jurnal("JR_Type") = "T" then %>
        <td colspan="2" class="text-center"> Terima Kas </td>
        <% else %>
        <td colspan="2" class="text-center"> Memorial </td>
        <% end if %> <% end if %>
    </tr>
    <%
        Jurnal_CMD.commandText = "SELECT GL_M_ChartAccount.CA_Name, GL_T_Jurnal_D.JRD_CA_ID, GL_T_Jurnal_D.JRD_Keterangan, GL_T_Jurnal_D.JRD_Debet, GL_T_Jurnal_D.JRD_Kredit FROM GL_T_Jurnal_D LEFT OUTER JOIN GL_M_ChartAccount ON GL_T_Jurnal_D.JRD_CA_ID = GL_M_ChartAccount.CA_ID RIGHT OUTER JOIN GL_T_Jurnal_H ON LEFT(GL_T_Jurnal_D.JRD_ID,12) = GL_T_Jurnal_H.JR_ID WHERE        (GL_T_Jurnal_H.JR_Tanggal BETWEEN '"& Jurnal_Tgla &"' AND '"& Jurnal_Tgle &"') AND (GL_T_Jurnal_H.JR_ID = '"& Jurnal("JR_ID") &"' ) ORDER BY GL_T_Jurnal_H.JR_Tanggal"
        set JurnalDetail= Jurnal_CMD.execute
    %>
    <% 
        do while not JurnalDetail.eof
    %>
    <tr>
        <td  colspan="3" class="text-center"> <%=JurnalDetail("JRD_CA_ID")%> </td>
        <td> <%=JurnalDetail("CA_Name")%> </td>
        <td> <%=JurnalDetail("JRD_Keterangan")%> </td>
        <td class="text-end"> <%=JurnalDetail("JRD_Debet")%> </td>
        <td class="text-end"> <%=JurnalDetail("JRD_Kredit")%> </td>
        <%
            TotalDebet = TotalDebet + JurnalDetail("JRD_Debet")
            TotalKredit = TotalKredit + JurnalDetail("JRD_Debet")
        %>
    </tr>

    <% 
        JurnalDetail.movenext
        loop
    %>
    <tr>
        <td  colspan="5" class="text-start"> SUBTOTAL </td>
        <td  class="text-end"> <%=TotalDebet%> </td>
        <td  class="text-end"> <%=TotalKredit%> </td>
    </tr>
    <%
        SubTotalDebet = SubTotalDebet + TotalDebet
        TotalDebet = 0 
        SubTotalKredit = SubTotalKredit + TotalKredit
        TotalKredit = 0 
    %>
    <% 
        Jurnal.movenext
        loop 
    %>
    <%
        GrandTotalDebet = GrandTotalDebet + SubTotalDebet
        GrandTotalKredit = GrandTotalKredit + SubTotalKredit
    %>
    <tr>
        <td  colspan="5" class="text-start"> GRANDTOTAL </td>
        <td  class="text-end"> <%=GrandTotalDebet%> </td>
        <td  class="text-end"> <%=GrandTotalKredit%> </td>
    </tr>
</table>