<!--#include file="../../../connections/pigoConn.asp"--> 
<%
    if Session("Username")="" then 
 
    response.redirect("../../../admin/")
    
    end if
    
    custNama = request.queryString("custNama")

    set BussinesPartner_cmd = server.createObject("ADODB.COMMAND")
	BussinesPartner_cmd.activeConnection = MM_PIGO_String

        BussinesPartner_cmd.commandText = "SELECT MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama FROM MKT_M_Customer RIGHT OUTER JOIN MKT_T_MaterialReceipt_H ON MKT_M_Customer.custID = MKT_T_MaterialReceipt_H.mm_custID WHERE MKT_M_Customer.custNama LIKE '%"& custNama &"%'  GROUP BY MKT_T_MaterialReceipt_H.mm_custID, MKT_M_Customer.custNama "
        'response.write Pembelian_cmd.commandText

    set bussinespartner = BussinesPartner_cmd.execute

    
%>
<%
    do while not bussinespartner.eof
%>
<tr>
    <td class="text-center" style="width:5px">
        <input type="checkbox" onchange="checkbarang(this)" name="<%=bussinespartner("custNama")%>" id="<%=bussinespartner("mm_custID")%>" value="<%=bussinespartner("mm_custID")%>">
    </td>
    <td><%=bussinespartner("custNama")%></td>
</tr>
    <script>
        var array = [];
        console.log(array);
        function checkbarang(ck){
        var id = ck.value+",";
        var nama = ck.name+",";
        console.log(nama);
            if (ck.checked){
                var obj = {
                    id,
                    nama,
                }
                array.push(obj);
                    array.map((key)=> {
            });
            document.getElementById("custID").value = document.getElementById("custID").value +id;
            // document.getElementById("bsID").value = document.getElementById("bsID").value +nama;
            $.ajax({
                type: "get",
                url: "get-bussinespartner.asp?custID="+document.getElementById("custID").value,
                success: function (url) {
                    $('.lisnama').html(url);
                    $('.tgla').focus();
                    document.getElementById("tgla").value = "";
                    document.getElementById("tgle").value = "";
                }
            });
            $.ajax({
                type: "get",
                url: "load-pembelian.asp?custID="+document.getElementById("custID").value,
                success: function (url) {
                    $('.datapembelian').html(url);
                    $('.tgla').focus();
                    document.getElementById("tgla").value = "";
                    document.getElementById("tgle").value = "";
                }
            });
            }else{
                var uncek = array.filter((key)=> key.id != id)
                array = uncek
                    array.map((key)=> {
                    total += Number(key.total)
                    tqty += Number(key.tqty)
            });

        // console.log(tqty);
        document.getElementById("total").value = total;
        document.getElementById("idproduk").value = document.getElementById("idproduk").value +id;
        document.getElementById("jumlah").value = document.getElementById("jumlah").value +jml;
        document.getElementById("tbarang").value= tqty;
        }
    }
</script>
<%
    bussinespartner.movenext
    loop
%>
