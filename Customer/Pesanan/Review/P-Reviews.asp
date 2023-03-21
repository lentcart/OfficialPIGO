<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

trID = request.queryString("trID")
tr_pdID = request.queryString("pdID")
tr_pdHarga = request.queryString("harga")
tr_custID = request.queryString("custID")
tr_slID = request.queryString("slID")
ReviewProduk = request.queryString("ulasan")

set reviews_CMD = server.CreateObject("ADODB.command")
reviews_CMD.activeConnection = MM_pigo_STRING

reviews_CMD.commandText = "INSERT INTO [dbo].[MKT_T_Reviews] ([trID],[tr_pdID],[tr_pdHarga],[tr_custID],[tr_slID],[ReviewTanggal],[ReviewProduk],[RUpdateTime],[RAktifYN]) VALUES ('"& trID &"','"& tr_pdID &"',"& tr_pdHarga &",'"& tr_custID &"','"& tr_slID &"','"& date() &"','"& ReviewProduk &"','"& now() &"','Y')"
'Response.Write reviews_CMD.commandText
reviews_CMD.execute

response.redirect "../"

%> 