<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="includes/init.jsp"%>
<%    
    String cookie_name = getServletContext().getInitParameter("cname");
    String cookie_value = getServletContext().getInitParameter("cval");
    String ip = request.getRemoteAddr();
    
    String savedusername = "";
    int savedcompanyid = 0;
    
    boolean all = false;
    Cookie[] cookieList = request.getCookies();
    if (cookieList != null) {
        for (int i = 0; i < cookieList.length; i++) {
            if (cookieList[i].getName() == null || cookieList[i].getValue() == null) {
                continue;
            }
            if (cookieList[i].getName().equals(cookie_name) && cookieList[i].getValue().equals(cookie_value)) {
                all = true;
            } else if (cookieList[i].getName().equals("lims_mysoft_auth")) {
                String[] cv = cookieList[i].getValue().split("_",2);
                if(cv.length == 2){
                    savedusername = cv[1];
                    savedcompanyid = Integer.parseInt(cv[0]);
                }
                break;
            }
        }
    }
    
    
    boolean allowed = true;
    if (ip.indexOf("192.168.") == 0 || ip.indexOf("127.0.0.1") == 0) {
        allowed = true;
    }
    if (!allowed) allowed = all;
    

    String errlogin = "";
    
    if (request.getParameter("submit_login") != null) {
        String pass = request.getParameter("password");
        String loginid = request.getParameter("loginid");
        int companyid = Integer.parseInt(request.getParameter("companyid"));
        String remember = request.getParameter("remember");
        try {
            if(companyid == 0)
                throw new Exception(trs.t("აირჩიეთ ორგანიზაცია"));
            if(loginid.trim().length() == 0)
                throw new Exception(trs.t("შეიყვანეთ სარეგისტრაციო სახელი"));
            if(pass.trim().length() == 0)
                throw new Exception(trs.t("შეიყვანეთ პაროლი"));
            /*
            ConfBean[] conf = ConfManager.getInstance().loadByWhere("where name = 'AUTHTYPE' and companyid = "+companyid);
            
            if(conf.length > 0){
                com.mysoft.serviceclient.adclient auser = new com.mysoft.serviceclient.adclient();
                auser.setBaseurl(conf[0].getVal());
                conf = ConfManager.getInstance().loadByWhere("where name = 'AUTHID' and companyid = "+companyid);
                auser.setLimsid(conf[0].getVal());
                try{
                    if(auser.login(loginid.toLowerCase(), pass)){
                        JSONObject props = auser.getuserdata();
                        PersonellBean[] tuser = PersonellManager.getInstance().loadByWhere("where upper(loginid) = '" + loginid.toUpperCase().replaceAll("'", "''") + "'");
                        if(tuser.length == 0)   {
                            tuser = new PersonellBean[1];
                            tuser[0] = PersonellManager.getInstance().createPersonellBean();
                        }
                        tuser[0].setAddress(props.getString("Address"));
                        tuser[0].setEmail(props.getString("Email"));
                        tuser[0].setFname(props.getString("FirstName"));
                        tuser[0].setLname(props.getString("LastName"));
                        tuser[0].setLoginid(props.getString("LoginName"));
                        tuser[0].setPassword(pass);
                        tuser[0].setPersonelltypeid(2);
                        tuser[0].setInstitutionid(0);
                        tuser[0].setCompanyid(companyid);
                        tuser[0] = PersonellManager.getInstance().save(tuser[0]);
                        user.copy(tuser[0]);
                    }
                }catch(Exception exl){}
            }
            */
            if(user.getPersonellid() == null){
                //PersonellBean[] tuser = PersonellManager.getInstance().loadByWhere("where deleted = false and upper(loginid) = '" + loginid.toUpperCase().replaceAll("'", "''") + "' and password = '" + pass.replaceAll("'", "''") + "' and companyid = "+companyid);
                PersonellBean tuser = PersonellBean.login(loginid, pass, companyid);
                if (tuser != null) {
                    user.copy(tuser);
                }
            }
            
            if(user.getPersonellid() == null)
                throw new Exception(trs.t("არასწორი სახელი/პაროლი"));
            if(request.getParameter("remember") != null){
                Cookie mycookie = new Cookie(cookie_name,cookie_value);
                mycookie.setMaxAge(60*60*24*3650);
                response.addCookie(mycookie);
                mycookie = new Cookie("lims_mysoft_auth",user.getCompanyid()+"_"+user.getLoginid());
                mycookie.setMaxAge(60*60*24*3650);
                response.addCookie(mycookie);
            } else {
                Cookie mycookie = new Cookie("lims_mysoft_auth",user.getCompanyid()+"_"+user.getLoginid());
                mycookie.setMaxAge(0);
                mycookie.setPath("/");
                response.addCookie(mycookie);
            }
        } catch (Exception ign) {
            ign.printStackTrace();
            errlogin = ign.getMessage();
        }
    } else if (request.getParameter("logout") != null) {
        PersonellBean tuser = PersonellManager.getInstance().createPersonellBean();
        user.copy(tuser);
    }
    
    if (user != null && user.getPersonellid() != null && user.getPersonellid().intValue() > 0) {
        response.sendRedirect("main.jsp");
        return;
    }
    
