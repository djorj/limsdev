<%-- 
    Document   : service
    Created on : Nov 22, 2014, 3:24:54 PM
    Author     : Gocha Tortladze
--%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
﻿<script src="js/plugin/filetree/jquery.easing.js" type="text/javascript"></script>
<script src="js/plugin/filetree/jqueryFileTree.js" type="text/javascript"></script>
<link href="js/plugin/filetree/jqueryFileTree.css" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css">
                        .example {
                                float: left;
                                margin: 0px;
                        }

                        .demo {
                                width: 200px;
                                height: 500px;
                                border-top: solid 1px #BBB;
                                border-left: solid 1px #BBB;
                                border-bottom: solid 1px #FFF;
                                border-right: solid 1px #FFF;
                                background: #FFF;
                                overflow: scroll;
                                padding: 5px;
                        }

                </style>
﻿<link rel="stylesheet" type="text/css" href="js/fm/styles/reset.css" />
<link rel="stylesheet" type="text/css" href="js/fm/scripts/jquery.contextmenu/jquery.contextMenu-1.01.css" />
<style type="text/css">
        #loading-wrap {
                position:fixed;
                height:100%;
                width:100%;
                overflow:hidden;
                top:0;
                left:0;
                display:block;
                background: white url(./images/wait30trans.gif) no-repeat center center;
                z-index:999;
        }
</style>

<section class="col col-md-12">
<div id="divquality" class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" style="width: 100%;">
<header style="width: 100%;padding: 0 !important;margin: 0 !important;">
    <h2><span id="currentdir"></span></h2>
</header>
<div class="row" style="box-sizing: border-box;padding:0px;">
    
<div class="col col-sm-2" style="padding: 0 !important;margin: 0 !important;">
    <div class="example" style="width: 100%;">
    <div id="filetree" class="demo"></div>
    </div>
</div>
<div class="col col-sm-10">
    <div class="row" style="width: 100%;">
    <div class="col col-sm-12" style="padding-top: 2px;">
<form id="uploader" method="post">
        <h1></h1>
        <div id="uploadresponse"></div>
        <button id="level-up" name="level-up" type="button" value="LevelUp">&nbsp;</button>
        <button id="home" name="home" type="button" value="Home">&nbsp;</button>
        <input id="mode" name="mode" type="hidden" value="add" />
        <input id="currentpath" name="currentpath" type="hidden" />
        <div id="file-input-container">
                <div id="alt-fileinput">
                        <input id="filepath" name="filepath" type="text" /><button id="browse" name="browse" type="button" value="Browse"></button>
                </div>
                <input  id="newfile" name="newfile" type="file" />
        </div>
        <button id="upload" name="upload" type="submit" value="Upload" class="em"></button>
        <button id="newfolder" name="newfolder" type="button" value="New Folder" class="em"></button>
</form>
    </div>
    </div>
    <div class="row" style="width: 100%; min-height: 420px;max-height: 420px;overflow-y: scroll;">
        <div id="fileinfo" class="col col-sm-12" style="padding-top: 2px;"></div>
    </div>
    </div>
</div>
</div>
</div>
</section>


<script type="text/javascript" src="js/fm/scripts/jquery-browser.js"></script>
<script type="text/javascript" src="js/fm/scripts/jquery.form-3.24.js"></script>
<script type="text/javascript" src="js/fm/scripts/jquery.contextmenu/jquery.contextMenu-1.01.js"></script>
<script type="text/javascript" src="js/fm/scripts/jquery.impromptu-3.2.min.js"></script>
<script type="text/javascript" src="js/fm/scripts/jquery.tablesorter-2.7.2.min.js"></script>
<script type="text/javascript" src="js/fm/scripts/jquery.filetree/jqueryFileTree.js"></script>
<script type="text/javascript" src="js/fm/scripts/filemanager.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css" />
<script src="https://code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.5.0/jquery.contextMenu.min.css" type="text/css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.5.0/jquery.contextMenu.min.js"></script>
<script>
$(function(){
    $.contextMenu({
        selector: '.directory', 
        build: function($trigger, e) {
            return {
                callback: function(key, options) {
                    setMenus(key,$trigger.attr('data-path'));
                },
                items: {
                    "rename": {name: "დასახელების შეცვლა", icon: "edit"},
                    "sep1": "---------",
                    "delete": {name: "წაშლა", icon: "delete"},
                    "sep2": "---------",
                    "quit": {name: "გამოსვლა", icon: function($element, key, item){ return 'context-menu-icon context-menu-icon-quit'; }}
                }
            };
        }
    });
    $.contextMenu({
        selector: '.file', 
        build: function($trigger, e) {
            return {
                callback: function(key, options) {
                    setMenus(key,$trigger.attr('data-path'));
                },
                items: {
                    "download": {name: "ჩამოტვირთვა", icon: "fa-cloud-download"},
                    "sep1": "---------",
                    "rename": {name: "დასახელების შეცვლა", icon: "edit"},
                    "sep2": "---------",
                    "delete": {name: "წაშლა", icon: "delete"},
                    "sep3": "---------",
                    "quit": {name: "გამოსვლა", icon: function($element, key, item){ return 'context-menu-icon context-menu-icon-quit'; }}
                }
            };
        }
    });
});
</script>
