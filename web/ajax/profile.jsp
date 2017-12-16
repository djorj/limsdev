<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String picture = "documents/pictures/"+user.getPicture();
File pfl = new File(basedir+picture);
if(user.getPicture() == null || user.getPicture().trim().length() == 0 || !pfl.exists())   picture = "img/avatars/"+((user.getGender().equalsIgnoreCase("M")) ? "male":"female")+".png";
String signature = "documents/signatures/"+user.getSignature();
pfl = new File(basedir+"/"+signature);
if(user.getSignature()== null || user.getSignature().trim().length() == 0 || !pfl.exists())   signature = "documents/signatures/signature.png";
PersonelltypeBean ptype = PersonelltypeManager.getInstance().loadByPrimaryKey(user.getPersonelltypeid());
PersonelltypeBean[] ptypes = PersonelltypeManager.getInstance().loadByWhere("order by name");
%>
<div class="small-container">
    <div class="smart-form">
        <fieldset>
            <div class="row">
                <section class="col col-6">
                    <div class="profile-pic">
                        <img id="prof-pic" src="<%=picture%>">
                        <div>
                            <label class="btn btn-primary change-pic">
                                <%=trs.t("პროფილის სურათის შეცვლა")%>
                                <input type="file" id="profile-picture"/>
                            </label>
                            <label onclick="delPic('picture')" class="btn btn-danger change-pic">
                                <i class="fa fa-trash"></i>
                            </label>
                        </div>
                    </div>
                </section>
                <section class="col col-6">
                    <div class="profile-pic">
                        <img id="prof-sig" src="<%=signature%>">
                        <div>
                            <label class="btn btn-primary change-pic">
                                <%=trs.t("ხელმოწერის შეცვლა")%>
                                <input type="file" id="profile-signature"/>
                            </label>
                            <label onclick="delPic('signature')" class="btn btn-danger change-pic">
                                <i class="fa fa-trash"></i>
                            </label>
                        </div>
                    </div>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <div class="input-group">
                        <label class="input"> <i class="icon-prepend fa fa-user"></i>
                            <input type="text" placeholder="<%=trs.t("სახელი")%>" value="<%=trs.t(user.getFname())%>" id='fname'>
                        </label>
                        <div class="input-group-btn">
                            <button class="btn btn-primary" type="button" onclick="setProfile('fname',$('#fname').val())" style="height: 34px;">
                                <i class="fa fa-save"></i>
                            </button>
                        </div>
                    </div>
                </section>
                <section class="col col-6">
                    <div class="input-group">
                        <label class="input"> <i class="icon-prepend fa fa-user"></i>
                            <input type="text" placeholder="<%=trs.t("გვარი")%>" value="<%=trs.t(user.getLname())%>" id='lname'>
                        </label>
                        <div class="input-group-btn">
                            <button class="btn btn-primary" type="button" onclick="setProfile('lname',$('#lname').val())" style="height: 34px;">
                                <i class="fa fa-save"></i>
                            </button>
                        </div>
                    </div>
                </section>
            </div>

            <div class="row">
                <section class="col col-6">
                    <div class="input-group">
                        <label class="input"> <i class="icon-prepend fa fa-envelope-o"></i>
                            <input type="email" placeholder="<%=trs.t("ელ-ფოსტა")%>" value="<%=user.getEmail()%>" id='email'>
                        </label>
                        <div class="input-group-btn">
                            <button class="btn btn-primary" type="button" onclick="setProfile('email',$('#email').val())" style="height: 34px;">
                                <i class="fa fa-save"></i>
                            </button>
                        </div>
                    </div>
                </section>
                <section class="col col-6">
                    <div class="input-group">
                        <label class="input"> <i class="icon-prepend fa fa-phone"></i>
                            <input type="tel" placeholder="<%=trs.t("ტელეფონი")%>" value="<%=user.getPhone()%>" id='phone'>
                        </label>
                        <div class="input-group-btn">
                            <button class="btn btn-primary" type="button" onclick="setProfile('phone',$('#phone').val())" style="height: 34px;">
                                <i class="fa fa-save"></i>
                            </button>
                        </div>
                    </div>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <div class="input-group">
                        <label class="input"> <i class="icon-prepend fa fa-user"></i>
                            <input type="text" placeholder="<%=trs.t("სარეგისტრაციო სახელი")%>" value="<%=user.getLoginid()%>" id='loginid'>
                        </label>
                        <div class="input-group-btn">
                            <button class="btn btn-primary" type="button" onclick="setProfile('loginid',$('#loginid').val())" style="height: 34px;">
                                <i class="fa fa-save"></i>
                            </button>
                        </div>
                    </div>
                </section>
                <section class="col col-6">
                    <label class="select">
                        <select name='personelltypeid' id='personelltypeid' disabled="">
                            <%
                            for(int i=0;i<ptypes.length;i++){
                                String sel = "";
                                if(ptypes[i].getPersonelltypeid().intValue() == ptype.getPersonelltypeid().intValue())
                                    sel = "selected";
                            %>
                            <option value="<%=ptypes[i].getPersonelltypeid()%>" <%=sel%>><%=trs.t(ptypes[i].getName())%></option>
                            <%
                            }
                            %>
                        </select>
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="legend">
                    <legend class="no-padding margin-bottom-10"><%=trs.t("პაროლის შეცვლა")%></legend>
                </section>
                <section class="col col-6">
                    <label class="input"> <i class="icon-prepend fa fa-lock"></i>
                        <input id='pass1' type="password" placeholder="<%=trs.t("ახალი პაროლი")%>" value="" autocomplete="off">
                    </label>
                </section>
                <section class="col col-6">
                    <label class="input"> <i class="icon-prepend fa fa-lock"></i>
                        <input id='pass0' type="password" placeholder="<%=trs.t("ძველი პაროლი")%>" value="" autocomplete="off">
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="input"> <i class="icon-prepend fa fa-lock"></i>
                        <input id='pass2' type="password" placeholder="<%=trs.t("გაიმეორეთ ახალი პაროლი")%>" value="" autocomplete="off">
                    </label>
                </section>
                <section class="col col-6" style="text-align: center;">
                    <button class="btn btn-success" type="button" onclick="setProfile('pass',$('#pass2').val())" style="height: 34px;">
                        <i class="fa fa-save"></i> <%=trs.t("პაროლის შეცვლა")%>
                    </button>
                </section>
            </div>
            <div id="demos">
                <div class="demo">
                    <form>
                        <legend class="no-padding margin-bottom-10"><%=trs.t("განლაგების პარამეტრები")%></legend>
                        <section>
                            <label><input type="checkbox" name="terms" id="smart-fixed-navigation" class="checkbox style-0"><span><%=trs.t("ფიქსირებული მენიუ")%></span></label>
                            <label><input type="checkbox" name="terms" id="smart-fixed-container" class="checkbox style-0"><span><%=trs.t("ეკრანის ცენტრში")%></span></label>
                            <label><input type="checkbox" id="smart-topmenu" class="checkbox style-0"><span><%=trs.t("მენიუ მაღლა")%></span></label>
                            <label><input type="checkbox" id="full-registration" class="checkbox style-0" checked=""><span><%=trs.t("კომპაქტური რეგისტრაციის ფორმა")%></span></label>
                            <span id="smart-bgimages"></span>
                        </section>
                            <h6 class="margin-top-10 semi-bold margin-bottom-5"><%=trs.t("ფერები")%></h6>
                            <section id="smart-styles">
                                <a href="javascript:void(0);" id="smart-style-0" data-skinlogo="img/logo.png" class="btn btn-block btn-xs txt-color-white margin-right-5" style="background-color:#4E463F;">
                                    <i class="fa fa-check fa-fw" id="skin-checked"></i><%=trs.t("ორიგინალი")%>
                                </a>
                                <a href="javascript:void(0);" id="smart-style-1" data-skinlogo="img/logo-white2.png" class="btn btn-block btn-xs txt-color-white" style="background:#3A4558;">
                                    <%=trs.t("მუქი")%>
                                </a>
                                <a href="javascript:void(0);" id="smart-style-2" data-skinlogo="img/logo-white2.png" class="btn btn-xs btn-block txt-color-darken margin-top-5" style="background:#fff;">
                                    <%=trs.t("განათებული")%>
                                </a>
                                <a href="javascript:void(0);" id="smart-style-3" data-skinlogo="img/logo-white2.png" class="btn btn-xs btn-block txt-color-white margin-top-5" style="background:#f78c40">
                                    <%=trs.t("ფერადი")%>
                                </a>
                                <a href="javascript:void(0);" id="smart-style-ncdc" data-skinlogo="img/logo-white2.png" class="btn btn-xs btn-block txt-color-white margin-top-5" style="background:#0084D1">
                                    <%=trs.t("NCDC")%>
                                </a>
                            </section>
                    </form>
                </div>
            </div>
        </fieldset>
    </div>
