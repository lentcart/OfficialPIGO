<!--#include file="../../../../Connections/pigoConn.asp" -->
<!--#include file="../../../../UpdateLOG/UpdateLOG.asp"-->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">

<%
        Cat_ID       = request.Form("Cat_ID")
        Cat_Name     = request.Form("Cat_Name")
        Cat_Tipe     = request.Form("Cat_Tipe")

        set  GL_M_CategoryItem_CMD = server.createObject("ADODB.COMMAND")
        GL_M_CategoryItem_CMD.activeConnection = MM_PIGO_String
        GL_M_CategoryItem_CMD.commandText = "INSERT INTO [dbo].[GL_M_CategoryItem_PIGO]([Cat_ID],[Cat_Name],[Cat_Tipe],[Cat_AktifYN],[Cat_UpdateID],[Cat_UpdateTime])VALUES('"& Cat_ID &"','"& Cat_Name &"','"& Cat_Tipe  &"','Y','"& session("username") &"','"& now() &"') "
        set CatItem =  GL_M_CategoryItem_CMD.execute

        Log_ServerID 	= "" 
        Log_Action   	= "ADD"
        Log_Key         = Cat_ID
        Log_Keterangan  = "Tambah Daftar Kategori Item ID : "& Cat_ID &" Tipe = "& Cat_Tipe &" pada : "& Date()
        URL		        = ""

        call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

        Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid white; background-color:white; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#0077a2;'> DATA BERHASIL DITAMBAHKAN </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/GL/GL-List-KelompokPerkiraan/GL-CatItem/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#0077a2; padding:5px 25px; border-radius:10px'>KEMBALI</a></div></div></div>"

%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
