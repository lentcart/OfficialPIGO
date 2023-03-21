
<%
    
    function GetPath(Log_Action,URLS,Log_Key,Log_Keterangan,Log_User,Log_ServerID)

        x   = "http" 
            If  lcase(request.ServerVariables("HTTPS"))<> "off" Then 
                x = "https" 
            End If

        query_string = request.ServerVariables("QUERY_STRING")

        if query_string <> "" then
            query_string = "?" & query_string
        end if
    
        GetPath = x & "://" & request.ServerVariables("SERVER_NAME") & request.ServerVariables("URL") & query_string

        dim UpdateLOG_CMD
        dim UpLOG

        Userserveraddress       = Request.ServerVariables("remote_addr")
        Userserverbrowsing      = Request.ServerVariables("http_user_agent")
        Log_ServerID 	        = "["& Userserveraddress & "]" & Userserverbrowsing 

        set UpdateLOG_CMD = server.CreateObject("ADODB.command")
        UpdateLOG_CMD.activeConnection = MM_pigo_STRING

        UpdateLOG_CMD.commandText = "exec sp_add_PIGO_T_LOG '"& Log_Action &"', '"& GetPath &"', '"& Log_Key &"', '"& Log_Keterangan &"', '"& session("username") &"', '"& Log_ServerID &"'"
        'response.write UpdateLOG_CMD.commandText
        set UpLOG = UpdateLOG_CMD.execute

    end function
%>