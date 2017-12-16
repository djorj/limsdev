/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function  showLoader(){ $(".page-footer.loader").fadeIn();}
function  hideLoader(){ $(".page-footer.loader").fadeOut();}
function showLoader2(container){
    $("#"+container).html('<h1><i class="fa fa-cog fa-spin"></i> Loading...</h1>').fadeIn('fast');
}


/*
$.fn.datepicker.dates['ka'] = {
    days: ["კვირა", "ორშაბათი", "სამსაბათი", "ოთხშაბათი", "ხუთშაბათი", "პარასკევი", "შაბათი"],
    daysShort: ["კვი", "ორშ", "სამ", "ოთხ", "ხუთ", "პარ", "შაბ"],
    daysMin: ["კი", "ორ", "სა", "ოთ", "ხუ", "პა", "შა"],
    months: ["იანვარი", "თებერვალი", "მარტი", "აპრილი", "მაისი", "ივნისი", "ივლისი", "აგვისტო", "სექტემბერი", "ოქტომბერი", "ნოემბერი", "დეკემბერი"],
    monthsShort: ["იან", "თებ", "მარ", "აპრ", "მაი", "ივნ", "ივლ", "აგვ", "სექ", "ოქტ", "ნოქ", "დეკ"],
    today: "დღეს",
    clear: "გასუფთავება",
    format: "dd/mm/yyyy",
    titleFormat: "MM yyyy",
    weekStart: 1
};
*/

 $.datepicker.regional['ka'] = {clearText: 'გასუფთავება', clearStatus: '',
    closeText: 'დახურვა', closeStatus: 'Fermer sans modifier',
    prevText: '<<', prevStatus: 'Voir le mois précédent',
    nextText: '>>', nextStatus: 'Voir le mois suivant',
    currentText: 'დღეს', currentStatus: 'Voir le mois courant',
    monthNames: ["იანვარი", "თებერვალი", "მარტი", "აპრილი", "მაისი", "ივნისი", "ივლისი", "აგვისტო", "სექტემბერი", "ოქტომბერი", "ნოემბერი", "დეკემბერი"],
    monthNamesShort: ["იან", "თებ", "მარ", "აპრ", "მაი", "ივნ", "ივლ", "აგვ", "სექ", "ოქტ", "ნოქ", "დეკ"],
    monthStatus: 'Voir un autre mois', yearStatus: 'Voir un autre année',
    weekHeader: 'კვ', weekStatus: '',
    dayNames: ["კვირა", "ორშაბათი", "სამშაბათი", "ოთხშაბათი", "ხუთშაბათი", "პარასკევი", "შაბათი"],
    dayNamesShort: ["კვი", "ორშ", "სამ", "ოთხ", "ხუთ", "პარ", "შაბ"],
    dayNamesMin: ["კი", "ორ", "სა", "ოთ", "ხუ", "პა", "შა"],
    dayStatus: 'Utiliser DD comme premier jour de la semaine', dateStatus: 'Choisir le DD, MM d',
    dateFormat: 'dd/mm/yy', firstDay: 1, 
    initStatus: 'Choisir la date', isRTL: false};
 $.datepicker.setDefaults($.datepicker.regional['ka']);

function rbtn(fid,savetext,closetext){
    $("#sData").removeClass("fm-button ui-state-default ui-corner-all fm-button-icon-left").addClass("btn btn-success");
    $("#sData").html(savetext+' <span class="fa fa-save"></span>');
    $("#sData").css("margin-right","5px");
    $("#cData").removeClass("fm-button ui-state-default ui-corner-all fm-button-icon-left").addClass("btn btn-danger");
    $("#cData").html(closetext+' <span class="fa fa-close"></span>');
    //$("#"+fid.attr("id")+" textarea").removeClass("FormElement ui-widget-content ui-corner-all").wrap('<label class="textarea"></label>');
    //$("#"+fid.attr("id")+" input").removeClass("FormElement ui-widget-content ui-corner-all").wrap('<label class="input"></label>');
}

