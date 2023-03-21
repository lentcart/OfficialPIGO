<!--#include file="../../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 

    response.redirect("../../../../admin/")
    
    end if
    Bulan   = MONTH(CDate("2022-10-01"))
    Tahun   = YEAR(CDate("2022-10-01"))
    
    set Stok_CMD = server.CreateObject("ADODB.command")
    Stok_CMD.activeConnection = MM_pigo_STRING
    set SAPDB_CMD = server.CreateObject("ADODB.command")
    SAPDB_CMD.activeConnection = MM_pigo_STRING

    Stok_CMD.commandText = "SELECT pdID , pdNama, pdHarga,( SELECT ISNULL(SUM(mm_pdQtyDiterima),0) AS Pembelian FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MONTH(mmTanggal) = '10') AND (YEAR(mmTanggal) = '2022') AND (mm_pdID = MKT_M_PIGO_Produk.pdID)) AS Pembelian, ( SELECT ISNULL(SUM(Perm_pdQty),0) AS Penjualan FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MONTH(PermTanggal) = '10') AND (YEAR(PermTanggal) = '2022') AND (Perm_pdID = MKT_M_PIGO_Produk.pdID)) AS Penjualan FROM MKT_M_PIGO_Produk WHERE ((SELECT ISNULL(SUM(mm_pdQtyDiterima),0) AS Pembelian FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MONTH(mmTanggal) = '10') AND (YEAR(mmTanggal) = '2022') AND (mm_pdID = MKT_M_PIGO_Produk.pdID)) <> 0) OR ((SELECT ISNULL(SUM(Perm_pdQty),0) AS Penjualan FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MONTH(PermTanggal) = '10') AND (YEAR(PermTanggal) = '2022') AND (Perm_pdID = MKT_M_PIGO_Produk.pdID)) <> 0 ) ORDER BY MKT_M_PIGO_Produk.pdID"
    response.Write Stok_CMD.commandText & "<br><br>"
    set Stok = Stok_CMD.execute

    do while not Stok.eof
        pdID                        = Stok("pdID")
        Tanggal                     = Stok("pdID")
        Pembelian                   = Stok("Pembelian")
        Penjualan                   = Stok("Penjualan")
        SAPDB_Bulan                 = MONTH(CDate("2022-10-01"))
            if len(SAPD_Tanggal)    = 1 then
            SAPD_Tanggal = "0" & SAPD_Tanggal
            end if
        SAPDB_Pembelian             = "SAPDB_Pembelian"&SAPDB_Bulan
        SAPDB_Penjualan             = "SAPDB_Penjualan"&SAPDB_Bulan

        SAPDB_CMD.commandText = "SELECT * FROM MKT_T_SAPDB WHERE SAPDB_pdID = '"& Stok("pdID") &"' and SAPDB_Tahun = '"& Tahun &"' "
        response.Write SAPDB_CMD.commandText & "<br><br>"
        set SAPDB = SAPDB_CMD.execute

        if SAPDB.eof = true then

            SAPDB_CMD.commandText = "exec sp_add_MKT_T_SAPDB '"& Tahun &"','','"& pdID &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
            set SETSAPD = SAPDB_CMD.execute
            
            ' SAPDB_CMD.commandText    = "SELECT pdID,  (SELECT MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MONTH(MKT_T_MaterialReceipt_H.mmTanggal) = '10') AND (YEAR(MKT_T_MaterialReceipt_H.mmTanggal) = '2022') AND (MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID)) AS Pembelian, (SELECT MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MONTH(MKT_T_Permintaan_Barang_H.PermTanggal) = '10') AND (YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '2022') AND (MKT_T_Permintaan_Barang_D.Perm_pdID = MKT_M_PIGO_Produk.pdID)) AS Penjualan FROM MKT_M_PIGO_Produk WHERE ((SELECT  MKT_T_MaterialReceipt_H.mmTanggal FROM  MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE (MONTH(MKT_T_MaterialReceipt_H.mmTanggal) = '10') AND (YEAR(MKT_T_MaterialReceipt_H.mmTanggal) = '2022') AND (mm_pdID = MKT_M_PIGO_Produk.pdID)) <> '')  OR (SELECT MKT_T_Permintaan_Barang_H.PermTanggal FROM MKT_T_Permintaan_Barang_D RIGHT OUTER JOIN MKT_T_Permintaan_Barang_H ON MKT_T_Permintaan_Barang_D.Perm_IDH = MKT_T_Permintaan_Barang_H.PermID WHERE (MONTH(MKT_T_Permintaan_Barang_H.PermTanggal) = '10') AND (YEAR(MKT_T_Permintaan_Barang_H.PermTanggal) = '2022') AND (Perm_pdID = MKT_M_PIGO_Produk.pdID)) <> ''"
            ' response.Write SAPDB_CMD.commandText & "<br><br>"
            ' set Tanggal = SAPDB_CMD.execute

            SAPDB_CMD.commandText    = "UPDATE MKT_T_SAPDB SET "& SAPDB_Pembelian &"  = '"& Pembelian &"' , "& SAPDB_Penjualan &"  = '"& Penjualan &"'  WHERE SAPDB_Tahun = '"& Tahun &"' AND SAPDB_pdID = '"& pdID &"' "
            response.Write SAPDB_CMD.commandText & "<br><br>"
            set UPDATESAPDPembelian = SAPDB_CMD.execute

        else

            Pembelian                   = Stok("Pembelian")
            Penjualan                   = Stok("Penjualan")
            SAPDB_Bulan                 = MONTH(CDate("2022-10-01"))
                if len(SAPD_Tanggal)    = 1 then
                SAPD_Tanggal = "0" & SAPD_Tanggal
                end if
            SAPDB_Pembelian             = "SAPDB_Pembelian"&SAPDB_Bulan
            SAPDB_Penjualan             = "SAPDB_Penjualan"&SAPDB_Bulan

            SAPDB_CMD.commandText    = "UPDATE MKT_T_SAPDB SET "& SAPDB_Pembelian &"  = '"& Pembelian &"' , "& SAPDB_Penjualan &"  = '"& Penjualan &"'  WHERE SAPDB_Tahun = '"& Tahun &"' AND SAPDB_pdID = '"& pdID &"' "
            response.Write SAPDB_CMD.commandText & "<br><br>"
            set UPDATESAPDPembelian = SAPDB_CMD.execute

        end if

    response.flush
    Stok.movenext
    loop

%>




