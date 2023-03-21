
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
    <div id="root">
  <p>Upload an image and see the result</p>
  <input id="img-input" type="file" accept="image/*" style="display:block" />
</div>
</body>
    <script>

    const MAX_WIDTH = 400;
    const MAX_HEIGHT = 390;
    const MIME_TYPE = "image/jpeg";
    const QUALITY = 10;

      const input = document.getElementById("img-input");
      input.onchange = function (ev) {
        const file = ev.target.files[0]; // get the file
        const blobURL = URL.createObjectURL(file);
        const img = new Image();
        img.src = blobURL;
        img.onerror = function () {
          URL.revokeObjectURL(this.src);
          // Handle the failure properly
          console.log("Cannot load image");
        };
        img.onload = function () {
          URL.revokeObjectURL(this.src);
          const [newWidth, newHeight] = calculateSize(img, MAX_WIDTH, MAX_HEIGHT);
          const canvas = document.createElement("canvas");
          canvas.width = newWidth;
          canvas.height = newHeight;
          const ctx = canvas.getContext("2d");
          ctx.drawImage(img, 0, 0, newWidth, newHeight);
          canvas.toBlob(
            (blob) => {
              // Handle the compressed image. es. upload or save in local state
              displayInfo('Original file', file);
              displayInfo('Compressed file', blob);
            },
            MIME_TYPE,
            QUALITY
          );
          document.getElementById("root").append(canvas);
        };
      };

      function calculateSize(img, maxWidth, maxHeight) {
        let width = img.width;
        let height = img.height;

        // calculate the width and height, constraining the proportions
        if (width > height) {
          if (width > maxWidth) {
            height = Math.round((height * maxWidth) / width);
            width = maxWidth;
          }
        } else {
          if (height > maxHeight) {
            width = Math.round((width * maxHeight) / height);
            height = maxHeight;
          }
        }
        return [width, height];
      }

      // Utility functions for demo purpose

      function displayInfo(label, file) {
        const p = document.createElement('p');
        p.innerText = `${label} - ${readableBytes(file.size)}`;
        document.getElementById('root').append(p);
      }

      function readableBytes(bytes) {
        const i = Math.floor(Math.log(bytes) / Math.log(1024)),
          sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

        return (bytes / Math.pow(1024, i)).toFixed(2) + ' ' + sizes[i];
      }
        </script>
</html>