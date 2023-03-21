<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Pilih Alamat Pengiriman</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="/action_page.php">
            <input type="text" placeholder="Search.." name="search">
        </form>
        <button type="button" class="btn btn-light btn-p mt-2 mb-2"style=" background-color:#0dcaf0; color:white"><b>Tambah Alamat Baru</b></button><br></td>
        <div class="container-pm" style="display:none">
            <form action="/action_page.asp">
                <label for="fname">Nama Jalan/Desa</label>
                    <input type="text" id="fname" name="firstname" value="Bekasi">
                <label for="lname">Kecamatan</label>
                    <input type="text" id="lname" name="lastname">

                <label for="country">Kota</label>
                    <select id="country" name="country">
                        <option value="australia">Jakarta Selatan</option>
                        <option value="canada">Jakarta Pusat</option>
                        <option value="usa">Jakarta Barat</option>
                        <option value="usa">Jakarta Timur</option>
                    </select>

                <label for="subject">Subject</label>
                    <textarea id="subject" name="subject" style="height:200px"></textarea>

                    <input type="submit" value="Submit">
            </form>
        </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>