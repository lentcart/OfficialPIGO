<style>
    .dropdown-btn-sidebar:hover {
        color: #0077a2;
        font-weight: 450;
        font-family: "Poppins";
        text-decoration:none;
    }
    .dropdown-btn-sidebar{
        padding: 6px 8px 6px 16px;
        border-bottom: 1px solid #0077a2;
        text-decoration: none;
        font-size: 13px;
        color: black;
        font-weight: 450;
        margin-bottom:7px;
        display: block;
        border: none;
        border-radius:20px;
        background: none;
        font-family: "Poppins";
        width: 100%;
        text-align: left;
        cursor: pointer;
        outline: none;
    }
    .dropdown-ct-sidebar{
        display: none;
        background-color: white;
        padding-left: 8px;
        font-family: "Poppins";
    }
    .text-sidebar{
        padding: 6px 8px 6px 16px;
        text-decoration: none;
        font-size: 12px;
        color: #2d2d2d;
        display: block;
        border: none;
        border-radius:20px;
        background: none;
        font-weight:450;
        font-family: "Poppins";
        width: 100%;
        text-align: left;
        cursor: pointer;
        outline: none;
    }
    .text-sidebar:hover{
        color:#0077a2;
        font-weight: 500;
    }
</style>
    <button class="dropdown-btn-sidebar" >Produk<i class="fa fa-caret-down"></i></button>
    <div class="dropdown-ct-sidebar">
        <a class="text-sidebar" href="<%=base_url%>/Produk/Tambah-Produk/">Tambah Produk</a>
        <a class="text-sidebar" href="<%=base_url%>/Produk/Daftar-Produk/">Daftar Produk</a>
        <a class="text-sidebar" href="<%=base_url%>/Supplier/">Supplier</a>
        <a class="text-sidebar" href="<%=base_url%>/Supplier/Produk-supplier/">Pembelian Produk</a>
    </div>

    <button class="dropdown-btn-sidebar" >Pesanan<i class="fa fa-caret-down"></i></button>
    <div class="dropdown-ct-sidebar">
        <a class="text-sidebar" href="<%=base_url%>/Seller/Pesanan/">Pesanan Toko</a>
        <a class="text-sidebar" href="<%=base_url%>/Seller/Pembatalan/">Pembatalan</a>
    </div>

    <button class="dropdown-btn-sidebar">Keuangan<i class="fa fa-caret-down"></i></button>
    <div class="dropdown-ct-sidebar">
        <a class="text-sidebar" href="#">Penghasilan</a>
        <a class="text-sidebar" href="<%=base_url%>/Seller/Finance/Wallet/">Saldo</a>
        <a class="text-sidebar" href="#">Laporan</a>
    </div>

    <button class="dropdown-btn-sidebar">Laporan<i class="fa fa-caret-down"></i></button>
    <div class="dropdown-ct-sidebar">
        <a class="text-sidebar" href="<%=base_url%>/Seller/Laporan/Lap-Penjualan/">Laporan Penjualan</a>
        <a class="text-sidebar" href="#">Laporan Produk</a>
        <a class="text-sidebar" href="#">Laporan Supplier</a>
        <a class="text-sidebar" href="#">Laporan Pembelian Produk </a>
    </div>
    
<script>
    var dropdown = document.getElementsByClassName("dropdown-btn-sidebar");
    var i;

    for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
            if (dropdownContent.style.display === "block") {
                dropdownContent.style.display = "none";
            } else {
                dropdownContent.style.display = "block";
            }
        });
    }
</script>


