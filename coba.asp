<script type="text/javascript" src="http://maps.google.com/maps/api/js?libraries=geometry"></script>

<script>
//lokasi pertama
var posisi_1 = new google.maps.LatLng(-7.2888878, 112.7581761);

//lokasi kedua
var posisi_2 = new google.maps.LatLng(-7.2921667, 112.7598175);

document.write(hitungJarak(posisi_1, posisi_2));


function hitungJarak(posisi_1, posisi_2) {
  return (google.maps.geometry.spherical.computeDistanceBetween(posisi_1, posisi_2) / 1000).toFixed(5);
}

</script>