function rbtn1(savetext,closetext){
    $("#sData").removeClass("fm-button ui-state-default ui-corner-all fm-button-icon-left").addClass("btn btn-success");
    $("#sData").html(savetext+' <span class="fa fa-save"></span>');
    $("#sData").css("margin-right","5px");
    $("#cData").removeClass("fm-button ui-state-default ui-corner-all fm-button-icon-left").addClass("btn btn-danger");
    $("#cData").html(closetext+' <span class="fa fa-close"></span>');
    //$("#"+fid.attr("id")+" textarea").removeClass("FormElement ui-widget-content ui-corner-all").wrap('<label class="textarea"></label>');
    //$("#"+fid.attr("id")+" input").removeClass("FormElement ui-widget-content ui-corner-all").wrap('<label class="input"></label>');
}

function addObject2(frm) {

    showLoader();

    $.ajax({ 
        url : "post/addobjects.jsp",
        method: "post",
        data: frm.serialise(),
        dataType: "json"
    }).done(function(rs) { 
        alert( "success" );
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); alert(xhr.responseText);
    }).always(function() {
        hideLoader();
    });
 
}
function sendMPForm(frm,cb) {
    showLoader();
    var form = $("#"+frm)[0];
    var data = new FormData(form);
    $.each($("#"+frm).find("input[type='file']"), function(i, tag) {
        $.each($(tag)[0].files, function(i, file) {
            data.append(tag.name, file);
        });
    });
    if (frm=="frmcontract") {
      $.each($("#frmbill").find("input[name='bill']"), function(i, tag) {
        var name = "bill_"+tag.value;
        var val = $("input[name='"+name+"']").val();
        data.append(name,val);
      });
      $.each($("#frmdocs").find("input[name^='docs_']"), function(i, tag) {
        data.append(tag.name,tag.value);
      });
    }
    $.ajax({
        type: "POST",
        url: form.action,
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        dataType: "json"
    }).done(function(rs) { 
        hideLoader();
        cb( rs );
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); 
        cb( {'status':'ER','message': textStatus});
    });
}

function sendForm(frm,cb) {
    showLoader();
    var form = $("#"+frm)[0];
    $.ajax({
        type: "POST",
        url: form.action,
        data: $("#"+frm).serialize(),
        dataType: "json"
    }).done(function(rs) { 
        hideLoader();
        cb( rs );
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); 
        cb( {'status':'ER','message': textStatus});
    });
}

function sendRequest(url,data,cb) {
    showLoader();
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        dataType: "json"
    }).done(function(rs) { 
        hideLoader();
        cb( rs );
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); 
        cb( {'status':'ER','message': textStatus});
    });
}

function getObject(par) {
    showLoader();
    var result=null;
    $.ajax({ 
        url : "api/getobject.jsp",
        method: "post",
        data: par,
        dataType: "json",
        cache:false,
        async:false
    }).done(function(rs) { 
        hideLoader();
        result=rs;
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); 
    });
    return result;
}

function alertError(title,msg,buttontitle) {
    BootstrapDialog.show({
        type: BootstrapDialog.TYPE_DEFAULT,
        title: '<h4><span class="fa fa-exclamation-circle" style="font-size:32px;color:red; vertical-align: middle;padding-right:5px;"></span>'+title+"</h4>",
        icon: 'fa fa-times',
        message: msg,
        closable: false,
        closeByKeyboard: true,
        buttons: [{label: buttontitle,action: function(dialogRef){dialogRef.close();}}]
    });
}
function alertMessage(title,msg,buttontitle) {
    BootstrapDialog.show({
        type: BootstrapDialog.TYPE_SUCCESS,
        title: title,
        icon: 'fa fa-times',
        message: msg,
        closable: false,
        closeByKeyboard: true,
        buttons: [{label: buttontitle,action: function(dialogRef){dialogRef.close();}}]
    });
}

