
        <div class="side">
            <div class="s" style="height:37rem; overflow-y:scroll;overflow-x:hidden">
                <div class="row items-align-center"> 
                    <div class="col-12" >
                        <div class="row text-center" style="border-bottom:1px solid white; padding: 3px ;">
                            <div class="col-12">
                                <span class=" mt-3 judul-side mt-4  text-center"> Official PIGO</span>
                            </div>
                        </div>
                        <div class="row mt-2 Dashboard text-center" style=" background-color:white; padding: 5px; whidth:100%">
                            <div class="col-12">
                                <a href="<%=base_url%>/Admin/dashboard.asp" class="judul-side" style="font-size:12px; color:#10a5d3;"> Dashboard Home </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <button class="dropdown-btn mt-2" >Data<i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Customer/">Customer PIGO</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Seller/">Seller</a>
                        </div>
                    <button class="dropdown-btn " > Produk <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukBaru/">Produk Baru</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukInfo/">Produk Info</a>
                            <a class="text-dropdown" href="">Stok Produk</a>
                        </div>
                    <button class="dropdown-btn " > Bussines Partner <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/BussinesPartner/"> Bussines Partner </a>
                        </div>
                    <button class="dropdown-btn " > PPN Masukan <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/PPN/"> PPh </a>
                        </div>
                    <button class="dropdown-btn " > General Ledger <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <button class="dropdown-btn " style="background-color:#0688af;font-size:12px; margin-left:-8px; width:13.9rem"> Cetak <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct" style="margin-left:-8px; width:13.9rem">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Cetak Pembukuan </a>
                                </div>
                            <button class="dropdown-btn " style="background-color:#0688af;font-size:12px; margin-left:-8px; width:13.9rem"> Daftar <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct" style="margin-left:-8px; width:13.9rem">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Daftar Kas Masuk/Keluar </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-KelompokPerkiraan/"> Daftar Kelompok Perkiraan </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Daftar Kode Perkiraan </a>
                                </div>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Kas-Masuk-Keluar/"> Kas Masuk/Keluar </a>
                        </div>
                    <button class="dropdown-btn " > Operasional <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/PurchaseOrderDetail/"> Purchase Order </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/MaterialReceiptDetail/"> Material Receipt </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pembayaran/PaymentRequestDetail/"> Payment Request </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pembayaran/PaymentDetail/"> Payment </a>
                        </div>
                    <button class="dropdown-btn " > Transaksi <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                        <button class="dropdown-btn " style="background-color:#0688af;font-size:12px; margin-left:-8px; width:13.9rem"> Invoice AR <i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct" style="margin-left:-8px; width:13.9rem">
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Invoice-AR/"> Faktur Penjualan </a>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/"> Invoice  </a>
                            </div>
                        <button class="dropdown-btn " style="background-color:#0688af;font-size:12px; margin-left:-8px; width:13.9rem"> Invoice AP <i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct" style="margin-left:-8px; width:13.9rem">
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Invoice-AP/Invoice(Vendor).asp"> Invoice (Vendor) </a>
                            </div>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/"> Penjualan-WEB </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Penawaran/"> Form Penawaran </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Permintaan-Barang/"> Permintaan Barang </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Pengeluaran-SCB/detail.asp"> Pengeluaran SCB </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/SuratJalan/"> Surat Jalan </a>
                            
                        </div>
                    <button class="dropdown-btn " >Laporan<i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Lap-Penjualan/">Laporan Penjualan</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Lap-Pembelian/">Laporan Pembelian</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/Daftar-Produk/">Laporan Barang</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Lap-Stok/">Laporan Stok</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Kartu-Stok/index.asp">Kartu Stok</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/">Laporan Laba Rugi</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/Produk-supplier/">Laporan Pemasukan</a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Supplier/Produk-supplier/">Laporan Pengeluaran</a>
                        </div>
                    <button class="dropdown-btn " >User<i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/Tambah-Produk">User PIGO</a>
                        </div>
                </div>
            </div>
            <div class="row mt-2 Dashboard text-center" style=" background-color:white; padding: 5px; whidth:100%">
                <div class="col-12">
                    <a href="<%=base_url%>/" class="judul-side" style="font-size:12px; color:#10a5d3;"> Website Official PIGO </a>
                </div>
            </div>
        </div>
    </div>
    <script>
        var dropdown = document.getElementsByClassName("dropdown-btn");
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