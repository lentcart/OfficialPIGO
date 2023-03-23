<!--#include file="../../../../Connections/pigoConn.asp" -->
<!--#include file="../../../../UpdateLOG/UpdateLOG.asp"-->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">

<%
        Cat_ID       = request.queryString("Cat_ID")

        set  GL_M_CategoryItem_CMD = server.createObject("ADODB.COMMAND")
        GL_M_CategoryItem_CMD.activeConnection = MM_PIGO_String
        GL_M_CategoryItem_CMD.commandText = "UPDATE GL_M_CategoryItem_PIGO SET Cat_AktifYN = 'N' Where Cat_ID = '"& Cat_ID &"'"
        set CatItem =  GL_M_CategoryItem_CMD.execute

        Log_ServerID 	= "" 
        Log_Action   	= "DELLETE"
        Log_Key         = Cat_ID
        Log_Keterangan  = "Kategori Item dengan ID : "& Cat_ID &" Dinonaktifkan / dihapus pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

%>
