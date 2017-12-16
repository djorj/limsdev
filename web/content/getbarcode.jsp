<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    String barheight = request.getParameter("barheight");
    String height = request.getParameter("height");
    String width = request.getParameter("width");
    String fontsize = request.getParameter("fontsize");
    String units = request.getParameter("units");
    String msg = request.getParameter("msg");
    String lmsg = request.getParameter("lmsg");
    String rmsg = request.getParameter("rmsg");
    String url = "getbcode?notxt=false&barheight="+barheight+"&height="+height+"&width="+width+"&fontsize="+fontsize+"&mm=";
    if(units.equalsIgnoreCase("mm")) url += "true";
    else                             url += "false";
    url += "&lmsg="+lmsg+"&rmsg="+rmsg+"&msg="+msg;
    
    if(request.getParameter("save").equals("1")){
        JSONObject bconf = new JSONObject();
        bconf.put("barheight", barheight);
        bconf.put("height", height);
        bconf.put("width", width);
        bconf.put("fontsize", fontsize);
        bconf.put("units", units);
        ConfBean[] conf = ConfManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" and upper(name) = 'BARCODE'");
        if(conf.length == 0){
            conf = new ConfBean[1];
            conf[0] = ConfManager.getInstance().createConfBean();
            conf[0].setCompanyid(user.getCompanyid());
            conf[0].setName("BARCODE");
        }
        conf[0].setVal(bconf.toString());
        conf[0] = ConfManager.getInstance().save(conf[0]);
    }
    
    res.put("src",url);
    res.put("result",1);
    Manager.getInstance().endTransaction(true);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>
