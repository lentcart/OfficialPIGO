<!--#include file="../../../connections/pigoConn.asp"-->
<!--#include file="../../../UpdateLOG/UpdateLOG.asp"-->

<% 
    Item_Tipe = request.Form("Item_Tipe")
    Item_CatTipe = request.Form("Item_CatTipe")
    Item_Cat_ID = request.Form("Item_Cat_ID")
    Item_Name = request.Form("Item_Name")
    Item_Status = request.Form("Item_Status")
    Item_CAIDD = request.Form("CA_ID")
    Item_CAIDK = request.Form("CA_IK")

        
    set GLItem_CMD = server.CreateObject("ADODB.command")
    GLItem_CMD.activeConnection = MM_pigo_STRING
    GLItem_CMD.commandText = "exec sp_add_GL_M_Item '"& Item_Tipe &"', '"& Item_CatTipe &"','"& Item_Cat_ID &"','"& Item_Name &"','"& Item_Status &"','"& Item_CAIDD &"','"& Item_CAIDK &"','"& session("username") &"'"
    'response.write GLItem_CMD.commandText 
    set GLItem = GLItem_CMD.execute


    Log_ServerID 	= "" 
    Log_Action   	= "CREATE"
    Log_Key         = GLItem("id")
    Log_Keterangan  = "Tambah list Master Kas Masuk/Keluar berdasarkan ID : "& GLItem("id") &" pada : "& Date()
    URL		        = ""

    call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)


    response.redirect "../GL-List-Item/"

%>