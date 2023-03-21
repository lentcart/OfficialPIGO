<script>
    $(document).ready(function() {
        document.getElementById("tahun").innerHTML  = new Date().getFullYear();
    });
</script>
<div class="cont-footer" style="width:100%; margin:0px; padding:10px 20px; background-color:none; margin-bottom:0px; z-index: 999;">
    <div class="row">
        <div class="col-10">
            <span class="txt-pesanan"><b>©</b></span> <span class="txt-pesanan" id="tahun"> </span><span class="txt-pesanan"><b> - OFFICIAL PIGO </b></span> 
        </div>
        <div class="col-2">
            <a href="goo"><img src="<%=base_url%>/assets/help/google.png" width="90" /></a>
            <a href="ios"><img src="<%=base_url%>/assets/help/ios.png" width="90" /></a>
        </div>
    </div>
</div>    