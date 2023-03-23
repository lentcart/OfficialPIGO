<!--#include file="../../../../Connections/pigoConn.asp" -->

<%
        Cat_ID       = request.queryString("Cat_ID")
        Cat_Name     = request.queryString("Cat_Name")
        Cat_Tipe     = request.queryString("Cat_Tipe")

        if Session("Username")="" then 

        response.redirect("../../../../admin/")
        
        end if

        dim MaxID

        set GL_M_CategoryItem_CMD = server.createObject("ADODB.COMMAND")
        GL_M_CategoryItem_CMD.activeConnection = MM_PIGO_String
        GL_M_CategoryItem_CMD.commandText = "SELECT * FROM GL_M_CategoryItem_PIGO WHERE Cat_Tipe = '"& Cat_Tipe &"' AND Cat_ID LIKE '%"& Cat_ID &"%'  AND Cat_Name LIKE '%"& Cat_Name &"%'"
        response.write GL_M_CategoryItem_CMD.commandText
        set CatItem = GL_M_CategoryItem_CMD.execute

        GL_M_CategoryItem_CMD.commandText = "SELECT MAX(Cat_ID) AS Cat_ID , MAX(LEFT(Cat_ID,3)) AS MaxID FROM GL_M_CategoryItem_PIGO WHERE Cat_AktifYN = 'Y'"
        set LastCAID = GL_M_CategoryItem_CMD.execute

        GL_M_CategoryItem_CMD.commandText = "SELECT '"& LastCAID("MaxID") &"' + Right('0000000000' + Convert(VarChar, COnvert(int, Right(IsNull(MAX(Cat_ID),'0000000000'),10))+1),10) AS MaxID FROM GL_M_CategoryItem_PIGO WHERE LEFT(Cat_ID,3) = '"& LastCAID("MaxID") &"' "
        set Max = GL_M_CategoryItem_CMD.execute

        GL_M_CategoryItem_CMD.commandText = "SELECT Cat_ID , Cat_Name, Cat_Tipe FROM GL_M_CategoryItem_PIGO WHERE Cat_ID = '"& LastCAID("Cat_ID") &"' "
        set LastAccount = GL_M_CategoryItem_CMD.execute

        NextID      = Max("MaxID")
%>
<% 
    no = 0 
    do while not CatItem.eof 
    no = no + 1
%>
<tr>
    <td class="text-center"><%=no%></td>
    <td class="text-center"><button class="cont-btn" style="width:max-content"> <%=CatItem("Cat_ID")%> </button> </td>
    <td><%=CatItem("Cat_Name")%></td>
    <% if CatItem("Cat_Tipe") = "T" then %>
    <td class="text-center"> Masuk </td>
    <% else %>
    <td class="text-center"> Keluar </td>
    <% end if %>
    <td class="text-center" ><%=CatItem("Cat_AktifYN")%></td>
    <td class="text-center" ><%=CatItem("Cat_UpdateTime")%></td>
    <td class="text-center" >
        <button class="cont-btn" onclick="hapus('<%=CatItem("Cat_ID")%>')"> DELLETE </button>
    </td>

</tr>
<% 
    CatItem.movenext
    loop
    nomor = no  
%>