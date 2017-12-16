/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function  showLoader(){ $(".page-footer.loader").fadeIn();}
function  hideLoader(){ $(".page-footer.loader").fadeOut();}


function addObject2(frm) {

    showLoader();

    $.ajax({ 
        url : "post/addobjects.jsp",
        method: "post",
        data: frm.serialise(),
        dataType: "json"
        })
    .done(function() { alert( "success" );})
    .fail(function() {hideLoader(); alert( "1" );  })
    .always(function() {hideLoader(); alert( "complete" );  });
 
}

function addObject(frm) {
    showLoader();
    var form = $("#"+frm)[0];
    var data = new FormData(form);
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "api/addobjects.jsp",
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        dataType: "json"
    }).done(function(rs) { 
        alert( "success" );
    }).fail(function() {
        hideLoader(); alert( "1" );  
    }).always(function() {
        hideLoader(); alert( "complete" );  
    });
}