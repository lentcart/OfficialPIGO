<nav id="sidebar"style="background-color:white;">
<div class=" text-center sidebar-header" style="background:#0077a2">
        <span class=""> <img src="<%=base_url%>/assets/logo/5.png" alt="" width="37" height="37"> </span><br>
        <span class="judul-sidebar-header" style="font-size:15px;color:white"> PT. INDAH GEMILANG OETAMA </span><br>
    </div>
    <div class="row mt-3 text-center">
        <div class="col-12">
            <div class="cont-judul-dashboard" >
            <a class="Dashboard" href="<%=base_url%>/Admin/home.asp"><i class="fas fa-home"></i> &nbsp; DASHBOARD HOME </a>
            </div>
        </div>
    </div>
        <div class="dashboard-sidebar mt-2">
            <div class="row">
                <div class="col-12 text-center">
                    <button class=" dashboard-dropdown dropdown-btn mt-2" >Data<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct">
                    
                    <% if session("H2A") = true OR session("H2B") = true then %>
                        <% if session("H2A") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Customer/">Customer PIGO</a>
                        <% end if %>
                        <% if session("H2B") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Seller/">Seller</a>
                        <% end if %>
                    <% else %>
                        <a class="text-dropdown">Tidak Memiliki Akses</a>
                    <% end if %>
                    </div>

                    <button class="dashboard-dropdown dropdown-btn mt-2  " > Product <i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct" style="top:-50px">
                    <% if session("H3A") = true OR session("H3B") = true OR session("H3C") = true then %>
                        <% if session("H3A") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukBaru/">Produk Baru</a>
                        <% end if %>
                        <% if session("H3B") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukInfo/">Produk Info</a>
                        <% end if %>
                        <% if session("H3C") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Produk/ProdukCost/">Produk Cost</a>
                        <% end if %>
                    <% else %>
                        <a class="text-dropdown">Tidak Memiliki Akses</a>
                    <% end if %>
                    </div>

                    <button class="dashboard-dropdown dropdown-btn mt-2 " > Bussines Partner <i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct">
                    <% if session("H4A") = true then %>
                        <% if session("H4A") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/BussinesPartner/"> Bussines Partner </a>
                        <% end if %>
                    <% else %>
                        <a class="text-dropdown">Tidak Memiliki Akses</a>
                    <% end if %>
                    </div>
                                
                    <button class="dashboard-dropdown dropdown-btn mt-2 " > PPN <i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct">
                    <% if Session("H5A") = true then %>
                        <% if session("H5A") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/PPN/"> PPN </a>
                        <% end if %>
                    <% else %>
                        <a class="text-dropdown">Tidak Memiliki Akses</a>
                    <% end if %>
                    </div>

                    <button class="dashboard-dropdown dropdown-btn mt-2 " > General Ledger <i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct">
                    <% if Session("H6A") = true OR  session("H6B") = true OR  session("H6c") = true OR  session("H6D") = true OR  session("H6E") = true then %>
                        <button class="cont-dashboard-dropdown cont-dp-btn "> Cetak <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct" style="margin-left:-10px;">
                        <% if session("H6A1") = true OR session("H6A2") = true OR session("H6A3") = true OR session("H6A4") = true OR session("H6A5") = true OR session("H6A6") = true  then %>
                            <% if session("H6A1") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/home.asp"> Cetak Pembukuan </a>
                            <% end if %>
                            <% if session("H6A2") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Cetak/Buku-Besar/"> Cetak Buku Besar </a>
                            <% end if %>
                            <% if session("H6A3") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Cetak/Neraca-Saldo/"> Cetak Neraca Saldo </a>
                            <% end if %>
                            <% if session("H6A4") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Cetak/Neraca/"> Cetak Neraca </a>
                            <% end if %>
                            <% if session("H6A5") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Cetak/Laba-Rugi/"> Cetak Laba/Rugi</a>
                            <% end if %>
                            <% if session("H6A6") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/home.asp"> Laporan Arus Kas </a>
                            <% end if %>
                            <% if session("H6A7") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Cetak/Kalkulasi-Fiskal/"> Kalkulasi Fiskal </a>
                            <% end if %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Cetak/Ekuitas/"> Laporan Perubahan Ekuitas </a>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Cetak/Rekap-Umur-Piutang/"> Rekap Umur Piutang </a>
                        <% else %>
                            <a class="text-dropdown">Tidak Memiliki Akses</a>
                        <% end if %>
                        </div>

                        <button class="cont-dashboard-dropdown cont-dp-btn"> Daftar <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct" style="margin-left:-10px;">
                        <% if session("H6B1") = true OR session("H6B2") = true OR session("H6B3") = true OR session("H6B4") = true then %>
                            <% if session("H6B1") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Item/"> Daftar Kas Masuk/Keluar </a>
                            <% end if %>
                            <% if session("H6B2") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-KelompokPerkiraan/"> Daftar Kelompok Perkiraan </a>
                            <% end if %>
                            <% if session("H6B3") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-Kode-Perkiraan/"> Daftar Kode Perkiraan </a>
                            <% end if %>
                            <% if session("H6B4") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-List-SaldoAwal-CA/"> Daftar Saldo Awal Perkiraan </a>
                            <% end if %>
                        <% else %>
                            <a class="text-dropdown">Tidak Memiliki Akses</a>
                        <% end if %>
                        </div>
                        <% if session("H6B1") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/GL/GL-Jurnal/"> Jurnal </a>
                        <% end if %>
                        <% if session("H6B1") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Kas-Masuk-Keluar/"> Kas Masuk/Keluar </a>
                        <% end if %>
                        <% if session("H6B1") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/GL/Posting-Jurnal/"> Posting Pembukuan Akhir Bulan </a>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/GL/UN-Posting-Jurnal/"> UN Posting Pembukuan Akhir Bulan </a>
                        <% end if %>
                    <% else %>
                        <a class="text-dropdown">Tidak Memiliki Akses</a>
                    <% end if %>
                    </div>

                    <button class="dashboard-dropdown dropdown-btn mt-2 " > Purchase Management <i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct">
                    <% if Session("H7A") = true OR  session("H7B") = true OR  session("H7C") = true then %>
                        <% if session("H7A") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/PurchaseOrderDetail/"> Purchase Order </a>
                        <% end if %>
                        <% if session("H7B") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/MaterialReceiptDetail/"> Material Receipt </a>
                        <% end if %>
                        <% if session("H7C") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Pembelian/TukarFaktur/"> Tukar Faktur </a>
                        <% end if %>
                        <% if Session("H8A") = true OR session("H8B") = true OR session("H8C") = true OR session("H8D") = true OR session("H8E") = true OR session("H8F") = true OR session("H8G") = true OR session("H8H") = true then %>
                            <button class="cont-dashboard-dropdown cont-dp-btn "> Invoice AP <i class="fa fa-caret-down"></i></button>
                            <div class="dropdown-ct" style="margin-left:-10px;">
                            <% if session("H8B1") = true then %>
                                <% if session("H8B1") = true then %>
                                <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Invoice-AP/Invoice(Vendor).asp"> Invoice (Vendor) </a>
                                <% end if %>
                            <% else %>
                                <a class="text-dropdown">Tidak Memiliki Akses</a>
                            <% end if %>
                            </div>
                        <% end if %>
                    <% else %>
                        <a class="text-dropdown">Tidak Memiliki Akses</a>
                    <% end if %>
                    </div>

                    <button class="dashboard-dropdown dropdown-btn mt-2 " > Sales Management <i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct">
                    <% if Session("H8A") = true OR session("H8B") = true OR session("H8C") = true OR session("H8D") = true OR session("H8E") = true OR session("H8F") = true OR session("H8G") = true OR session("H8H") = true then %>
                                            
                        <% if session("H8D") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Penawaran/"> Form Penawaran </a>
                        <% end if %>
                        <% if session("H8E") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Permintaan-Barang/"> Permintaan Barang </a>
                        <% end if %>
                        <% if session("H8F") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Pengeluaran-SCB/List-PSCB.asp"> Pengeluaran SCB </a>
                        <% end if %>
                        <% if session("H8G") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/SuratJalan/"> Surat Jalan </a>
                        <% end if %>

                        <button class="cont-dashboard-dropdown cont-dp-btn "> Invoice AR <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct" style="margin-left:-10px;" >
                        <% if session("H8A1") = true OR session("H8A2") = true then %>
                            <% if session("H8A1") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Transaksi/Invoice-AR/"> Faktur Penjualan </a>
                            <% end if %>
                            <% if session("H8A2") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/"> Invoice  </a>
                            <% end if %>
                        <% else %>
                            <a class="text-dropdown">Tidak Memiliki Akses</a>
                        <% end if %>
                        </div>
                    <% else %>
                        <a class="text-dropdown">Tidak Memiliki Akses</a>
                    <% end if %>
                    </div>

                    <button class="dashboard-dropdown dropdown-btn mt-2 " >Payment <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-ct">
                        <% if session("H8C1") = true then %>
                            <a class="text-dropdown" href="<%=base_url%>/Admin/Pembayaran/PaymentDetail/"> Payment  </a>
                        <% else %>
                            <a class="text-dropdown">Tidak Memiliki Akses</a>
                        <% end if %>
                        </div>

                    <button class="dashboard-dropdown dropdown-btn mt-2 " >Report<i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct">
                    <% if session("H9A") = true OR session("H9B") = true OR session("H9C") = true OR session("H9D") = true then %>
                        <% if session("H9A") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Laporan-Penjualan/">Laporan Penjualan</a>
                        <% end if %>
                        <% if session("H9B") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Laporan-Pembelian/">Laporan Pembelian</a>
                        <% end if %>
                        <% if session("H9C") = true then %>
                        <a class="text-dropdown" href="<%=base_url%>/Admin/Laporan/Stok/">Stok</a>
                        <% end if %>
                    <% else %>
                        <a class="text-dropdown">Tidak Memiliki Akses</a>
                    <% end if %>
                    </div>

                    <button class="dashboard-dropdown dropdown-btn mt-2 " ><i class="fas fa-user-check"></i> &nbsp; <%=session("username")%><i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-ct">
                        <a class=" text-dropdown dashboard-dropdown-menu dropdown-item" href="<%=base_url%>/admin/LogoutUser.asp"><i class="fas fa-sign-out-alt"></i> &nbsp; Log Out</a>
                        <a class=" text-dropdown dashboard-dropdown-menu dropdown-item" href="<%=base_url%>/admin/Ubah-Password/"><i class="fas fa-lock"></i>&nbsp; Ubah Password </a>
                        <a class=" text-dropdown dashboard-dropdown-menu dropdown-item" href="<%=base_url%>/admin/LogoutUser.asp"><i class="fab fa-shopify"></i> &nbsp; Website Official PIGO</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</nav>
