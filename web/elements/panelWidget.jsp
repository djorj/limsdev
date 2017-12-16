<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    long widgetid = (new Date()).getTime();
    String sdata = request.getParameter("data");
    JSONObject data = JSONObject.fromObject(sdata);
    String header = URLDecoder.decode(data.getString("header"),"UTF-8");
    String body = URLDecoder.decode(data.getString("body"),"UTF-8");
    boolean colorbutton = false;
    boolean editbutton = false;
    boolean togglebutton = false;
    boolean deletebutton = false;
    boolean fullscreenbutton = false;
    boolean custombutton = false;
    boolean collapsed = false; 
    boolean sortable = false;
    if(data.containsKey("attributes")){
        JSONObject attributes = data.getJSONObject("attributes");
        if(attributes.containsKey("colorbutton"))  colorbutton = attributes.getBoolean("colorbutton");
        if(attributes.containsKey("editbutton"))  editbutton = attributes.getBoolean("editbutton");
        if(attributes.containsKey("togglebutton"))  togglebutton = attributes.getBoolean("togglebutton");
        if(attributes.containsKey("deletebutton"))  deletebutton = attributes.getBoolean("deletebutton");
        if(attributes.containsKey("fullscreenbutton"))  colorbutton = attributes.getBoolean("fullscreenbutton");
        if(attributes.containsKey("custombutton"))  colorbutton = attributes.getBoolean("custombutton");
        if(attributes.containsKey("collapsed"))  colorbutton = attributes.getBoolean("collapsed");
        if(attributes.containsKey("sortable"))  colorbutton = attributes.getBoolean("sortable");
            
    }
    JSONArray icons = new JSONArray();
    if(data.containsKey("icons"))
        icons = data.getJSONArray("icons");
        
%>
<div class="jarviswidget <%=(sortable) ? "jarviswidget-sortable":""%> <%=(collapsed) ? "jarviswidget-collapsed":""%>" id="wid-id-<%=widgetid%>" 
     data-widget-colorbutton="<%=colorbutton%>" 
     data-widget-editbutton="<%=editbutton%>" 
     data-widget-togglebutton="<%=togglebutton%>" 
     data-widget-deletebutton="<%=deletebutton%>" 
     data-widget-fullscreenbutton="<%=fullscreenbutton%>" 
     data-widget-custombutton="<%=custombutton%>" 
     role="widget" style="position: relative; opacity: 1; left: 0px; top: 0px;">
    <header role="heading">
        <div class="jarviswidget-ctrls" role="menu">
            <%
            for(int i=0;i<icons.size();i++){
                JSONObject icon = icons.getJSONObject(i);
                String title = URLDecoder.decode(icon.getString("title"),"UTF-8");
            %>
            <a href="javascript:void(0);" class="button-icon jarviswidget-<%=icon.getString("name")%>-btn" data-loading-text="&nbsp;&nbsp;<%=trs.t("მიმდინარეობს ჩატვირთვა...")%>&nbsp;" rel="tooltip" title="" data-placement="bottom" data-original-title="<%=title%>">
                <i class="fa fa-<%=icon.getString("name")%>"></i>
            </a> 
            <%}%>
        </div>
        <h2><%=header%></h2>	
    </header>
    <!-- widget div-->
    <div role="content">
        <!-- widget edit box -->
        <div class="jarviswidget-editbox">
        <!-- This area used as dropdown edit box -->
        </div>
        <!-- end widget edit box -->
        <!-- widget content -->
        <div class="widget-body">
            <%=body%>
        </div>
<!-- end widget content -->
    </div>
<!-- end widget div -->
</div>