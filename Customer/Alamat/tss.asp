<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>
<script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
<script >
$(document).ready(function () {
//change selectboxes to selectize mode to be searchable
   $("select").select2();
});</script>

</head>
<body>
  <select id="select_page" style="width:200px;" class="operator"> 
         <option value="">Select a Page...</option>
         <option value="alpha">alpha</option> 
         <option value="beta">beta</option>
         <option value="theta">theta</option>
         <option value="omega">omega</option>
  </select>
</body>
</html>