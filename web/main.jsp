<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="includes/init.jsp"%>
<%    
    if (user == null || user.getPersonellid() == null || user.getPersonellid().intValue() == 0) {
        response.sendRedirect("index.jsp");
        return;
    }
    MenuBean[] menu = MenuManager.getInstance().loadByWhere("where companyid = " + user.getCompanyid() + " and menuid in (select m.parentid from plevel p, menu m where m.companyid = " + user.getCompanyid() + " and p.read = true and p.menuid = m.menuid and p.personelltypeid = " + user.getPersonelltypeid() + ") and parentid is null order by ord");
    System.out.println("select * from menu where companyid = " + user.getCompanyid() + " and menuid in (select m.parentid from plevel p, menu m where m.companyid = " + user.getCompanyid() + " and p.read = true and p.menuid = m.menuid and p.personelltypeid = " + user.getPersonelltypeid() + ") and parentid is null order by ord");
    String logo = "img/logo.png";
    String orgname = "MySoft";
    String styleclass = "";
    CompanyBean company = CompanyManager.getInstance().loadByPrimaryKey(user.getCompanyid());
    if (company.getLogo() != null && company.getLogo().trim().length() > 0) {
        logo = "img/logos/" + company.getLogo();
    }
    if (company.getName() != null && company.getName().trim().length() > 0) {
        orgname = trs.t(company.getName());
    }
    String avatar = "female.png";
    if (user.getGender().equalsIgnoreCase("M")) {
        avatar = "male.png";
    }
    if (user.getPicture() != null && user.getPicture().trim().length() > 0) {
        File flpic = new File(basedir + "documents/pictures/" + user.getPicture().trim());
        if (flpic.exists()) {
            avatar = user.getPicture().trim();
        }
    }
    if (user.getCompanyid().intValue() == 1) {
        styleclass = "ncdc";
    } else {
        styleclass = "";
    }
    
    String skin = "smart-style-0";
    if(user.getOptions() != null){
        JSONObject options = JSONObject.fromObject(user.getOptions());
        skin = options.getString("skin");
    }
%>

