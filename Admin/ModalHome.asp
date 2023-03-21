    <!-- Modal DashBoard -->
        <!-- The Modal -->
        <div id="myModal" class="modal-GL">

        <!-- Modal content -->
            <div class="modal-content-GL">
                <div class="modal-body-GL">
                    <div class="row mt-3">
                        <div class="col-11">
                            <button class="btn-dashboard"> DASHBOARD MENU   </button>
                            </div>
                            <div class="col-1">
                                <span><i class="fas fa-times closee" id="closee"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="body" style="padding:5px 20px">
                        <div class="row  mb-2 text-center">
                            <div class="col-12">
                                <button class=" dashboard-dropdown dropdown-btn mt-2" >Data<i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Customer/">Customer PIGO</a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Seller/">Seller</a>
                                </div>

                            <button class="dashboard-dropdown dropdown-btn mt-2  " > Produk <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukBaru/">Produk Baru</a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukInfo/">Produk Info</a>
                                    <a class="text-dropdown" href="">Stok Produk</a>
                                </div>

                                <button class="dashboard-dropdown dropdown-btn mt-2 " > Bussines Partner <i class="fa fa-caret-down"></i></button>
                                    <div class="dropdown-ct">
                                        <a class="text-dropdown" href="<%=base_url%>/Admin/BussinesPartner/"> Bussines Partner </a>
                                    </div>
                                    
                                <button class="dashboard-dropdown dropdown-btn mt-2 " > PPN Masukan <i class="fa fa-caret-down"></i></button>
                                    <div class="dropdown-ct">
                                        <a class="text-dropdown" href="<%=base_url%>/Admin/PPN/"> PPh </a>
                                    </div>

                                <button class="dashboard-dropdown dropdown-btn mt-2 " > General Ledger <i class="fa fa-caret-down"></i></button>
                                    <div class="dropdown-ct">
                                    <button class="dashboard-dropdown dropdown-btn mt-2 " style="background-color:#0688af;font-size:12px; margin-left:-2px; width:13.9rem"> Cetak <i class="fa fa-caret-down"></i></button>
                                        <div class="dropdown-ct" style="margin-left:-2px; width:13.9rem">
                                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Cetak Pembukuan </a>
                                        </div>

                                    <button class="dashboard-dropdown dropdown-btn mt-2 " style="background-color:#0688af;font-size:12px; margin-left:-2px; width:13.9rem"> Daftar <i class="fa fa-caret-down"></i></button>
                                        <div class="dropdown-ct" style="margin-left:-2px; width:13.9rem">
                                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Daftar Kas Masuk/Keluar </a>
                                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-KelompokPerkiraan/"> Daftar Kelompok Perkiraan </a>
                                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Daftar Kode Perkiraan </a>
                                        </div>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Kas-Masuk-Keluar/"> Kas Masuk/Keluar </a>
                                </div>

                            <button class="dashboard-dropdown dropdown-btn mt-2 " > Operasional <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/PurchaseOrderDetail/"> Purchase Order </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/MaterialReceiptDetail/"> Material Receipt </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Pembayaran/PaymentRequestDetail/"> Payment Request </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Pembayaran/PaymentDetail/"> Payment </a>
                                </div>

                            <button class="dashboard-dropdown dropdown-btn mt-2 " > Transaksi <i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct">
                                <button class="dashboard-dropdown dropdown-btn mt-2 " style="background-color:#0688af;font-size:12px; margin-left:-2px; width:13.9rem"> Invoice AR <i class="fa fa-caret-down"></i></button>
                                    <div class="dropdown-ct" style="margin-left:-2px; width:13.9rem">
                                        <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Invoice-AR/"> Faktur Penjualan </a>
                                        <a class="text-dropdown" href="<%=base_url%>/Admin/"> Invoice  </a>
                                    </div>

                                <button class="dashboard-dropdown dropdown-btn mt-2 " style="background-color:#0688af;font-size:12px; margin-left:-2px; width:13.9rem"> Invoice AP <i class="fa fa-caret-down"></i></button>
                                    <div class="dropdown-ct" style="margin-left:-2px; width:13.9rem">
                                        <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Invoice-AP/Invoice(Vendor).asp"> Invoice (Vendor) </a>
                                    </div>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/"> Penjualan-WEB </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Penawaran/"> Form Penawaran </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Permintaan-Barang/"> Permintaan Barang </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Pengeluaran-SCB/detail.asp"> Pengeluaran SCB </a>
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/SuratJalan/"> Surat Jalan </a>
                                </div>
                            <button class="dashboard-dropdown dropdown-btn mt-2 " >Laporan<i class="fa fa-caret-down"></i></button>
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

                            <button class="dashboard-dropdown dropdown-btn mt-2 " >User<i class="fa fa-caret-down"></i></button>
                                <div class="dropdown-ct">
                                    <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/Tambah-Produk">User PIGO</a>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        <!-- Modal content -->
    <!-- Modal DashBoard -->