<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 

    response.redirect("../../../../admin/")
    
    end if
    SAPDB_Tgla      = CDate("2022-10-01")
    SAPDB_Tgle      = CDate("2022-11-30")
    Bulan           = MONTH(CDate("2022-10-01"))
    Tahun           = YEAR(CDate("2022-10-01"))
    
    set Stok_CMD = server.CreateObject("ADODB.command")
    Stok_CMD.activeConnection = MM_pigo_STRING
    set SAPDB_CMD = server.CreateObject("ADODB.command")
    SAPDB_CMD.activeConnection = MM_pigo_STRING

    Stok_CMD.commandText = "SELECT pdID, pdNama, pdHarga, (SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MONTH(MKT_T_MaterialReceipt_H.mmTanggal) = '10') AND (YEAR(MKT_T_MaterialReceipt_H.mmTanggal) = '2022') AND (MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID)) AS Pembelian, (SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty), 0) AS Penjualan FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MONTH(MKT_T_Permintaan_Barang_H.PermTanggal) = '10') AND (YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '2022') AND (MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID)) AS Penjualan FROM MKT_M_PIGO_Produk WHERE ((SELECT ISNULL(SUM(MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima), 0) AS Pembelian FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MONTH(MKT_T_MaterialReceipt_H.mmTanggal) = '10') AND (YEAR(MKT_T_MaterialReceipt_H.mmTanggal) = '2022') AND (MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID)) <> 0) OR ((SELECT ISNULL(SUM(MKT_T_Permintaan_Barang_D.Perm_pdQty), 0) AS Penjualan FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MONTH(MKT_T_Permintaan_Barang_H.PermTanggal) = '10') AND (YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '2022') AND (MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID)) <> 0) ORDER BY pdID"
    response.Write Stok_CMD.commandText & "<br><br>"
    set Stok = Stok_CMD.execute

    do while not Stok.eof
        pdID                        = Stok("pdID")

        SAPDB_Bulan                 = MONTH(CDate("2022-10-01"))
            if len(SAPDB_Tgla)    = 1 then
            SAPDB_Tgla = "0" & SAPDB_Tgla
            end if
        SAPDB_Pembelian             = "SAPDB_Pembelian"&SAPDB_Bulan
        SAPDB_HargaPembelian        = "SAPDB_HargaPembelian"&SAPDB_Bulan
        SAPDB_Penjualan             = "SAPDB_Penjualan"&SAPDB_Bulan
        SAPDB_HargaPenjualan        = "SAPDB_HargaPenjualan"&SAPDB_Bulan

        SAPDB_CMD.commandText = "SELECT * FROM MKT_T_SAPDB WHERE SAPDB_pdID = '"& pdID &"' and SAPDB_Tahun = '"& Tahun &"' "
        response.Write SAPDB_CMD.commandText & "<br><br>"
        set SAPDB = SAPDB_CMD.execute

        if SAPDB.eof = true then

            'Pembelian
                Stok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_D2.mm_pdID = '"& pdID &"' AND  YEAR(MKT_T_MaterialReceipt_H.mmTanggal ) = '"& Tahun &"' ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC "
                response.Write Stok_CMD.commandText & "<br><br>"
                set Pembelian = Stok_CMD.execute

                do while not Pembelian.eof

                    SAPDB_CMD.commandText = "exec sp_add_MKT_T_SAPDB '"& Tahun &"','"& Pembelian("mmTanggal") &"','"& Pembelian("mm_pdID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                    set SETPembelian = SAPDB_CMD.execute

                    SAPDB_CMD.commandText    = "UPDATE MKT_T_SAPDB SET "& SAPDB_Pembelian &"  = '"& Pembelian("mm_pdQty") &"', "& SAPDB_HargaPembelian &" = '"& Pembelian("mm_pdHarga") &"'  WHERE SAPDB_Tahun = '"& Tahun &"' AND SAPDB_pdID = '"& Pembelian("mm_pdID")  &"' AND SAPDB_Tanggal = '"& Pembelian("mmTanggal") &"' "
                    response.Write SAPDB_CMD.commandText & "<br><br>"
                    set UPPembelian = SAPDB_CMD.execute

                Pembelian.movenext
                loop
            'Pembelian

            'Penjualan
                Stok_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty,  MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_pdID = '"& pdID &"' AND YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '"& Tahun &"' ORDER BY MKT_T_Permintaan_Barang_H.PermTanggal ASC "
                response.Write Stok_CMD.commandText & "<br><br>"
                set Penjualan = Stok_CMD.execute

                do while not Penjualan.eof

                    SAPDB_CMD.commandText = "exec sp_add_MKT_T_SAPDB '"& Tahun &"','"& Penjualan("PermTanggal") &"','"& Penjualan("Perm_pdID") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                    set SETPenjualan = SAPDB_CMD.execute

                    SAPDB_CMD.commandText    = "UPDATE MKT_T_SAPDB SET "& SAPDB_Penjualan &"  = '"& Penjualan("Perm_pdQty") &"', "& SAPDB_HargaPenjualan &" = '"& Penjualan("Perm_pdHargaJual") &"' WHERE SAPDB_Tahun = '"& Tahun &"' AND SAPDB_pdID = '"& Penjualan("Perm_pdID") &"' AND SAPDB_Tanggal = '"& Penjualan("PermTanggal") &"'"
                    response.Write SAPDB_CMD.commandText & "<br><br>"
                    set UPPenjualan = SAPDB_CMD.execute

                Penjualan.movenext
                loop
            'Penjualan

            else

            'Pembelian
                Stok_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQty, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 WHERE MKT_T_MaterialReceipt_D2.mm_pdID = '"& pdID &"' AND  YEAR(MKT_T_MaterialReceipt_H.mmTanggal ) = '"& Tahun &"' ORDER BY MKT_T_MaterialReceipt_H.mmTanggal ASC "
                response.Write Stok_CMD.commandText & "<br><br>"
                set Pembelian = Stok_CMD.execute

                do while not Pembelian.eof

                    SAPDB_CMD.commandText    = "UPDATE MKT_T_SAPDB SET "& SAPDB_Pembelian &"  = '"& Pembelian("mm_pdQty") &"', "& SAPDB_HargaPembelian &" = '"& Pembelian("mm_pdHarga") &"'  WHERE SAPDB_Tahun = '"& Tahun &"' AND SAPDB_pdID = '"& Pembelian("mm_pdID")  &"' AND SAPDB_Tanggal = '"& Pembelian("mmTanggal") &"' "
                    response.Write SAPDB_CMD.commandText & "<br><br>"
                    set UPPembelian = SAPDB_CMD.execute

                Pembelian.movenext
                loop
            'Pembelian

            'Penjualan
                Stok_CMD.commandText = "SELECT MKT_T_Permintaan_Barang_D.Perm_pdID, MKT_T_Permintaan_Barang_D.Perm_pdQty,  MKT_T_Permintaan_Barang_D.Perm_pdHargaJual, MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE MKT_T_Permintaan_Barang_D.Perm_pdID = '"& pdID &"' AND YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '"& Tahun &"' ORDER BY MKT_T_Permintaan_Barang_H.PermTanggal ASC "
                response.Write Stok_CMD.commandText & "<br><br>"
                set Penjualan = Stok_CMD.execute

                do while not Penjualan.eof

                    SAPDB_CMD.commandText    = "UPDATE MKT_T_SAPDB SET "& SAPDB_Penjualan &"  = '"& Penjualan("Perm_pdQty") &"', "& SAPDB_HargaPenjualan &" = '"& Penjualan("Perm_pdHargaJual") &"' WHERE SAPDB_Tahun = '"& Tahun &"' AND SAPDB_pdID = '"& Penjualan("Perm_pdID") &"' AND SAPDB_Tanggal = '"& Penjualan("PermTanggal") &"'"
                    response.Write SAPDB_CMD.commandText & "<br><br>"
                    set UPPenjualan = SAPDB_CMD.execute

                Penjualan.movenext
                loop
            'Penjualan

            end if
    response.flush
    Stok.movenext
    loop

%>




