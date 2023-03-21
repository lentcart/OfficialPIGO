<% 
    custEmail = "fitriyani.contact@gmail.com"
    Response.Cookies("custEmail")=custEmail %>

<%= request.cookies("custEmail") %> <BR>
<%= request.cookies("custNama") %> <BR>