CompanyBean[] companies = CompanyManager.getInstance().loadByWhere("order by name");
%>
<jsp:include page="includes/header.jsp"></jsp:include>
<%if(errlogin.trim().length() > 0){%>
<script>
    jQuery().ready(function (){
        $("#loginerrortag").show();
        setTimeout(function(){
            $("#loginerrortag").hide();
        },500);
    }
</script>
<%}%>
    <body class="animated fadeInDown">
        <header id="header">
            <div id="logo-group">
                <span id="logo"> <img src="img/logo.png" alt="MySoft"> </span>
            </div>
        </header>
        <div id="main" role="main" style="margin-left: 0;">
            <div id="content" class="container">
                <div class="row text-center">
                    <h1 class="txt-color-red login-header-big login-title"><%=trs.t("ლაბორატორიის მართვის საინფორმაციო სისტემა (LIMS)")%></h1>
                    <div class="login-form">
                        <div class="well no-padding">
                            <form action="index.jsp" id="login-form" class="smart-form client-form" method="post">
                                <header>
                                    <%=trs.t("რეგისტრაცია")%>
                                    <ul class="header-dropdown-list">
					<li>
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-top: 0;"> <img src="img/blank.gif" class="flag flag-<%=trs.getFlag()%>" alt="<%=trs.getName()%>"> <span> <%=trs.getCode()%></span> <i class="fa fa-angle-down"></i> </a>
						<ul class="dropdown-menu pull-right">
                                                    <%for(int i=0;i<langs.length;i++){
                                                        String sel = "";
                                                        if(langs[i].getLangid().intValue() == trs.getLangid())
                                                            sel = "active";
                                                    %>
							<li class="<%=sel%>">
                                                            <a href="index.jsp?langid=<%=langs[i].getLangid()%>"><img src="img/blank.gif" class="flag flag-<%=langs[i].getFlag()%>" alt="<%=langs[i].getName()%>"> <%=langs[i].getName()%></a>
							</li>
                                                    <%}%>
						</ul>
					</li>
                                    </ul>
                                </header>
                                <fieldset>
                                    <%if(errlogin.trim().length() > 0){%>
                                    <section>
                                        <div id='loginerrortag'>
                                            <div class="alert alert-danger fade in">
                                                <button class="close" data-dismiss="alert"> × </button>
                                                <i class="fa-fw fa fa-times"></i>
                                                <strong><%=trs.t("შეცდომა!")%></strong> 
                                                <span id="modalproducterrorcontext"><%=errlogin%></span>
                                            </div>
                                        </div>
                                    </section>
                                    <%}%>
                                    <section>
                                        <label class="label"><%=trs.t("სარეგისტრაციო სახელი")%></label>
                                        <label class="input"> <i class="icon-append fa fa-user"></i>
                                            <input type="text" name="loginid" value="<%=savedusername%>">
                                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("შეიყვანეთ თქვენი სარეგისტრაციო სახელი")%></b></label>
                                    </section>
                                    <section>
                                        <label class="label"><%=trs.t("პაროლი")%></label>
                                        <label class="input"> <i class="icon-append fa fa-lock"></i>
                                            <input type="password" name="password" maxlength="255">
                                            <b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> <%=trs.t("შეიყვანეთ პაროლი")%></b> </label>
                                    </section>
                                    <section>
                                        <label class="label"><%=trs.t("ორგანიზაცია")%></label>
                                        <label class="input"> <i class="icon-append fa fa-institution"></i>
                                            <label class="select">
                                                <select name="companyid" class="dropdown">
                                                    <option value="0"><%=trs.t("-- აირჩიეთ --")%></option>
                                                    <%for(int i=0;i<companies.length;i++){
                                                        String sel = "";
                                                        if(savedcompanyid == companies[i].getCompanyid().intValue())
                                                            sel = "selected";
                                                        //if(request.getParameter("companyid") != null && Integer.parseInt(request.getParameter("companyid")) == companies[i].getCompanyid().intValue())
                                                        //    sel = "selected";
                                                    %>
                                                    <option value="<%=companies[i].getCompanyid()%>" <%=sel%>><%=trs.t(companies[i].getName())%></option>
                                                    <%}%>
                                                </select><i></i>
                                            </label>
                                            <b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> <%=trs.t("აირჩიეთ ორგანიზაცია")%></b> </label>
                                    </section>
                                    <section>
                                        <label class="checkbox">
                                            <input type="checkbox" name="remember" <%=(savedcompanyid > 0) ? "checked=\"\"":""%>>
                                            <i></i><%=trs.t("დამიმახსოვრე")%></label>
                                    </section>
                                </fieldset>
                                <footer>
                                    <button type="submit" name="submit_login" class="btn btn-primary"><%=trs.t("რეგისტრაცია")%></button>
                                </footer>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <jsp:include page="includes/footer.jsp"></jsp:include>
