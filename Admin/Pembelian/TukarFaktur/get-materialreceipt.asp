<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    TFD_mmID = request.queryString("TFD_mmID")

    set MaterialReceipt_CMD = server.createObject("ADODB.COMMAND")
	MaterialReceipt_CMD.activeConnection = MM_PIGO_String
    MaterialReceipt_CMD.commandText = "SELECT SUM(MKT_T_MaterialReceipt_D2.mm_pdSubtotal) as TotalMM, MKT_T_MaterialReceipt_D2.mm_poID FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MKT_T_MaterialReceipt_H.mmID = '"& TFD_mmID &"') GROUP BY MKT_T_MaterialReceipt_D2.mm_poID "
    'Response.Write MaterialReceipt_CMD.commandText & "<br>"
    set MaterialReceipt = MaterialReceipt_CMD.execute
        
%>
<span class="cont-text"> Total Material Receipt </span><br>
<input readonly type="text" class="text-center cont-form" name="TFD_TotalMM" id="TFD_TotalMM" value="<%=Replace(Replace(FormatCurrency(MaterialReceipt("TotalMM")),"$","Rp."),".00","")%>" >
<input readonly type="hidden" class="text-center cont-form" name="TFD_Total" id="TFD_Total" value="<%=MaterialReceipt("TotalMM")%>" >