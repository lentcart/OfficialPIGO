<!--#include file="../../../../Connections/pigoConn.asp" -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
<%
    if Session("Username")="" then 

    response.redirect("../../../../admin/")
    
    end if
    tgla            = Cdate("2022-09-01")
    tgle            = Cdate("2022-10-31")
    Bulan           = MONTH("2022-09-01")
    Tahun           = YEAR("2022-09-01")
    pdID            = "P072200002"
    

    set SAPD_CMD = server.CreateObject("ADODB.command")
    SAPD_CMD.activeConnection = MM_pigo_STRING
    SAPD_CMD.commandText = "SELECT SAPD_pdID FROM MKT_T_SAPD WHERE SAPD_pdID = '"& pdID &"' and SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' "
    'response.Write SAPD_CMD.commandText & "<br><br>"
    set SAPD = SAPD_CMD.execute

    if SAPD.eof = true then
        SAPD_CMD.commandText = "exec sp_add_MKT_T_SAPD '"& Tahun &"','"& Bulan &"','"& pdID &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
        set SETSAPD = SAPD_CMD.execute

        ' PEMBELIAN
            SAPD_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (YEAR(MKT_T_MaterialReceipt_H.mmTanggal) = '2022') AND (MKT_T_MaterialReceipt_D2.mm_pdID = 'P072200002') AND (MKT_T_MaterialReceipt_H.mmTanggal BETWEEN '9/1/2022' AND '10/24/2022') GROUP BY MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_H.mmTanggal "
            'response.Write SAPD_CMD.commandText & "<br><br>"
            set Pembelian = SAPD_CMD.execute

            do while not Pembelian.eof

                SAPD_CMD.commandText = "SELECT SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima) AS Pembelian,  MKT_M_PIGO_Produk.pdHarga FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MKT_T_MaterialReceipt_D2.mm_pdID = '"& Pembelian("mm_pdID") &"') AND (MKT_T_MaterialReceipt_H.mmTanggal = '"& Pembelian("mmTanggal") &"') GROUP BY MKT_M_PIGO_Produk.pdHarga"
                'response.Write SAPD_CMD.commandText & "<br><br>"
                set SAPD_Pembelian = SAPD_CMD.execute

                    QTY                      = SAPD_Pembelian("Pembelian")
                    Harga                    = SAPD_Pembelian("pdHarga")
                    SAPD_Tanggal             = Day(CDate(Pembelian("mmTanggal")))
                        if len(SAPD_Tanggal) = 1 then
                        SAPD_Tanggal = "0" & SAPD_Tanggal
                        end if
                    SAPD_Bulan               = Month(CDate(Pembelian("mmTanggal")))
                    SAPD_Pembelian           = "SAPD_Pembelian"&SAPD_Tanggal
                    SAPD_HargaPembelian      = "SAPD_HargaPembelian"&SAPD_Tanggal

                SAPD_CMD.commandText    = "UPDATE MKT_T_SAPD SET "& SAPD_Pembelian &"  = '"& QTY &"' , "& SAPD_HargaPembelian &" = '"& Harga &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                'response.Write SAPD_CMD.commandText & "<br><br>"
                set UPDATESAPDPembelian = SAPD_CMD.execute

            Pembelian.Movenext
            loop
        ' PEMBELIAN

        ' PENJUALAN
            SAPD_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_D.Perm_pdID FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '2022') AND (MKT_T_Permintaan_Barang_D.Perm_pdID = 'P072200002') AND (MKT_T_Permintaan_Barang_H.PermTanggal BETWEEN '9/1/2022' AND '10/24/2022') GROUP BY MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_D.Perm_pdID"
            'response.Write SAPD_CMD.commandText & "<br><br>"
            set Penjualan = SAPD_CMD.execute

            do while not Penjualan.eof

                SAPD_CMD.commandText = "SELECT SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty) AS Penjualan, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_pdID = '"& Penjualan("Perm_pdID") &"' AND MKT_T_Permintaan_Barang_H.PermTanggal = '"& Penjualan("PermTanggal") &"' GROUP BY MKT_T_Permintaan_Barang_D.Perm_pdHargaJual"
                'response.Write SAPD_CMD.commandText & "<br><br>"
                set SAPD_Penjualan = SAPD_CMD.execute

                    QTY                      = SAPD_Penjualan("Penjualan")
                    Harga                    = SAPD_Pembelian("Perm_pdHargaJual")
                    SAPD_Tanggal             = Day(CDate(Penjualan("PermTanggal")))
                        if len(SAPD_Tanggal) = 1 then
                        SAPD_Tanggal = "0" & SAPD_Tanggal
                        end if
                    SAPD_Bulan               = Month(CDate(Penjualan("PermTanggal")))
                    SAPD_Penjualan           = "SAPD_Penjualan"&SAPD_Tanggal
                    SAPD_HargaPenjualan      = "SAPD_HargaPenjualan"&SAPD_Tanggal

                SAPD_CMD.commandText    = "UPDATE MKT_T_SAPD SET "& SAPD_Penjualan &"  = '"& QTY &"' , "& SAPD_HargaPenjualan &" = '"& Harga &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                'response.Write SAPD_CMD.commandText & "<br><br>"
                set UPDATESAPDPenjualan = SAPD_CMD.execute

            Penjualan.Movenext
            loop
        ' PENJUALAN

    else
        ' PEMBELIAN
            SAPD_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (YEAR(MKT_T_MaterialReceipt_H.mmTanggal) = '2022') AND (MKT_T_MaterialReceipt_D2.mm_pdID = 'P072200002') AND (MKT_T_MaterialReceipt_H.mmTanggal BETWEEN '9/1/2022' AND '10/24/2022') GROUP BY MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_H.mmTanggal "
            'response.Write SAPD_CMD.commandText & "<br><br>"
            set Pembelian = SAPD_CMD.execute

            do while not Pembelian.eof

                SAPD_CMD.commandText = "SELECT SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima) AS Pembelian,  MKT_M_PIGO_Produk.pdHarga FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MKT_T_MaterialReceipt_D2.mm_pdID = '"& Pembelian("mm_pdID") &"') AND (MKT_T_MaterialReceipt_H.mmTanggal = '"& Pembelian("mmTanggal") &"') GROUP BY MKT_M_PIGO_Produk.pdHarga"
                'response.Write SAPD_CMD.commandText & "<br><br>"
                set SAPD_Pembelian = SAPD_CMD.execute

                    QTY                      = SAPD_Pembelian("Pembelian")
                    Harga                    = SAPD_Pembelian("pdHarga")
                    SAPD_Tanggal             = Day(CDate(Pembelian("mmTanggal")))
                        if len(SAPD_Tanggal) = 1 then
                        SAPD_Tanggal = "0" & SAPD_Tanggal
                        end if
                    SAPD_Bulan               = Month(CDate(Pembelian("mmTanggal")))
                    SAPD_Pembelian           = "SAPD_Pembelian"&SAPD_Tanggal
                    SAPD_HargaPembelian      = "SAPD_HargaPembelian"&SAPD_Tanggal

                SAPD_CMD.commandText = "SELECT "& SAPD_Pembelian &" AS Pembelian , "& SAPD_HargaPembelian &" AS HargaPembelian FROM MKT_T_SAPD WHERE  SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                'response.Write SAPD_CMD.commandText & "<br><br>"
                set SAPDPembelian = SAPD_CMD.execute
                'response.Write SAPDPembelian.eof & "<br><br>"

                if SAPDPembelian.eof = true then

                    Pembelian   = SAPDPembelian("Pembelian")+QTY
                    HargaPembelian  = Harga 

                    SAPD_CMD.commandText = "UPDATE MKT_T_SAPD SET "& SAPD_Pembelian &" = '"& Pembelian &"', "& SAPD_HargaPembelian &" = '"& HargaPembelian &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                    'response.Write SAPD_CMD.commandText & "<br><br>"
                    set UPDATESAPDPembelian = SAPD_CMD.execute

                else
                    SAPD_CMD.commandText = "UPDATE MKT_T_SAPD SET "& SAPD_Pembelian &" = '"& QTY &"', "& SAPD_HargaPembelian &" = '"& Harga &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                    'response.Write SAPD_CMD.commandText & "<br><br>"
                    set UPDATESAPDPembelian = SAPD_CMD.execute
                end if 

            Pembelian.Movenext
            loop
        ' PEMBELIAN

        ' PENJUALAN
            SAPD_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_D.Perm_pdID FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '2022') AND (MKT_T_Permintaan_Barang_D.Perm_pdID = 'P072200002') AND (MKT_T_Permintaan_Barang_H.PermTanggal BETWEEN '9/1/2022' AND '10/24/2022') GROUP BY MKT_T_Permintaan_Barang_H.PermTanggal, MKT_T_Permintaan_Barang_D.Perm_pdID"
            'response.Write SAPD_CMD.commandText & "<br><br>"
            set Penjualan = SAPD_CMD.execute

            do while not Penjualan.eof

                SAPD_CMD.commandText = "SELECT SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty) AS Penjualan, MKT_T_Permintaan_Barang_D.Perm_pdHargaJual FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_pdID = '"& Penjualan("Perm_pdID") &"' AND MKT_T_Permintaan_Barang_H.PermTanggal = '"& Penjualan("PermTanggal") &"' GROUP BY MKT_T_Permintaan_Barang_D.Perm_pdHargaJual"
                'response.Write SAPD_CMD.commandText & "<br><br>"
                set SAPD_Penjualan = SAPD_CMD.execute

                    QTY                      = SAPD_Penjualan("Penjualan")
                    Harga                    = SAPD_Pembelian("Perm_pdHargaJual")
                    SAPD_Tanggal             = Day(CDate(Penjualan("PermTanggal")))
                        if len(SAPD_Tanggal) = 1 then
                        SAPD_Tanggal = "0" & SAPD_Tanggal
                        end if
                    SAPD_Bulan               = Month(CDate(Penjualan("PermTanggal")))
                    SAPD_Penjualan           = "SAPD_Penjualan"&SAPD_Tanggal
                    SAPD_HargaPenjualan      = "SAPD_HargaPenjualan"&SAPD_Tanggal

                SAPD_CMD.commandText = "SELECT "& SAPD_Penjualan &" AS Penjualan , "& SAPD_HargaPenjualan &" AS HargaPenjualan FROM MKT_T_SAPD WHERE  SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                'response.Write SAPD_CMD.commandText & "<br><br>"
                set SAPDPenjualan = SAPD_CMD.execute
                'response.Write SAPDPenjualan.eof & "<br><br>"

                if SAPDPenjualan.eof = true then

                    Penjualan       = SAPDPenjualan("Penjualan")+QTY
                    HargaPenjualan  = Harga 

                    SAPD_CMD.commandText = "UPDATE MKT_T_SAPD SET "& SAPD_Penjualan &" = '"& Penjualan &"', "& SAPD_HargaPenjualan &" = '"& HargaPenjualan &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                    'response.Write SAPD_CMD.commandText & "<br><br>"
                    set UPDATESAPDPenjualan = SAPD_CMD.execute

                else
                    SAPD_CMD.commandText = "UPDATE MKT_T_SAPD SET "& SAPD_Penjualan &" = '"& QTY &"', "& SAPD_HargaPenjualan &" = '"& Harga &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                    'response.Write SAPD_CMD.commandText & "<br><br>"
                    set UPDATESAPDPenjualan = SAPD_CMD.execute
                end if

            Penjualan.Movenext
            loop
        ' PENJUALAN
    end if

    Response.Write "<div class='berhasil' style='padding:5rem 30rem;'><div class='row text-center 'style=' border:2px solid #bff4ff; background-color:#bff4ff; border-radius:20px; padding:10px 20px;box-shadow: 0 4px 10px 0 rgba(46, 46, 46, 0.2), 0 6px 20px 0 rgba(75, 75, 75, 0.19);'> <div class='col-12'><span style='font-family: Poppins, sans-serif; font-weight:bold; color:#079ebd;'> PROSES TELAH SELESAI </span><br><img src='"& base_url &"/Assets/logo/maskotnew.png' width='250'><br><br><a href="& base_url &"/Admin/GL/Closing/unposting.asp?bulan="& Bulan &"&tahun="& Tahun &"&pdID="& pdID &" style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>KARTU STOK</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="& base_url &"/Admin/Laporan/Laporan-Stok/Kartu-Stok/ style='color:white;font-weight:bold;  text-decoration:none; background-color:#079ebd; padding:5px 25px; border-radius:10px'>KEMBALI</a><br><br></div></div></div>"

%>
<script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>



