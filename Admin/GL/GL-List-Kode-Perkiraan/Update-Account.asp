<!--#include file="../../../Connections/pigoConn.asp" -->

<%
    if Session("Username")="" then 

    response.redirect("../../../admin/")
    
    end if

        set GL_M_GL_M_ChartAccount_cmd = server.createObject("ADODB.COMMAND")
        GL_M_GL_M_ChartAccount_cmd.activeConnection = MM_PIGO_String
        GL_M_GL_M_ChartAccount_cmd.commandText = "SELECT * FROM GL_M_ChartAccount WHERE CA_Type = 'H'"
        set CID = GL_M_GL_M_ChartAccount_cmd.execute

%>