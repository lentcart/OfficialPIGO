
<!--#include file="../Connections/pigoConn.asp" -->

<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OFFICIAL PIGO</title>
    <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        
    </head>
<body>
    <input type="file" id="inputImg1">
    <input type="text" id="base64_1">
</body>
    <script>
        async function compressImage(blobImg1, percent1) {
        let bitmap1 = await createImageBitmap(blobImg1);
        let canvass = document.createElement("canvas");
        let ctx1 = canvass.getContext("2d");
        canvass.width = bitmap1.width;
        canvass.height = bitmap1.height;
        ctx1.drawImage(bitmap1, 0, 0);
        let dataUrl1 = canvass.toDataURL("image/jpeg", percent1/100);
        return dataUrl1;
        }

        inputImg1.addEventListener('change', async(e1) => {
        let img1 = e1.target.files[0];
        console.log('File Name: ', img1.name)
        console.log('Original Size: ', img1.size.toLocaleString())
        
        let imgCompressed1 = await compressImage(img1, 75) // set to 75%
        let compSize1 = atob(imgCompressed1.split(",")[1]).length;
        console.log('Compressed Size: ', compSize1.toLocaleString())
        //console.log(imgCompressed)
        })
        if (window.File && window.FileReader && window.FileList && window.Blob) {
        document.getElementById('inputImg1').addEventListener('change', SKUFileSelect1, false);
        } else {
        alert('The File APIs are not fully supported in this browser.');
        }

        function SKUFileSelect1(evt) {
        var f1 = evt.target.files[0];
        var reader1 = new FileReader();

        reader1.onload = (function(theFile1) {
            return function(e1) {
            var binaryData1 = e1.target.result;

            var base64String1 = window.btoa(binaryData1);

            document.getElementById('base64_1').value = base64String1;
            };
        })(f1);
        // Read in the image file as a data URL.
        reader1.readAsBinaryString(f1);
        }
        // async function compressImage(blobImg2, percent2) {
        // let bitmap2 = await createImageBitmap(blobImg2);
        // let canvas2 = document.createElement("canvas");
        // let ctx2 = canvas2.getContext("2d");
        // canvas2.width = bitmap2.width;
        // canvas2.height = bitmap2.height;
        // ctx2.drawImage(bitmap2, 0, 0);
        // let dataUrl2 = canvas2.toDataURL("image/jpeg", percent2/100);
        // return dataUrl2;
        // }

        // inputImg2.addEventListener('change', async(e2) => {
        // let img2 = e2.target.files[0];
        // console.log('File Name: ', img2.name)
        // console.log('Original Size: ', img2.size.toLocaleString())
        
        // let imgCompressed2 = await compressImage(img2, 75) // set to 75%
        // let compSize2 = atob(imgCompressed2.split(",")[1]).length;
        // console.log('Compressed Size: ', compSize2.toLocaleString())
        // //console.log(imgCompressed)
        // })
    </script>
</html>