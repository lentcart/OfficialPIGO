<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    tgla            = Cdate("2022-09-01")
    tgle            = Cdate(date())
    SAPD_Tanggala   = Day(Cdate("2022-10-01"))
    SAPD_Tanggale   = Day(Cdate(date()))
    bulan           = month("2022-10-01")
    tahun           = year("2022-10-01")
    typeproduk      = request.queryString("typeproduk")
    typepart        = request.queryString("typepart")
    pdID            = "P072200002"
    

    set Merchant_cmd = server.createObject("ADODB.COMMAND")
	Merchant_cmd.activeConnection = MM_PIGO_String
	Merchant_cmd.commandText = "SELECT MKT_M_Customer.*, MKT_M_Alamat.* FROM MKT_M_Alamat RIGHT OUTER JOIN  MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID where MKT_M_Customer.custID= 'C0322000000002'  "
	set Merchant = Merchant_cmd.execute

    'PROSES SALDO PEMBELIAN (SAPD)
    pdStokAwal  = request.queryString("pdStokAwal")
    Tahun       = Year(Date())
    Bulan       = Month(Date())

    set SAPD_CMD = server.CreateObject("ADODB.command")
    SAPD_CMD.activeConnection = MM_pigo_STRING
    SAPD_CMD.commandText = "SELECT SAPD_pdID FROM MKT_T_SAPD WHERE SAPD_pdID = '"& pdID &"' and SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' "
    response.Write SAPD_CMD.commandText & "<br><br>"
    set SAPD = SAPD_CMD.execute

    if SAPD.eof = true then
        SAPD_CMD.commandText = "exec sp_add_MKT_T_SAPD '"& Tahun &"','"& Bulan &"','"& pdID &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
        set SETSAPD = SAPD_CMD.execute

        ' PEMBELIAN
            SAPD_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mmID_D2, MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE YEAR(mmTanggal) = '"& Tahun &"' AND mm_pdID = '"& pdID &"' AND mmTanggal BETWEEN '"& tgla &"' and '"& tgle &"' "
            response.Write SAPD_CMD.commandText & "<br><br>"
            set Pembelian = SAPD_CMD.execute
            do while not Pembelian.eof
                QTY                      = Pembelian("mm_pdQtyDiterima")
                Harga                    = Pembelian("mm_pdHarga")
                SAPD_Tanggal             = Day(CDate(Pembelian("mmTanggal")))
                    if len(SAPD_Tanggal) = 1 then
                    SAPD_Tanggal = "0" & SAPD_Tanggal
                    end if
                SAPD_Bulan               = Month(CDate(Pembelian("mmTanggal")))
                SAPD_Pembelian           = "SAPD_Pembelian"&SAPD_Tanggal
                SAPD_HargaPembelian      = "SAPD_HargaPembelian"&SAPD_Tanggal

                SAPD_CMD.commandText    = "UPDATE MKT_T_SAPD SET "& SAPD_Pembelian &"  = '"& QTY &"' , "& SAPD_HargaPembelian &" = '"& Harga &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                response.Write SAPD_CMD.commandText & "<br><br>"
                set UPDATESAPD = SAPD_CMD.execute
            Pembelian.Movenext
            loop
        ' PEMBELIAN

        ' PENJUALAN

        ' PENJUALAN
    else
        SAPD_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D2.mmID_D2, MKT_T_MaterialReceipt_D2.mm_pdID, MKT_T_MaterialReceipt_D2.mm_pdQtyDiterima, MKT_T_MaterialReceipt_D2.mm_pdHarga, MKT_T_MaterialReceipt_H.mmTanggal FROM MKT_T_MaterialReceipt_D2 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D2.mmID_D2 = MKT_T_MaterialReceipt_H.mmID WHERE YEAR(mmTanggal) = '"& Tahun &"' AND mm_pdID = '"& pdID &"' AND mmTanggal BETWEEN '"& tgla &"' and '"& tgle &"' "
        response.Write SAPD_CMD.commandText & "<br><br>"
        set Pembelian = SAPD_CMD.execute
        do while not Pembelian.eof
            QTY                     = Pembelian("mm_pdQtyDiterima")
            Harga                   = Pembelian("mm_pdHarga")
            SAPD_Tanggal           = Day(CDate(Pembelian("mmTanggal")))
                if len(SAPD_Tanggal) = 1 then
                SAPD_Tanggal = "0" & SAPD_Tanggal
                end if
            SAPD_Bulan              = Month(CDate(Pembelian("mmTanggal")))
            SAPD_Pembelian          = "SAPD_Pembelian"&SAPD_Tanggal
            SAPD_HargaPembelian     = "SAPD_HargaPembelian"&SAPD_Tanggal
            
            SAPD_CMD.commandText = "SELECT "& SAPD_Pembelian &" AS Pembelian , "& SAPD_HargaPembelian &" AS HargaPembelian FROM MKT_T_SAPD WHERE  SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
            response.Write SAPD_CMD.commandText & "<br><br>"
            set SAPD = SAPD_CMD.execute
            response.Write SAPD.eof & "<br><br>"

            if SAPD.eof = true then
                SAPD_CMD.commandText = "UPDATE MKT_T_SAPD SET "& SAPD_Pembelian &" = '"& QTY &"', "& SAPD_HargaPembelian &" = '"& Harga &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                response.Write SAPD_CMD.commandText & "<br><br>"
                set UPDATESAPD = SAPD_CMD.execute
            else
                Pembelian   = SAPD("Pembelian")+QTY
                HargaPembelian  = Harga 

                SAPD_CMD.commandText = "UPDATE MKT_T_SAPD SET "& SAPD_Pembelian &" = '"& Pembelian &"', "& SAPD_HargaPembelian &" = '"& HargaPembelian &"' WHERE SAPD_Tahun = '"& Tahun &"' AND SAPD_Bulan = '"& Bulan &"' AND SAPD_pdID = '"& pdID &"' "
                response.Write SAPD_CMD.commandText & "<br><br>"
                set UPDATESAPD = SAPD_CMD.execute
                
            end if 
        Pembelian.Movenext
        loop
        
    end if


%>




