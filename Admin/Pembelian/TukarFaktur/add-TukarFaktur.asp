<!--#include file="../../../connections/pigoConn.asp"--> 

<% 

    TF_ID                   = request.queryString("TF_ID")
    TF_Tanggal              = request.queryString("TF_Tanggal")
    TF_Invoice              = request.queryString("TF_Invoice")
    TF_FakturPajak          = request.queryString("TF_FakturPajak")
    TF_SuratJalan           = request.queryString("TF_SuratJalan")
    TF_Status               = request.queryString("TF_Status")
    TF_custID               = request.queryString("TF_custID")
    TFD_mmID                = request.queryString("TFD_mmID")
    TFD_TotalMM             = request.queryString("TFD_TotalMM")
    TFD_TotalTukarFaktur    = request.queryString("TFD_TotalTukarFaktur")
    TFD_SisaMM              = request.queryString("TFD_SisaMM")

    If TF_ID = "" then
        no = 0

        set TukarFaktur_H_CMD = server.CreateObject("ADODB.command")
        TukarFaktur_H_CMD.activeConnection = MM_pigo_STRING
        TukarFaktur_H_CMD.commandText = "exec sp_add_MKT_T_TukarFaktur '"& TF_Tanggal &"','"& TF_Invoice &"','"& TF_FakturPajak &"','"& TF_SuratJalan &"','"& TF_custID &"', 'N','','N','"& session("username") &"' "
        'response.write TukarFaktur_H_CMD.commandText  & "<br><br>"
        set TukarFaktur_H = TukarFaktur_H_CMD.execute
        TF_ID = TukarFaktur_H("id")

        no=no+1
        nourut=right("0000"&no,4)

        set TukarFaktur_D_CMD = server.CreateObject("ADODB.command")
        TukarFaktur_D_CMD.activeConnection = MM_pigo_STRING
        TukarFaktur_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_TukarFaktur_D]([TFD_ID],[TF_mmID],[TF_mmTotal],[TF_TFTotal],[TF_mmSisa])VALUES('"& TF_ID&nourut &"','"& TFD_mmID &"',"& TFD_TotalMM &","& TFD_TotalTukarFaktur &","& TFD_SisaMM &")"
        'response.write TukarFaktur_D_CMD.commandText

        set TukarFaktur_D = TukarFaktur_D_CMD.execute
            set UpdateMM_CMD = server.CreateObject("ADODB.command")
            UpdateMM_CMD.activeConnection = MM_pigo_STRING
            UpdateMM_CMD.commandText = "UPDATE MKT_T_MaterialReceipt_H set mm_tfYN = 'Y' where mmID = '"& TFD_mmID &"' "
            set UpdateMM = UpdateMM_CMD.execute

            UpdateMM_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poID FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID Where mmID = '"& TFD_mmID &"' GROUP BY MKT_T_MaterialReceipt_D1.mm_poID "
            set POID = UpdateMM_CMD.execute

            no = 0
            do while not POID.eof
            no=no+1
            d1=right("0000"&no,4)

            TukarFaktur_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_TukarFaktur_D1]([TFD1_ID],[TFD1_mmID],[TFD1_poID])VALUES('"& TF_ID&nourut&d1 &"','"& TFD_mmID &"','"& POID("mm_poID") &"')"
            'response.write TukarFaktur_D_CMD.commandText
            set TukarFaktur_D1 = TukarFaktur_D_CMD.execute

            UpdateMM_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set po_tfYN = 'Y' where poID_H = '"& POID("mm_poID") &"' "
            set UpdatePOMM = UpdateMM_CMD.execute

            POID.movenext
            loop 
        TukarFaktur_D_CMD.commandText = "SELECT * FROM MKT_T_TukarFaktur_D WHERE LEFT(TFD_ID,16) = '"& TF_ID &"' "
        set Faktur = TukarFaktur_D_CMD.execute

    Else
        set TukarFaktur_H_CMD = server.CreateObject("ADODB.command")
        TukarFaktur_H_CMD.activeConnection = MM_pigo_STRING
        TukarFaktur_H_CMD.commandText = "SELECT * FROM MKT_T_TukarFaktur_D WHERE  TF_mmID = '"& TFD_mmID &"' "
        set TF = TukarFaktur_H_CMD.execute

        
        if TF.eof = false then 

            TukarFaktur_H_CMD.commandText = "SELECT * FROM MKT_T_TukarFaktur_D WHERE LEFT(TFD_ID,16) = '"& TF_ID &"' "
            set Faktur = TukarFaktur_H_CMD.execute

        else

            set TukarFaktur_D_CMD = server.CreateObject("ADODB.command")
            TukarFaktur_D_CMD.activeConnection = MM_pigo_STRING
            TukarFaktur_D_CMD.commandText = "SELECT ISNULL(MAX(RIGHT(MKT_T_TukarFaktur_D.TFD_ID,4)),0) AS TFIDD FROM [pigo].[dbo].[MKT_T_TukarFaktur_D] WHERE LEFT(TFD_ID,16) = '"& TF_ID &"'"
            set TukarFaktur = TukarFaktur_D_CMD.execute

            no = TukarFaktur("TFIDD")
            no=no+1
            nourut=right("0000"&no,4)
            TukarFaktur_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_TukarFaktur_D]([TFD_ID],[TF_mmID],[TF_mmTotal],[TF_TFTotal],[TF_mmSisa])VALUES('"& TF_ID&nourut &"','"& TFD_mmID &"',"& TFD_TotalMM &","& TFD_TotalTukarFaktur &","& TFD_SisaMM &")"
            set TukarFaktur_D = TukarFaktur_D_CMD.execute

            set UpdateMM_CMD = server.CreateObject("ADODB.command")
            UpdateMM_CMD.activeConnection = MM_pigo_STRING
            UpdateMM_CMD.commandText = "UPDATE MKT_T_MaterialReceipt_H set mm_tfYN = 'Y' where mmID = '"& TFD_mmID &"' "
            set UpdateMM = UpdateMM_CMD.execute

            UpdateMM_CMD.commandText = "SELECT MKT_T_MaterialReceipt_D1.mm_poID FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID Where mmID = '"& TFD_mmID &"' GROUP BY MKT_T_MaterialReceipt_D1.mm_poID "
            'response.write UpdateMM_CMD.commandText
            set POID = UpdateMM_CMD.execute

                no = 0
                do while not POID.eof

                no=no+1
                d1=right("0000"&no,4)

                TukarFaktur_D_CMD.commandText = "INSERT INTO [dbo].[MKT_T_TukarFaktur_D1]([TFD1_ID],[TFD1_mmID],[TFD1_poID])VALUES('"& TF_ID&nourut&d1 &"','"& TFD_mmID &"','"& POID("mm_poID") &"')"
                'response.write TukarFaktur_D_CMD.commandText
                set TukarFaktur_D1 = TukarFaktur_D_CMD.execute

                UpdateMM_CMD.commandText = "UPDATE MKT_T_PurchaseOrder_D set po_tfYN = 'Y' where poID_H = '"& POID("mm_poID") &"' "
                set UpdatePOMM = UpdateMM_CMD.execute
                    
                POID.movenext
                loop

            TukarFaktur_D_CMD.commandText = "SELECT * FROM MKT_T_TukarFaktur_D WHERE LEFT(TFD_ID,16) = '"& TF_ID &"' "
            set Faktur = TukarFaktur_D_CMD.execute
        end if 

        

    end if

    