function ConfirmMessage(title,msg,buttontitle,cb) 
{
    BootstrapDialog.confirm({
        title: '<h4><span class="fa fa-exclamation-circle" style="font-size:32px;color:red; vertical-align: middle;padding-right:5px;"></span>'+title+"</h4>",
        message: msg,
        type: BootstrapDialog.TYPE_DEFAULT,
        closable: true, 
        draggable: true, // <-- Default value is false
        btnCancelLabel: buttontitle[0],
        btnOKLabel: buttontitle[1],
        btnOKClass: 'btn-danger',
        callback: function(result) { cb(result) }
    });
}

function ConfirmMessageArg(title,msg,buttontitle,cb,arg) 
{
    BootstrapDialog.confirm({
        title: '<h4><span class="fa fa-exclamation-circle" style="font-size:32px;color:red; vertical-align: middle;padding-right:5px;"></span>'+title+"</h4>",
        message: msg,
        type: BootstrapDialog.TYPE_DEFAULT,
        closable: true, 
        draggable: true, // <-- Default value is false
        btnCancelLabel: buttontitle[0],
        btnOKLabel: buttontitle[1],
        btnOKClass: 'btn-danger',
        callback: function(result) { cb(result,arg) }
    });
}

function ConfirmDelete(api,par,cb) 
{
    BootstrapDialog.show({
        type: BootstrapDialog.TYPE_DEFAULT,
        title: '<h4><span class="fa fa-exclamation-circle" style="font-size:32px;color:red; vertical-align: middle;padding-right:5px;"></span>ყურადღება, ჩანაწერის წაშლა</h4>',
        message: 'დარწმუნებული ხართ?',
        buttons: [
            {
                label: 'არა',
                action: function(dialogItself){dialogItself.close();}
            }, 
            {
                label: 'დიახ',
                icon: 'glyphicon glyphicon-ban-trash',
                cssClass: 'btn-danger',
                action: function(dialogItself){
                    sendRequest(api,par,cb);
                    dialogItself.close();
                }
            }]
        });
}


function printReport(name, id){
    BootstrapDialog.show({
        title: 'დაელოდეთ, მიმდინარეობს მონაცემთა დამუშავება...',
        size: BootstrapDialog.SIZE_NORMAL,
        resizable: false,
        modal: true,
        draggable: false,
        closeOnEscape: false,
        message: function(dialog){
            var $message = $('<div style="text-align: center;"><img src="img/wait30trans.gif" alt=""/></div>');
            $.post("content/getreport.jsp",{ name: name, id: id },function(data){
                if(data.result == 0)    alert(data.error);
                else {
                    var fname = data.filename;
                    window.open("readfile?name="+fname);
                }
                dialog.close();
            },"json");
            return $message;
        },
        buttons: [{
        id: 'btn-cancel',
        icon: 'fa fa-times',
        label: ' შეწყვეტა',
        cssClass: 'btn-danger', 
        autospin: false,
        action: function(dialogRef){
            dialogRef.close();
        }
        }]
    });
}

function printReportFname(name, id, fn){
    BootstrapDialog.show({
        title: 'დაელოდეთ, მიმდინარეობს მონაცემთა დამუშავება...',
        size: BootstrapDialog.SIZE_NORMAL,
        resizable: false,
        modal: true,
        draggable: false,
        closeOnEscape: false,
        message: function(dialog){
            var $message = $('<div style="text-align: center;"><img src="img/wait30trans.gif" alt=""/></div>');
            $.post("content/getreport.jsp",{ name: name, id: id },function(data){
                if(data.result == 0)    alert(data.error);
                else {
                    var fname = data.filename;
                    window.open("readfile?name="+fname+"&name1="+fn);
                }
                dialog.close();
            },"json");
            return $message;
        },
        buttons: [{
        id: 'btn-cancel',
        icon: 'fa fa-times',
        label: ' შეწყვეტა',
        cssClass: 'btn-danger', 
        autospin: false,
        action: function(dialogRef){
            dialogRef.close();
        }
        }]
    });
}


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