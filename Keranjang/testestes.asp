
<%

    Dim objHttp
    Set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

    Dim url, payload
    url = "https://api.xendit.co/v2/invoices"
    payload = "{" & _
                    """external_id"" : ""ORDERID-12272200010""," & _
                    """amount"" : 50000," & _
                    """success_redirect_url"" : ""https://www.google.com""," & _
                    """invoice_duration"" : 3600" & _
                    "}"

    objHttp.Open "GET", url, False
    objHttp.setRequestHeader "Content-Type", "application/json"
    objHttp.setRequestHeader "Authorization", "Basic eG5kX2RldmVsb3BtZW50X2p3NzllSVVBTWQwTEdjd1B4S1hDcVdtZU1rVnpnZndJSlQzMlJMTUlvWTFvUjVWTkdqeEFsdmpOWkNHZmxDZDo"
    objHttp.send payload

    strReturn = objHTTP.responseText
    response.write strReturn

    Dim status
    status = objHttp.status

    If status = 200 Then
    ' Success!
    Else
    ' Error occurred.
    End If


    'response.redirect "https://checkout-staging.xendit.co/web/63aa97739a4da7b42dfe1a47"

    

    set Transaksi_CMD = server.createObject("ADODB.COMMAND")
	Transaksi_CMD.activeConnection = MM_PIGO_String

	Transaksi_CMD.commandText = ""
    'response.write Transaksi_CMD.commandText
    set Transaksi = Transaksi_CMD.execute



    ' ' dim Authorization
    ' ' Authorization = "Basic eG5kX2RldmVsb3BtZW50X0ZSQ3JpVGZaVWxxWlJ4ZHhpVVNSa1M4SDlTNGZTT0N6aDJMams5elI1alE4TTVvNnVxSDNpbmRWcWp0Og=="


    ' '     Dim data, httpRequest, postResponse

    ' '     data = "external_id=ORDERID000098"
    ' '     data = data & "&amount=500"

    ' '     Set httpRequest = Server.CreateObject("MSXML2.ServerXMLHTTP")
    ' '     httpRequest.Open "POST", "https://api.xendit.co/v2/invoices", False
    ' '     httpRequest.SetRequestHeader "Authorization", "Basic eG5kX2RldmVsb3BtZW50X2p3NzllSVVBTWQwTEdjd1B4S1hDcVdtZU1rVnpnZndJSlQzMlJMTUlvWTFvUjVWTkdqeEFsdmpOWkNHZmxDZDo"
    ' '     httpRequest.SetRequestHeader "Authorization", "Basic eG5kX2RldmVsb3BtZW50X2p3NzllSVVBTWQwTEdjd1B4S1hDcVdtZU1rVnpnZndJSlQzMlJMTUlvWTFvUjVWTkdqeEFsdmpOWkNHZmxDZDo"
    ' '     httpRequest.Send data

    ' '     postResponse = httpRequest.ResponseText

    ' '     Response.Write postResponse 
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="../js/jquery-3.6.0.min.js"></script>
    </head>
    <body> 

        <!--<form action="https://api.xendit.co/v2/invoices" method="POST">
            <input type="text" name="Authorization" id="Authorization" value="<%'=Authorization%>">
            <input type="text" name="external_id" id="external_id" value="ORDERID83734357">
            <input type="text" name="amount" id="amount" value="50000">
            
            <input type="submit" value="send">
        </form>-->

    </body> 
        <script>
                // var token_ // variable will store the token
                // var userName = "clientID"; // app clientID
                // var passWord = "secretKey"; // app clientSecret
                // var caspioTokenUrl = "https://xxx123.caspio.com/oauth/token"; // Your application token endpoint  
                // var request = new XMLHttpRequest(); 

                // function getToken(url, clientID, clientSecret) {
                //     var key;           
                //     request.open("POST", url, true); 
                //     request.setRequestHeader("Content-type", "application/json");
                //     request.send("grant_type=client_credentials&client_id="+clientID+"&"+"client_secret="+clientSecret); // specify the credentials to receive the token on request
                //     request.onreadystatechange = function () {
                //         if (request.readyState == request.DONE) {
                //             var response = request.responseText;
                //             var obj = JSON.parse(response); 
                //             key = obj.access_token; //store the value of the accesstoken
                //             token_ = key; // store token in your global variable "token_" or you could simply return the value of the access token from the function
                //         }
                //     }
                // }
                // // Get the token
                // getToken(caspioTokenUrl, userName, passWord);

                //     var userName = "xnd_development_FRCriTfZUlqZRxdxiUSRkS8H9S4fSOCzh2Ljk9zR5jQ8M5o6uqH3indVqjt";
                //     var passWord = "";
                // function authenticateUser(user, password)
                // {
                //         var token = userName + ":" + passWord;

                //         // Should i be encoding this value????? does it matter???
                //         // Base64 Encoding -> btoa
                //         var hash = btoa(token); 

                //         console.log(hash);
                // }

                // function CallWebAPI() {

                //     // New XMLHTTPRequest
                //     var request = new XMLHttpRequest();
                //     request.open("POST", "https://api.xendit.co/v2/invoices/", false);
                //     request.setRequestHeader("Authorization", authenticateUser(userName, passWord));  
                //     request.send();
                //     // view request status
                //     alert(request.status);
                //     response.innerHTML = request.responseText;
                // }

                //     const apikey = "xnd_development_FRCriTfZUlqZRxdxiUSRkS8H9S4fSOCzh2Ljk9zR5jQ8M5o6uqH3indVqjt:"
                //     $.ajax({
                //         type: 'POST',
                //         url: 'https://api.xendit.co/v2/invoices/',
                //             data:{
                //                     Authorization: "Basic "+apikey,
                //                     external_id: "invoice-{{$timestamp}}",
                //                     amount: 50000,
                //                 },
                //             traditional: true,
                //             success: function (data) {
                //             console.log(data);
                //             }
                //         });

                // const usrname = "xnd_development_FRCriTfZUlqZRxdxiUSRkS8H9S4fSOCzh2Ljk9zR5jQ8M5o6uqH3indVqjt";
                // const pasword = ""; 
                // $.ajax({
                // type: "POST",
                //     url: "https://api.xendit.co/v2/invoices/",
                //     dataType: 'json',
                //     headers: {
                //         'Accept': 'application/json',
                //         'Content-Type': 'application/json',
                //         "Authorization": "Basic " + (btoa("xnd_development_FRCriTfZUlqZRxdxiUSRkS8H9S4fSOCzh2Ljk9zR5jQ8M5o6uqH3indVqjt:"))
                //     },
                //     data:{
                //             external_id: "556",
                //             amount: 50000,
                //     },
                //     success: function (){
                //         alert('Thanks for your comment!'); 
                //     }
                // });

                // var username   = "xnd_development_FRCriTfZUlqZRxdxiUSRkS8H9S4fSOCzh2Ljk9zR5jQ8M5o6uqH3indVqjt";
                // var password   = ""; 
                // var id         = "I26548484";
                // var total      = 50000;
                // $.ajax({
                // type: "POST",
                //     url: "https://api.xendit.co/v2/invoices/",beforeSend: function (xhr) {
                //         xhr.setRequestHeader ("Authorization", "Basic " + btoa("xnd_development_FRCriTfZUlqZRxdxiUSRkS8H9S4fSOCzh2Ljk9zR5jQ8M5o6uqH3indVqjt:"));
                //         },
                //     dataType: 'json',
                //     data:{
                //             external_id: id,
                //             amount: total
                //     },
                //     success: function (){
                //         alert('Thanks for your comment!'); 
                //     }
                // });

                // // var username = "xnd_development_FRCriTfZUlqZRxdxiUSRkS8H9S4fSOCzh2Ljk9zR5jQ8M5o6uqH3indVqjt";
                // // var password = "";  

                // // function make_base_auth(user, password) {
                // // var tok = user + ':' + password;
                // // var hash = btoa(tok);
                // // return "Basic " + hash;
                // // }
                // // $.ajax
                // // ({
                // //     type: "GET",
                // //     url: "https://api.xendit.co/v2/invoices/",
                // //     dataType: 'json',
                // //     async: false,
                // //     data: '{}',
                // //     beforeSend: function (xhr){ 
                // //         xhr.setRequestHeader('Authorization', make_base_auth(username, password)); 
                // //     },
                // //     success: function (){
                // //         alert('Thanks for your comment!'); 
                // //     }
                // // });

                // fetch('https://reqbin.com/echo/post/json', {
                //     method: 'POST',
                //     headers: {
                //         'Accept': 'application/json',
                //         'Content-Type': 'application/json'
                //     },
                //     body: JSON.stringify({ "id": 78912 })
                // })
                // .then(response => response.json())
                // .then(response => console.log(JSON.stringify(response)))


                
                // var a = btoa("xnd_development_FRCriTfZUlqZRxdxiUSRkS8H9S4fSOCzh2Ljk9zR5jQ8M5o6uqH3indVqjt:");
                // console.log(a);
                // document.getElementById("Authorization").value = "Basic "+a;

                // sessionStorage.setItem("lastname", "Smith");
                // let personName = sessionStorage.getItem("lastname");

                // fetch(`https://api.xendit.co/v2/invoices`, {
                    
                //     method: 'POST',
                //     headers: {
                //         //live
                //         // Authorization: `Basic eG5kX3Byb2R1Y3Rpb25fWW1rODY5c1ZyNFEyb0FDNFg5dWtGUHV0NHlxWjNQc0xtNENRWDN6aldBVzJxYVZOUTBkZ28xaHVDTVJqU3c6`,
                //         //trial
                //         Authorization: `Basic eG5kX2RldmVsb3BtZW50X0ZSQ3JpVGZaVWxxWlJ4ZHhpVVNSa1M4SDlTNGZTT0N6aDJMams5elI1alE4TTVvNnVxSDNpbmRWcWp0Og`,
                //         "Content-type": "application/json",
                //         // Cookie: `incap_ses_7250_2182539=ZRSsQGda+X9zC9bnrSydZI/gs2IAAAAADNKDc2kh+TuuseFKyyn+QQ==; nlbi_2182539=oVMdOnu/QU1Ep6hKjjCKbQAAAADz+5sgFthMBXa+gND7VVZy`
                //     },
                //     body: JSON.stringify({
                //         "external_id": "ORDERID9497436",
                //         "amount": 5000,
                //         // "invoice_duration": 180
                //     })
                // })
                //     .then((res) => {
                //         return res.json();
                //     })
                //     .then((json) => { 
                // })
        </script>
    </body>
</html>