%>
<input type="hidden" name="TF_ID" id="TF_ID" value="<%=TF_ID%>">
<input type="hidden" name="TF_Tanggal" id="TF_Tanggal" value="<%=TF_Tanggal%>">
<div class="row">
    <div class="col-12">
        <table class="tb-dashboard cont-tb align-items-center table tb-transaksi table-bordered table-condensed mt-1">
            <thead class="text-center">
                <tr>
                    <th> NO </td>
                    <th> AKSI </td>
                    <th> ID MATERIAL RECEIPT </th>
                    <th> TOTAL RECEIPT </th>
                    <th> TOTAL TUKAR FAKTUR </th>
                    <th> SISA </th>
                </tr>
            </thead>
            <tbody>
                <%
                    no = 0 
                    do while not Faktur.eof
                    no = no + 1
                %>
                <tr>
                    <td class="text-center"> <%=no%> </td>
                    <td class="text-center"> 
                        <button onclick="deleteTukarFaktur<%=no%>()" class="cont-btn"> DELETE </button> 
                        <input type="hidden" name="TFD_ID" id="TFD_ID<%=no%>" value="<%=Faktur("TFD_ID")%>">
                    </td>
                    <td class="text-center"> <%=Faktur("TF_mmID")%> </td>
                    <td class="text-end"> <%=Replace(FormatCurrency(Faktur("TF_mmTotal")),"$","Rp. ")%> </td>
                    <td class="text-end"> <%=Replace(FormatCurrency(Faktur("TF_TFTotal")),"$","Rp. ")%> </td>
                    <td class="text-end"> <%=Replace(FormatCurrency(Faktur("TF_mmSisa")),"$","Rp. ")%> </td>
                </tr>
                <%
                    TotalTukarFaktur = TotalTukarFaktur + Faktur("TF_TFTotal")
                %>
                <script>
                    function deleteTukarFaktur<%=no%>(){
                        var TFD_ID = document.getElementById("TFD_ID<%=no%>").value;
                        $.ajax({
                            type: "GET",
                            url: "delete-materialreceipt.asp",
                            data: {
                                TFD_ID
                            },
                            success: function (data) {
                                $('.data-TukarFaktur').html(data);
                                Swal.fire('Data Berhasil Dihapus', data.message, 'success').then(() => {
                                });
                            }
                        });
                    }
                </script>
                <%
                    Faktur.movenext
                    loop
                %>
            </tbody>
        </table>
    </div>
</div>
<input type="hidden" name="TotalTukarFaktur" id="TotalTukarFaktur" value="<%=TotalTukarFaktur%>">
<div class="datajurnal">

</div>
<div class="row mt-2 cont-simpan-tukar-faktur" id="cont-simpan-tukar-faktur">
    <div class="col-6">
        <button onclick="simpan()"class="cont-btn"> Simpan </button>
    </div>
    <div class="col-6">
        <button onclick="batal()" class="cont-btn"> Batalkan Tukar Faktur </button>
    </div>
</div>
<script>
    function postingtukarfaktur(){
        var TF_ID = document.getElementById("TF_ID").value;
        var TF_Total = document.getElementById("TotalTukarFaktur").value;
        console.log(TF_ID);
        console.log(TF_Total);
        $.ajax({
            type: "GET",
            url: "posting-jurnal.asp",
            data:{
                TF_ID,
                TF_Total
            },
            success: function (data) {
                $('.datajurnal').html(data);
            }
        });
    }
</script>