<jsp:include page="includes/header.jsp"></jsp:include>
<body class="<%=styleclass%>">
    <header id="header">
        <div id="logo-group">
            <span id="logo"> <img src="<%=logo%>" alt="<%=orgname%>"> </span>
        </div>
        <div class="pull-right">

            <ul id="mobile-profile-img" class="header-dropdown-list hidden-xs padding-5">
                <li class="">
                    <a href="#" class="dropdown-toggle no-margin userdropdown" data-toggle="dropdown" aria-expanded="false"> 
                        <img src="documents/pictures/<%=avatar%>" id='userpicture1' class="online">  
                    </a>
                    <ul class="dropdown-menu pull-right">
                        <li>
                            <a href="#ajax/messages.jsp" class="padding-10 padding-top-0 padding-bottom-0"><i class="fa fa-envelope"></i> <%=trs.t("შეტყობინება")%></a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#ajax/profile.jsp" class="padding-10 padding-top-0 padding-bottom-0"> <i class="fa fa-user"></i> <%=trs.t("პროფილი")%></a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="index.jsp?logout=yes" class="padding-10 padding-top-0 padding-bottom-0"> <i class="fa fa-sign-out"></i> <%=trs.t("გასვლა")%></a>
                        </li>
                    </ul>
                </li>
            </ul>
            <div id="hide-menu" class="btn-header pull-right">
                <span> <a href="javascript:void(0);" data-action="toggleMenu" title="<%=trs.t("მენიუს ჩაკეცვა")%>"><i class="fa fa-reorder"></i></a> </span>
            </div>
            <div id="logout" class="btn-header transparent pull-right">
                <span> <a href="index.jsp?logout=yes" title="<%=trs.t("გამოსვლა")%>"><i class="fa fa-sign-out"></i></a> </span>
            </div>
            <div id="fullscreen" class="btn-header transparent pull-right">
                <span> <a href="javascript:void(0);" data-action="launchFullscreen" title="<%=trs.t("მთლიანი ეკრანი")%>"><i class="fa fa-arrows-alt"></i></a> </span>
            </div>
            <ul class="header-dropdown-list hidden-xs">

                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <img src="img/blank.gif" class="flag flag-<%=trs.getFlag()%>" alt="<%=trs.getName()%>"> <span> <%=trs.getCode()%></span> <i class="fa fa-angle-down"></i> </a>
                    <ul class="dropdown-menu pull-right">
                        <%for (int i = 0; i < langs.length; i++) {
                                String sel = "";
                                if (langs[i].getLangid().intValue() == trs.getLangid()) {
                                    sel = "active";
                                }
                        %>
                        <li class="<%=sel%>">
                            <a href="index.jsp?langid=<%=langs[i].getLangid()%>"><img src="img/blank.gif" class="flag flag-<%=langs[i].getFlag()%>" alt="<%=langs[i].getName()%>"> <%=langs[i].getName()%></a>
                        </li>
                        <%}%>
                    </ul>
                </li>
            </ul>
        </div>
    </header>
    <aside id="left-panel">
        <div class="login-info">
            <span> <!-- User image size is adjusted inside CSS, it should stay as is --> 

                <a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
                    <span class="label pull-right bg-color-red cust" id="newmessages"></span>
                    <img src="documents/pictures/<%=avatar%>" id='userpicture2' alt="me" class="online" /> 
                    <span><%=trs.t(user.getFname())%> <%=trs.t(user.getLname())%></span>
                    <i class="fa fa-angle-down"></i>
                </a> 

            </span>
        </div>
        <!-- end user info -->

        <!-- NAVIGATION : This navigation is also responsive

        To make this navigation dynamic please make sure to link the node
        (the reference to the nav > ul) after page load. Or the navigation
        will not initialize.
        -->
        <nav>
            <!-- 
            NOTE: Notice the gaps after each icon usage <i></i>..
            Please note that these links work a bit different than
            traditional href="" links. See documentation for details.
            -->

            <ul>
                <%
                    for (int i = 0; i < menu.length; i++) {
                        String href = "#";
                        if (menu[i].getFile().length() > 0) {
                            href = "ajax/" + menu[i].getFile() + ".jsp";
                            File flmenu = new File(session.getServletContext().getRealPath("/") + "/" + href);
                            if (!flmenu.exists()) {
                                href = "ajax/construction.jsp";
                            }
                        }
                        MenuBean[] smenu = MenuManager.getInstance().loadByWhere("where companyid = " + user.getCompanyid() + " and menuid in (select m.menuid from plevel p, menu m where m.companyid = " + user.getCompanyid() + " and p.menuid = m.menuid and p.read = true and p.personelltypeid = " + user.getPersonelltypeid() + ") and parentid = " + menu[i].getMenuid() + " order by ord");
                %>
                <li <%=(i == 0) ? "class=\"\"" : ""%>>
                    <a href="<%=href%>" title="<%=trs.t(menu[i].getName())%>"><i class="fa fa-lg fa-fw <%=menu[i].getIcon()%>"></i> <span class="menu-item-parent"><%=trs.t(menu[i].getName())%></span></a>
                        <%
                            for (int j = 0; j < smenu.length; j++) {
                                if (j == 0) {%><ul><%}
                                    String shref = "ajax/" + smenu[j].getFile() + ".jsp";
                                    File sflmenu = new File(session.getServletContext().getRealPath("/") + "/" + shref);
                                    if (!sflmenu.exists()) {
                                        shref = "ajax/construction.jsp?sessionid=" + String.valueOf(new Date().getTime());
                                    }
                        %>
                        <li>
                            <a href="<%=shref%>"><%=trs.t(smenu[j].getName())%></a>
                        </li>
                        <%
                            if (j == smenu.length - 1) {%></ul><%}
                            }
                        %>
                </li>
                <%}%>
            </ul>
        </nav>
        <span class="minifyme" data-action="minifyMenu"> <i class="fa fa-arrow-circle-left hit"></i> </span>

    </aside>
    <!-- END NAVIGATION -->

    <!-- #MAIN PANEL -->
    <div id="main" role="main">

        <!-- RIBBON -->
        <div id="ribbon">

            <!-- breadcrumb -->
            <ol class="breadcrumb">
                <!-- This is auto generated -->
            </ol>
            <ol style="float: right; margin-right: 5px; display: none;" id='ribbonerrorol'>
                <div class="alert alert-danger fade in">
                    <button class="close" data-dismiss="alert">
                        ×
                    </button>
                    <i class="fa-fw fa fa-times"></i>
                    <strong><%=trs.t("Error!")%></strong> <span id='ribbonerror'></span>
                </div>
            </ol>
            <!-- end breadcrumb -->

            <!-- You can also add more buttons to the
            ribbon for further usability

            Example below:

            <span class="ribbon-button-alignment pull-right" style="margin-right:25px">
                    <span id="search" class="btn btn-ribbon hidden-xs" data-title="search"><i class="fa fa-grid"></i> Change Grid</span>
                    <span id="add" class="btn btn-ribbon hidden-xs" data-title="add"><i class="fa fa-plus"></i> Add</span>
                    <span id="search" class="btn btn-ribbon" data-title="search"><i class="fa fa-search"></i> <span class="hidden-mobile">Search</span></span>
            </span> -->

        </div>
        <!-- END RIBBON -->

        <!-- #MAIN CONTENT -->
        <div id="content">

        </div>

        <!-- END #MAIN CONTENT -->

    </div>
    <!-- END #MAIN PANEL -->

    <!-- #PAGE FOOTER -->
    <div class="page-footer">
        <div class="row">
            <div class="col-xs-12 col-sm-6">
                <span class="txt-color-white">MySoft &reg 2017</span>
            </div>
        </div>
        <!-- end row -->
    </div>
    <div class="page-footer loader">
