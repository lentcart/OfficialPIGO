
<!--#include file="UpdateLOG.asp"-->
<!--#include file="../Connections/pigoConn.asp" -->
<%
    'updateLog system
	Userserveraddress       = Request.ServerVariables("remote_addr")
    Userserverbrowsing      = Request.ServerVariables("http_user_agent")

        Log_ServerID 	=  "["& Userserveraddress & "]" & Userserverbrowsing 
        Log_Action   	= "CREATE"
        Log_Key         = "00656898998"
		Log_Keterangan  = "COBA AJA DULU JALANIN"
		URLS				= ""

		call GetPath(Log_Action,URLS,Log_Key,Log_Keterangan,session("username"),Log_ServerID)
%>