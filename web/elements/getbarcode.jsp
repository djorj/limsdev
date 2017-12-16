<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/includes/init.jsp" %>
<%
    String w = "400";
    String h = "250";
    String msg = request.getParameter("code");
    String cmsg = request.getParameter("num");
    String all = request.getParameter("all");
    if(request.getParameter("w") != null)   w = request.getParameter("w");
    if(request.getParameter("h") != null)   h = request.getParameter("h");
    
    JSONObject obj = getFromFile(basedir + "json/barcodes.json");
    double barheight = obj.getDouble("barheight");
    double width = obj.getDouble("width");
    double height = obj.getDouble("height");
    int fontsize = obj.getInt("fontsize");
    String units = obj.getString("units");
    ConfBean[] conf = ConfManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" and upper(name) = 'BARCODE'");
    if(conf.length > 0){
        JSONObject obj1 = JSONObject.fromObject(conf[0].getVal());
        try{
            barheight = obj1.getDouble("barheight");
            width = obj1.getDouble("width");
            height = obj1.getDouble("height");
            fontsize = obj1.getInt("fontsize");
            units = obj1.getString("units");
        }catch(Exception ign){
            barheight = obj.getDouble("barheight");
            width = obj.getDouble("width");
            height = obj.getDouble("height");
            fontsize = obj.getInt("fontsize");
            units = obj.getString("units");
        }
    }
    String url = "?notxt=false&barheight="+barheight+"&height="+height+"&width="+width+"&fontsize="+fontsize+"&mm=";
    if(units.equalsIgnoreCase("mm")) url += "true";
    else                             url += "false";
    if(all == null){
        url = "getbcode"+url;
        if(cmsg != null && cmsg.length() > 0)   url += "&cmsg="+cmsg;
        url += "&msg="+msg;
    } else {
        url = "getmbcode"+url;
        String sql = (String)session.getAttribute("CONTRACTSAMPLEITEMS_BOX_SQL");
        Connection c = Manager.getInstance().getConnection();
        ResultSet rs = c.createStatement().executeQuery(sql);
        int n=0;
        JSONArray ar = new JSONArray();
        while(rs.next())
        {
            JSONObject o = new JSONObject();
            o.put("scenter",(rs.getString(2)!=null ? rs.getString(2) : ""));
            o.put("msg",rs.getInt(1));
            ar.add(o);
        }
        rs.close();
        Manager.getInstance().releaseConnection(c);
        //url += "&data="+ar.toString();
        session.setAttribute("MASSIVEBCODEPRINT", (String)ar.toString());
    }
%>
<iframe style="text-align: center; border: 0;" width="<%=w%>" height="<%=h%>" id="barcodeforprint" src="<%=url%>"></iframe>