</div>
<script>
    function setPicture(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $.post("content/setprofile.jsp",{ oper: "picture", id: <%=user.getPersonellid()%>, pic: e.target.result },function(data){
                    if(data.result == 0) {
                        $("#ribbonerror").html(data.error);
                        $("#ribbonerrorol").show();
                    } else {
                        $("#ribbonerrorol").hide();
                        $('#prof-pic').attr('src', e.target.result);
                        $('#userpicture1').attr('src', e.target.result);
                        $('#userpicture2').attr('src', e.target.result);
                    }
                },"json");
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
    
    function setSignature(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $.post("content/setprofile.jsp",{ oper: "signature", id: <%=user.getPersonellid()%>, pic: e.target.result },function(data){
                    if(data.result == 0) {
                        $("#ribbonerror").html(data.error);
                        $("#ribbonerrorol").show();
                    } else {
                        $("#ribbonerrorol").hide();
                        $('#prof-sig').attr('src', e.target.result);
                    }
                },"json");
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
    
    function delPic(oper){
        $.post("content/setprofile.jsp",{ oper: "del"+oper, id: <%=user.getPersonellid()%> },function(data){
            if(data.result == 0) {
                $("#ribbonerror").html(data.error);
                $("#ribbonerrorol").show();
            } else {
                $("#ribbonerrorol").hide();
                if(oper == 'signature')
                    $('#prof-sig').attr('src', data.picture);
                if(oper == 'picture'){
                    $('#prof-pic').attr('src', data.picture);
                    $('#userpicture1').attr('src', data.picture);
                    $('#userpicture2').attr('src', data.picture);
                }
            }
        },"json");
    }
    
    function setProfile(par,val){
        if(par == 'pass'){
            var pass1 = $("#pass1").val();
            var pass2 = $("#pass2").val();
            if(pass1 != pass2){
                $("#ribbonerror").html("<%=trs.t("განმეორებითი ახალი პაროლი არ ედრება")%>");
                $("#ribbonerrorol").show();
                return;
            }
        }
        $.post("content/setprofile.jsp",{ oper: par, id: <%=user.getPersonellid()%>, val:val },function(data){
            if(data.result == 0) {
                $("#ribbonerror").html(data.error);
                $("#ribbonerrorol").show();
            } else {
                $("#ribbonerrorol").hide();
            }
        },"json");
    }

    $("#profile-picture").change(function () {
        setPicture(this);
    });
    
    $("#profile-signature").change(function () {
        setSignature(this);
    });
    
    
    //$("#demos").append('<div class="demo"> <form><legend class="no-padding margin-bottom-10">< %=trs.t("განლაგების პარამეტრები")%></legend><section><label><input type="checkbox" name="terms" id="smart-fixed-navigation" class="checkbox style-0"><span>< %=trs.t("ფიქსირებული მენიუ")%></span></label><label><input type="checkbox" name="terms" id="smart-fixed-container" class="checkbox style-0"><span>< %=trs.t("ეკრანის ცენტრში")%></span></label><label><input type="checkbox" id="smart-topmenu" class="checkbox style-0"><span>< %=trs.t("მენიუ მაღლა")%></span></label> <span id="smart-bgimages"></span></section><h6 class="margin-top-10 semi-bold margin-bottom-5">< %=trs.t("ფერები")%></h6><section id="smart-styles"><a href="javascript:void(0);" id="smart-style-0" data-skinlogo="img/logo.png" class="btn btn-block btn-xs txt-color-white margin-right-5" style="background-color:#4E463F;"><i class="fa fa-check fa-fw" id="skin-checked"></i>< %=trs.t("ორიგინალი")%></a><a href="javascript:void(0);" id="smart-style-1" data-skinlogo="img/logo-white2.png" class="btn btn-block btn-xs txt-color-white" style="background:#3A4558;">< %=trs.t("მუქი")%></a><a href="javascript:void(0);" id="smart-style-2" data-skinlogo="img/logo-white2.png" class="btn btn-xs btn-block txt-color-darken margin-top-5" style="background:#fff;">< %=trs.t("განათებული")%></a><a href="javascript:void(0);" id="smart-style-3" data-skinlogo="img/logo-white2.png" class="btn btn-xs btn-block txt-color-white margin-top-5" style="background:#f78c40">< %=trs.t("ფერადი")%></a></section></form> </div>');
    var smartbgimage = "<h6 class='margin-top-10 semi-bold'><%=trs.t("ფონი")%></h6><img src='img/pattern/graphy-xs.png' data-htmlbg-url='img/pattern/graphy.png' width='22' height='22' class='margin-right-5 bordered cursor-pointer'><img src='img/pattern/tileable_wood_texture-xs.png' width='22' height='22' data-htmlbg-url='img/pattern/tileable_wood_texture.png' class='margin-right-5 bordered cursor-pointer'><img src='img/pattern/sneaker_mesh_fabric-xs.png' width='22' height='22' data-htmlbg-url='img/pattern/sneaker_mesh_fabric.png' class='margin-right-5 bordered cursor-pointer'><img src='img/pattern/nistri-xs.png' data-htmlbg-url='img/pattern/nistri.png' width='22' height='22' class='margin-right-5 bordered cursor-pointer'><img src='img/pattern/paper-xs.png' data-htmlbg-url='img/pattern/paper.png' width='22' height='22' class='bordered cursor-pointer'>";
    $("#smart-bgimages").fadeOut(), 
    $("#demo-setting").click(function () {
        $("#ribbon .demo").toggleClass("activate")
    }), 
    $('input[type="checkbox"]#smart-fixed-navigation').click(function () {
        $(this).is(":checked") ? ($('input[type="checkbox"]#smart-fixed-header').prop("checked", !0), $.root_.addClass("fixed-header"), $.root_.addClass("fixed-navigation"), $('input[type="checkbox"]#smart-fixed-container').prop("checked", !1), $.root_.removeClass("container")) : ($('input[type="checkbox"]#smart-fixed-ribbon').prop("checked", !1), $.root_.removeClass("fixed-navigation"), $.root_.removeClass("fixed-ribbon"))
    }), 
    $('input[type="checkbox"]#smart-rtl').click(function () {
        $(this).is(":checked") ? $.root_.addClass("smart-rtl") : $.root_.removeClass("smart-rtl")
    }), 
    $('input[type="checkbox"]#smart-topmenu').click(function () {
        $(this).is(":checked") ? $.root_.addClass("menu-on-top") : $.root_.removeClass("menu-on-top")
    }), 
    $('input[type="checkbox"]#smart-fixed-container').click(function () {
        $(this).is(":checked") ? ($.root_.addClass("container"), $('input[type="checkbox"]#smart-fixed-ribbon').prop("checked", !1), $.root_.removeClass("fixed-ribbon"), $('input[type="checkbox"]#smart-fixed-navigation').prop("checked", !1), $.root_.removeClass("fixed-navigation"), smartbgimage ? ($("#smart-bgimages").append(smartbgimage).fadeIn(1e3), $("#smart-bgimages img").bind("click", function () {
            var a = $(this), b = $("html");
            bgurl = a.data("htmlbg-url"), b.css("background-image", "url(" + bgurl + ")")
        }), smartbgimage = null) : $("#smart-bgimages").fadeIn(1e3)) : ($.root_.removeClass("container"), $("#smart-bgimages").fadeOut())
    }), 
    $("#smart-styles > a").on("click", function () { var a = $(this);
        $.post("content/setprofile.jsp",{ oper: "skin", id: <%=user.getPersonellid()%>, skin: a.attr("id") },function(data){
                    if(data.result == 0) {
                        $("#ribbonerror").html(data.error);
                        $("#ribbonerrorol").show();
                    } else {
                        $("#ribbonerrorol").hide();
                        var b = $("#logo img");
                        $.root_.removeClassPrefix("smart-style").addClass(a.attr("id")), 
                        b.attr("src", a.data("skinlogo")), 
                        $("#smart-styles > a #skin-checked").remove(), 
                        a.prepend("<i class='fa fa-check fa-fw' id='skin-checked'></i>");
                    }
                },"json");
    });
</script>

