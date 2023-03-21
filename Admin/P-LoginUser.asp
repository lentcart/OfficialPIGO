<!--#include file="../SecureString.asp" -->
<!--#include file="../connections/pigoConn.asp"--> 
<!--#include file="../md5.asp" -->
<!--#include file="../UpdateLOG/UpdateLOG.asp"-->

<% 

    userName                = request.form("username")
    userPassword            = md5(request.form("password"))
    userSection             = request.form("usersection")
    Userserveraddress       = Request.ServerVariables("remote_addr")
    Userserverbrowsing      = Request.ServerVariables("http_user_agent")

    set LoginUser_CMD = server.CreateObject("ADODB.command")
    LoginUser_CMD.activeConnection = MM_pigo_STRING

    LoginUser_CMD.commandText = "select * from WebLogin where Username  = '"& userName &"' "
    response.Write LoginUser_CMD.commandText & "<br><br>"
    set LoginUser = LoginUser_CMD.execute
    
    if LoginUser.eof = False then

        if userPassword <> LoginUser("Password") then 
            Response.redirect "index.asp?x=ER04hfRR85nz6xc3548hfi73fd"
        else 
            if userSection <> LoginUser("Usersection") then 
                Response.redirect "index.asp?e=ER04hvfdgh3h684hhnth987uiu"
            end if 
        end if

        LoginUser_CMD.commandText = "SELECT AppRights FROM WebRights WHERE UserName = '"& UserName &"' and UserSection = '"& userSection &"' "
        set LoginRights = LoginUser_CMD.execute

        do while not LoginRights.eof

            Session(LoginRights("AppRights")) = true

        LoginRights.moveNext
        loop

        LoginUser_CMD.commandText = "UPDATE WebLogin SET UserserverID = '"& "["& Userserveraddress & "]" & Userserverbrowsing &"' , Userlastlogin = '"& now() &"' , UserUpdateTime = '"& now() &"' WHERE UserID = '"& LoginUser("UserID") &"' and Username = '"& userName &"' and Usersection = '"& userSection &"' "
        response.Write LoginUser_CMD.commandText & "<br><br>"
        set UpdateLoginUser = LoginUser_CMD.execute

        user                    = LoginUser("Username")
        usersection             = LoginUser("Usersection")
        Session("Username")     = user
        Session("Usersection")  = Usersection

            Log_ServerID 	= "["& Userserveraddress & "]" & Userserverbrowsing 
            Log_Action   	= "LOGIN"
            Log_Key         = LoginUser("UserID")
            Log_Keterangan  = session("username") & " LOGIN WEB PIGO BACKEND PADA " & now()
            URL		    = ""

            call GetPath(Log_Action,URL,Log_Key,Log_Keterangan,session("username"),Log_ServerID)

        if loginUser("username") = "administrator" then

            user                    = LoginUser("username")
            Session("username")     = user

            Response.redirect "../hakakses/"
            
        else

            Response.redirect "../Admin/home.asp"


        end if
    else
        Response.redirect "index.asp?b=ER04hvfdgh3h684hhnth987uiu"
    end if

    
%> 