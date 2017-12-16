<%-- 
    Document   : scan
    Created on : Sep 13, 2017, 5:20:58 PM
    Author     : djorj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/scannerjs.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="js/scanner.js"></script>
        <script>
            function scanToJpg() {
               scanner.scan(displayImagesOnPage,
               {
                  "output_settings" :
                  [
                     {
                        "type" : "return-base64",
                        "format" : "jpg"
                     }
                  ]
               }
               );
            }
            
            function displayImagesOnPage(successful, mesg, response) {
               if(!successful) { // On error
                  console.error('Failed: ' + mesg);
                  return;
               }

               if(successful && mesg != null && mesg.toLowerCase().indexOf('user cancel') >= 0) { // User canceled.
                  console.info('User canceled');
                  return;
               }

               var scannedImages = scanner.getScannedImage(response, true, false); // returns an array of ScannedImage
               for(var i = 0; (scannedImages instanceof Array) && i < scannedImages.length; i++) {
                  var scannedImage = scannedImages[i];
                  processScannedImage(scannedImage);
               }
            }

            /** Images scanned so far. */
            var imagesScanned = [];

            /** Processes a ScannedImage */
            function processScannedImage(scannedImage) {
               imagesScanned.push(scannedImage);
               var elementImg = createDomElementFromModel( {
                   'name': 'img',
                   'attributes': {
                       'class': 'scanned',
                       'src': scannedImage.src
                   }
               });
               document.getElementById('images').appendChild(elementImg);
            }
        </script>
    </head>
    <body>
        <button type="button" onclick="scanToJpg();">Scan</button>
        <div id="images"/>
    </body>
</html>