<!--        <h2>< %=trs.t("თქვენ არ გაქვთ წვდომა ინტერნეტთან")%></h2>
        <div><button class="btn btn-danger">< %=trs.t("განახლება")%></button></div>-->
        <img src="img/ajax-loader.gif" alt=""/>
    </div>
    <!-- END FOOTER -->

    <!-- #SHORTCUT AREA : With large tiles (activated via clicking user name tag)
             Note: These tiles are completely responsive, you can add as many as you like -->
    <div id="shortcut">
        <ul>
            <li>
                <a href="#ajax/messages.jsp" class="jarvismetro-tile big-cubes bg-color-blue"> <span class="iconbox"> <i class="fa fa-envelope fa-4x"></i> <span id="newmessages1"><%=trs.t("შეტყობინება")%> </span> </span> </a>
            </li>
            <li>
                <a href="#ajax/profile.jsp" class="jarvismetro-tile big-cubes bg-color-darken"> <span class="iconbox"> <i class="fa fa-user fa-4x"></i> <span><%=trs.t("პროფილი")%> </span> </span> </a>
            </li>
        </ul>
    </div>
    <!-- END SHORTCUT AREA -->
    <div class="modal fade page-footer" id="printModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title"><%=trs.t("ბეჭდვა")%></h4>
                </div>
                <div class="modal-body" id="frmprintmodal">
                    <object data="documents/hhhh.pdf" type="application/pdf" width="100%"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
                </div>
                <footer class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <%=trs.t("დახურვა")%>
                    </button>
                </footer>
            </div>
        </div>
    </div>


    <!--================================================== -->

    <script src="js/libs/jquery-2.0.2.min.js"></script>

    <script src="js/libs/jquery-ui-1.10.3.min.js"></script>

    <!-- IMPORTANT: APP CONFIG -->
    <script src="js/app.config.js"></script>

    <!-- JS TOUCH : include this plugin for mobile drag / drop touch events-->
    <script src="js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script> 

    <!-- BOOTSTRAP JS -->
    <script src="js/bootstrap/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-3-typeahead/4.0.1/bootstrap3-typeahead.min.js"></script>

    <!-- CUSTOM NOTIFICATION -->
    <script src="js/notification/SmartNotification.min.js"></script>

    <!-- JARVIS WIDGETS -->
    <script src="js/smartwidgets/jarvis.widget.min.js"></script>

    <!-- EASY PIE CHARTS -->
    <script src="js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>

    <!-- SPARKLINES -->
    <script src="js/plugin/sparkline/jquery.sparkline.min.js"></script>

    <!-- JQUERY VALIDATE -->
    <script src="js/plugin/jquery-validate/jquery.validate.min.js"></script>

    <!-- JQUERY MASKED INPUT -->
    <script src="js/plugin/masked-input/jquery.maskedinput.min.js"></script>

    <!-- JQUERY SELECT2 INPUT -->
    <script src="js/plugin/select2/select2.min.js"></script>

    <!-- JQUERY UI + Bootstrap Slider -->
    <script src="js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>

    <!-- browser msie issue fix -->
    <script src="js/plugin/msie-fix/jquery.mb.browser.min.js"></script>

    <!-- FastClick: For mobile devices: you can disable this in app.js -->
    <script src="js/plugin/fastclick/fastclick.min.js"></script>

    <script src="js/jquery.ui.position.min.js" type="text/javascript"></script>
    <script src="js/jquery.contextMenu.min.js" type="text/javascript"></script>



    <script src="js/moment.js" type="text/javascript"></script>
    <script src="js/bootstrap-datetimepicker.js" type="text/javascript"></script>
    <script src="js/daterangepicker.js" type="text/javascript"></script>

    <!-- MAIN APP JS FILE -->
    <script src="js/app.min.js"></script>
    <script>
