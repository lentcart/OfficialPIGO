
<% response.buffer=false
server.ScriptTimeout=300000
%>

	<%
	' keharusan user login sebelum masuk ke menu utama aplikasi
	if session("custEmail") = "" then
	response.Redirect("../../../")
	end if
	%>
	
<!--#include file="../../../connections/pigoConn.asp"--> 


<html>
<head>

	<title>Print Label</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<style media="screen" type="text/css">/*<![CDATA[*/@import 'css/stylesheet.css';/*]]>*/</style>
	<!-- QR -->
	<script src="jquery.min.js"></script>
	<script type="text/javascript" src="jquery.qrcode.js"></script>
	<script type="text/javascript" src="qrcode.js"></script>

	<script type="text/javascript">

		function printpage() {
			//Get the print button and put it into a variable
			var printButton = document.getElementById("divprintpagebutton");
			//Set the print button visibility to 'hidden' 
		   printButton.style.visibility = 'hidden';
		   
			//Print the page content
			window.print()
			//Set the print button to 'visible' again 
			//[Delete this line if you want it to stay hidden after printing]
			printButton.style.visibility = 'visible';
				   
		}
	</script>

	<style type="text/css">
		@font-face
		{
		   font-family:Code39;
		   src:url(css/free3of9.ttf);
		   src:url(css/FREE3OF9.woff);
		}
	<!--
		@media screen(min-resolution: 300pi){
		img{
			image-resolution: 300dpi; 
			width: 50%;
			height: auto;
		}
		}
	-->

		.font
		{
			font-family:"Free 3 of 9 Regular";
			font-size: 23px;
			margin: 0;
			
		}



	
	
		.wrap-barcode{
			width: 280px;
			height: 192px;
			/* border: 1px dotted #111111; */
			margin: 5px;
			margin-top:2px
			display: block;

					
		}
		.barcode{
			width: 300px;
			height: 40px;
			margin: 0;
			
		
					
		}
		body, span, h1, h2, h3, h4{
			margin: 5px;
		
		}
		p, hr{
			margin: 0;
			padding: 0;
		
		
		}
		
		
		
		.image-icon{
			width: 50%;
			
		}
		.new_logo{
			width: 100%;
			
		}
	#divprintpagebutton
	{
		position:fixed;
		top:1%;
		right:1%;
		background-color:#00F;
		padding-top:2%;
		margin: 10px;
		width:35%;
		text-align:center;
		color:#FF0;
		z-index:2;
	}
	table{
			width: 100%;
	
		}
		.row{
			margin-top:5px;
			margin-bottom:15px;
		}
	</style>


</head>

<body>


		<% 
			dim b
			b=request.QueryString("jmlbarcode")
			pdID = request.QueryString("pdID")
			
			dim i
			i=0

			dim btt
			dim btt_cmd

			set btt_cmd = server.CreateObject("ADODB.Command")
			btt_cmd.activeConnection = MM_PIGO_String
		   
				
			btt_cmd.commandText = "SELECT * FROM [PIGO].[dbo].[MKT_T_ProdukD] where pdID = '"& pdID &"' order by StokID desc"	

			'response.write btt_cmd.commandText
			'response.write b & "<BR>"
			set btt = btt_cmd.execute

			if btt.eof = true then 
			i=1
			else
				if len(btt("stokID")) <= 0 then
					i = 1
				else
					i=right(btt("StokID"),16)
				end if
			end if

			'response.write i & "<BR>"
			do while not b <= 0

			StokIDbc =  pdID & right("00" & month(now()),2) & right("00" & year(now()),2)  & right("0000000000000000" & i,16)
			
			'response.write StokIDbc & "<BR>"

		
				
				
			
			
		%>

		<div class="row">
			<div class="wrap-barcode mt-4" >
		
					
					<span style="font-size: 12px; text-align:center;">
						PD.ID :  <%=pdID%> <br/> 
					</span> 	
					
					<table width="100%">
						<tr>	
							
							<td width="60%" align="right">
								<p style="font-size: 12px;"><%=StokIDbc%></p>
								<p class="font">*<%=ucase(StokIDbc)%>*</p>
								<p class="font">*<%=ucase(StokIDbc)%>*</p>
								<p style="font-size: 12px;">OTOPIGO OFFICIAL STOCK</p>
								
								
							</td>
							<td width="40%" align="center">
							
								<p style="font-size: 24px;"></p>
								<p style="font-size: 10px;"></p>
								<p style="font-size: 9px;"></p>
							
							</td>
							
							
						
						
						</tr>
					
					</table>
					 
					
				
				<table width="100%" >
						<tr>
						<td width="40%" align="right">
								<div id="qrcodeCanvas<%=StokIDbc%>" ></div>
								<script>
									jQuery('#qrcodeCanvas'+'<%=StokIDbc%>').qrcode({
										text	: "<%=StokIDbc%>"
									});	
								</script>
							</td>
							
						
							<td width="60%" align="left">
								
								<p style="font-size: 11px;">No. SKU :</p>
								<p><b style="font-size: 10px;"> <%'=btt("SKU") %></b></p>
								
							
								<table width="100%" >
									<tr>
										
										<td width="50%" align="left">
										
											<img src="../../../assets/logo.png" alt="Logo PIGO" class="new_logo" style="width: 80%;">
											<br />
											<p style="font-size: 12px;">www.pigo.com</p>
											
										</td>
										<td width="40%" align="right">
											<img src="up_icon.png" alt="BTT Barcode" class="image-icon" >
										</td>
									</tr>
								</table>
							
								
								
							
							</td>
						
						
						</tr>
					</table>
					
				
					
					
					
					
					
				
					
				
				
			</div>
		</div>
		
	
	<%
		i = CInt(i) + 1
		
			b = b - 1
			loop
	%>	
	

		
	
	

	<div id="divprintpagebutton">
		
		<h2> KLIK CETAK BARCODE DENGAN PRINT ZEBRA </h2>
	
	
		<input type="button" name="printpagebutton" id="printpagebutton" value="CETAK BARCODE" onClick="printpage()" />	
		<br />
		<br />

	</div>
	

			
	
</body>
</html>

