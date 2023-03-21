<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 

    response.redirect("../../../../admin/")
    
    end if
    SAPD_Tgla      = CDate("2022-10-01")
    SAPD_Tgle      = CDate("2022-10-31")
    Bulan     = MONTH(CDate("2022-10-01"))
    Tahun     = YEAR(CDate("2022-10-01"))
    
    set Stok_CMD = server.CreateObject("ADODB.command")
    Stok_CMD.activeConnection = MM_pigo_STRING
    set SAPD_CMD = server.CreateObject("ADODB.command")
    SAPD_CMD.activeConnection = MM_pigo_STRING

    Stok_CMD.commandText = "SELECT pdID, pdNama, pdHarga, (SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MKT_T_MaterialReceipt_H.mmTanggal BETWEEN '2022-10-01' AND '2022-10-30' ) AND (YEAR(MKT_T_MaterialReceipt_H.mmTanggal) = '2022') AND (MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID)) AS Pembelian, (SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty), 0) AS Penjualan FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MKT_T_Permintaan_Barang_H.PermTanggal BETWEEN '2022-10-01' AND '2022-10-30' ) AND (YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '2022') AND (MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID)) AS Penjualan FROM MKT_M_PIGO_Produk WHERE ((SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MKT_T_MaterialReceipt_H.mmTanggal BETWEEN '2022-10-01' AND '2022-10-30' ) AND (YEAR(MKT_T_MaterialReceipt_H.mmTanggal) = '2022') AND (MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID)) <> 0) OR ((SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty), 0) AS Penjualan FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MKT_T_Permintaan_Barang_H.PermTanggal BETWEEN '2022-10-01' AND '2022-10-30' ) AND (YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '2022') AND (MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID)) <> 0) ORDER BY pdID"
    response.Write Stok_CMD.commandText & "<br><br>"
    set Stok = Stok_CMD.execute

    do while not Stok.eof

        pdID                        = Stok("pdID")

        SAPD_CMD.commandText = "SELECT * FROM MKT_T_SAPD WHERE SAPD_pdID = '"& pdID &"' and SAPD_Tahun = '"& Tahun &"' "
        response.Write SAPD_CMD.commandText & "<br><br>"
        set SAPD = SAPD_CMD.execute
        
        if SAPD.eof = true then
            'Pembelian

                Stok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_D2.mm_pdID = '"& pdID &"' AND (MKT_T_MaterialReceipt_H.mmTanggal BETWEEN '"& SAPD_Tgla &"' AND '"& SAPD_Tgle &"' ) AND YEAR(MKT_T_MaterialReceipt_H.mmTanggal ) = '"& Tahun &"' ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC "
                response.Write Stok_CMD.commandText & "<br><br>"
                set Pembelian = Stok_CMD.execute

                do while not Pembelian.eof

                    SAPD_Tanggal                = Day(CDate(Pembelian("mmTanggal")))
                        if len(SAPD_Tanggal)    = 1 then
                        SAPD_Tanggal = "0" & SAPD_Tanggal
                        end if
                    SAPD_Pembelian             = "SAPD_Pembelian"&SAPD_Tanggal
                    SAPD_HargaPembelian        = "SAPD_HargaPembelian"&SAPD_Tanggal

                    SAPD_CMD.commandText = "exec sp_add_MKT_T_SAPD '"& Tahun &"','"& Bulan &"','"& Pembelian("mm_pdID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                    response.Write SAPD_CMD.commandText & " Pembelian<br><br>"
                    set SETPembelian = SAPD_CMD.execute

                    SAPD_CMD.commandText    = "UPDATE [dbo].[MKT_T_SAPD] SET "& SAPD_Pembelian &"  = '"& Pembelian("mm_pdQty") &"', "& SAPD_HargaPembelian &" = '"& Pembelian("mm_pdHarga") &"'  WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_pdID = '"& Pembelian("mm_pdID")  &"' AND SAPD_Bulan = '"& Bulan &"' "
                    response.Write SAPD_CMD.commandText & "<br><br>"
                    set UPPembelian = SAPD_CMD.execute

                Pembelian.movenext
                loop
            'Pembelian

            'Penjualan
                Stok_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty,  MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_pdID = '"& pdID &"' AND (MKT_T_Permintaan_Barang_H.PermTanggal BETWEEN '"& SAPD_Tgla &"' AND '"& SAPD_Tgle &"' ) AND YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '"& Tahun &"' ORDER BY MKT_T_Permintaan_Barang_H.PermTanggal ASC "
                response.Write Stok_CMD.commandText & "<br><br>"
                set Penjualan = Stok_CMD.execute

                do while not Penjualan.eof

                    SAPD_Tanggal                = Day(CDate(Penjualan("PermTanggal")))
                        if len(SAPD_Tanggal)    = 1 then
                        SAPD_Tanggal = "0" & SAPD_Tanggal
                        end if
                    SAPD_Penjualan             = "SAPD_Penjualan"&SAPD_Tanggal
                    SAPD_HargaPenjualan        = "SAPD_HargaPenjualan"&SAPD_Tanggal 

                    SAPD_CMD.commandText = "exec sp_add_MKT_T_SAPD '"& Tahun &"','"& Bulan &"','"& Penjualan("Perm_pdID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                    response.Write SAPD_CMD.commandText & "Penjualan<br><br>"
                    set SETPenjualan = SAPD_CMD.execute

                    SAPD_CMD.commandText    = "UPDATE [dbo].[MKT_T_SAPD] SET "& SAPD_Penjualan &"  = '"& Penjualan("Perm_pdQty") &"', "& SAPD_HargaPenjualan &" = '"& Penjualan("Perm_pdHargaJual") &"'  WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_pdID = '"& Penjualan("Perm_pdID")  &"' AND SAPD_Bulan = '"& Bulan &"' "
                    response.Write SAPD_CMD.commandText & "<br><br>"
                    set UPPenjualan = SAPD_CMD.execute

                Penjualan.movenext
                loop

            'Penjualan
        else
            'Pembelian

                Stok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_D2.mm_pdID = '"& pdID &"' AND (MKT_T_MaterialReceipt_H.mmTanggal BETWEEN '"& SAPD_Tgla &"' AND '"& SAPD_Tgle &"' ) AND YEAR(MKT_T_MaterialReceipt_H.mmTanggal ) = '"& Tahun &"' ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC "
                response.Write Stok_CMD.commandText & "<br><br>"
                set Pembelian = Stok_CMD.execute

                do while not Pembelian.eof

                    SAPD_Tanggal                 = Day(CDate(Pembelian("mmTanggal")))
                        if len(SAPD_Tanggal)    = 1 then
                        SAPD_Tanggal = "0" & SAPD_Tanggal
                        end if
                    SAPD_Pembelian             = "SAPD_Pembelian"&SAPD_Tanggal
                    SAPD_HargaPembelian        = "SAPD_HargaPembelian"&SAPD_Tanggal

                    SAPD_CMD.commandText    = "UPDATE [dbo].[MKT_T_SAPD] SET "& SAPD_Pembelian &"  = '"& Pembelian("mm_pdQty") &"', "& SAPD_HargaPembelian &" = '"& Pembelian("mm_pdHarga") &"'  WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_pdID = '"& Pembelian("mm_pdID")  &"' AND SAPD_Bulan = '"& Bulan &"' "
                    response.Write SAPD_CMD.commandText & "<br><br>"
                    set UPPembelian = SAPD_CMD.execute

                Pembelian.movenext
                loop
            'Pembelian

            'Penjualan
                Stok_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty,  MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_pdID = '"& pdID &"' AND (MKT_T_Permintaan_Barang_H.PermTanggal BETWEEN '"& SAPD_Tgla &"' AND '"& SAPD_Tgle&"' ) AND YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '"& Tahun &"' ORDER BY MKT_T_Permintaan_Barang_H.PermTanggal ASC "
                response.Write Stok_CMD.commandText & "<br><br>"
                set Penjualan = Stok_CMD.execute

                do while not Penjualan.eof

                    SAPD_Tanggal                 = Day(CDate(Penjualan("PermTanggal")))
                        if len(SAPD_Tanggal)    = 1 then
                        SAPD_Tanggal = "0" & SAPD_Tanggal
                        end if
                    SAPD_Penjualan             = "SAPD_Penjualan"&SAPD_Tanggal
                    SAPD_HargaPenjualan        = "SAPD_HargaPenjualan"&SAPD_Tanggal 

                    SAPD_CMD.commandText    = "UPDATE [dbo].[MKT_T_SAPD] SET "& SAPD_Penjualan &"  = '"& Penjualan("Perm_pdQty") &"', "& SAPD_HargaPenjualan &" = '"& Penjualan("Perm_pdHargaJual") &"'  WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_pdID = '"& Penjualan("Perm_pdID")  &"' AND SAPD_Bulan = '"& Bulan &"' "
                    response.Write SAPD_CMD.commandText & "<br><br>"
                    set UPPenjualan = SAPD_CMD.execute

                Penjualan.movenext
                loop

            'Penjualan
        end if 
    response.flush
    Stok.movenext
    loop

    ' do while not Stok.eof
    '     pdID                        = Stok("pdID")

    '     SAPD_Bulan                 = MONTH(CDate("2022-10-01"))
    '         if len(SAPD_Tanggal)    = 1 then
    '         SAPD_Tanggal = "0" & SAPD_Tanggal
    '         end if
    '     SAPD_Pembelian             = "SAPD_Pembelian"&SAPD_Bulan
    '     SAPD_HargaPembelian        = "SAPD_HargaPembelian"&SAPD_Bulan
    '     SAPD_Penjualan             = "SAPD_Penjualan"&SAPD_Bulan
    '     SAPD_HargaPenjualan        = "SAPD_HargaPenjualan"&SAPD_Bulan

    '     SAPD_CMD.commandText = "SELECT * FROM MKT_T_SAPD WHERE SAPD_pdID = '"& pdID &"' and SAPD_Tahun = '"& Tahun &"' "
    '     response.Write SAPD_CMD.commandText & "<br><br>"
    '     set SAPD = SAPD_CMD.execute

    '     if SAPD.eof = true then

    '         'Pembelian
    '             Stok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_D2.mm_pdID = '"& pdID &"' AND MKT_T_MaterialReceipt_H.mmTanggal BETWEEN '"& SAPD_Tgla &"' AND '"& SAPD_Tgle &"' ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC "
    '             response.Write Stok_CMD.commandText & "<br><br>"
    '             set Pembelian = Stok_CMD.execute

    '             do while not Pembelian.eof

    '                 SAPD_CMD.commandText = "exec sp_add_MKT_T_SAPD '"& Tahun &"','"& Pembelian("mmTanggal") &"','"& Pembelian("mm_pdID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
    '                 set SETPembelian = SAPD_CMD.execute

    '                 SAPD_CMD.commandText    = "UPDATE MKT_T_SAPD SET "& SAPD_Pembelian &"  = '"& Pembelian("mm_pdQty") &"', "& SAPD_HargaPembelian &" = '"& Pembelian("mm_pdHarga") &"'  WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_pdID = '"& Pembelian("mm_pdID")  &"' AND SAPD_Tanggal = '"& Pembelian("mmTanggal") &"' "
    '                 response.Write SAPD_CMD.commandText & "<br><br>"
    '                 set UPPembelian = SAPD_CMD.execute

    '             Pembelian.movenext
    '             loop
    '         'Pembelian

    '         'Penjualan
    '             Stok_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty,  MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_pdID = '"& pdID &"' AND MONTH(MKT_T_Permintaan_Barang_H.PermTanggal) = '"& Bulan &"' ORDER BY MKT_T_Permintaan_Barang_H.PermTanggal ASC "
    '             response.Write Stok_CMD.commandText & "<br><br>"
    '             set Penjualan = Stok_CMD.execute

    '             do while not Penjualan.eof

    '                 SAPD_CMD.commandText = "exec sp_add_MKT_T_SAPD '"& Tahun &"','"& Penjualan("PermTanggal") &"','"& Penjualan("Perm_pdID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
    '                 set SETPenjualan = SAPD_CMD.execute

    '                 SAPD_CMD.commandText    = "UPDATE MKT_T_SAPD SET "& SAPD_Penjualan &"  = '"& Penjualan("Perm_pdQty") &"', "& SAPD_HargaPenjualan &" = '"& Penjualan("Perm_pdHargaJual") &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_pdID = '"& Penjualan("Perm_pdID") &"' AND SAPD_Tanggal = '"& Penjualan("PermTanggal") &"'"
    '                 response.Write SAPD_CMD.commandText & "<br><br>"
    '                 set UPPenjualan = SAPD_CMD.execute

    '             Penjualan.movenext
    '             loop
    '         'Penjualan

    '         else

    '         'Pembelian
    '             Stok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_D2.mm_pdID = '"& pdID &"' AND MONTH(MKT_T_MaterialReceipt_H.mmTanggal) = '"& Bulan &"' ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC "
    '             response.Write Stok_CMD.commandText & "<br><br>"
    '             set Pembelian = Stok_CMD.execute

    '             do while not Pembelian.eof

    '                 SAPD_CMD.commandText    = "UPDATE MKT_T_SAPD SET "& SAPD_Pembelian &"  = '"& Pembelian("mm_pdQty") &"', "& SAPD_HargaPembelian &" = '"& Pembelian("mm_pdHarga") &"'  WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_pdID = '"& Pembelian("mm_pdID")  &"' AND SAPD_Tanggal = '"& Pembelian("mmTanggal") &"' "
    '                 response.Write SAPD_CMD.commandText & "<br><br>"
    '                 set UPPembelian = SAPD_CMD.execute

    '             Pembelian.movenext
    '             loop
    '         'Pembelian

    '         'Penjualan
    '             Stok_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty,  MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_pdID = '"& pdID &"' AND MONTH(MKT_T_Permintaan_Barang_H.PermTanggal) = '"& Bulan &"' ORDER BY MKT_T_Permintaan_Barang_H.PermTanggal ASC "
    '             response.Write Stok_CMD.commandText & "<br><br>"
    '             set Penjualan = Stok_CMD.execute

    '             do while not Penjualan.eof

    '                 SAPD_CMD.commandText    = "UPDATE MKT_T_SAPD SET "& SAPD_Penjualan &"  = '"& Penjualan("Perm_pdQty") &"', "& SAPD_HargaPenjualan &" = '"& Penjualan("Perm_pdHargaJual") &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_pdID = '"& Penjualan("Perm_pdID") &"' AND SAPD_Tanggal = '"& Penjualan("PermTanggal") &"'"
    '                 response.Write SAPD_CMD.commandText & "<br><br>"
    '                 set UPPenjualan = SAPD_CMD.execute

    '             Penjualan.movenext
    '             loop
    '         'Penjualan

    '         end if
    ' response.flush
    ' Stok.movenext
    ' loop

%>




