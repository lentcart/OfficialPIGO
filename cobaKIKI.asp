<!DOCTYPE html>
<html>
<body>

<%
    num = 3  
    for i = 1 to num-1
        for j = 1 to i 
            response.Write(" I ")
        next
        response.Write(""& "<br />")
    next
    For i = 1 To num
        For J = num to i step -1
            response.Write(" I ")
        Next
        response.Write(""& "<br />")
    Next
    
%>

</body>
</html>