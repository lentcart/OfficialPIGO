<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    KasID = request.queryString("X")
    CatName = request.queryString("CATNAME")

    set Kas_Detail_CMD = server.CreateObject("ADODB.command")
    Kas_Detail_CMD.activeConnection = MM_pigo_STRING
    
    Kas_Detail_CMD.commandText = "Select * From GL_M_Kas Where KasID = '"& KasID &"' "
    set KasDetail = Kas_Detail_CMD.execute

    Kas_Detail_CMD.commandText = "SELECT GL_M_Item.Item_Cat_ID, GL_M_CategoryItem_PIGO.Cat_Name FROM GL_M_Item LEFT OUTER JOIN GL_M_CategoryItem_PIGO ON GL_M_Item.Item_Cat_ID = GL_M_CategoryItem_PIGO.Cat_ID  Where GL_M_Item.Item_CatTipe = '"& KasDetail("KasJenis") &"' AND  GL_M_CategoryItem_PIGO.Cat_Name LIKE '%"& CatName &"%' GROUP BY GL_M_Item.Item_Cat_ID, GL_M_CategoryItem_PIGO.Cat_Name "
    set KategoriItem = Kas_Detail_CMD.execute
%>
<table class="align-items-center table tb-transaksi table-bordered table-condensed mt-1" style="font-size:12px;">
<% if KategoriItem.eof = true then %>
    <tr class="text-center">
        <td colspan="2"> Data Tidak Ditemukan </td>
    </tr>
<% else %>
<% 
    no = 0
    do while not KategoriItem.eof 
    no = no + 1
%>
    <tr>
        <td class="text-center"><Input onclick="getCatItem<%=no%>()" class=" text-center cont-form" type="text" name="Item_Cat_ID" id="Item_Cat_ID<%=no%>" Value="<%=KategoriItem("Item_Cat_ID")%>"  style="width:15rem;border:none;"></td>
        <td><Input onclick="getCatItem<%=no%>()" class="cont-form" type="text" name="CatID" id="CatID" Value="<%=KategoriItem("Cat_Name")%>" style="width:19rem;border:none;"> </td>
    </tr>
    <script>
        function getCatItem<%=no%>(){
            $.ajax({
                type: "get",
                url: "get-KategoriItem.asp?CATID="+document.getElementById("Item_Cat_ID<%=no%>").value,
                success: function (url) {
                $('.cont-CATITEM').html(url);
                }
            });
            document.getElementById("cont-KategoriKas").style.display = "none"
        }
    </script>
<% KategoriItem.Movenext
loop %>
<% end if %>
</table>