//        setTimeout(function () {
//            $.bigBox({
//                title: "Big Information box",
//                content: "This message will dissapear in 10 seconds!",
//                color: "#C46A69",
//                icon: "fa fa-warning shake animated",
//                timeout: 10000
//            });
//        }, 5000);
//        setTimeout(function () {
//            $.bigBox({
//                title: "Big Information box",
//                content: "This message not dissapear!",
//                color: "grey",
//                icon: "fa fa-question shake animated",
//            });
//        }, 10000);

        function checkmessages(){
            $.post("content/getmsg.jsp",{ onlyunread: 1 },function(data){
                if(data.result == 0)    console.log(data.error);
                else {
                    var unread = data.unread;
                    if(unread.length > 0){
                        $("#newmessages").html(unread.length);
                        $("#newmessages1").html('<%=trs.t("შეტყობინება")%> <span class="label pull-right bg-color-red">'+unread.length+'</span>');
                        var s = "";
                        for(var i=0;i<unread.length;i++){
                            s += "<a href='main.jsp#ajax/messages.jsp'>"+unread[i].msgdate+"</a><br><a href='main.jsp#ajax/messages.jsp'>"+unread[i].content+"</a><br>";
                        }
                        $("#divbigBoxes").html("");
                        $("#divMiniIcons").html("");
                        if($(location).attr('href').indexOf("ajax/messages.jsp") < 0){
                            $.bigBox({
                                title: "<%=trs.t("თქვენ გაქვთ")%> "+unread.length+" <%=trs.t("წაუკითხავი შეტყობინება")%>",
                                content: s,
                                color: "#C46A69",
                                icon: "fa fa-warning shake animated",
                                timeout: <%=String.valueOf(msgtimeout-1000)%>
                            });
                        }
                    } else {
                        $("#newmessages").html("");
                        $("#newmessages1").html("<%=trs.t("შეტყობინება")%>");
                        $("#divbigBoxes").html("");
                        $("#divMiniIcons").html("");
                    }
                }
            },"json");
        }

        $(document).ready(function () {
            $(".page-footer.loader").fadeIn();
            setTimeout(function () {
                $(".page-footer.loader").fadeOut();
            }, 1000);
            $.root_.removeClassPrefix("smart-style").addClass("<%=skin%>");
            checkmessages();
            setInterval(function(){
                checkmessages();
            },<%=msgtimeout%>);
        });
        $(document).on("keyup", ".req", function () {
            if ($(this).val() != "") {
                $(this).addClass("complete");
            } else {
                $(this).removeClass("complete");
            }
        });
        $(document).on("change", ".req", function () {
            if ($(this).val() != "0") {
                $(this).addClass("complete");
            } else {
                $(this).removeClass("complete");
            }
        });
        $(document).on("click", ".showcode", function () {
            $("#printModal").modal();
            var id =$(this).attr("data-itemid");
            $("#frmprintmodal").load("api/getbarcode.jsp?id="+id);
        });
        
        $(document).on("focus", ".smart-form .select select", function(){
            $(this).parent().find(".tooltip").addClass("active");
        });
        $(document).on("blur", ".smart-form .select select", function(){
            $(this).parent().find(".tooltip").removeClass("active");
        });
        $(document).on("focus", ".smart-form .select .select2-input", function(){
            $(this).parent().parent().parent().parent().find(".tooltip").addClass("active");
        });
        $(document).on("blur", ".smart-form .select .select2-input", function(){
            $(this).parent().parent().parent().parent().find(".tooltip").removeClass("active");
        });
        $(document).on("focus", ".smart-form .input .bootstrap-tagsinput input", function(){
            $(this).parent().parent().find(".tooltip").addClass("active");
        });
        $(document).on("blur", ".smart-form .input .bootstrap-tagsinput input", function(){
            $(this).parent().parent().find(".tooltip").removeClass("active");
        });
        $(document).on("focus", ".smart-form .input input.datetime", function(){
            $(this).parent().find(".tooltip").addClass("active");
        });
        $(document).on("blur", ".smart-form .input input.datetime", function(){
            $(this).parent().find(".tooltip").removeClass("active");
        });
    </script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js" type="text/javascript"></script>
    <script src="js/myjs.js" type="text/javascript"></script>

</body>

</html>